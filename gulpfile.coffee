spawn = require('child_process').spawn

argv  = require('yargs').argv
gulp  = require 'gulp'
gp    = do require "gulp-load-plugins"

streamqueue = require 'streamqueue'
combine     = require 'stream-combiner'
protractor  = require('gulp-protractor').protractor

sources     = require './gulp.sources'

# ==========================
# task options

# distPath    = './dist'
builderPath = '../ee-front/ee-shared'
storePath   = '../ee-store/ee-shared'

htmlminOptions =
  removeComments: true
  removeCommentsFromCDATA: true
  collapseWhitespace: true
  # conservativeCollapse: true # otherwise <i> & text squished
  collapseBooleanAttributes: true
  removeAttributeQuotes: true
  removeRedundantAttributes: true
  caseSensitive: true
  minifyJS: true
  minifyCSS: true

## ==========================
## html tasks

# gulp.task 'html-push', () ->
#   gulp.src './src/store.html'
#     .pipe gp.plumber()
#     .pipe gp.htmlReplace
#       css: 'stylesheets/ee.builder.css'
#       js: sources.storeJs(), { keepBlockTags: true }
#     .pipe gulp.dest './src'

# gulp.task 'html-push', () ->
#   # Builder html
#   # gulp.src './src/builder.html'
#   #   .pipe gp.plumber()
#   #   # Replace localhost tracking code with product tracking code
#   #   .pipe gp.replace /UA-55625421-2/g, 'UA-55625421-1'
#   #   .pipe gp.htmlReplace
#   #     css: 'ee.builder.css'
#   #     js: 'ee.builder.js'
#   #   .pipe gp.htmlmin htmlminOptions
#   #   .pipe gulp.dest distPath
#   # Builder sitemap
#   # gulp.src './src/sitemap.xml'
#   #   .pipe gulp.dest distPath
#   # Store html
#   gulp.src ['./src/store.html']
#     .pipe gp.plumber()
#     .pipe gp.htmlReplace
#       css: 'ee.builder.css'
#       js: 'ee.store.js'
#     .pipe gp.htmlmin htmlminOptions
#     .pipe gulp.dest distPath

# ==========================
# css tasks

# gulp.task 'css-dev', () ->
#   gulp.src './src/stylesheets/ee.builder.less' # ** force to same dir
#     .pipe gp.sourcemaps.init()
#     .pipe gp.less paths: './src/stylesheets/' # @import path
#     # write sourcemap to separate file w/o source content to path relative to dest below
#     .pipe gp.sourcemaps.write './', { includeContent: false, sourceRoot: '../' }
#     .pipe gulp.dest './src/stylesheets'
#
# gulp.task 'css-prod', () ->
#   gulp.src './src/stylesheets/ee.builder.less'
#     # TODO: wait for minifyCss to support sourcemaps
#     .pipe gp.replace "../bower_components/bootstrap/fonts/", "./fonts/"
#     .pipe gp.replace "../bower_components/font-awesome/fonts/", "./fonts/"
#     .pipe gp.less paths: './src/stylesheets/' # @import path
#     .pipe gp.minifyCss cache: true, keepSpecialComments: 0 # remove all
#     .pipe gulp.dest distPath

# ==========================
# js tasks

gulp.task 'js-test', () ->
  gulp.src './src/**/*.coffee' # ** glob forces dest to same subdir
    .pipe gp.replace /@@eeBackUrl/g, 'http://localhost:5555'
    .pipe gp.plumber()
    .pipe gp.sourcemaps.init()
    .pipe gp.coffee()
    .pipe gp.sourcemaps.write './'
    .pipe gulp.dest './src/js'

gulp.task 'js-dev', () ->
  gulp.src './src/**/*.coffee' # ** glob forces dest to same subdir
    .pipe gp.replace /@@eeBackUrl/g, 'http://localhost:5000'
    .pipe gp.plumber()
    .pipe gp.sourcemaps.init()
    .pipe gp.coffee()
    .pipe gp.sourcemaps.write './'
    .pipe gulp.dest './src/js'

gulp.task 'js-prod', () ->
  # inline templates; no need for ngAnnotate
  # TODO separate templates for builder and store
  appTemplates = gulp.src './src/components/ee*.html'
    .pipe gp.htmlmin htmlminOptions
    .pipe gp.angularTemplatecache
      module: 'ee.templates'
      standalone: true
      root: 'components'

  ## Store prod
  storeVendorMin   = gulp.src sources.storeVendorMin
  storeVendorUnmin = gulp.src sources.storeVendorUnmin
  # store modules; replace and annotate
  storeModules = gulp.src sources.storeModules()
    .pipe gp.plumber()
    .pipe gp.replace "# 'ee.templates'", "'ee.templates'" # for store.index.coffee $templateCache
    .pipe gp.replace "'env', 'development'", "'env', 'production'" # TODO use gulp-ng-constant
    .pipe gp.replace "'demoseller' # username", "username" # allows testing at *.localhost
    .pipe gp.replace /@@eeBackUrl/g, 'https://api.eeosk.com'
    .pipe gp.coffee()
    .pipe gp.ngAnnotate()
  # minified and uglify vendorUnmin, templates, and modules
  storeCustomMin = streamqueue objectMode: true, storeVendorUnmin, appTemplates, storeModules
    .pipe gp.uglify()
  # concat: vendorMin before jsMin because vendorMin has angular
  streamqueue objectMode: true, storeVendorMin, storeCustomMin
    .pipe gp.concat 'ee.store.js'
    .pipe gulp.dest distPath

# ==========================
# other tasks
# copy non-compiled files

gulp.task 'copy-html', () ->
  # gulp.src ['./**/*.html'], base: './html'
  #   .pipe gp.plumber()
  #   .pipe gp.changed builderPath
  #   .pipe gulp.dest builderPath
  gulp.src ['./**/*.html'], base: './html'
    .pipe gp.plumber()
    .pipe gp.changed storePath
    .pipe gulp.dest storePath

gulp.task 'copy-js', () ->

gulp.task 'copy-css', () ->

gulp.task 'copy-img', () ->

gulp.task 'copy-fonts', () ->

  gulp.src './src/bower_components/bootstrap/fonts/**/*.*'
    .pipe gp.plumber()
    .pipe gp.changed distPath
    .pipe gulp.dest distPath + '/fonts'

  gulp.src './src/bower_components/font-awesome/fonts/**/*.*'
    .pipe gp.plumber()
    .pipe gp.changed distPath
    .pipe gulp.dest distPath + '/fonts'


# ==========================
# protractors

gulp.task 'protractor-test', () ->
  gulp.src ['./src/e2e/config.coffee', './src/e2e/*.coffee']
    .pipe protractor
      configFile: './protractor.conf.js'
      args: ['--grep', (argv.grep || ''), '--baseUrl', 'http://localhost:3333', '--apiUrl', 'http://localhost:5555']
    .on 'error', (e) -> return

gulp.task 'protractor-prod', () ->
  gulp.src ['./src/e2e/config.coffee', './src/e2e/*.coffee']
    .pipe protractor
      configFile: './protractor.conf.js'
      args: ['--baseUrl', 'http://localhost:3333', '--apiUrl', 'http://localhost:5555']
    .on 'error', (e) -> return

gulp.task 'protractor-live', () ->
  gulp.src ['./src/e2e/config.coffee', './src/e2e/*.coffee']
    .pipe protractor
      configFile: './protractor.conf.js'
      args: ['--grep', (argv.grep || ''), '--baseUrl', 'https://eeosk.com', '--apiUrl', 'https://api.eeosk.com']
    .on 'error', (e) -> return

# ==========================
# servers

gulp.task 'server-dev', () ->
  gulp.src('./src').pipe gp.webserver(
    fallback: 'store.html' # for angular html5mode
    port: 4000
  )

gulp.task 'server-test-store', () ->
  gulp.src('./src').pipe gp.webserver(
    fallback: 'store.html' # for angular html5mode
    port: 4444
  )

gulp.task 'server-prod', () -> spawn 'foreman', ['start'], stdio: 'inherit'

# ==========================
# watchers

gulp.task 'watch-dev', () ->
  gulp.src './src/stylesheets/ee*.less'
    .pipe gp.watch { emit: 'one', name: 'css' }, ['css-dev']
  gulp.src './src/**/*.coffee'
    .pipe gp.watch { emit: 'one', name: 'js' }, ['js-dev']
  gulp.src './src/**/*.html'
    .pipe gp.watch { emit: 'one', name: 'html' }, ['html-dev']

gulp.task 'watch-test', () ->
  gulp.src './src/stylesheets/ee*.less'
    .pipe gp.watch { emit: 'one', name: 'css' }, ['css-dev']
  gulp.src './src/**/*.coffee'
    .pipe gp.watch { emit: 'one', name: 'js' }, ['js-test']
  gulp.src './src/e2e/*e2e*.coffee'
    .pipe gp.watch { emit: 'one', name: 'test' }, ['protractor-test']

# ===========================
# runners

gulp.task 'copy', ['copy-html'], () -> return

gulp.task 'test', ['js-test', 'html-dev', 'server-test', 'watch-test'], () -> return

gulp.task 'dev', ['watch-dev', 'server-dev'], () -> return

# gulp.task 'pre-prod-test', ['css-prod', 'html-prod', 'copy-prod', 'js-prod', 'server-prod'], () ->
#   gulp.src './dist/ee.store.js'
#     .pipe gp.replace /https:\/\/api\.eeosk\.com/g, 'http://localhost:5555'
#     .pipe gulp.dest distPath
#   return

gulp.task 'prod-test', ['pre-prod-test', 'protractor-prod']

gulp.task 'prod', ['css-prod', 'js-prod', 'html-prod', 'copy-prod', 'server-prod'], () -> return

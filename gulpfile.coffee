gulp  = require 'gulp'
gp    = do require "gulp-load-plugins"

streamqueue = require 'streamqueue'
combine     = require 'stream-combiner'

sources     = require './gulp.sources'

# ===========================
## paths
frontPath     = '../ee-front/src/ee-shared'
storePath     = '../ee-store/src/ee-shared'
checkoutPath  = '../ee-checkout/src/ee-shared'

# ================================
## copy html/coffee in directories
copyDir = (dir) ->
  # copy all files
  gulp.src './' + dir + '/*.*'
    .pipe gulp.dest frontPath + '/' + dir
    .pipe gulp.dest storePath + '/' + dir
    .pipe gulp.dest checkoutPath + '/' + dir
  return

gulp.task 'copy-components',  () -> copyDir 'components'
gulp.task 'copy-core',        () -> copyDir 'core'
gulp.task 'copy-product',     () -> copyDir 'product'
gulp.task 'copy-storefront',  () -> copyDir 'storefront'

# ================================
## copy img directory
gulp.task 'copy-img', () ->
  gulp.src './img/*.*'
    .pipe gulp.dest frontPath + '/img'
    .pipe gulp.dest storePath + '/img'
    .pipe gulp.dest checkoutPath + '/img'

# ================================
## copy stylesheet
gulp.task 'copy-css', () ->
  gulp.src './stylesheets/ee.less'
    .pipe gp.sourcemaps.init()
    .pipe gp.less paths: './src/stylesheets/' # @import path
    # write sourcemap to separate file w/o source content to path relative to dest below
    .pipe gp.sourcemaps.write './', { includeContent: false, sourceRoot: '../' }
    .pipe gulp.dest frontPath + '/stylesheets'
    .pipe gulp.dest storePath + '/stylesheets'
    .pipe gulp.dest checkoutPath + '/stylesheets'

# ================================
## copy fonts
gulp.task 'copy-fonts', () ->
  gulp.src './bower_components/bootstrap/fonts/**/*.*'
    .pipe gulp.dest frontPath + '/fonts'
    .pipe gulp.dest storePath + '/fonts'
    .pipe gulp.dest checkoutPath + '/fonts'
  gulp.src './bower_components/font-awesome/fonts/**/*.*'
    .pipe gulp.dest frontPath + '/fonts'
    .pipe gulp.dest storePath + '/fonts'
    .pipe gulp.dest checkoutPath + '/fonts'

# ===========================
# runners

copyDirTasks  = ['copy-components', 'copy-core', 'copy-product', 'copy-storefront']
nonDirTasks   = ['copy-css', 'copy-fonts']

gulp.task 'copy', copyDirTasks.concat(nonDirTasks), () ->
  gulp.watch ['./**/*.html', './**/*.coffee'], copyDirTasks
  gulp.src('./stylesheets/ee.less').pipe gp.watch { emit: 'one', name: 'img' }, ['copy-css']
  gulp.src('./img/*.*').pipe gp.watch { emit: 'one', name: 'img' }, ['copy-img']

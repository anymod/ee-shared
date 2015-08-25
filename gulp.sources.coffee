_       = require 'lodash'
sources = {}

stripSrc  = (arr) -> _.map arr, (str) -> str.replace('./src/', '')
toJs      = (arr) -> _.map arr, (str) -> str.replace('.coffee', '.js').replace('./src/', 'js/')
unmin     = (arr) ->
  _.map arr, (str) -> str.replace('dist/angulartics', 'src/angulartics').replace('.min.js', '.js')

sources.storeJs = () ->
  [].concat stripSrc(unmin(sources.storeVendorMin))
    .concat stripSrc(sources.storeVendorUnmin)
    .concat toJs(sources.appModule)
    .concat toJs(sources.storeModule)
    .concat toJs(sources.storeDirective)

sources.storeModules = () ->
  [].concat sources.appModule
    .concat sources.storeModule
    .concat sources.storeDirective

### MODULE ###
sources.appModule = [
  # Definitions
  '../ee-shared/core/core.module.coffee'
  '../ee-shared/core/constants.coffee'
  '../ee-shared/core/filters.coffee'
  '../ee-shared/core/config.coffee'
  '../ee-shared/core/run.coffee'
  # Services
  '../ee-shared/core/svc.back.coffee'
  # '../ee-shared/core/svc.storefront.coffee'
  '../ee-shared/core/svc.modal.coffee'
  '../ee-shared/core/svc.definer.coffee'
  # '../ee-shared/core/svc.selection.coffee'
  # '../ee-shared/core/svc.selections.coffee'
  '../ee-shared/core/svc.collections.coffee'
  # Product modal
  # '../ee-shared/product/product.modal.controller.coffee'
]

module.exports = sources

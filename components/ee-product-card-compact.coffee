'use strict'

module = angular.module 'ee-product-card-compact', []

module.directive "eeProductCardCompact", ($rootScope, $state, $location, $filter) ->
  templateUrl: 'ee-shared/components/ee-product-card-compact.html'
  restrict: 'E'
  scope:
    product:  '='
    skus:     '='
    products: '='
    disabled: '='
  link: (scope, ele, attrs) ->
    scope.skuPage = false
    scope.adding = false

    scope.addToCart = (sku) ->
      scope.adding = true
      scope.addingText = 'Adding'
      $rootScope.$emit 'cart:add:sku', sku

    scope.setCurrentSku = (sku) ->
      scope.currentSku = sku
      if sku.msrp and sku.price
        scope.msrpDiscount = (sku.msrp - sku.price) / sku.msrp

    if scope.skus and scope.skus.length > 0 then scope.setCurrentSku scope.skus[0]

    scope.showSkuPage = () ->
      scope.skuPage = true
      title = $filter('urlText')(scope.product.title )
      # $location.url $state.href('sku', { obfuscated_id: scope.product.skus[0].obfuscated_id, title: title })
      $state.go('sku', { obfuscated_id: scope.product.skus[0].obfuscated_id, title: title }, { notify: false, reload: false })
    return

'use strict'

module = angular.module 'ee-product-card-compact', []

module.directive "eeProductCardCompact", ($rootScope, $state, eeBack) ->
  templateUrl: 'ee-shared/components/ee-product-card-compact.html'
  restrict: 'E'
  scope:
    product:  '='
    skus:     '='
    products: '='
    disabled: '='
  link: (scope, ele, attrs) ->

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

    return

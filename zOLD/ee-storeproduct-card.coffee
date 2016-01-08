'use strict'

module = angular.module 'ee-product-card', []

module.directive "eeProductCard", ($rootScope, $state, eeBack) ->
  templateUrl: 'ee-shared/components/ee-product-card.html'
  restrict: 'E'
  scope:
    product:  '='
    template: '='
    disabled: '='
    price:    '='
  link: (scope, ele, attrs) ->

    scope.adding = false
    scope.addToCart = () ->
      scope.adding = true
      scope.addingText = 'Adding'
      $rootScope.$emit 'cart:add:sku', $state.params.id

    if scope.price and scope.product then scope.product.selling_price = scope.price

    if scope.product?.msrp and scope.product?.selling_price
      scope.msrpDiscount = (scope.product.msrp - scope.product.selling_price) / scope.product.msrp

    return

'use strict'

angular.module 'ee-product-for-store', []

angular.module('ee-product-for-store').directive "eeProductForStore", ($state, $filter) ->
  templateUrl: 'ee-shared/components/ee-product-for-store.html'
  restrict: 'E'
  scope:
    product: '='
    skuLink: '@'
    hidePrice: '@'
    hideSale: '@'
    hideHeart: '@'
  link: (scope, ele, attr) ->
    if $state.current.name is 'sale' then scope.hideSale = true

    scope.imageClick = () ->
      return $state.go('storefront') unless scope.product.id
      title = $filter('urlText')(scope.product.title )
      if scope.skuLink and scope.product.skus?.length > 0 then return $state.go 'sku', { obfuscated_id: scope.product.skus[0].obfuscated_id, title: title }
      $state.go 'product', { id: scope.product.id, title: title, c: scope.product.category_id }
    return

'use strict'

angular.module 'ee-product-single', []

angular.module('ee-product-single').directive "eeProductSingle", ($rootScope, $state, $filter) ->
  templateUrl: 'ee-shared/components/ee-product-single.html'
  restrict: 'E'
  scope:
    product: '='
    skuLink: '@'
    hideExtra: '@'
  link: (scope, ele, attr) ->
    if $state.current.name is 'sale' then scope.hideSale = true

    # scope.imageClick = () ->
    #   return $state.go('storefront') unless scope.product?.id?
    #   title = $filter('urlText')(scope.product.title )
    #   $rootScope.$broadcast 'product:navigate', scope.product
    #   $state.go 'product', { id: scope.product.id, title: title, c: scope.product.category_id }, { notify: $state.current.name isnt 'product' }
    #   if $state.current.name is 'product' then $rootScope.scrollTo 'body-top'

    scope.addToCart = (sku) ->
      scope.adding = true
      scope.addingText = 'Adding'
      $rootScope.$emit 'cart:add:sku', sku

    return

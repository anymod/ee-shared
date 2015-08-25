'use strict'

module = angular.module 'ee-storeproduct-card', []

module.directive "eeStoreproductCard", ($rootScope, $state, $cookies, eeBack) ->
  templateUrl: 'ee-shared/components/ee-storeproduct-card.html'
  restrict: 'E'
  scope:
    storeproductTitle: '=' # storeproductTitle to avoid title="" in HTML (which causes popover note in some browsers)
    price:          '='
    content:        '='
    mainImage:      '@'
    details:        '='
    disabled:       '='
    outOfStock:     '='
    discontinued:   '='
  link: (scope, ele, attrs) ->
    scope.setMainImage = (url) -> scope.mainImage = url
    scope.addToCart = () -> $rootScope.$emit 'add:storeproduct', $state.params.id
    return

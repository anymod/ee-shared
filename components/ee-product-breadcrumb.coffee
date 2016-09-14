'use strict'

module = angular.module 'ee-product-breadcrumb', []

module.directive "eeProductBreadcrumb", ($stateParams, categories, eeProducts) ->
  templateUrl: 'ee-shared/components/ee-product-breadcrumb.html'
  scope:
    product: '='
  link: (scope, ele, attrs) ->
    scope.stateParams = $stateParams
    scope.data = eeProducts.data

    scope.getCategoryTitle = () ->
      for category in categories
        if parseInt(category.id) is parseInt(scope.product.category_id) then return category.title
      return null

    return

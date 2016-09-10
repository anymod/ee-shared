'use strict'

module = angular.module 'ee-search-breadcrumb', []

module.directive "eeSearchBreadcrumb", ($stateParams, categories, sortOrders, eeProducts) ->
  templateUrl: 'ee-shared/components/ee-search-breadcrumb.html'
  # restrict: 'E'
  scope: {}
  link: (scope, ele, attrs) ->
    scope.stateParams = $stateParams
    scope.data = eeProducts.data

    scope.setOrder = (order) ->
      eeProducts.fns.setParam 's', order, { goTo: 'search' }

    scope.getStart = () ->
      1 + (parseInt(eeProducts.data.page) - 1) * parseInt(eeProducts.data.perPage)

    scope.getEnd = () ->
      Math.min(parseInt(eeProducts.data.page) * parseInt(eeProducts.data.perPage), parseInt(eeProducts.data.count))

    scope.getCount = () -> eeProducts.data.count

    scope.getCategoryTitle = () ->
      for category in categories
        if parseInt(category.id) is parseInt(eeProducts.data.params.c) then return category.title
      return null

    scope.getOrderTitle = () ->
      for order in sortOrders
        if order.order is eeProducts.data.params.s then return order.title
      return 'Featured'

    scope.clearSearch = () -> eeProducts.fns.setParam 'q', null, { goTo: 'search' }
    scope.clearCategory = () -> eeProducts.fns.setParam 'c', null, { goTo: 'search' }

    return

'use strict'

angular.module 'ee-search-token', []

angular.module('ee-search-token').directive 'eeSearchToken', ($state, $window, eeProducts, eeModal) ->
  templateUrl: 'ee-shared/components/ee-search-token.html'
  restrict: 'EA'
  scope:
    showDetails: '@'
  link: (scope, ele, attr) ->
    box = ele.find('input')
    minBoxWidth = 110
    maxBoxWidth = 300
    scope.data  = eeProducts.data
    scope.fns   = eeProducts.fns
    scope.boxWidth = minBoxWidth
    scope.boxValue = ''
    # scope.collectionData = eeCollection.data
    # scope.state = $state

    # scope.setCategory = (category) ->
    #   if !category?.id?
    #     $stateParams.c = null
    #     $state.go 'search', $stateParams
    #   else
    #     $stateParams.id = category.id
    #     $stateParams.title =  category.title
    #     $state.go 'category', $stateParams

    scope.openSearchModal = () -> eeModal.fns.open 'search'

    scope.searchToken = (token) ->
      eeProducts.fns.setParam 'q', token
      eeProducts.fns.runQuery()
      $state.go 'search', { q: token }

    scope.focusBox = () ->
      box.focus()
      return

    scope.adjustBox = () ->
      letterCount = scope.boxValue.length
      scope.boxWidth = letterCount * 9
      if scope.boxWidth < minBoxWidth then scope.boxWidth = minBoxWidth
      if scope.boxWidth > maxBoxWidth then scope.boxWidth = maxBoxWidth

    scope.addToQuery = () ->
      eeProducts.fns.addToQuery scope.boxValue
      scope.boxValue = ''
      eeProducts.fns.runQuery()

    # scope.removeFromSearch = (token) -> eeProducts.fns.removeFromSearch token

    scope.clearSearchQuery = () ->
      eeProducts.fns.setParam 'q', null
      eeProducts.fns.runQuery()

    return

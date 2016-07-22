'use strict'

angular.module 'ee-search-token', []

angular.module('ee-search-token').directive 'eeSearchToken', ($state, $window, eeProducts, eeModal) ->
  templateUrl: 'ee-shared/components/ee-search-token.html'
  restrict: 'EA'
  scope:
    showDetails: '@'
  link: (scope, ele, attr) ->
    box = ele.find('input')
    scope.data  = eeProducts.data
    scope.fns   = eeProducts.fns
    scope.boxWidth = 80
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
      $state.go 'search', { q: token }

    scope.focusBox = () ->
      box.focus()
      return

    scope.adjustBox = () ->
      letterCount = scope.boxValue.length
      scope.boxWidth = letterCount * 9
      if scope.boxWidth < 80 then scope.boxWidth = 80
      if scope.boxWidth > 300 then scope.boxWidth = 300

    scope.addToSearch = () ->
      eeProducts.fns.addToSearch scope.boxValue
      scope.boxValue = ''

    scope.removeFromSearch = (token) -> eeProducts.fns.removeFromSearch token

    return

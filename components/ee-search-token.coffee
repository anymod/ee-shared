'use strict'

angular.module 'ee-search-token', []

angular.module('ee-search-token').directive 'eeSearchToken', ($state, $stateParams, eeProducts, eeCollection) ->
  templateUrl: 'ee-shared/components/ee-search-token.html'
  restrict: 'EA'
  scope: {}
  link: (scope, ele, attr) ->
    scope.data  = eeProducts.data
    scope.fns   = eeProducts.fns
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

    scope.searchToken = (token) ->
      $state.go 'search', { q: token }
      # eeProducts.fns.searchLike token

    return

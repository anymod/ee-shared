'use strict'

angular.module 'ee-sidebar', []

angular.module('ee-sidebar').directive 'eeSidebar', ($state, $stateParams, eeDefiner, eeProducts) ->
  templateUrl: 'ee-shared/components/ee-sidebar.html'
  restrict: 'EA'
  scope: {}
  link: (scope, ele, attr) ->
    scope.ee = eeDefiner.exports
    scope.state = $state.current.name
    scope.stateParams = $stateParams

    scope.setCategory = (id) ->
      eeProducts.fns.setParam 'c', id, { goTo: 'search' }

    scope.setCategoryAndSubtag = (id, subtag) ->
      console.log 'id, subtag', id, subtag
      eeProducts.fns.setParams { c: id, t: subtag }, { goTo: 'search' }

    return

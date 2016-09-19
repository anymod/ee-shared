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

    scope.clearCollection = () -> eeProducts.fns.setParams { p: 1, coll: null }, { goTo: 'search' }

    scope.setCategoryAndSubtag = (id, subtag) ->
      subtag ||= ''
      eeProducts.fns.setParams { c: id, t: subtag, p: 1, q: null, coll: null }, { goTo: 'search' }

    return

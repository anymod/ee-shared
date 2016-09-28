'use strict'

angular.module 'ee-sidebar', []

angular.module('ee-sidebar').directive 'eeSidebar', ($state, $stateParams, $filter, eeDefiner, eeProducts, tagTree) ->
  templateUrl: 'ee-shared/components/ee-sidebar.html'
  restrict: 'EA'
  scope: {}
  link: (scope, ele, attr) ->
    scope.ee = eeDefiner.exports
    scope.state = $state.current.name
    scope.stateParams = $stateParams

    scope.clearCollection = () -> eeProducts.fns.setParams { p: 1, coll: null }, { goTo: 'search' }

    scope.tag1s = Object.keys(tagTree)

    scope.setTags = (tagObj) ->
      params = { p: 1, q: null, coll: null }
      params[key] = $filter('urlText')(tagObj[key]) for key in Object.keys(tagObj)
      eeProducts.fns.setParams params, { goTo: 'search' }

    scope.setCategoryAndSubtag = (id, subtag) ->
      subtag ||= ''
      eeProducts.fns.setParams { c: id, t: subtag, p: 1, q: null, coll: null }, { goTo: 'search' }

    return

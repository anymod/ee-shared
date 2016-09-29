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
    scope.tagTree = tagTree
    scope.currentTag1 = scope.currentTag2 = scope.currentTag3 = null

    # TODO Make currentTag1, currentTag2, and currentTag3 available on rootScope
    for tag1, branch1 of tagTree
      if $stateParams.t1 is $filter('urlText')(tag1) then scope.currentTag1 = tag1
      for tag2, branch2 of branch1
        break unless $stateParams.t2
        if $stateParams.t2 is $filter('urlText')(tag2) then scope.currentTag2 = tag2
        for tag3 in branch2
          break unless $stateParams.t3
          if $stateParams.t3 is $filter('urlText')(tag3) then scope.currentTag3 = tag3

    console.log scope.currentTag1, scope.currentTag2, scope.currentTag3

    scope.clearCollection = () -> eeProducts.fns.setParams { p: 1, coll: null }, { goTo: 'search' }

    scope.setTags = (tagObj) ->
      params = { p: 1, q: null, coll: null, t1: null, t2: null, t3: null }
      params[key] = $filter('urlText')(tagObj[key]) for key in Object.keys(tagObj)
      eeProducts.fns.setParams params, { goTo: 'search' }

    return

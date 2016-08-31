'use strict'

angular.module 'ee-sidebar', []

angular.module('ee-sidebar').directive 'eeSidebar', ($state, eeDefiner) ->
  templateUrl: 'ee-shared/components/ee-sidebar.html'
  restrict: 'EA'
  scope: {}
  link: (scope, ele, attr) ->
    scope.ee = eeDefiner.exports
    scope.state = $state.current.name
    return

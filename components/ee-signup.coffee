'use strict'

angular.module 'ee-signup', []

angular.module('ee-signup').directive 'eeSignup', ($rootScope, $window, $timeout, eeModal, eeBack) ->
  templateUrl: 'ee-shared/components/ee-signup.html'
  restrict: 'EA'
  scope:
    runParse: '@'
    hideSocial: '@'
  link: (scope, ele, attr) ->

    scope.subscribe = () ->
      scope.submitting = true
      eeBack.fns.customerPOST scope.email
      .then (res) ->
        scope.alert = false
        eeModal.fns.close 'offer'
        eeModal.fns.open  'offer_thanks'
      .catch (err) -> scope.alert = 'Please check your email address.'
      .finally () -> scope.submitting = false

    socialParse = () ->
      return if !scope.runParse and $rootScope.pageDepth < 2
      parent = ele.parent()[0]
      $window.FB?.XFBML?.parse(parent)
      $window.PinUtils?.build(parent)
    # $timeout(socialParse, 100)
    socialParse() unless scope.hideSocial

    # page_like_callback = (url, html_element) ->
    #   console.log 'running'
    #   heap.track 'Clicked Follow Button'
    # FB?.Event.subscribe 'edge.create', page_like_callback

    return

'use strict'

module = angular.module 'ee-paypal-button', []

module.directive "eePaypalButton", (eeCart, eeBack, eeEnvironment) ->
  templateUrl: 'ee-shared/components/ee-paypal-button.html'
  restrict: 'EA'
  scope:
    showButton: '='
  link: (scope, ele, attrs) ->
    uuid = eeCart.data.uuid
    return unless uuid?
    scope.showButton = false

    scope.initPaypal = () ->
      paypal.checkout.initXO()
      eeBack.fns.paymentPOST uuid
      .then (res) -> paypal.checkout.startFlow res.href
      .catch (err) ->
        console.log 'Problem with checkout flow'
        paypal.checkout.closeFlow()

    loadPaypalButton = () ->
      env = if eeEnvironment is 'production' then 'production' else 'sandbox'
      paypal.checkout.setup 'WJ7QFVAKXGVG8', {
        environment: env
        container: 't1'
      }
      scope.showButton = true
      scope.$digest()

    if window.paypalCheckoutReady?
      scope.showButton = true
    else
      s = document.createElement 'script'
      s.src = '//www.paypalobjects.com/api/checkout.js'
      document.body.appendChild s
      window.paypalCheckoutReady = () -> loadPaypalButton()

    return

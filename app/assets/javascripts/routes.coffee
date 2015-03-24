angular.module('SimpleTask').config ($stateProvider, $urlRouterProvider) ->
	$urlRouterProvider.otherwise('/')

	$stateProvider
		.state 'home',
		url: '/'
		templateUrl: 'home/_home.html'
		controller: 'MainCtrl'

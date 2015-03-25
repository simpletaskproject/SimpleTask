angular.module('SimpleTask').config ($stateProvider, $urlRouterProvider) ->
	$urlRouterProvider.otherwise('/')

	$stateProvider
		
		.state('home',
		url: '/'
		templateUrl: 'home/_home.html'
		controller: 'MainCtrl')
		
		.state('login',
		url: '/login'
		templateUrl: 'user/_login.html'
		controller: 'UserCtrl',
		onEnter: ($state, Auth) ->
			Auth.currentUser().then ->
				$state.go 'home')
		
		.state('register',
		url: '/register'
		templateUrl: 'user/_register.html'
		controller: 'UserCtrl',
		onEnter: ($state, Auth) ->
			Auth.currentUser().then ->
				$state.go 'home')

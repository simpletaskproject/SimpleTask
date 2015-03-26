angular.module('SimpleTask').controller 'MainCtrl', ($scope, $http, Auth, $stateParams) ->
	$scope.list = {}

	Auth.currentUser().then ((user) ->
		$http.get('/api/lists/#{ list_slug }.json').success (data) ->
			$scope.list = data
			return
		$scope.message = 'Success :)'
		return
	), (error) ->
		$scope.message = 'Fail :('

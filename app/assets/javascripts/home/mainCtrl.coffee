angular.module('SimpleTask').controller 'MainCtrl', ($scope, $http, Auth) ->
	$scope.lists = []

	Auth.currentUser().then ((user) ->
		$http.get('/api/lists.json').success (data) ->
			$scope.lists = data
			return
		$scope.message = 'Success :)'
		return
	), (error) ->
		$scope.message = 'Fail :('

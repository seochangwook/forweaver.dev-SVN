var app = angular.module('myApp', [
	
]); //사용할 모듈을 불러온다.//
///////////////////////////////
app.controller('codecontroller', function($scope){
	$scope.printCode = 'class{ \npublic static void main(String args[])\n{}\n}';
});
///////////////////////////////
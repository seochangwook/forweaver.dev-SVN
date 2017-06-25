var app = angular.module('myadminApp', [
	
]); //사용할 모듈을 불러온다.//
////////////////////
app.controller('codecontroller', function($scope){
	$scope.printCode = 'class{ \npublic static void main(String args[])\n{}\n}';
});
////////////////////
app.controller('authcheckcontroller', function($scope, $http){
	$scope.logoutclick = function(){
		console.log('logout pricess');
		
		//로그아웃 프로세스 진행(ajax)//
		$http({
			method: 'POST', //방식
			url: 'http://localhost:8080/controller/adminlogoutajax',
			headers: {'Content-Type': 'application/json; charset=utf-8'} //헤더
		}).then(function(response){
	        //First function handles success
			//원래의 로그아웃으로 이동//
			var url = "http://localhost:8080/controller/";
	        $(location).attr("href", url);
	    },	function(response){
	        //Second function handles error
	    	console.log('logout fail...');
	    });
	}
});
///////////////////////
app.controller('mainbackcontroller', function($scope, $http){
	$scope.backmainbtn = function(){
		console.log('logout error view');
		
		//로그아웃 프로세스 진행(ajax)//
		$http({
			method: 'POST', //방식
			url: 'http://localhost:8080/controller/adminlogoutajax',
			headers: {'Content-Type': 'application/json; charset=utf-8'} //헤더
		}).then(function(response){
	        //First function handles success
			//원래의 로그아웃으로 이동//
			var url = "http://localhost:8080/controller/";
	        $(location).attr("href", url);
	    },	function(response){
	        //Second function handles error
	    	console.log('logout fail...');
	    });
	}
});
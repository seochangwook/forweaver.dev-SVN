<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="myadminApp">
<head>
<link rel="icon" type="image/png"  href="resources/images/svnicon.png"/> <!-- favicon fix -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- jQuery, bootstrap CDN -->
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="http://code.jquery.com/jquery-migrate-1.2.1.js"></script> <!-- msie 문제 해결 -->
	<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/latest/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/latest/css/bootstrap.min.css">
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
	<!-- AngularJS CDN -->
	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>
	<!-- AngularJS External File -->
	<script src="resources/js/adminmainangular.js"></script>
<title>Login Error Page</title>
</head>
<body>
	<h1>Login Error</h1>
	<div ng-controller="mainbackcontroller">
		<input type="button" value="Back to login page" ng-click="backmainbtn('${serverip}')">
	</div>
</body>
</html>
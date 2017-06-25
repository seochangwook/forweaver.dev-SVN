<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login</title>
</head>
<body>
	<h1>Custom UI Spring Security Test (for MongoDB)</h1>
	<div>
		<form action="j_spring_security_check" method="POST">
        	ID : <input type="text" name="j_username" size="20" maxlength="50" /><br />
        	Password : <input type="password" name="j_password" size="20" maxlength="50" /><br />
        <input type="submit" value="Login" />
    </form>
	</div>
</body>
</html>
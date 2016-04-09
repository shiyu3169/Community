<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Registeration</title>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" 
		integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
		<link href="./css/Register.css" rel="stylesheet">
	</head>
	<body background="./image/background.jpg">
		<div class="container">
	        <form  method="post" class="form-signin">
	            <h2 class="form-signin-heading"> 
	            	<font color="white">Please Register </font>
	            </h2>
	            <label for="inputUserName" class="sr-only">User Name</label>
	            <input type="text" name="username" id="Username" class="form-control" placeholder="UserName" value="${username}" required>
	            <label for="inputEmail" class="sr-only">Email</label>
	            <input type="email" name="email" id="email" class="form-control" placeholder="Email@example.com" value="${email}" required>
	            <label for="inputPassword" class="sr-only">Password</label>   
	            <input type="password" name="password" id="Password" class="form-control" placeholder="Password" value="${password}"  required>
	            <h3>
	            	<font color="white">${message }</font>
	            </h3>
	            <button class="btn btn-lg btn-primary btn-block" type="submit">Sign up</button>
	        </form>
	    </div>
	</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" 
		integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
</head>
	<body background="./image/background.jpg">
	    <div>
	        <header>
	            <nav class="navbar navbar-inverse navbar-fixed-top" ng-controller="NavController">
	                <div class="container">
	                    <div id="navbar" class="collapse navbar-collapse" aria-expanded="true">
	                        <ul class="nav navbar-nav navbar-right">
	                            <li><a href="/Community/login.jsp">Log in</a></li>
	                            <li><a href="/Community/Register.jsp">Sign up</a></li>
	                            <li><a href="#/logout">Log out</a></li>  
	                        </ul>
	                    </div>
	                </div>
	            </nav>
	        </header>
	    </div>
	    <hr/>
	    <hr/>
	    <div class="text-center">
	    	<img src="./image/title.png" alt="Mountain View">
	    </div>
	    
	    <!-- Search -->
	    <div class="container">
	    	<form class="form" role="search">
		        <div class="col-lg-3"></div>
		        <div class="col-lg-6">
		            <div class="input-group">
		                <input type="text" class="form-control" placeholder="Seaching for forum ...">
		                <span class="input-group-btn">
		                    <button class="btn btn-default" type="submit">Go!</button>
		                </span>
		            </div>
		        </div>
	        </form>
	    </div>
	</body>
</html>
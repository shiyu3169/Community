<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Yahoo!!! From JSP</title>
	</head>
	<body>
		<h2>My name is ${username } and my password is${password }.</h2>
		<a href="/#">Log out</a>
		<%="Now is " + new java.util.Date() %>
		<%
			System.out.println(request.getParameter("password"));
		%>
	</body>
</html>
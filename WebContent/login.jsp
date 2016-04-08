<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Yahoo!!! From JSP</title>
	</head>
	<body>
		<p>${message }</p>
		<form method="post" action="">
		
			Username: <input name="username" value="${username }"/>
			Password: <input type="password" name="password" value="${password}"/>
			<button type="submit">Submit</button>
		</form>
		<%="Now is " + new java.util.Date() %>
		<%
			System.out.println(request.getParameter("password"));
		%>
	</body>
</html>
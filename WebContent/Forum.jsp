<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="edu.neu.ccs.community.*, java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>${forumName }</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" 
		integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
<link rel="stylesheet" href="./css/fresh-bootstrap-table.css">
</head>
	<body background="./image/background.jpg">
	    <div>
	        <header>
	            <nav class="navbar navbar-inverse navbar-fixed-top" ng-controller="NavController">
	                <div class="container">
	                    <div id="navbar" class="collapse navbar-collapse" aria-expanded="true">
	                        <ul class="nav navbar-nav navbar-right">
	                        	<%if (request.getAttribute("username") == null) {
	                        		%> 
	                        			<li><a href="/Community/login">Log in</a></li>
	                            		<li><a href="/Community/register">Sign up</a></li>
	                            	<%
	                        		}
	                            	else {
	                            		%>
	                            		<li><a href="#">Hi ${username}</a></li>  
	                            		<li><a href="/Community/login">Log out</a></li>  
	                            		<%
	                            	}
	                        		%> 
	                        </ul>
	                    </div>
	                </div>
	            </nav>
	        </header>
	    </div>
	    <br/>
	    <br/>
	    <br/>
	    <br/>
	    <br/>
	    <br/>
	    <br/>
	    <br/>
	    <div class="text-center">
	    	<img src="./image/title.png" alt="Mountain View">
	    </div>
	    <!-- Search -->
	    <div class="container">
	    	<form class="form" method="get" action="home">
		        <div class="col-lg-3"></div>
		        <div class="col-lg-6">
		           <div class="input-group">
		                <input type="text" name="search" value="${forumName }" class="form-control" placeholder="Seaching for forum ...">
		                <span class="input-group-btn">
		                    <button class="btn btn-primary btn-block" type="submit">Go!</button>
		                </span>
		            </div>
		        </div>
	        </form>
	    </div>
	    <br/>
	    <br/>
	    <div class=" container">
		    <div class="row">
		    	<div class="col-md-8 col-md-offset-2">
		    		<div class="fresh-table full-color-orange">
					    <table  id="fresh-table" class="table">
					    	<tbody>
						    	<%
						    	
						    	if (request.getAttribute("threadList") == null) { 
						    	%>Error!<%
						    	} else {
						    		List<edu.neu.ccs.community.Thread> threads = (List<edu.neu.ccs.community.Thread>)request.getAttribute("threadList");
								    	 for (edu.neu.ccs.community.Thread thread: threads) {
								    		 System.out.println(thread.getTitle());
								    		 %><tr>
								    		 	<td>
								    		 		<strong><a href="/Community/thread?id=<%=thread.getThreadID()%>">
								    		 			<%= thread.getTitle()%>
								    		 		</a></strong>
								    		 	</td>
								    		 	<td>
								    		 		<%= thread.getAuthor() %>
								    		 		</td>
								    		 	<td><%=thread.getLastUpdateTime()%> by <%=thread.getLastUpdator()%></td>
								    		 <tr><%
								   } } %>
						    </tbody>
					    </table>
				    </div>
			    </div>
			</div>
	    </div>
	</body>
</html>
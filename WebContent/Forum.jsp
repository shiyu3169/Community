<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="edu.neu.ccs.community.*, java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>${forumName }</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-2.2.3.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="./css/fresh-bootstrap-table.css">
</head>
	<body background="./image/forum.jpg">
	    <div>
	        <header>
	            <nav class="navbar navbar-inverse navbar-fixed-top" ng-controller="NavController">
	                <div class="container">
	                    <div id="navbar" class="collapse navbar-collapse" aria-expanded="true">
						    <form class="navbar-form navbar-left" method="get" action="home">
						        <div class="form-group">	           
						        	<input type="text" name="search" value="${forumName }" class="form-control" placeholder="Seaching for forum ...">
						       	</div>  
						        <button class="btn btn-primary" type="submit">Go!</button>
					        </form>
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
	    <!-- body -->
		    <div class="row">
		    	<div class="col-md-3">
		            	<h1 align="middle"><font color="white">${forumName }</font></h1>
		            	<hr/>
		                <p align="middle"><font color="white">${description }</font></p>
	    		</div>
		    	<div class="col-md-6">
		    		<div class="fresh-table">
					    <table  id="fresh-table" class="table">
					    	<thead>
					    		<tr>
					    			<th>Thread</th>
					    			<th>Initiators</th>
					    			<th>Create Date</th>
					    			<th>Last Update</th>
					    		</tr>
					    	</thead>
					    	<tbody>
						    	<%	
						    	if (request.getAttribute("threadList") == null) { 
						    	%>Error! You found the secreat place<%
						    	} else {
						    		List<edu.neu.ccs.community.Thread> threads = (List<edu.neu.ccs.community.Thread>)request.getAttribute("threadList");
								    	 for (edu.neu.ccs.community.Thread thread: threads) {
								    		 System.out.println(thread.getTitle());
								    		 %>
								    		 <tr>
								    		 	<td>
								    		 		<strong>
								    		 			<a href="/Community/thread?id=<%=thread.getThreadID()%>"><%= thread.getTitle()%></a>
								    		 		</strong>
								    		 	</td>
								    		 	<td>
								    		 		<%= thread.getAuthor() %>
								    		 	</td>
								    		 	<td>
								    		 		<%=thread.getCreationTime()%>
								    		 	</td>
								    		 	<td>
								    		 		<%=thread.getLastUpdateTime()%> by <%=thread.getLastUpdator() %>
								    		 	</td>
								    		 <tr><%
								   } } %>
						    </tbody>
					    </table>
				    </div>
			    </div>
			    <div class="col-md-3">
			    	<hr/>
	    			<p><strong><font color="white"> Owner: ${owner}</font></strong></p>
	    			<p><strong><font color="white"> Created at: ${creationTime}</font></strong></p>
	    			<p><strong><font color="white"> Total Threads:
	    			<%
	    			if (request.getAttribute("threadList") == null) { 
	    				
				    	} else {
				    		List<edu.neu.ccs.community.Thread> threads = (List<edu.neu.ccs.community.Thread>)request.getAttribute("threadList");
				    		%><%=threads.size()%><%
				    	}
	    			%>
	    			</font></strong></p>
	    			<p><strong><font color="white"> Recent Post Time: ${lastPostTime}</font></strong></p>
	    			<hr/>
	    		</div>
			</div>
	    </div>
	</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-2.2.3.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="./css/fresh-bootstrap-table.css">
</head>
<body background="./image/thread.png">
	<div>
		<header> 
			<nav class="navbar navbar-inverse navbar-fixed-top">
				<div class="container">
					<div id="navbar" class="collapse navbar-collapse" aria-expanded="true">
						<form class="navbar-form navbar-left" method="get" action="home">
							<div class="form-group">
								<input type="text" name="search" value="${forumName }"
									class="form-control" placeholder="Seaching for forum ...">
							</div>
							<button class="btn btn-primary" type="submit">Go!</button>
						</form>
						<ul class="nav navbar-nav navbar-right">
							<%
								if (request.getAttribute("username") == null) {
							%>
							<li><a href="/Community/login">Log in</a></li>
							<li><a href="/Community/register">Sign up</a></li>
							<%
								} else {
							%>
							<li><a href="#">Hi ${username}></a></li>
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
	<h1>${ title }</h1>
	<div class="row">
		<div>
			<table>
				<tbody>
				<%if (request.getAttribute("postList") == null) {
					%>Error! You found the 2nd secreat place<%
				} else { %>
					<tr>
						<td>${ content}</td>
						<td>Created at : ${cteationTime }</td>
						<td>${ author}</td>
					</tr>
					<tr <%if (request.getAttribute("lastModifytime") == null) {
						%>style="visibility:hidden;"<%
					} %>>
						<td>${lastModifyTime }</td>
					</tr> <%
				} %>
					<tr>
						<td>
							<button data-toggle="modal" data-target="#edit" <%if(!request.getAttribute("author").equals(request.getAttribute("username")) &&
			                		!(boolean)request.getAttribute("isAdmin")) {
			                	%>style="visibility:hidden;" <%
			                } %> class="btn btn-primary">Edit</button>
						</td>
						<td>
							<button data-toggle="modal" data-target="#delete" <%if(!(boolean)request.getAttribute("isAdmin")  ) {
			                	%>style="visibility:hidden;" <%
			                }%> class="btn btn-danger">Delete</button>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<!-- Modal -->
	<div class="modal fade" id="edit">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Edit Forum</h4>
				</div>
				<div class="modal-body">
					<form class="form form-horizontal" method="post"
						action="updateForum">
						<input type="hidden" id="owner" name="owner" value="${author}" />
						<input type="hidden" id="postID" name="postID" value="<%=request.getParameter("id")%>" />
						<div class="form-group">
							<label class="col-sm-3 control-label">Content</label>
							<div class="col-sm-8">
								<textarea id="content" name="content"
									class="form-control" maxlength="400" value="${content }"
									placeholder="The content of the post">
								</textarea>
							</div>
						</div>
						<div class="modal-footer">
							<button type="submit" class="btn btn-success" id="ok">Confirm</button>
							<button type="button" data-dismiss="modal" class="btn btn-danger" id="cancelAdd">Cancel</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- Delete -->
	<div class="modal fade" id="delete">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Delete Post</h4>
				</div>
				<div class="modal-body">
					<form class="form form-horizontal" method="post"
						action="deleteForum">
						<input type="hidden" name="forumID"
							value="<%=request.getParameter("id") %>" />
						<h3>Are you sure to delete this post?</h3>
						<div class="modal-footer">
							<button type="submit" class="btn btn-danger" id="ok">Delete</button>
							<button type="button" data-dismiss="modal" class="btn btn-success" id="cancelAdd">Cancel</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
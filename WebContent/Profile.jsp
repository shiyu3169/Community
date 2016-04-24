<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="edu.neu.ccs.community.Thread, java.util.List, edu.neu.ccs.community.Forum"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Profile</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-2.2.3.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="./css/fresh-bootstrap-table.css">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.2/css/select2.min.css"
	rel="stylesheet" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.2/js/select2.min.js"></script>
</head>
<body background="./image/profile.jpg">
	<header> <nav class="navbar navbar-inverse navbar-fixed-top">
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
				<li><a href="<%=request.getContextPath()%>/home">Home</a></li>
				<li><a href="<%=request.getContextPath()%>/login">Log out</a></li>
			</ul>
		</div>
	</div>
	</nav> </header>
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<div class="container">
		<div class="row">
			<div class="col-lg-4">
				<!-- Search -->
				<div class="container">
					<form class="form" method="get" action="searchUser">
						<div class="col-lg-3"></div>
						<div class="col-lg-6">
							<div class="input-group">
								<input type="text" name="search"
									class="form-control" placeholder="Seaching for other user...">
								<span class="input-group-btn">
									<a href="profile?user=<%=request.getAttribute("user")%>" class="btn btn-primary btn-block" type="submit">Go!</a>
								</span>
							</div>
						</div>
					</form>
				</div>
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="text-center panel-default">${username}</h3>
					</div>
					<div class="panel-body">
						<p>${creationTime}</p>
						<br />
						<p>${lastLoginTime}</p>
						<br />
						<p>${lastPostTime}</p>
						<br />
						<p>${lastPostTime}</p>
						<br />
						<p>${gender }</p>
						<br />
						<p>${birthday }</p>
						<br />
						<p>${bio }</p>
					</div>
				</div>
				<br />
				<div align="middle">
					<button data-toggle="modal" data-target="#edit"
						<%if (!request.getAttribute("owner").equals(request.getAttribute("username"))
					&& !(boolean) request.getAttribute("isAdmin")) {%>
						style="visibility: hidden;" <%}%> class="btn btn-primary">Edit</button>
					<button data-toggle="modal" data-target="#delete"
						<%if (!(boolean) request.getAttribute("isAdmin")) {%>
						style="visibility: hidden;" <%}%> class="btn btn-danger">Ban
						User</button>
				</div>
			</div>
			<div class="col-lg-4">
				<div class="fresh-table full-color-blue">
					<table id="fresh-table" class="table">
						<thead>
							<tr>
								<th>Recent Posted Thread</th>
							</tr>
						</thead>
						<tbody>
							<%
								if (request.getAttribute("recentPostedThread") == null) {
							%>
							<%
								} else {
									List<Thread> threads = (List<Thread>) request.getAttribute("recentPostedThread");
									for (Thread thread : threads) {
							%>
							<tr>
								<td><a
									href="goThread?forumid=<%=thread.getForumID()%>&threadid=<%=thread.getThreadID()%>"><%=thread.getTitle()%></a>
								</td>
							</tr>
							<%
								}
								}
							%>
						</tbody>
					</table>
				</div>
			</div>
			<div class="col-lg-4">
				<div class="fresh-table full-color-blue">
					<table id="fresh-table" class="table">
						<thead>
							<tr>
								<th>Favorite Forum</th>
							</tr>
						</thead>
						<tbody>
							<%
								if (request.getAttribute("favoriteForum") == null) {
							%>
							<%
								} else {
									List<Forum> forums = (List<Forum>) request.getAttribute("favoriteForum");
									for (Forum forum : forums) {
							%>
							<tr>
								<td><a href="forum?id=<%=forum.getForumID()%>"><%=forum.getForumName()%></a>
								</td>
							</tr>
							<%
								}
								}
							%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<!-- Edit Modal -->
	<div class="modal fade" id="edit">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Edit Profile</h4>
				</div>
				<div class="modal-body">
					<form class="form form-horizontal" method="post"
						action="updateProfile">
						<div class="form-group">
							<label class="col-sm-3 control-label">User Name</label>
							<div class="col-sm-8">
								<input id="username" name="username" type="text"
									class="form-control" value="${username}"
									placeholder="User Name" required />
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">Password</label>
							<div class="col-sm-8">
								<input id="password" name="password" type="password"
									class="form-control" value="${password}" placeholder="password"
									required />
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">Gender</label>
							<div class="col-sm-8">
								<select id="gender" name="gender" class="form-control">
									<option>Hidden</option>
									<option value="M">Male</option>
									<option value="F">Female</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">${bio }</label>
							<div class="col-sm-8">
								<textarea id="bio" name="bio" class="form-control"
									maxlength="400" placeholder="A short discription about you">${bio}</textarea>
							</div>
						</div>
						<div class="modal-footer">
							<button type="submit" class="btn btn-success" id="ok">Confirm</button>
							<button type="button" data-dismiss="modal" class="btn btn-danger"
								id="cancelAdd">Cancel</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- Delete Modal-->
	<div class="modal fade" id="delete">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Ban User</h4>
				</div>
				<div class="modal-body">
					<form class="form form-horizontal" method="post" action="banUser">
						<h3>Are you sure to ban this user?</h3>
						<div class="modal-footer">
							<button type="submit" class="btn btn-danger" id="ok">Ban</button>
							<button type="button" data-dismiss="modal"
								class="btn btn-success" id="cancelAdd">Cancel</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
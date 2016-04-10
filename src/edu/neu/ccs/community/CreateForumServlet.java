package edu.neu.ccs.community;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CreateForumServlet
 */
@WebServlet("/createForum")
public class CreateForumServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CreateForumServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		DataAccessObject dao = new DataAccessObject();
		LoginManager loginManager = new LoginManager(new CookieAccessObject(request, response), dao);
		if (!loginManager.hasLoggedIn()) {
			response.getWriter().println("You need to log in before create a forum.");
			return;
		}

		Integer parentID = null;
		String forumName = request.getParameter("name");
		String owner = loginManager.getSavedUsername();
		String catagory = request.getParameter("catagory");
		String description = request.getParameter("description");
		boolean isVerified = false;
		try {
			int forumID = dao.create(new Forum(parentID, forumName, owner, catagory, description, isVerified));
			response.sendRedirect("forum?id=" + forumID);
		} catch (InstantiationException | IllegalAccessException | ClassNotFoundException | SQLException e) {
			response.getWriter().println(e.getLocalizedMessage());
			return;
		}

	}

}

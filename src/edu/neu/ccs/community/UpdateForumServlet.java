package edu.neu.ccs.community;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UpdateForumServlet
 */
@WebServlet("/updateForum")
public class UpdateForumServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateForumServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DataAccessObject dao = new DataAccessObject();
		LoginManager loginManager = new LoginManager(new CookieAccessObject(request, response),
				dao);
		if (!loginManager.hasLoggedIn()) {
			request.setAttribute("message", "You need to log in before updating a form.");
			request.getRequestDispatcher("/Login.jsp").forward(request, response);
			return;
		};
		
		
		Integer parentID;
		String forumName;
		String owner;
		String catagory;
		String description;
		boolean isVerified;
		
	}

}

package edu.neu.ccs.community;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ThreadServlet
 */
@WebServlet("/thread")
public class ThreadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ThreadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		DataAccessObject dao = new DataAccessObject();
		LoginManager loginManager = new LoginManager(new CookieAccessObject(request, response), dao);
		
		
		int threadID;
		if (loginManager.hasLoggedIn()) {
			request.setAttribute("isAdmin", loginManager.getCurrentUser().isAdministrator());
		}
		else {
			request.setAttribute("isAdmin", false);
		}
		try {
			threadID = Integer.valueOf(request.getParameter("id"));
			List<Post> postList = dao.getPostsByThreadID(threadID);
			request.setAttribute("postList", postList);
		} catch (Exception e) {
			throw new IllegalArgumentException();
		}
		request.setAttribute("username", loginManager.getSavedUsername());
		request.getRequestDispatcher("/Thread.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

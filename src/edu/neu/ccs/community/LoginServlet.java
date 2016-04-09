package edu.neu.ccs.community;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import edu.neu.ccs.community.LoginManager;


@WebServlet(urlPatterns = "/login")
public class LoginServlet extends HttpServlet {

	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
    	LoginManager loginManager = new LoginManager(new CookieAccessObject(request,response),
    			new DataAccessObject());
    	
        request.setAttribute("username", loginManager.getSavedUsername());
    	loginManager.logOut();
    	try {
			request.getRequestDispatcher("/Login.jsp").forward(request, response);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
    	LoginManager loginManager = new LoginManager(new CookieAccessObject(request,response),
    			new DataAccessObject());
    	
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		if (loginManager.logIn(username, password, 60*60)) {
			request.getRequestDispatcher("/home").forward(request, response);
		} else {
			request.setAttribute("message", "User name or password is incorrect.");
			request.getRequestDispatcher("/Login.jsp").forward(request, response);
		}
		
	}

}
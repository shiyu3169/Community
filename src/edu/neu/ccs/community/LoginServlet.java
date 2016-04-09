package edu.neu.ccs.community;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import edu.neu.ccs.community.LoginManager;

<<<<<<< HEAD
/*
 * Browser sends Http Request to Web Server
 * 
 * Code in Web Server => Input:HttpRequest, Output: HttpResponse
 * JEE with Servlets
 * 
 * Web Server responds with Http Response
 */

//Java Platform, Enterprise Edition (Java EE) JEE6

//Servlet is a Java programming language class 
//used to extend the capabilities of servers 
//that host applications accessed by means of 
//a request-response programming model.

//1. extends javax.servlet.http.HttpServlet
//2. @WebServlet(urlPatterns = "/login.do")
//3. doGet(HttpServletRequest request, HttpServletResponse response)
//4. How is the response created?

@WebServlet(urlPatterns = "/login")
=======
//@WebServlet(urlPatterns = "/login")
@WebServlet("/login")
>>>>>>> refs/remotes/wuzhenh/master
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
			request.getRequestDispatcher("/Home.jsp").forward(request, response);
		} else {
			request.setAttribute("message", "User name or password is incorrect.");
			request.getRequestDispatcher("/Login.jsp").forward(request, response);
		}
		
	}

}
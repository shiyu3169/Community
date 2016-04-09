package edu.neu.ccs.community;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//@WebServlet(urlPatterns = "/login")
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        CookieAccessObject cao = new CookieAccessObject(request, response);
    	
        request.setAttribute("username", cao.get("username"));
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
/*    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        //String name = ;
    	String username = request.getParameter("username");
    	String password = request.getParameter("password");
        request.setAttribute("username", username);
        request.setAttribute("password", password);
        request.getRequestDispatcher("/WEB-INF/views/Welcome.jsp").forward(request, response);

        	
    	
    }   */

}
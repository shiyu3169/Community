package edu.neu.ccs.community;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "/register")
//@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {

		request.getRequestDispatcher("/Register.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		Date now = new Date(System.currentTimeMillis());
		request.setAttribute("username", username);
		request.setAttribute("password", password);
		request.setAttribute("email", email);
		User user = new User(username, password, email, request.getRemoteAddr(), now, now, null, false, false);

		DataAccessObject dao = new DataAccessObject();
		try {
			dao.create(user);
			request.getRequestDispatcher("/login").forward(request, response);
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			request.setAttribute("message", e.getMessage());
			request.getRequestDispatcher("/Register.jsp").forward(request, response);
			e.printStackTrace();
		}

	}
}

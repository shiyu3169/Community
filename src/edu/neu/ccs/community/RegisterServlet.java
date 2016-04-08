package edu.neu.ccs.community;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "/register")
public class RegisterServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		
		request.setAttribute("username", request.getParameter("username"));
		request.setAttribute("password", request.getParameter("password"));
		request.setAttribute("email", request.getParameter("email"));

		request.getRequestDispatcher("/Register.jsp").forward(request, response);
		PrintWriter out = response.getWriter();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		request.setAttribute("username", username);
		request.setAttribute("password", password);
		request.setAttribute("email", email);
		boolean isValid = new UserValidationService().isValid(username, password);
		if (isValid)
			request.getRequestDispatcher("/login.jsp").forward(request, response);
		else {
			request.setAttribute("message", "Wrong!!!!");
			request.getRequestDispatcher("/Register.jsp").forward(request, response);
		}
	}
}

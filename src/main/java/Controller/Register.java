package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import Model.UserModel;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;

import Dao.UserDAO;

import java.text.ParseException;
import java.text.SimpleDateFormat;

@WebServlet("/RegisterServlet")
@MultipartConfig(
		fileSizeThreshold = 1024 * 1024,
		maxFileSize = 1024 * 1024 * 5,
		maxRequestSize = 1024 * 1024 * 10
		)

public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Register() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/view/register.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userName = request.getParameter("username");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		UserModel newUser = new UserModel(userName, email, password, 2);
		
		int userID = UserDAO.addUser(newUser);
		
		if (userID > 0) {
//			request.getSession().setAttribute("registrationSuccessful", "Registration Successfull. Please login.");
			response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
		}
		else {
			request.setAttribute("error", "Registration failed. Email may already be in use.");
			request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
		}
	}
}
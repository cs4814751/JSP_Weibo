package com.leibro.Weibo;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class getuserdetail extends HttpServlet {


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String userid = request.getParameter("userid");
		HttpSession session = request.getSession(false);
		String loginid = String.valueOf((Integer)session.getAttribute("userid"));
		if(userid.equals(loginid)) {
			response.sendRedirect("loginuserdetail.jsp?userid="+loginid);
		} else {
			response.sendRedirect("otheruserdetail.jsp?userid="+userid);
		}
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doGet(request, response);
	}



}

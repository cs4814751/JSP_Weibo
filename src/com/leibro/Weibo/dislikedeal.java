package com.leibro.Weibo;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class dislikedeal extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int dislikeid = Integer.parseInt(request.getParameter("userid"));
		HttpSession session = request.getSession(false);
		int loginid = (Integer)session.getAttribute("userid");
		userRel.dislikeUser(loginid, dislikeid);
		response.sendRedirect("getuserdetail?userid="+dislikeid);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doGet(request, response);

	}


}

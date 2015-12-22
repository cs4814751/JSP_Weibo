package com.leibro.Weibo;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class likedeal extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int likeid = Integer.parseInt(request.getParameter("userid"));
		HttpSession session = request.getSession(false);
		int loginid = (Integer)session.getAttribute("userid");
		userRel.likeUser(loginid, likeid);
		response.sendRedirect("getuserdetail?userid="+likeid);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doGet(request, response);
	}




}

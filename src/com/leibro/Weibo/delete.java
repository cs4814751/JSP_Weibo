package com.leibro.Weibo;
import java.sql.*;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class delete extends HttpServlet {


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String rootid = request.getParameter("weiboid");
		String userid = request.getParameter("userid");
		Connection conn = DB.getConn();
		Statement stmt = DB.createStmt(conn);
		String sql = "delete from mircoblog where rootid = "+ rootid;
		DB.executeUpdate(stmt, sql);
		DB.close(stmt);
		DB.close(conn);
		response.sendRedirect("loginuserdetail.jsp?userid="+userid);
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doGet(request, response);
	}



}

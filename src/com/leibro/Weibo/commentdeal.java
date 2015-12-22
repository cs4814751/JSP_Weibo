package com.leibro.Weibo;

import java.io.IOException;
import java.sql.*;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class commentdeal extends HttpServlet {


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession(false);
		int loginid = (Integer)session.getAttribute("userid");
		String cont = request.getParameter("cont");
		int pid = Integer.parseInt(request.getParameter("pid"));
		int rootid = Integer.parseInt(request.getParameter("rootid"));
		Connection conn = DB.getConn();
		String sql = "insert into mircoblog values(null,?,?,?,null,now(),?)";
		PreparedStatement pstmt = DB.preparedStatement(conn, sql);
		try {
			pstmt.setInt(1,pid);
			pstmt.setInt(2,loginid);
			pstmt.setString(3, cont);
			pstmt.setInt(4, rootid);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		DB.executeUpdate(pstmt);
		DB.close(pstmt);
		DB.close(conn);
		response.sendRedirect("comment.jsp?weiboid="+rootid);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doGet(request, response);

	}



}

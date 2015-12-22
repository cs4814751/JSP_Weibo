package com.leibro.Weibo;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class postdeal extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String cont = request.getParameter("cont");
		HttpSession session = request.getSession(false);
		int userid = (Integer)session.getAttribute("userid");
		Connection conn = DB.getConn();
		
		int rootid = -1;
		
		String sql = "insert into mircoblog values(null,0,?,?,null,now(),?)";
		PreparedStatement pstmt = DB.preparedStmtm(conn, sql, Statement.RETURN_GENERATED_KEYS);
		try {
			pstmt.setInt(1,userid);
			pstmt.setString(2,cont);
			pstmt.setInt(3,rootid);
			pstmt.executeUpdate();
			ResultSet rsKey = pstmt.getGeneratedKeys();
			rsKey.next();
			rootid = rsKey.getInt(1);
			Statement stmt = DB.createStmt(conn);
			stmt.executeUpdate("update mircoblog set rootid = " + rootid + " where id = "	+ rootid);		
			DB.close(pstmt);
			DB.close(stmt);
			DB.close(conn);	
		} catch (SQLException e) {
			e.printStackTrace();
		}
		response.sendRedirect("getMircoBlog?userid="+userid);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doGet(request, response);

	}




}

package com.leibro.Weibo;


import java.io.*;
import java.sql.*;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class getMircoBlog extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String userid = request.getParameter("userid");
		Connection conn = DB.getConn();
		Statement stmt = DB.createStmt(conn);
		String sql = "select likeuserid from userrel where userid = " + userid;
		ResultSet rs = DB.executeQuery(stmt, sql);
		List<Integer> ids = new ArrayList<Integer>();
		try {
			while(rs.next()) {
				int likeid = rs.getInt(1);
				ids.add(likeid);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		String preString = "select * from mircoblog where (userid = "+userid;
		Iterator it = ids.iterator();
		while(it.hasNext()) {
			int temp = (Integer)it.next();
			preString += " or userid ="+temp;
		}
		preString += ")";
		DB.close(rs);
		DB.close(stmt);
		DB.close(conn);
		request.setAttribute("sql", preString);
		RequestDispatcher view = request.getRequestDispatcher("main.jsp");
		view.forward(request, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doGet(request, response);
	}

}

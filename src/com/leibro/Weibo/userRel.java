package com.leibro.Weibo;

import java.sql.*;

public class userRel {
	public static boolean checkisLike(int userid,int likeuserid) {
		Connection conn = null;
		ResultSet rs = null;
		Statement stmt = null;
		boolean next = false;
		try {
			conn = DB.getConn();
			stmt = DB.createStmt(conn);
			String sql = "select * from userrel where userid = "+userid+" and likeuserid = "+ likeuserid;
			rs = DB.executeQuery(stmt, sql);
			next = rs.next();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(next) {
			DB.close(rs);
			DB.close(stmt);
			DB.close(conn);
			return true;
		} else {
			DB.close(rs);
			DB.close(stmt);
			DB.close(conn);			
			return false;
		}
	}
	
	public static void likeUser(int userid,int likeuserid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "insert into userrel values(?,?)";
		conn = DB.getConn();
		pstmt = DB.preparedStatement(conn, sql);
		try {
			pstmt.setInt(1, userid);
			pstmt.setInt(2, likeuserid);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		DB.executeUpdate(pstmt);
		DB.close(pstmt);
		DB.close(conn);
	}
	
	public static void dislikeUser(int userid,int likeuserid) {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = "delete from userrel where userid = " + userid +" and likeuserid = "+likeuserid;
		conn = DB.getConn();
		stmt  = DB.createStmt(conn);
		DB.executeUpdate(stmt, sql);
		DB.close(stmt);
		DB.close(conn);
	}
	
}

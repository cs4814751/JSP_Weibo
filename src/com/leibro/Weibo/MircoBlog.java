package com.leibro.Weibo;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.sql.*;	
	
public class MircoBlog {

	private int id;
	private int pid;
	private int rootid;
	private int userid;
	private String cont;
	private String pic;
	private Date pdate;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public String getCont() {
		return cont;
	}
	public void setCont(String cont) {
		this.cont = cont;
	}
	public String getPic() {
		return pic;
	}
	public void setPic(String pic) {
		this.pic = pic;
	}
	public Date getPdate() {
		return pdate;
	}
	public void setPdate(Date pdate) {
		this.pdate = pdate;
	}
	public int getRootid() {
		return rootid;
	}
	public void setRootid(int rootid) {
		this.rootid = rootid;
	}
	
	public static MircoBlog initFromRs(ResultSet rs) {
		MircoBlog mb = new MircoBlog();
		try {
			mb.setId(rs.getInt(1));
			mb.setPid(rs.getInt(2));
			mb.setUserid(rs.getInt(3));
			mb.setCont(rs.getString(4));
			mb.setPic(rs.getString(5));
			mb.setPdate(rs.getDate(6));
			mb.setRootid(rs.getInt(7));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return mb;
	}
	
	
	public static String getPCont(int pid) {
		Connection conn = DB.getConn();
		String preString = "";
		return tree(conn,pid,preString);
	}
	
	public static String tree(Connection conn,int pid,String preString) {
		Statement stmt = DB.createStmt(conn);
		String sql = "select * from mircoblog where id = "+pid;
		ResultSet rs = DB.executeQuery(stmt, sql);
		try {
			rs.next();
			int prootid = rs.getInt(7);
			if(prootid != pid) {
				preString =preString+"//@"+ DB.getNickName(rs.getInt(3))+":"+rs.getString(4);
				preString =  tree(conn,rs.getInt(2),preString);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
			return preString;

	}
}

package com.leibro.Weibo;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

public class User {
	private int userid;
	private Date rigdate;
	private String nickname;
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public Date getRigdate() {
		return rigdate;
	}
	public void setRigdate(Date rigdate) {
		this.rigdate = rigdate;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	public static User initFromRs(ResultSet rs) {
		User u = new User();
		try {
			u.setUserid(rs.getInt(1));
			u.setRigdate(rs.getDate(4));
			u.setNickname(rs.getString(5));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return u;
	}
}

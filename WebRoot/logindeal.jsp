<%@ page language="java" import="java.util.*,com.leibro.Weibo.DB,java.sql.*,javax.servlet.http.HttpSession" pageEncoding="UTF-8"%>

<%! boolean logined = false;
	int userid = 0;
 %>
	
<%
	
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	Connection conn = DB.getConn();
	Statement stmt = DB.createStmt(conn);
	String sql = "select * from user where username = '"+username+"'";
	ResultSet rs = DB.executeQuery(stmt, sql);
	if(rs.next() == false) {
		logined = false;
	} else {
		String correctPwd = rs.getString("password");
		if(correctPwd.equals(password)) {
			logined = true;
			userid = rs.getInt("userid");
			session.setAttribute("userid", userid);		
		}
	}
 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	
	<script language="JavaScript1.2" type="text/javascript">
		function delayURL(url) {
			var delay=document.getElementById("time").innerHTML;
			if(delay > 1) {
				delay--;
				document.getElementById("time").innerText = delay;
			} else {
			window.top.location.href=url;
			}
			setTimeout("delayURL('"+url+"')",1000);
		}
	</script>

  </head>
  
  <body>
	<% if(logined == true) {%>
   	恭喜你，登录成功。 <br>
  	<span id="time" >3</span>秒钟后没跳转，请点击
    <a href="getMircoBlog?userid=<%= userid %>">重新登录</a>
    <script language="JavaScript1.2" type="text/javascript">
		delayURL("getMircoBlog?userid=<%= userid %>");
	</script>
    <% } else { %>
 	  用户名或密码错误，请重新登录。 <br>
  	<span id="time" style="background:red">3</span>秒钟后没跳转，请点击
    <a href="login.html">主页</a>
    <script language="JavaScript1.2" type="text/javascript">
		delayURL("login.html");
	</script>
	<% } %>
    
    
  </body>
</html>

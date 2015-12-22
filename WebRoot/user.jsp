<%@ page language="java" import="java.util.*,com.leibro.Weibo.*,java.sql.*,javax.servlet.http.HttpSession" pageEncoding="UTF-8"%>


<%
	int loginid = (Integer)session.getAttribute("userid");
	Connection conn = DB.getConn();
	Statement stmt = DB.createStmt(conn);
	String sql = "select * from user where userid <> "+loginid;
	ResultSet rs = DB.executeQuery(stmt, sql);
	List<User> users = new ArrayList<User>();
	while(rs.next()) {
		User user = User.initFromRs(rs);
		users.add(user);
	}



 %>


<!DOCTYPE html>
<html>
  <head>
    <title>发现用户</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <!-- Bootstrap -->
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
  </head>
  <body>

<div class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button class="navbar-toggle collapsed" type="button" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand hidden-sm" href="http://www.bootcss.com" onclick="_hmt.push(['_trackEvent', 'navbar', 'click', 'navbar-首页'])">LeiBro的留言板</a>
        </div>
        <div class="navbar-collapse collapse" role="navigation">
          <ul class="nav navbar-nav">
            <li class="hidden-sm hidden-md"><a href="http://v2.bootcss.com/"  target="_blank" onclick="_hmt.push(['_trackEvent', 'navbar', 'click', 'v2doc'])">我的主页</a></li>
            <li><a href="http://v3.bootcss.com/" target="_blank" onclick="_hmt.push(['_trackEvent', 'navbar', 'click', 'v3doc'])">发现用户</a></li>
            <li><a href="http://v4.bootcss.com/" target="_blank" onclick="_hmt.push(['_trackEvent', 'navbar', 'click', 'v4doc'])"> </a></li>
            <li><a href="/p/lesscss/" target="_blank" onclick="_hmt.push(['_trackEvent', 'navbar', 'click', 'less'])"> </a></li>
            <li><a href="http://www.jquery123.com/" target="_blank" onclick="_hmt.push(['_trackEvent', 'navbar', 'click', 'jquery'])"> </a></li>
            <li><a href="http://expo.bootcss.com" target="_blank" onclick="_hmt.push(['_trackEvent', 'navbar', 'click', 'expo'])"> </a></li>
          </ul>
          <ul class="nav navbar-nav navbar-right hidden-sm">
            <li><p class="navbar-text navbar-right"><a href="#" class="navbar-link"><%= DB.getNickName(loginid) %></a> &nbsp;&nbsp;欢迎回来！&nbsp;&nbsp; <a href="#" class="navbar-link">退出登录</a></p></li>

          </ul>
        </div>
      </div>
    </div>


<div class="col-xs-10 col-xs-offset-1">
	<hr class="divider" style="margin-top:100px">
</div>


<div class="container col-xs-8 col-xs-offset-2">

<% Iterator it = users.iterator();
while(it.hasNext()) {
User u = (User)it.next();



 %>

	<div class="panel panel-info">
		<div class="panel-body">
			<span>
				<%= u.getNickname() %>
			<span>
			
			<% if(userRel.checkisLike(loginid, u.getUserid())) {
			
			
			
			 %>
			<span class="pull-right">
				<span>
					<a href="dislikedeal?userid=<%= u.getUserid() %>" class="btn btn-primary" role="button">取消关注</a>
				</span>
			</span>
			<%
				} else {
			
			
			 %>
			<span class="pull-right">
				<span>
					<a href="likedeal?userid=<%= u.getUserid() %>" class="btn btn-primary" role="button">关注</a>
				</span>
			</span>
			<%
			
			} %>
		</div>

	</div>
	
	<%
	}
	 %>


</div>





      <script src="bootstrap/js/jquery.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
  </body>
</html>
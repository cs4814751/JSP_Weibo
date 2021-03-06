<%@ page language="java" import="java.util.*,com.leibro.Weibo.*,java.sql.*,javax.servlet.http.HttpSession" pageEncoding="UTF-8"%>

<%
	String temp = (String)request.getAttribute("sql");
	int loginid = (Integer)session.getAttribute("userid");
	String sql = temp + " and pid = 0 order by pdate desc";
	Connection conn = DB.getConn();
	Statement stmt = DB.createStmt(conn);
	ResultSet rs = DB.executeQuery(stmt, sql);
	List<MircoBlog> mbs = new ArrayList<MircoBlog>();
	while(rs.next()) {
		MircoBlog mb = MircoBlog.initFromRs(rs);
		mbs.add(mb);
	}
	DB.close(rs);
	DB.close(stmt);
	DB.close(conn);
	Iterator<MircoBlog> it = mbs.iterator();
 %>



<!DOCTYPE html>
<html>
  <head>
    <title>主页</title>
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
          <a class="navbar-brand hidden-sm" href="getMircoBlog?userid=<%= loginid %>" onclick="_hmt.push(['_trackEvent', 'navbar', 'click', 'navbar-首页'])">LeiBro的留言板</a>
        </div>
        <div class="navbar-collapse collapse" role="navigation">
          <ul class="nav navbar-nav">
            <li class="hidden-sm hidden-md"><a href="loginuserdetail.jsp?userid=<%= loginid %>"  target="_blank" onclick="_hmt.push(['_trackEvent', 'navbar', 'click', 'v2doc'])">我的主页</a></li>
            <li><a href="user.jsp" target="_blank" onclick="_hmt.push(['_trackEvent', 'navbar', 'click', 'v3doc'])">发现用户</a></li>
            <li><a href="http://v4.bootcss.com/" target="_blank" onclick="_hmt.push(['_trackEvent', 'navbar', 'click', 'v4doc'])"> </a></li>
            <li><a href="/p/lesscss/" target="_blank" onclick="_hmt.push(['_trackEvent', 'navbar', 'click', 'less'])"> </a></li>
            <li><a href="http://www.jquery123.com/" target="_blank" onclick="_hmt.push(['_trackEvent', 'navbar', 'click', 'jquery'])"> </a></li>
            <li><a href="http://expo.bootcss.com" target="_blank" onclick="_hmt.push(['_trackEvent', 'navbar', 'click', 'expo'])"> </a></li>
          </ul>
          <ul class="nav navbar-nav navbar-right hidden-sm">
            <li><p class="navbar-text navbar-right"><a href="#" class="navbar-link"><%= DB.getNickName(loginid) %></a> &nbsp;&nbsp;欢迎回来！&nbsp;&nbsp; <a href="logout" class="navbar-link">退出登录</a></p></li>

          </ul>
        </div>
      </div>
    </div>


<div class="col-xs-10 col-xs-offset-1">
	<hr class="divider" style="margin-top:100px">
</div>


<div class="container col-xs-8 col-xs-offset-2">

	<div class="panel panel-primary">
		<div class="panel-heading">
				<h3 class="panel-title">有什么新鲜事想告诉大家？</h3>
		</div>
		<div class="panel-body">
			<form class="form-horizontal" action="postdeal" method="post">
				<textarea class="form-control" rows="4" name="cont"></textarea>
					<div class="form-group" style="margin-bottom:0px">
							<span class="col-xs-1">
							<a type="button" class="btn btn-link btn-default"><span class="glyphicon glyphicon-sunglasses"></span> &nbsp; 表情</a>
							</span>
							<span class="col-xs-1">
							<a type="button" class="btn btn-link btn-default"><span class="glyphicon glyphicon-level-up"></span> &nbsp; 图片</a>
							</span>
							<span class="col-xs-offset-8 next">
							<input type="submit" class="btn btn-warning pull-right" value="发布" style="margin-top:10px;margin-right:15px;padding-left:30px;padding-right:30px;">
							<span>
					</div>

			</form>




		</div>
	</div>

<%
	Connection conn_temp = DB.getConn();
	Statement stmt_temp = DB.createStmt(conn_temp);
	while(it.hasNext()) {
		MircoBlog mb = it.next();
 %>



	<div class="panel panel-info">
		<div class="panel-heading">
			<h3 class="panel-title"><a href="getuserdetail?userid=<%= mb.getUserid() %>"><%= DB.getNickName(mb.getUserid()) %></a>说:
			</h3>
		</div>
		<div class="panel-body">
			<div>
				<%= mb.getCont() %>
			</div>
			<span class="pull-right">
				<span>
					<a href="comment.jsp?weiboid=<%= mb.getId() %>" type="button" class="btn btn-link btn-default"><span class="glyphicon glyphicon-edit"></span> &nbsp; 评论</a>
				</span>
				<!--  
				<span>
					<a type="button" class="btn btn-link btn-default"><span class="glyphicon glyphicon-thumbs-up"></span> &nbsp; 点赞</a>
				</span>
				-->
			</span>

		</div>

	</div>


	<%} %>	





      <script src="bootstrap/js/jquery.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
  </body>
</html>
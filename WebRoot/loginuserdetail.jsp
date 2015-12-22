<%@page import="com.leibro.Weibo.MircoBlog"%>
<%@ page language="java" import="java.util.*,com.leibro.Weibo.DB,java.sql.*,javax.servlet.http.HttpSession" pageEncoding="UTF-8"%>

<%
	int userid =  Integer.parseInt(request.getParameter("userid"));
	Connection conn = DB.getConn();
	Statement stmt = DB.createStmt(conn);
	String sql = "select * from mircoblog where userid = " + userid +" and pid = 0 order by pdate desc";
	ResultSet rs = DB.executeQuery(stmt, sql);
	List<MircoBlog> mbs = new ArrayList<MircoBlog>();
	while(rs.next()) {
		MircoBlog mb = MircoBlog.initFromRs(rs);
		mbs.add(mb);
	}
	DB.close(rs);
	DB.close(stmt);
	DB.close(conn);
		
 %>








<!DOCTYPE html>
<html>
  <head>
    <title>个人主页</title>
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
          <a class="navbar-brand hidden-sm" href="getMircoBlog?userid=<%= userid %>" onclick="_hmt.push(['_trackEvent', 'navbar', 'click', 'navbar-首页'])">LeiBro的留言板</a>
        </div>
        <div class="navbar-collapse collapse" role="navigation">
          <ul class="nav navbar-nav">
            <li class="hidden-sm hidden-md"><a href="loginuserdetail.jsp?userid=<%= userid %>"  target="_blank" onclick="_hmt.push(['_trackEvent', 'navbar', 'click', 'v2doc'])">我的主页</a></li>
            <li><a href="http://v3.bootcss.com/" target="_blank" onclick="_hmt.push(['_trackEvent', 'navbar', 'click', 'v3doc'])">发现用户</a></li>
            <li><a href="http://v4.bootcss.com/" target="_blank" onclick="_hmt.push(['_trackEvent', 'navbar', 'click', 'v4doc'])"> </a></li>
            <li><a href="/p/lesscss/" target="_blank" onclick="_hmt.push(['_trackEvent', 'navbar', 'click', 'less'])"> </a></li>
            <li><a href="http://www.jquery123.com/" target="_blank" onclick="_hmt.push(['_trackEvent', 'navbar', 'click', 'jquery'])"> </a></li>
            <li><a href="http://expo.bootcss.com" target="_blank" onclick="_hmt.push(['_trackEvent', 'navbar', 'click', 'expo'])"> </a></li>
          </ul>
          <ul class="nav navbar-nav navbar-right hidden-sm">
            <li><p class="navbar-text navbar-right"><a href="#" class="navbar-link"><%= DB.getNickName(userid) %></a> &nbsp;&nbsp;欢迎回来！&nbsp;&nbsp; <a href="logout" class="navbar-link">退出登录</a></p></li>

          </ul>
        </div>
      </div>
    </div>


<div class="container">
	<img src="bootstrap/ico2.png" alt="..." class="img-circle img-responsive center-block" style="margin-top:65px">
	<p class="text-center">这是我的座右铭</span>
</div>



<div class="col-xs-10 col-xs-offset-1">
	<hr class="divider" style="margin-top:30px">
</div>


<div class="container col-xs-8 col-xs-offset-2">


	<%
		Iterator<MircoBlog> it = mbs.iterator();
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
				<span>
					<a href="delete?weiboid=<%= mb.getId() %>&userid=<%= userid %>" type="button" class="btn btn-link btn-default"><span class="glyphicon glyphicon-trash"></span> &nbsp; 删除</a>
				</span>
			</span>

		</div>

	</div>


	<%} %>	






      <script src="bootstrap/js/jquery.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
  </body>
</html>
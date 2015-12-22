<%@ page language="java" import="java.util.*,com.leibro.Weibo.*,java.sql.*,javax.servlet.http.HttpSession" pageEncoding="UTF-8"%>

<%
	int loginid = (Integer)session.getAttribute("userid");	
	String weiboid = request.getParameter("weiboid");
	Connection conn = DB.getConn();
	Statement stmt = DB.createStmt(conn);
	String sql = "select * from mircoblog where id = " + weiboid;
	ResultSet rs = DB.executeQuery(stmt, sql);
	rs.next();
	MircoBlog masterMb = MircoBlog.initFromRs(rs);
	DB.close(rs);
	DB.close(stmt);
	DB.close(conn);
	conn = DB.getConn();
	stmt = DB.createStmt(conn);
	sql = "select * from mircoblog where rootid = " + weiboid +" and pid <> 0 order by pdate desc";
	rs = DB.executeQuery(stmt,sql);
	List<MircoBlog> commentMbs = new ArrayList<MircoBlog>();
	while(rs.next()) {
		MircoBlog temp = MircoBlog.initFromRs(rs);
		commentMbs.add(temp);
	}
	DB.close(rs);
	DB.close(stmt);
	DB.close(conn);




 %>







<!DOCTYPE html>
<html>
  <head>
    <title>评论</title>
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
            <li class="hidden-sm hidden-md"><a href="http://v2.bootcss.com/"  target="_blank" onclick="_hmt.push(['_trackEvent', 'navbar', 'click', 'v2doc'])">我的主页</a></li>
            <li><a href="http://v3.bootcss.com/" target="_blank" onclick="_hmt.push(['_trackEvent', 'navbar', 'click', 'v3doc'])">发现用户</a></li>
            <li><a href="http://v4.bootcss.com/" target="_blank" onclick="_hmt.push(['_trackEvent', 'navbar', 'click', 'v4doc'])"> </a></li>
            <li><a href="/p/lesscss/" target="_blank" onclick="_hmt.push(['_trackEvent', 'navbar', 'click', 'less'])"> </a></li>
            <li><a href="http://www.jquery123.com/" target="_blank" onclick="_hmt.push(['_trackEvent', 'navbar', 'click', 'jquery'])"> </a></li>
            <li><a href="http://expo.bootcss.com" target="_blank" onclick="_hmt.push(['_trackEvent', 'navbar', 'click', 'expo'])"> </a></li>
          </ul>
          <ul class="nav navbar-nav navbar-right hidden-sm">
            <li><p class="navbar-text navbar-right"><a href="#" class="navbar-link">李栋</a> &nbsp;&nbsp;欢迎回来！&nbsp;&nbsp; <a href="#" class="navbar-link">退出登录</a></p></li>

          </ul>
        </div>
      </div>
    </div>


<div class="col-xs-10 col-xs-offset-1">
	<hr class="divider" style="margin-top:100px">
</div>


<div class="container col-xs-8 col-xs-offset-2">












	<div class="panel panel-info">
		<div class="panel-heading">
			<h3 class="panel-title"><a href="#"><%= DB.getNickName(masterMb.getUserid()) %></a>说：</h3>
		</div>
		<div class="panel-body">
			<div>
				<%= masterMb.getCont() %>
			</div>

		</div>

	</div>

	<div class="panel panel-info">
		<div class="panel-body">
			<form class="form-horizontal" action="commentdeal" method="post">
				<textarea class="form-control" rows="4" name="cont"></textarea>
				<input type="hidden" name="pid" value="<%= masterMb.getId() %>">
				<input type="hidden" name="rootid" value="<%= masterMb.getRootid() %>" >
					<div class="form-group" style="margin-bottom:0px">					
					<input type="submit" class="btn btn-warning pull-right" value="评论" style="margin-top:10px;margin-right:15px;padding-left:30px;padding-right:30px;">					
					</div>
			</form>




		</div>
	</div>

	<hr>

	<% Iterator<MircoBlog> it = commentMbs.iterator();
		while(it.hasNext()) {
			MircoBlog mb = it.next();
			String preString = MircoBlog.getPCont(mb.getPid());
	
	
	 %>
	<div class="panel panel-primary">
		<div class="panel-body">
			<div>
				<%= DB.getNickName(mb.getUserid()) %>:<%= mb.getCont()+preString %>
			</div>
		<span class="pull-right">
				<span>
					<a href="ccomment.jsp?pid=<%= mb.getId() %>&rootid=<%= mb.getRootid() %>"  type="button"  class="btn btn-link btn-default"><span class="glyphicon glyphicon-edit"></span> &nbsp; 评论</a>
				</span>				
		</span>
		</div>

	</div>
	

            
            	<% } %>

      <script src="bootstrap/js/jquery.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
  </body>
</html>
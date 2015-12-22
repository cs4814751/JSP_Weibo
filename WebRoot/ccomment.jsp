<%@ page language="java" import="java.util.*,com.leibro.Weibo.*,java.sql.*,javax.servlet.http.HttpSession" pageEncoding="UTF-8"%>

<%
	String pid = request.getParameter("pid");
	String rootid = request.getParameter("rootid");
 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
  </head>
  
  <body>
  <div class="container">
   <div class="panel panel-info">
		<div class="panel-body">
			<form class="form-horizontal" action="commentdeal" method="post">
				<textarea class="form-control" rows="4" name="cont"></textarea>
				<input type="hidden" name="pid" value="<%= pid %>">
				<input type="hidden" name="rootid" value="<%= rootid %>" >
					<div class="form-group" style="margin-bottom:0px">					
					<input type="submit" class="btn btn-warning pull-right" value="评论" style="margin-top:10px;margin-right:15px;padding-left:30px;padding-right:30px;">					
					</div>
			</form>
		</div>
	</div>
 </div>
    
    
      <script src="bootstrap/js/jquery.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
  </body>
</html>

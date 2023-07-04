<!-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="java.sql.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">

    <title>登录失败</title>
    <link rel="stylesheet" href="css/login.css">
</head>
<body>  
        <form action='deliver.jsp' method='post'>
        <div class="login-table" style="height:350px;">
        	<div class="tit" style="margin: 25px auto 10px auto;">忘记密码</div>
        	<div style="margin:30px auto 15px auto" >请输入用户名：</div>
        	<input type="userName" name="userName" placeholder="用户名">
        	<button type='submit'>提交</button>
        	<br>
        	<br>
        	<a href="login.jsp">返回登录界面</a>
        </div>
		     	
    
        </form>
    </body>  
</html>
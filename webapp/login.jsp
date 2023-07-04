<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="java.sql.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">

    <title>登录界面</title>
    <link rel="stylesheet" href="css/login.css">
    <script>
    
    </script>
    
</head>

<body>

    <form action='check.jsp' method='post'>
        <div class="login-table">
            <img src="medias/imgs/sysu.jpg" class="avatar"/>
            <div class="tit">鸭鸭集市</div>
            <input type="userName" name="userName" placeholder="账号">
            <input type="password" name="password" placeholder="密码">
            <ul>
                <button type='submit'>登录</button>	
                <button type='button' onclick="window.location.href = 'tourist.jsp'">游客访问</button>
            </ul>
            
            
        	<br>
        	<a href="forgetpassword.jsp">忘记密码</a>
        </div>
        
        
      
    </form>
</body>
</html>
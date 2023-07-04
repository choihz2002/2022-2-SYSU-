<%@ page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
        <% request.setCharacterEncoding("utf-8");
    String conStr = "jdbc:mysql://localhost:3307/blog20337003" + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
    String username = (String)session.getAttribute("userName"); // 用户名
    String userAvatar = null; // 用户头像
    String userID = null; // 用户id
    String motto = null; // 用户格言
    int speechStatus = 1; // 是否可以发言
    int isRoot = 1; // 管理员删除
    ArrayList <String> msgidList = new ArrayList<String>(); // 评论号
    ArrayList <String> userList = new ArrayList<String>(); // 用户名
    ArrayList <String> userIDList = new ArrayList<String>(); // 用户ID
    ArrayList <String> avatarList = new ArrayList<String>(); // 用户头像
    ArrayList <String> palceList = new ArrayList<String>(); // 评论地点
    ArrayList <String> contentList = new ArrayList<String>(); // 评论内容
    ArrayList <String> timeList = new ArrayList<String>(); // 评论时间

    try {
        Class.forName("com.mysql.jdbc.Driver"); // 查找数据库驱动类
    	Connection con=DriverManager.getConnection(conStr, "root", "123");
    	Statement stmt = con.createStatement(); // 创建MySQL语句的对象

        //用户头像路径，座右铭及特有ID
    	String sql_0 = "select * from users where userName = '"+ username +"';";
    	ResultSet rs_0 = stmt.executeQuery(sql_0);//执行查询，返回结果集
    	while(rs_0.next()) { //把游标(cursor)移至第一个或下一个记录
    		userAvatar = rs_0.getString("userAvatar");
    		motto = rs_0.getString("motto");
    		userID = rs_0.getString("userID");
            speechStatus = rs_0.getInt("speechStatus");
            isRoot = rs_0.getInt("isRoot");
    	}
        rs_0.close();
        
        // 获取评论
        String sql_1 = "select * from webcomment order by msgID desc;";
        ResultSet rs_1 = stmt.executeQuery(sql_1);
        while (rs_1.next()) {
            msgidList.add(rs_1.getString("msgID"));
            palceList.add(rs_1.getString("userPlace"));
            contentList.add(rs_1.getString("content"));
            timeList.add(rs_1.getString("time"));
            userIDList.add(rs_1.getString("userID"));
        }
        rs_1.close();

        for (int i = 0; i < msgidList.size(); i++) {
            String tempUserID = userIDList.get(i);
            String sql_2 = "select * from users where userID = " + tempUserID + ";";
            ResultSet rs_2 = stmt.executeQuery(sql_2);
            while (rs_2.next()) {
                userList.add(rs_2.getString("userName"));
                avatarList.add(rs_2.getString("userAvatar"));
            }
            rs_2.close();
        }

        stmt.close();
        con.close();
    } catch (Exception e) {
        out.write(e.getMessage() + "<br>");
        e.printStackTrace();
        out.write("<script>alert('连接数据库出错！');</script>");
        return;
    }
%>

            <!DOCTYPE HTML>
            <html lang="zh-CN">

            <head>
                <meta charset="utf-8">
                <title>留言区</title>
                <link rel="icon" type="image/png" href="./favicon.ico">
                <link rel="stylesheet" type="text/css" href="./css/awesome/css/all.min.css">
                <link rel="stylesheet" type="text/css" href="./css/materialize/materialize.min.css">
                <link rel="stylesheet" type="text/css" href="./css/animate/animate.min.css">
                <link rel="stylesheet" type="text/css" href="./css/lightGallery/css/lightgallery.min.css">
                <link rel="stylesheet" type="text/css" href="./css/matery.css">
                <link rel="stylesheet" type="text/css" href="./css/my.css">
                <link rel="stylesheet" type="text/css" href="./css/myaos.css">
                <script src="./js/myaos.js"></script>

                <link rel="alternate" href="atom.xml" title="UserName" type="application/atom+xml">
                <style>
  
                                .banner-box{
                                    /* margin-top: 40%; */
                                    margin-left: -470px;
                                    height: 60vh;
                                    width: 2100px;
                                    overflow:hidden;/* 超出该标签的长高部分会被隐藏 */
                                    z-index: -1;
                                }
                                .slide-box{
                                    height: 60vh;
                                    width: 10500px;/*因为每张图的宽度是1920px，所以这里是1920px*5 的大小*/
                                    /* 动画属性 */
                                    /* animation:自定义关键帧 过度时间 过度效果 循环次数； */
                                    animation:aaa 15s ease-out infinite;
                                }
                                .slide-box img{
                                    float: left;
                                    width: 2100px;
                                    height: 60vh;
                                }
                                @keyframes aaa{/*因为是五张图，所以分为5份，如果是4张就分为4份*/
                                    0%,19%{
                                        margin-left: 0;
                                    }
                                    20%,39%{
                                        margin-left: -2100px;
                                    }
                                    40%,59%{
                                        margin-left: -4200px;
                                    }
                                    60%,79%{
                                        margin-left: -6300px;
                                    }
                                    80%,100%{
                                        margin-left: -8400px;
                                    }
                                }

                            </style>
            </head>


            <body>
                <header class="navbar-fixed">
                    <%
	Object obj = session.getAttribute("userName");
	String uname;
	if(obj==null){
		response.sendRedirect("login.jsp");
		return;
	}
	uname = obj.toString();
	pageContext.setAttribute("uname", uname);
	%>
                        <link rel="stylesheet" type="text/css" href="./css/header.css?t=2">
                        <script src="./js/header.js"></script>
                        <nav id="nav_header" class="bg-color nav-transparent">
                            <div id="navContainer" class="nav-wrapper container">
                                <div class="right brand-logo">
                                    <!-- <a href="home.jsp" class="waves-effect waves-light"> <img src="./medias/logo.png" class="logo-img" alt="LOGO"> -->
                                    </a>
                                    <div id="login_to_change" style="display: inline;">
                                        <span class="logo-span" style="position:relative;bottom:24px;left:5px">
                        <c:out value="${uname}"></c:out></span>
                                        <div class="login">
                                            <a href="login.jsp"><span>切换用户</span></a>
                                        </div>
                                        <div class="login">
                                            <a href="changeinfo.jsp"><span>修改信息</span></a>
                                        </div>
                                        <%if (uname.equals("admin")) {%>
                                            <div class="login">
                                                <a href="manage.jsp"><span>后台管理</span></a>
                                            </div>
                                            <%}%>
                                    </div>
                                </div>
                                <a href="#" data-target="mobile-nav" class="sidenav-trigger button-collapse"><i class="fas fa-bars"></i></a>
                                <ul class="left nav-menu">
                                    <li class="hide-on-med-and-down nav-item">
                                        <a href="home.jsp" class="waves-effect waves-light"> <i class="fas fa-home" style="zoom: 0.6;"></i> <span>首页</span>
                                        </a>
                                    </li>

                                    <li class="hide-on-med-and-down nav-item">
                                        <a href="categories.jsp" class="waves-effect waves-light"> <i class="fas fa-bookmark" style="zoom: 0.6;"></i> <span>分类</span>
                                        </a>
                                    </li>

                                    <li class="hide-on-med-and-down nav-item">
                                        <a href="about.jsp" class="waves-effect waves-light"> <i class="fas fa-user-circle" style="zoom: 0.6;"></i> <span>个人</span>
                                        </a>
                                    </li>

                                    <li class="hide-on-med-and-down nav-item">
                                        <a href="comment.jsp" class="waves-effect waves-light"> <i class="fas fa-comments" style="zoom: 0.6;"></i> <span>留言</span>
                                        </a>
                                    </li>

                                    <li class="hide-on-med-and-down nav-item">
                                        <a href="friends.jsp" class="waves-effect waves-light"> <i class="fas fa-address-book" style="zoom: 0.6;"></i> <span>社区</span>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </nav>
                </header>
                <div class="bg-cover pd-header about-cover">
                    <div class="container">
                        <!-- <div class="row">
                            <div class="col s10 offset-s1 m8 offset-m2 l8 offset-l2">
                                <div class="brand">
                                    <div class="title center-align">
                                        记录一些过程
                                    </div>
                                    <div class="description center-align">
                                        <span id="subtitle"></span>
                                        <script src="./js/myTyped.js"></script>
                                        <script>
                                            var typed = new Typed("#subtitle", {
                                                strings: [
                                                    "从来没有真正的绝境, 只有心灵的迷途",
                                                    "Never really desperate, only the lost of the soul",
                                                ],
                                                startDelay: 300,
                                                typeSpeed: 100,
                                                loop: true,
                                                backSpeed: 50,
                                                showCursor: true
                                            });
                                        </script>
                                    </div>
                                </div>
                            </div>
                        </div> -->
                        <script>
                            // 每天切换 banner 图.  Switch banner image every day.
                            var bannerUrl = "./medias/banner/" + new Date().getDay() + '.jpg';
                            var pick = Math.floor(Math.random() * 7);
                            var bannerUrl = "./medias/banner/" + pick + '.jpg';
                            var csstext = document.getElementsByClassName("bg-cover")[0];
                            csstext.style.cssText += "background-image: url( " + bannerUrl + "  )";
                        </script>
                    </div>
                </div>

                <main class="content" style="min-height: 584px;">
                    <div id="contact" class="container chip-container">
                        <div class="card" style="min-width:850px">
                            <div class="card-content">
                                <div class="tag-title center-align">
                                    <i class="fas fa-comments"></i>&nbsp;&nbsp;留言区
                                </div>
                                <div class="comment-container">
                                    <div class="comment-send">
                                        <%
                                        String can = "发布";
                                        if (speechStatus == 0) {
                                            out.write("<form id='commentForm' onsubmit='return false' method='post'>");
                                            can = "当前用户\n已被禁言";
                                        }
                                        else
                                            out.write("<form id='commentForm' action='comment_insert.jsp' method='post'>");
                                        %>
                                        <%-- <form id="commentForm" action="comment_insert.jsp" method="post"> --%>
                                            <span class="comment-avatar">
                                                <img src="<%=userAvatar%>" alt="avatar">
                                            </span>
                                            <textarea class="comment-send-input" name="comment" form="commentForm" cols="80" rows="5" placeholder="请留下你的评论~" ></textarea>
                                            <input class="comment-send-button" type="submit" value="<%=can%>">
                                        </form>
                                    </div>
                                    <%
                    for (int i = 0; i < msgidList.size(); i++) {
                    %>
                                        <div class="comment-list">
                                            <div class="comment">
                                                <span class="comment-avatar">
                                <img src="<%=avatarList.get(i)%>" alt="avatar">
                            </span>
                                                <div class="comment-content">
                                                    <p class="comment-content-name">
                                                        <%=userList.get(i)%>
                                                    </p>
                                                    <p class="comment-content-article">
                                                        <%=contentList.get(i)%>
                                                    </p>
                                                    <p class="comment-content-footer">
                                                        <span class="comment-content-footer-id">#<%=msgidList.get(i)%></span>
                                                        <span class="comment-content-footer-device"><%=palceList.get(i)%></span>
                                                        <span class="comment-content-footer-timestamp"><%=timeList.get(i)%></span>
                                                        <%
                                                        if (isRoot == 1 || userList.get(i).equals(username)) {
                                                            out.write("<span class='comment-content-footer-timestamp'>");
                                                            out.write("<a href='comment_delete.jsp?number=" + msgidList.get(i) + "'>删除</a>");
                                                            out.write("</span>");
                                                        }
                                                        %>
                                                    </p>
                                                </div>
                                                <div class="comment-cls"></div>
                                            </div>
                                            <%}%>
                                        </div>
                                </div>
                            </div>
                        </div>
                        <div class="card"></div>
                    </div>
                </main>

                <footer class="page-footer bg-color">

                    <div class="container row center-align" style="margin-bottom: 15px !important;">
                        <div class="s12 copy-right">
                            <a href="about.jsp" target="_blank">鸭鸭集市</a>
                            <span id="year">：中大ers的交流平台</span>
                            <br>
                        </div>
                    </div>
                </footer>
            </body>

            <script>
                if (window.name != "bencalie") {
                    window.location.href = window.location.href;
                    window.name = "bencalie";
                } else {
                    window.name = "";
                }
            </script>

            </html>

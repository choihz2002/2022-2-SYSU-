<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ page import="java.io.*,java.util.*"%>
        <%@ page import="java.sql.*"%>
            <%@ page import="java.text.SimpleDateFormat"%>
                <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
                    <%@ page trimDirectiveWhitespaces="true"%>
                        <!DOCTYPE HTML>
                        <html lang="zh-CN">

                        <head>
                            <meta charset="utf-8">
                            <title>首页</title>
                            <link rel="icon" type="image/png" href="./favicon.ico">
                            <link rel="stylesheet" type="text/css" href="./css/awesome/css/all.min.css">
                            <link rel="stylesheet" type="text/css" href="./css/materialize/materialize.min.css">
                            <link rel="stylesheet" type="text/css" href="./css/animate/animate.min.css">
                            <link rel="stylesheet" type="text/css" href="./css/lightGallery/css/lightgallery.min.css">
                            <link rel="stylesheet" type="text/css" href="./css/matery.css?u=3">
                            <link rel="stylesheet" type="text/css" href="./css/my.css">
                            <link rel="stylesheet" type="text/css" href="./css/main.css">
                            <link rel="stylesheet" type="text/css" href="./css/myaos.css">
                            <script src="js/delBlog.js"></script>
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
		if (obj == null) {
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
                                    <!-- </a> -->
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
                                        <a href="new.jsp" class="waves-effect waves-light"> <i class="fas fa-edit" style="zoom: 0.6;"></i> <span>发布</span>
                                    </a>

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
                                    <div class="row">
                                        <div class="col s10 offset-s1 m8 offset-m2 l8 offset-l2">
                                            <div class="brand">
                                                <div class="title center-align">集市首页</div>
                                                <div class="description center-align">
                                                    Home Page of SYSU Blog
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class = "banner-box">
                                            <div class="slide-box">
                                                <img src="medias/banner/0.jpg" alt="">
                                                <img src="medias/banner/1.jpg" alt="">
                                                <img src="medias/banner/2.jpg" alt="">
                                                <img src="medias/banner/3.jpg" alt="">
                                                <img src="medias/banner/4.jpg" alt="">
                                            </div>
                                    </div>
                                </div>
                            </div>

                            <%
Connection conn = null;
try {
	Class.forName("com.mysql.jdbc.Driver");
	String connectionUrl = "jdbc:mysql://localhost:3307/blog20337003?useUnicode=true&characterEncoding=UTF-8";
	conn = DriverManager.getConnection(connectionUrl, "root", "123");
} catch (Exception e) {
	out.write("<script>alert('连接数据库出错！');</script>");
	return;
}
String see;
try {
	see = new String(request.getParameter("see"));
} catch (Exception e) {
	see = "all";
}
String SQL = "select blogID,title,content,releaseTime,backgroundImg,catName from blog natural join users natural join cat";
if (see.equals("me")) { // 如果设置了只显示自己的文章，那么只能看到自己的文章
	SQL = SQL + " where userName = \"" + uname + "\"";
	see = "all";
} else
	see = "me";
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(SQL);
List<Map<String, String>> articles = new ArrayList<>();
while (rs.next()) {
	Map<String, String> map = new HashMap<>();
	map.put("blogID", Integer.toString(rs.getInt("blogID")));
	map.put("title", rs.getString("title"));
	map.put("content", rs.getString("content"));
	map.put("backgroundImg", rs.getString("backgroundImg"));
	map.put("catName", rs.getString("catName"));
	String releaseTime = new SimpleDateFormat("yyyy-MM-dd").format(rs.getTimestamp("releaseTime"));
	map.put("releaseTime", releaseTime);
	articles.add(map);
}
pageContext.setAttribute("articles", articles);
rs.close();
stmt.close();
conn.close();
%>

                                <main class="content">

                                    <div id="indexCard" class="index-card">
                                        <div class="container ">
                                            <div class="card">
                                                <div class="card-content">
                                                    <div class="dream">
                                                        <div class="title center-align">
                                                            <i class="fa fa-home"></i>&nbsp;&nbsp;博客首页
                                                        </div>
                                                        <div class="row">
                                                            <div class="col l8 offset-l2 m10 offset-m1 s10 offset-s1 center-align text">
                                                                Welcome to SYSU Blog!
                                                            </div>
                                                            <div class="col l8 offset-l2 m10 offset-m1 s10 offset-s1 center-align text">
                                                                This is a state of grace, this is a war worth fight.
                                                            </div>
                                                            <div class="col l8 offset-l2 m10 offset-m1 s10 offset-s1 center-align text">
                                                                Love is a ruthless game, unless you play it good and right.
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div id="recommend-sections" class="recommend"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 所有文章卡片 -->
                                    <article id="articles" class="container articles">
                                        <div class="row article-row">

                                            <!-- 单个文章 -->
                                            <c:forEach items="${articles}" var="article">
                                                <div class="article col s12 m6 l6 myaos">
                                                    <div class="card">
                                                        <a href="blog.jsp?blogID=<c:out
											value="${article.get('blogID')}"></c:out>">
                                                            <div class="card-image">
                                                                <img src=<c:out value="${article.get('backgroundImg')}"></c:out>
                                                                class="responsive-img" alt=
                                                                <c:out value="${article.get('title')}"></c:out>>
                                                                <span class="card-title"><c:out
											value="${article.get('title')}"></c:out></span>
                                                            </div>
                                                        </a>
                                                        <div class="card-content article-content">
                                                            <div class="summary block-with-text">
                                                                <c:out value="${article.get('content')}" escapeXml="false"></c:out>
                                                            </div>
                                                            <div class="publish-info">
                                                                <span class="publish-date"> <i
										class="far fa-clock fa-fw icon-date"></i> <c:out
											value="${article.get('releaseTime')}"></c:out>
									</span> <span class="publish-author"> <i
										class="fas fa-bookmark fa-fw icon-category"></i> <a
										href="categories.jsp" class="post-category"> <c:out
												value="${article.get('catName')}"></c:out>
									</a>
									</span>
                                                            </div>
                                                        </div>
                                                        <div class="card-action article-tags" style="position: relative;">
        
                                            </a> <img src="./medias/trash.png" onclick=delBlog(<c:out value="${article.get('blogID')}"></c:out>) style="float: right;position: relative; right: 10px; width: 20px; height: 20px; margin-bottom: 10px; cursor: pointer;">
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                            <!-- 单个文章 -->
                                        </div>
                                    </article>

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

                                <script src="./js/myaos.js"></script>
                        </body>

                        </html>
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
	<title>博客页面</title>
	<link rel="icon" type="image/png" href="./favicon.ico">
	<link rel="stylesheet" type="text/css"
		href="./css/awesome/css/all.min.css">
	<link rel="stylesheet" type="text/css"
		href="./css/materialize/materialize.min.css">
	<link rel="stylesheet" type="text/css"
		href="./css/animate/animate.min.css">
	<link rel="stylesheet" type="text/css"
		href="./css/lightGallery/css/lightgallery.min.css">
	<link rel="stylesheet" type="text/css" href="./css/matery.css">
	<link rel="stylesheet" type="text/css" href="./css/my.css">
	<link rel="stylesheet" type="text/css" href="./css/tocbot.css">
	<link rel="stylesheet" type="text/css" href="./css/myaos.css">
	<script src="./js/myaos.js"></script>
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

<%!
String content = null;
int thumbcnt = 0;
%>
<%
String blogID_str = request.getParameter("blogID");
if (blogID_str == null || blogID_str == "") {
	out.write("<script>alert('沒有blogID！');window.location.href='home.jsp';</script>");
	return;
}
int blogID = Integer.parseInt(blogID_str);
Connection conn = null;
try {
	Class.forName("com.mysql.jdbc.Driver");
	String connectionUrl = "jdbc:mysql://localhost:3307/blog20337003?useUnicode=true&characterEncoding=UTF-8";
	conn = DriverManager.getConnection(connectionUrl, "root", "123");
} catch (Exception e) {
	out.write("<script>alert('连接数据库出错！');</script>");
	return;
}
String SQL = String.format("select * from blog natural join users natural join cat where blogID = %d;",
		blogID);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(SQL);
Map<String, String> article = new HashMap<>();
if (rs.next()) {
	article.put("userName", rs.getString("userName"));
	article.put("catName", rs.getString("catName"));
	article.put("title", rs.getString("title"));
	content = rs.getString("content");
	content = content.replace("&lt;", "<");
	content = content.replace("&gt;", ">");
	int wordCnt = content.length();
	String releaseTime = new SimpleDateFormat("yyyy-MM-dd").format(rs.getTimestamp("releaseTime"));
	String backgroundImg = rs.getString("backgroundImg");
	article.put("content", content);
	article.put("releaseTime", releaseTime);
	article.put("wordCnt", Integer.toString(wordCnt));
	article.put("readTime", String.format("%.1f 分钟",(double)wordCnt / 500));
	article.put("backgroundImg", backgroundImg);
	
	rs = stmt.executeQuery(String.format("select count(*) as cnt from likes where blogID=%d;",blogID));
	rs.next();
	thumbcnt = rs.getInt("cnt");
} else {
	out.write("<script>alert('blog不存在！');window.location.href='home.jsp';</script>");
	return;
}
pageContext.setAttribute("article", article);
%>

<%
String userID = "5";
String username = (String)session.getAttribute("userName");
String sql_1 = "select * from users where userName = '" + username + "';";
ResultSet rs_1 = stmt.executeQuery(sql_1);//执行查询，返回结果集
while (rs_1.next()) { //把游标(cursor)移至第一个或下一个记录
	userID = rs_1.getString("userID");
}
rs_1.close();
rs.close();
stmt.close();
conn.close();
%>

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
						<div class="title center-align">阅读博客</div>
						<div class="description center-align">
							Read the Blog
						</div>
					</div>
				</div>
			</div>
			<!-- <div class = "banner-box">
					<div class="slide-box">
						<img src="medias/banner/0.jpg" alt="">
						<img src="medias/banner/1.jpg" alt="">
						<img src="medias/banner/2.jpg" alt="">
						<img src="medias/banner/3.jpg" alt="">
						<img src="medias/banner/4.jpg" alt="">
					</div>
			</div> -->
			<div class="banner-box" style="height:100vh;">
                <div class="slide-box" style="animation:none;height:100vh">
                    <img src=<c:out value="${article.get('backgroundImg')}"></c:out> alt=<c:out value="${article.get('title')}"></c:out> style="height:100vh;">
                </div>
			</div>
		</div>
	</div>

	<main class="content">
		<link rel="stylesheet" href="./css/tocbot.css">
		<style>
#articleContent h1::before, #articleContent h2::before, #articleContent h3::before,
	#articleContent h4::before, #articleContent h5::before, #articleContent h6::before
	{
	display: block;
	content: " ";
	height: 100px;
	margin-top: -100px;
	visibility: hidden;
}

#articleContent :focus {
	outline: none;
}

.toc-fixed {
	position: fixed;
	top: 64px;
}

.toc-widget {
	width: 345px;
	padding-left: 20px;
}

.toc-widget .toc-title {
	padding: 35px 0 15px 17px;
	font-size: 1.5rem;
	font-weight: bold;
	line-height: 1.5rem;
}

.toc-widget ol {
	padding: 0;
	list-style: none;
}

#toc-content {
	padding-bottom: 30px;
	overflow: auto;
}

#toc-content ol {
	padding-left: 10px;
}

#toc-content ol li {
	padding-left: 10px;
}

#toc-content .toc-link:hover {
	color: #4ea7cd;
	font-weight: 700;
	text-decoration: underline;
}

#toc-content .toc-link::before {
	background-color: transparent;
	max-height: 25px;
	position: absolute;
	right: 23.5vw;
	display: block;
}

#toc-content .is-active-link {
	color: #4ea7cd;
}

#floating-toc-btn {
	position: fixed;
	right: 15px;
	bottom: 76px;
	padding-top: 15px;
	margin-bottom: 0;
	z-index: 998;
}

#floating-toc-btn .btn-floating {
	width: 48px;
	height: 48px;
}

#floating-toc-btn .btn-floating i {
	line-height: 48px;
	font-size: 1.4rem;
}

#artDetail {
	text-align: center;
}
</style>
		<div class="row">
			<div  id="main-content"  class="s12 m12">
				<!-- 文章内容详情 -->
				<div id="artDetail" style="width: 70%; margin: auto;" >
					<div class="card">
						<div class="card-content article-info">
							<!-- <div class="row tag-cate"> -->
								<!-- <div class="col s7">
									<div class="article-tag" style="width: 30%; margin: left;">
										<a href="tags.jsp"> <span class="chip bg-color"><c:out
													value="${article.get('tagName')}"></c:out></span>
										</a>
									</div>
								</div> -->
								
							<!-- </div> -->
							<div class="post-info">
								<div class="post-date info-break-policy">
									<i class="far fa-calendar-minus fa-fw"></i>发布日期:&nbsp;&nbsp;
									<c:out value="${article.get('releaseTime')}"></c:out>
								</div>
								<div class="info-break-policy">
									<i class="far fa-file-word fa-fw"></i>博文字数:&nbsp;&nbsp;
									<c:out value="${article.get('wordCnt')}"></c:out>
								</div>
								
								<div class="info-break-policy right">
									<i class="far fa-thumbs-up fa-fw"></i>点赞数:&nbsp;&nbsp;<%=thumbcnt %>
								</div>

							</div>
						</div>
						<hr class="clearfix">
						<div class="card-content article-card-content">
							<div id="articleContent">
								<h2 id="Abstract">
									<a href="#Abstract" class="headerlink" title="Abstract"></a>
									<c:out value="${article.get('title')}"></c:out>
								</h2>
								<div style="text-align: left;">
									<%=content %>
								</div>
							</div>
							<hr />
							<div class="reprint" id="reprint-statement">
								<div class="reprint__author left">
									<span class="reprint-meta" style="font-weight: bold;"> <i
										class="fas fa-user"> 博客作者: </i>
									</span> <span class="reprint-info"> <a 
										rel="external nofollow noreferrer">
                                        <font size='4px' color = '#4ea7cd'>
                                        <c:out
												value="${article.get('userName')}"></c:out></a>
                                        </font>
									</span>
								</div>
								<div class="col s5 right">
									<div class="post-cate">
										<i class="fas fa-bookmark fa-fw icon-category"></i> <a
											href="categories.jsp" class="post-category"> <c:out
												value="${article.get('catName')}"></c:out>
										</a>
                                        <script type="text/javascript">
            function likeit(userID, blogID) {
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function () {
                    if (xmlhttp.readyState == 4) {
                    alert(xmlhttp.responseText);
                    if (xmlhttp.status == 200) {
                        location.reload();
                    }
                    }
                };
                xmlhttp.open("get", "like.jsp?blogid=" + blogID + "&userid=" + userID, true);
                xmlhttp.send(null);
            }
        </script>
		<button class="post-category" type='button'
			onclick="likeit(<%out.print(userID); %>, <%out.print(blogID); %>)" style="border:none;background:none">
			<img src="./medias/thumb.png"
				style="width: 20px; height: 20px; position: relative;cursor:pointer">
		</button>
									</div>
                                    
								</div>
        

							</div>
						</div>
					</div>
				</div>
			</div>
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

</html>
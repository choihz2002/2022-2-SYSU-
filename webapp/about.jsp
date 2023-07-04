<%@ page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
        <% request.setCharacterEncoding("utf-8");
    String msg = "";
    String result = "";
    String username = null;
    String userAvatar = null;
    String userID = null;
    String motto = null;
    String table = "";
    int articleNum = 0;
    int catNum = 0;
    String[] color = {"#FF0066 0%, #FF00CC 100%","#9900FF 0%, #CC66FF 100%","#2196F3 0%, #42A5F5 100%","#00BCD4 0%, #80DEEA 100%","#4CAF50 0%, #81C784 100%","#FFEB3B 0%, #FFF176 100%"};
    ArrayList<String> catlist = new ArrayList<String>();
    ArrayList<Integer> catlistNum = new ArrayList<Integer>();
    ArrayList<String> piclist = new ArrayList<String>();
    username = (String)session.getAttribute("userName");
    String conStr = "jdbc:mysql://localhost:3307/blog20337003" + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
	try {
    	Class.forName("com.mysql.jdbc.Driver"); // 查找数据库驱动类
    	Connection con=DriverManager.getConnection(conStr, "root", "123");
    	Statement stmt = con.createStatement(); // 创建MySQL语句的对象
    	//用户头像路径，座右铭及特有ID
    	String sql_1 = "select * from users where userName = '"+ username +"';";
    	ResultSet rs_1 = stmt.executeQuery(sql_1);//执行查询，返回结果集
    	while(rs_1.next()) { //把游标(cursor)移至第一个或下一个记录
    		userAvatar = rs_1.getString("userAvatar");
    		motto = rs_1.getString("motto");
    		userID = rs_1.getString("userID");
    	}
    	//用户博文数量
    	String sql_2 = "select count(blogID) from blog where userID = "+ userID +";";
    	ResultSet rs_2 = stmt.executeQuery(sql_2);//执行查询，返回结果集
    	while(rs_2.next()) { //把游标(cursor)移至第一个或下一个记录
    		articleNum = rs_2.getInt("count(blogID)");
    	}
        //用户分类数量
    	String sql_3 = "select count(catID) from cat where userID = "+ userID +";";
    	ResultSet rs_3 = stmt.executeQuery(sql_3);//执行查询，返回结果集
    	while(rs_3.next()) { //把游标(cursor)移至第一个或下一个记录
    		catNum = rs_3.getInt("count(catID)");
    	}
    	
    	//技术分布
    	String sql_5 = "select catName,count(catName) from cat where userID = "+ userID +" group by catName;";
    	ResultSet rs_5 = stmt.executeQuery(sql_5);//执行查询，返回结果集
    	while(rs_5.next()) { //把游标(cursor)移至第一个或下一个记录
    		catlist.add(rs_5.getString("catName"));
    		catlistNum.add(rs_5.getInt("count(catName)"));
    	}

    	String sql_8 = "select content from pic where userID = "+ userID +";";
    	ResultSet rs_8=stmt.executeQuery(sql_8);//执行查询，返回结果集
    	while(rs_8.next()) { //把游标(cursor)移至第一个或下一个记录
    		piclist.add(rs_8.getString("content"));
    	}
	    	
    	rs_1.close(); 
    	rs_2.close();
    	rs_3.close(); 
    	//<!-- rs_4.close(); -->
    	rs_5.close(); 
    	//<!-- rs_6.close(); -->
    	rs_8.close();
    	
    	stmt.close(); con.close();
	}
    catch (Exception e){
    	msg = e.getMessage();
    }
%>
            <!DOCTYPE HTML>
            <html lang="zh-CN">


            <head>
                <meta charset="utf-8">

                <title>About | UserName</title>
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
                                    <div class="title center-align">
                                        个人主页
                                    </div>
                                    <div class="description center-align">
                                        Personal Profile
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

                <main class="content">

                    <div id="aboutme" class="container about-container">
                        <div class="card">
                            <div class="card-content">
                                <div class="row">
                                    <div class="post-statis col l4 hide-on-med-and-down">

                                        <div class="statis">
                                            <span class="count"><a href="home.jsp"><% out.print(articleNum); %></a></span>
                                            <span class="name">博客</span>
                                        </div>

                                    </div>
                                    <div class="col s12 m12 l4">
                                        <div class="profile center-align">
                                            <div class="avatar">
                                                <img src="<%
                                    out.print(userAvatar);
                                    %>" alt="<%out.print(username); %>" class="circle responsive-img avatar-img">
                                            </div>
                                            <div class="author">
                                                <div class="post-statis hide-on-large-only">

                                                    <div class="statis">
                                                        <span class="count"><a href="home.jsp"><% out.print(articleNum); %></a></span>
                                                        <span class="name">博客</span>
                                                    </div>



                                                    <div class="statis">
                                                        <span class="count"><a href="categories.jsp"><% out.print(catNum); %></a></span>
                                                        <span class="name">分类</span>
                                                    </div>

                                                </div>
                                                <div class="title">
                                                    <% out.print(username); %>
                                                </div>
                                                <!-- <div class="career">Software Engineer</div> -->
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="introduction center-align">
                                    <% out.print(motto); %>
                                </div>

                                <style type="text/css">
                                    #posts-chart,
                                    #categories-chart,
                                    #tags-chart {
                                        width: 100%;
                                        height: 300px;
                                        margin: 0.5rem auto;
                                        padding: 0.5rem;
                                    }
                                </style>

                                <div class="my-skills">
                                    <div class="title center-align">
                                        <i class="fas fa-wrench"></i>&nbsp;&nbsp;博客分类
                                    </div>
                                    <div class="row">
                                        <%for (int i=0;i<=catlistNum.size()-1;i++){%>
                                            <div class="col s12 m6 l6">
                                                <div class="skillbar">
                                                    <div class="skillbar-title" style="background: linear-gradient(to right, <%out.print(color[i%6]); %>); width: <%out.print((int)(1.0*catlistNum.get(i)/catNum*100)*0.5+50);%>%">
                                                        <span><%out.print(catlist.get(i));%></span>
                                                    </div>
                                                    <div class="skill-bar-percent">
                                                        <%if(catNum == 0){%>
                                                            <%out.print(0);%>%
                                                                <%}%>
                                                                    <%if(catNum != 0){%>
                                                                        <%out.print((int)(1.0*catlistNum.get(i)/catNum*100));%>%
                                                                            <%}%>
                                                    </div>
                                                </div>
                                            </div>
                                            <%}%>
                                    </div>
                                </div>

                                <div id="myGallery" class="my-gallery">
                                    <div class="title center-align">
                                        <i class="far fa-image"></i>&nbsp;&nbsp;个人相册
                                    </div>
                                    <div class="row">

                                        <%for(int i=0;i<=piclist.size()-1;i++){ %>
                                            <div class="photo col s12 m6 l4 myaos">
                                                <div class="img-item" data-src="<%out.print(piclist.get(i));%>">
                                                    <img src="<%out.print(piclist.get(i));%>" class="responsive-img">
                                                </div>

                                            </div>
                                            <%} %>
                                    </div>
                                </div>

                                <script>
                                    $(function() {
                                        let animateClass = 'animated pulse';
                                        $('#myGallery .photo').hover(function() {
                                            $(this).addClass(animateClass);
                                        }, function() {
                                            $(this).removeClass(animateClass);
                                        });
                                    });
                                </script>
                            </div>
                        </div>
                    </div>
                </main>

                <footer class="page-footer bg-color">
                    <!-- <div id="toTopButton" style="position: fixed;right: 10px;bottom:10px;cursor: pointer;display: none;" onclick="returnToTop()">
                        <img src="./medias/arrow.png" style="width: 40px;height: 40px; ">
                        <script>
                            function returnToTop() {
                                document.body.scrollTop = 0;
                                document.documentElement.scrollTop = 0;
                            }
                        </script>
                    </div> -->
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
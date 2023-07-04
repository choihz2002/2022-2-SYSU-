<%@ page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
        <% request.setCharacterEncoding("utf-8");
    String msg = "";
    String result = "";
    String userID = null;
   	String username = "";



    ArrayList<String> userNameList = new ArrayList<String>();
    ArrayList<String> userAvatarList = new ArrayList<String>();
    ArrayList<String> mottoList = new ArrayList<String>();
    ArrayList<String> homePageList = new ArrayList<String>();
    
    ArrayList<String> userNameList2 = new ArrayList<String>();
    ArrayList<String> userAvatarList2 = new ArrayList<String>();
    ArrayList<String> mottoList2 = new ArrayList<String>();
    ArrayList<String> homePageList2 = new ArrayList<String>();
    
    username = (String)session.getAttribute("userName");
    String conStr = "jdbc:mysql://localhost:3307/blog20337003" + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
	try {
    	Class.forName("com.mysql.jdbc.Driver"); // 查找数据库驱动类
    	Connection con=DriverManager.getConnection(conStr, "root", "123");
    	Statement stmt = con.createStatement(); // 创建MySQL语句的对象
    	//用户头像路径，座右铭及特有ID
    	
    	
    	String sql_2 = "select userName,userAvatar,motto,homePage from users where userName <> '"+username+"';";
    	ResultSet rs_2 = stmt.executeQuery(sql_2);//执行查询，返回结果集
    	while (rs_2.next()) {	
    		//rs_2.next();
    		userNameList2.add(rs_2.getString("userName"));		
    		userAvatarList2.add(rs_2.getString("userAvatar"));
    		mottoList2.add(rs_2.getString("motto"));
    		homePageList2.add(rs_2.getString("homePage"));
    	}
    	rs_2.close(); 	
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

                <title>好友列表</title>
                <link rel="icon" type="image/png" href="favicon.ico">
                <link rel="stylesheet" type="text/css" href="./css/awesome/css/all.min.css">
                <link rel="stylesheet" type="text/css" href="./css/materialize/materialize.min.css">
                <link rel="stylesheet" type="text/css" href="./css/animate/animate.min.css">
                <link rel="stylesheet" type="text/css" href="./css/lightGallery/css/lightgallery.min.css">
                <link rel="stylesheet" type="text/css" href="./css/matery.css">
                <link rel="stylesheet" type="text/css" href="./css/my.css">
                <link rel="stylesheet" type="text/css" href="./css/main.css">
                <link rel="stylesheet" type="text/css" href="./css/myaos.css">
                <link rel="stylesheet" type="text/css" href="./css/myfriends.css" />
                <link rel="alternate" href="atom.xml" title="UserName" type="application/atom+xml">
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
                                        我的好友
                                    </div>
                                    <div class="description center-align">
                                        My Friends
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

                <main class="content" style="margin-bottom: 200px;">
                    <div class="container friends-container">
                        <div class="card">
                            <div class="card-content">
                                <div class="tag-title center-align">
                                    <i class="fas fa-address-book"></i>&nbsp;&nbsp;社区
                                </div>

                                <!-- 从这里开始改 -->
                                <div class="row tags-posts friend-all">

                                    
                                    	<%for (int i=0; i<userAvatarList2.size(); ++i){%>
                                        <div class="col s12 m6 l4 friend-div">
                                            <div class="frind-card1 card myaos">
                                                <div class="frind-ship">
                                                    <div class="title">
                                                        <img src="<%out.print(userAvatarList2.get(i));%>" alt="img">
                                                        <div>
                                                            <h1 class="friend-name">
                                                                <%out.print(userNameList2.get(i)); %>
                                                            </h1>
                                                            <p style="position: relative;top: -35px;">
                                                                <%out.print(mottoList2.get(i).substring(0, Math.min(10, mottoList2.get(i).length()))+(mottoList2.get(i).length()>10?"...":"")); %>
                                                            </p>
                                                        </div>
                                                    </div>
                                                    <div class="friend-button">
                                                        <a href="<%out.print(homePageList2.get(i)); %>" target="_blank" class="button button-glow button-rounded button-caution">访问主页</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
							 			<%}%>
                                       

                                            

                                </div>

                                </article>
                            </div>
                        </div>

                        <div class="card">


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
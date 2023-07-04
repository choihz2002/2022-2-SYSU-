<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ page import="java.io.*,java.util.*,java.util.Random.*"%>
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
                            <link rel="stylesheet" type="text/css" href="./css/matery.css">
                            <link rel="stylesheet" type="text/css" href="./css/my.css">
                            <link rel="stylesheet" type="text/css" href="./css/main.css">
                            <link rel="stylesheet" type="text/css" href="./css/myaos.css">
                            <link rel="stylesheet" type="text/css" href="./css/meChart.css" />
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
String SQL = "select blogID,title,content,releaseTime,backgroundImg,catName from blog natural join users natural join cat;";
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
/////////////////////////////////////////////////////////////////////////////////////////
String msg = "";
String result = "";
String username = null;
String userAvatar = null;
String userID = null;
String motto = null;
String table = "";
String albumID = "";
int articleNum = 0;
int catNum = 0;
String[] color = {"#FF0066 0%, #FF00CC 100%","#9900FF 0%, #CC66FF 100%","#2196F3 0%, #42A5F5 100%","#00BCD4 0%, #80DEEA 100%","#4CAF50 0%, #81C784 100%","#FFEB3B 0%, #FFF176 100%"};
ArrayList<String> catlist = new ArrayList<String>();
ArrayList<Integer> catlistNum = new ArrayList<Integer>();
ArrayList<Integer> catcount = new ArrayList<Integer>();
String[] initcatcolor = {"#dffffa","#dffeff","#dff5ff","#dfecff","#dfe5ff", "rgb(150, 249, 147)"};
ArrayList<String> catcolor = new ArrayList<String>();
for (int i=0; i<initcatcolor.length; i++)
	catcolor.add(initcatcolor[i]);
ArrayList<String> piclist = new ArrayList<String>();
username = (String)session.getAttribute("userName");
String conStr = "jdbc:mysql://localhost:3307/blog20337003" + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
List<Map<String, String>> ttags = new ArrayList<>();
try {
	Class.forName("com.mysql.jdbc.Driver"); // 查找数据库驱动类
	Connection con=DriverManager.getConnection(conStr, "root", "123");
	stmt = con.createStatement(); // 创建MySQL语句的对象
	/* 1.拿到userID */
	//用户头像路径，座右铭及特有ID
	String sql_1 = "select * from users where userName = '"+ username +"';";
	ResultSet rs_1 = stmt.executeQuery(sql_1);//执行查询，返回结果集
	while(rs_1.next()) { //把游标(cursor)移至第一个或下一个记录
		userAvatar = rs_1.getString("userAvatar");
		motto = rs_1.getString("motto");
		userID = rs_1.getString("userID");
	}
	/* 2.统计出类别的数量和每个类别的名称、博客数 */
	//用户标签数量
	String sql_4;
	if (username.equals("admin") || username.equals("tourist"))
		sql_4 = "select count(distinct catName) from cat;";
	else
		sql_4 = "select count(distinct catName) from cat where userID = " + userID + ";";
	ResultSet rs_4 = stmt.executeQuery(sql_4);//执行查询，返回结果集
	while(rs_4.next()) { //把游标(cursor)移至第一个或下一个记录
		catNum = rs_4.getInt("count(distinct catName)");
	}
	Random random = new Random();
	while (catcolor.size() < catNum) {
        int r = random.nextInt(256);
        int g = random.nextInt(256);
        int b = random.nextInt(256);
        catcolor.add(String.format("rgb(%d, %d, %d)", r, g, b));
	}
	//博客标签内容
	String sql_6;
	if (username.equals("admin") || username.equals("tourist"))
		sql_6 = "select distinct catName from cat;";
	else
		sql_6 = "select distinct catName from cat where userID = " + userID + ";";
	ResultSet rs_6 = stmt.executeQuery(sql_6);//执行查询，返回结果集
	while(rs_6.next()) { //把游标(cursor)移至第一个或下一个记录
		catlist.add(rs_6.getString("catName"));
	}
	// 每个标签的次数
	String sql_2;
	for (int i=0; i<catlist.size(); i++) {
		if (username.equals("admin") || username.equals("tourist"))
	sql_2 = "select count(*) from cat where catName = '" + catlist.get(i) + "';";
		else
	sql_2 = "select count(*) from cat where userID = " + userID + " and catName = '" + catlist.get(i) + "';";
		ResultSet rs_2 = stmt.executeQuery(sql_2);//执行查询，返回结果集
		while(rs_2.next()) { //把游标(cursor)移至第一个或下一个记录
			catcount.add(rs_2.getInt("count(*)"));
		}
		rs_2.close();
	}
    	
	rs_1.close(); 
	rs_4.close();
	rs_6.close();
	
	stmt.close(); con.close();
}
catch (Exception e){
	msg = e.getMessage();
}
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
                                    <div id="category-cloud" class="container chip-container">
                                        <div class="card">
                                            <div class="card-content">
                                                <div class="tag-title center-align">
                                                    <i class="fas fa-bookmark"></i>&nbsp;&nbsp;博客分类
                                                </div>
                                                <div class="tag-chips">
                                                    <%for (int i=0;i<=catNum-1;i++){%>
                                                        <a href="chooseCat.jsp?catName=<%out.print(catlist.get(i)); %>"  
                                                            title="<%out.print(catlist.get(i)); %>:<%out.print(catcount.get(i)); %>">
                                                            <span class="chip center-align waves-effect waves-light
                                                            chip-default " data-tagname="<%out.print(catlist.get(i)); %>" style="background-color: <%out.print(catcolor.get(i)); %>;"><%out.print(catlist.get(i)); %>
                                                        <span class="tag-length"><%out.print(catcount.get(i)); %></span>
                                                            </span>
                                                        </a>
                                                        <%}%>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <style type="text/css">
                                        #category-radar {
                                            width: 100%;
                                            height: 360px;
                                        }
                                        
                                        #category-radar img {
                                            margin: 0 auto;
                                            text-align: center;
                                        }
                                    </style>

                                    <div class="container">
                                        <div class="card">
                                            <div class="myaos" style="margin-left: 28%;">
                                                <canvas id="curve" width="500" height="300">
					<script>
						var thislabels = [];
						<%for(int i=0;i<catlist.size();i++){%>
							thislabels.push("<%=catlist.get(i)%>");
						<%}%>	
						var thisvalues = [];
						<%for(int i=0;i<catcount.size();i++){%>
							thisvalues.push(<%=catcount.get(i)%>);
						<%}%>	
						var len = <%=catNum%>;
						window.onload = function() {
							var bg = document.getElementById("curve");
							linedata = {
								labels: thislabels,//标签
								datas: thisvalues,//数据
								xTitle: "分类",//x轴标题
								yTitle: "博客数量",//y轴标题
                                
								ctxSets:{
									strokeColor:"#C0C0C0",//背景线颜色
									lineWidth:1,//线的宽度
									txtColor:"#000000",//绘制文本颜色
									txtFont:"12px microsoft yahei",//字体
									txtAlign:"center",//对齐方式
									txtBase:"middle",//基线
									lineColor:"rgb(163, 217, 255)",//折线颜色
									circleColor: "blue",
								},
							};
							setBg(bg,linedata);//绘制图标背景及折线
						}
					</script>
					</canvas>
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

                                <script src="./js/myaos.js"></script>
                                <script type="text/javascript" src="./js/meChart.js"></script>

                            </body>

                        </html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="org.apache.commons.io.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page trimDirectiveWhitespaces="true"%>
<!DOCTYPE HTML>
<html lang="zh-CN">

<head>
	<meta charset="utf-8">
	<title>写博文</title>
	<link rel="icon" type="image/png" href="./favicon.ico">
	<link rel="stylesheet" type="text/css" href="./css/awesome/css/all.min.css">
	<link rel="stylesheet" type="text/css" href="./css/materialize/materialize.min.css">
	<link rel="stylesheet" type="text/css" href="./css/animate/animate.min.css">
	<link rel="stylesheet" type="text/css" href="./css/lightGallery/css/lightgallery.min.css">
	<link rel="stylesheet" type="text/css" href="./css/matery.css">
	<link rel="stylesheet" type="text/css" href="./css/skin.css">
	<link rel="stylesheet" type="text/css" href="./css/my.css">
	<link rel="stylesheet" type="text/css" href="./css/blog.css">
	<link rel="stylesheet" type="text/css" href="./css/myaos.css">
	<!--  <link rel="stylesheet" href="./css/login.css"> -->
	<script src="./js/myaos.js"></script>
	<link href="./css/layui.css" rel="stylesheet" />
    <link href="./css/global.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="./plug/layui/css/layui.css" />
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

<style>
	select {
		display: block !important;
	}

</style>
<script type="text/javascript">
	function check() {
		var cat = document.getElementById("cat").value.replace(' ', '');
		var title = document.getElementById("title").value;
		var blogcontent = document.getElementById("richedit").innerHTML;
		// 过滤script标签
	    blogcontent = blogcontent.replace(/&lt;\s*\/?script\s*&gt;/g, '');
	    // 过滤属性值javascript:开头
	    blogcontent = blogcontent.replace(/javascript:[^'"]*/g, '');
	    // 过滤onerror属性
	    blogcontent = blogcontent.replace(/onerror\s*=\s*['"]?[^'"]*['"]/g, '');
		document.getElementById("mytextarea").value = blogcontent;
		if(cat.length > 20){
			alert("分类或标签的长度不能大于20！");
			return false;
		}
		return true;
	}
	function italic() {
		document.execCommand("italic", false, null);
	}
	function color() {
		document.execCommand("foreColor", false, "red");
	}
	function fontSize() {
		document.execCommand("fontSize", false, 7);
	}
	function image() {
		document.execCommand("insertImage", false, "images/home.gif");
	}
	function link() {
		document.execCommand("createLink", false, " ");
	}
	function undo() {
		document.execCommand("undo", false, null);
	}
	function code() {
		var richedit = document.getElementById("richedit");
		alert(richedit.innerHTML);
	}
	function delete_line() {
		document.execCommand("StrikeThrough", false, "");
	}
	function Underline() {
		document.execCommand("Underline", false, "");
	}
	function JustifyLeft() {//居左
		document.execCommand("JustifyLeft", false, "");
	}
	function JustifyRight() {//居右
		document.execCommand("JustifyRight", false, "");
	}
	function JustifyCenter() {//居中
		document.execCommand("JustifyCenter", false, "");
	}
</script>

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
		if (uname == "tourist") {
			out.write("<script>alert('游客不能发博文，请先登录');window.location.href='home.jsp';</script>");
			return;
		}
		Connection connS = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String connectionUrl = "jdbc:mysql://localhost:3307/blog20337003?useUnicode=true&characterEncoding=UTF-8";
			connS = DriverManager.getConnection(connectionUrl, "root", "123");
			Statement stmtS = connS.createStatement();
			ResultSet rsS = stmtS.executeQuery(String.format("select speechStatus from users where userName = \"%s\"",uname));
			rsS.next();
			int status = rsS.getInt("speechStatus");
			rsS.close();
			stmtS.close();
			connS.close();
			if(status == 0){
				out.write("<script>alert('你已被禁言！');window.location.href='home.jsp';</script>");
				return;
			}
		} catch (Exception e) {
			out.write("<script>alert('数据库出错，打开页面失败');window.location.href='home.jsp';</script>");
			return;
		}
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
						<div class="title center-align">发布博客</div>
						<div class="description center-align">
							Post a blog
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
	request.setCharacterEncoding("utf-8");
	if (request.getMethod().equalsIgnoreCase("post")) {
		String cat = null, title = null, body = null;
		String uid = session.getAttribute("userID").toString();
		String imgUrl = null;
		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		List items = upload.parseRequest(request);
		for (int i = 0; i < items.size(); i++) {
			FileItem fi = (FileItem) items.get(i);
			if (fi.isFormField()) {
		if (fi.getFieldName().equals("Cat"))
			cat = fi.getString("utf-8");
		if (fi.getFieldName().equals("Title"))
			title = fi.getString("utf-8");
		if (fi.getFieldName().equals("Body")) {
			body = fi.getString("utf-8");
			body = body.replace("<", "&lt");
			body = body.replace(">", "&gt");
		}
			} else {
		DiskFileItem dfi = (DiskFileItem) fi;
		String fileName = FilenameUtils.getName(dfi.getName());
		fileName = fileName.replace(" ", "");
		if (!fileName.trim().equals("")) {
			String path = application.getRealPath("");
			String sep = System.getProperty("file.separator");
			String dirToSave = path + "medias" + sep + "userbk" + sep;
			if (!(new File(dirToSave).isDirectory())) {//如果文件夹不存在
				new File(dirToSave).mkdir();
			}
			String uniFileName = System.currentTimeMillis() + fileName;
			dfi.write(new File(dirToSave + uniFileName));
			imgUrl = "medias/userbk/" + uniFileName;
		}
			}
		}
		if (imgUrl == null)
			imgUrl = "medias/featureimages/" + (int) (Math.random() * 24) + ".jpg";
		Connection conn = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String connectionUrl = "jdbc:mysql://localhost:3307/blog20337003?useUnicode=true&characterEncoding=UTF-8";
			conn = DriverManager.getConnection(connectionUrl, "root", "123");
			conn.setAutoCommit(false);
			Statement stmt = conn.createStatement();
			stmt.executeUpdate(String.format("insert into cat(userID,catName) values(%s,\"%s\");", uid, cat));
			stmt.executeQuery(
			String.format("select max(catID) from cat where userID=%s and catName=\"%s\" into @cid;", uid, cat));
			stmt.executeUpdate(String.format(
			"insert into blog(userID,catID,title,content,backgroundImg) values(%s, @cid, \"%s\",\"%s\",\"%s\");",
			uid, title, body, imgUrl));
			stmt.executeUpdate(String.format("insert into pic(userID,content) values(\"%s\",\"%s\");", uid, imgUrl));
			conn.commit();
			out.write("<script>alert('发布博文成功！');window.location.href='home.jsp';</script>");
			stmt.close();
			conn.close();
		} catch (Exception e) {
			if (conn != null)
		conn.rollback();
			out.write("<script>alert('提交失败！');</script>");
		}
	}
	%>
	<main class="content">
		<div id="aboutme" class="container about-container">
			<div class="card">
				<br><br><br>
				<form action="" method="post" enctype="multipart/form-data">
					<div class="input-group" style="width: 80%; margin: auto; display: block !important;">
						<div class="blog-module shadow" style="box-shadow: 0 1px 8px #a6a6a6;">
                            <div class="form-row">
								<div class="name">标题</div>
								<div class="value">
									<div class="input-group">
										<input id="title" class="input--style-6" type="text" name="Title" placeholder="请输入标题" required="required">
									</div>
								</div>
							</div>
							<br>
                            <div class="form-row">
								<div class="name">分类</div>
                                <div class="value">
                                    <select name="Cat" class="input--style-6">
                                        <option values="生活分享">生活分享</option>
                                        <option values="学习相关">学习相关</option>
                                        <option values="兴趣爱好">兴趣爱好</option>
                                        <option values="求助咨询">求助咨询</option>
                                        <option values="交易市场">交易市场</option>
                                    </select>
                                </div>
								<!-- <div class="value">
									<div class="input-group">
										<input id="cat" class="input--style-6" type="text" name="Cat" placeholder="请输入分类" required="required">
									</div>
								</div> -->
							</div>
							<br>
							<div class="form-row">
                                <div class="name">正文</div>
                                <div class="layui-layedit">
                                    
                                    <div class="layui-unselect layui-layedit-tool">
                                        <i class="layui-icon " title="表情" onclick="return undo();">&#xe603;</i>
                                        <span class=" layedit-tool-mid"></span>
                                            <i class=" layui-icon layedit-tool-b" title="加粗" lay-command="Bold" layedit-event="b"" onclick="return fontSize();">&#xe62b;</i>    
                                                <i class=" layui-icon layedit-tool-i" title="斜体" lay-command="italic" layedit-event="i"" onclick="return italic();">&#xe644;</i>
                                        
                                                    <i class=" layui-icon layedit-tool-u" title="下划线" lay-command="underline" layedit-event="u"" onclick="return Underline();">&#xe646;</i>
                                        
                                                        <i class=" layui-icon layedit-tool-d" title="删除线" lay-command="strikeThrough"
                                                            layedit-event="d"" onclick="return delete_line()">&#xe64f;</i>
                                        <span class=" layedit-tool-mid"></span>
                                                    <i class="layui-icon layedit-tool-left" title="左对齐" lay-command="justifyLeft"
                                        layedit-event="left" "="" onclick="return JustifyLeft()"></i>
                        <i class=" layui-icon layedit-tool-center" title="居中对齐" lay-command="justifyCenter"
                                        layedit-event="center" "="" onclick="return JustifyCenter()"></i>
                        <i class=" layui-icon layedit-tool-right" title="右对齐" lay-command="justifyRight"
                                        layedit-event="right" "="" onclick="return JustifyRight()"></i>
                                                            
                                                            
                                        <span class=" layedit-tool-mid"></span>
                                                <i class="layui-icon layedit-tool-link" title="插入链接" layedit-event="link" "="" onclick="return code();"></i>
                                                </div>
                                                <textarea id="mytextarea" style="display:none" name="Body" ></textarea>
                                                <div class=" layui-layedit-iframe" contenteditable="true" id="richedit" style="overflow:auto;padding:10px;width:100%;height:200px;">
                                                    
                                    </div>
                                </div>
                            </div>
							<br>
							<br>
							<div class="a-upload" style="color: gray;">
                                
								<input type="file" name="fileToUpload" id="file" accept="image/*"><div style="position:relative;left:2	px;top:-15px;pointer-events:none">上传本地图片</div>
							</div>
							
							<br>
							<br>
							<button class="sub" type="submit" onclick="return check()">
								<div style="position:relative;left:2px;top:-15px;">
									发布</div>
							</button>
					    </div>
						
					</div>
				</form>
				<br>
				
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
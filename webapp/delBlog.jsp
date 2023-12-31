<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page trimDirectiveWhitespaces="true"%>

<%
Connection conn = null;
try {
	int blogID = Integer.parseInt(request.getParameter("blogID"));
	Class.forName("com.mysql.jdbc.Driver");
	String connectionUrl = "jdbc:mysql://localhost:3307/blog20337003?useUnicode=true&characterEncoding=UTF-8";
	conn = DriverManager.getConnection(connectionUrl, "root", "123");
	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery(String.format("select userID from blog where blogID=%d;", blogID));
	rs.next();
	String bloguid = Integer.toString(rs.getInt("userID"));
	String myuid = session.getAttribute("userID").toString();
	String myname = session.getAttribute("userName").toString();
	if (!myname.equals("admin") && !myuid.equals(bloguid)) {
		conn.close();
		conn = null;
		throw new Exception("删除失败，无法删除他人的博客！");
	}
	conn.setAutoCommit(false);
	stmt.executeQuery(String.format("select catID from blog where blogID=%d into @cid;", blogID));
	stmt.executeUpdate(String.format("delete from blog where blogID = %d;", blogID));
	stmt.executeUpdate(String.format("delete from cat where catID = @cid;"));
	conn.commit();
	out.println("删除成功！");
	response.setStatus(200);
	stmt.close();
	conn.close();
} catch (Exception e) {
	if (conn != null)
		conn.rollback();
	out.println("删除失败！");
	response.setStatus(404);
	out.println(e.getMessage());
}
%>
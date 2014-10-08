<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="model.TargetAdvertisement"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<link rel="stylesheet" href="Style.css">
<body>
	<%
	try{
		String url = "jdbc:mysql://cs336-36.cs.rutgers.edu:3306/proj2014";
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver").newInstance();

		//Create a connection to your DB
		Connection con = DriverManager.getConnection(url, "csuser",
				"cs99f4c8");

		//Create a SQL statement
		Statement stmt = con.createStatement();
		String delete = "Delete from Message where messageID = " + request.getParameter("messageID"); 
		int num = stmt.executeUpdate(delete);
		if (num != 1) {
			%>
			<h2>Unable to Delete Message</h2>
			<button type="button" onclick="location.href='GoHome.jsp'">OK</button>
		<%
		}
		%>
			<jsp:forward page="GoHome.jsp">
				<jsp:param name="success" value="success" />
			</jsp:forward>
		<%
	}catch(SQLException e){
		
	}
	%>
</body>
</html>
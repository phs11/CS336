<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<%
	try { //Create a connection string

		String url = "jdbc:mysql://cs336-36.cs.rutgers.edu:3306/proj2014";
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver").newInstance();

		//Create a connection to your DB
		Connection con = DriverManager.getConnection(url, "csuser",
				"cs99f4c8");

		Statement stmt = con.createStatement();
		//Create a SQL statement
		String adID = request.getParameter("ad");
		int num = stmt.executeUpdate("Delete from Advertisement WHERE AD_ID= " + adID);
		if (num != 1) {
			out.println("error on update");
		}

		out.println("Update complete");
		con.close();
%>

<jsp:forward page="ManageAds.jsp">
	<jsp:param name="success" value="success" />
</jsp:forward>
<%
	} catch (Exception e) {
		System.out.print("Exception: " + e.getLocalizedMessage());
		%>

		<jsp:forward page="ManageAds.jsp">
			<jsp:param name="success" value="success" />
		</jsp:forward>
		<%
	}
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<%

String userName = session.getAttribute("userName").toString();
try{
	
	String url = "jdbc:mysql://cs336-36.cs.rutgers.edu:3306/proj2014";
	//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
	Class.forName("com.mysql.jdbc.Driver").newInstance();

	//Create a connection to your DB
	Connection con = DriverManager.getConnection(url, "csuser",
			"cs99f4c8");

	//Create a SQL statement
	Statement stmt = con.createStatement();
	
	String newBio = request.getParameter("bio");
	String newUrl = request.getParameter("profilePicUrl");
	
	
	//Make a SELECT query from the table specified by the 'command' parameter at the HelloWorld.jsp
	String str = "UPDATE User SET bio='"+newBio+"', profilePicUrl='"+newUrl+"' WHERE username = '" +  session.getAttribute("userName") + "'";
	
	System.out.println(str);

			//Run the query against the database.
	int result = stmt.executeUpdate(str);
			
	
	
	con.close();
	
}catch(SQLException e)
{
	System.out.println("EXCEPTION LINE 147");
	System.out.println("error-" + e.getMessage());
}catch(InstantiationException e)
{
	System.out.println("Exception Line 151- Instantiation");
}
	%>
	<jsp:forward page="GoHome.jsp">
		<jsp:param name="userName" value="<%=userName %>" />
	</jsp:forward>
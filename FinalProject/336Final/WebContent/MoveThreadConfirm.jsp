<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

   <% 
   		
   		
   		String threadID = request.getParameter("threadID");
   		String topicName = request.getParameter("topicName").replace("'","''");
   		
   		try{
   		
   		
   		String url = "jdbc:mysql://cs336-36.cs.rutgers.edu:3306/proj2014";
   		
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver").newInstance();

		//Create a connection to your DB
		Connection con = DriverManager.getConnection(url, "csuser",
				"cs99f4c8");

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
			
			String str = "UPDATE Thread T SET T.topicName = '" + topicName +"' WHERE T.threadID = '" + threadID + "'";
			System.out.println(str);
			stmt.executeUpdate(str);

		
   		}catch(Exception e)
   		{
   			System.out.println("Exception caught in EditPostConfirm.jsp "+e.getMessage());
   		}
   
   	//redirect back to Thread.jsp
		
		%>
		
		<jsp:forward page="Topics.jsp"/>
	
		
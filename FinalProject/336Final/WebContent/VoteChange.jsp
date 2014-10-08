<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="model.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

   <% 
   		String postID = (String)request.getParameter("postID");
   		String threadID =(String)request.getParameter("threadID");
   		String sort = (String)request.getParameter("sort");
   		System.out.println(postID);

   		
   		try{
   		
   		
   		
   		
   		String url = "jdbc:mysql://cs336-36.cs.rutgers.edu:3306/proj2014";
   		
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver").newInstance();

		//Create a connection to your DB
		Connection con = DriverManager.getConnection(url, "csuser",
				"cs99f4c8");

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String str = null;
		
		//this is a thread vote
		String topicName = (String)session.getAttribute("topicName");
		if(postID == null)
		{
		if(request.getParameter("direction").equals("up"))
			//Make a SELECT query from the table specified by the 'command' parameter at the HelloWorld.jsp
			str = "UPDATE Thread T SET T.votes = T.votes + 1 WHERE T.threadID = '" + threadID + "'";
			else
			str = "UPDATE Thread T SET T.votes = T.votes - 1 WHERE T.threadID = '" + threadID + "'";
			
			System.out.println(str);
		
			stmt.executeUpdate(str);
			
			%>
			
			<jsp:forward page="IndividualTopic.jsp">
			<jsp:param name= "topicName" value="<%=topicName%>"/>
			<jsp:param value="<%=sort%>" name="sort"/>
			</jsp:forward>
			
			<%
			
		}
		else//a post vote
		{
		
		if(request.getParameter("direction").equals("up"))
		//Make a SELECT query from the table specified by the 'command' parameter at the HelloWorld.jsp
		str = "UPDATE Post P SET P.votes = P.votes + 1 WHERE P.postID = '" + postID + "'";
		else
		str = "UPDATE Post P SET P.votes = P.votes - 1 WHERE P.postID = '" + postID + "'";
		
		System.out.println(str);
		
		stmt.executeUpdate(str);
		
		%>
		<jsp:forward page="Thread.jsp">
		<jsp:param name= "threadID" value="<%=threadID%>"/>
		<jsp:param name="sort" value="<%=sort%>"/>
		</jsp:forward>
		
		
		<% 
		
		}
		}catch(Exception e){
			
			System.out.println("error in votechange.jsp: "+ e.getMessage());
			
		}
		
		%>
		
		
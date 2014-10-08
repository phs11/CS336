<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

   <% 
   		String topicName = (String)request.getParameter("topicName");
   		String threadID = (String)request.getParameter("threadID");
   		String modType = (String)request.getParameter("modType");
   		String postID = (String)request.getParameter("postID");
   		
   		System.out.println("Threadid =" +threadID);
   		
   		try{
   		
   		
   		String url = "jdbc:mysql://cs336-36.cs.rutgers.edu:3306/proj2014";
   		
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver").newInstance();

		//Create a connection to your DB
		Connection con = DriverManager.getConnection(url, "csuser",
				"cs99f4c8");

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		if(modType.equals("p"))
		{
			promotePost(postID, stmt);
		}
		else
		if(modType.equals("d"))
		{
			
			deletePost(postID, stmt);
		}
		else
		if(modType.equals("e"))
		{
			%>
			
		<jsp:forward page="EditPost.jsp">
 		<jsp:param value="<%=topicName %>" name="topicName"/>
 		<jsp:param value="<%=threadID %>" name="threadID"/>
 		<jsp:param value="<%=postID %>" name="postID"/>
 		</jsp:forward>
			
			
			
			<%
		}
		else
		if(modType.equals("m"))
		{
			%>
			<jsp:forward page="MovePost.jsp">
	 		<jsp:param value="<%=threadID %>" name="threadID"/>
	 		<jsp:param value="<%=postID %>" name="postID"/>
	 		<jsp:param value="<%=topicName %>" name="topicName"/>
	 		</jsp:forward>
		<%
	
		}

		
		
		
		}catch(Exception e)
		{
			
			System.out.println("Exception in Modify Thread + "+ e.getMessage());
		}
   		
   	  %>
   	  <%! 
   		public void promotePost(String postID, Statement stmt)throws SQLException
   		{
   			
   		  String query = "Update Post P Set P.parentPostID = '0' WHERE P.postID = '" + postID + "'";
   		  
   		  System.out.println(query);
   		  stmt.executeUpdate(query);
   		  
   		  
   		}
   	  
   	  	public void deletePost(String postID, Statement stmt) throws SQLException
   	  	{
   	  		String query = "DELETE FROM Post WHERE postID = '" + postID + "'";
   	  		
   	  		System.out.println(query);
 		 	 stmt.executeUpdate(query);
 		 	 
 		 	 //delete subposts
 		 	query = "DELETE FROM Post WHERE parentPostID = '" + postID + "'";
   	  		stmt.executeUpdate(query);
   	  	}
   		
 		%>
 		
 		<jsp:forward page="Thread.jsp">
 		<jsp:param value="<%=topicName %>" name="topicName"/>
 		<jsp:param value="<%=threadID %>" name="threadID"/>
 		</jsp:forward>
		
		
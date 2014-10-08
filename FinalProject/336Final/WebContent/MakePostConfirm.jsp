<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

   <% 
   		String threadID = null;
   		String threadDescription = (String)session.getAttribute("threadDescription");
   		threadDescription = threadDescription.replace("'","''");
   		try{
   		
   		String content = request.getParameter("postContent").replace("'","''");
   		threadID = (String)session.getAttribute("threadID");
   		
   		
   		String url = "jdbc:mysql://cs336-36.cs.rutgers.edu:3306/proj2014";
   		
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver").newInstance();

		//Create a connection to your DB
		Connection con = DriverManager.getConnection(url, "csuser",
				"cs99f4c8");

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		//Make a SELECT query from the table specified by the 'command' parameter at the HelloWorld.jsp
		String str = "SELECT * FROM Post P WHERE P.content = '"+content+"' AND P.threadID = '"+threadID+"'";
		
		System.out.println(str);
		
		ResultSet result = stmt.executeQuery(str);
		
		if(!result.next())
		{
			//thread does not exist, let's make a new one
			
			str = "INSERT INTO Post(username, threadID, parentPostID, content) VALUES('"+(String)session.getAttribute("userName")+"','"+threadID+"','0',"+"'"+content+"')";
			System.out.println(str);
			stmt.executeUpdate(str);
			
			str ="UPDATE Thread T SET T.dateTime = now() WHERE T.threadID = '" + threadID +"'";
			System.out.println(str);
			stmt.executeUpdate(str);
			
		}
		
   		}catch(Exception e)
   		{
   			System.out.println("Exception caught in MakePostConfirm.jsp "+e.getMessage());
   		}
   
   	//redirect back to Thread.jsp
		
		%>
		
		<jsp:forward page="Thread.jsp">
		<jsp:param value="<%=threadID%>" name="threadID"/>
		<jsp:param value="<%=threadDescription%>" name="threadDescription"/>
		</jsp:forward>
		

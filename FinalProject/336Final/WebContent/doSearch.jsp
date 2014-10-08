<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="model.TargetSearch"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Search</title>
<link rel="stylesheet" href="Style.css">
</head>
<body>
<% 
	String userName = session.getAttribute("userName").toString();
%>
	<center>
		<h2>Search Results:</h2><br>
		<table>
			<tr>
				<td align="center" valign="middle" width="200"><a
					href="GoHome.jsp?">
						Home </a></td>
				<td align="center" valign="middle" width="200"><a
					href="Topics.jsp"> Topics Page</a></td>
				<td align="center" valign="middle" width="200"><a
					href="EditHomeScreen.jsp?username=<%=userName%>">Edit Profile
						Information</a></td>
				<td align="center" valign="middle" width="200"><a
					href="index.jsp"
					onclick="return confirm ('Are you sure you want to logout?')">Logout</a></td>
				<td align="center" valign="middle" width="200">
					<form action="doSearch.jsp" method="post">

						<input type="text"
							style="width: 250px" value="" size="35" name="searchInput">
						<select style="width: 150px" name="option">
							<option value="topic">Search for Topics</option>
							<option value="thread">Search for Threads</option>
							<option value="post">Search for Posts</option>
						</select>
						<input type="submit" value="Submit">
					</form>
				</td>

			</tr>
		</table><br>
	<%
		try {
			
			String url = "jdbc:mysql://cs336-36.cs.rutgers.edu:3306/proj2014";
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver").newInstance();

			//Create a connection to your DB
			Connection con = DriverManager.getConnection(url, "csuser",
					"cs99f4c8");

			//Create a SQL statement
			Statement stmt = con.createStatement();
			String query;
			ResultSet result;
			
			if(request.getParameter("option") ==  null || request.getParameter("searchInput") == null || request.getParameter("searchInput").toString().compareTo("") == 0){
				%>
					<jsp:forward page="GoHome.jsp"> 
						<jsp:param name="Sales" value="success"/>
						</jsp:forward>
				<%
			}
			String searchStr = request.getParameter("searchInput").toString();
			String option = request.getParameter("option").toString();
			if(option.equalsIgnoreCase("topic")){
				String topic;
				query = "Select * from Topic";
				%>
					<table border="1">
						<tr>
							<td align="center" valign="middle" width="100" colspan="2"></td>
							<td align="center" valign="middle" width="500" colspan="2">Matching Posts</td>
						</tr>
		<%
				result = stmt.executeQuery(query);
				int i = 1;
				while(result.next()){
					topic = result.getString("topicName");
					if(TargetSearch.checkMatch(searchStr, topic)){
						%>
						<tr>
							<td align="center" valign="middle" width="100" colspan="2"><a href="IndividualTopic.jsp?topicName=<%=topic%>"><%=i%></a></td>
							<td align="center" valign="middle" width="500" colspan="2"><%=topic%></td>
						</tr>
						<%
						i++;
					}
				}
				%>
					</table>
				<%
				if(i == 1){
					%>
						<h2>**No Search Results**</h2>
					<%
				}
			 }else if(option.equalsIgnoreCase("thread")){
				 String thread;
					query = "Select * from Thread";
					%>
						<table border="1">
							<tr>
								<td align="center" valign="middle" width="100" colspan="2"></td>
								<td align="center" valign="middle" width="500" colspan="2">Matching Threads</td>
							</tr>
			<%
					result = stmt.executeQuery(query);
					int i = 1;
					while(result.next()){
						thread = result.getString("description");
						if(TargetSearch.checkMatch(searchStr, thread)){
							%>
							<tr>
								<td align="center" valign="middle" width="100" colspan="2"><a href="Thread.jsp?topicName=<%=result.getString("topicName")%>&threadID=<%=result.getString("threadID")%>&threadDescription=<%=result.getString("description") %>"><%=i%></a></td>
								<td align="center" valign="middle" width="500" colspan="2"><%=thread%></td>
							</tr>
							<%
							i++;
						}
					}
					%>
						</table>
					<%
					if(i == 1){
						%>
							<h2>**No Search Results**</h2>
						<%
					}
			 }else{ //search by post
				 String post;
					query = "Select * from Post";
					%>
						<table border="1">
							<tr>
								<td align="center" valign="middle" width="100" colspan="2"></td>
								<td align="center" valign="middle" width="500" colspan="2">Matching Posts</td>
							</tr>
			<%	
					
					
					Statement stmt2 = con.createStatement(); 
					result = stmt.executeQuery(query);
					String thread;
					ResultSet result2;
					int i = 1;
					while(result.next()){
						thread = "Select * from Thread where threadID = '" + result.getString("threadID") +"'";
						result2 = stmt2.executeQuery(thread);
						result2.next();
						post = result.getString("content");
						if(TargetSearch.checkMatch(searchStr, post)){
							%>
							<tr>
								<td align="center" valign="middle" width="100" colspan="2"><a href="Thread.jsp?topicName=<%=result2.getString("topicName")%>&threadID=<%=result2.getString("threadID")%>&threadDescription=<%=result2.getString("description") %>"><%=i%><%session.setAttribute("topicName", result2.getString("topicName"));%></a></td>
								<td align="center" valign="middle" width="500" colspan="2"><%=post%></td>
							</tr>
							<%
							i++;
						}
					}
					%>
						</table>
					<%
					if(i == 1){
						%>
							<h2>**No Search Results**</h2>
						<%
					}
			 }
		} catch (SQLException e) {

		}
	%>
	</center>
</body>
</html>
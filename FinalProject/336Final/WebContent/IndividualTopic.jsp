
	<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="model.Thread, model.ThreadVoteComparator, model.ThreadDateComparator, model.ThreadAlphaComparator" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><%=request.getParameter("topicName") %></title>
<link rel="stylesheet" href="Style.css">
</head>
<%
	String userName = session.getAttribute("userName").toString();
%>
		<!-- logo -->
	<a name="top"></a>
	<br><table class="page" cellpadding="0" cellspacing="0" align="center" border="0" width="96%">
	<tbody><tr>
		<td width="8">&nbsp;</td>
		<td valign="top" width="424"><font color="#152437"><font size="2"><b>Welcome To The Forums!</b></font>
			</font>
			<img src=http://darylgeorge.com/wp-content/uploads/2013/10/2forum.jpg alt="Image" height="80" width="450" border="0"></a>
		</td>
		<td align="right">
			
			<fieldset class="fieldset" align="center">
				<legend>Search</legend>
				<div style="padding:3px">
				<div id="tag_add_menu" class="vbmenu_popup" style="display: none; position: absolute; z-index: 50;"></div>
				</div>
				<div style="padding:3px, margin-top:6px">
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
				
				</div>
				
			</fieldset>
		</td>
		<td width="25">&nbsp;</td>
		</tr>
		<tr>
		<td colspan="4">
		<table cellpadding="0" cellspacing="0" border="0" width="100%">
		<tbody><tr>


		<div class="body_container">
		
		<div class="page_heading_txt"></div>
		
		<div id="main_container">

<!-- Display forum list -->

<!-- Top Navigation -->

<table cellpadding="0" cellspacing="0" border="0" width="100%">
	<tbody><tr>
	    <td class="topnav_left_img"></td>
		<td class="topnav_bg_img" valign="top">
			
		</td>
		<td class="topnav_right_img"></td>
	</tr>
</tbody></table>
<center>
<h1><%=request.getParameter("topicName")%></h1>
<br>
<table>
			<tr>
				<td align="center" valign="middle" width="200"><a
					href="GoHome.jsp">
						Home </a></td>
				<td align="center" valign="middle" width="200"><a
					href="Topics.jsp"> Topics Page</a></td>
				<td align="center" valign="middle" width="200"><a
					href="EditHomeScreen.jsp">Edit Profile
						Information</a></td>
				<td align="center" valign="middle" width="200"><a
					href="index.jsp"
					onclick="return confirm ('Are you sure you want to logout?')">Logout</a></td>
			</tr>
		</table><br>
<a href="MakeThread.jsp">Make a new thread for <%=request.getParameter("topicName")%></a>
</center>

<a href="IndividualTopic.jsp?topicName=<%=request.getParameter("topicName")%>&sort=votes">Sort by Vote</a>
<br>
<a href="IndividualTopic.jsp?topicName=<%=request.getParameter("topicName")%>&sort=date">Sort by Date</a>
<br>
<a href="IndividualTopic.jsp?topicName=<%=request.getParameter("topicName")%>&sort=alpha">Sort Alphabetically</a>

<body>

<%
//get all threads under topic
		String typeUser = (String) session.getAttribute("type");
		String topic = (String)request.getParameter("topicName");
		session.setAttribute("topicName", topic);
		
	try{
		
		String url = "jdbc:mysql://cs336-36.cs.rutgers.edu:3306/proj2014";
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver").newInstance();

		//Create a connection to your DB
		Connection con = DriverManager.getConnection(url, "csuser",
				"cs99f4c8");

		//Create a SQL statement
		Statement stmt = con.createStatement();
	
		String str = "SELECT * FROM Thread T WHERE T.topicName = '" + topic + "'";
		
		

		//Run the query against the database.
		ResultSet result = stmt.executeQuery(str);
		
		ArrayList<Thread> threadArr = new ArrayList<Thread>();
		
		//make new threads
		while(result.next())
		{
			
			int threadID = Integer.parseInt(result.getString("threadID"));
			String topicName = result.getString("topicName");
			String description = result.getString("description");
			int votes = Integer.parseInt(result.getString("votes"));
			String dateTime = result.getString("dateTime");
			
			Thread thread = new Thread(threadID, topicName, votes, description, dateTime);
			threadArr.add(thread);
			
		}
		
		//votes is default
		if(request.getParameter("sort") == null || request.getParameter("sort").equals("votes"))
		{
			ThreadVoteComparator tvc = ThreadVoteComparator.getInstance();
			
			Collections.sort(threadArr, tvc);
			
			
			
		}
		else
		//sort by date
		if(request.getParameter("sort").equals("date"))		
		{
			
			
			ThreadDateComparator tdc = ThreadDateComparator.getInstance();
			
			Collections.sort(threadArr, tdc);
			
		}
		else
		if(request.getParameter("sort").equals("alpha"))
		{
			
			ThreadAlphaComparator tac = ThreadAlphaComparator.getInstance();
			
			Collections.sort(threadArr, tac);
		}
		
		
		//sort according to vote
		
		
		for(int i = 0; i < threadArr.size(); i++)
		{
			
			int threadID = threadArr.get(i).threadID;
			String description = threadArr.get(i).description;
			int votes = threadArr.get(i).votes;
			
			%>
			
			
			<div id = "container"> 
			<%=description %>: &nbsp;&nbsp; <%=votes %>
			<br>
			<a href="VoteChange.jsp?threadID=<%=threadID%>&direction=up&sort=<%=request.getParameter("sort")%>">&#9650;</a>&nbsp;<a href="VoteChange.jsp?threadID=<%=threadID%>&direction=down&sort=<%=request.getParameter("sort")%>">&#9660;</a>
			<br>
			<a href="Thread.jsp?threadDescription=<%=description%>&threadID=<%=threadID%>&sort=votes">Explore Posts</a>
			
			<br>
			<%
			//check if they can modify links
					if(typeUser.equals("Moderator") || typeUser.equals("Admin"))
					{
						%>
						<a href="ModifyThread.jsp?modType=d&topicName=<%=topic%>&threadID=<%=threadID%>">Delete Thread</a>
						<br>
						<a href="ModifyThread.jsp?modType=e&topicName=<%=topic%>&threadID=<%=threadID%>">Edit Thread</a>
						<br>
						<a href="ModifyThread.jsp?modType=m&topicName=<%=topic%>&threadID=<%=threadID%>">Move Thread to Different Topic</a>
						&nbsp;&nbsp;
						<%
					}
					%>
				 </div>
				<br>
					<%
					
				
					
					
		}
			
		
			
			
		
		
		con.close();
		
		
	}catch(Exception e)
	{
		System.out.println("EXCEPTION in IndividualTopic.jsp");
		System.out.println(e.getMessage());
		
	}

%>










</body></html>
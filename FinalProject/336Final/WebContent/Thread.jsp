
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="model.PostAlphaComparator, model.PostDateComparator, model.PostVoteComparator"%>
<%@ page import="model.Post"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Posts</title>
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
<%
if(request.getParameter("threadDescription")!= null)
session.setAttribute("threadDescription", request.getParameter("threadDescription"));
String topicName = session.getAttribute("topicName").toString();
%>
<center>
	<h2>Posts</h2>
	<br>
	
	<table>
		<tr>
			<td align="center" valign="middle" width="200"><a
				href="GoHome.jsp"> Home </a></td>
			<td align="center" valign="middle" width="200"><a
				href="Topics.jsp"> Topics Page</a></td>
			<td align="center" valign="middle" width="200"><a
				href="EditHomeScreen.jsp">Edit Profile Information</a></td>
			<td align="center" valign="middle" width="200"><a
				href="index.jsp"
				onclick="return confirm ('Are you sure you want to logout?')">Logout</a></td>
		</tr>
	</table>
	<h2><%=session.getAttribute("threadDescription")%></h2>
	<br> <a href="MakePost.jsp">Make a new Post for thread: <%=session.getAttribute("threadDescription")%></a><br>
	<a href="IndividualTopic.jsp?topicName=<%=topicName%>">Back to Topic</a><br>
</center>

<a href="Thread.jsp?threadID=<%=request.getParameter("threadID")%>&sort=votes">Sort by Vote</a>
<br>
<a href="Thread.jsp?threadID=<%=request.getParameter("threadID")%>&sort=date">Sort by Date</a>
<br>
<a href="Thread.jsp?threadID=<%=request.getParameter("threadID")%>&sort=alpha">Sort Alphabetically</a>

<body>
<body>

<%
//get type of user
String typeUser = (String)session.getAttribute("type");
//get all threads under topic
//set session threadID because all subposts will need it
session.setAttribute("threadID", request.getParameter("threadID"));
String threadID = (String)session.getAttribute("threadID");


	try{
		
		String url = "jdbc:mysql://cs336-36.cs.rutgers.edu:3306/proj2014";
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver").newInstance();

		//Create a connection to your DB
		Connection con = DriverManager.getConnection(url, "csuser",
				"cs99f4c8");

		//Create a SQL statement
		Statement stmt = con.createStatement();
	
		String str = "SELECT * FROM Post WHERE threadID = '" + threadID + "' AND parentPostID = '0'";
		
		System.out.println(str);
		

		//Run the query against the database.
		ResultSet result = stmt.executeQuery(str);
		
		ArrayList<Post> superPosts = new ArrayList<Post> ();
		
		
		while(result.next())
		{
			int postID = Integer.parseInt(result.getString("postID"));
			int threadID_post = Integer.parseInt(result.getString("threadID"));
			String dateTime = result.getString("dateTime");
			String content = result.getString("content");
			int votes = Integer.parseInt(result.getString("votes"));
			int parentPostID = Integer.parseInt(result.getString("parentPostID"));
			
			superPosts.add(new Post(postID, userName, threadID_post, parentPostID, votes, content, dateTime));
		}
		
				//votes is default
				System.out.println(request.getParameter("sort"));
				if(request.getParameter("sort") == null || request.getParameter("sort").equals("votes"))
				{
					System.out.println("Sorting by vote");
					PostVoteComparator pvc = PostVoteComparator.getInstance();
					
					Collections.sort(superPosts, pvc);
					
					
					
				}
				else
				//sort by date
				if(request.getParameter("sort").equals("date"))		
				{
					
					
					PostDateComparator pdc = PostDateComparator.getInstance();
					
					Collections.sort(superPosts, pdc);
					
				}
				else
				//alphabetically
				if(request.getParameter("sort").equals("alpha"))
				{
					
					PostAlphaComparator pac = PostAlphaComparator.getInstance();
					
					Collections.sort(superPosts, pac);
				}
		
		for(int i = 0 ; i< superPosts.size(); i++)
		{
			
			
			
			%>
			<div id = "container"> 
			<%=superPosts.get(i).userName %>&nbsp;&nbsp;&nbsp;<%=superPosts.get(i).dateTime%>
			<br>
			<%=superPosts.get(i).content %>: <%=superPosts.get(i).votes %> <a href="VoteChange.jsp?postID=<%=superPosts.get(i).postID%>&direction=up&threadID=<%=threadID%>&sort=<%=request.getParameter("sort")%>">&#9650;</a>&nbsp;<a href="VoteChange.jsp?postID=<%=superPosts.get(i).postID%>&direction=down&threadID=<%=superPosts.get(i).threadID%>&sort=<%=request.getParameter("sort")%>">&#9660;</a>
			<br>
			<%
			//check if they can modify links
			if(typeUser.equals("Moderator") || typeUser.equals("Admin") || superPosts.get(i).userName.equals(session.getAttribute("userName")))
			{
				%>
				<a href="ModifyPost.jsp?modType=d&topicName=<%=topicName%>&threadID=<%=superPosts.get(i).threadID%>&postID=<%=superPosts.get(i).postID%>">Delete Post</a>
				&nbsp;&nbsp;
				<a href="ModifyPost.jsp?modType=e&topicName=<%=topicName%>&threadID=<%=superPosts.get(i).threadID%>&postID=<%=superPosts.get(i).postID%>">Edit Post</a>
				&nbsp;&nbsp;
				<br>
				<%
			}
			
			if(typeUser.equals("Moderator") || typeUser.equals("Admin"))
			{
				%>
				<a href="ModifyPost.jsp?modType=m&topicName=<%=topicName%>&threadID=<%=superPosts.get(i).threadID%>&postID=<%=superPosts.get(i).postID%>">Move Post to Different Thread</a>
				<br>
				<%
				
			}
			%>
			
			<a href="ReplyToPost.jsp?postID=<%=superPosts.get(i).postID%>">Reply to Post</a>
				<blockquote>
				
				<%
				//if they have suposts print them
				
				int parentPostID = superPosts.get(i).parentPostID;
				Statement stmt2 = con.createStatement();
				
				str = "SELECT * FROM Post WHERE parentPostID = '" + superPosts.get(i).postID + "'";
				
				System.out.println(str);
				

				//Run the query against the database.
				ResultSet result2 = stmt2.executeQuery(str);
				
				ArrayList<Post> subPosts = new ArrayList<Post>();
				
				
				while(result2.next())
				{
					int postID = Integer.parseInt(result2.getString("postID"));
					int threadID_post = Integer.parseInt(result2.getString("threadID"));
					String dateTime = result2.getString("dateTime");
					String	content = result2.getString("content");
					int votes = Integer.parseInt(result2.getString("votes"));
					
					subPosts.add(new Post(postID, userName, threadID_post, parentPostID, votes, content, dateTime));
				}
				
				//votes is default
				System.out.println(request.getParameter("sort"));
				if(request.getParameter("sort") == null || request.getParameter("sort").equals("votes"))
				{
					System.out.println("Sorting by vote");
					PostVoteComparator pvc = PostVoteComparator.getInstance();
					
					Collections.sort(subPosts, pvc);
					
					
					
				}
				else
				//sort by date
				if(request.getParameter("sort").equals("date"))		
				{
					
					
					PostDateComparator pdc = PostDateComparator.getInstance();
					
					Collections.sort(subPosts, pdc);
					
				}
				else
				//alphabetically
				if(request.getParameter("sort").equals("alpha"))
				{
					
					PostAlphaComparator pac = PostAlphaComparator.getInstance();
					
					Collections.sort(subPosts, pac);
				}
				
				for(int j = 0; j< subPosts.size() ; j++)
				{
					System.out.println(subPosts.get(j));
				%>
				
				
					<div id = "container"> 
					<%=subPosts.get(j).userName%>&nbsp;&nbsp;&nbsp;<%=subPosts.get(j).dateTime %>
					<br>
					<%=subPosts.get(j).content %>: <%=subPosts.get(j).votes %> <a href="VoteChange.jsp?postID=<%=subPosts.get(j).postID%>&direction=up&threadID=<%=subPosts.get(j).threadID%>&sort=<%=request.getParameter("sort")%>">&#9650;</a>&nbsp;<a href="VoteChange.jsp?postID=<%=subPosts.get(j).postID%>&direction=down&threadID=<%=subPosts.get(j).threadID%>&sort=<%=request.getParameter("sort")%>">&#9660;</a>
					<%
						//check if they can modify links
						if(typeUser.equals("Moderator") || typeUser.equals("Admin") || subPosts.get(j).userName.equals(session.getAttribute("userName")))
						{
							%>
							<a href="ModifyPost.jsp?modType=d&topicName=<%=topicName%>&threadID=<%=subPosts.get(j).threadID%>&postID=<%=subPosts.get(j).postID%>">Delete Post</a>
							&nbsp;&nbsp;
							<a href="ModifyPost.jsp?modType=e&topicName=<%=topicName%>&threadID=<%=subPosts.get(j).threadID%>&postID=<%=subPosts.get(j).postID%>">Edit Post</a>
							&nbsp;&nbsp;
							
							
							<%
						}
						if(typeUser.equals("Moderator") || typeUser.equals("Admin"))
						{
							%>
							<a href="ModifyPost.jsp?modType=p&topicName=<%=topicName%>&threadID=<%=subPosts.get(j).threadID%>&postID=<%=subPosts.get(j).postID%>">Promote SubPost to Post</a>
							
							
							<%
							
						}
						
						%>
					
					</div>
					<br>
					
				
				<%
						
				}
								
				%>
				</blockquote>
				</div>
				
			
				
				 
			<br>
					<%
		}
			
			
			
			
		
		
		con.close();
		
		
	}catch(SQLException e)
	{
		System.out.println("EXCEPTION THREAD");
		System.out.println(e.getMessage());
		
	}

%>
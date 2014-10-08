<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Manage Advertisements</title>
<link rel="stylesheet" href="Style.css">
</head>
<body>
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
<!-- End of Top Navigation -->

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


			System.out.println("USERNAME " + session.getAttribute("userName"));
			con.close();

		} catch (Exception e) {
			System.out.println("EXCEPTION LINE 84");
			System.out.println(e.getCause());

		}
	%>
	<center>

		<h2>
			Welcome
			<%=session.getAttribute("userName")%></h2>
		<br>
		<table>
			<tr>
				<td align="center" valign="middle" width="200"><a
					href="HomeScreen.jsp?userName=<%=request.getParameter("userName")%>">
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
		</table>
		<br>
		<%
			//get the bio from user

			String bio = null;
			String profilePicUrl = null;
			try {

				String url = "jdbc:mysql://cs336-36.cs.rutgers.edu:3306/proj2014";
				//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
				Class.forName("com.mysql.jdbc.Driver").newInstance();

				//Create a connection to your DB
				Connection con = DriverManager.getConnection(url, "csuser",
						"cs99f4c8");

				//Create a SQL statement
				Statement stmt = con.createStatement();
				//System.out.println(session.getAttribute("userName"));

				//Make a SELECT query from the table specified by the 'command' parameter at the HelloWorld.jsp
				String str = "SELECT U.bio FROM User U WHERE U.username = '"
						+ session.getAttribute("userName") + "'";

				//System.out.println(str);

				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);

				result.next();
				bio = result.getString("bio");

				//System.out.println("BIO " + bio);

				str = "SELECT U.profilePicUrl FROM User U WHERE U.username = '"
						+ session.getAttribute("userName") + "'";
				result = stmt.executeQuery(str);

				result.next();
				profilePicUrl = result.getString("profilePicUrl");

				//str = "SELECT A.username FROM Admin A WHERE A.username= '"
						//+ session.getAttribute("userName") + "'";
				//result = stmt.executeQuery(str);
		%>
		<img src="<%=profilePicUrl%>" alt="your profile picture" height="200"
			width="200"> <br>
		<h2>Biography:</h2>
		<p><%=bio%></p>
		<br> <a href="NewAd.jsp">New Advertisement</a> &nbsp;&nbsp;<a
			href="SalesStat.jsp">Sales Statistics</a>

		<%
				str = "SELECT * from Advertisement";
				result = stmt.executeQuery(str);
				if(!result.next()){//no ads
						%>
		<h2>**No Ads**</h2>
		<%
				}else{
					String adID = result.getString("AD_ID");
					String name = result.getString("companyName");
					String desc = result.getString("description");
						%>
		<table border="1">
			<tr>
				<td align="center" valign="middle" width="300">Company Name</td>
				<td align="center" valign="middle" width="300">Description</td>
			</tr>
			<tr>
				<td align="center" valign="middle" width="300"><a
					href="EditAd.jsp?ad=<%=adID%>"><%=name%></a></td>
				<td align="center" valign="middle" width="300"><%=desc%></td>
			</tr>
			<%
						while (result.next()) {
							adID = result.getString("AD_ID");
							name = result.getString("companyName");
							desc = result.getString("description");
							%>
			<tr>
				<td align="center" valign="middle" width="300"><a
					href="EditAd.jsp?ad=<%=adID%>"><%=name%></a></td>
				<td align="center" valign="middle" width="300"><%=desc%></td>
			</tr>
			<%
						}
					}
					
					con.close();
				} catch (Exception e) {
					System.out.println("EXCEPTION LINE 199");
					System.out.println(e.getCause());

				}
			%>
		</table>
	</center>
	<br>
	<h2>Inbox:</h2>
	<button type="button" onclick="location.href='NewMessage.jsp'">New
		message</button>
	<%
		//get all users
		try {

			String url = "jdbc:mysql://cs336-36.cs.rutgers.edu:3306/proj2014";
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver").newInstance();

			//Create a connection to your DB
			Connection con = DriverManager.getConnection(url, "csuser",
					"cs99f4c8");

			//Create a SQL statement
			Statement stmt = con.createStatement();

			//Make a SELECT query from the table specified by the 'command' parameter at the HelloWorld.jsp
			String str = "SELECT * from Message where toUser= '" + userName + "'";

			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			if(!result.next()){
				%>
	<p>**No messages**</p>
	<%
			}else{
				%>
	<table border="1">
		<tr>
			<td align="center" valign="middle" width="100">Message</td>
			<td align="center" valign="middle" width="150">From</td>
			<td align="center" valign="middle" width="400">Content</td>
			<td align="center" valign="middle" width="100"></td>
		</tr>
		<%
				int i = 1;
				do{
				%>
		<tr>
						<td align="center" valign="middle" width="100"><%=i%></td>
						<td align="center" valign="middle" width="150"><%=result.getString("fromUser") %></td>
						<td align="center" valign="middle" width="400"><%=result.getString("content") %></td>
						<td align="center" valign="middle" width="100"><a href="DeleteMessage.jsp">delete</a></td>
		</tr>
		<%
				}while(result.next());
			}
			
			con.close();
			%>
	</table>
	<%
		} catch (Exception e) {
			System.out.println("EXCEPTION LINE 199");
			System.out.println(e.getCause());

		}
	%>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="model.TargetAdvertisement"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home Screen</title>
<link rel="stylesheet" href="Style.css">
</head>
<body>




<!--determine user advertisements-->
	<%
		String userName = null;
		try {

			String url = "jdbc:mysql://cs336-36.cs.rutgers.edu:3306/proj2014";
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver").newInstance();

			//Create a connection to your DB
			Connection con = DriverManager.getConnection(url, "csuser",
					"cs99f4c8");

			//Create a SQL statement
			Statement stmt = con.createStatement();

			userName = session.getAttribute("userName").toString();
			con.close();

		} catch (Exception e) {
			System.out.println("EXCEPTION LINE 84");
			System.out.println(e.getCause());

		}
	%>

	<center>
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
				Statement stmt2 = con.createStatement();
				Statement stmt3 = con.createStatement();
				boolean first = true;
				String str = "select * from Advertisement";
				ResultSet result = stmt.executeQuery(str);
		%>
		<table border="1">
			<%
				String getBio = "select U.bio from User U where U.username= '" + userName + "'";
				ResultSet bioCheck = stmt3.executeQuery(getBio);
				bioCheck.next();
				String bio = bioCheck.getString("bio");
				while(result.next()) { //loop through advertisements
						String keys = result.getString("keywords").toLowerCase();
						if(bio != null && TargetAdvertisement.checkMatch(keys, bio)){
							if(first){
								%>
								<tr>
									<td align="center" valign="middle" width="500" colspan="2">Advertisements</td>
								</tr>
								<%
								first = false;
							}
							%>
							<tr>
								<td align="center" valign="middle" width="500"><a href="PurchaseAd.jsp?ad=<%=result.getString("AD_ID")%>"><%=result.getString("companyName")%></a></td>
								<td align="center" valign="middle" width="500"><%=result.getString("description")%></td>
							</tr>
							<%
							continue;
						}
						String postQuery = "select * from Post where username='"
								+ userName + "'";
						ResultSet result2 = stmt2.executeQuery(postQuery);
						while (result2.next()) { // loop through users posts
							String content = result2.getString("content");
							content = content.toLowerCase();
							if (TargetAdvertisement.checkMatch(keys, content)) {
								if(first){
									%>
									<tr>
										<td align="center" valign="middle" width="500" colspan="2">Advertisements</td>
									</tr>
									<%
									first = false;
								}
								%>
								<tr>
									<td align="center" valign="middle" width="500"><a href="PurchaseAd.jsp?ad=<%=result.getString("AD_ID")%>"><%=result.getString("companyName")%></a></td>
									<td align="center" valign="middle" width="500"><%=result.getString("description")%></td>
								</tr>
								<%
								break;
							}
						}
					}

				} catch (Exception e) {
	
				}
			%>
		</table>
		<br>
		
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
		
		
<!--welcome user and print their name-->
		<h2 align="center">
			Welcome
			<%=userName%></h2>
		<br>

		<!-- Links to spaces on the website -->
		<table width="100%">
			<tr>
				<td align="center" valign="middle" width="200"><a
					href="GoHome.jsp?userName=<%=request.getParameter("userName")%>">
						Home </a></td>
				<td align="center" valign="middle" width="200"><a
					href="Topics.jsp"> Topics Page</a></td>
				<td align="center" valign="middle" width="200"><a
					href="EditHomeScreen.jsp?username=<%=userName%>">Edit Profile
						Information</a></td>
				<td align="center" valign="middle" width="200"><a
					href="index.jsp"
					onclick="return confirm ('Are you sure you want to logout?')">Logout</a></td>
			</tr>
		</table>
		<br>



		<%
			//get the bio from user

			String bio = null;
			String profilePicUrl = null;
			try {
				String str;

				String url = "jdbc:mysql://cs336-36.cs.rutgers.edu:3306/proj2014";
				//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
				Class.forName("com.mysql.jdbc.Driver").newInstance();

				//Create a connection to your DB
				Connection con = DriverManager.getConnection(url, "csuser",
						"cs99f4c8");

				//Create a SQL statement
				Statement stmt = con.createStatement();
				System.out.println(userName);

				//Make a SELECT query from the table specified by the 'command' parameter at the HelloWorld.jsp
				str = "SELECT U.bio FROM User U WHERE U.username = '"
						+ userName + "'";

				System.out.println(str);

				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);

				result.next();
				bio = result.getString("bio");

				System.out.println("BIO " + bio);

				str = "SELECT U.profilePicUrl FROM User U WHERE U.username = '"
						+ userName + "'";
				result = stmt.executeQuery(str);

				result.next();
				profilePicUrl = result.getString("profilePicUrl");

				str = "SELECT A.username FROM Admin A WHERE A.username= '"
						+ userName + "'";
				result = stmt.executeQuery(str);
				if (result.next()) { //user is an admin
		%>

		<%
			} else { //user not an admin
		%>
		<div align="center">
		<img src="<%=profilePicUrl%>" alt="your profile picture" height="200"
			width="200"> </div> <br>
		<h2 align="center">Biography:</h2>
		<br>
		<%=bio%>
		<%
			con.close();
				}

			} catch (SQLException e) {
				System.out.println("EXCEPTION LINE 147");
				System.out.println("error-" + e.getMessage());
			} catch (InstantiationException e) {
				System.out.println("Exception Line 151- Instantiation");
			}
		%>
	</center>
	<br>
	<h2>Inbox:</h2>
	<button type="button" onclick="location.href='NewMessage.jsp'">New message</button>
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
						<td align="center" valign="middle" width="200"></td>
					</tr>
				<%
				int i = 1;
				do{
				%>
					<tr>
						<td align="center" valign="middle" width="100"><%=i%></td>
						<td align="center" valign="middle" width="150"><%=result.getString("fromUser") %></td>
						<td align="center" valign="middle" width="400"><%=result.getString("content") %></td>
						<td align="center" valign="middle" width="200"><button type="button" onclick="location.href='NewMessage.jsp?messageID=<%=result.getString("messageID")%>'">Reply</button>
						<button type="button" onclick="location.href='DeleteMessage.jsp?messageID=<%=result.getString("messageID")%>'">Delete</button></td>
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
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sales Statistics</title>
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
	<center>
	<table>
			<tr>
				<td align="center" valign="middle" width="200"><a
					href="ManageAds.jsp">Home</a></td>
				<td align="center" valign="middle" width="200"><a
					href="Topics.jsp">Topics Page</a></td>
				<td align="center" valign="middle" width="200"><a
					href="EditHomeScreen.jsp">Edit Profile Information</a></td>
				<td align="center" valign="middle" width="200"><a
					href="index.jsp"
					onclick="return confirm ('Are you sure you want to logout?')">Logout</a></td>
			</tr>
	</table>
			<br>
		<h2>Sales to User:<br><i><%=userName%></i></h2><br>
		<table border="1">
			<tr>
				<td align="center" valign="middle" width="300">Company</td>
				<td align="center" valign="middle" width="300">Description</td>
				<td align="center" valign="middle" width="300">Price</td>
			</tr>
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
			String str = "select S.price, A.companyName, A.description From Advertisement A, Buys B, Sale_Item S Where S.AD_ID = B.AD_ID and B.AD_ID = A.AD_ID and B.username = '" + userName + "'";
			ResultSet result = stmt.executeQuery(str);
			while(result.next()){
				%>
				<tr>
					<td align="center" valign="middle" width="300"><%=result.getString("companyName") %></td>
					<td align="center" valign="middle" width="300"><%=result.getString("description") %></td>
					<td align="center" valign="middle" width="300">$<%=result.getString("price") %></td>
				</tr>
				<%
			}
		%>
		</table>
		</center>
		<%
			
		}catch(SQLException e){
			
		}
		%>
		
	</center>
</body>
</html>
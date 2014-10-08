<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Manage Users</title>
<link rel="stylesheet" href="Style.css">
</head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Confirm User Change</title>
</head>
<body>

<%
	String userName = session.getAttribute("userName").toString();
	String selectedUser = request.getParameter("selected");
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


<!-- End of Top Navigation -->
	<center>
		<h2>
			Selected User:
			<%=selectedUser%>
		</h2>
		<br>
		<p>Please confirm change to user:</p>
		<%
			String url = "jdbc:mysql://cs336-36.cs.rutgers.edu:3306/proj2014";
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver").newInstance();

		//Create a connection to your DB
		Connection con = DriverManager.getConnection(url, "csuser",
				"cs99f4c8");

		//Create a SQL statement
		Statement stmt = con.createStatement();



		//Make a SELECT query from the table specified by the 'command' parameter at the HelloWorld.jsp
		String str = "SELECT M.username FROM Moderator M WHERE M.username = '" + selectedUser + "'";

		System.out.println(str);
				//Run the query against the database.
		ResultSet result = stmt.executeQuery(str);
				if(result.next()){ //user already moderator
				%>
				
					<form action="AdminConfirm.jsp?selected=<%=selectedUser%>" method="post">
						<input type="radio" name="option" value="remove">Remove Moderator<br>
						<input type="radio" name="option" value="delete">Delete User<br>
						<input type="submit" value="Submit">
					</form>
				
				<%
			}else{ //user not a moderator
				str = "SELECT S.username FROM Sales_Staff S WHERE S.username = '" + selectedUser + "'";
				result = stmt.executeQuery(str);
				if(result.next()){ //user sales_Staff
					%>
					
						<form action="AdminConfirm.jsp?selected=<%=selectedUser%>" method="post">
							<input type="radio" name="option" value="fire">Fire Salesman<br>
							<input type="radio" name="option" value="delete">Delete User<br>
							<input type="submit" value="Submit">
						</form>
					
					
					<%
				}else{ //user neither moderator or sales staff
					%>
					<form action="AdminConfirm.jsp?selected=<%=selectedUser%>" method="post">
						<input type="radio" name="option" value="make">Make Moderator<br>
						<input type="radio" name="option" value="hire">Hire Salesman<br>
						<input type="radio" name="option" value="delete">Delete User<br>
						<input type="submit" value="Submit">
					</form>
					<%
				}
				
			}
				%>
	</center>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
</head>
<title>Purchase Advertisement</title>
<link rel="stylesheet" href="Style.css">
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

<%
try { //Create a connection string
		String url = "jdbc:mysql://cs336-36.cs.rutgers.edu:3306/proj2014";
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver").newInstance();

		//Create a connection to your DB
		Connection con = DriverManager.getConnection(url, "csuser",
				"cs99f4c8");

		//Create a SQL statement
		Statement stmt = con.createStatement();
		Statement stmt2 = con.createStatement();
		String query = "select description from Advertisement where AD_ID = " + request.getParameter("ad");
		String query2 = "select price from Sale_Item where AD_ID =" + request.getParameter("ad");
		ResultSet result = stmt.executeQuery(query);
		ResultSet result2 = stmt2.executeQuery(query2);
		result.next();
		result2.next();
		String desc = result.getString("description");
		String price = result2.getString("price");
		System.out.println("AD_ID :" + request.getParameter("ad") + "\n Desc: " + desc + "\n price: $" + price);
		%>
		<h2>Confirm Purchase</h2><br>
		<h3>Would you like to buy the advertisement:</h3><p><%=desc%></p><br><p>Price: $<%=price%></p>
		<button type="button" onclick="location.href='ConfirmPurchase.jsp?ad=<%=request.getParameter("ad")%>'">Confirm</button><button type="button" onclick="location.href='GoHome.jsp'">Cancel</button>
		<%
	}catch(SQLException e){
		System.out.println(e.toString());
	}
		
%>
</center>
</body>
</html>
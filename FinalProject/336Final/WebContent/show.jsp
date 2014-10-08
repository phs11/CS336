<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
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
<%      
	List<String> list = new ArrayList<String>();

	try {



	    	//Create a connection string
			String url = "jdbc:mysql://cs336-36.cs.rutgers.edu:3306/test";
	    	//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		    Class.forName("com.mysql.jdbc.Driver");
	    
	    	//Create a connection to your DB
		    Connection con = DriverManager.getConnection(url, "csuser", "cs99f4c8");
		
	    	//Create a SQL statement
		    Statement stmt = con.createStatement();
	    	//Get the selected radio button from the HelloWorld.jsp
		    String entity = request.getParameter("command");
	    	//Make a SELECT query from the table specified by the 'command' parameter at the HelloWorld.jsp
			String str = "SELECT * FROM " + entity;
	    	//Run the query against the database.
		    ResultSet result = stmt.executeQuery(str);
		   
		    //Make an HTML table to show the results in:
		    out.print("<table>");
		    
	    	   //make a row
		       out.print("<tr>");
	    	   //make a column
		       out.print("<td>");
	    	   //print out column header
		       out.print("name");
		       out.print("</td>");
		       //make a column
		       out.print("<td>");
		       //depending on the radio button selection make a column header for Manufacturer if the beers table was selected and Address if the bars table was selected
		       if (entity.equals("beers"))
		       		out.print("manf");
		       else
		    	   out.print("addr");
		       out.print("</td>");
		       out.print("</tr>");
		    
		    //parse out the results
		    while(result.next())
		    {
		       //make a row
		       out.print("<tr>");
		       //make a column
		       out.print("<td>");
		       //Print out current bar or beer name:
		       out.print(result.getString("name"));
		       out.print("</td>");
		       out.print("<td>");
		       //Print out current bar/beer additional info: Manf or Address
		       if (entity.equals("beers"))
		       		out.print(result.getString("manf"));
		       else
		    	   out.print(result.getString("addr"));
		       out.print("</td>");
		       out.print("</tr>");
		      
		    } 
		    out.print("</table>");
		    
		    //close the connection.
		    con.close();

	} catch (Exception ex) {
	}
	
	
%>

</body>
</html>
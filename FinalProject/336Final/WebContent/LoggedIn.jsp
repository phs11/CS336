<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <style type="text/css">
  body {
    color: white;
    background-color: black }
  ul.navbar {
    list-style-type: none;
    padding: 0;
    margin: 0;
    position: absolute;
    top: 2em;
    left: 1em;
    width: 9em }
  h1 {
    font-family: Helvetica, Geneva, Arial,
          SunSans-Regular, sans-serif }
  ul.navbar li {
    background: white;
    margin: 0.5em 0;
    padding: 0.3em;
    border-right: 1em solid black }
  ul.navbar a {
    text-decoration: none }
  a:link {
    color: red }
  a:visited {
    color: purple }
  address {
    margin-top: 1em;
    padding-top: 1em;
    border-top: thin dotted }
  </style>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>HomePage</title>
</head>
<body>
	<%
		try {
		//Create a connection string
			
			String url = "jdbc:mysql://cs336-36.cs.rutgers.edu:3306/proj2014";
			Class.forName("com.mysql.jdbc.Driver");
			//Create a connection to your DB
			Connection con = DriverManager.getConnection(url, "csuser", "cs99f4c8");
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the HelloWorld.jsp
			String user = request.getParameter("user");
			String password = request.getParameter("password");
			//Make a SELECT query from the table specified by the 'command' parameter at the HelloWorld.jsp
			String str = "SELECT U.username, U.passwordUser FROM User U WHERE U.username= '" + user + "'" + " AND U.passwordUser= '" + password + "'";
			ResultSet result = stmt.executeQuery(str);
			System.out.println(request.getParameter("inputText"));
			if(result.next()){
				//make it request to be used in HomeScreen.jsp
				session.setAttribute("userName", user);
				str = "SELECT A.username FROM Admin A WHERE A.username= '" + session.getAttribute("userName") + "'";
				result = stmt.executeQuery(str);	
				if(result.next()){ //user is an Admin
					session.setAttribute("type", "Admin");
					%>
						<jsp:forward page="AdminHome.jsp"> 
						<jsp:param name="admin" value="success"/>
						</jsp:forward>
					<%
				}
				str = "SELECT M.username FROM Moderator M WHERE M.username= '" + session.getAttribute("userName") + "'";
				result = stmt.executeQuery(str);	
				if(result.next()){ //user is a Moderator
					session.setAttribute("type", "Moderator");
					%>
						<jsp:forward page="HomeScreen.jsp"> 
						<jsp:param name="moderator" value="success"/>
						</jsp:forward>
					<%
				}
				str = "SELECT S.username FROM Sales_Staff S WHERE S.username= '" + session.getAttribute("userName") + "'";
				result = stmt.executeQuery(str);
				if(result.next()){ //user is a Sales_Staff
					session.setAttribute("type", "Sales_Staff");
					%>
						<jsp:forward page="ManageAds.jsp"> 
						<jsp:param name="Sales" value="success"/>
						</jsp:forward>
					<%
				}
				session.setAttribute("type", "Normal");
				//User is normal user
				%>
				<jsp:forward page="HomeScreen.jsp"> 
				<jsp:param name="normal" value="success"/>
				</jsp:forward>
				<% 
			}else{
				%>
					<jsp:forward page="error.jsp"> 
					<jsp:param name="UserDoesntExist" value="Username doesn't exist"/>
					</jsp:forward>
				<%
			}
		} catch (Exception ex) {
			out.print(ex);
		} 
		%>
</body>
</html>
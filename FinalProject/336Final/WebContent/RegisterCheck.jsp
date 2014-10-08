<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


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

		String userName = request.getParameter("username");
		String password = request.getParameter("password");
		String password2 = request.getParameter("password2");
		

		//if passwords are not equal
		if (!password.equals(password2)) {
%>

<jsp:forward page="newUserError.jsp">
	<jsp:param name="passwordsDontMatch" value="Passwords don't match" />
</jsp:forward>

<%
	}

		//Make a SELECT query from the table specified by the 'command' parameter at the HelloWorld.jsp
		String str = "SELECT userName FROM User WHERE userName = '" + userName + "'";

		//Run the query against the database.
		ResultSet result = stmt.executeQuery(str);

		if (result.next()) {
			//user already exists, FAIL
%>

<jsp:forward page="newUserError.jsp">
	<jsp:param name="userAlreadyExists" value="This user already exists" />
</jsp:forward>
<%
	} else {
			out.println("Else");
			//User does not exist yet, add to table
			String insert = "INSERT INTO User(username, passwordUser, isCustomer, bio, profilePicUrl)"
					+ "VALUES ( ?, ?, ?, ?, ?)";

			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(insert);

			out.println("Prepared Statement");

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, userName);
			ps.setString(2, password);
			ps.setBoolean(3, false);
			ps.setString(4, "**please add your biography**");
			ps.setString(5, "http://www.stablesclub.com/wp-content/themes/stables2012/images/avatar.jpg");

			out.println(ps);
			
			String i = ps.toString();

			//Run the query against the DB
			int num = ps.executeUpdate();

			if (num != 1) {
				out.println("error on update");
			}

			out.println("Update complete");
			con.close();
			
			//Success
%>

<jsp:forward page="index.jsp">
	<jsp:param name="userAlreadyExists" value="This user already exists" />
</jsp:forward>
<%
	}

	} catch (Exception e) {
	}
%>

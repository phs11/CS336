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
		String description = request.getParameter("description").replace("'", "'");;
		String companyName = request.getParameter("companyName").replace("'", "'");;
		String price = request.getParameter("price");
		String keywords = request.getParameter("keywords").replace("'", "'");;
		if(request.getParameter("ad") != null){ //editing add
			String update = "UPDATE Advertisement SET description='"+description+"', companyName='"+companyName+"',"+"keywords='"+keywords+"' WHERE AD_ID =" +  request.getParameter("ad");
			Statement stmt = con.createStatement();
			int result = stmt.executeUpdate(update);
		}else{ //new ad
			String insert = "Insert into Advertisement(companyName,description,keywords)" + "VALUES ( ?, ?, ?)";

			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(insert);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, companyName);
			ps.setString(2, description);
			ps.setString(3, keywords);
			int num = ps.executeUpdate();

			if (num != 1) {
				out.println("error on update");
			}
			String adID = "select AD_ID from Advertisement where description = '" + description + "'";
			Statement stmt = con.createStatement();
			ResultSet result = stmt.executeQuery(adID);
			result.next();
			insert = "Insert into Sale_Item(AD_ID,description,price)" + "VALUES ( ?, ?, ?)";
			ps = con.prepareStatement(insert);
			ps.setString(1, result.getString("AD_ID"));
			ps.setString(2, description);
			ps.setString(3, price);
			num = ps.executeUpdate();
			if (num != 1) {
				out.println("error on update");
			}
			out.println("Update complete");
			con.close();
		}
		
		
%>

<jsp:forward page="ManageAds.jsp">
	<jsp:param name="success" value="success" />
</jsp:forward>
<%
	} catch (Exception e) {
		System.out.print("Exception: " + e.getLocalizedMessage());
	}
%>

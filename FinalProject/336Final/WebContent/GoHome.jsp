<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
	<%
String type = session.getAttribute("type").toString();
	System.out.println("Type of User:" + type);
if(type.equalsIgnoreCase("normal")){
	%>
	<jsp:forward page="HomeScreen.jsp">
		<jsp:param name="success" value="success" />
	</jsp:forward>
	<%
}else if(type.equalsIgnoreCase("moderator")){
	%>
	<jsp:forward page="HomeScreen.jsp">
		<jsp:param name="success" value="success" />
	</jsp:forward>
	<%
}else if(type.equalsIgnoreCase("Admin")){
	%>
	<jsp:forward page="AdminHome.jsp">
		<jsp:param name="success" value="success" />
	</jsp:forward>
	<%
}else{ //sales staff
	%>
	<jsp:forward page="ManageAds.jsp">
		<jsp:param name="success" value="success" />
	</jsp:forward>
	<%
}
%>

</body>
</html>
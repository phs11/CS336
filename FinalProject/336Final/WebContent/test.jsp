    <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
            pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
    <%@ page import="javax.servlet.http.*,javax.servlet.*"%>
     
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    
    
    <html>
<head>
	   <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  <title>Rutgers forum Login</title>
  <link rel="stylesheet" href="Style.css">
</head>

  <body>

    <h2>Login</h2>

    <form method="post" action="j_security_check">
      <p>
        <strong>You may have entered an invalid user ID
          or password. To correct the problem, please enter
          your correct user ID and password. If you have
          forgotten your user ID or password, please contact
          the server administrator.</strong>
      </p>
      <p>
        <strong>Please enter user ID and password:</strong>
        <br>
        <strong>User ID</strong>
        <input type="text" size="20" name="j_username">
        <strong>Password</strong>
        <input type="password" size="20" name="j_password">
      </p>

      <p>
        <input type="submit" name="login" value="Login">
      </p>
    </form>
            <form method="post" action="newBeer.jsp">
                    <br> New User: <br>
                    <input type="submit" value="Create new Account">
           	</form>
            
    </body>
    </html>
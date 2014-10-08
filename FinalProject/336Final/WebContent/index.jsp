    <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
            pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
    <%@ page import="javax.servlet.http.*,javax.servlet.*"%>
     
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    
    
    <html>
<head>
	   <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  <title>Rutgers forum Login</title>
  <style>
  
	table, td{  
  		border: 1px solid;
  		}
  		
  	#login_areaTable{
  		background-color: #D8D8D8 
  	}
  	
form {
    margin: 0;
}
body {
    background: none repeat scroll 0 0 #EFF2F8;
    color: #333333;
    font-family: Verdana,Arial,Helvetica,sans-serif;
    font-size: 14px;
    height: 100%;
    margin: 0;
    width: 100%;
}
a {
    color: #5982AE;
    text-decoration: none;
}
a:hover {
    color: #4593E7;
}

td {
    color: #333333;
    font-family: Verdana,Arial,Helvetica,sans-serif;
    font-size: 14px;
}

.top_control_tab_middle a {
    background: none repeat scroll 0 0 #385F8D;
    color: #FFFFFF;
    display: block;
    height: 22px;
    padding: 6px 10px 0;
    text-align: center;
}
.top_control_tab_middle a:hover {
    background: none repeat scroll 0 0 #204066;
}
.bottom_control_tab_middle a {
    background: none repeat-x scroll 0 0 #385F8D;
    color: #FFFFFF;
    display: block;
    height: 22px;
    padding: 6px 10px 0;
    text-align: center;
}
.bottom_control_tab_middle a:hover {
    background: none repeat scroll 0 0 #204066;
}

#topnavTable {
    float: left;
}
.topnav_bg_img {
    background-color: #204066;
    padding-top: 0;
}
.register_img {
    width: 25px;
}
.login_img {
    width: 25px;
}
.search_img {
    width: 25px;
}
.new_post_img {
    width: 25px;
}
.topnav_link_default {
    background: none repeat scroll 0 0 #FFFFFF;
    color: #000000;
    font-weight: bold;
    padding: 0 12px;
    text-align: center;
}
.topnav_middle {
    background-position: left center;
    background-repeat: no-repeat;
    display: block;
    line-height: 33px;
    padding: 0 10px;
    text-align: center;
}
.topnav_middle a {
    color: #FFFFFF;
    font-family: Verdana,Arial,Helvetica,sans-serif;
    font-size: 14px;
    padding: 0 12px;
}
.topnav_middle a:hover {
    background-color: #1A264C;
    color: #FFFFFF;
    padding: 7px 12px;
}
#login_areaTable {
    background-image: url("/skins/mb/elegance/images/login_area_bg.gif");
    background-repeat: repeat;
    height: 118px;
}
.table_topleft_corner {
    background-image: url("/skins/mb/elegance/images/table_tlc.png");
    background-position: left top;
    background-repeat: repeat-x;
    border: medium none !important;
    height: 37px;
    width: 3px;
}
.table_topright_corner {
    background-image: url("/skins/mb/elegance/images/table_trc.png");
    background-position: right top;
    border: medium none !important;
    height: 37px;
    width: 7px;
}
.table_top_middle {
    background-image: url("/skins/mb/elegance/images/table_tbg.png");
    background-repeat: repeat-x;
    border: medium none !important;
}
.sub_heading_row {
    background-color: #D8DEEB;
}
.sub_heading_row a {
    font-size: 12px;
    font-weight: normal;
}
.sub_heading_row a:hover {
    color: #000000;
}
.sub_heading_row td {
    color: #000000;
    font-weight: normal;
    padding-bottom: 6px;
    padding-left: 10px;
    padding-top: 8px;
}
.table_header {
    color: #FFFFFF;
    font-weight: bold;
    padding: 6px;
    text-decoration: none;
}
.table_header a {
    color: #FFFFFF;
}
.table_header a:hover {
    color: #79BDED;
}
.tables {
    border-collapse: collapse;
}

.table_row td {
    background-color: #EFF2F8;
    color: #333333;
    padding: 8px;
}
.alternate_table_row td {
    background-color: #F7F7F7;
    color: #000000;
    padding: 8px;
}
.nested_invisible_table td {
    border: medium none;
    padding: 1px;
}
.body_container {
    margin: auto;
    text-align: left;
    width: 96%;
}
.table_bottomright_corner {
    background-image: url("/skins/mb/elegance/images/table_tbg.png");
}
.table_bottom_middle {
    background-image: url("/skins/mb/elegance/images/table_tbg.png");
    height: 35px;
}
.table_top_middle table_header {
    color: #FFFFFF;
    padding-right: 7px;
}
.table_bottomleft_corner {
    background-image: url("/skins/mb/elegance/images/table_tbg.png");
    background-repeat: repeat-x;
}
.textArea {
    padding: 4px;
}
.txtBox {
    padding: 4px;
}
.dropDown {
    padding: 2px;
}
label {
    cursor: pointer;
}
.desc {
    color: #A4A4A4;
    font-size: 14px;
}
.forum_desc {
    color: #242424;
    font-size: 14px;
}
.forum_title {
    color: #20384D;
    font-size: 15px;
    font-weight: bold;
}
.thread_title {
    font-size: 15px;
}
.table_bottom_txt:hover {
    color: #FFFFFF !important;
}
 		
  </style>
</head>

  <body>

<!-- logo -->
	<a name="top"></a>
	<br><table class="page" cellpadding="0" cellspacing="0" align="center" border="0" width="96%">
	<tbody><tr>
		<td width="8">&nbsp;</td>
		<td valign="top" width="424">
			
			<img src=http://darylgeorge.com/wp-content/uploads/2013/10/2forum.jpg alt="Image" height="80" width="450" border="0"></a>
		</td>
		<td align="right">
			<td valign="top" width="424"><font color="#152437"><font size="2"><b>Welcome To The Forums!</b></font>
			<font color="#152437"><font size="2"><br>Register or Log in to start posting<br>
			</font></font></font>

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
			<table id="topnavTable" cellpadding="0" cellspacing="0" border="0">
				<tbody><tr>
					<td>
					<table id="top_navButtonTable" class="topnav_active" cellpadding="0" cellspacing="0" border="0">
						<tbody><tr>										

<!-- Navigation Link Block -->

	<td class="register_img" valign="bottom"></td>
	<td class="topnav_middle" id="td_tab_register"><a href="RegisterPage.jsp" id="anchor_tab_register">Register</a></td>
								

<!-- Navigation Link Block -->

	
		<td class="top_nav_divider"></td>
	
	

	
				</tr>
					</tbody></table>
					</td>
				</tr>
			</tbody></table>
		</td>
		<td class="topnav_right_img"></td>
	</tr>
</tbody></table>
<!-- End of Top Navigation -->


</body>

    <h2>Login</h2>

    <form method="post" action="LoggedIn.jsp">
      <p>
        <strong>User ID</strong>
        <input type="text" size="20" name="user">
        <strong>Password</strong>
        <input type="password" size="20" name="password">
      </p>

      <p>
        <input type="submit" name="login" value="Login">
      </p>
            
    </body>
    </html>
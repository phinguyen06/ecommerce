<%@ page contentType="text/html; charset=iso-8859-1" language="java"
import="java.sql.*" errorPage="" %>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body><h1>Test
</h1>
<% String url = "jdbc:mysql://ebizdeal.db.4247188.hostedresource.com:3306/ebizdeal";
String user= "ebizdeal";
String pass= "Hona1%%";
try{
Class.forName ("com.mysql.jdbc.Driver").newInstance ();
Connection conn = DriverManager.getConnection(url, user, pass);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery("select code from State");

 

while(rs.next())
{
%>
<table> <tr>
<td><%= rs.getString("code") %></td>
</tr></table>
<%}
rs.close();
conn.close();
}catch(Exception e)
{
out.println(e.toString());
}
%>
</body>
</html>
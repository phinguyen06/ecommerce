<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page import="java.util.Map"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.Iterator"%>

<%
String message = null;
Map<String,String> env = System.getenv();
System.setProperty("https.proxySet","false");
	
%>

<script language=javascript>

</script>

<head>
<title>Wood Crafts</title>
<LINK href=../include/app.css type="text/css" rel="stylesheet">
<LINK href=../include/masthead.css type="text/css" rel="stylesheet">
<LINK href=../include/panels.css type="text/css" rel="stylesheet">
<LINK href=../include/buttons.css type="text/css" rel="stylesheet">
<LINK href=../include/containers.css type="text/css" rel="stylesheet">
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="content-language" content="en-us" />
</head>




<body>

<center>

<form name="frm" method="post" action="#" id="mainForm">
<center>
<table id="ctl00_columns" cellspacing="0" cellpadding="0" border="0"
	style="border-collapse: collapse;" width="1024"
	style="background-image:url(/ebiz/wood/images/pageBackground.jpg); PADDING-BOTTOM: 0px; background-repeat: no-repeat; PADDING-LEFT: 0px ">
	<tr>
		<td width=20>&nbsp;</td>
		<td width="150" id="ctl00_leftColumn" valign="top"><br>
		<br>
		<br>
		</td>
		<br>
		<br>
		<td width=10>&nbsp;</td>
		<td style="vertical-align: top; "><br>
		<br>
	<% if( message != null ){  %>	
		<td colspan="2" align=center><h4><i><font color=red><%=message%></font></i></h4></td>
	<% }else{ %>
		<td colspan="2" align=left>	
		<h1 class="leftMenuTitleFont"><center>Error Queue</center></h1>
		<table cellspacing="0" cellpadding="2" border="3" style="width: 100%; border-collapse: ">
			<tr bgcolor=#CCCCCC>
				<th align=center width=50>ID</th>
				<th width=50 align=center>Data</th>
			</tr>
		<% 
		Set set = env.entrySet();
		for( Iterator iter = set.iterator(); iter.hasNext(); ){ 
			Object key = iter.next();
		%>
			<tr>
				<td align=center><%=key%></td>
				<td align=right><%="abc"%></td>
			</tr>
		<% } //close for loop %>
		</table>		
		</td>
	<% } %>
		<td width=20>&nbsp;</td>
	</tr>
</table>

</form>
</body>
</html>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page import="java.io.*"%>

<%
String message = null;
try
{
	FileInputStream file = null;

	file = new FileInputStream("/home/content/e/b/i/ebizdeal09/html/gifts/include/wood.js");
	
	
	DataInputStream in = new DataInputStream(file);

	byte[] bytes = new byte[in.available()];

	in.readFully(bytes);

	in.close();

	message = new String(bytes,0,bytes.length,"Cp850");
	
	//java.lang.Runtime run = getRuntime();
	//java.lang.Process proc = run.exec("echo $CLASSPATH");
	

}	
catch(Exception ex)
{
	message = ex.getMessage();
}
finally
{
}		
	
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

<%=message%>

</body>
</html>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page import="com.ebiz.data.Constants"%>
<%@ page import="com.ebiz.utils.SendMail"%>

<%
String message = "";
String respMessage = "";
try
{	
	String name = request.getParameter("txtName");
	String email = request.getParameter("txtEmail");
	String question = request.getParameter("taQuestion");
	validate( name, email, question );

	SendMail mail = new SendMail(email, "Wood Product Question from " + name, question);
	mail.send();
	respMessage = "Your enquiry has been successfully sent to the Support personel.";
}	
catch(Exception ex)
{
	message = ex.getMessage();
}
finally
{
}

%>

<%!
	private void validate(String name, String email, String question) throws Exception {
		if (name == null || name.length() == 0)
			throw new Exception( "Name is required" );
		if (email == null || email.length() == 0)
			throw new Exception( "Email is required" );
		if (question == null || question.length() == 0)
			throw new Exception("Question text is required");
	}
%>

<head>
<title>eBiz Global Corporation</title>

<LINK href=include/app.css type="text/css" rel="stylesheet">
<LINK href=include/masthead.css type="text/css" rel="stylesheet">
<LINK href=include/panels.css type="text/css" rel="stylesheet">
<LINK href=include/buttons.css type="text/css" rel="stylesheet">
<LINK href=include/containers.css type="text/css" rel="stylesheet">
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="content-language" content="en-us" />
</head>
<body>
<br><br><br>
<center>
<table cellspacing="0" cellpadding="0" width="1024" align=center
style="background-image:url(images/bgframe.gif); PADDING-BOTTOM: 100px; background-repeat: no-repeat; PADDING-LEFT: 0px;  ">
	<tr>
		<td><br><br>
			<table cellspacing="2" cellpadding="0" align=center>
				<tr>
					<td align=center><img src="images/logo.gif"></td>
				</tr>
				<tr>
					<td>
						<h1 class="leftMenuTitleFont"><center>Welcome to eBiz Global Business</center></h1>
					</td>

				</tr>
				<tr>
					<td align=center>&nbsp;</td>
				</tr>
					<% if (message.length() > 0 ) { %>
						<tr>
							<td colspan=2><font color=red><%=message%></font></td>

						</tr>
					<% } %>
						<tr>
							<td colspan=2><font color=red><%=respMessage%></font>&nbsp;</td>

						</tr>
				
				<tr>
					<td>
<form name=frm action="contactEmail.jsp" method=POST>
					<h1><font color=blue><center>Contact Us</center></font></h1>
					<table cellspacing="0" cellpadding="2" border="0" style="width: 60%; border-collapse;" align=center>
						<tr>
							<td colspan=2 align=center>
								Customer Service<br>
								@eBizDeal.net<br>
								USA<br>
								support@eBizDeal.net
							</td>
						</tr>						
						<tr>
							<td width=100 align=right>Your name:</td>
							<td align=left><input type=text name=txtName maxlength="50" size="50" ></td>
						</tr>
						<tr>
							<td align=right>Your email:</td>
							<td align=left><input type=text name=txtEmail maxlength="100" size="50" ></td>

						</tr>
						<tr>
							<td align=right>Your Enquiry:</td>
							<td align=left><textarea name=taQuestion rap="" cols="60" rows="5" ></textarea></td>
						</tr>
						<tr>
							<td colspan=2 align=center>
								<br><br><a href="javascript: document.frm.submit()" class="buttontextp"><font color=blue><b>Send Email</b></font></a>

							</td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
</form>
		</td>
	</tr>
	<tr>
		<td align=center><a href="/"><br><br>Home</a>
		| <a href="contactUs.html">Contact Us</a>
		| <a href="aboutUs.html">About Us</a>
		<br>
		@ 2009 eBizDeal.net
		</td>
	</tr>
</table>
</center>
</body>
</html>

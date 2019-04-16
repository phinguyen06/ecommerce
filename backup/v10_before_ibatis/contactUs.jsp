<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page import="com.ebiz.data.WoodCategory"%>
<%@ page import="com.ebiz.data.Tracker"%>
<%@ page import="com.ebiz.data.Constants"%>
<%@ page import="com.ebiz.cache.CustomerSession"%>
<%@ page import="com.ebiz.cache.WoodCategoryDataProvider"%>
<%@ page import="com.ebiz.cache.TrackerDataProvider"%>
<%@ page import="com.ebiz.utils.SendMail"%>

<%
String message = "";
WoodCategory[] categories = new WoodCategory[1];
int catId = -1;
String respMessage = null;
try
{	
	categories = WoodCategoryDataProvider.getInstance().getAllCategories();
	if( request.getParameter("hdnOp") != null )
	{
		String name = request.getParameter("txtName");
		String email = request.getParameter("txtEmail");
		String question = request.getParameter("taQuestion");
		validate( name, email, question );
		
		SendMail mail = new SendMail("phi2006@gmail.com", "Wood Product Question from " + name, " email: " + email, question);
		mail.send();
		respMessage = "Your enquiry has been successfully sent to the Support personel.";
	}
}	
catch(Exception ex)
{
	message = ex.getMessage();
}
finally
{
}

//add counter for page usages
try{
	Tracker t = new Tracker();
	t.setCategoryId(catId);
	t.setProductType(Constants.s_PRODUCT_TYPE_WOOD);
	t.setPage("contactUs");
	t.setClientId(request.getRemoteAddr());
	TrackerDataProvider.getInstance().addTracker(t);
}
catch(Exception ignore){}

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
<title>Ideal Wood Gifts</title>
<LINK href=include/app.css type="text/css" rel="stylesheet">
<LINK href=include/masthead.css type="text/css" rel="stylesheet">
<LINK href=include/panels.css type="text/css" rel="stylesheet">
<LINK href=include/buttons.css type="text/css" rel="stylesheet">
<LINK href=include/containers.css type="text/css" rel="stylesheet">
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="content-language" content="en-us" />
</head>

<script language="JavaScript" type="text/javascript" src="include/wood.js"></script>


<body>
<form name="frm" method="post" action="contactUs.jsp">
<center>
<table cellspacing="0" cellpadding="0" width="1024">
<tr>
	<td width=5%></td>
 	<td width=20 align=left><img src="images/logo.gif"></td>
 	<td width=500>
	<table cellspacing="0" cellpadding="0" width="100%" align=center>
		<tr>
			<td align=center colspan=2><br>
			<table cellspacing="0" cellpadding="0" width="500" align=center>
			  <tr>
				<td width=73 background="images/menubg2a.gif" align=center>		
					<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif" title="Return Home" href="<%=Constants.s_PAGE_ROOT_WOOD%>"><font COLOR="white">&nbsp;&nbsp;Home&nbsp;&nbsp;</font></a>
				</td>
				<td width=1></td>
				<td width=108 background="images/menubg3a.gif" align=center>				
					<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif" title="My Account" href="Logon.jsp"><font COLOR="white">My Account</font></a>
				</td>
				<td width=1></td>
				<td width=186 background="images/menubg4a.gif" align=center>
					<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif" title="View Cart and Checkout" href="cartSummary.jsp"><font COLOR="white">View Cart/Checkout</font></a>
				</td>
				<td width=1></td>
				<td width=108 background="images/menubg3a_f.gif" align=center>
					<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif" title="Contact Us" href="contactUs.jsp"><font COLOR="black">&nbsp;Contact Us</font></a>
				</td>
				<td><h5>&nbsp;</h5></td>
		      </tr>
			</table>					
			</td>
		</tr>
	</table>
    </td>
    <td width=20%></td>
 </tr>
</table>

<table cellspacing="0" cellpadding="0" border="0" width="1024"
	style="background-image:url(images/pageBackground8.jpg); PADDING-BOTTOM: 300px; background-repeat: no-repeat; PADDING-LEFT: 0px; border-collapse: collapse; ">
	<tr>
		<td width=20>&nbsp;</td>
		<td width="200" valign="top"><br>
		<table border="0" cellpadding="0" cellspacing="0" width="100%"
			style="background-image: url(images/sidemenubgxx.jpg); PADDING-BOTTOM: 100px; vertical-align: top; PADDING-LEFT: 0px; PADDING-RIGHT: 10px; PADDING-TOP: 0px">
			<tr>
				<td align=left><br>
				<br>
				<br> <!--<img src="images/shop.jpg" alt="Browse Categories" />-->
				<center>
				<h3 class="leftMenuTitleFont">Shop</h3>
				</center>
				<ul>
					<% for(int i=0; i<categories.length; i++ ) { %>
					<li><a href="index.jsp?cat=<%=categories[i].getId()%>" class="leftMenuFont">
							<%=categories[i].getName()%></a></li>
					<br>
					<%} %>
				</ul>
				</td>
			</tr>
		</table>
		</td>
		<td width=10>&nbsp;</td>
		<td id="ctl00_centerColumn" style="vertical-align: top; " valign="top">
		<br><br>
		<h1 class="leftMenuTitleFont"><center>Contact Us</center></h1><br>
		<table cellspacing="0" cellpadding="2" border="0" style="width: 60%; border-collapse;" align=center>
			<tr>
				<td colspan=2 align=center>
					<% if( respMessage != null ){ %>
							<%=respMessage%><br>
					<% }else{ 
							if( message != null ){
					%>				
							<font color=red><h4><center><%=message%></center></h4></font><br>
					<% }%>
				
				
					Customer Service<br>
					@Gift<br>
					14008 109th AVE NE<br> 
					KIRKLAND, WA 98034<br>
					USA<br>
					ebiz-global@gmail.com
				</td>
			</tr>
			<tr>
				<td colspan=2>&nbsp;</td>
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
				<td align=left><textarea name=taQuestion rap="" cols="60" rows="10" ></textarea></td>
			</tr>
			<tr>
				<td colspan=2 align=center>
					<br><br><input type="image" src="images/button_continue.gif" onclick="javascript: document.frm.hdnOp.value='submit'; document.frm.submit() " border="0" alt="Submit"  name="btnSubmit" value="submit"/>
				</td>
			</tr>
		</table>
<% } %>		
		</td>
		<td width=20>&nbsp;</td>
	</tr>
</table>
<input type=hidden name=hdnOp>
</form>
<br><br><br>
<center>
<table cellspacing="0" cellpadding="0">
	<tbody>
		<tr>
			<td><a href="index.html">Home</a> 
			| <a href="Logon.jsp">My Account</a> 
			| <a href="shippingPolicy.jsp">Shipping Policy</a> 
			| <a href="returnPolicy.jsp">Return Policy</a> 
			| <a href="privacyPolicy.jsp">Privacy Policy</a>  
			| <a href="contactUs.jsp">Contact Us</a> 
			</td>
		</tr>
		<tr>
			<td class="containerFooter" align="center">© 2009 Power by eBizDeal.net</td>
		</tr>
	</tbody>
</table>
</center>
</body>
</html>

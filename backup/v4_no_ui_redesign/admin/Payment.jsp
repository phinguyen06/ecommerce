<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page import="com.ebiz.data.Constants"%>
<%@ page import="com.ebiz.data.Payment"%>
<%@ page import="com.ebiz.data.Order"%>
<%@ page import="com.ebiz.db.WoodDB"%>
<%@ page import="com.ebiz.cache.CustomerSession"%>
<%@ page import="java.util.HashMap"%>

<%
String message = null;
Payment payment = null;
try
{
	//Validate admin permission
	CustomerSession.validateAdminPermission(response, session);
	
	String orderId = request.getParameter("orderId");
	if( orderId == null || orderId.trim().length() == 0 )
		throw new Exception("Order ID is required");
	HashMap<String,Order> map = (HashMap<String,Order>) session.getAttribute(Constants.s_CUSTOMER_REVIEW_CART);
	payment = (map.get(orderId)).getPayment();
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

<center>
<table cellspacing="0" cellpadding="0" width="100%">
	<tbody>
		<tr>
			<td width="348" style="PADDING-BOTTOM: 10px">&nbsp;</td>
			<td align=left><a title="Return Home" href="/"><img alt="logo" src="../images/logo.jpg" /></a></td>
		</tr>
		<tr>
			<td align=center colspan=2><br><br>
			<table cellspacing="0" cellpadding="0" width="500" align=center>
			  <tr>
				<td background="../images/menubg.jpg" align=center>		
				 	<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif"" title="Return Home" href="<%=Constants.s_PAGE_ROOT_WOOD%>"><font COLOR="white">&nbsp;&nbsp;&nbsp;Home&nbsp;&nbsp;&nbsp;</font></a>
				</td>
				<td background="../images/menubg.jpg" align=center>				
			 		<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif"" title="My Account" href="Logon.jsp"><font COLOR="white">My Account</font></a>
			 	</td>
				<td background="../images/menubg.jpg" align=center>
			 		<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif"" title="View Cart and Checkout" href="cartSummary.jsp"><font COLOR="white">View Cart/Checkout</font></a>
				</td>
				<td background="../images/menubg.jpg" align=center>
					<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif"" title="Contact Us" href="contactUs.jsp"><font COLOR="white">Contact Us</font></a>
				</td>
				<td><h5>&nbsp;</h5></td>
		      </tr>
			</table>					
		
			</td>
		</tr>
	</tbody>
</table>
</center>

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
		<table border="0" cellpadding="0" cellspacing="0"
			style="background-image: url(images/sidemenubg.jpg); PADDING-BOTTOM: 200px; vertical-align: top; PADDING-LEFT: 0px; PADDING-RIGHT: 30px; PADDING-TOP: 0px">
			<tr>
				<td align=left><br>
				<br>
				<br> <!--<img src="images/shop.jpg" alt="Browse Categories" />-->
				<center>
				<h3 class="leftMenuTitleFont">Admin</h3>
				</center>
				<ul class="leftMenuFont">
					<li><a href="<%=Constants.s_PAGE_ROOT_ADMIN%>Orders.jsp">View Orders</a></li>
				</ul>
				</td>
			</tr>
		</table>
		</td>
		<br>
		<br>
		<td width=10>&nbsp;</td>
		<td id="ctl00_centerColumn" style="vertical-align: top; "><br>
		<br>
	<% if( message != null ){  %>	
		<td colspan="2" align=center><h4><i><font color=red><%=message%></font></i></h4></td>
	<% }else{ %>
		<td colspan="2" align=left>	
		<h1 class="leftMenuTitleFont"><center>Order Payment</center></h1>
		<table cellspacing="0" cellpadding="2" border="3" style="width: 100%; border-collapse: ">
			<tr bgcolor=#CCCCCC>
				<th align=center>Payer Name</th>
				<th width=50 align=center>Card Type</th>
				<th width=100 align=center>Card Number</th>
				<th width=100 align=center>Card Exp Date</th>
				<th width=50 align=center>Card CVV</th>
				<th width=50 align=center>Charge Amount</th>
				<th width=100 align=center>Create Date</th>
				<th width=100 align=center>Update Date</th>
			</tr>
			<tr>
				<td align=center><%=payment.getCardHolderName()%></td>
				<td align=center><%=payment.getCardType()%></td>
				<td align=center><%=payment.getCardNumber()%></td>
				<td align=center><%=payment.getCardExpDateString()%></td>
				<td align=center><%=payment.getCardCVV()%></td>
				<td align=right><%=payment.getAmount()%></td>
				<td align=center><%=payment.getCreateDate()%>&nbsp;</td>
				<td align=center><%=payment.getUpdateDate()==null ? "" : payment.getUpdateDate()%>&nbsp;</td>
			</tr>
		</table><br><br>
		<table cellspacing="0" cellpadding="2" border="3" style="width: 800; border-collapse: ">
			<tr bgcolor=#CCCCCC>
				<th width=150 align=center>Vendor Confirm No</th>
				<th align=center>Vendor Response</th>
			</tr>
			<tr>
				<td align=center><%=payment.getVendorConfirmationNo()==null ? "" : payment.getVendorConfirmationNo()%>&nbsp;</td>
				<td align=center><%=payment.getVendorResponse()==null ? "" : payment.getVendorResponse()%>&nbsp;</td>
			</tr>
		</table>						
		</td>
	<% } %>
		<td width=20>&nbsp;</td>
	</tr>
</table>

<br><br><br><br>

</form>

<center>
<table cellspacing="0" cellpadding="0">
	<tbody>
		<tr>
			<td><a href="/">Home</a> 
			| <a href="Logon.jsp">My Account</a> 
			| <a href="shippingPolicy.jsp">Shipping Policy</a> 
			| <a href="returnPolicy.jsp">Return Policy</a> 
			| <a href="privacyPolicy.jsp">Privacy Policy</a>  
			| <a href="contactUs.jsp">Contact Us</a> 
			</td>
		</tr>
		<tr>
			<td class="containerFooter" align="center">© 2009 www.eBiz.com
			</td>
		</tr>
	</tbody>
</table>
</center>
</body>
</html>

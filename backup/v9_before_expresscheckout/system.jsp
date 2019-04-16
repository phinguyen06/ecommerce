<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page import="com.ebiz.data.Customer"%>
<%@ page import="com.ebiz.data.Order"%>
<%@ page import="com.ebiz.data.Payment"%>
<%@ page import="com.ebiz.payment.IPayment"%>
<%@ page import="com.ebiz.paypal.PayPalPayment"%>

<%
String message = null;
try{
System.setProperty("https.proxySet","false");
Customer customer = new Customer();

customer.setFirstName("PHI");
customer.setLastName("NGUYEN");
customer.setEmail("phi@gmail.com");
customer.setContactPhone("2062260043");
customer.setContactFax("2062260043");
customer.setPassword("passwd");
customer.setAddress1("5421 33RD CT SE");
customer.setAddress2(" line 2");
customer.setCity("LACEY");
customer.setState("WA");
customer.setZip("98503");
customer.setZip4("4445");
customer.setCountry("US");
customer.setShipAddress1("124 main st");
customer.setShipAddress2(" line 2");
customer.setShipCity("lacey");
customer.setShipState("wa");
customer.setShipZip("98504");
customer.setShipZip4("9999");
customer.setShipCountry("US");

java.text.SimpleDateFormat fm = new java.text.SimpleDateFormat("MMyyyy");

Payment payment = new Payment();
payment.setCardHolderName("PHI NGUYEN");
payment.setCardType("Visa");
payment.setCardNumber("4652137160583194");
payment.setCardCVV("000");
payment.setCardExpDate(fm.parse("032019"));
payment.setAmount(0.1);
 		 
Order order = new Order();
order.setProductType("WOOD");
order.setComments("comment me not");

order.setCustomer(customer);
order.setPayment(payment);	

IPayment pmt  = new PayPalPayment();
pmt.processPayment(order);
}
catch(Exception e)
{
	message = e.toString();
	
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
		</table>		
		</td>
	<% } %>
		<td width=20>&nbsp;</td>
	</tr>
</table>

</form>
</body>
</html>

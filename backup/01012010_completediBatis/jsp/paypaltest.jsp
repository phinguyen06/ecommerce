<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page import="com.paypal.sdk.exceptions.PayPalException"%>
<%@ page import="com.paypal.sdk.profiles.APIProfile"%>
<%@ page import="com.paypal.sdk.profiles.ProfileFactory"%>
<%@ page import="com.paypal.sdk.services.NVPCallerServices"%>
<%@ page import="com.paypal.sdk.core.nvp.NVPEncoder"%>


<%
String message = null;
try{
	System.setProperty("https.proxySet","false");

	String VERSION = "56.0";
	String METHOD_DIRECT_PAYMENT = "DoDirectPayment";
	String PAYMENT_ACTION_SALE = "Sale";

	NVPEncoder encoder = new NVPEncoder();

	encoder.add("VERSION", VERSION);
	encoder.add("METHOD",METHOD_DIRECT_PAYMENT);

	// Add request-specific fields to the request string.
	encoder.add("PAYMENTACTION",PAYMENT_ACTION_SALE);
	encoder.add("AMT","0.1");
	encoder.add("CREDITCARDTYPE","Visa");		
	encoder.add("ACCT","4652137160583194");						
	encoder.add("EXPDATE","03/2019");
	encoder.add("CVV2","000");
	encoder.add("FIRSTNAME","BRANDON");
	encoder.add("LASTNAME","NGUYEN");
	encoder.add("STREET","526 165TH AVE NE");
	encoder.add("CITY","BELLEVUE");	
	encoder.add("STATE","WA");			
	encoder.add("ZIP","98006");	
	encoder.add("COUNTRYCODE","US");

	// Execute the API operation and obtain the response.
	String reqStr = encoder.encode();

	NVPCallerServices caller = new NVPCallerServices();
	APIProfile profile = ProfileFactory.createSignatureAPIProfile();
	profile.setAPIUsername("brando_1236904149_biz_api1.yahoo.com");
	profile.setAPIPassword("1236904156");
	profile.setSignature("Az-d2M7YeHW.K9EvxlnkjtZJbVRKAlVAvKD08puJ8JstAkWxo5TwvXZz");
	profile.setEnvironment("https://api-3t.sandbox.paypal.com/nvp");
	//profile.setSubject("");
	caller.setAPIProfile(profile);

	message =(String) caller.call(reqStr);
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
		<td colspan="2" align=center><h4><i><font color=red><%=message%></font></i></h4></td>
		<td width=20>&nbsp;</td>
	</tr>
</table>

</form>
</body>
</html>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page import="com.ebiz.data.WoodCategory"%>
<%@ page import="com.ebiz.data.Tracker"%>
<%@ page import="com.ebiz.data.Constants"%>
<%@ page import="com.ebiz.cache.CustomerSession"%>
<%@ page import="com.ebiz.cache.WoodCategoryDataProvider"%>
<%@ page import="com.ebiz.cache.TrackerDataProvider"%>

<%
String message = "";
WoodCategory[] categories = new WoodCategory[1];
int catId = -1;
try
{	
	categories = WoodCategoryDataProvider.getInstance().getAllCategories();
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
	t.setPage("returnPolicy");
	t.setClientId(request.getRemoteAddr());
	TrackerDataProvider.getInstance().addTracker(t);
}
catch(Exception ignore){}

%>


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
	</tbody>
</table>
</center>

<form name="frm" method="post" action="#" id="mainForm">
<center>
<table id="ctl00_columns" cellspacing="0" cellpadding="0" border="0" width="1024"
	style="background-image:url(/ebiz/wood/images/pageBackground.jpg); PADDING-BOTTOM: 30px; background-repeat: no-repeat; PADDING-LEFT: 0px; border-collapse: collapse; ">
	<tr>
		<td colspan=6>
			<table cellspacing="0" cellpadding="0" width="100%" align=center>
					<tr>
						<td align=center colspan=2><br>
						<table cellspacing="0" cellpadding="0" width="500" align=center>
						  <tr>
							<td background="../images/menubg.jpg" align=center>		
							 	<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif" title="Return Home" href="<%=Constants.s_PAGE_ROOT_WOOD%>"><font COLOR="white">&nbsp;&nbsp;&nbsp;Home&nbsp;&nbsp;&nbsp;</font></a>
							</td>
							<td background="../images/menubg.jpg" align=center>				
						 		<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif" title="My Account" href="Logon.jsp"><font COLOR="white">My Account</font></a>
						 	</td>
							<td background="../images/menubg.jpg" align=center>
						 		<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif" title="View Cart and Checkout" href="cartSummary.jsp"><font COLOR="white">View Cart/Checkout</font></a>
							</td>
							<td background="../images/menubg.jpg" align=center>
								<a style="TEXT-DECORATION: none; FONT-SIZE: 14px; COLOR: #333; FONT-FAMILY: arial,sans-serif" title="Contact Us" href="contactUs.jsp"><font COLOR="white">Contact Us</font></a>
							</td>
							<td><h5>&nbsp;</h5></td>
					      </tr>
						</table>					
						</td>
					</tr>
			</table>		
		</td>
	</tr>	
	<tr>
		<td width=20>&nbsp;</td>
		<td width="200" valign="top"><br>
		<table border="0" cellpadding="0" cellspacing="0" width="100%"
			style="background-image: url(images/sidemenubg.jpg); PADDING-BOTTOM: 100px; vertical-align: top; PADDING-LEFT: 0px; PADDING-RIGHT: 10px; PADDING-TOP: 0px">
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
		<td id="ctl00_centerColumn" style="vertical-align: top; " valign="top"><br>
		<br>
		<h1 class="leftMenuTitleFont"><center>Return Policy</center></h1>
		<table cellspacing="0" cellpadding="2" border="0" style="width: 50%; border-collapse;" align=center>
			<tr>
				<td style="FONT-SIZE: 14px; FONT-FAMILY: Verdana; ">
					@Gift guarantees your complete satisfaction with every purchase. 
					Our goal is to provide excellent quality products and workmanship. 
					If for any reason you would like to return an item(s) purchased at eBiz.com.
					you may return it within 14 days of the purchase for a refund (Returns made past the allowed 
					time frames referenced above will receive a store credit only).
					The buyer will be responsible for paying the shipping cost to send package back and 
					will NOT be credited back the shipping cost.
					
					All returns must be in its original condition, unused and in sellable condition. 
					If you have any questions or concerns, please email us at 
					<a href="mailto:ebiz_global@gmail.com">ebiz_global@gmail.com</a>.
					 
					<br><br><b>***Damage Claim</b> 
					Any claim of damage caused by UPS, FedEx, USPS or other Courier (crushed boxes) must be made with that particular courier to initiate claim for damages. 
					We will be happy to work with the customer in filing the damage claim, however a claim must be initiated first by the customer. 
					Any and all damage claim must be made with 48 hours of receipt of package.
					We will not be responsible for any replacements if the damage is not reported to us in 10 calendar days. 
					Afterwards, all shipment will be considered to be in good condition. 
 
				</td>
			</tr>
		</table>
		</td>
		<td width=20>&nbsp;</td>
	</tr>
</table>


</form>
<br><br><br>
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

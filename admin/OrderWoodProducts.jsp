<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page import="com.ebiz.data.Constants"%>
<%@ page import="com.ebiz.data.OrderWoodProduct"%>
<%@ page import="com.ebiz.db.WoodDB"%>
<%@ page import="com.ebiz.cache.CustomerSession"%>

<%
String message = null;
OrderWoodProduct[] woodOrders = null;
try
{
	//Validate admin permission
	CustomerSession.validateAdminPermission(response, session);
	
	String orderId = request.getParameter("orderId");
	if( orderId == null || orderId.trim().length() == 0 )
		throw new Exception("Order ID is required");
	woodOrders = WoodDB.getOrderWoodProducts(Integer.parseInt(orderId));
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
		<h1 class="leftMenuTitleFont"><center>Wood Order List</center></h1>
		<table id="ctl00_pageContent_ctl00_productList" cellspacing="0"
			cellpadding="2" border="3" style="width: 100%; border-collapse: ">
			<tr bgcolor=#CCCCCC>
				<th align=center colspan=2>Product</th>
				<th width=50 align=center>Quantity</th>
				<th width=50 align=center>Price</th>
			</tr>
		<% for( int i=0; i<woodOrders.length; i++ ){ %>
			<tr>
				<td width=50><a href="#">
					  <img alt="<%=woodOrders[i].getWoodProduct().getName()%>"
					  src="../wood/<%=woodOrders[i].getWoodProduct().getCategory().getUrlPath()+"s"+woodOrders[i].getWoodProduct().getImageName()%>"
					  class="containerBody-img" />
				    </a>
				</td>
				<td><%=woodOrders[i].getWoodProduct().getName()%></td>				
				<td width=50 align="right"><%=woodOrders[i].getQuantity()%></td>
				<td width=50 align="right"><%=woodOrders[i].getWoodProduct().getPrice()%></td>
			</tr>
		<% } %>
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
			| <a href="../contactUs.html">Contact Us</a> 
			</td>
		</tr>
		<tr>
			<td class="containerFooter" align="center">© 2009 www.eBiz.com</td>
		</tr>
	</tbody>
</table>
</center>
</body>
</html>

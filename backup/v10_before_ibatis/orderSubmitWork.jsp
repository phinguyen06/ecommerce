<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page import="com.ebiz.data.Constants"%>
<%@ page import="com.ebiz.data.OrderWoodProduct"%>
<%@ page import="com.ebiz.cache.CustomerSession"%>
<%@ page import="com.ebiz.process.ProcessOrder"%>

<%
try {
	System.setProperty("https.proxySet","false");
	OrderWoodProduct[] orderProducts = (OrderWoodProduct[]) session.getAttribute(Constants.s_CUSTOMER_ORDER_CART);
	orderProducts[0].getOrder().setClientId(request.getRemoteAddr());
	orderProducts[0].getOrder().setStatus(String.valueOf(Constants.s_ORDER_PROCESSING_CODE));
	ProcessOrder p = new ProcessOrder();
	p.processOrder(orderProducts);
	session.setAttribute(Constants.s_CUSTOMER_ORDER_CART,orderProducts);
	response.sendRedirect(Constants.s_PAGE_ROOT_WOOD+ "orderConfirmation.jsp");
} catch (Exception e) {
	e.printStackTrace();
	session.setAttribute(Constants.s_ERROR, e.getMessage());
	response.sendRedirect(Constants.s_PAGE_ROOT_WOOD + "error.jsp");
} finally {
}

%>

<head></head>
<body></body>
</html>
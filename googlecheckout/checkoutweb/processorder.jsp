<!-- 
 * Copyright (C) 2007 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 -->
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ page import="java.util.Date" %>
<%@ page import="com.google.checkout.example.GoogleOrder" %>
<%@ page import="com.google.checkout.MerchantConstants" %>
<%@ page import="com.google.checkout.orderprocessing.ProcessOrderRequest" %>
<%@ page import="com.google.checkout.CheckoutResponse" %>
<%@ page import="com.google.checkout.example.MerchantConstantsFactory" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Process Order</title>
</head>
<body>
<script language="JavaScript">
  function postIt(v) {
     document.forms[0].button.value=v;
     document.forms[0].submit();
  };
</script>
<%
    String button = request.getParameter("button");

    MerchantConstants mc = MerchantConstantsFactory.getMerchantConstants();

    ProcessOrderRequest processRequest;
	String orderNumber = request.getParameter("orderNumber") == null ? "" : request.getParameter("orderNumber");
    
    String prettyXml = null;
	String responseXml = null;
	
  if (button == null || button.equals("")) {
	  processRequest = new ProcessOrderRequest(mc);
	  session.setAttribute("processRequest", processRequest);
	  prettyXml = processRequest.getXmlPretty();
	  responseXml = "";
  }
  else if (button.equals("NewRequest")) {
	  processRequest = new ProcessOrderRequest(mc);
	  session.setAttribute("processRequest", processRequest);
	  prettyXml = processRequest.getXmlPretty();
	  responseXml = "";
  }
  else if (button.equals("AddValues")) {
	  processRequest = (ProcessOrderRequest) session.getAttribute("processRequest");

	  orderNumber = request.getParameter("orderNumber");
	  
	  processRequest.setGoogleOrderNo(orderNumber);
	  
	  prettyXml = processRequest.getXmlPretty();
	  responseXml = "";
  }
  else if (button.equals("Submit")) {
	  processRequest = (ProcessOrderRequest) session.getAttribute("processRequest");
 	  CheckoutResponse res = processRequest.send();
  	  
	  prettyXml = processRequest.getXmlPretty();
	  responseXml = res.getXmlPretty();

	  GoogleOrder order = GoogleOrder.findOrCreate(mc.getMerchantId(), orderNumber);
	  order.addOutgoingMessage(new Date(), "process-order", prettyXml, responseXml);  
  }
%>
  <p>
	<h1>Process Order</h1>
    <form action="processorder.jsp" method="POST">
      <input type="hidden" name="button" value=""/>      
      <strong>MerchantId: </strong>    
      <%=mc.getMerchantId()%>
      <br/>
      <br/>      
      <table>  
	  <tr>
	    <td colspan='1'><strong>Enter the Process Details</strong></td>
	  </tr>
      <tr>
        <td>
          <table>
	      <tr>
	      	<td><input type="button" value="Set Values" onClick="postIt('AddValues')"/></td>
	      	<td>Order Number:</td><td><input type="text" name="orderNumber" value="<%=orderNumber %>"/></td>
	      </tr>
		  </table>
		</td>
       	</tr>
	  <tr>
	    <td colspan='1'><strong>Request XML</strong></td>
	  </tr>
	  <tr>
	    <td colspan='1'><textarea name="cart" readonly="true" cols="145" rows="20"><%=prettyXml%></textarea></td>
	  </tr>
	  <tr>
	    <td align="left">
          <table>
          <tr>
            <td align="center">
              <input type="button" value="Submit" onClick="postIt('Submit')"/>
            </td>
            <td align="center" valign="top">
              <input type="button" value="Or Create a New Request" onClick="postIt('NewRequest')"/>
            </td>
          </tr>
	  <tr>
          </table>
 		</td>
	  </tr>
      <tr>
	    <td colspan='1'><strong>Response XML</strong></td>
	  </tr>
	  <tr>
	    <td colspan='1'><textarea name="response" readonly="true" cols="145" rows="8"><%=responseXml%></textarea></td>
	  </tr>
      </table>
    </form>
</body>
</html>
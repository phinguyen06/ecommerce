package com.ebiz.data;

import java.text.SimpleDateFormat;

import com.ebiz.cache.ShipperDataProvider;
import com.ebiz.cache.StateDataProvider;

public class EmailConfirmation {
	
	public static String getWoodEmailShipConfirmation(OrderWoodProduct[] orderProducts) throws Exception
	{
		SimpleDateFormat fm = new SimpleDateFormat("MM/dd/yyyy");
		StringBuffer message = new StringBuffer();
		message.append("************************************************\n");
		message.append("PLEASE DO NOT RESPOND TO THIS EMAIL.\n");
		message.append("To send an email to customer service, please go to this link:\n");
		message.append("http://www.ebiz.com/wood/ \n");
		message.append("************************************************\n");
		message.append("Dear " + orderProducts[0].getOrder().getCustomer().getFirstName() + 
				" " + orderProducts[0].getOrder().getCustomer().getLastName() + " : \n\n");
		message.append("Your order from ebiz, has been shipped and your credit card has been charged.\n\n");
		message.append("Order Number:\t\t\t "+ orderProducts[0].getOrder().getConfirmationNo() +"\n");
		message.append("Order Date:\t\t\t " + fm.format(orderProducts[0].getOrder().getCreateDate()) + "\n\n");
		message.append(orderProducts[0].getOrder().getCustomer().getFirstName() + 
				" " + orderProducts[0].getOrder().getCustomer().getLastName() + " : \n\n");
		message.append(orderProducts[0].getOrder().getCustomer().getShipAddress1() + "\n");
		message.append(orderProducts[0].getOrder().getCustomer().getShipCity() + ", " +
				orderProducts[0].getOrder().getCustomer().getShipState() + " " +
				orderProducts[0].getOrder().getCustomer().getShipZip() + "\n");
		message.append(orderProducts[0].getOrder().getCustomer().getContactPhone() + "\n");
		message.append(orderProducts[0].getOrder().getCustomer().getEmail() + "\n\n");
		message.append("Product Name                                      Qty Ordered  Qty Shipped  Price\n");
		message.append("------------------------------------------------------------------------------------\n");
		for(int i=0; i<orderProducts.length; i++){
			message.append(orderProducts[i].getWoodProduct().getName() + "\t" +
					orderProducts[i].getQuantity() + "\t" +
					"SHIPPING COST \t" +
					orderProducts[i].getWoodProduct().getPrice() + "\n");
		}
		message.append("------------------------------------------------------------------------------------\n");
		//Tax rate
		double taxRate = (StateDataProvider.getInstance().getState(
				orderProducts[0].getOrder().getCustomer().getState(), 
				orderProducts[0].getOrder().getCustomer().getCountry()).getTaxRate())/100;
		message.append("                                                                 Tax:   $" +  
				com.ebiz.utils.Util.formatNumber((taxRate * orderProducts[0].getOrder().getPayment().getAmount()), 2)+"\n");
		//Shipping cost
		String sVendor = String.valueOf(orderProducts[0].getOrder().getShipping().getVendor().getId());
		message.append("                                                            Shipping:   $" +
				(ShipperDataProvider.getInstance().getShipper(sVendor)).getCost() +"\n");
		message.append("                                                               Total:  $" + 
				com.ebiz.utils.Util.formatNumber(orderProducts[0].getOrder().getPayment().getAmount(), 2) + "\n\n");
		message.append("Tracking Number\n");
		message.append("---------------------------------------\n");
		message.append("xxxxxxxxxxxxxxx\n\n");
		message.append("Note: International Postal shipments (EMI Tracking) are not issued tracking numbers. Please allow up to 14 business days for delivery.\n\n");
		message.append("Shipping Method\n");
		message.append("---------------------------------------------------------------------------------------------------\n");
		message.append("Economy Postal Mail                                      Track your order at http://www.usps.com\n");
		message.append("(UPS Ground)                                             Track your order at http://www.ups.com\n");
		message.append("(UPS 2nd Day)                                            Track your order at http://www.ups.com\n");
		message.append("(UPS Overnight)                                          Track your order at http://www.ups.com\n");
		
		return message.toString();
	}

	public static String getWoodEmailConfirmation(OrderWoodProduct[] orderProducts) throws Exception
	{
		SimpleDateFormat fm = new SimpleDateFormat("MM/dd/yyyy");
		StringBuffer message = new StringBuffer();
		message.append("************************************************\n");
		message.append("PLEASE DO NOT RESPOND TO THIS EMAIL.\n");
		message.append("To send an email to customer service, please go to this link:\n");
		message.append("http://www.ebiz.com/wood/ \n");
		message.append("************************************************\n");
		message.append("Dear " + orderProducts[0].getOrder().getCustomer().getFirstName() + 
				" " + orderProducts[0].getOrder().getCustomer().getLastName() + " : \n\n");
		message.append("Your order from ebiz, has been charged to your credit card.\n\n");
		message.append("Order Number:\t\t\t "+ orderProducts[0].getOrder().getConfirmationNo() +"\n");
		message.append("Order Date:\t\t\t " + fm.format(orderProducts[0].getOrder().getCreateDate()) + "\n\n");
		message.append(orderProducts[0].getOrder().getCustomer().getFirstName() + 
				" " + orderProducts[0].getOrder().getCustomer().getLastName() + " : \n\n");
		message.append(orderProducts[0].getOrder().getCustomer().getShipAddress1() + "\n");
		message.append(orderProducts[0].getOrder().getCustomer().getShipCity() + ", " +
				orderProducts[0].getOrder().getCustomer().getShipState() + " " +
				orderProducts[0].getOrder().getCustomer().getShipZip() + "\n");
		message.append(orderProducts[0].getOrder().getCustomer().getContactPhone() + "\n");
		message.append(orderProducts[0].getOrder().getCustomer().getEmail() + "\n\n");
		message.append("Product Name                                      Qty Ordered  Qty Shipped  Price\n");
		message.append("------------------------------------------------------------------------------------\n");
		for(int i=0; i<orderProducts.length; i++){
			message.append(orderProducts[i].getWoodProduct().getName() + "\t" +
					orderProducts[i].getQuantity() + "\t" +
					"SHIPPING COST \t" +
					orderProducts[i].getWoodProduct().getPrice() + "\n");
		}
		message.append("------------------------------------------------------------------------------------\n");
		//Tax rate
		double taxRate = (StateDataProvider.getInstance().getState(
				orderProducts[0].getOrder().getCustomer().getState(), 
				orderProducts[0].getOrder().getCustomer().getCountry()).getTaxRate())/100;
		message.append("                                                                 Tax:   $" +  
				com.ebiz.utils.Util.formatNumber(taxRate * orderProducts[0].getOrder().getPayment().getAmount(), 2)+"\n");
		//Shipping cost
		String sVendor = String.valueOf(orderProducts[0].getOrder().getShipping().getVendor().getId());
		message.append("                                                            Shipping:   $" +
				(ShipperDataProvider.getInstance().getShipper(sVendor)).getCost() +"\n");
		message.append("                                                               Total:  $" + 
				com.ebiz.utils.Util.formatNumber(orderProducts[0].getOrder().getPayment().getAmount(), 2) + "\n\n");
		
		return message.toString();
	}
	
	public static String getPasswordResend(User user)
	{
		StringBuffer message = new StringBuffer();
		message.append("************************************************\n");
		message.append("PLEASE DO NOT RESPOND TO THIS EMAIL.\n");
		message.append("To send an email to customer service, please go to this link:\n");
		message.append("http://www.ebiz.com/wood/ \n");
		message.append("************************************************\n");
		message.append("Dear " + user.getCustomer().getFirstName() + 
				" " + user.getCustomer().getLastName() + " : \n\n");
		message.append("You have requested to resend your password.  If this is not your request, please ignore this email.\n\n");
		message.append("Your account password is: \t\t\t "+ user.getPassword() +"\n");
		
		return message.toString();
	}

}

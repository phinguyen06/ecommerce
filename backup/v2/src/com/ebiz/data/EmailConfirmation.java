package com.ebiz.data;

import java.text.SimpleDateFormat;

public class EmailConfirmation {
	
	public static String getWoodEmailShipConfirmation(OrderWoodProduct[] orderProducts)
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
		message.append("                                                                 Tax:   $$$$$ \n");
		message.append("                                                            Shipping:   $$$$$ \n");
		message.append("                                                               Total:  $" + 
				orderProducts[0].getOrder().getPayment().getAmount() + "\n\n");
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

	public static String getWoodEmailConfirmation(OrderWoodProduct[] orderProducts)
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
		message.append("                                                                 Tax:   $$$$$ \n");
		message.append("                                                            Shipping:   $$$$$ \n");
		message.append("                                                               Total:  $" + 
				orderProducts[0].getOrder().getPayment().getAmount() + "\n\n");
		
		return message.toString();
	}

}

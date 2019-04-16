package com.ebiz.paypal;

import com.ebiz.data.Order;
import com.ebiz.framework.data.ServiceException;
import com.paypal.sdk.core.nvp.NVPEncoder;

public class PayPalRequest {
	final String VERSION = "56.0";
	final String METHOD_DIRECT_PAYMENT = "DoDirectPayment";
	final String PAYMENT_ACTION_SALE = "Sale";
	
	/*
	 USER=apiUsername
	&PWD=apiPassword
	&SIGNATURE=apiSignature
	&SUBJECT=optionalThirdPartyEmailAddress
	&VERSION=56.0
	&METHOD=DoDirectPayment
	&PAYMENTACTION=Sale
	&IPADDRESS=BUYER_IP_ADDRESS
	&CREDITCARDTYPE=
	&ACCT=
	&EXPDATE=
	&CVV2=
	&STREET=
	&CITY=
	&STATE=
	&COUNTRYCODE=
	&ZIP=
	&AMT=
	 */
	
	public PayPalRequest(){}
	
	public String getNVP(Order order) throws ServiceException
	{
		try
		{
			NVPEncoder encoder = new NVPEncoder();
			
			encoder.add("VERSION", VERSION);
			encoder.add("METHOD",METHOD_DIRECT_PAYMENT);
		
			// Add request-specific fields to the request string.
			encoder.add("PAYMENTACTION",PAYMENT_ACTION_SALE);
			encoder.add("AMT",String.valueOf(order.getPayment().getAmount()));
			encoder.add("CREDITCARDTYPE",order.getPayment().getCardType());		
			encoder.add("ACCT",order.getPayment().getCardNumber());						
			encoder.add("EXPDATE",order.getPayment().getCardExpDateString());
			encoder.add("CVV2",order.getPayment().getCardCVV());
			encoder.add("FIRSTNAME",order.getCustomer().getFirstName());
			encoder.add("LASTNAME",order.getCustomer().getLastName());
			encoder.add("STREET",order.getCustomer().getAddress1());
			encoder.add("CITY",order.getCustomer().getCity());	
			encoder.add("STATE",order.getCustomer().getState());			
			encoder.add("ZIP",order.getCustomer().getZip());	
			encoder.add("COUNTRYCODE",order.getCustomer().getCountry());
		
			// Execute the API operation and obtain the response.
			return encoder.encode();
		}
		catch(Exception e){
			throw new ServiceException(e);
		}
	}
	
}

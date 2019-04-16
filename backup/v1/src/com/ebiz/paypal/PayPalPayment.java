package com.ebiz.paypal;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import com.ebiz.data.Customer;
import com.ebiz.data.Order;
import com.ebiz.data.Constants;
import com.ebiz.data.Payment;
import com.ebiz.framework.data.PaymentException;
import com.ebiz.framework.data.ServiceException;
import com.ebiz.payment.IPayment;

import com.paypal.sdk.exceptions.PayPalException;
import com.paypal.sdk.profiles.APIProfile;
import com.paypal.sdk.profiles.ProfileFactory;
import com.paypal.sdk.services.NVPCallerServices;

public class PayPalPayment implements IPayment{
	private NVPCallerServices caller = null;
	
	public PayPalPayment(){}
	
	public String processPaymentHTTP(Order order) throws ServiceException
	{
		try
		{
			URL url = new URL(Constants.s_PAYPAL_SERVER_URL);
			HttpURLConnection c = (HttpURLConnection)(url.openConnection());
		
			//Setting output data to POST to URL
			c.setDoOutput(true);
			c.setDoInput(true);
			c.setRequestMethod("POST");
			PrintWriter out = new PrintWriter(c.getOutputStream());
			//out.print(URLEncoder.encode(getPayPalRequest(order),"ISO-8859-1"));
			out.close();
		
			//Getting data back from HTTP response
			BufferedReader in = new BufferedReader(new InputStreamReader(c.getInputStream()));
			String result = "";
			String inputLine;
			while((inputLine = in.readLine()) != null)
			{
				System.out.println("["+inputLine+"]");
				if( inputLine != null && inputLine.trim().length() > 0 )
				{
					result += inputLine.trim();
				}
			}
			in.close();
		}
		catch(Exception e){}
		
		return null;
	}
	
	public String processPayment(Order order) throws PaymentException, ServiceException
	{
		try
		{
			caller = new NVPCallerServices();
			APIProfile profile = ProfileFactory.createSignatureAPIProfile();
			/*
			 WARNING: Do not embed plaintext credentials in your application code.
			 Doing so is insecure and against best practices.
			 Your API credentials must be handled securely. Please consider
			 encrypting them for use in any production environment, and ensure
			 that only authorized individuals may view or modify them.
			 */
			profile.setAPIUsername(Constants.s_PAYPAL_USER_NAME);
	        profile.setAPIPassword(Constants.s_PAYPAL_PWD);
	        profile.setSignature(Constants.s_PAYPAL_SIGNATURE);
	        profile.setEnvironment(Constants.s_PAYPAL_SERVER);
	        //profile.setSubject("");
	        caller.setAPIProfile(profile);

	        PayPalRequest r = new PayPalRequest();
	        String reqStr = r.getNVP(order);
	        
	        System.out.println("PAYMENT REQUEST["+reqStr+"]");
			String NVPResponse =(String) caller.call(reqStr);
			PayPalResponse resp = new PayPalResponse(NVPResponse);
			System.out.println("PAYMENT RESPONSE["+resp.toString()+"]");
			//System.out.println(resp.toString());
			
			order.getPayment().setVendorResponse(resp.toString());
			
			if( !resp.isSuccess() ){
				order.setErrorCode(resp.getErrorCode());
				order.setErrorMessage(resp.getErrorLongMessage());
				throw new PaymentException(resp.getErrorLongMessage());	
			}
			
			return resp.getTransactionId();
		} 
		catch(PayPalException ppe){
			ppe.printStackTrace();
			throw new PaymentException(ppe);
		}
	}

	public static void main(String[] args) throws Exception
	{
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
		System.out.println("TransactionId:"+pmt.processPayment(order));
	}
}

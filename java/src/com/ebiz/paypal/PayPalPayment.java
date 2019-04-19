
//import org.apache.log4j.Logger;

import com.ebiz.cache.LoggerDataProvider;
import com.ebiz.cache.ConfigDataProvider;
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
	//static Logger logger = Logger.getLogger(PayPalPayment.class.getName());
	static LoggerDataProvider logger = LoggerDataProvider.getInstance();
	
	private NVPCallerServices caller = null;
	
	public PayPalPayment(){}

	public String processPayment(Order order) throws PaymentException, ServiceException
	{
		try
		{
			/*
			 * Test code only.  We used this code to test on production.  
			 */
			if( Constants.s_TEST_CUSTOMER.equals(order.getCustomer().getEmail())){
				System.out.println("START RUNNING TEST CODE CHARGING 1 DOLLAR");
				order.getPayment().setAmount(1);
				System.out.println("END RUNNING TEST CODE CHARGING 1 DOLLAR");
			}
			
			caller = new NVPCallerServices();
			APIProfile profile = ProfileFactory.createSignatureAPIProfile();
			//System.out.println("user["+ConfigDataProvider.getInstance().getValue(Constants.s_PAYPAL_USER_NAME)+"]");
			//System.out.println("pw["+ConfigDataProvider.getInstance().getValue(Constants.s_PAYPAL_PWD)+"]");
			//System.out.println("sig["+ConfigDataProvider.getInstance().getValue(Constants.s_PAYPAL_SIGNATURE)+"]");
			//System.out.println("server["+Constants.s_PAYPAL_SERVER+"]");
			profile.setAPIUsername(ConfigDataProvider.getInstance().getValue(Constants.s_PAYPAL_USER_NAME));
	        profile.setAPIPassword(ConfigDataProvider.getInstance().getValue(Constants.s_PAYPAL_PWD));
	        profile.setSignature(ConfigDataProvider.getInstance().getValue(Constants.s_PAYPAL_SIGNATURE));
        	profile.setEnvironment(Constants.s_PAYPAL_SERVER);
	        //profile.setSubject("");
	        caller.setAPIProfile(profile);

	        PayPalRequest r = new PayPalRequest();
	        String reqStr = r.getNVP(order);
	        
			//logger.debug("PAYMENT USER["+ConfigDataProvider.getInstance().getValue(Constants.s_PAYPAL_USER_NAME)+"]");
			//logger.debug("PAYMENT PWD["+ConfigDataProvider.getInstance().getValue(Constants.s_PAYPAL_PWD)+"]");
			//logger.debug("PAYMENT SIG["+ConfigDataProvider.getInstance().getValue(Constants.s_PAYPAL_SIGNATURE)+"]");
	        
	        //logger.debug("PAYMENT REQUEST["+reqStr+"]");
	        
			String NVPResponse =(String) caller.call(reqStr);
			PayPalResponse resp = new PayPalResponse(NVPResponse);
			
			logger.debug("PAYMENT RESPONSE["+resp.toString()+"]");
			
			order.getPayment().setVendorResponse(resp.toString());
			
			if( !resp.isSuccess() ){
				order.setErrorCode(resp.getErrorCode());
				order.setErrorMessage(resp.getErrorLongMessage());
				throw new PaymentException(resp.getErrorLongMessage());	
			}
			
			return resp.getTransactionId();
		} 
		catch(PayPalException ppe){
			logger.debug(ppe.toString());
			throw new PaymentException(ppe);
		}
		catch(Exception e){
			logger.debug(e.toString());
			throw new ServiceException(e);
		}
	}
	
	/*
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
				logger.debug("["+inputLine+"]");
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
	*/	

	public static void main(String[] args) throws Exception
	{
		Customer customer = new Customer();
		
		customer.setFirstName("xxx");
		customer.setLastName("xxx");
		customer.setEmail("xxx@gmail.com");
		customer.setContactPhone("xxx");
		customer.setContactFax("xxx");
		customer.setPassword("passwd");
		customer.setAddress1("xxx");
		customer.setAddress2(" line 2");
		customer.setCity("xxx");
		customer.setState("WA");
		customer.setZip("xxx");
		customer.setZip4("xxx");
		customer.setCountry("US");
		customer.setShipAddress1("124 main st");
		customer.setShipAddress2(" line 2");
		customer.setShipCity("xxx");
		customer.setShipState("wa");
		customer.setShipZip("xxx");
		customer.setShipZip4("xx");
		customer.setShipCountry("US");

		java.text.SimpleDateFormat fm = new java.text.SimpleDateFormat("MMyyyy");
		
		Payment payment = new Payment();
		payment.setCardHolderName("xxx");
		payment.setCardType("Visa");
		payment.setCardNumber("xxx");
		payment.setCardCVV("xxx");
		payment.setCardExpDate(fm.parse("xxx"));
		payment.setAmount(0.1);
		 		 
		Order order = new Order();
		order.setProductType("WOOD");
		order.setComments("comment me not");
		
		order.setCustomer(customer);
		order.setPayment(payment);	
		
		IPayment pmt  = new PayPalPayment();
		logger.debug("TransactionId:"+pmt.processPayment(order));
	}
}

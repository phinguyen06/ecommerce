package com.ebiz.paypal;

import com.ebiz.framework.data.ServiceException;
import com.paypal.sdk.core.nvp.NVPDecoder;
import com.paypal.sdk.exceptions.PayPalException;

public class PayPalResponse {

	//	AMT=0%2e10&CURRENCYCODE=USD&AVSCODE=X&CVV2MATCH=M&TRANSACTIONID=3J3700001M895821C&TIMESTAMP=2009%2d03%2d15T03%3a22%3a08Z&CORRELATIONID=7cc7d958bd3b1&ACK=Success&VERSION=56%2e0&BUILD=854529
	NVPDecoder decoder;
	String nvpResponse;
	
	public PayPalResponse(String NVPResponse) throws ServiceException{
		try{
			decoder = new NVPDecoder();
			decoder.decode(NVPResponse);
			this.nvpResponse = NVPResponse;
		}
		catch(PayPalException ppe){
			throw new ServiceException(ppe);
		}
	}
	
	public double getAmount(){
		return Double.parseDouble(decoder.get("AMT"));
	}
	
	public String getCurrencyCode(){
		return decoder.get("CURRENCYCODE");
	}
	
	public String getAVSCode(){
		return decoder.get("AVSCODE");
	}
	
	public String getCVV2Match(){
		return decoder.get("CVV2MATCH");
	}
	
	public String getTransactionId(){
		return decoder.get("TRANSACTIONID");
	}
	
	public String getTimestamp(){
		return decoder.get("TIMESTAMP");
	}
	
	public String getCorrelationId(){
		return decoder.get("CORRELATIONID");
	}
	
	public String getACK(){
		return decoder.get("ACK");
	}
	
	public String toString(){
		return nvpResponse;
	}
	
	public boolean isSuccess(){
		String ack = getACK();
		return "Success".equals(ack) || "SuccessWithWarning".equals(ack);
	}

	public String getErrorCode(){
		return decoder.get("L_ERRORCODE0");
	}
	public String getErrorShortMessage(){
		return decoder.get("L_SHORTMESSAGE0");
	}
	public String getErrorLongMessage(){
		return decoder.get("L_LONGMESSAGE0");
	}
	public String getErrorSeverityCode(){
		return decoder.get("L_SEVERITYCODE0");
	}
}

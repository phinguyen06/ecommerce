package com.ebiz.data;

import java.io.Serializable;
import java.util.Date;

public class Payment implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public Payment(){}
	
    public int getPaymentId() {
		return paymentId;
	}
	public void setPaymentId(int paymentId) {
		this.paymentId = paymentId;
	}
	public String getCardHolderName() {
		return cardHolderName;
	}
	public void setCardHolderName(String cardHolderName) {
		this.cardHolderName = cardHolderName;
	}
	public String getCardType() {
		return cardType;
	}
	public void setCardType(String cardType) {
		this.cardType = cardType;
	}
	public String getCardNumber() {
		return cardNumber;
	}
	public void setCardNumber(String cardNumber) {
		this.cardNumber = cardNumber;
	}
	public String getMaskedCardNumber() {
		if( cardNumber == null || cardNumber.length()<=3) return cardNumber;
		
		return com.ebiz.utils.Util.mask(
				cardNumber.substring(0,cardNumber.length()-4),"*") +
				cardNumber.substring(cardNumber.length()-4, cardNumber.length());
	}
	public Date getCardExpDate() {
		return cardExpDate;
	}
	public String getCardExpDateString() {
		return fm.format(cardExpDate);
	}
	public void setCardExpDate(java.util.Date date) {
		this.cardExpDate = date;
	}
	public void setCardExpDate(String month, String year) {
		try{
			cardExpDate = fm.parse(month+year);
		}catch(Exception ignore){}
	}
	public String getMaskedCardCVV() {
		return com.ebiz.utils.Util.mask(cardCVV,"*");
	}
	public String getCardCVV() {
		return cardCVV;
	}
	public void setCardCVV(String cardCVV) {
		this.cardCVV = cardCVV;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
    public String getVendorConfirmationNo() {
		return vendorConfirmationNo;
	}

	public void setVendorConfirmationNo(String vendorConfirmationNo) {
		this.vendorConfirmationNo = vendorConfirmationNo;
	}
    public String getVendorResponse() {
		return vendorResponse;
	}

	public void setVendorResponse(String vendorResponse) {
		this.vendorResponse = vendorResponse;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	
	public String toString(){
		StringBuffer sb = new StringBuffer();
		sb.append("\nPAYMENT{");
		sb.append("paymentId["+paymentId+"]\n");
		sb.append("cardHolderName["+cardHolderName+"]\n");
		sb.append("cardType["+cardType+"]\n");
		sb.append("cardNumber["+cardNumber+"]\n");
		sb.append("cardExpDate["+cardExpDate+"]\n");
		sb.append("cardCVV["+cardCVV+"]\n");
		sb.append("amount["+amount+"]\n");
		sb.append("vendorConfirmationNo["+vendorConfirmationNo+"]\n");
		sb.append("vendorResponse["+vendorResponse+"]\n");
		sb.append("createDate["+createDate+"]\n");
		sb.append("updateDate["+updateDate+"]\n");
		sb.append("}");
		
		return sb.toString();
	}		
	
	int paymentId;
    String cardHolderName;
    String cardType;
    String cardNumber;
    Date cardExpDate;
    String cardCVV;
	double amount;
    String vendorConfirmationNo;
    String vendorResponse;
    Date createDate;
    Date updateDate;
	
    java.text.SimpleDateFormat fm = new java.text.SimpleDateFormat("MMyyyy");
}

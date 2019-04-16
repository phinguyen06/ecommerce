package com.ebiz.data;

import java.io.Serializable;
import java.util.Date;

public class Order implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public String getConfirmationNo() {
		return confirmationNo;
	}
	public void setConfirmationNo(String confirmationNo) {
		this.confirmationNo = confirmationNo;
	}
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	public Payment getPayment() {
		return payment;
	}
	public void setPayment(Payment payment) {
		this.payment = payment;
	}
	public String getProductType() {
		return productType;
	}
	public void setProductType(String productType) {
		this.productType = productType;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getErrorCode() {
		return errorCode;
	}
	public void setErrorCode(String errorCode) {
		this.errorCode = errorCode;
	}
	public String getErrorMessage() {
		return errorMessage;
	}
	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}
	public String getClientId() {
		return clientId;
	}
	public void setClientId(String clientId) {
		this.clientId = clientId;
	}
	
	public void setShipping(Shipping s){
		this.shipping = s;
	}
	
	public Shipping getShipping(){
		return shipping;
	}
	
	public String toString(){
		StringBuffer sb = new StringBuffer();
		sb.append("\nORDER{");
		sb.append("orderId["+orderId+"]\n");
		sb.append("payment["+payment+"]\n");
		sb.append("customer["+customer.toString()+"]\n");
		sb.append("shipping["+shipping+"]\n");
		sb.append("productType["+productType+"]\n");
		sb.append("amount["+amount+"]\n");
		sb.append("comments["+comments+"]\n");
		sb.append("createDate["+createDate+"]\n");
		sb.append("updateDate["+updateDate+"]\n");
		sb.append("confirmationNo["+confirmationNo+"]\n");
		sb.append("status["+status+"]\n");
		sb.append("errorCode["+errorCode+"]\n");
		sb.append("errorMessage["+errorMessage+"]\n");
		sb.append("clientId["+clientId+"]\n");
		sb.append("}");
		
		return sb.toString();
	}
	
	
	int orderId;
	Payment payment;
	Customer customer;
	Shipping shipping;
	String productType;
	double amount;
	String comments;
	Date createDate;
	Date updateDate;
	//This is a derive string from random letters and orderId from DB
	String confirmationNo;	
	String status;
	String errorCode;
	String errorMessage;
	String clientId;
	
}

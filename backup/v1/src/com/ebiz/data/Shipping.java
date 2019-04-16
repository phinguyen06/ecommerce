package com.ebiz.data;

import java.util.Date;

public class Shipping {
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getVendor() {
		return vendor;
	}
	public void setVendor(String vendor) {
		this.vendor = vendor;
	}
	public String getTrackingId() {
		return trackingId;
	}
	public void setTrackingId(String trackingId) {
		this.trackingId = trackingId;
	}
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
	public String toString(){
		StringBuffer sb = new StringBuffer();
		sb.append("\nSHIPPING{");
		sb.append("id["+id+"]\n");
		sb.append("vendor["+vendor+"]\n");
		sb.append("trackingId["+trackingId+"]\n");
		sb.append("createDate["+createDate+"]\n");
		sb.append("}");
		
		return sb.toString();
	}		
	
	int id;
	String vendor;
	String trackingId;
	int orderId;
	Date createDate;
}

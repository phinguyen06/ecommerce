package com.ebiz.data;

import java.util.Date;

public class Tracker {

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public String getProductType() {
		return productType;
	}

	public void setProductType(String productType) {
		this.productType = productType;
	}

	public String getClientId() {
		return clientId;
	}

	public void setClientId(String clientId) {
		this.clientId = clientId;
	}
	
	public String getPage() {
		return page;
	}

	public void setPage(String page) {
		this.page = page;
	}
	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String toString(){
		StringBuffer sb = new StringBuffer();
		sb.append("\nTRACKER{");
		sb.append("id["+id+"]\n");
		sb.append("categoryId["+categoryId+"]\n");
		sb.append("productId["+productId+"]\n");
		sb.append("productType["+productType+"]\n");
		sb.append("clientId["+clientId+"]\n");
		sb.append("page["+page+"]\n");
		sb.append("page["+createDate+"]\n");
		sb.append("}");
		
		return sb.toString();
	}			
	
	
	int id;
	int categoryId = -1;
	int productId = -1;
	String productType;
	String clientId;
	String page;
	Date createDate;

}

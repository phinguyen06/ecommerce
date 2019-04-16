package com.ebiz.data;

import java.io.Serializable;
import java.util.Date;

public class OrderWoodProduct implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public OrderWoodProduct(){}
	
	public OrderWoodProduct(Order order, WoodProduct wp, int quantity, Date createDate){
		this.order = order;
		this.woodProduct = wp;
		this.quantity = quantity;
		this.createDate = createDate;
	}
    public Order getOrder() {
		return order;
	}
	public void setOrder(Order order) {
		this.order = order;
	}
	public WoodProduct getWoodProduct() {
		return woodProduct;
	}
	public void setWoodProduct(WoodProduct woodProduct) {
		this.woodProduct = woodProduct;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
	public String toString(){
		StringBuffer sb = new StringBuffer();
		sb.append("\nORDERWOODPRODUCT{");
		sb.append("order["+order.toString()+"]\n");
		sb.append("woodProduct["+woodProduct.toString()+"]\n");
		sb.append("quantity["+quantity+"]\n");
		sb.append("createDate["+createDate+"]\n");
		sb.append("}");
		
		return sb.toString();
	}	
	
	Order order;
    WoodProduct woodProduct;
    int quantity;
    Date createDate;
}

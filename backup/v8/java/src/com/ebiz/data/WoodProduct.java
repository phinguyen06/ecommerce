package com.ebiz.data;

import java.io.Serializable;
import java.util.Date;
import java.util.HashMap;


public class WoodProduct implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public WoodProduct(){}
	
	/**
	 * getProductId()
	 * @return int - Product Id
	 */
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public WoodCategory getCategory() {
		return category;
	}
	public void setCategory(WoodCategory category) {
		this.category = category;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public double getWidth() {
		return width;
	}
	public void setWidth(double width) {
		this.width = width;
	}
	public double getLength() {
		return length;
	}
	public void setLength(double length) {
		this.length = length;
	}
	public double getHeight() {
		return height;
	}
	public void setHeight(double height) {
		this.height = height;
	}
	public double getBasePrice() {
		return basePrice;
	}
	public void setBasePrice(double basePrice) {
		this.basePrice = basePrice;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public boolean isForSale() {
		return forSale;
	}
	public void setForSale(boolean forSale) {
		this.forSale = forSale;
	}
	public double getShippingCost() {
		return shippingCost;
	}
	public void setShippingCost(double shippingCost) {
		this.shippingCost = shippingCost;
	}
	public String getImageName() {
		return imageName;
	}
	public void setImageName(String imageName) {
		this.imageName = imageName;
	}
	public String getImageURL() {
		return imageURL;
	}
	public void setImageURL(String imageURL) {
		this.imageURL = imageURL;
	}
	public String getVendorId() {
		return vendorId;
	}
	public void setVendorId(String vendorId) {
		this.vendorId = vendorId;
	}
	public String getVendorName() {
		return vendorName;
	}
	public void setVendorName(String vendorName) {
		this.vendorName = vendorName;
	}
	public String getVendorDescription() {
		return vendorDescription;
	}
	public void setVendorDescription(String vendorDescription) {
		this.vendorDescription = vendorDescription;
	}
	public double getVendorWidth() {
		return vendorWidth;
	}
	public void setVendorWidth(double vendorWidth) {
		this.vendorWidth = vendorWidth;
	}
	public double getVendorLenght() {
		return vendorLenght;
	}
	public void setVendorLenght(double vendorLenght) {
		this.vendorLenght = vendorLenght;
	}
	public double getVendorHeight() {
		return vendorHeight;
	}
	public void setVendorHeight(double vendorHeight) {
		this.vendorHeight = vendorHeight;
	}
	public double getVendorPrice() {
		return vendorPrice;
	}
	public void setVendorPrice(double vendorPrice) {
		this.vendorPrice = vendorPrice;
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
	
	public static HashMap<String,WoodProduct> productsToHash(WoodProduct[] products){
		HashMap<String,WoodProduct> rets = new HashMap<String,WoodProduct>();
		for( int i=0; i<products.length; i++ ){
			rets.put(String.valueOf(products[i].getProductId()), products[i]);
		}
		return rets;
	}
	
	public String toString(){
		StringBuffer sb = new StringBuffer();
		sb.append("\nWOODPRODUCT{");
		sb.append("productId["+productId+"]\n");
		sb.append("category["+category.toString()+"]\n");
		sb.append("name["+name+"]\n");
		sb.append("description["+description+"]\n");
		sb.append("width["+width+"]\n");
		sb.append("length["+length+"]\n");
		sb.append("height["+height+"]\n");
		sb.append("basePrice["+basePrice+"]\n");
		sb.append("price["+price+"]\n");
		sb.append("forSale["+forSale+"]\n");
		sb.append("shippingCost["+shippingCost+"]\n");
		sb.append("imageName["+imageName+"]\n");
		sb.append("imageURL["+imageURL+"]\n");
		sb.append("vendorId["+vendorId+"]\n");
		sb.append("vendorName["+vendorName+"]\n");
		sb.append("vendorDescription["+vendorDescription+"]\n");
		sb.append("vendorWidth["+vendorWidth+"]\n");
		sb.append("vendorLenght["+vendorLenght+"]\n");
		sb.append("vendorHeight["+vendorHeight+"]\n");
		sb.append("vendorPrice["+vendorPrice+"]\n");
		sb.append("createDate["+createDate+"]\n");
		sb.append("updateDate["+updateDate+"]\n");
		sb.append("}");
		
		return sb.toString();
	}			
	
	
	int productId;
	WoodCategory category;
	String name;
	String description;
	double width;
	double length;
	double height;
	double basePrice;
	double price;
	boolean forSale;
	double shippingCost;
	String imageName;
	String imageURL;
	String vendorId;
	String vendorName;
	String vendorDescription;
	double vendorWidth;
	double vendorLenght;
	double vendorHeight;
	double vendorPrice;
	Date createDate;
	Date updateDate;
}

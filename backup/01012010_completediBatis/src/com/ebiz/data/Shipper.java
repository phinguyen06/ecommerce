package com.ebiz.data;

import java.util.Date;

public class Shipper {
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public double getCost() {
		return cost;
	}
	public void setCost(double cost) {
		this.cost = cost;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
	public String toString(){
		StringBuffer sb = new StringBuffer();
		sb.append("\nSHIPPER{");
		sb.append("id["+id+"]\n");
		sb.append("name["+name+"]\n");
		sb.append("type["+type+"]\n");
		sb.append("cost["+cost+"]\n");
		sb.append("createDate["+createDate+"]\n");
		sb.append("}");
		
		return sb.toString();
	}		
	
	int id;
	String name;
	String type;
	double cost;
	Date createDate;
	

}

package com.ebiz.data;

import java.io.Serializable;

public class Status implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public Status(String code, String description){
		this.code = code;
		this.description = description;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	public String toString(){
		StringBuffer sb = new StringBuffer();
		sb.append("\nSTATUS{");
		sb.append("code["+code+"]\n");
		sb.append("description["+description+"]\n");
		sb.append("}");
		
		return sb.toString();
	}			
	
	String code;
	String description;	
}
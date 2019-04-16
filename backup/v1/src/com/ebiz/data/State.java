package com.ebiz.data;

import java.io.Serializable;

public class State implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public State(){}
	public State(String code, String name, String country){
		this.code = code;
		this.name = name;
		this.country = country;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	
	public String toString(){
		StringBuffer sb = new StringBuffer();
		sb.append("\nSTATE{");
		sb.append("code["+code+"]\n");
		sb.append("name["+name+"]\n");
		sb.append("country["+country+"]\n");
		sb.append("}");
		
		return sb.toString();
	}			
	
	String code;
	String name;
	String country;
	
}

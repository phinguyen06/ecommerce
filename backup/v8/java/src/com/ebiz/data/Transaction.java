package com.ebiz.data;

import java.util.Date;

public class Transaction {
	
	public Transaction(){};
	
	public Transaction(String type, char currentStep, Date date, Object[] data)
	{
		this.type = type;
		this.currentStep = currentStep;
		this.date = date;
		this.data = data;
	}
	
	public String getType(){
		return type;
	}
	
	public void setType(String type){
		this.type = type;
	}
	public char getCurrentStep() {
		return currentStep;
	}

	public void setCurrentStep(char currentStep) {
		this.currentStep = currentStep;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Object[] getData() {
		return data;
	}

	public void setData(Object[] data) {
		this.data = data;
	}

	public String toString(){
		StringBuffer sb = new StringBuffer();
		sb.append("\nTRANSACTION{");
		sb.append("type["+type+"]\n");
		sb.append("currentStep["+currentStep+"]\n");
		sb.append("date["+date+"]\n");
		for( int i=0; i<data.length; i++ ){
			sb.append("index["+i+"] name["+data[i].toString()+"]\n");
		}
		sb.append("}");
		
		return sb.toString();
		
	}
	String type;
	char currentStep;
	Date date;
	Object[] data;

}

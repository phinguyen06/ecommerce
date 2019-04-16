package com.ebiz.data;

import java.io.Serializable;

public class WoodCategory implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	int id;
	String name;
	String description;
	String urlPath;
	double importTaxRate;
	double margin;
	
	public WoodCategory(){}

	public WoodCategory(int id, String name, String description, String urlPath, double importTaxRate, double margin)
	{
		this.id = id;
		this.name = name;
		this.description = description;
		this.urlPath = urlPath;
		this.importTaxRate = importTaxRate;
		this.margin = margin;
	}
	
	public String toString(){
		StringBuffer sb = new StringBuffer();
		sb.append("\nWOODCATEGORY{");
		sb.append("id["+id+"]\n");
		sb.append("name["+name+"]\n");
		sb.append("description["+description+"]\n");
		sb.append("urlPath["+urlPath+"]\n");
		sb.append("importTaxRate["+importTaxRate+"]\n");
		sb.append("margin["+margin+"]\n");
		sb.append("}");
		
		return sb.toString();
	}			
	

	/**
	 * getId
	 * @return id
	 */
	public int getId(){ return id; }

	/**
	 * getName
	 * @return name
	 */
	public String getName(){ return name; }

	/**
	 * getDescription
	 * @return description
	 */
	public String getDescription(){ return description; }


	/**
	 * getUrlPath
	 * @return urlPath
	 */
	public String getUrlPath(){ return urlPath; }


	/**
	 * getImportTaxRate
	 * @return importTaxRate
	 */
	public double getImportTaxRate(){ return importTaxRate; }


	/**
	 * getMargin
	 * @return margin
	 */
	public double getMargin(){ return margin; }
	
	public void setId(int id) {
		this.id = id;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public void setUrlPath(String urlPath) {
		this.urlPath = urlPath;
	}

	public void setImportTaxRate(double importTaxRate) {
		this.importTaxRate = importTaxRate;
	}

	public void setMargin(double margin) {
		this.margin = margin;
	}	

}
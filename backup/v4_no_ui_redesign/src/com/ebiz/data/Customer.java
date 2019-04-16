package com.ebiz.data;

import java.io.Serializable;
import java.util.Date;

public class Customer implements Serializable
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public Customer(){}

    public int getCustomerId() {
		return customerId;
	}
	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getContactPhone() {
		return contactPhone;
	}
	public void setContactPhone(String contactPhone) {
		this.contactPhone = contactPhone;
	}
	public String getContactFax() {
		return contactFax;
	}
	public void setContactFax(String contactFax) {
		this.contactFax = contactFax;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
	}
	public String getZip4() {
		return zip4;
	}
	public void setZip4(String zip4) {
		this.zip4 = zip4;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getShipAddress1() {
		return shipAddress1;
	}
	public void setShipAddress1(String shipAddress1) {
		this.shipAddress1 = shipAddress1;
	}
	public String getShipAddress2() {
		return shipAddress2;
	}
	public void setShipAddress2(String shipAddress2) {
		this.shipAddress2 = shipAddress2;
	}
	public String getShipCity() {
		return shipCity;
	}
	public void setShipCity(String shipCity) {
		this.shipCity = shipCity;
	}
	public String getShipState() {
		return shipState;
	}
	public void setShipState(String shipState) {
		this.shipState = shipState;
	}
	public String getShipZip() {
		return shipZip;
	}
	public void setShipZip(String shipZip) {
		this.shipZip = shipZip;
	}
	public String getShipZip4() {
		return shipZip4;
	}
	public void setShipZip4(String shipZip4) {
		this.shipZip4 = shipZip4;
	}
	public String getShipCountry() {
		return shipCountry;
	}
	public void setShipCountry(String shipCountry) {
		this.shipCountry = shipCountry;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String toString(){
		StringBuffer sb = new StringBuffer();
		sb.append("\nCUSTOMER{");
		sb.append("customerId["+customerId+"]\n");
		sb.append("firstName["+firstName+"]\n");
		sb.append("lastName["+lastName+"]\n");
		sb.append("email["+email+"]\n");
		sb.append("contactPhone["+contactPhone+"]\n");
		sb.append("contactFax["+contactFax+"]\n");
		sb.append("password["+password+"]\n");
		sb.append("address1["+address1+"]\n");
		sb.append("address2["+address2+"]\n");
		sb.append("city["+city+"]\n");
		sb.append("state["+state+"]\n");
		sb.append("zip["+zip+"]\n");
		sb.append("zip4["+zip4+"]\n");
		sb.append("country["+country+"]\n");
		sb.append("shipAddress1["+shipAddress1+"]\n");
		sb.append("shipAddress2["+shipAddress2+"]\n");
		sb.append("shipCity["+shipCity+"]\n");
		sb.append("shipState["+shipState+"]\n");
		sb.append("shipZip["+shipZip+"]\n");
		sb.append("shipZip4["+shipZip4+"]\n");
		sb.append("shipCountry["+shipCountry+"]\n");
		sb.append("createDate["+createDate+"]\n");
		sb.append("}");
		
		return sb.toString();
	}
	int customerId;
    String firstName;
    String lastName;
    String email;
    String contactPhone;
    String contactFax;
    String password;
    String address1;
    String address2;
    String city;
    String state;
    String zip;
    String zip4;
    String country;
    String shipAddress1;
    String shipAddress2;
    String shipCity;
    String shipState;
    String shipZip;
    String shipZip4;
    String shipCountry;
    Date createDate;
	
}

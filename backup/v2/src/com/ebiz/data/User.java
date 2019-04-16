package com.ebiz.data;

public class User {
	String email;
	String password;
	Permission permission;

	public User(String email, String password){
		this.email = email;
		this.password = password;
	}

	public User(String email, Permission permission){
		this.email = email;
		this.permission = permission;
	}
	
	public String getEmail(){
		return email;
	}
	
	public void setEmail(String email){
		this.email = email;
	}

	public String getPassword(){
		return password;
	}
	
	public void setPassword(String password){
		this.password = password;
	}
	
	public Permission getPermission(){
		return permission;
	}
	
	public void setPermission(Permission permission){
		this.permission = permission;
	}
}

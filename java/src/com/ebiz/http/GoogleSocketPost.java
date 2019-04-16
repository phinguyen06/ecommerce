package com.ebiz.http;

import com.ebiz.data.Constants;

public class GoogleSocketPost extends SocketPost{
	public void post(){
		super.post(Constants.s_GOOGLE_CHECKOUT_REQUESTFORM_SERVER_URL, 
					Constants.s_GOOGLE_CHECKOUT_SERVER_PORT);
	}
	
	public static void main(String[] args) throws Exception{
		GoogleSocketPost s = new GoogleSocketPost();
		System.out.println("GoogleSocketPost::main:START");
		s.post();
		System.out.println("GoogleSocketPost::main:END");
	}
}

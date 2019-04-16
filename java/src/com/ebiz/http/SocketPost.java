package com.ebiz.http;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.InetAddress;
import java.net.Socket;
import java.net.URLEncoder;

import com.ebiz.data.Constants;


public class SocketPost {
	public void post(String address, int port){
		BufferedWriter wr = null;
		BufferedReader rd = null;
		try {
			System.out.println("SocketPost:post:BEGIN");
		    // Construct data
		    //String data = URLEncoder.encode("key1", "UTF-8") + "=" + URLEncoder.encode("value1", "UTF-8");
		    //data += "&" + URLEncoder.encode("key2", "UTF-8") + "=" + URLEncoder.encode("value2", "UTF-8");

		    String data = 	"item_name_1=Dog%20Food" +
			"&item_description_1=Yummy%20bacon%20flavor" +
			"&item_quantity_1=1" +
			"&item_price_1=10" +
			"&item_currency_1=USD";			
			
		    // Create a socket to the host
		    //InetAddress addr = InetAddress.getByName(Constants.s_GOOGLE_CHECKOUT_REQUESTFORM_SERVER_URL);
		    System.out.println("SocketPost::post:addr["+address+"] port["+port+"]");
		    InetAddress addr = InetAddress.getByName(address);
		    Socket socket = new Socket(addr, port);
		    //Socket socket = new Socket(addr, Constants.s_GOOGLE_CHECKOUT_SERVER_PORT);
	
		    // Send header
		    String path = "/servlet/SomeServlet";
		    wr = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream(), "UTF8"));
		    wr.write("POST "+path+" HTTP/1.0\r\n");
		    wr.write("Authorization: Basic " + URLEncoder.encode(Constants.s_GOOGLE_CHECKOUT_MERCHANT_ID+
		    													":"+
		    													Constants.s_GOOGLE_CHECKOUT_MERCHANT_KEY, "UTF-8") );  //MERCHANT_ID:MERCHANT_KEY
		    wr.write("Content-Length: "+data.length()+"\r\n");
		    wr.write("Content-Type: application/xml; charset=UTF-8\r\n");
		    wr.write("Accept: application/xml;charset=UTF-8\r\n");
		    wr.write("\r\n");
	
		    System.out.println("SocketPost:post:WRITE");
		    
		    // Send data
		    wr.write(data);
		    wr.flush();
	
		    System.out.println("SocketPost:post:FLUSHED");
		    
		    // Get response
		    rd = new BufferedReader(new InputStreamReader(socket.getInputStream()));
		    System.out.println("SocketPost:post:GET INPUT STREAM");
		    String line;
		    while ((line = rd.readLine()) != null) {
		    	System.out.println(line);
		    }
		    System.out.println("SocketPost:post:END");
		} catch (Exception e) {
			System.out.println("error:"+e.getMessage());
			e.printStackTrace();
		}
		finally{
			try{wr.close();} catch(Exception ignore){}
			try{rd.close();} catch(Exception ignore){}
		}
	}
}
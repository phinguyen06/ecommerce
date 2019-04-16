package com.ebiz.http;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;


public class HttpPost {
	public void post(){
		BufferedReader rd = null;
		OutputStreamWriter wr = null;
		try { 
			// Construct data 
			String data = URLEncoder.encode("key1", "UTF-8") + "=" + URLEncoder.encode("value1", "UTF-8"); 
			data += "&" + URLEncoder.encode("key2", "UTF-8") + "=" + URLEncoder.encode("value2", "UTF-8"); 
			// Send data 
			URL url = new URL("http://hostname:80/cgi"); 
			URLConnection conn = url.openConnection(); conn.setDoOutput(true); 
			wr = new OutputStreamWriter(conn.getOutputStream()); 
			wr.write(data); wr.flush(); 
			// Get the response 
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream())); 
			String line; 
			while ((line = rd.readLine()) != null) { 
				System.out.println(line); 
			} 
			wr.close(); 
			rd.close(); 
		} 
		catch (Exception e) { }
		finally{
			try{wr.close();} catch(Exception ignore){}
			try{rd.close();} catch(Exception ignore){}
		}
	}
}

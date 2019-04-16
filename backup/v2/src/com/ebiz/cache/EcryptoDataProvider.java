package com.ebiz.cache;

import org.apache.commons.codec.binary.Base64;
import org.apache.log4j.Logger;

import com.ebiz.security.Ecrypto;


public class EcryptoDataProvider extends DataProvider
{
	static Logger logger = Logger.getLogger(EcryptoDataProvider.class.getName());
	
    private static EcryptoDataProvider s_instance = null;

    // instance variables
    private Ecrypto ecrypto  = null;
    private String key = null;
    private String scheme = null;

    protected EcryptoDataProvider(String sKey, String sScheme)
	throws Exception
    {
		logger.debug("StateDataProvider");
		Base64 base64encoder = new Base64();   	
    	this.key = new String(base64encoder.decode(sKey.getBytes()));
    	this.scheme = new String(base64encoder.decode(sScheme.getBytes()));
		load();
		logger.debug("StateDataProvider");
    }

    public void clear()
    {
    	ecrypto = null;
    }



    public synchronized static void init(String key, String scheme)
	throws Exception
    {
		if (s_instance == null)
			s_instance = new EcryptoDataProvider(key, scheme);
    }

    public static EcryptoDataProvider getInstance() throws Exception
    {
		if( s_instance == null )
			throw new Exception("Instance is null");

		return s_instance;
    }

    public void load() throws Exception
    {
		try{
			register();
			clear();
			loadData();
		}
		catch (Exception e){
			logger.error("StateDataProvider::load",e);
		}
    }

    public void loadData() throws Exception
    {   	
    	ecrypto = new Ecrypto(scheme, key);
    }

    public Ecrypto getEcrypto()
    {
		return ecrypto;
    }
}
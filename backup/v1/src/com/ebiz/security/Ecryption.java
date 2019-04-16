package com.ebiz.security;

import com.ebiz.framework.data.ServiceException;

/**
 * Encryption class is a wrapper class to encrypt and decrypt
 * a message by using base64 format.  Future release can have
 * more sophisicated encryption architecture
 */

public class Ecryption {

	/**
	 * encrypt - Encrypt a message into base64 format
	 * @param message - Message to encrypt
	 * @return String - Base64 encrypted string
	 * @throws ServiceException
	 */
	public static String encrypt(String message) throws ServiceException
	{
		try{
			return new sun.misc.BASE64Encoder().encode(message.getBytes());
		}
		catch(Exception e)
		{
			throw new ServiceException(e);
		}
	}

	/**
	 * decrypt - Decrypt a base64 message into a regular readable string
	 * @param message - Base64 encrypted message
	 * @return String - Readable string
	 * @throws ServiceException
	 */
	public static String decrypt(String message) throws ServiceException
	{
		try{
			return new String(new sun.misc.BASE64Decoder().decodeBuffer(message));
		}
		catch(Exception e)
		{
			throw new ServiceException(e);
		}
	}

}

package com.ebiz.security;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.KeySpec;

import javax.crypto.Cipher;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import javax.crypto.spec.DESedeKeySpec;

import org.apache.commons.codec.binary.Base64;
import org.apache.log4j.Logger;


public class Ecrypto {
	static Logger logger = Logger.getLogger(Ecrypto.class.getName());
	
	public static final String DESEDE_ENCRYPTION_SCHEME = "DESede";
	public static final String DES_ENCRYPTION_SCHEME = "DES";

	private KeySpec keySpec;
	private SecretKeyFactory keyFactory;
	private Cipher cipher;

	private static final String UNICODE_FORMAT = "UTF8";

	public Ecrypto(String scheme, String key)
			throws SecurityException {

		try {
			if (key == null)
				throw new IllegalArgumentException("encryption key was null");
			if (key.trim().length() < 24)
				throw new IllegalArgumentException(
						"encryption key was less than 24 characters");

			byte[] keyAsBytes = key.getBytes(UNICODE_FORMAT);

			keySpec = new DESedeKeySpec(keyAsBytes);

			if (scheme.equals(DESEDE_ENCRYPTION_SCHEME)) {
				keySpec = new DESedeKeySpec(keyAsBytes);
			} else if (scheme.equals(DES_ENCRYPTION_SCHEME)) {
				keySpec = new DESKeySpec(keyAsBytes);
			} else {
				throw new IllegalArgumentException(
						"Encryption scheme not supported: " + scheme);
			}

			keyFactory = SecretKeyFactory.getInstance(scheme);
			cipher = Cipher.getInstance(scheme);

		} catch (InvalidKeyException e) {
			throw new SecurityException(e);
		} catch (UnsupportedEncodingException e) {
			throw new SecurityException(e);
		} catch (NoSuchAlgorithmException e) {
			throw new SecurityException(e);
		} catch (NoSuchPaddingException e) {
			throw new SecurityException(e);
		}

	}

	public String encrypt(String unencryptedString) throws SecurityException 
	{
		logger.debug("Ecrypto::ecrypt:BEGIN");
		if (unencryptedString == null || unencryptedString.trim().length() == 0)
			throw new IllegalArgumentException(
					"unencrypted string was null or empty");

		try {
			SecretKey key = keyFactory.generateSecret(keySpec);
			cipher.init(Cipher.ENCRYPT_MODE, key);
			byte[] cleartext = unencryptedString.getBytes(UNICODE_FORMAT);
			byte[] ciphertext = cipher.doFinal(cleartext);

			Base64 base64encoder = new Base64();
			return new String(base64encoder.encode(ciphertext));
		} catch (Exception e) {
			throw new SecurityException(e);
		}
		finally{
			logger.debug("Ecrypto::ecrypt:END");
		}
	}

	public String decrypt(String encryptedString) throws SecurityException 
	{
		logger.debug("decrypt::ecrypt:BEGIN");
		
		if (encryptedString == null || encryptedString.trim().length() <= 0)
			throw new IllegalArgumentException(
					"encrypted string was null or empty");

		try {
			//logger.debug("1");
			SecretKey key = keyFactory.generateSecret(keySpec);
			//logger.debug("2");
			cipher.init(Cipher.DECRYPT_MODE, key);
			//logger.debug("3");
			Base64 base64decoder = new Base64();
			//logger.debug("4");
			byte[] cleartext = base64decoder.decode(encryptedString.getBytes());
			//logger.debug("4:"+cleartext);
			byte[] ciphertext = cipher.doFinal(cleartext);
			//logger.debug("5");
			return new String(ciphertext);
			//return new String(bytes2String(ciphertext));
		} catch (Exception e) {
			logger.error(e.toString());
			throw new SecurityException(e);
		}
		finally{
			logger.debug("Ecrypto::decrypt:END");
		}
		
	}
/*
	private static String bytes2String(byte[] bytes) {
		StringBuffer stringBuffer = new StringBuffer();
		for (int i = 0; i < bytes.length; i++) {
			stringBuffer.append((char) bytes[i]);
		}
		return stringBuffer.toString();
	}
*/
}
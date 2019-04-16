package test.security;

import com.ebiz.security.Ecrypto;

import org.apache.commons.codec.binary.Base64;

public class CryptoTest {
	public static void main(String[] args) throws Exception {
		if( args.length < 2 )
		{
			System.out.println("Usage: java.test.security.CryptoTest option[base64/crypto] option[encrypt/decrypt] [cryptoKey] [cryptoScheme] encrypt_or_decrypt_string");
			System.exit(1);
		}
		
		if( "base64".equals(args[0]) )
		{
			if( "encrypt".equals(args[1]) )
			{
				Base64 base64encoder = new Base64();
				System.out.println(new String(base64encoder.encode(args[2].getBytes())));
			}
			else
			{
				Base64 base64decoder = new Base64();
				System.out.println(new String(base64decoder.decode(args[2].getBytes())));
			}
		}
		else if( "crypto".equals(args[0]) )
		{
			if( args.length != 5 )
			{
				System.out.println("Missing crypto argument\n\n" +
						"Usage: java.test.security.CryptoTest option[base64/crypto] option[encrypt/decrypt] [cryptoKey] [cryptoScheme] encrypt_or_decrypt_string");
				System.exit(1);				
			}
			//String stringToEncrypt = "test";
			//String encryptionKey = "eBiz is a global trading company for both import and export";
			//String encryptionScheme = Ecrypto.DESEDE_ENCRYPTION_SCHEME;
			
			String encryptionKey = args[2];
			String encryptionScheme = args[3];
			String str = args[4];
			
			Ecrypto encrypter = new Ecrypto(encryptionScheme, encryptionKey);
			if( "encrypt".equals(args[1]) )
				System.out.println(encrypter.encrypt(str));
			else
				System.out.println(encrypter.decrypt(str));
		}
	}
}

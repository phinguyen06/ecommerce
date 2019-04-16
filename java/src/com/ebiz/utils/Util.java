package com.ebiz.utils;

/**
 * Util is a helper class uses to gather all utilities method
 * to help the application
 *
 */
public class Util {
	private static final String letters[] =
		new String[]{"a","b","c","d","e","f","g","h","i","j","k","l",
			"m","n","o","p","q","r","s","t","u","v","w","x","y","z"};

	private static final char symbols[] =
		new char[]{'!','@','#','$','%','*'};



	/**
	 * getRandom4 - Generated a random number from 0 - 1000
	 * @return int - Random number
	 */
	public static int getRandom4()
	{
		return (int)Math.random()*10000;
	}

	/**
	 * getRandomLetter - Special function to randomly pick a character
	 * from 26 alphabet
	 * @param isUpper - If needed an upper case letter
	 * @return String - A random character
	 */
	private static String getRandomLetter(boolean isUpper)
	{
		double random = Math.random();
		return isUpper ? letters[(int)(random*26)].toUpperCase() : letters[(int)(random*26)];
	}

	/**
	 * getRandomLetters - Special function to randomly pick a character
	 * from 26 alphabet
	 * @param count - number of letter
	 * @param isUpper - If needed an upper case letter
	 * @return String - A random character
	 */
	public static String getRandomLetters(int count, boolean isUpper)
	{
		StringBuffer buf = new StringBuffer();
		for( int i=0; i<count; i++ ){
			buf.append(getRandomLetter(true));
		}
		return buf.toString();
	}

	public static String getRandomPassword()
	{
		//one Upper case letter
		String password = getRandomLetter(true);
		//one sympbol
		password += symbols[(int)(Math.random()*6)];
		//one number
		password += (int) Math.random()*10;
		for( int i=0; i<4; i++ )
		{
			password += getRandomLetter(false);
		}
		return password;
	}
	
	public static String mask(String str, String mask)
	{
		StringBuffer buf = new StringBuffer(str.length());
		for( int i=0; i<str.length(); i++ ){
			buf.append(mask);
		}
		return buf.toString();
	}
	
	public static String formatNumber(double number, int digits)
	{
		java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setMinimumFractionDigits(digits);
		return nf.format(number);
		
	}
}

package com.ebiz.utils;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;

import com.ebiz.data.Constants;

/**
 * 
 * SendMail
 * 
 * This class is reponsible to deliver mail on existing Email Server with
 * 
 * passed parameters. The caller is responsible for initializing before
 * 
 * this class can operate. Email Server address is dynamicly loaded from
 * 
 * the runtime environment.
 * 
 */

public class SendMail {
	// private String fromEmail = "support@emath.com";
	private String message = null;
	private String subject = null;
	// private String host = "mail.smtp.host";
	private String sender = null;
	private String[] recipient = null;
	private String[] fileName = null;
	private Session session = null;

	// private String server = "gmail-smtp.l.google.com";

	// private final String SMTP_AUTH_USER = "phi2006@gmail.com";
	// private final String SMTP_AUTH_PWD = "saigon";

	/**
	 * 
	 * SendMail
	 * 
	 * @param from
	 * 
	 * @param to
	 * 
	 * @param subject
	 * 
	 * @param msg
	 * 
	 */

	public SendMail(String to, String subject, String message) {
		this.recipient = new String[1];
		recipient[0] = to;

		init(Constants.s_EMAIL_FROM, recipient, subject, message, null,
				Constants.s_EMAIL_SERVER, Constants.s_EMAIL_HOST);
	}

	/**
	 * 
	 * SendMail
	 * 
	 * @param from
	 * 
	 * @param to
	 * 
	 * @param subject
	 * 
	 * @param msg
	 * 
	 */

	public SendMail(String from, String to, String subject, String message) {
		this.recipient = new String[1];
		recipient[0] = to;

		init(from, recipient, subject, message, null, Constants.s_EMAIL_SERVER,
				Constants.s_EMAIL_HOST);
	}

	/**
	 * 
	 * SendMail
	 * 
	 * @param from
	 * 
	 * @param to
	 * 
	 * @param subject
	 * 
	 * @param msg
	 * 
	 */

	public SendMail(String from, String to, String subject, String message,
			String server, String host) {

		this.recipient = new String[1];

		recipient[0] = to;

		init(from, recipient, subject, message, null, server, host);

	}

	/**
	 * 
	 * SendMail
	 * 
	 * @param from
	 * 
	 * @param to
	 * 
	 * @param subject
	 * 
	 * @param msg
	 * 
	 * @param file
	 * 
	 */

	public SendMail(String from,

	String to,

	String subject,

	String message,

	String file,

	String server,

	String host)

	{

		this.recipient = new String[1];

		recipient[0] = to;

		fileName = new String[1];

		fileName[0] = file;

		init(from, recipient, subject, message, fileName, server, host);

	}

	/**
	 * 
	 * SendMail
	 * 
	 * @param from
	 * 
	 * @param to
	 *            []
	 * 
	 * @param subject
	 * 
	 * @param msg
	 * 
	 */

	public SendMail(String from,

	String[] to,

	String subject,

	String message,

	String server,

	String host)

	{

		init(from, to, subject, message, null, server, host);

	}

	/**
	 * 
	 * SendMail
	 * 
	 * @param from
	 * 
	 * @param to
	 *            []
	 * 
	 * @param subject
	 * 
	 * @param msg
	 * 
	 * @param file
	 * 
	 */

	public SendMail(String from,

	String[] to,

	String subject,

	String message,

	String file,

	String server,

	String host)

	{

		fileName = new String[1];

		fileName[0] = file;

		init(from, to, subject, message, fileName, server, host);

	}

	/**
	 * 
	 * SendMail
	 * 
	 * @param from
	 * 
	 * @param to
	 *            []
	 * 
	 * @param subject
	 * 
	 * @param msg
	 * 
	 * @param file
	 * 
	 */

	public SendMail(String from,

	String[] to,

	String subject,

	String message,

	String[] fileName,

	String server,

	String host)

	{

		init(from, to, subject, message, fileName, server, host);

	}

	/**
	 * 
	 * init
	 * 
	 */

	private void init(String from, String[] recipient, String subject,
			String message,

			String[] fileName, String server, String host)

	{

		this.sender = from;

		this.recipient = recipient;

		this.subject = subject;

		this.message = message;

		this.fileName = fileName;

		// this.server = server;

		// this.host = host;

		java.security.Security
				.addProvider(new com.sun.net.ssl.internal.ssl.Provider());

		Properties props = new Properties();

		props.put("mail.transport.protocol", "smtp");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", server);
		props.put("mail.smtp.auth", "true");

		Authenticator auth = new SMTPAuthenticator();
		session = Session.getDefaultInstance(props, auth);

	}

	/**
	 * 
	 * send - start sending email
	 * 
	 * 
	 * 
	 * @see MessagingException
	 * 
	 */

	public void send() throws MessagingException

	{

		Message msg = new MimeMessage(session);

		msg.setFrom(new InternetAddress(sender));

		InternetAddress[] addresses = new InternetAddress[recipient.length];

		for (int i = 0; i < recipient.length; i++)

			addresses[i] = new InternetAddress(recipient[i]);

		msg.setRecipients(Message.RecipientType.TO, addresses);

		msg.setSubject(this.subject);

		if (fileName != null && fileName.length > 0)

		{

			// First message part is text

			MimeBodyPart mbp1 = new MimeBodyPart();

			mbp1.setText(this.message);

			// Create the Mutipart and its parts to it

			Multipart mp = new MimeMultipart();

			mp.addBodyPart(mbp1);

			for (int i = 0; i < fileName.length; i++)

			{

				// Second message part is attachment

				MimeBodyPart mbp2 = new MimeBodyPart();

				// Get file to attach

				FileDataSource fds = new FileDataSource(fileName[i]);

				mbp2.setDataHandler(new DataHandler(fds));

				mbp2.setFileName(fds.getName());

				// Add attachment to Multipart

				mp.addBodyPart(mbp2);

			}

			// Set content and call it for good

			msg.setContent(mp);

		}

		else {

			msg.setContent(this.message, "text/plain");

		}

		Transport.send(msg);

	}

	/**
	 * SimpleAuthenticator is used to do simple authentication when the SMTP
	 * server requires it.
	 */
	private class SMTPAuthenticator extends javax.mail.Authenticator {

		public PasswordAuthentication getPasswordAuthentication() {
			String username = Constants.s_EMAIL_SMTP_AUTH_USER;
			String password = Constants.s_EMAIL_SMTP_AUTH_PWD;
			return new PasswordAuthentication(username, password);
		}
	}

	public static void main(String[] args) throws Exception {
		SendMail mail = new SendMail("phi2006@gmail.com", "phi2006@gmail.com",
				"test subject", "test message");
		mail.send();
		System.out.println("successfully sent");
	}

}
package com.ebiz.framework.data;

import java.io.Serializable;

/**
 * ServiceException is a wrapper of Exception class.  Its purpose is to give
 * us a unique Exception handler within the application instead of
 * generic Exception
 *
 */
public class ServiceSecurityException extends ServiceException
    implements Serializable
{

    /**
	 * serialVersionUID is required when implements Serializable
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * default constructor
	 *
	 */
	public ServiceSecurityException()
    {
    }

	/**
	 * constructor with exception object
	 * @param exception - Error Exception
	 */
    public ServiceSecurityException(Exception exception)
    {
        super(exception);
    }

    /**
     * constructor with exception string
     * @param s - Error message a String
     */
    public ServiceSecurityException(String s)
    {
        super(s);
    }

    /**
     * Constructor with input exception object;
     * @param s - Error message string
     * @param exception - Exception object
     */
    public ServiceSecurityException(String s, Exception exception)
    {
        super(s);
        super.m_nestedException = exception;
    }
}

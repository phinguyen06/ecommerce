package com.ebiz.framework.data;

import java.io.Serializable;

/**
 * ServiceException is a wrapper of Exception class.  Its purpose is to give
 * us a unique Exception handler within the application instead of
 * generic Exception
 *
 */
public class ServiceNoDataFoundException extends ServiceException
    implements Serializable
{

    /**
	 * serialVersionUID is required when implements Serializable
	 */
	private static final long serialVersionUID = 1L;

	public ServiceNoDataFoundException()
    {
    }

	/**
	 * constructor with exception object
	 * @param exception - Error Exception
	 */
    public ServiceNoDataFoundException(Exception exception)
    {
        super(exception);
    }

	/**
	 * Constructor with input error message string
	 * @param s - Error message string
	 */
    public ServiceNoDataFoundException(String s)
    {
        super(s);
    }

    /**
     * Constructor with input exception object;
     * @param s - Error message string
     * @param exception - Exception object
     */
    public ServiceNoDataFoundException(String s, Exception exception)
    {
        super(s);
        super.m_nestedException = exception;
    }
}

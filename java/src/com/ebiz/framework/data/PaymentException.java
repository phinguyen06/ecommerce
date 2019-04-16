package com.ebiz.framework.data;

import java.io.Serializable;

/**
 * PaymentException is a wrapper of Exception class.  Its purpose is to give
 * us a unique Exception handler within the application instead of
 * generic Exception
 *
 */
public class PaymentException extends Exception
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
	public PaymentException()
    {
        m_nestedException = null;
    }

	/**
	 * Constructor with input error message string
	 * @param s - Error message string
	 */
    public PaymentException(String s)
    {
        super(s);
        m_nestedException = null;
    }

    /**
     * Constructor with input exception object;
     * @param s - Error message string
     * @param exception - Exception object
     */
    public PaymentException(String s, Exception exception)
    {
        super(s);
        m_nestedException = null;
        m_nestedException = exception;
    }

    /**
     * Constructor with throwable interface
     * @param throwable - Throwable interface message
     */
    public PaymentException(Throwable throwable)
    {
        super(throwable.getMessage());
        m_nestedException = null;
        m_nestedException = throwable;
    }

    /**
     * getNestedException
     * @return Throwable
     */
    public Throwable getNestedException()
    {
        return m_nestedException;
    }

    public Throwable m_nestedException;
}

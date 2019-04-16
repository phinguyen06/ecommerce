package com.ebiz.payment;

import com.ebiz.data.Order;
import com.ebiz.framework.data.PaymentException;
import com.ebiz.framework.data.ServiceException;

public interface IPayment {
	public String processPayment(Order order) throws PaymentException, ServiceException;
}

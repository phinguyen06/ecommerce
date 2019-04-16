/*******************************************************************************
 * Copyright (C) 2007 Google Inc.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 ******************************************************************************/

package com.google.checkout.orderprocessing;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import com.google.checkout.AbstractCheckoutRequest;
import com.google.checkout.MerchantConstants;
import com.google.checkout.util.Constants;
import com.google.checkout.util.Utils;

/**
 * This class contains methods that construct &lt;add-tracking-data&gt; API
 * requests.
 */
public class AddTrackingDataRequest extends AbstractCheckoutRequest {

	private Document document;

	private Element root;

	/**
	 * Constructor which takes an instance of MerchantConstants.
	 * 
	 * @param merchantConstants
	 *            The MerchantConstants.
	 * 
	 * @see MerchantConstants
	 */
	public AddTrackingDataRequest(MerchantConstants merchantConstants) {
		super(merchantConstants);

		document = Utils.newEmptyDocument();
		root = (Element) document.createElementNS(Constants.checkoutNamespace,
				"add-tracking-data");
		root.setAttributeNS("http://www.w3.org/2000/xmlns/", "xmlns",
				Constants.checkoutNamespace);
		document.appendChild(root);
	}

	/**
	 * Constructor which takes an instance of MerchantConstants, the Google
	 * Order Number, the Carrier and the Tracking Number
	 * 
	 * @param merchantConstants
	 *            The MerchantConstants.
	 * @param googleOrderNo
	 *            The Google Order Number.
	 * @param carrier
	 *            The Carrier.
	 * @param trackingNo
	 *            The Tracking Number.
	 * 
	 * @see MerchantConstants
	 */
	public AddTrackingDataRequest(MerchantConstants merchantConstants,
			String googleOrderNo, String carrier, String trackingNo) {
		this(merchantConstants);
		this.setGoogleOrderNo(googleOrderNo);
		this.setCarrier(carrier);
		this.setTrackingNo(trackingNo);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.google.checkout.CheckoutRequest#getXml()
	 */
	public String getXml() {
		return Utils.documentToString(document);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.google.checkout.CheckoutRequest#getXmlPretty()
	 */
	public String getXmlPretty() {
		return Utils.documentToStringPretty(document);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.google.checkout.CheckoutRequest#getPostUrl()
	 */
	public String getPostUrl() {
		return merchantConstants.getRequestUrl();
	}

	/**
	 * Return the carrier String, which is the value of the &lt;carrier&gt; tag.
	 * 
	 * @return The carrier String.
	 */
	public String getCarrier() {
		Element trackingDataTag = Utils.findContainerElseCreate(document, root,
				"tracking-data");
		return Utils
				.getElementStringValue(document, trackingDataTag, "carrier");
	}

	/**
	 * Return the Google Order Number, which is the value of the
	 * google-order-number attribute on the root tag.
	 * 
	 * @return The Google Order Number.
	 */
	public String getGoogleOrderNo() {
		return Utils.getElementStringValue(document, root,
				"google-order-number");
	}

	/**
	 * Return the tracking number, which is the value of the
	 * &lt;tracking-number&gt; tag.
	 * 
	 * @return The tracking number.
	 */
	public String getTrackingNo() {
		Element trackingDataTag = Utils.findContainerElseCreate(document, root,
				"tracking-data");
		return Utils.getElementStringValue(document, trackingDataTag,
				"tracking-number");
	}

	/**
	 * Set the carrier String, which is the value of the &lt;carrier&gt; tag.
	 * 
	 * @param carrier
	 *            The carrier String.
	 */
	public void setCarrier(String carrier) {
		Element trackingDataTag = Utils.findContainerElseCreate(document, root,
				"tracking-data");
		Utils.findElementAndSetElseCreateAndSet(document, trackingDataTag,
				"carrier", carrier);
	}

	/**
	 * Set the Google Order Number, which is the value of the
	 * google-order-number attribute on the root tag.
	 * 
	 * @param googleOrderNo
	 *            The Google Order Number.
	 */
	public void setGoogleOrderNo(String googleOrderNo) {
		root.setAttribute("google-order-number", googleOrderNo);
	}

	/**
	 * Set the tracking number, which is the value of the
	 * &lt;tracking-number&gt; tag.
	 * 
	 * @param trackingNo
	 *            The tracking number.
	 */
	public void setTrackingNo(String trackingNo) {
		Element trackingDataTag = Utils.findContainerElseCreate(document, root,
				"tracking-data");
		Utils.findElementAndSetElseCreateAndSet(document, trackingDataTag,
				"tracking-number", trackingNo);
	}
}

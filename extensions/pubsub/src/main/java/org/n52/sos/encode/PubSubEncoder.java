/**
 * Copyright (C) 2012-2015 52°North Initiative for Geospatial Open Source
 * Software GmbH
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License version 2 as published
 * by the Free Software Foundation.
 *
 * If the program is linked with libraries which are licensed under one of
 * the following licenses, the combination of the program with the linked
 * library is not considered a "derivative work" of the program:
 *
 *     - Apache License, version 2.0
 *     - Apache Software License, version 1.0
 *     - GNU Lesser General Public License, version 3
 *     - Mozilla Public License, versions 1.0, 1.1 and 2.0
 *     - Common Development and Distribution License (CDDL), version 1.0
 *
 * Therefore the distribution of the program linked with libraries licensed
 * under the aforementioned licenses, is permitted by the copyright holders
 * if the distribution is compliant with both the GNU General Public
 * License version 2 and the aforementioned licenses.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
 * Public License for more details.
 */
package org.n52.sos.encode;

import java.util.Collections;
import java.util.EnumMap;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import org.apache.xmlbeans.XmlException;
import org.apache.xmlbeans.XmlObject;
import org.n52.iceland.coding.encode.Encoder;
import org.n52.iceland.coding.encode.EncoderKey;
import org.n52.iceland.exception.ows.OwsExceptionReport;
import org.n52.iceland.exception.ows.concrete.UnsupportedEncoderInputException;
import org.n52.iceland.ogc.ows.OWSConstants.HelperValues;
import org.n52.iceland.response.AbstractServiceResponse;
import org.n52.iceland.util.http.MediaType;
import org.n52.iceland.util.http.MediaTypes;
import org.n52.sos.PubSubConstants;
import org.n52.sos.response.PauseSubscriptionResponse;
import org.n52.sos.response.ResumeSubscriptionResponse;
import org.n52.sos.response.SubscribeResponse;
import org.n52.sos.response.UnsubscribeResponse;
import org.n52.sos.util.CodingHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author <a href="mailto:e.h.juerrens@52north.org">Eike Hinderk J&uuml;rrens</a>
 *
 * @since 5.0.0
 */
public class PubSubEncoder implements Encoder<XmlObject, AbstractServiceResponse> {

	private static final Logger LOGGER = LoggerFactory.getLogger(PubSubEncoder.class);

    private static final Set<EncoderKey> ENCODER_KEYS = CodingHelper.encoderKeysForElements(PubSubConstants.NS_PUBSUB,
            SubscribeResponse.class,
            UnsubscribeResponse.class,
            PauseSubscriptionResponse.class,
            ResumeSubscriptionResponse.class);

    public PubSubEncoder() {
        LOGGER.debug("Encoder for the following keys initialized successfully: {}!",
                ENCODER_KEYS
                	.stream()
                	.map(EncoderKey::toString)
                	.collect(Collectors.joining(", ")));
    }

    @Override
    public Set<EncoderKey> getKeys() {
        return Collections.unmodifiableSet(ENCODER_KEYS);
    }

	@Override
	public XmlObject encode(AbstractServiceResponse objectToEncode)
			throws OwsExceptionReport, UnsupportedEncoderInputException {
		Map<HelperValues, String> additionalValues = new EnumMap<HelperValues, String>(HelperValues.class);
        additionalValues.put(HelperValues.VERSION, PubSubConstants.SERVICEVERSION);
        return encode(objectToEncode, additionalValues);
	}

	@Override
	public XmlObject encode(AbstractServiceResponse objectToEncode,
			Map<HelperValues, String> additionalValues)
			throws OwsExceptionReport, UnsupportedEncoderInputException {
		// TODO adjust to current state of implementation
        if (objectToEncode instanceof SubscribeResponse) {
        	try {
				return XmlObject.Factory.parse(((SubscribeResponse) objectToEncode).getResponseString());
			} catch (XmlException e) {
				throw new UnsupportedEncoderInputException(this, objectToEncode);
			}
        } else if (objectToEncode instanceof UnsubscribeResponse) {
        	try {
				return XmlObject.Factory.parse(((UnsubscribeResponse) objectToEncode).getResponseString());
			} catch (XmlException e) {
				throw new UnsupportedEncoderInputException(this, objectToEncode);
			}
        } else {
            throw new UnsupportedEncoderInputException(this, objectToEncode);
        }
	}

	@Override
	public MediaType getContentType() {
		return MediaTypes.TEXT_XML;
	}
	
	@Override
	public void addNamespacePrefixToMap(Map<String, String> nameSpacePrefixMap) {
		nameSpacePrefixMap.put(PubSubConstants.NS_PUBSUB, PubSubConstants.NS_PUBSUB_PREFIX);
	}

}

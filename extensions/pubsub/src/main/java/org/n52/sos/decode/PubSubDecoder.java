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
package org.n52.sos.decode;

import java.util.Collections;
import java.util.Set;
import java.util.stream.Collectors;

import org.apache.xmlbeans.XmlObject;
import org.n52.iceland.coding.decode.Decoder;
import org.n52.iceland.coding.decode.DecoderKey;
import org.n52.iceland.exception.ows.OwsExceptionReport;
import org.n52.iceland.exception.ows.concrete.UnsupportedDecoderInputException;
import org.n52.iceland.service.AbstractServiceCommunicationObject;
import org.n52.iceland.util.CollectionHelper;
import org.n52.sos.PubSubConstants;
import org.n52.sos.request.DescribePublicationTypeRequest;
import org.n52.sos.request.DescribeSubscriptionRequest;
import org.n52.sos.request.RenewRequest;
import org.n52.sos.request.SubscribeRequest;
import org.n52.sos.request.UnsubscribeRequest;
import org.n52.sos.util.CodingHelper;
import org.oasisOpen.docs.wsn.b2.RenewDocument;
import org.oasisOpen.docs.wsn.b2.SubscribeDocument;
import org.oasisOpen.docs.wsn.b2.UnsubscribeDocument;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class PubSubDecoder implements Decoder<AbstractServiceCommunicationObject, XmlObject> {
    
    private static final Logger LOGGER = LoggerFactory.getLogger(PubSubDecoder.class);

    private static final Set<DecoderKey> DECODER_KEYS = CollectionHelper.union(
            CodingHelper.decoderKeysForElements(SubscribeDocument.type.getDocumentElementName().getNamespaceURI(),
            SubscribeDocument.class,
            UnsubscribeDocument.class,
            RenewDocument.class
        ),
       CodingHelper.xmlDecoderKeysForOperation(
               PubSubConstants.SERVICE, 
               PubSubConstants.SERVICEVERSION,
               PubSubConstants.Operations.Subscribe
        )
    );
    
    public PubSubDecoder() {
        LOGGER.debug(
        		"Decoder for the following keys initialized successfully: {}!", 
        		DECODER_KEYS.stream().map(String::valueOf).collect(Collectors.joining(", ")));
    }
    
    @Override
    public Set<DecoderKey> getKeys() {
        return Collections.unmodifiableSet(DECODER_KEYS);
    }

    @Override
    public AbstractServiceCommunicationObject decode(final XmlObject xml) throws OwsExceptionReport,
            UnsupportedDecoderInputException {
        if (xml.getDomNode().getFirstChild().getNodeName().contains(PubSubConstants.Operations.DescribePublicationType.name())) {
            DescribePublicationTypeRequest request = new DescribePublicationTypeRequest();
            request.setService(PubSubConstants.SERVICE);
            request.setVersion(PubSubConstants.SERVICEVERSION);
            return request;
        } else if (xml.getDomNode().getFirstChild().getNodeName().contains(PubSubConstants.Operations.DescribeSubscription.name())) {
            DescribeSubscriptionRequest request = new DescribeSubscriptionRequest();
            request.setService(PubSubConstants.SERVICE);
            request.setVersion(PubSubConstants.SERVICEVERSION);
            return request;
        } else if (xml.getDomNode().getFirstChild().getNodeName().contains(PubSubConstants.Operations.Renew.name())) {
            RenewRequest request = new RenewRequest();
            request.setService(PubSubConstants.SERVICE);
            request.setVersion(PubSubConstants.SERVICEVERSION);
            return request;
        } else if (xml.getDomNode().getFirstChild().getNodeName().contains(PubSubConstants.Operations.Subscribe.name())) {
            SubscribeRequest request = new SubscribeRequest(xml);
            request.setService(PubSubConstants.SERVICE);
            request.setVersion(PubSubConstants.SERVICEVERSION);
            return request;
        } else if (xml.getDomNode().getFirstChild().getNodeName().contains(PubSubConstants.Operations.Unsubscribe.name())) {
            UnsubscribeRequest request = new UnsubscribeRequest(xml);
            request.setService(PubSubConstants.SERVICE);
            request.setVersion(PubSubConstants.SERVICEVERSION);
            return request;
        }
        throw new UnsupportedDecoderInputException(this, xml);
    }
}

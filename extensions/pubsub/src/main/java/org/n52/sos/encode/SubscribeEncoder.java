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
import java.util.Set;

import org.apache.xmlbeans.XmlObject;
import org.n52.iceland.exception.ows.OwsExceptionReport;
import org.n52.iceland.w3c.SchemaLocation;
import org.n52.sos.PubSubConstants;
import org.n52.sos.coding.encode.AbstractResponseEncoder;
import org.n52.sos.response.SubscribeResponse;
import org.oasisOpen.docs.wsn.b2.SubscribeResponseDocument;

/**
 * @author <a href="mailto:e.h.juerrens@52north.org">Eike Hinderk J&uuml;rrens</a>
 *
 * @since 5.0.0
 */
public class SubscribeEncoder extends AbstractResponseEncoder<SubscribeResponse> {

    public SubscribeEncoder() {
    	super(PubSubConstants.SERVICE,
    			PubSubConstants.SERVICEVERSION,
    			PubSubConstants.Operations.Subscribe.name(),
    			PubSubConstants.NS_PUBSUB,
    			PubSubConstants.NS_PUBSUB_PREFIX,
    			SubscribeResponse.class);
    }

	@Override
	protected Set<SchemaLocation> getConcreteSchemaLocations() {
		return Collections.singleton(new SchemaLocation(PubSubConstants.NS_PUBSUB, PubSubConstants.NS_PUBSUB_SCHEMA_LOC));
	}

	@Override
	protected XmlObject create(SubscribeResponse response)
			throws OwsExceptionReport {
		final SubscribeResponseDocument xbResponse = SubscribeResponseDocument.Factory.newInstance();
		xbResponse.addNewSubscribeResponse()
			.addNewSubscriptionReference()
			.addNewAddress()
			.setStringValue(response.getResponseString());
		return xbResponse;
	}

}

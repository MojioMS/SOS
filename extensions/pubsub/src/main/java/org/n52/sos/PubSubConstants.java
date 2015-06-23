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
package org.n52.sos;

import org.n52.sos.wsdl.WSDLConstants;
import org.n52.sos.wsdl.WSDLOperation;

/**
 * Provides all constants required by the Pub-Sub-Extension.
 * 
 * @author <a href="mailto:e.h.juerrens@52north.org">Eike Hinderk J&uuml;rrens</a>
 * 
 * @since 5.0.0
 *
 */
public interface PubSubConstants {
	
	/**
	 * The operations of the pub-sub extension
	 *
	 */
	enum Operations {
		Subscribe, DescribePublicationType, DescribeSubscription, Renew, Unsubscribe, ResumeSubscription
	}

	/**
	 * The service identifier for the pub-sub extension service: "PubSub"
	 */
	String SERVICE = "PubSub";
	
	/**
	 * The service version identifier for the pub-sub extension specification that is implemented.
	 */
	String SERVICEVERSION = "1.0.0";
	
	String NS_PUBSUB = "http://www.opengis.net/pubsub/1.0/core";

    String NS_PUBSUB_PREFIX = "psc";
	
	interface WSDLOperations extends WSDLConstants {
		// TODO adjust to Pub-Sub values
        WSDLOperation SUBSCRIBE = WSDLOperation.newWSDLOperation()
                .setName(PubSubConstants.Operations.Subscribe.name()).setVersion(PubSubConstants.SERVICEVERSION)
                /*.setRequest(SwesConstants.QN_DELETE_SENSOR).setRequestAction(SoapRequestActionUris.DELETE_SENSOR)
                .setResponse(SwesConstants.QN_DELETE_SENSOR_RESPONSE)
                .setResponseAction(SoapResponseActionUris.DELETE_SENSOR).setFaults(WSDLFault.DEFAULT_FAULTS)*/.build();
	}

}

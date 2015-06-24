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
package org.n52.sos.handler;

import org.n52.iceland.exception.ows.OwsExceptionReport;
import org.n52.iceland.ogc.ows.OwsOperation;
import org.n52.sos.PubSubConstants;
import org.n52.sos.ds.AbstractOperationHandler;
import org.n52.sos.exception.pubsub.PubSubProcessorException;
import org.n52.sos.request.UnsubscribeRequest;
import org.n52.sos.response.UnsubscribeResponse;

/**
 * @author <a href="mailto:e.h.juerrens@52north.org">Eike Hinderk J&uuml;rrens</a>
 * 
 * @since 5.0.0
 *
 */
public class UnsubscribeHandler extends AbstractOperationHandler {

    public UnsubscribeHandler() {
        super(PubSubConstants.SERVICE, PubSubConstants.Operations.Unsubscribe.name());
    }

    public UnsubscribeResponse getUnsubscribe(UnsubscribeRequest request) throws PubSubProcessorException {
        UnsubscribeResponse response = new UnsubscribeResponse();
        response.setService(request.getService());
        response.setVersion(request.getVersion());
        // TODO @matthesrieke Implement delegation to EPOS
        /*
        response.setResponseString(
        		PubSubProcessorFacade.getInstance().getProcessorInstance().processUnsubscribe(
        				request.getPayload(),
        				request.getSoapHeader()).xmlText());
        */
        return response;
    }

	@Override
	protected void setOperationsMetadata(OwsOperation operation,
			String service, String version) throws OwsExceptionReport {
		// TODO Implement operations metadata for pub-sub Unsubscribe operation
	}

}
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
package org.n52.sos.request.operator;

import java.util.Collections;
import java.util.Set;

import org.n52.iceland.exception.ows.CompositeOwsException;
import org.n52.iceland.exception.ows.OwsExceptionReport;
import org.n52.iceland.ogc.sos.ConformanceClasses;
import org.n52.sos.PubSubConstants;
import org.n52.sos.handler.UnsubscribeHandler;
import org.n52.sos.request.UnsubscribeRequest;
import org.n52.sos.response.UnsubscribeResponse;

/**
 * class handles the pub-sub Unsubscribe request
 * 
 * @author <a href="mailto:e.h.juerrens@52north.org">Eike Hinderk J&uuml;rrens</a>
 * 
 * @since 5.0.0
 */
public class UnsubscribeOperator extends
        AbstractRequestOperator<UnsubscribeHandler, UnsubscribeRequest, UnsubscribeResponse> {
	
    private static final String OPERATION_NAME = PubSubConstants.Operations.Unsubscribe.name();

    // TODO add pub sub conformance classes
    private static final Set<String> CONFORMANCE_CLASSES = 
    		Collections.singleton(ConformanceClasses.SOS_V2_CORE_PROFILE);

    public UnsubscribeOperator() {
        super(PubSubConstants.SERVICE,
        		PubSubConstants.SERVICEVERSION,
        		OPERATION_NAME,
        		UnsubscribeRequest.class);
    }

    @Override
    public Set<String> getConformanceClasses(String service, String version) {
        if(PubSubConstants.SERVICE.equals(service) && PubSubConstants.SERVICEVERSION.equals(version)) {
            return Collections.unmodifiableSet(CONFORMANCE_CLASSES);
        }
        return Collections.emptySet();
    }

    @Override
    public UnsubscribeResponse receive(UnsubscribeRequest request) throws OwsExceptionReport {
        return getOperationHandler().getUnsubscribe(request);
    }

    @Override
    protected void checkParameters(UnsubscribeRequest unsubscribeRequest) throws OwsExceptionReport {
        CompositeOwsException exceptions = new CompositeOwsException();
        try {
            checkServiceParameter(unsubscribeRequest.getService());
        } catch (OwsExceptionReport owse) {
            exceptions.add(owse);
        }
        try {
            checkSingleVersionParameter(unsubscribeRequest);
        } catch (OwsExceptionReport owse) {
            exceptions.add(owse);
        }
        exceptions.throwIfNotEmpty();
    }
    
}

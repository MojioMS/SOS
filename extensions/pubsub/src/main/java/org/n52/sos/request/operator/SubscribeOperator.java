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
import org.n52.sos.handler.SubscribeHandler;
import org.n52.sos.request.SubscribeRequest;
import org.n52.sos.response.SubscribeResponse;

/**
 * class handles the pub-sub Subscribe request
 * 
 * @author <a href="mailto:e.h.juerrens@52north.org">Eike Hinderk J&uuml;rrens</a>
 * 
 * @since 5.0.0
 */
public class SubscribeOperator extends
        AbstractRequestOperator<SubscribeHandler, SubscribeRequest, SubscribeResponse> {
	
    private static final String OPERATION_NAME = PubSubConstants.Operations.Subscribe.name();

    // TODO add pub sub conformance classes
    private static final Set<String> CONFORMANCE_CLASSES = Collections
            .singleton(ConformanceClasses.SOS_V2_CORE_PROFILE);

    public SubscribeOperator() {
        super(PubSubConstants.SERVICE,
        		PubSubConstants.SERVICEVERSION,
        		OPERATION_NAME,
        		SubscribeRequest.class);
    }

    @Override
    public Set<String> getConformanceClasses(String service, String version) {
        if(PubSubConstants.SERVICE.equals(service) && PubSubConstants.SERVICEVERSION.equals(version)) {
            return Collections.unmodifiableSet(CONFORMANCE_CLASSES);
        }
        return Collections.emptySet();
    }

    @Override
    public SubscribeResponse receive(SubscribeRequest request) throws OwsExceptionReport {
        return getOperationHandler().getSubscribe(request);
    }

    @Override
    protected void checkParameters(SubscribeRequest subscribeRequest) throws OwsExceptionReport {
        CompositeOwsException exceptions = new CompositeOwsException();
        try {
            checkServiceParameter(subscribeRequest.getService());
        } catch (OwsExceptionReport owse) {
            exceptions.add(owse);
        }
        try {
            checkSingleVersionParameter(subscribeRequest);
        } catch (OwsExceptionReport owse) {
            exceptions.add(owse);
        }
//        try {
//            checkProcedureID(subscribeRequest.getProcedure(), SosConstants.DescribeSensorParams.procedure.name());
//        } catch (OwsExceptionReport owse) {
//            exceptions.add(owse);
//        }
//        try {
//            checkProcedureDescriptionFromat(subscribeRequest.getProcedureDescriptionFormat(), subscribeRequest);
//        } catch (OwsExceptionReport owse) {
//            exceptions.add(owse);
//        }
        // if (sosRequest.isSetValidTime()) {
        // exceptions.add(new
        // OptionNotSupportedException().at(Sos2Constants.DescribeSensorParams.validTime)
        // .withMessage("The requested parameter is not supported by this server!"));
        // }
//        checkExtensions(subscribeRequest, exceptions);
        exceptions.throwIfNotEmpty();
    }
    
}

/**
 * ﻿Copyright (C) 2013
 * by 52 North Initiative for Geospatial Open Source Software GmbH
 *
 * Contact: Andreas Wytzisk
 * 52 North Initiative for Geospatial Open Source Software GmbH
 * Martin-Luther-King-Weg 24
 * 48155 Muenster, Germany
 * info@52north.org
 *
 * This program is free software; you can redistribute and/or modify it under
 * the terms of the GNU General Public License version 2 as published by the
 * Free Software Foundation.
 *
 * This program is distributed WITHOUT ANY WARRANTY; even without the implied
 * WARRANTY OF MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program (see gnu-gpl v2.txt). If not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA or
 * visit the Free Software Foundation web page, http://www.fsf.org.
 */
package org.n52.sos.handler;

import org.n52.iceland.exception.ows.OwsExceptionReport;
import org.n52.iceland.ogc.ows.OwsOperation;
import org.n52.sos.PubSubConstants;
import org.n52.sos.ds.AbstractOperationHandler;
import org.n52.sos.request.PauseSubscriptionRequest;
import org.n52.sos.response.PauseSubscriptionResponse;

/**
 * @author <a href="mailto:e.h.juerrens@52north.org">Eike Hinderk J&uuml;rrens</a>
 *
 * @since 5.0.0
 */
public class PauseSubscriptionHandler extends AbstractOperationHandler {

	public PauseSubscriptionHandler() {
        super(PubSubConstants.SERVICE, PubSubConstants.Operations.PauseSubscription.name());
    }

    public PauseSubscriptionResponse getPauseSubscription(PauseSubscriptionRequest request) {
    	PauseSubscriptionResponse response = new PauseSubscriptionResponse();
        response.setService(request.getService());
        response.setVersion(request.getVersion());
        // TODO @matthesrieke Implement delegation to EPOS
        response.setResponseString("NO YET IMPLEMENTED");
        return response;
    }

	@Override
	protected void setOperationsMetadata(OwsOperation operation,
			String service, String version) throws OwsExceptionReport {
		// TODO Implement Pause subscription operations metadata
	}

}

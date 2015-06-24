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
package org.n52.sos.event;

import java.util.Set;

import org.n52.iceland.event.ServiceEvent;
import org.n52.iceland.event.ServiceEventListener;
import org.n52.iceland.util.CollectionHelper;
import org.n52.sos.epos.EPOSFascade;
import org.n52.sos.event.events.ObservationInsertion;
import org.n52.sos.event.events.ResultInsertion;
import org.n52.sos.event.events.ResultTemplateInsertion;
import org.n52.sos.event.events.SensorDeletion;
import org.n52.sos.event.events.SensorInsertion;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Delegates relevant SOS events to the EPOS implementation.
 * 
 * @author <a href="mailto:e.h.juerrens@52north.org">Eike Hinderk J&uuml;rrens</a>
 * 
 * @since 5.0.0
 *
 */
public class EventListener implements ServiceEventListener {

	private static final Logger LOGGER = LoggerFactory.getLogger(EventListener.class);
	
	private static final Set<Class<? extends ServiceEvent>> TYPES = CollectionHelper.<Class<? extends ServiceEvent>>set(
            SensorInsertion.class,
            ObservationInsertion.class,
            ResultTemplateInsertion.class,
            SensorDeletion.class,
            ResultInsertion.class);
	
	@Override
	public Set<Class<? extends ServiceEvent>> getTypes() {
		return CollectionHelper.unmodifiableSet(TYPES);
	}

	@Override
	public void handle(ServiceEvent event) {
		// TODO execute thread / submit to executor
		/*if (event instanceof SensorInsertion) {
            // TODO ... process
        } else */if (event instanceof ObservationInsertion) {
            EPOSFascade.getInstance().getProcessorInstance().processMessage((ObservationInsertion) event);
        } /*else if (event instanceof ResultTemplateInsertion) {
            // TODO ... process
        } else if (event instanceof SensorDeletion) {
            // TODO ... process
        } else if (event instanceof ResultInsertion) {
            // TODO ... process
        } */else {
            LOGGER.debug("Can not handle modification event: {}", event);
        }
	}

}

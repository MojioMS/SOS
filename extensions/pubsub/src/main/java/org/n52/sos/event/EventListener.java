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

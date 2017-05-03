/**
 * Copyright (C) 2012-2016 52°North Initiative for Geospatial Open Source
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
package org.n52.svalbard.encode;

import com.google.common.collect.Sets;
import java.util.Collections;
import java.util.Set;
import net.opengis.urt.x10.UpdateResultTemplateResponseDocument;
import net.opengis.urt.x10.UpdateResultTemplateResponseType;
import org.apache.xmlbeans.XmlObject;
import org.n52.shetland.ogc.sos.urt.UpdateResultTemplateConstants;
import org.n52.sos.encode.AbstractResponseEncoder;
import org.n52.sos.exception.ows.concrete.MissingServiceParameterException;
import org.n52.sos.exception.ows.concrete.MissingVersionParameterException;
import org.n52.sos.exception.ows.concrete.UnsupportedEncoderInputException;
import org.n52.sos.ogc.ows.CompositeOwsException;
import org.n52.sos.ogc.ows.OwsExceptionReport;
import org.n52.sos.ogc.sos.Sos2Constants;
import org.n52.sos.ogc.sos.SosConstants;
import org.n52.sos.response.UpdateResultTemplateResponse;
import org.n52.sos.w3c.SchemaLocation;

/**
 * @author <a href="mailto:e.h.juerrens@52north.org">Eike Hinderk J&uuml;rrens</a>
 * @since 4.4.0
 */
public class UpdateResultTemplateEncoder extends AbstractResponseEncoder<UpdateResultTemplateResponse> {

    public static final SchemaLocation SCHEMA_LOCATION = new SchemaLocation(UpdateResultTemplateConstants.NS,
            UpdateResultTemplateConstants.SCHEMA_LOCATION_URL);

    public UpdateResultTemplateEncoder() {
        super(SosConstants.SOS,
                Sos2Constants.SERVICEVERSION,
                UpdateResultTemplateConstants.OPERATION_NAME,
                UpdateResultTemplateConstants.NS,
                UpdateResultTemplateConstants.NS_PREFIX,
                UpdateResultTemplateResponse.class);
    }

    @Override
    public Set<String> getConformanceClasses() {
        return Collections.unmodifiableSet(Sets.newHashSet(
                UpdateResultTemplateConstants.CONFORMANCE_CLASS_INSERTION,
                UpdateResultTemplateConstants.CONFORMANCE_CLASS_RETRIEVAL));
    }

    @Override
    protected XmlObject create(UpdateResultTemplateResponse urtr) throws OwsExceptionReport {
        if (urtr == null) {
            throw new UnsupportedEncoderInputException(this, urtr);
        }
        final CompositeOwsException exceptions = new CompositeOwsException();
        if (urtr.getService() == null) {
            exceptions.add(new MissingServiceParameterException());
        }
        if (urtr.getVersion() == null) {
            exceptions.add(new MissingVersionParameterException());
        }
        exceptions.throwIfNotEmpty();
        
        UpdateResultTemplateResponseDocument drtrd =
                UpdateResultTemplateResponseDocument.Factory.newInstance(getXmlOptions());
        UpdateResultTemplateResponseType drtrt = drtrd.addNewUpdateResultTemplateResponse();
        if (urtr.isSetResultTemplate()) {
            drtrt.setResultTemplate(urtr.getResultTemplate());
        }
        return drtrd;
    }

    @Override
    public Set<SchemaLocation> getSchemaLocations() {
        return Sets.newHashSet(SCHEMA_LOCATION);
    }

    @Override
    protected Set<SchemaLocation> getConcreteSchemaLocations() {
        return Sets.newHashSet();
    }
}

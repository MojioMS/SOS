\connect template_postgis
DROP SCHEMA IF EXISTS tiger CASCADE;
DROP SCHEMA IF EXISTS tiger_data CASCADE;
\connect sos
DROP SCHEMA IF EXISTS tiger CASCADE;
DROP SCHEMA IF EXISTS tiger_data CASCADE;
CREATE TABLE blobvalue (
    observationid bigint NOT NULL,
    value oid
);
COMMENT ON TABLE blobvalue IS 'Value table for blob observation';
COMMENT ON COLUMN blobvalue.observationid IS 'Foreign Key (FK) to the related observation from the observation table. Contains "observation".observationid';
COMMENT ON COLUMN blobvalue.value IS 'Blob observation value';
CREATE TABLE booleanfeatparamvalue (
    parameterid bigint NOT NULL,
    value character(1),
    CONSTRAINT booleanfeatparamvalue_value_check CHECK ((value = ANY (ARRAY['T'::bpchar, 'F'::bpchar])))
);
COMMENT ON TABLE booleanfeatparamvalue IS 'Value table for boolean parameter';
COMMENT ON COLUMN booleanfeatparamvalue.parameterid IS 'Foreign Key (FK) to the related parameter from the parameter table. Contains "featureParameter".parameterid';
COMMENT ON COLUMN booleanfeatparamvalue.value IS 'Boolean parameter value';
CREATE TABLE booleanparametervalue (
    parameterid bigint NOT NULL,
    value character(1),
    CONSTRAINT booleanparametervalue_value_check CHECK ((value = ANY (ARRAY['T'::bpchar, 'F'::bpchar])))
);
COMMENT ON TABLE booleanparametervalue IS 'Value table for boolean parameter';
COMMENT ON COLUMN booleanparametervalue.parameterid IS 'Foreign Key (FK) to the related parameter from the parameter table. Contains "parameter".parameterid';
COMMENT ON COLUMN booleanparametervalue.value IS 'Boolean parameter value';
CREATE TABLE booleanvalue (
    observationid bigint NOT NULL,
    value character(1),
    CONSTRAINT booleanvalue_value_check CHECK ((value = ANY (ARRAY['T'::bpchar, 'F'::bpchar]))),
    CONSTRAINT booleanvalue_value_check1 CHECK ((value = ANY (ARRAY['T'::bpchar, 'F'::bpchar])))
);
COMMENT ON TABLE booleanvalue IS 'Value table for boolean observation';
COMMENT ON COLUMN booleanvalue.observationid IS 'Foreign Key (FK) to the related observation from the observation table. Contains "observation".observationid';
COMMENT ON COLUMN booleanvalue.value IS 'Boolean observation value';
CREATE TABLE categoryfeatparamvalue (
    parameterid bigint NOT NULL,
    value character varying(255),
    unitid bigint
);
COMMENT ON TABLE categoryfeatparamvalue IS 'Value table for category parameter';
COMMENT ON COLUMN categoryfeatparamvalue.parameterid IS 'Foreign Key (FK) to the related parameter from the parameter table. Contains "featureParameter".parameterid';
COMMENT ON COLUMN categoryfeatparamvalue.value IS 'Category parameter value';
COMMENT ON COLUMN categoryfeatparamvalue.unitid IS 'Foreign Key (FK) to the related unit of measure. Contains "unit".unitid. Optional';
CREATE TABLE categoryparametervalue (
    parameterid bigint NOT NULL,
    value character varying(255),
    unitid bigint
);
COMMENT ON TABLE categoryparametervalue IS 'Value table for category parameter';
COMMENT ON COLUMN categoryparametervalue.parameterid IS 'Foreign Key (FK) to the related parameter from the parameter table. Contains "parameter".parameterid';
COMMENT ON COLUMN categoryparametervalue.value IS 'Category parameter value';
COMMENT ON COLUMN categoryparametervalue.unitid IS 'Foreign Key (FK) to the related unit of measure. Contains "unit".unitid. Optional';
CREATE TABLE categoryvalue (
    observationid bigint NOT NULL,
    value character varying(255),
    identifier character varying(255),
    name character varying(255),
    description character varying(255)
);
COMMENT ON TABLE categoryvalue IS 'Value table for category observation';
COMMENT ON COLUMN categoryvalue.observationid IS 'Foreign Key (FK) to the related observation from the observation table. Contains "observation".observationid';
COMMENT ON COLUMN categoryvalue.value IS 'Category observation value';
COMMENT ON COLUMN categoryvalue.identifier IS 'SweCategory observation identifier';
COMMENT ON COLUMN categoryvalue.name IS 'SweCategory observation name';
COMMENT ON COLUMN categoryvalue.description IS 'SweCategory observation description';
CREATE TABLE codespace (
    codespaceid bigint NOT NULL,
    codespace character varying(255) NOT NULL
);
COMMENT ON TABLE codespace IS 'Table to store the gml:identifier and gml:name codespace information. Mapping file: mapping/core/Codespace.hbm.xml';
COMMENT ON COLUMN codespace.codespaceid IS 'Table primary key, used for relations';
COMMENT ON COLUMN codespace.codespace IS 'The codespace value';
CREATE TABLE complexvalue (
    observationid bigint NOT NULL
);
COMMENT ON TABLE complexvalue IS 'Value table for complex observation';
COMMENT ON COLUMN complexvalue.observationid IS 'Foreign Key (FK) to the related observation from the observation table. Contains "observation".observationid';
CREATE TABLE compositeobservation (
    observationid bigint NOT NULL,
    childobservationid bigint NOT NULL
);
COMMENT ON TABLE compositeobservation IS 'Relation table for complex parent/child observations';
COMMENT ON COLUMN compositeobservation.observationid IS 'Foreign Key (FK) to the related parent complex observation. Contains "observation".observationid';
COMMENT ON COLUMN compositeobservation.childobservationid IS 'Foreign Key (FK) to the related child complex observation. Contains "observation".observationid';
CREATE TABLE compositephenomenon (
    parentobservablepropertyid bigint NOT NULL,
    childobservablepropertyid bigint NOT NULL
);
COMMENT ON TABLE compositephenomenon IS 'Relation table to store observableProperty hierarchies, aka compositePhenomenon. E.g. define a parent in a query and all childs are also contained in the response. Mapping file: mapping/transactional/TObservableProperty.hbm.xml';
COMMENT ON COLUMN compositephenomenon.parentobservablepropertyid IS 'Foreign Key (FK) to the related parent observableProperty. Contains "observableProperty".observablePropertyid';
COMMENT ON COLUMN compositephenomenon.childobservablepropertyid IS 'Foreign Key (FK) to the related child observableProperty. Contains "observableProperty".observablePropertyid';
CREATE TABLE countfeatparamvalue (
    parameterid bigint NOT NULL,
    value integer
);
COMMENT ON TABLE countfeatparamvalue IS 'Value table for count parameter';
COMMENT ON COLUMN countfeatparamvalue.parameterid IS 'Foreign Key (FK) to the related parameter from the parameter table. Contains "featureParameter".parameterid';
COMMENT ON COLUMN countfeatparamvalue.value IS 'Count parameter value';
CREATE TABLE countparametervalue (
    parameterid bigint NOT NULL,
    value integer
);
COMMENT ON TABLE countparametervalue IS 'Value table for count parameter';
COMMENT ON COLUMN countparametervalue.parameterid IS 'Foreign Key (FK) to the related parameter from the parameter table. Contains "parameter".parameterid';
COMMENT ON COLUMN countparametervalue.value IS 'Count parameter value';
CREATE TABLE countvalue (
    observationid bigint NOT NULL,
    value integer
);
COMMENT ON TABLE countvalue IS 'Value table for count observation';
COMMENT ON COLUMN countvalue.observationid IS 'Foreign Key (FK) to the related observation from the observation table. Contains "observation".observationid';
COMMENT ON COLUMN countvalue.value IS 'Count observation value';
CREATE TABLE featureofinterest (
    featureofinterestid bigint NOT NULL,
    hibernatediscriminator character varying(255),
    featureofinteresttypeid bigint NOT NULL,
    identifier character varying(255),
    codespace bigint,
    name character varying(255),
    codespacename bigint,
    description character varying(255),
    geom geometry,
    descriptionxml text,
    url character varying(255)
);
COMMENT ON COLUMN featureofinterest.featureofinterestid IS 'Table primary key, used for relations';
COMMENT ON COLUMN featureofinterest.featureofinteresttypeid IS 'Relation/foreign key to the featureOfInterestType table. Describes the type of the featureOfInterest. Contains "featureOfInterestType".featureOfInterestTypeId';
COMMENT ON COLUMN featureofinterest.identifier IS 'The identifier of the featureOfInterest, gml:identifier. Used as parameter for queries. Optional but unique';
COMMENT ON COLUMN featureofinterest.codespace IS 'Relation/foreign key to the codespace table. Contains the gml:identifier codespace. Optional';
COMMENT ON COLUMN featureofinterest.name IS 'The name of the featureOfInterest, gml:name. Optional';
COMMENT ON COLUMN featureofinterest.codespacename IS 'The name of the featureOfInterest, gml:name. Optional';
COMMENT ON COLUMN featureofinterest.description IS 'Description of the featureOfInterest, gml:description. Optional';
COMMENT ON COLUMN featureofinterest.geom IS 'The geometry of the featureOfInterest (composed of the “latitude” and “longitude”) . Optional';
COMMENT ON COLUMN featureofinterest.descriptionxml IS 'XML description of the feature, used when transactional profile is supported . Optional';
COMMENT ON COLUMN featureofinterest.url IS 'Reference URL to the feature if it is stored in another service, e.g. WFS. Optional but unique';
CREATE TABLE featureofinteresttype (
    featureofinteresttypeid bigint NOT NULL,
    featureofinteresttype character varying(255) NOT NULL
);
COMMENT ON TABLE featureofinteresttype IS 'Table to store the FeatureOfInterestType information. Mapping file: mapping/core/FeatureOfInterestType.hbm.xml';
COMMENT ON COLUMN featureofinteresttype.featureofinteresttypeid IS 'Table primary key, used for relations';
COMMENT ON COLUMN featureofinteresttype.featureofinteresttype IS 'The featureOfInterestType value, e.g. http://www.opengis.net/def/samplingFeatureType/OGC-OM/2.0/SF_SamplingPoint (OGC OM 2.0 specification) for point features';
CREATE TABLE featureparameter (
    parameterid bigint NOT NULL,
    featureofinterestid bigint NOT NULL,
    name character varying(255) NOT NULL
);
COMMENT ON TABLE featureparameter IS 'Table to store additional featureOfInterest information (sf:parameter). Mapping file: mapping/core/FeatureParameter.hbm.xml';
COMMENT ON COLUMN featureparameter.parameterid IS 'Table primary key';
COMMENT ON COLUMN featureparameter.featureofinterestid IS 'Foreign Key (FK) to the related featureOfInterest. Contains "featureOfInterest.featureOfInterestId';
COMMENT ON COLUMN featureparameter.name IS 'Parameter name';
CREATE TABLE featurerelation (
    parentfeatureid bigint NOT NULL,
    childfeatureid bigint NOT NULL
);
COMMENT ON TABLE featurerelation IS 'Relation table to store feature hierarchies. E.g. define a parent in a query and all childs are also contained in the response. Mapping file: mapping/transactional/TFeatureOfInterest.hbm.xml';
COMMENT ON COLUMN featurerelation.parentfeatureid IS 'Foreign Key (FK) to the related parent featureOfInterest. Contains "featureOfInterest".featureOfInterestid';
COMMENT ON COLUMN featurerelation.childfeatureid IS 'Foreign Key (FK) to the related child featureOfInterest. Contains "featureOfInterest".featureOfInterestid';
CREATE TABLE geometryvalue (
    observationid bigint NOT NULL,
    value geometry
);
COMMENT ON TABLE geometryvalue IS 'Value table for geometry observation';
COMMENT ON COLUMN geometryvalue.observationid IS 'Foreign Key (FK) to the related observation from the observation table. Contains "observation".observationid';
COMMENT ON COLUMN geometryvalue.value IS 'Geometry observation value';
CREATE TABLE numericfeatparamvalue (
    parameterid bigint NOT NULL,
    value double precision,
    unitid bigint
);
COMMENT ON TABLE numericfeatparamvalue IS 'Value table for numeric/Measurment parameter';
COMMENT ON COLUMN numericfeatparamvalue.parameterid IS 'Foreign Key (FK) to the related parameter from the parameter table. Contains "featureParameter".parameterid';
COMMENT ON COLUMN numericfeatparamvalue.value IS 'Numeric/Quantity parameter value';
COMMENT ON COLUMN numericfeatparamvalue.unitid IS 'Foreign Key (FK) to the related unit of measure. Contains "unit".unitid. Optional';
CREATE TABLE numericparametervalue (
    parameterid bigint NOT NULL,
    value double precision,
    unitid bigint
);
COMMENT ON TABLE numericparametervalue IS 'Value table for numeric/Measurment parameter';
COMMENT ON COLUMN numericparametervalue.parameterid IS 'Foreign Key (FK) to the related parameter from the parameter table. Contains "parameter".parameterid';
COMMENT ON COLUMN numericparametervalue.value IS 'Numeric/Quantity parameter value';
COMMENT ON COLUMN numericparametervalue.unitid IS 'Foreign Key (FK) to the related unit of measure. Contains "unit".unitid. Optional';
CREATE TABLE numericvalue (
    observationid bigint NOT NULL,
    value double precision
);
COMMENT ON TABLE numericvalue IS 'Value table for numeric/Measurment observation';
COMMENT ON COLUMN numericvalue.observationid IS 'Foreign Key (FK) to the related observation from the observation table. Contains "observation".observationid';
COMMENT ON COLUMN numericvalue.value IS 'Numeric/Measurment observation value';
CREATE TABLE observableproperty (
    observablepropertyid bigint NOT NULL,
    identifier character varying(255) NOT NULL,
    codespace bigint,
    name character varying(255),
    codespacename bigint,
    description character varying(255),
    disabled character(1) DEFAULT 'F'::bpchar NOT NULL,
    hiddenchild character(1) DEFAULT 'F'::bpchar NOT NULL,
    CONSTRAINT observableproperty_disabled_check CHECK ((disabled = ANY (ARRAY['T'::bpchar, 'F'::bpchar]))),
    CONSTRAINT observableproperty_hiddenchild_check CHECK ((hiddenchild = ANY (ARRAY['T'::bpchar, 'F'::bpchar])))
);
COMMENT ON TABLE observableproperty IS 'Table to store the ObservedProperty/Phenomenon information. Mapping file: mapping/core/ObservableProperty.hbm.xml';
COMMENT ON COLUMN observableproperty.observablepropertyid IS 'Table primary key, used for relations';
COMMENT ON COLUMN observableproperty.identifier IS 'The identifier of the observableProperty, gml:identifier. Used as parameter for queries. Unique';
COMMENT ON COLUMN observableproperty.codespace IS 'Relation/foreign key to the codespace table. Contains the gml:identifier codespace. Optional';
COMMENT ON COLUMN observableproperty.name IS 'The name of the observableProperty, gml:name. Optional';
COMMENT ON COLUMN observableproperty.codespacename IS 'Relation/foreign key to the codespace table. Contains the gml:name codespace. Optional';
COMMENT ON COLUMN observableproperty.description IS 'Description of the observableProperty, gml:description. Optional';
COMMENT ON COLUMN observableproperty.disabled IS 'For later use by the SOS. Indicator if this observableProperty should not be provided by the SOS.';
CREATE TABLE observation (
    observationid bigint NOT NULL,
    seriesid bigint NOT NULL,
    phenomenontimestart timestamp without time zone NOT NULL,
    phenomenontimeend timestamp without time zone NOT NULL,
    resulttime timestamp without time zone NOT NULL,
    identifier character varying(255),
    codespace bigint,
    name character varying(255),
    codespacename bigint,
    description character varying(255),
    deleted character(1) DEFAULT 'F'::bpchar NOT NULL,
    child character(1) DEFAULT 'F'::bpchar NOT NULL,
    parent character(1) DEFAULT 'F'::bpchar NOT NULL,
    validtimestart timestamp without time zone,
    validtimeend timestamp without time zone,
    samplinggeometry geometry,
    unitid bigint,
    CONSTRAINT observation_child_check CHECK ((child = ANY (ARRAY['T'::bpchar, 'F'::bpchar]))),
    CONSTRAINT observation_deleted_check CHECK ((deleted = ANY (ARRAY['T'::bpchar, 'F'::bpchar]))),
    CONSTRAINT observation_parent_check CHECK ((parent = ANY (ARRAY['T'::bpchar, 'F'::bpchar])))
);
COMMENT ON TABLE observation IS 'Stores the observations. Mapping file: mapping/series/observation/Observation.hbm.xml';
COMMENT ON COLUMN observation.observationid IS 'Table primary key, used in relations';
COMMENT ON COLUMN observation.seriesid IS 'Relation/foreign key to the associated series table. Contains "series".seriesId';
COMMENT ON COLUMN observation.phenomenontimestart IS 'Time stamp when the observation was started or phenomenon was observed';
COMMENT ON COLUMN observation.phenomenontimeend IS 'Time stamp when the observation was stopped or phenomenon was observed';
COMMENT ON COLUMN observation.resulttime IS 'Time stamp when the observation was published or result was published/available';
COMMENT ON COLUMN observation.identifier IS 'The identifier of the observation, gml:identifier. Used as parameter for queries. Optional but unique';
COMMENT ON COLUMN observation.codespace IS 'Relation/foreign key to the codespace table. Contains the gml:identifier codespace. Optional';
COMMENT ON COLUMN observation.name IS 'The name of the observation, gml:name. Optional';
COMMENT ON COLUMN observation.codespacename IS 'The name of the observation, gml:name. Optional';
COMMENT ON COLUMN observation.description IS 'The name of the observation, gml:name. Optional';
COMMENT ON COLUMN observation.deleted IS 'Flag to indicate that this observation is deleted or not (OGC SWES 2.0 - DeleteSensor operation or not specified DeleteObservation)';
COMMENT ON COLUMN observation.child IS 'Flag to indicate that this observation is a child observation for complex observation';
COMMENT ON COLUMN observation.parent IS 'Flag to indicate that this observation is a parent observation for complex observation';
COMMENT ON COLUMN observation.validtimestart IS 'Start time stamp for which the observation/result is valid, e.g. used for forecasting. Optional';
COMMENT ON COLUMN observation.validtimeend IS 'End time stamp for which the observation/result is valid, e.g. used for forecasting. Optional';
COMMENT ON COLUMN observation.samplinggeometry IS 'Sampling geometry describes exactly where the measurement has taken place. Used for OGC SOS 2.0 Spatial Filtering Profile. Optional';
COMMENT ON COLUMN observation.unitid IS 'Foreign Key (FK) to the related unit of measure. Contains "unit".unitid. Optional';
CREATE TABLE observationconstellation (
    observationconstellationid bigint NOT NULL,
    observablepropertyid bigint NOT NULL,
    procedureid bigint NOT NULL,
    observationtypeid bigint,
    offeringid bigint NOT NULL,
    deleted character(1) DEFAULT 'F'::bpchar NOT NULL,
    hiddenchild character(1) DEFAULT 'F'::bpchar NOT NULL,
    disabled character(1) DEFAULT 'F'::bpchar NOT NULL,
    CONSTRAINT observationconstellation_deleted_check CHECK ((deleted = ANY (ARRAY['T'::bpchar, 'F'::bpchar]))),
    CONSTRAINT observationconstellation_disabled_check CHECK ((disabled = ANY (ARRAY['T'::bpchar, 'F'::bpchar]))),
    CONSTRAINT observationconstellation_hiddenchild_check CHECK ((hiddenchild = ANY (ARRAY['T'::bpchar, 'F'::bpchar])))
);
COMMENT ON TABLE observationconstellation IS 'Table to store the ObservationConstellation information. Contains information about the constellation of observableProperty, procedure, offering and the observationType. Mapping file: mapping/core/ObservationConstellation.hbm.xml';
COMMENT ON COLUMN observationconstellation.observationconstellationid IS 'Table primary key, used for relations';
COMMENT ON COLUMN observationconstellation.observablepropertyid IS 'Foreign Key (FK) to the related observableProperty. Contains "observableproperty".observablepropertyid';
COMMENT ON COLUMN observationconstellation.procedureid IS 'Foreign Key (FK) to the related procedure. Contains "procedure".procedureid';
COMMENT ON COLUMN observationconstellation.observationtypeid IS 'Foreign Key (FK) to the related observation type. Contains "observationtype".observationtypeid';
COMMENT ON COLUMN observationconstellation.offeringid IS 'Foreign Key (FK) to the related offering. Contains "offering".offeringid';
COMMENT ON COLUMN observationconstellation.deleted IS 'Flag to indicate that this observationConstellation is deleted or not. Set if the related procedure is deleted via DeleteSensor operation (OGC SWES 2.0 - DeleteSensor operation)';
COMMENT ON COLUMN observationconstellation.hiddenchild IS 'Flag to indicate that this observationConstellations procedure is a child procedure of another procedure. If true, the related procedure is not contained in OGC SOS 2.0 Capabilities but in OGC SOS 1.0.0 Capabilities.';
COMMENT ON COLUMN observationconstellation.disabled IS 'Flag to indicate that this observationConstellations is disabled for insertion of observations. If false, new observation could be added to the SOS.';
CREATE TABLE observationhasoffering (
    observationid bigint NOT NULL,
    offeringid bigint NOT NULL
);
COMMENT ON COLUMN observationhasoffering.observationid IS 'Foreign Key (FK) to the related observation. Contains "observation".observationid';
COMMENT ON COLUMN observationhasoffering.offeringid IS 'Foreign Key (FK) to the related offering. Contains "offering".offeringid';
CREATE TABLE observationtype (
    observationtypeid bigint NOT NULL,
    observationtype character varying(255) NOT NULL
);
COMMENT ON TABLE observationtype IS 'Table to store the observationTypes. Mapping file: mapping/core/ObservationType.hbm.xml';
COMMENT ON COLUMN observationtype.observationtypeid IS 'Table primary key, used for relations';
COMMENT ON COLUMN observationtype.observationtype IS 'The observationType value, e.g. http://www.opengis.net/def/observationType/OGC-OM/2.0/OM_Measurement (OGC OM 2.0 specification) for OM_Measurement';
CREATE TABLE offering (
    offeringid bigint NOT NULL,
    hibernatediscriminator character(1) NOT NULL,
    identifier character varying(255) NOT NULL,
    codespace bigint,
    name character varying(255),
    codespacename bigint,
    description character varying(255),
    disabled character(1) DEFAULT 'F'::bpchar NOT NULL,
    CONSTRAINT offering_disabled_check CHECK ((disabled = ANY (ARRAY['T'::bpchar, 'F'::bpchar])))
);
COMMENT ON TABLE offering IS 'Table to store the offering information. Mapping file: mapping/core/Offering.hbm.xml';
COMMENT ON COLUMN offering.offeringid IS 'Table primary key, used for relations';
COMMENT ON COLUMN offering.identifier IS 'The identifier of the offering, gml:identifier. Used as parameter for queries. Unique';
COMMENT ON COLUMN offering.codespace IS 'Relation/foreign key to the codespace table. Contains the gml:identifier codespace. Optional';
COMMENT ON COLUMN offering.name IS 'The name of the offering, gml:name. If available, displyed in the contents of the Capabilites. Optional';
COMMENT ON COLUMN offering.codespacename IS 'Relation/foreign key to the codespace table. Contains the gml:name codespace. Optional';
COMMENT ON COLUMN offering.description IS 'Description of the offering, gml:description. Optional';
COMMENT ON COLUMN offering.disabled IS 'For later use by the SOS. Indicator if this offering should not be provided by the SOS.';
CREATE TABLE offeringallowedfeaturetype (
    offeringid bigint NOT NULL,
    featureofinteresttypeid bigint NOT NULL
);
COMMENT ON TABLE offeringallowedfeaturetype IS 'Table to store relations between offering and allowed featureOfInterestTypes, defined in InsertSensor request. Mapping file: mapping/transactional/TOffering.hbm.xml';
COMMENT ON COLUMN offeringallowedfeaturetype.offeringid IS 'Foreign Key (FK) to the related offering. Contains "offering".offeringid';
COMMENT ON COLUMN offeringallowedfeaturetype.featureofinteresttypeid IS 'Foreign Key (FK) to the related featureOfInterestTypeId. Contains "featureOfInterestType".featureOfInterestTypeId';
CREATE TABLE offeringallowedobservationtype (
    offeringid bigint NOT NULL,
    observationtypeid bigint NOT NULL
);
COMMENT ON TABLE offeringallowedobservationtype IS 'Table to store relations between offering and allowed observationTypes, defined in InsertSensor request. Mapping file: mapping/transactional/TOffering.hbm.xml';
COMMENT ON COLUMN offeringallowedobservationtype.offeringid IS 'Foreign Key (FK) to the related offering. Contains "offering".offeringid';
COMMENT ON COLUMN offeringallowedobservationtype.observationtypeid IS 'Foreign Key (FK) to the related observationType. Contains "observationType".observationTypeId';
CREATE TABLE offeringhasrelatedfeature (
    relatedfeatureid bigint NOT NULL,
    offeringid bigint NOT NULL
);
COMMENT ON TABLE offeringhasrelatedfeature IS 'Table to store relations between offering and associated relatedFeatures. Mapping file: mapping/transactional/TOffering.hbm.xml';
COMMENT ON COLUMN offeringhasrelatedfeature.relatedfeatureid IS 'Foreign Key (FK) to the related relatedFeature. Contains "relatedFeature".relatedFeatureid';
COMMENT ON COLUMN offeringhasrelatedfeature.offeringid IS 'Foreign Key (FK) to the related offering. Contains "offering".offeringid';
CREATE TABLE offeringrelation (
    parentofferingid bigint NOT NULL,
    childofferingid bigint NOT NULL
);
COMMENT ON TABLE offeringrelation IS 'Relation table to store offering hierarchies. E.g. define a parent in a query and all childs are also contained in the response. Mapping file: mapping/core/Offering.hbm.xml';
COMMENT ON COLUMN offeringrelation.parentofferingid IS 'Foreign Key (FK) to the related parent offering. Contains "offering".offeringid';
COMMENT ON COLUMN offeringrelation.childofferingid IS 'Foreign Key (FK) to the related child offering. Contains "offering".offeringid';
CREATE TABLE parameter (
    parameterid bigint NOT NULL,
    observationid bigint NOT NULL,
    name character varying(255) NOT NULL
);
COMMENT ON TABLE parameter IS 'Table to store additional obervation information (om:parameter). Mapping file: mapping/core/Parameter.hbm.xml';
COMMENT ON COLUMN parameter.parameterid IS 'Table primary key';
COMMENT ON COLUMN parameter.observationid IS 'Foreign Key (FK) to the related observation. Contains "observation".observationId';
COMMENT ON COLUMN parameter.name IS 'Parameter name';
CREATE TABLE procedure (
    procedureid bigint NOT NULL,
    hibernatediscriminator character(1) NOT NULL,
    proceduredescriptionformatid bigint NOT NULL,
    identifier character varying(255) NOT NULL,
    codespace bigint,
    name character varying(255),
    codespacename bigint,
    description character varying(255),
    deleted character(1) DEFAULT 'F'::bpchar NOT NULL,
    disabled character(1) DEFAULT 'F'::bpchar NOT NULL,
    descriptionfile text,
    referenceflag character(1) DEFAULT 'F'::bpchar,
    typeof bigint,
    istype character(1) DEFAULT 'F'::bpchar,
    isaggregation character(1) DEFAULT 'T'::bpchar,
    mobile character(1) DEFAULT 'F'::bpchar,
    insitu character(1) DEFAULT 'T'::bpchar,
    CONSTRAINT procedure_deleted_check CHECK ((deleted = ANY (ARRAY['T'::bpchar, 'F'::bpchar]))),
    CONSTRAINT procedure_disabled_check CHECK ((disabled = ANY (ARRAY['T'::bpchar, 'F'::bpchar]))),
    CONSTRAINT procedure_insitu_check CHECK ((insitu = ANY (ARRAY['T'::bpchar, 'F'::bpchar]))),
    CONSTRAINT procedure_isaggregation_check CHECK ((isaggregation = ANY (ARRAY['T'::bpchar, 'F'::bpchar]))),
    CONSTRAINT procedure_istype_check CHECK ((istype = ANY (ARRAY['T'::bpchar, 'F'::bpchar]))),
    CONSTRAINT procedure_mobile_check CHECK ((mobile = ANY (ARRAY['T'::bpchar, 'F'::bpchar]))),
    CONSTRAINT procedure_referenceflag_check CHECK ((referenceflag = ANY (ARRAY['T'::bpchar, 'F'::bpchar])))
);
COMMENT ON TABLE procedure IS 'Table to store the procedure/sensor. Mapping file: mapping/core/Procedure.hbm.xml';
COMMENT ON COLUMN procedure.procedureid IS 'Table primary key, used for relations';
COMMENT ON COLUMN procedure.proceduredescriptionformatid IS 'Relation/foreign key to the procedureDescriptionFormat table. Describes the format of the procedure description.';
COMMENT ON COLUMN procedure.identifier IS 'The identifier of the procedure, gml:identifier. Used as parameter for queries. Unique';
COMMENT ON COLUMN procedure.codespace IS 'Relation/foreign key to the codespace table. Contains the gml:identifier codespace. Optional';
COMMENT ON COLUMN procedure.name IS 'The name of the procedure, gml:name. Optional';
COMMENT ON COLUMN procedure.codespacename IS 'Relation/foreign key to the codespace table. Contains the gml:name codespace. Optional';
COMMENT ON COLUMN procedure.description IS 'Description of the procedure, gml:description. Optional';
COMMENT ON COLUMN procedure.deleted IS 'Flag to indicate that this procedure is deleted or not (OGC SWES 2.0 - DeleteSensor operation)';
COMMENT ON COLUMN procedure.disabled IS 'For later use by the SOS. Indicator if this procedure should not be provided by the SOS.';
COMMENT ON COLUMN procedure.descriptionfile IS 'Field for full (XML) encoded procedure description or link to a procedure description file. Optional';
COMMENT ON COLUMN procedure.referenceflag IS 'Flag to indicate that this procedure is a reference procedure of another procedure. Not used by the SOS but by the Sensor Web REST-API';
COMMENT ON COLUMN procedure.typeof IS 'Relation/foreign key to procedure table. Optional, contains procedureId if this procedure is typeOf another procedure';
COMMENT ON COLUMN procedure.istype IS 'Flag to indicate that this procedure is a type description, has no observations.';
COMMENT ON COLUMN procedure.isaggregation IS 'Flag to indicate that this procedure is an aggregation (e.g. System, PhysicalSystem).';
COMMENT ON COLUMN procedure.mobile IS 'Flag to indicate that this procedure is stationary (false) or mobile (true). Optional';
COMMENT ON COLUMN procedure.insitu IS 'Flag to indicate that this procedure is insitu (true) or remote (false). Optional';
CREATE TABLE proceduredescriptionformat (
    proceduredescriptionformatid bigint NOT NULL,
    proceduredescriptionformat character varying(255) NOT NULL
);
COMMENT ON TABLE proceduredescriptionformat IS 'Table to store the ProcedureDescriptionFormat information of procedures. Mapping file: mapping/core/ProcedureDescriptionFormat.hbm.xml';
COMMENT ON COLUMN proceduredescriptionformat.proceduredescriptionformatid IS 'Table primary key, used for relations';
COMMENT ON COLUMN proceduredescriptionformat.proceduredescriptionformat IS 'The procedureDescriptionFormat value, e.g. http://www.opengis.net/sensorML/1.0.1 for procedures descriptions as specified in OGC SensorML 1.0.1';
CREATE TABLE profileobservation (
    observationid bigint NOT NULL,
    childobservationid bigint NOT NULL
);
COMMENT ON TABLE profileobservation IS 'Relation table for complex parent/child observations';
COMMENT ON COLUMN profileobservation.observationid IS 'Foreign Key (FK) to the related parent complex observation. Contains "observation".observationid';
COMMENT ON COLUMN profileobservation.childobservationid IS 'Foreign Key (FK) to the related child complex observation. Contains "observation".observationid';
CREATE TABLE profilevalue (
    observationid bigint NOT NULL,
    fromlevel double precision,
    tolevel double precision,
    levelunitid bigint
);
COMMENT ON TABLE profilevalue IS 'Value table for profile observation';
COMMENT ON COLUMN profilevalue.observationid IS 'Foreign Key (FK) to the related observation from the observation table. Contains "observation".observationid';
COMMENT ON COLUMN profilevalue.fromlevel IS 'Value of fromLevel';
COMMENT ON COLUMN profilevalue.tolevel IS 'Value of toLevel';
COMMENT ON COLUMN profilevalue.levelunitid IS 'Foreign Key (FK) to the related unit of measure. Contains "unit".unitid. Optional';
CREATE TABLE referencevalue (
    observationid bigint NOT NULL,
    href character varying(255),
    title character varying(255),
    role character varying(255)
);
COMMENT ON TABLE referencevalue IS 'Value table for category observation';
COMMENT ON COLUMN referencevalue.observationid IS 'Foreign Key (FK) to the related observation from the observation table. Contains "observation".observationid';
COMMENT ON COLUMN referencevalue.href IS 'href value';
COMMENT ON COLUMN referencevalue.title IS 'title value';
COMMENT ON COLUMN referencevalue.role IS 'role value';
CREATE TABLE relatedfeature (
    relatedfeatureid bigint NOT NULL,
    featureofinterestid bigint NOT NULL
);
COMMENT ON TABLE relatedfeature IS 'Table to store related feature information used in the OGC SOS 2.0 Capabilities (See also OGC SWES 2.0). Mapping file: mapping/transactionl/RelatedFeature.hbm.xml';
COMMENT ON COLUMN relatedfeature.relatedfeatureid IS 'Table primary key, used for relations';
COMMENT ON COLUMN relatedfeature.featureofinterestid IS 'Foreign Key (FK) to the related featureOfInterest. Contains "featureOfInterest".featureOfInterestid';
CREATE TABLE relatedfeaturehasrole (
    relatedfeatureid bigint NOT NULL,
    relatedfeatureroleid bigint NOT NULL
);
COMMENT ON TABLE relatedfeaturehasrole IS 'Relation table to store relatedFeatures and their associated relatedFeatureRoles. Mapping file: mapping/transactionl/RelatedFeature.hbm.xml';
COMMENT ON COLUMN relatedfeaturehasrole.relatedfeatureid IS 'Foreign Key (FK) to the related relatedFeature. Contains "relatedFeature".relatedFeatureid';
COMMENT ON COLUMN relatedfeaturehasrole.relatedfeatureroleid IS 'Foreign Key (FK) to the related relatedFeatureRole. Contains "relatedFeatureRole".relatedFeatureRoleid';
CREATE TABLE relatedfeaturerole (
    relatedfeatureroleid bigint NOT NULL,
    relatedfeaturerole character varying(255) NOT NULL
);
COMMENT ON TABLE relatedfeaturerole IS 'Table to store related feature role information used in the OGC SOS 2.0 Capabilities (See also OGC SWES 2.0). Mapping file: mapping/transactionl/RelatedFeatureRole.hbm.xml';
COMMENT ON COLUMN relatedfeaturerole.relatedfeatureroleid IS 'Table primary key, used for relations';
COMMENT ON COLUMN relatedfeaturerole.relatedfeaturerole IS 'The related feature role definition. See OGC SWES 2.0 specification';
CREATE TABLE relatedobservation (
    relatedobservationid bigint NOT NULL,
    observationid bigint,
    relatedobservation bigint,
    role character varying(255),
    relatedurl character varying(255)
);
COMMENT ON TABLE relatedobservation IS 'The related observation of an observation.';
COMMENT ON COLUMN relatedobservation.relatedobservationid IS 'Table primary key';
COMMENT ON COLUMN relatedobservation.observationid IS 'Foreign Key (FK) to the observation. Contains "observation".observationId';
COMMENT ON COLUMN relatedobservation.relatedobservation IS 'Relation/foreign key to the associated observation table. Contains "observation".observationId';
COMMENT ON COLUMN relatedobservation.role IS 'The role of the relation';
COMMENT ON COLUMN relatedobservation.relatedurl IS 'An url to a related observation';
CREATE TABLE resulttemplate (
    resulttemplateid bigint NOT NULL,
    offeringid bigint NOT NULL,
    observablepropertyid bigint NOT NULL,
    procedureid bigint,
    featureofinterestid bigint,
    identifier character varying(255) NOT NULL,
    resultstructure text NOT NULL,
    resultencoding text NOT NULL
);
COMMENT ON TABLE resulttemplate IS 'Table to store resultTemplates (OGC SOS 2.0 result handling profile). Mapping file: mapping/transactionl/ResultTemplate.hbm.xml';
COMMENT ON COLUMN resulttemplate.resulttemplateid IS 'Table primary key';
COMMENT ON COLUMN resulttemplate.offeringid IS 'Foreign Key (FK) to the related offering. Contains "offering".offeringid';
COMMENT ON COLUMN resulttemplate.observablepropertyid IS 'Foreign Key (FK) to the related observableProperty. Contains "observableProperty".observablePropertyId';
COMMENT ON COLUMN resulttemplate.procedureid IS 'Foreign Key (FK) to the related procedure. Contains "procedure".procedureId';
COMMENT ON COLUMN resulttemplate.featureofinterestid IS 'Foreign Key (FK) to the related featureOfInterest. Contains "featureOfInterest".featureOfInterestid';
COMMENT ON COLUMN resulttemplate.identifier IS 'The resultTemplate identifier, required for InsertResult requests.';
COMMENT ON COLUMN resulttemplate.resultstructure IS 'The resultStructure as XML string. Describes the types and order of the values in a GetResultResponse/InsertResultRequest';
COMMENT ON COLUMN resulttemplate.resultencoding IS 'The resultEncoding as XML string. Describes the encoding of the values in a GetResultResponse/InsertResultRequest';
CREATE TABLE sensorsystem (
    parentsensorid bigint NOT NULL,
    childsensorid bigint NOT NULL
);
COMMENT ON TABLE sensorsystem IS 'Relation table to store procedure hierarchies. E.g. define a parent in a query and all childs are also contained in the response. Mapping file: mapping/transactional/TProcedure.hbm.xml';
COMMENT ON COLUMN sensorsystem.parentsensorid IS 'Foreign Key (FK) to the related parent procedure. Contains "procedure".procedureid';
COMMENT ON COLUMN sensorsystem.childsensorid IS 'Foreign Key (FK) to the related child procedure. Contains "procedure".procedureid';
CREATE TABLE series (
    seriesid bigint NOT NULL,
    featureofinterestid bigint NOT NULL,
    observablepropertyid bigint NOT NULL,
    procedureid bigint NOT NULL,
    offeringid bigint NOT NULL,
    deleted character(1) DEFAULT 'F'::bpchar NOT NULL,
    published character(1) DEFAULT 'T'::bpchar NOT NULL,
    hiddenchild character(1) DEFAULT 'F'::bpchar NOT NULL,
    firsttimestamp timestamp without time zone,
    lasttimestamp timestamp without time zone,
    firstnumericvalue double precision,
    lastnumericvalue double precision,
    unitid bigint,
    identifier character varying(255),
    codespace bigint,
    name character varying(255),
    codespacename bigint,
    description character varying(255),
    seriestype character varying(255),
    CONSTRAINT series_deleted_check CHECK ((deleted = ANY (ARRAY['T'::bpchar, 'F'::bpchar]))),
    CONSTRAINT series_hiddenchild_check CHECK ((hiddenchild = ANY (ARRAY['T'::bpchar, 'F'::bpchar]))),
    CONSTRAINT series_published_check CHECK ((published = ANY (ARRAY['T'::bpchar, 'F'::bpchar])))
);
COMMENT ON TABLE series IS 'Table to store a (time-) series which consists of featureOfInterest, observableProperty, and procedure. Mapping file: mapping/series/Series.hbm.xml';
COMMENT ON COLUMN series.seriesid IS 'Table primary key, used for relations';
COMMENT ON COLUMN series.featureofinterestid IS 'Foreign Key (FK) to the related featureOfInterest. Contains "featureOfInterest".featureOfInterestId';
COMMENT ON COLUMN series.observablepropertyid IS 'Foreign Key (FK) to the related observableProperty. Contains "observableproperty".observablepropertyid';
COMMENT ON COLUMN series.procedureid IS 'Foreign Key (FK) to the related procedure. Contains "procedure".procedureid';
COMMENT ON COLUMN series.offeringid IS 'Foreign Key (FK) to the related offering. Contains "offering".offeringid';
COMMENT ON COLUMN series.deleted IS 'Flag to indicate that this series is deleted or not. Set if the related procedure is deleted via DeleteSensor operation (OGC SWES 2.0 - DeleteSensor operation)';
COMMENT ON COLUMN series.published IS 'Flag to indicate that this series is published or not. A not published series is not contained in GetObservation and GetDataAvailability responses';
COMMENT ON COLUMN series.hiddenchild IS 'TODO';
COMMENT ON COLUMN series.firsttimestamp IS 'The time stamp of the first (temporal) observation associated to this series';
COMMENT ON COLUMN series.lasttimestamp IS 'The time stamp of the last (temporal) observation associated to this series';
COMMENT ON COLUMN series.firstnumericvalue IS 'The value of the first (temporal) observation associated to this series';
COMMENT ON COLUMN series.lastnumericvalue IS 'The value of the last (temporal) observation associated to this series';
COMMENT ON COLUMN series.unitid IS 'Foreign Key (FK) to the related unit of the first/last numeric values . Contains "unit".unitid';
COMMENT ON COLUMN series.identifier IS 'The identifier of the series, gml:identifier. Unique';
COMMENT ON COLUMN series.codespace IS 'Relation/foreign key to the codespace table. Contains the gml:identifier codespace. Optional';
COMMENT ON COLUMN series.name IS 'The name of the series, gml:name. Optional';
COMMENT ON COLUMN series.codespacename IS 'Relation/foreign key to the codespace table. Contains the gml:name codespace. Optional';
COMMENT ON COLUMN series.description IS 'Description of the series, gml:description. Optional';
COMMENT ON COLUMN series.seriestype IS 'Definition of the series type, e.g. measurement for OM_Measurement. Optional';
CREATE TABLE seriesreference (
    seriesid bigint NOT NULL,
    referenceseriesid bigint NOT NULL,
    sortorder integer NOT NULL
);
COMMENT ON COLUMN seriesreference.seriesid IS 'Foreign Key (FK) to link a series with a reference value series. Contains "series".seriesid';
COMMENT ON COLUMN seriesreference.referenceseriesid IS 'Foreign Key (FK) to the linked reference value series. Contains "series".seriesid';
CREATE TABLE swedataarrayvalue (
    observationid bigint NOT NULL,
    value text
);
COMMENT ON TABLE swedataarrayvalue IS 'Value table for SweDataArray observation';
COMMENT ON COLUMN swedataarrayvalue.observationid IS 'Foreign Key (FK) to the related observation from the observation table. Contains "observation".observationid';
COMMENT ON COLUMN swedataarrayvalue.value IS 'SweDataArray observation value';
CREATE TABLE textfeatparamvalue (
    parameterid bigint NOT NULL,
    value character varying(255)
);
COMMENT ON TABLE textfeatparamvalue IS 'Value table for text parameter';
COMMENT ON COLUMN textfeatparamvalue.parameterid IS 'Foreign Key (FK) to the related parameter from the parameter table. Contains "featureParameter".parameterid';
COMMENT ON COLUMN textfeatparamvalue.value IS 'Text parameter value';
CREATE TABLE textparametervalue (
    parameterid bigint NOT NULL,
    value character varying(255)
);
COMMENT ON TABLE textparametervalue IS 'Value table for text parameter';
COMMENT ON COLUMN textparametervalue.parameterid IS 'Foreign Key (FK) to the related parameter from the parameter table. Contains "parameter".parameterid';
COMMENT ON COLUMN textparametervalue.value IS 'Text parameter value';
CREATE TABLE textvalue (
    observationid bigint NOT NULL,
    value text,
    identifier character varying(255),
    name character varying(255),
    description character varying(255)
);
COMMENT ON TABLE textvalue IS 'Value table for text observation';
COMMENT ON COLUMN textvalue.observationid IS 'Foreign Key (FK) to the related observation from the observation table. Contains "observation".observationid';
COMMENT ON COLUMN textvalue.value IS 'Text observation value';
COMMENT ON COLUMN textvalue.identifier IS 'SweText observation identifier';
COMMENT ON COLUMN textvalue.name IS 'SweText observation name';
COMMENT ON COLUMN textvalue.description IS 'SweText observation description';
CREATE TABLE unit (
    unitid bigint NOT NULL,
    unit character varying(255) NOT NULL,
    name character varying(255),
    link character varying(255)
);
COMMENT ON TABLE unit IS 'Table to store the unit of measure information, used in observations. Mapping file: mapping/core/Unit.hbm.xml';
COMMENT ON COLUMN unit.unitid IS 'Table primary key, used for relations';
COMMENT ON COLUMN unit.unit IS 'The unit of measure of observations. See http://unitsofmeasure.org/ucum.html';
COMMENT ON COLUMN unit.name IS 'The name of the unit of measure of observations';
COMMENT ON COLUMN unit.link IS 'The link to an external description of the unit of measure of observations, e.g. a vocabulary';
CREATE TABLE validproceduretime (
    validproceduretimeid bigint NOT NULL,
    procedureid bigint NOT NULL,
    proceduredescriptionformatid bigint NOT NULL,
    starttime timestamp without time zone NOT NULL,
    endtime timestamp without time zone,
    descriptionxml text NOT NULL
);
COMMENT ON TABLE validproceduretime IS 'Table to store procedure descriptions which were inserted or updated via the transactional Profile. Mapping file: mapping/transactionl/ValidProcedureTime.hbm.xml';
COMMENT ON COLUMN validproceduretime.validproceduretimeid IS 'Table primary key';
COMMENT ON COLUMN validproceduretime.procedureid IS 'Foreign Key (FK) to the related procedure. Contains "procedure".procedureid';
COMMENT ON COLUMN validproceduretime.proceduredescriptionformatid IS 'Foreign Key (FK) to the related procedureDescriptionFormat. Contains "procedureDescriptionFormat".procedureDescriptionFormatid';
COMMENT ON COLUMN validproceduretime.starttime IS 'Timestamp since this procedure description is valid';
COMMENT ON COLUMN validproceduretime.endtime IS 'Timestamp until this procedure description is invalid';
COMMENT ON COLUMN validproceduretime.descriptionxml IS 'Procedure description as XML string';
CREATE TABLE xmlfeatparamvalue (
    parameterid bigint NOT NULL,
    value text
);
COMMENT ON TABLE xmlfeatparamvalue IS 'Value table for XML parameter';
COMMENT ON COLUMN xmlfeatparamvalue.parameterid IS 'Foreign Key (FK) to the related parameter from the parameter table. Contains "featureParameter".parameterid';
COMMENT ON COLUMN xmlfeatparamvalue.value IS 'XML parameter value';
CREATE TABLE xmlparametervalue (
    parameterid bigint NOT NULL,
    value text
);
COMMENT ON TABLE xmlparametervalue IS 'Value table for XML parameter';
COMMENT ON COLUMN xmlparametervalue.parameterid IS 'Foreign Key (FK) to the related parameter from the parameter table. Contains "parameter".parameterid';
COMMENT ON COLUMN xmlparametervalue.value IS 'XML parameter value';
ALTER TABLE ONLY blobvalue
    ADD CONSTRAINT blobvalue_pkey PRIMARY KEY (observationid);
ALTER TABLE ONLY booleanfeatparamvalue
    ADD CONSTRAINT booleanfeatparamvalue_pkey PRIMARY KEY (parameterid);
ALTER TABLE ONLY booleanparametervalue
    ADD CONSTRAINT booleanparametervalue_pkey PRIMARY KEY (parameterid);
ALTER TABLE ONLY booleanvalue
    ADD CONSTRAINT booleanvalue_pkey PRIMARY KEY (observationid);
ALTER TABLE ONLY categoryfeatparamvalue
    ADD CONSTRAINT categoryfeatparamvalue_pkey PRIMARY KEY (parameterid);
ALTER TABLE ONLY categoryparametervalue
    ADD CONSTRAINT categoryparametervalue_pkey PRIMARY KEY (parameterid);
ALTER TABLE ONLY categoryvalue
    ADD CONSTRAINT categoryvalue_pkey PRIMARY KEY (observationid);
ALTER TABLE ONLY codespace
    ADD CONSTRAINT codespace_pkey PRIMARY KEY (codespaceid);
ALTER TABLE ONLY codespace
    ADD CONSTRAINT codespaceuk UNIQUE (codespace);
ALTER TABLE ONLY complexvalue
    ADD CONSTRAINT complexvalue_pkey PRIMARY KEY (observationid);
ALTER TABLE ONLY compositeobservation
    ADD CONSTRAINT compositeobservation_pkey PRIMARY KEY (observationid, childobservationid);
ALTER TABLE ONLY compositephenomenon
    ADD CONSTRAINT compositephenomenon_pkey PRIMARY KEY (childobservablepropertyid, parentobservablepropertyid);
ALTER TABLE ONLY countfeatparamvalue
    ADD CONSTRAINT countfeatparamvalue_pkey PRIMARY KEY (parameterid);
ALTER TABLE ONLY countparametervalue
    ADD CONSTRAINT countparametervalue_pkey PRIMARY KEY (parameterid);
ALTER TABLE ONLY countvalue
    ADD CONSTRAINT countvalue_pkey PRIMARY KEY (observationid);
ALTER TABLE ONLY featureofinterest
    ADD CONSTRAINT featureofinterest_pkey PRIMARY KEY (featureofinterestid);
ALTER TABLE ONLY featureofinteresttype
    ADD CONSTRAINT featureofinteresttype_pkey PRIMARY KEY (featureofinteresttypeid);
ALTER TABLE ONLY featureparameter
    ADD CONSTRAINT featureparameter_pkey PRIMARY KEY (parameterid);
ALTER TABLE ONLY featurerelation
    ADD CONSTRAINT featurerelation_pkey PRIMARY KEY (childfeatureid, parentfeatureid);
ALTER TABLE ONLY featureofinteresttype
    ADD CONSTRAINT featuretypeuk UNIQUE (featureofinteresttype);
ALTER TABLE ONLY featureofinterest
    ADD CONSTRAINT featureurl UNIQUE (url);
ALTER TABLE ONLY featureofinterest
    ADD CONSTRAINT foiidentifieruk UNIQUE (identifier);
ALTER TABLE ONLY geometryvalue
    ADD CONSTRAINT geometryvalue_pkey PRIMARY KEY (observationid);
ALTER TABLE ONLY numericfeatparamvalue
    ADD CONSTRAINT numericfeatparamvalue_pkey PRIMARY KEY (parameterid);
ALTER TABLE ONLY numericparametervalue
    ADD CONSTRAINT numericparametervalue_pkey PRIMARY KEY (parameterid);
ALTER TABLE ONLY numericvalue
    ADD CONSTRAINT numericvalue_pkey PRIMARY KEY (observationid);
ALTER TABLE ONLY observableproperty
    ADD CONSTRAINT observableproperty_pkey PRIMARY KEY (observablepropertyid);
ALTER TABLE ONLY observation
    ADD CONSTRAINT observation_pkey PRIMARY KEY (observationid);
ALTER TABLE ONLY observationconstellation
    ADD CONSTRAINT observationconstellation_pkey PRIMARY KEY (observationconstellationid);
ALTER TABLE ONLY observationhasoffering
    ADD CONSTRAINT observationhasoffering_pkey PRIMARY KEY (observationid, offeringid);
ALTER TABLE ONLY observationtype
    ADD CONSTRAINT observationtype_pkey PRIMARY KEY (observationtypeid);
ALTER TABLE ONLY observationtype
    ADD CONSTRAINT observationtypeuk UNIQUE (observationtype);
ALTER TABLE ONLY observationconstellation
    ADD CONSTRAINT obsnconstellationidentity UNIQUE (observablepropertyid, procedureid, offeringid);
ALTER TABLE ONLY observableproperty
    ADD CONSTRAINT obspropidentifieruk UNIQUE (identifier);
ALTER TABLE ONLY offering
    ADD CONSTRAINT offering_pkey PRIMARY KEY (offeringid);
ALTER TABLE ONLY offeringallowedfeaturetype
    ADD CONSTRAINT offeringallowedfeaturetype_pkey PRIMARY KEY (offeringid, featureofinteresttypeid);
ALTER TABLE ONLY offeringallowedobservationtype
    ADD CONSTRAINT offeringallowedobservationtype_pkey PRIMARY KEY (offeringid, observationtypeid);
ALTER TABLE ONLY offeringhasrelatedfeature
    ADD CONSTRAINT offeringhasrelatedfeature_pkey PRIMARY KEY (offeringid, relatedfeatureid);
ALTER TABLE ONLY offeringrelation
    ADD CONSTRAINT offeringrelation_pkey PRIMARY KEY (childofferingid, parentofferingid);
ALTER TABLE ONLY offering
    ADD CONSTRAINT offidentifieruk UNIQUE (identifier);
ALTER TABLE ONLY parameter
    ADD CONSTRAINT parameter_pkey PRIMARY KEY (parameterid);
ALTER TABLE ONLY proceduredescriptionformat
    ADD CONSTRAINT procdescformatuk UNIQUE (proceduredescriptionformat);
ALTER TABLE ONLY procedure
    ADD CONSTRAINT procedure_pkey PRIMARY KEY (procedureid);
ALTER TABLE ONLY proceduredescriptionformat
    ADD CONSTRAINT proceduredescriptionformat_pkey PRIMARY KEY (proceduredescriptionformatid);
ALTER TABLE ONLY procedure
    ADD CONSTRAINT procidentifieruk UNIQUE (identifier);
ALTER TABLE ONLY profileobservation
    ADD CONSTRAINT profileobservation_pkey PRIMARY KEY (observationid, childobservationid);
ALTER TABLE ONLY profilevalue
    ADD CONSTRAINT profilevalue_pkey PRIMARY KEY (observationid);
ALTER TABLE ONLY referencevalue
    ADD CONSTRAINT referencevalue_pkey PRIMARY KEY (observationid);
ALTER TABLE ONLY relatedfeature
    ADD CONSTRAINT relatedfeature_pkey PRIMARY KEY (relatedfeatureid);
ALTER TABLE ONLY relatedfeaturehasrole
    ADD CONSTRAINT relatedfeaturehasrole_pkey PRIMARY KEY (relatedfeatureid, relatedfeatureroleid);
ALTER TABLE ONLY relatedfeaturerole
    ADD CONSTRAINT relatedfeaturerole_pkey PRIMARY KEY (relatedfeatureroleid);
ALTER TABLE ONLY relatedobservation
    ADD CONSTRAINT relatedobservation_pkey PRIMARY KEY (relatedobservationid);
ALTER TABLE ONLY relatedfeaturerole
    ADD CONSTRAINT relfeatroleuk UNIQUE (relatedfeaturerole);
ALTER TABLE ONLY resulttemplate
    ADD CONSTRAINT resulttemplate_pkey PRIMARY KEY (resulttemplateid);
ALTER TABLE ONLY sensorsystem
    ADD CONSTRAINT sensorsystem_pkey PRIMARY KEY (childsensorid, parentsensorid);
ALTER TABLE ONLY series
    ADD CONSTRAINT series_pkey PRIMARY KEY (seriesid);
ALTER TABLE ONLY series
    ADD CONSTRAINT seriesidentifieruk UNIQUE (identifier);
ALTER TABLE ONLY series
    ADD CONSTRAINT seriesidentity UNIQUE (featureofinterestid, observablepropertyid, procedureid, offeringid);
ALTER TABLE ONLY seriesreference
    ADD CONSTRAINT seriesreference_pkey PRIMARY KEY (seriesid, sortorder);
ALTER TABLE ONLY swedataarrayvalue
    ADD CONSTRAINT swedataarrayvalue_pkey PRIMARY KEY (observationid);
ALTER TABLE ONLY textfeatparamvalue
    ADD CONSTRAINT textfeatparamvalue_pkey PRIMARY KEY (parameterid);
ALTER TABLE ONLY textparametervalue
    ADD CONSTRAINT textparametervalue_pkey PRIMARY KEY (parameterid);
ALTER TABLE ONLY textvalue
    ADD CONSTRAINT textvalue_pkey PRIMARY KEY (observationid);
ALTER TABLE ONLY unit
    ADD CONSTRAINT unit_pkey PRIMARY KEY (unitid);
ALTER TABLE ONLY unit
    ADD CONSTRAINT unituk UNIQUE (unit);
ALTER TABLE ONLY validproceduretime
    ADD CONSTRAINT validproceduretime_pkey PRIMARY KEY (validproceduretimeid);
ALTER TABLE ONLY xmlfeatparamvalue
    ADD CONSTRAINT xmlfeatparamvalue_pkey PRIMARY KEY (parameterid);
ALTER TABLE ONLY xmlparametervalue
    ADD CONSTRAINT xmlparametervalue_pkey PRIMARY KEY (parameterid);
CREATE INDEX blobvalueidx ON blobvalue USING btree (value);
CREATE INDEX blobvalueobsididx ON blobvalue USING btree (observationid);
CREATE INDEX booleanfeatparamidx ON booleanfeatparamvalue USING btree (value);
CREATE INDEX booleanparamididx ON booleanparametervalue USING btree (parameterid);
CREATE INDEX booleanparamidx ON booleanparametervalue USING btree (value);
CREATE INDEX booleanvalueidx ON booleanvalue USING btree (value);
CREATE INDEX booleanvalueobsididx ON booleanvalue USING btree (observationid);
CREATE INDEX categoryfeatparamidx ON categoryfeatparamvalue USING btree (value);
CREATE INDEX categoryparamididx ON categoryparametervalue USING btree (parameterid);
CREATE INDEX categoryparamidx ON categoryparametervalue USING btree (value);
CREATE INDEX categoryvalueidx ON categoryvalue USING btree (value);
CREATE INDEX categoryvalueobsididx ON categoryvalue USING btree (observationid);
CREATE INDEX complexchildobsididx ON compositeobservation USING btree (childobservationid);
CREATE INDEX complexobsididx ON compositeobservation USING btree (observationid);
CREATE INDEX complexvalueobsididx ON complexvalue USING btree (observationid);
CREATE INDEX countfeatparamidx ON countfeatparamvalue USING btree (value);
CREATE INDEX countparamididx ON countparametervalue USING btree (parameterid);
CREATE INDEX countparamidx ON countparametervalue USING btree (value);
CREATE INDEX countvalueidx ON countvalue USING btree (value);
CREATE INDEX countvalueobsididx ON countvalue USING btree (observationid);
CREATE INDEX featparamnameidx ON featureparameter USING btree (name);
CREATE INDEX featuregeomidx ON featureofinterest USING gist (geom);
CREATE INDEX geometryvalueidx ON geometryvalue USING gist (value);
CREATE INDEX geometryvalueobsididx ON geometryvalue USING btree (observationid);
CREATE INDEX numericparamididx ON numericparametervalue USING btree (parameterid);
CREATE INDEX numericvalueidx ON numericvalue USING btree (value);
CREATE INDEX numericvalueobsididx ON numericvalue USING btree (observationid);
CREATE INDEX obsconstobspropidx ON observationconstellation USING btree (observablepropertyid);
CREATE INDEX obsconstofferingidx ON observationconstellation USING btree (offeringid);
CREATE INDEX obsconstprocedureidx ON observationconstellation USING btree (procedureid);
CREATE INDEX obshasoffobservationidx ON observationhasoffering USING btree (observationid);
CREATE INDEX obshasoffofferingidx ON observationhasoffering USING btree (offeringid);
CREATE INDEX obsphentimeendidx ON observation USING btree (phenomenontimeend);
CREATE INDEX obsphentimestartidx ON observation USING btree (phenomenontimestart);
CREATE INDEX obsresulttimeidx ON observation USING btree (resulttime);
CREATE INDEX obsseriesidx ON observation USING btree (seriesid);
CREATE INDEX paramnameidx ON parameter USING btree (name);
CREATE INDEX profileobsididx ON profileobservation USING btree (observationid, childobservationid);
CREATE INDEX profvalueobsididx ON profilevalue USING btree (observationid);
CREATE INDEX quantityfeatparamidx ON numericfeatparamvalue USING btree (value);
CREATE INDEX quantityparamidx ON numericparametervalue USING btree (value);
CREATE INDEX referenceseriesididx ON seriesreference USING btree (referenceseriesid);
CREATE INDEX referencevalueobsididx ON referencevalue USING btree (observationid);
CREATE INDEX relatedobsobsidx ON relatedobservation USING btree (observationid);
CREATE INDEX relobsobsididx ON relatedobservation USING btree (observationid);
CREATE INDEX relobsrelobsididx ON relatedobservation USING btree (relatedobservation);
CREATE INDEX resulttempeobspropidx ON resulttemplate USING btree (observablepropertyid);
CREATE INDEX resulttempidentifieridx ON resulttemplate USING btree (identifier);
CREATE INDEX resulttempofferingidx ON resulttemplate USING btree (offeringid);
CREATE INDEX resulttempprocedureidx ON resulttemplate USING btree (procedureid);
CREATE INDEX samplinggeomidx ON observation USING gist (samplinggeometry);
CREATE INDEX seriesfeatureidx ON series USING btree (featureofinterestid);
CREATE INDEX seriesididx ON seriesreference USING btree (seriesid);
CREATE INDEX seriesobspropidx ON series USING btree (observablepropertyid);
CREATE INDEX seriesofferingidx ON series USING btree (offeringid);
CREATE INDEX seriesprocedureidx ON series USING btree (procedureid);
CREATE INDEX swedataarryvalueobsididx ON swedataarrayvalue USING btree (observationid);
CREATE INDEX textfeatparamidx ON textfeatparamvalue USING btree (value);
CREATE INDEX textparamididx ON textparametervalue USING btree (parameterid);
CREATE INDEX textparamidx ON textparametervalue USING btree (value);
CREATE INDEX textvalueidx ON textvalue USING btree (value);
CREATE INDEX textvalueobsididx ON textvalue USING btree (observationid);
CREATE INDEX validproceduretimeendtimeidx ON validproceduretime USING btree (endtime);
CREATE INDEX validproceduretimestarttimeidx ON validproceduretime USING btree (starttime);
CREATE INDEX xmlparamididx ON xmlparametervalue USING btree (parameterid);
ALTER TABLE ONLY categoryfeatparamvalue
    ADD CONSTRAINT catfeatparamvalueunitfk FOREIGN KEY (unitid) REFERENCES unit(unitid);
ALTER TABLE ONLY categoryparametervalue
    ADD CONSTRAINT catparamvalueunitfk FOREIGN KEY (unitid) REFERENCES unit(unitid);
ALTER TABLE ONLY booleanfeatparamvalue
    ADD CONSTRAINT featparambooleanvaluefk FOREIGN KEY (parameterid) REFERENCES featureparameter(parameterid);
ALTER TABLE ONLY categoryfeatparamvalue
    ADD CONSTRAINT featparamcategoryvaluefk FOREIGN KEY (parameterid) REFERENCES featureparameter(parameterid);
ALTER TABLE ONLY countfeatparamvalue
    ADD CONSTRAINT featparamcountvaluefk FOREIGN KEY (parameterid) REFERENCES featureparameter(parameterid);
ALTER TABLE ONLY numericfeatparamvalue
    ADD CONSTRAINT featparamnumericvaluefk FOREIGN KEY (parameterid) REFERENCES featureparameter(parameterid);
ALTER TABLE ONLY textfeatparamvalue
    ADD CONSTRAINT featparamtextvaluefk FOREIGN KEY (parameterid) REFERENCES featureparameter(parameterid);
ALTER TABLE ONLY xmlfeatparamvalue
    ADD CONSTRAINT featparamxmlvaluefk FOREIGN KEY (parameterid) REFERENCES featureparameter(parameterid);
ALTER TABLE ONLY featureofinterest
    ADD CONSTRAINT featurecodespaceidentifierfk FOREIGN KEY (codespace) REFERENCES codespace(codespaceid);
ALTER TABLE ONLY featureofinterest
    ADD CONSTRAINT featurecodespacenamefk FOREIGN KEY (codespacename) REFERENCES codespace(codespaceid);
ALTER TABLE ONLY featureofinterest
    ADD CONSTRAINT featurefeaturetypefk FOREIGN KEY (featureofinteresttypeid) REFERENCES featureofinteresttype(featureofinteresttypeid);
ALTER TABLE ONLY featurerelation
    ADD CONSTRAINT featureofinterestchildfk FOREIGN KEY (childfeatureid) REFERENCES featureofinterest(featureofinterestid);
ALTER TABLE ONLY featurerelation
    ADD CONSTRAINT featureofinterestparentfk FOREIGN KEY (parentfeatureid) REFERENCES featureofinterest(featureofinterestid);
ALTER TABLE ONLY parameter
    ADD CONSTRAINT fk_3v5iovcndi9w0hgh827hcvivw FOREIGN KEY (observationid) REFERENCES observation(observationid);
ALTER TABLE ONLY featureparameter
    ADD CONSTRAINT fk_4ps6yv41rwnbu3q0let2v7772 FOREIGN KEY (featureofinterestid) REFERENCES featureofinterest(featureofinterestid);
ALTER TABLE ONLY relatedfeaturehasrole
    ADD CONSTRAINT fk_5fd921q6mnbkc57mgm5g4uyyn FOREIGN KEY (relatedfeatureid) REFERENCES relatedfeature(relatedfeatureid);
ALTER TABLE ONLY offeringallowedfeaturetype
    ADD CONSTRAINT fk_cu8nfsf9q5vsn070o2d3u6chg FOREIGN KEY (offeringid) REFERENCES offering(offeringid);
ALTER TABLE ONLY relatedobservation
    ADD CONSTRAINT fk_g0f0mpuxn3co65uwud4pwxh4q FOREIGN KEY (observationid) REFERENCES observation(observationid);
ALTER TABLE ONLY offeringallowedobservationtype
    ADD CONSTRAINT fk_jehw0637hllvta9ao1tqdhrtm FOREIGN KEY (offeringid) REFERENCES offering(offeringid);
ALTER TABLE ONLY relatedobservation
    ADD CONSTRAINT fk_m4nuof4x6w253biuu1r6ttnqc FOREIGN KEY (relatedobservation) REFERENCES observation(observationid);
ALTER TABLE ONLY observationhasoffering
    ADD CONSTRAINT fk_s19siow5aetbwb8ppww4kb96n FOREIGN KEY (observationid) REFERENCES observation(observationid);
ALTER TABLE ONLY observation
    ADD CONSTRAINT obscodespaceidentifierfk FOREIGN KEY (codespace) REFERENCES codespace(codespaceid);
ALTER TABLE ONLY observation
    ADD CONSTRAINT obscodespacenamefk FOREIGN KEY (codespacename) REFERENCES codespace(codespaceid);
ALTER TABLE ONLY observationconstellation
    ADD CONSTRAINT obsconstobservationiypefk FOREIGN KEY (observationtypeid) REFERENCES observationtype(observationtypeid);
ALTER TABLE ONLY observationconstellation
    ADD CONSTRAINT obsconstobspropfk FOREIGN KEY (observablepropertyid) REFERENCES observableproperty(observablepropertyid);
ALTER TABLE ONLY observationconstellation
    ADD CONSTRAINT obsconstofferingfk FOREIGN KEY (offeringid) REFERENCES offering(offeringid);
ALTER TABLE ONLY compositephenomenon
    ADD CONSTRAINT observablepropertychildfk FOREIGN KEY (childobservablepropertyid) REFERENCES observableproperty(observablepropertyid);
ALTER TABLE ONLY compositephenomenon
    ADD CONSTRAINT observablepropertyparentfk FOREIGN KEY (parentobservablepropertyid) REFERENCES observableproperty(observablepropertyid);
ALTER TABLE ONLY blobvalue
    ADD CONSTRAINT observationblobvaluefk FOREIGN KEY (observationid) REFERENCES observation(observationid);
ALTER TABLE ONLY booleanvalue
    ADD CONSTRAINT observationbooleanvaluefk FOREIGN KEY (observationid) REFERENCES observation(observationid);
ALTER TABLE ONLY categoryvalue
    ADD CONSTRAINT observationcategoryvaluefk FOREIGN KEY (observationid) REFERENCES observation(observationid);
ALTER TABLE ONLY compositeobservation
    ADD CONSTRAINT observationchildfk FOREIGN KEY (childobservationid) REFERENCES observation(observationid);
ALTER TABLE ONLY complexvalue
    ADD CONSTRAINT observationcomplexvaluefk FOREIGN KEY (observationid) REFERENCES observation(observationid);
ALTER TABLE ONLY countvalue
    ADD CONSTRAINT observationcountvaluefk FOREIGN KEY (observationid) REFERENCES observation(observationid);
ALTER TABLE ONLY geometryvalue
    ADD CONSTRAINT observationgeometryvaluefk FOREIGN KEY (observationid) REFERENCES observation(observationid);
ALTER TABLE ONLY numericvalue
    ADD CONSTRAINT observationnumericvaluefk FOREIGN KEY (observationid) REFERENCES observation(observationid);
ALTER TABLE ONLY observationhasoffering
    ADD CONSTRAINT observationofferingfk FOREIGN KEY (offeringid) REFERENCES offering(offeringid);
ALTER TABLE ONLY compositeobservation
    ADD CONSTRAINT observationparentfk FOREIGN KEY (observationid) REFERENCES complexvalue(observationid);
ALTER TABLE ONLY profilevalue
    ADD CONSTRAINT observationprofilevaluefk FOREIGN KEY (observationid) REFERENCES observation(observationid);
ALTER TABLE ONLY referencevalue
    ADD CONSTRAINT observationrefvaluefk FOREIGN KEY (observationid) REFERENCES observation(observationid);
ALTER TABLE ONLY observation
    ADD CONSTRAINT observationseriesfk FOREIGN KEY (seriesid) REFERENCES series(seriesid);
ALTER TABLE ONLY swedataarrayvalue
    ADD CONSTRAINT observationswedataarrayvaluefk FOREIGN KEY (observationid) REFERENCES observation(observationid);
ALTER TABLE ONLY textvalue
    ADD CONSTRAINT observationtextvaluefk FOREIGN KEY (observationid) REFERENCES observation(observationid);
ALTER TABLE ONLY observation
    ADD CONSTRAINT observationunitfk FOREIGN KEY (unitid) REFERENCES unit(unitid);
ALTER TABLE ONLY observationconstellation
    ADD CONSTRAINT obsnconstprocedurefk FOREIGN KEY (procedureid) REFERENCES procedure(procedureid);
ALTER TABLE ONLY observableproperty
    ADD CONSTRAINT obspropcodespaceidentifierfk FOREIGN KEY (codespace) REFERENCES codespace(codespaceid);
ALTER TABLE ONLY observableproperty
    ADD CONSTRAINT obspropcodespacenamefk FOREIGN KEY (codespacename) REFERENCES codespace(codespaceid);
ALTER TABLE ONLY offering
    ADD CONSTRAINT offcodespaceidentifierfk FOREIGN KEY (codespace) REFERENCES codespace(codespaceid);
ALTER TABLE ONLY offering
    ADD CONSTRAINT offcodespacenamefk FOREIGN KEY (codespacename) REFERENCES codespace(codespaceid);
ALTER TABLE ONLY offeringrelation
    ADD CONSTRAINT offeringchildfk FOREIGN KEY (childofferingid) REFERENCES offering(offeringid);
ALTER TABLE ONLY offeringallowedfeaturetype
    ADD CONSTRAINT offeringfeaturetypefk FOREIGN KEY (featureofinteresttypeid) REFERENCES featureofinteresttype(featureofinteresttypeid);
ALTER TABLE ONLY offeringallowedobservationtype
    ADD CONSTRAINT offeringobservationtypefk FOREIGN KEY (observationtypeid) REFERENCES observationtype(observationtypeid);
ALTER TABLE ONLY offeringrelation
    ADD CONSTRAINT offeringparenffk FOREIGN KEY (parentofferingid) REFERENCES offering(offeringid);
ALTER TABLE ONLY offeringhasrelatedfeature
    ADD CONSTRAINT offeringrelatedfeaturefk FOREIGN KEY (relatedfeatureid) REFERENCES relatedfeature(relatedfeatureid);
ALTER TABLE ONLY profileobservation
    ADD CONSTRAINT oprofileobschildfk FOREIGN KEY (childobservationid) REFERENCES observation(observationid);
ALTER TABLE ONLY booleanparametervalue
    ADD CONSTRAINT parameterbooleanvaluefk FOREIGN KEY (parameterid) REFERENCES parameter(parameterid);
ALTER TABLE ONLY categoryparametervalue
    ADD CONSTRAINT parametercategoryvaluefk FOREIGN KEY (parameterid) REFERENCES parameter(parameterid);
ALTER TABLE ONLY countparametervalue
    ADD CONSTRAINT parametercountvaluefk FOREIGN KEY (parameterid) REFERENCES parameter(parameterid);
ALTER TABLE ONLY numericparametervalue
    ADD CONSTRAINT parameternumericvaluefk FOREIGN KEY (parameterid) REFERENCES parameter(parameterid);
ALTER TABLE ONLY textparametervalue
    ADD CONSTRAINT parametertextvaluefk FOREIGN KEY (parameterid) REFERENCES parameter(parameterid);
ALTER TABLE ONLY xmlparametervalue
    ADD CONSTRAINT parameterxmlvaluefk FOREIGN KEY (parameterid) REFERENCES parameter(parameterid);
ALTER TABLE ONLY procedure
    ADD CONSTRAINT proccodespaceidentifierfk FOREIGN KEY (codespace) REFERENCES codespace(codespaceid);
ALTER TABLE ONLY procedure
    ADD CONSTRAINT proccodespacenamefk FOREIGN KEY (codespacename) REFERENCES codespace(codespaceid);
ALTER TABLE ONLY sensorsystem
    ADD CONSTRAINT procedurechildfk FOREIGN KEY (childsensorid) REFERENCES procedure(procedureid);
ALTER TABLE ONLY sensorsystem
    ADD CONSTRAINT procedureparenffk FOREIGN KEY (parentsensorid) REFERENCES procedure(procedureid);
ALTER TABLE ONLY procedure
    ADD CONSTRAINT procprocdescformatfk FOREIGN KEY (proceduredescriptionformatid) REFERENCES proceduredescriptionformat(proceduredescriptionformatid);
ALTER TABLE ONLY profileobservation
    ADD CONSTRAINT profileobsparentfk FOREIGN KEY (observationid) REFERENCES profilevalue(observationid);
ALTER TABLE ONLY profilevalue
    ADD CONSTRAINT profileunitfk FOREIGN KEY (levelunitid) REFERENCES unit(unitid);
ALTER TABLE ONLY numericfeatparamvalue
    ADD CONSTRAINT quanfeatparamvalueunitfk FOREIGN KEY (unitid) REFERENCES unit(unitid);
ALTER TABLE ONLY numericparametervalue
    ADD CONSTRAINT quanparamvalueunitfk FOREIGN KEY (unitid) REFERENCES unit(unitid);
ALTER TABLE ONLY relatedfeaturehasrole
    ADD CONSTRAINT relatedfeatrelatedfeatrolefk FOREIGN KEY (relatedfeatureroleid) REFERENCES relatedfeaturerole(relatedfeatureroleid);
ALTER TABLE ONLY relatedfeature
    ADD CONSTRAINT relatedfeaturefeaturefk FOREIGN KEY (featureofinterestid) REFERENCES featureofinterest(featureofinterestid);
ALTER TABLE ONLY offeringhasrelatedfeature
    ADD CONSTRAINT relatedfeatureofferingfk FOREIGN KEY (offeringid) REFERENCES offering(offeringid);
ALTER TABLE ONLY resulttemplate
    ADD CONSTRAINT resulttemplatefeatureidx FOREIGN KEY (featureofinterestid) REFERENCES featureofinterest(featureofinterestid);
ALTER TABLE ONLY resulttemplate
    ADD CONSTRAINT resulttemplateobspropfk FOREIGN KEY (observablepropertyid) REFERENCES observableproperty(observablepropertyid);
ALTER TABLE ONLY resulttemplate
    ADD CONSTRAINT resulttemplateofferingidx FOREIGN KEY (offeringid) REFERENCES offering(offeringid);
ALTER TABLE ONLY resulttemplate
    ADD CONSTRAINT resulttemplateprocedurefk FOREIGN KEY (procedureid) REFERENCES procedure(procedureid);
ALTER TABLE ONLY series
    ADD CONSTRAINT seriescodespaceidentifierfk FOREIGN KEY (codespace) REFERENCES codespace(codespaceid);
ALTER TABLE ONLY series
    ADD CONSTRAINT seriescodespacenamefk FOREIGN KEY (codespacename) REFERENCES codespace(codespaceid);
ALTER TABLE ONLY series
    ADD CONSTRAINT seriesfeaturefk FOREIGN KEY (featureofinterestid) REFERENCES featureofinterest(featureofinterestid);
ALTER TABLE ONLY series
    ADD CONSTRAINT seriesobpropfk FOREIGN KEY (observablepropertyid) REFERENCES observableproperty(observablepropertyid);
ALTER TABLE ONLY series
    ADD CONSTRAINT seriesofferingfk FOREIGN KEY (offeringid) REFERENCES offering(offeringid);
ALTER TABLE ONLY series
    ADD CONSTRAINT seriesprocedurefk FOREIGN KEY (procedureid) REFERENCES procedure(procedureid);
ALTER TABLE ONLY seriesreference
    ADD CONSTRAINT seriesrefreffk FOREIGN KEY (referenceseriesid) REFERENCES series(seriesid);
ALTER TABLE ONLY seriesreference
    ADD CONSTRAINT seriesrefseriesfk FOREIGN KEY (seriesid) REFERENCES series(seriesid);
ALTER TABLE ONLY series
    ADD CONSTRAINT seriesunitfk FOREIGN KEY (unitid) REFERENCES unit(unitid);
ALTER TABLE ONLY procedure
    ADD CONSTRAINT typeoffk FOREIGN KEY (typeof) REFERENCES procedure(procedureid);
ALTER TABLE ONLY validproceduretime
    ADD CONSTRAINT validproceduretimeprocedurefk FOREIGN KEY (procedureid) REFERENCES procedure(procedureid);
ALTER TABLE ONLY validproceduretime
    ADD CONSTRAINT validprocprocdescformatfk FOREIGN KEY (proceduredescriptionformatid) REFERENCES proceduredescriptionformat(proceduredescriptionformatid);
CREATE TABLE foidata (featureofinterestid bigint PRIMARY KEY,
  ID character varying(255) NOT NULL UNIQUE,
  Name character varying(255) NOT NULL UNIQUE,
  CONSTRAINT foidata_featureofinterestid_fkey FOREIGN KEY (featureofinterestid)
  REFERENCES featureofinterest (featureofinterestid) MATCH SIMPLE
  ON UPDATE CASCADE ON DELETE CASCADE);
CREATE TABLE foidatametadata (columnid character varying(255) PRIMARY KEY,
  dede character varying(255) NOT NULL,
  uom bigint);
INSERT INTO foidatametadata VALUES ('id', 'ID');
INSERT INTO foidatametadata VALUES ('name', 'Name');
CREATE TABLE observablepropertyrelation (
                parentobservablepropertyid bigint NOT NULL,
                childobservablepropertyid bigint NOT NULL,
                CONSTRAINT observablepropertyrealtion_pkey PRIMARY KEY (childobservablepropertyid, parentobservablepropertyid),
                CONSTRAINT observablepropertychildfk FOREIGN KEY (childobservablepropertyid)
                   REFERENCES observableproperty (observablepropertyid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
                CONSTRAINT observablepropertyparentfk FOREIGN KEY (parentobservablepropertyid)
                   REFERENCES observableproperty (observablepropertyid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION);
CREATE SEQUENCE public.codespaceid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE public.codespaceid_seq
  OWNER TO postgres;
CREATE SEQUENCE public.featureofinterestid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE public.featureofinterestid_seq
  OWNER TO postgres;
CREATE SEQUENCE public.featureofinteresttypeid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE public.featureofinteresttypeid_seq
  OWNER TO postgres;
CREATE SEQUENCE public.observablepropertyid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE public.observablepropertyid_seq
  OWNER TO postgres;
CREATE SEQUENCE public.observationconstellationid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE public.observationconstellationid_seq
  OWNER TO postgres;
CREATE SEQUENCE public.observationid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE public.observationid_seq
  OWNER TO postgres;
CREATE SEQUENCE public.observationtypeid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE public.observationtypeid_seq
  OWNER TO postgres;
CREATE SEQUENCE public.offeringid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE public.offeringid_seq
  OWNER TO postgres;
CREATE SEQUENCE public.parameterid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE public.parameterid_seq
  OWNER TO postgres;
CREATE SEQUENCE public.procdescformatid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE public.procdescformatid_seq
  OWNER TO postgres;
CREATE SEQUENCE public.procedureid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE public.procedureid_seq
  OWNER TO postgres;
CREATE SEQUENCE public.relatedfeatureid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE public.relatedfeatureid_seq
  OWNER TO postgres;
CREATE SEQUENCE public.relatedfeatureroleid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE public.relatedfeatureroleid_seq
  OWNER TO postgres;
CREATE SEQUENCE public.relatedobservationid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE public.relatedobservationid_seq
  OWNER TO postgres;
CREATE SEQUENCE public.resulttemplateid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE public.resulttemplateid_seq
  OWNER TO postgres;
CREATE SEQUENCE public.seriesid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE public.seriesid_seq
  OWNER TO postgres;
CREATE SEQUENCE public.unitid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE public.unitid_seq
  OWNER TO postgres;
CREATE SEQUENCE public.validproceduretimeid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE public.validproceduretimeid_seq
  OWNER TO postgres;


-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler version: 0.9.4
-- PostgreSQL version: 12.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: udistrital_financiera | type: DATABASE --
-- DROP DATABASE IF EXISTS udistrital_financiera;
-- CREATE DATABASE udistrital_financiera;
-- ddl-end --


-- object: ingresos | type: SCHEMA --
-- DROP SCHEMA IF EXISTS ingresos CASCADE;
CREATE SCHEMA ingresos;
-- ddl-end --

SET search_path TO public,ingresos;
-- ddl-end --

-- object: ingresos.ingreso | type: TABLE --
-- DROP TABLE IF EXISTS ingresos.ingreso CASCADE;
CREATE TABLE ingresos.ingreso (
	id serial NOT NULL,
	vigencia_id character varying NOT NULL,
	consecutivo integer NOT NULL,
	area_funcional character varying NOT NULL,
	valor_total numeric(20,7) NOT NULL,
	tipo_ingreso_id integer,
	movimiento_contable_id integer NOT NULL,
	metadatos jsonb,
	activo boolean NOT NULL,
	fecha_creacion timestamp with time zone NOT NULL,
	fecha_modificacion timestamp with time zone NOT NULL,
	CONSTRAINT pk_id_ingreso PRIMARY KEY (id)
);
-- ddl-end --
COMMENT ON TABLE ingresos.ingreso IS E'Tabla que almacena toda la información pertinente para consultar un registro';
-- ddl-end --
COMMENT ON COLUMN ingresos.ingreso.id IS E'Identificador de la tabla de ingreso, sequencia generada por el motor de base de datos.';
-- ddl-end --
COMMENT ON COLUMN ingresos.ingreso.vigencia_id IS E'Identificador de la vigencia actual almacenada en la colección plan_cuentas.vigencia_233_2 de mongo';
-- ddl-end --
COMMENT ON COLUMN ingresos.ingreso.consecutivo IS E'Número que indica cuántos ingresos se han generado';
-- ddl-end --
COMMENT ON COLUMN ingresos.ingreso.area_funcional IS E'Campo que almacena los datos de la entidad que realiza el ingreso (Rector, Convenios, etc)';
-- ddl-end --
COMMENT ON COLUMN ingresos.ingreso.valor_total IS E'Campo para almacenar el valor final de un ingreso';
-- ddl-end --
COMMENT ON COLUMN ingresos.ingreso.tipo_ingreso_id IS E'Campo para relacionar un id de la tabla tipo_ingreso';
-- ddl-end --
COMMENT ON COLUMN ingresos.ingreso.movimiento_contable_id IS E'Campo para relacionar un id de los movimientos contables (actualmente almacenado como metadato)';
-- ddl-end --
COMMENT ON COLUMN ingresos.ingreso.metadatos IS E'Datos varios para identificar el ingreso (datos WebService, movimiento contable, etc)';
-- ddl-end --
COMMENT ON COLUMN ingresos.ingreso.activo IS E'Campo para verificar que el registro está en uso';
-- ddl-end --
COMMENT ON COLUMN ingresos.ingreso.fecha_creacion IS E'Fecha en la fue registrado el ingreso';
-- ddl-end --
COMMENT ON COLUMN ingresos.ingreso.fecha_modificacion IS E'Fecha en la que fue modificado el ingreso';
-- ddl-end --

-- object: ingresos.tipo_ingreso | type: TABLE --
-- DROP TABLE IF EXISTS ingresos.tipo_ingreso CASCADE;
CREATE TABLE ingresos.tipo_ingreso (
	id serial NOT NULL,
	tipo character varying NOT NULL,
	descripcion character varying(250),
	parametrizacion_contable jsonb,
	numero_orden numeric(5,2),
	codigo_abreviacion character varying(20),
	activo boolean NOT NULL,
	fecha_creacion timestamp with time zone NOT NULL,
	fecha_modificacion timestamp with time zone NOT NULL,
	CONSTRAINT pk_id_tipo_ingreso PRIMARY KEY (id),
	CONSTRAINT uq_codigo_abreviacion UNIQUE (codigo_abreviacion)
);
-- ddl-end --
COMMENT ON TABLE ingresos.tipo_ingreso IS E'Tabla que relaciona un ingreso con su tipo correspondiente';
-- ddl-end --
COMMENT ON COLUMN ingresos.tipo_ingreso.id IS E'Identificador de la tabla de tipo_ingreso, sequencia generada por el motor de base de datos.';
-- ddl-end --
COMMENT ON COLUMN ingresos.tipo_ingreso.tipo IS E'Nombre que se le asigna a cada tipo de ingreso';
-- ddl-end --
COMMENT ON COLUMN ingresos.tipo_ingreso.descripcion IS E'Descripción ampliada del tipo de ingreso';
-- ddl-end --
COMMENT ON COLUMN ingresos.tipo_ingreso.parametrizacion_contable IS E'Parametrización utilizada para vincular un tipo de ingreso con un tipo de movimiento contable';
-- ddl-end --
COMMENT ON COLUMN ingresos.tipo_ingreso.codigo_abreviacion IS E'Sigla que describa el tipo de ingreso';
-- ddl-end --
COMMENT ON COLUMN ingresos.tipo_ingreso.activo IS E'Dato que indica si el registro es válido';
-- ddl-end --
COMMENT ON COLUMN ingresos.tipo_ingreso.fecha_creacion IS E'Fecha en la que se creó el tipo de ingreso';
-- ddl-end --
COMMENT ON COLUMN ingresos.tipo_ingreso.fecha_modificacion IS E'Fecha en la que se modificó el registro del tipo de ingreso';
-- ddl-end --

-- object: ingresos.afectacion_presupuestal | type: TABLE --
-- DROP TABLE IF EXISTS ingresos.afectacion_presupuestal CASCADE;
CREATE TABLE ingresos.afectacion_presupuestal (
	id serial NOT NULL,
	ingreso_id integer NOT NULL,
	rubro_id integer NOT NULL,
	activo boolean NOT NULL,
	fecha_creacion timestamp with time zone NOT NULL,
	fecha_modificacion timestamp with time zone NOT NULL,
	CONSTRAINT pk_afectacion_presupuestal PRIMARY KEY (id),
	CONSTRAINT uq_ingreso_rubro_afectacion_presupuestal UNIQUE (ingreso_id,rubro_id)
);
-- ddl-end --
COMMENT ON TABLE ingresos.afectacion_presupuestal IS E'Tabla que relaciona un ingreso con los diferentes rubros que pueda incluir al momento de la creación';
-- ddl-end --
COMMENT ON COLUMN ingresos.afectacion_presupuestal.id IS E'Identificador de la tabla de afectacion_presupuestal, sequencia generada por el motor de base de datos.';
-- ddl-end --
COMMENT ON COLUMN ingresos.afectacion_presupuestal.ingreso_id IS E'Campo para relacionar un id de la tabla de ingreso.';
-- ddl-end --
COMMENT ON COLUMN ingresos.afectacion_presupuestal.rubro_id IS E'Campo para relacionar los rubros almacenados en plan_cuentas.arbol_rubro_apropiacion_año_periodo; donde año y periodo son los actuales, al momento de la creación del esquema 2022_1';
-- ddl-end --
COMMENT ON COLUMN ingresos.afectacion_presupuestal.activo IS E'Campo que indica si un registro es válido';
-- ddl-end --
COMMENT ON COLUMN ingresos.afectacion_presupuestal.fecha_creacion IS E'Fecha en la que se creó un registro de afectación presupuestal';
-- ddl-end --
COMMENT ON COLUMN ingresos.afectacion_presupuestal.fecha_modificacion IS E'Fecha en la que se realizó la modificación del registro en afectación presupuestal';
-- ddl-end --

-- object: fk_ingreso_tipo_ingreso | type: CONSTRAINT --
-- ALTER TABLE ingresos.ingreso DROP CONSTRAINT IF EXISTS fk_ingreso_tipo_ingreso CASCADE;
ALTER TABLE ingresos.ingreso ADD CONSTRAINT fk_ingreso_tipo_ingreso FOREIGN KEY (tipo_ingreso_id)
REFERENCES ingresos.tipo_ingreso (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_ingreso_afectacion_presupuestal | type: CONSTRAINT --
-- ALTER TABLE ingresos.afectacion_presupuestal DROP CONSTRAINT IF EXISTS fk_ingreso_afectacion_presupuestal CASCADE;
ALTER TABLE ingresos.afectacion_presupuestal ADD CONSTRAINT fk_ingreso_afectacion_presupuestal FOREIGN KEY (ingreso_id)
REFERENCES ingresos.ingreso (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --



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

SET search_path TO pg_catalog,public,ingresos;
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
	fecha_creacion timestamp NOT NULL,
	fecha_modificacion timestamp NOT NULL,
	CONSTRAINT pk_id_ingreso PRIMARY KEY (id)
);
-- ddl-end --

-- object: ingresos.tipo_ingreso | type: TABLE --
-- DROP TABLE IF EXISTS ingresos.tipo_ingreso CASCADE;
CREATE TABLE ingresos.tipo_ingreso (
	id serial NOT NULL,
	tipo character varying NOT NULL,
	parametrizacion_contable jsonb,
	activo boolean NOT NULL,
	fecha_creacion timestamp NOT NULL,
	fecha_modificacion timestamp NOT NULL,
	CONSTRAINT pk_id_tipo_ingreso PRIMARY KEY (id)
);
-- ddl-end --

-- object: ingresos.afectacion_presupuestal | type: TABLE --
-- DROP TABLE IF EXISTS ingresos.afectacion_presupuestal CASCADE;
CREATE TABLE ingresos.afectacion_presupuestal (
	id serial NOT NULL,
	ingreso_id integer NOT NULL,
	rubro_id integer NOT NULL,
	activo boolean NOT NULL,
	fecha_creacion timestamp NOT NULL,
	fecha_modificacion timestamp NOT NULL,
	CONSTRAINT pk_afectacion_presupuestal PRIMARY KEY (id),
	CONSTRAINT uq_ingreso_rubro_afectacion_presupuestal UNIQUE (ingreso_id,rubro_id)
);
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



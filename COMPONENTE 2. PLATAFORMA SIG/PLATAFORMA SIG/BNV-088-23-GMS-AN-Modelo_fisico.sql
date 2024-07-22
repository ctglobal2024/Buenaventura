-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler version: 1.0.4
-- PostgreSQL version: 15.0
-- Project Site: pgmodeler.io
-- Model Author: ---
-- object: cloudsqlagent | type: ROLE --
-- DROP ROLE IF EXISTS cloudsqlagent;
CREATE ROLE cloudsqlagent WITH 
	CREATEDB
	CREATEROLE
	INHERIT
	LOGIN
	 PASSWORD '********';
-- ddl-end --

-- object: cloudsqlimportexport | type: ROLE --
-- DROP ROLE IF EXISTS cloudsqlimportexport;
CREATE ROLE cloudsqlimportexport WITH 
	CREATEDB
	CREATEROLE
	INHERIT
	LOGIN
	 PASSWORD '********';
-- ddl-end --

-- object: cloudsqllogical | type: ROLE --
-- DROP ROLE IF EXISTS cloudsqllogical;
CREATE ROLE cloudsqllogical WITH 
	INHERIT
	REPLICATION
	 PASSWORD '********';
-- ddl-end --

-- object: cloudsqlsuperuser | type: ROLE --
-- DROP ROLE IF EXISTS cloudsqlsuperuser;
CREATE ROLE cloudsqlsuperuser WITH 
	CREATEDB
	CREATEROLE
	INHERIT
	LOGIN
	 PASSWORD '********'
	ROLE cloudsqlagent,cloudsqlimportexport,postgres,cloudsqllogical;
-- ddl-end --

-- object: cloudsqlreplica | type: ROLE --
-- DROP ROLE IF EXISTS cloudsqlreplica;
CREATE ROLE cloudsqlreplica WITH 
	INHERIT
	LOGIN
	REPLICATION
	 PASSWORD '********';
-- ddl-end --

-- object: cloudsqliamuser | type: ROLE --
-- DROP ROLE IF EXISTS cloudsqliamuser;
CREATE ROLE cloudsqliamuser WITH 
	INHERIT
	 PASSWORD '********';
-- ddl-end --

-- object: cloudsqliamserviceaccount | type: ROLE --
-- DROP ROLE IF EXISTS cloudsqliamserviceaccount;
CREATE ROLE cloudsqliamserviceaccount WITH 
	INHERIT
	 PASSWORD '********';
-- ddl-end --


-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: buenaventura | type: DATABASE --
-- DROP DATABASE IF EXISTS buenaventura;
CREATE DATABASE buenaventura
	ENCODING = 'UTF8'
	LC_COLLATE = 'en_US.UTF8'
	LC_CTYPE = 'en_US.UTF8'
	TABLESPACE = pg_default
	OWNER = postgres;
-- ddl-end --


SET check_function_bodies = false;
-- ddl-end --

-- object: catastro | type: SCHEMA --
-- DROP SCHEMA IF EXISTS catastro CASCADE;
CREATE SCHEMA catastro;
-- ddl-end --
ALTER SCHEMA catastro OWNER TO postgres;
-- ddl-end --

SET search_path TO pg_catalog,public,catastro;
-- ddl-end --

-- object: public.usuario | type: TABLE --
-- DROP TABLE IF EXISTS public.usuario CASCADE;
CREATE TABLE public.usuario (
	nombre character varying(50),
	email character varying(100),
	usuario character varying(50) NOT NULL,
	contrasena character varying(32),
	estado boolean,
	id character varying(50) NOT NULL,
	tipo character varying(20),
	municipio character varying(254),
	CONSTRAINT usuario_pkey PRIMARY KEY (id),
	CONSTRAINT constraint_name UNIQUE (email),
	CONSTRAINT constraintname UNIQUE (usuario)
);
-- ddl-end --
ALTER TABLE public.usuario OWNER TO postgres;
-- ddl-end --

-- object: postgis | type: EXTENSION --
-- DROP EXTENSION IF EXISTS postgis CASCADE;
CREATE EXTENSION postgis
WITH SCHEMA public
VERSION '3.1.7';
-- ddl-end --
COMMENT ON EXTENSION postgis IS E'PostGIS geometry and geography spatial types and functions';
-- ddl-end --

-- object: public.capas_gid_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.capas_gid_seq CASCADE;
CREATE SEQUENCE public.capas_gid_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.capas_gid_seq OWNER TO postgres;
-- ddl-end --

-- object: public.capas | type: TABLE --
-- DROP TABLE IF EXISTS public.capas CASCADE;
CREATE TABLE public.capas (
	gid integer DEFAULT nextval('public.capas_gid_seq'::regclass),
	url character varying(254),
	layer character varying(100),
	nombre character varying(100),
	permisos character varying(100),
	id character varying(50) NOT NULL,
	CONSTRAINT capas_pkey PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public.capas OWNER TO postgres;
-- ddl-end --

-- object: catastro.u_manzana_gid_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS catastro.u_manzana_gid_seq CASCADE;
CREATE SEQUENCE catastro.u_manzana_gid_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE catastro.u_manzana_gid_seq OWNER TO postgres;
-- ddl-end --

-- object: catastro.u_manzana | type: TABLE --
-- DROP TABLE IF EXISTS catastro.u_manzana CASCADE;
CREATE TABLE catastro.u_manzana (
	gid integer NOT NULL DEFAULT nextval('catastro.u_manzana_gid_seq'::regclass),
	objectid double precision,
	codigo character varying(17),
	barrio_cod character varying(13),
	codigo_ant character varying(254),
	shape_leng numeric,
	shape_area numeric,
	geom geometry(MULTIPOLYGON, 4326),
	CONSTRAINT u_manzana_pkey PRIMARY KEY (gid)
);
-- ddl-end --
ALTER TABLE catastro.u_manzana OWNER TO postgres;
-- ddl-end --

-- object: catastro.r_nomenclatura_domiciliaria_gid_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS catastro.r_nomenclatura_domiciliaria_gid_seq CASCADE;
CREATE SEQUENCE catastro.r_nomenclatura_domiciliaria_gid_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE catastro.r_nomenclatura_domiciliaria_gid_seq OWNER TO postgres;
-- ddl-end --

-- object: catastro.r_nomenclatura_domiciliaria | type: TABLE --
-- DROP TABLE IF EXISTS catastro.r_nomenclatura_domiciliaria CASCADE;
CREATE TABLE catastro.r_nomenclatura_domiciliaria (
	gid integer NOT NULL DEFAULT nextval('catastro.r_nomenclatura_domiciliaria_gid_seq'::regclass),
	objectid double precision,
	texto character varying(254),
	terreno_co character varying(30),
	shape_leng numeric,
	geom geometry(MULTILINESTRING, 4326),
	CONSTRAINT r_nomenclatura_domiciliaria_pkey PRIMARY KEY (gid)
);
-- ddl-end --
ALTER TABLE catastro.r_nomenclatura_domiciliaria OWNER TO postgres;
-- ddl-end --

-- object: catastro.r_nomenclatura_vial_gid_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS catastro.r_nomenclatura_vial_gid_seq CASCADE;
CREATE SEQUENCE catastro.r_nomenclatura_vial_gid_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE catastro.r_nomenclatura_vial_gid_seq OWNER TO postgres;
-- ddl-end --

-- object: catastro.r_nomenclatura_vial | type: TABLE --
-- DROP TABLE IF EXISTS catastro.r_nomenclatura_vial CASCADE;
CREATE TABLE catastro.r_nomenclatura_vial (
	gid integer NOT NULL DEFAULT nextval('catastro.r_nomenclatura_vial_gid_seq'::regclass),
	objectid double precision,
	texto character varying(254),
	shape_leng numeric,
	geom geometry(MULTILINESTRING, 4326),
	CONSTRAINT r_nomenclatura_vial_pkey PRIMARY KEY (gid)
);
-- ddl-end --
ALTER TABLE catastro.r_nomenclatura_vial OWNER TO postgres;
-- ddl-end --

-- object: catastro.r_vereda_gid_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS catastro.r_vereda_gid_seq CASCADE;
CREATE SEQUENCE catastro.r_vereda_gid_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE catastro.r_vereda_gid_seq OWNER TO postgres;
-- ddl-end --

-- object: catastro.r_vereda | type: TABLE --
-- DROP TABLE IF EXISTS catastro.r_vereda CASCADE;
CREATE TABLE catastro.r_vereda (
	gid integer NOT NULL DEFAULT nextval('catastro.r_vereda_gid_seq'::regclass),
	objectid double precision,
	codigo character varying(17),
	sector_cod character varying(9),
	nombre character varying(100),
	codigo_ant character varying(13),
	shape_leng numeric,
	shape_area numeric,
	geom geometry(MULTIPOLYGON, 4326),
	CONSTRAINT r_vereda_pkey PRIMARY KEY (gid)
);
-- ddl-end --
ALTER TABLE catastro.r_vereda OWNER TO postgres;
-- ddl-end --

-- object: catastro.r_zona_homogenea_fisica_gid_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS catastro.r_zona_homogenea_fisica_gid_seq CASCADE;
CREATE SEQUENCE catastro.r_zona_homogenea_fisica_gid_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE catastro.r_zona_homogenea_fisica_gid_seq OWNER TO postgres;
-- ddl-end --

-- object: catastro.r_zona_homogenea_fisica | type: TABLE --
-- DROP TABLE IF EXISTS catastro.r_zona_homogenea_fisica CASCADE;
CREATE TABLE catastro.r_zona_homogenea_fisica (
	gid integer NOT NULL DEFAULT nextval('catastro.r_zona_homogenea_fisica_gid_seq'::regclass),
	objectid double precision,
	codigo character varying(7),
	codigo_zon character varying(4),
	area_homog character varying(254),
	norma_uso_ character varying(250),
	vigencia date,
	disponib_1 character varying(250),
	influenc_1 character varying(250),
	shape_leng numeric,
	shape_area numeric,
	geom geometry(MULTIPOLYGON, 4326),
	CONSTRAINT r_zona_homogenea_fisica_pkey PRIMARY KEY (gid)
);
-- ddl-end --
ALTER TABLE catastro.r_zona_homogenea_fisica OWNER TO postgres;
-- ddl-end --

-- object: catastro.r_zona_homogenea_geoeconomica_gid_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS catastro.r_zona_homogenea_geoeconomica_gid_seq CASCADE;
CREATE SEQUENCE catastro.r_zona_homogenea_geoeconomica_gid_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE catastro.r_zona_homogenea_geoeconomica_gid_seq OWNER TO postgres;
-- ddl-end --

-- object: catastro.r_zona_homogenea_geoeconomica | type: TABLE --
-- DROP TABLE IF EXISTS catastro.r_zona_homogenea_geoeconomica CASCADE;
CREATE TABLE catastro.r_zona_homogenea_geoeconomica (
	gid integer NOT NULL DEFAULT nextval('catastro.r_zona_homogenea_geoeconomica_gid_seq'::regclass),
	objectid double precision,
	codigo character varying(7),
	codigo_zon character varying(4),
	valor_hect character varying(20),
	subzona_fi character varying(254),
	vigencia date,
	shape_leng numeric,
	shape_area numeric,
	geom geometry(MULTIPOLYGON, 4326),
	CONSTRAINT r_zona_homogenea_geoeconomica_pkey PRIMARY KEY (gid)
);
-- ddl-end --
ALTER TABLE catastro.r_zona_homogenea_geoeconomica OWNER TO postgres;
-- ddl-end --

-- object: catastro.u_nomenclatura_vial_gid_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS catastro.u_nomenclatura_vial_gid_seq CASCADE;
CREATE SEQUENCE catastro.u_nomenclatura_vial_gid_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE catastro.u_nomenclatura_vial_gid_seq OWNER TO postgres;
-- ddl-end --

-- object: catastro.u_nomenclatura_vial | type: TABLE --
-- DROP TABLE IF EXISTS catastro.u_nomenclatura_vial CASCADE;
CREATE TABLE catastro.u_nomenclatura_vial (
	gid integer NOT NULL DEFAULT nextval('catastro.u_nomenclatura_vial_gid_seq'::regclass),
	objectid double precision,
	texto character varying(254),
	shape_leng numeric,
	geom geometry(MULTILINESTRING, 4326),
	CONSTRAINT u_nomenclatura_vial_pkey PRIMARY KEY (gid)
);
-- ddl-end --
ALTER TABLE catastro.u_nomenclatura_vial OWNER TO postgres;
-- ddl-end --

-- object: catastro.u_unidad_gid_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS catastro.u_unidad_gid_seq CASCADE;
CREATE SEQUENCE catastro.u_unidad_gid_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE catastro.u_unidad_gid_seq OWNER TO postgres;
-- ddl-end --

-- object: catastro.u_unidad | type: TABLE --
-- DROP TABLE IF EXISTS catastro.u_unidad CASCADE;
CREATE TABLE catastro.u_unidad (
	gid integer NOT NULL DEFAULT nextval('catastro.u_unidad_gid_seq'::regclass),
	objectid double precision,
	codigo character varying(30),
	terreno_co character varying(30),
	construcci character varying(30),
	tipo_const character varying(20),
	tipo_domin character varying(20),
	etiqueta character varying(50),
	identifica character varying(2),
	planta_1 character varying(20),
	shape_leng numeric,
	shape_area numeric,
	geom geometry(MULTIPOLYGON, 4326),
	CONSTRAINT u_unidad_pkey PRIMARY KEY (gid)
);
-- ddl-end --
ALTER TABLE catastro.u_unidad OWNER TO postgres;
-- ddl-end --

-- object: catastro.u_zona_homogenea_geoeconomica_gid_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS catastro.u_zona_homogenea_geoeconomica_gid_seq CASCADE;
CREATE SEQUENCE catastro.u_zona_homogenea_geoeconomica_gid_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE catastro.u_zona_homogenea_geoeconomica_gid_seq OWNER TO postgres;
-- ddl-end --

-- object: catastro.u_zona_homogenea_geoeconomica | type: TABLE --
-- DROP TABLE IF EXISTS catastro.u_zona_homogenea_geoeconomica CASCADE;
CREATE TABLE catastro.u_zona_homogenea_geoeconomica (
	gid integer NOT NULL DEFAULT nextval('catastro.u_zona_homogenea_geoeconomica_gid_seq'::regclass),
	objectid double precision,
	codigo character varying(7),
	codigo_zon character varying(4),
	valor_metr numeric,
	subzona_fi character varying(100),
	vigencia date,
	shape_leng numeric,
	shape_area numeric,
	geom geometry(MULTIPOLYGON, 4326),
	CONSTRAINT u_zona_homogenea_geoeconomica_pkey PRIMARY KEY (gid)
);
-- ddl-end --
ALTER TABLE catastro.u_zona_homogenea_geoeconomica OWNER TO postgres;
-- ddl-end --

-- object: r_nomenclatura_domiciliaria_geom_idx | type: INDEX --
-- DROP INDEX IF EXISTS catastro.r_nomenclatura_domiciliaria_geom_idx CASCADE;
CREATE INDEX r_nomenclatura_domiciliaria_geom_idx ON catastro.r_nomenclatura_domiciliaria
USING gist
(
	geom
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: r_nomenclatura_vial_geom_idx | type: INDEX --
-- DROP INDEX IF EXISTS catastro.r_nomenclatura_vial_geom_idx CASCADE;
CREATE INDEX r_nomenclatura_vial_geom_idx ON catastro.r_nomenclatura_vial
USING gist
(
	geom
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: r_vereda_geom_idx | type: INDEX --
-- DROP INDEX IF EXISTS catastro.r_vereda_geom_idx CASCADE;
CREATE INDEX r_vereda_geom_idx ON catastro.r_vereda
USING gist
(
	geom
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: r_zona_homogenea_fisica_geom_idx | type: INDEX --
-- DROP INDEX IF EXISTS catastro.r_zona_homogenea_fisica_geom_idx CASCADE;
CREATE INDEX r_zona_homogenea_fisica_geom_idx ON catastro.r_zona_homogenea_fisica
USING gist
(
	geom
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: r_zona_homogenea_geoeconomica_geom_idx | type: INDEX --
-- DROP INDEX IF EXISTS catastro.r_zona_homogenea_geoeconomica_geom_idx CASCADE;
CREATE INDEX r_zona_homogenea_geoeconomica_geom_idx ON catastro.r_zona_homogenea_geoeconomica
USING gist
(
	geom
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: u_manzana_geom_idx | type: INDEX --
-- DROP INDEX IF EXISTS catastro.u_manzana_geom_idx CASCADE;
CREATE INDEX u_manzana_geom_idx ON catastro.u_manzana
USING gist
(
	geom
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: u_nomenclatura_vial_geom_idx | type: INDEX --
-- DROP INDEX IF EXISTS catastro.u_nomenclatura_vial_geom_idx CASCADE;
CREATE INDEX u_nomenclatura_vial_geom_idx ON catastro.u_nomenclatura_vial
USING gist
(
	geom
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: u_unidad_geom_idx | type: INDEX --
-- DROP INDEX IF EXISTS catastro.u_unidad_geom_idx CASCADE;
CREATE INDEX u_unidad_geom_idx ON catastro.u_unidad
USING gist
(
	geom
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: u_zona_homogenea_geoeconomica_geom_idx | type: INDEX --
-- DROP INDEX IF EXISTS catastro.u_zona_homogenea_geoeconomica_geom_idx CASCADE;
CREATE INDEX u_zona_homogenea_geoeconomica_geom_idx ON catastro.u_zona_homogenea_geoeconomica
USING gist
(
	geom
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: catastro.u_nomenclatura_domiciliaria_gid_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS catastro.u_nomenclatura_domiciliaria_gid_seq CASCADE;
CREATE SEQUENCE catastro.u_nomenclatura_domiciliaria_gid_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE catastro.u_nomenclatura_domiciliaria_gid_seq OWNER TO postgres;
-- ddl-end --

-- object: catastro.u_nomenclatura_domiciliaria | type: TABLE --
-- DROP TABLE IF EXISTS catastro.u_nomenclatura_domiciliaria CASCADE;
CREATE TABLE catastro.u_nomenclatura_domiciliaria (
	gid integer NOT NULL DEFAULT nextval('catastro.u_nomenclatura_domiciliaria_gid_seq'::regclass),
	objectid double precision,
	texto character varying(254),
	terreno_co character varying(30),
	shape_leng numeric,
	geom geometry(MULTILINESTRING, 4326),
	CONSTRAINT u_nomenclatura_domiciliaria_pkey PRIMARY KEY (gid)
);
-- ddl-end --
ALTER TABLE catastro.u_nomenclatura_domiciliaria OWNER TO postgres;
-- ddl-end --

-- object: u_nomenclatura_domiciliaria_geom_idx | type: INDEX --
-- DROP INDEX IF EXISTS catastro.u_nomenclatura_domiciliaria_geom_idx CASCADE;
CREATE INDEX u_nomenclatura_domiciliaria_geom_idx ON catastro.u_nomenclatura_domiciliaria
USING gist
(
	geom
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: public.to_tsquery_partial | type: FUNCTION --
-- DROP FUNCTION IF EXISTS public.to_tsquery_partial(text) CASCADE;
CREATE FUNCTION public.to_tsquery_partial (_param1 text)
	RETURNS tsquery
	LANGUAGE sql
	VOLATILE 
	CALLED ON NULL INPUT
	SECURITY INVOKER
	PARALLEL UNSAFE
	COST 100
	AS $$
    SELECT to_tsquery('simple',
           array_to_string(
           regexp_split_to_array(
           trim($1),E'\\s+'),' & ') ||
           CASE WHEN $1 ~ ' $' THEN '' ELSE ':*' END)
  
$$;
-- ddl-end --
ALTER FUNCTION public.to_tsquery_partial(text) OWNER TO postgres;
-- ddl-end --

-- object: public.mapas_pdf_gid_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.mapas_pdf_gid_seq CASCADE;
CREATE SEQUENCE public.mapas_pdf_gid_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.mapas_pdf_gid_seq OWNER TO postgres;
-- ddl-end --

-- object: public.mapas_pdf | type: TABLE --
-- DROP TABLE IF EXISTS public.mapas_pdf CASCADE;
CREATE TABLE public.mapas_pdf (
	gid integer NOT NULL DEFAULT nextval('public.mapas_pdf_gid_seq'::regclass),
	codigo character varying(50),
	categoria character varying(30),
	nombre_del_plano character varying(100),
	CONSTRAINT mapas_pdf_pkey PRIMARY KEY (gid)
);
-- ddl-end --
ALTER TABLE public.mapas_pdf OWNER TO postgres;
-- ddl-end --

-- object: catastro.r1_gid_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS catastro.r1_gid_seq CASCADE;
CREATE SEQUENCE catastro.r1_gid_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE catastro.r1_gid_seq OWNER TO postgres;
-- ddl-end --

-- object: catastro.r1 | type: TABLE --
-- DROP TABLE IF EXISTS catastro.r1 CASCADE;
CREATE TABLE catastro.r1 (
	gid integer NOT NULL DEFAULT nextval('catastro.r1_gid_seq'::regclass),
	codigo character varying(50),
	cod_propie character varying(20),
	nombre character varying(200),
	tipo_doc character varying(5),
	num_doc character varying(20),
	direccion character varying(100),
	destino_ec character varying(5),
	area_terre numeric,
	area_const numeric,
	avaluo numeric,
	matricula character varying(50),
	CONSTRAINT r1_pkey PRIMARY KEY (gid)
);
-- ddl-end --
ALTER TABLE catastro.r1 OWNER TO postgres;
-- ddl-end --

-- object: public.reguser_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.reguser_id_seq CASCADE;
CREATE SEQUENCE public.reguser_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START WITH 90168
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.reguser_id_seq OWNER TO postgres;
-- ddl-end --

-- object: public.reguser | type: TABLE --
-- DROP TABLE IF EXISTS public.reguser CASCADE;
CREATE TABLE public.reguser (
	id integer NOT NULL DEFAULT nextval('public.reguser_id_seq'::regclass),
	usuario character varying(50) NOT NULL,
	fecha timestamp DEFAULT now(),
	actividad character varying(50),
	tipo character varying(50),
	CONSTRAINT id_pkey_amco PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public.reguser OWNER TO postgres;
-- ddl-end --

-- object: "grant_CU_cd8e46e7b6" | type: PERMISSION --
GRANT CREATE,USAGE
   ON SCHEMA public
   TO PUBLIC;
-- ddl-end --

-- object: "grant_CU_eb94f049ac" | type: PERMISSION --
GRANT CREATE,USAGE
   ON SCHEMA public
   TO postgres;
-- ddl-end --

-- object: "grant_cT_57a794ac0c" | type: PERMISSION --
GRANT CONNECT,TEMPORARY
   ON DATABASE buenaventura
   TO PUBLIC;
-- ddl-end --

-- object: "grant_CcT_d51c603e09" | type: PERMISSION --
GRANT CREATE,CONNECT,TEMPORARY
   ON DATABASE buenaventura
   TO postgres;
-- ddl-end --

-- object: "grant_CU_10a7dd29cf" | type: PERMISSION --
GRANT CREATE,USAGE
   ON SCHEMA catastro
   TO postgres;
-- ddl-end --

-- object: "grant_CU_7f42c616e0" | type: PERMISSION --
GRANT CREATE,USAGE
   ON SCHEMA catastro
   TO PUBLIC;
-- ddl-end --



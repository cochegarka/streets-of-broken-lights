-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.3
-- PostgreSQL version: 13.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: road_depot | type: DATABASE --
-- DROP DATABASE IF EXISTS road_depot;
CREATE DATABASE road_depot;
-- ddl-end --


-- object: public.car_owner_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.car_owner_id_seq CASCADE;
CREATE SEQUENCE public.car_owner_id_seq
	INCREMENT BY 1
	MINVALUE -2147483648
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --

-- object: public.accident_participant_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.accident_participant_id_seq CASCADE;
CREATE SEQUENCE public.accident_participant_id_seq
	INCREMENT BY 1
	MINVALUE -2147483648
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --

-- object: public.registration_application_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.registration_application_id_seq CASCADE;
CREATE SEQUENCE public.registration_application_id_seq
	INCREMENT BY 1
	MINVALUE -2147483648
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --

-- object: public.theft_statement_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.theft_statement_id_seq CASCADE;
CREATE SEQUENCE public.theft_statement_id_seq
	INCREMENT BY 1
	MINVALUE -2147483648
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --

-- object: public.inspection_application_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.inspection_application_id_seq CASCADE;
CREATE SEQUENCE public.inspection_application_id_seq
	INCREMENT BY 1
	MINVALUE -2147483648
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --

-- object: public.accident_alert_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.accident_alert_id_seq CASCADE;
CREATE SEQUENCE public.accident_alert_id_seq
	INCREMENT BY 1
	MINVALUE -2147483648
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --

-- object: public.insurance_policy_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.insurance_policy_id_seq CASCADE;
CREATE SEQUENCE public.insurance_policy_id_seq
	INCREMENT BY 1
	MINVALUE -2147483648
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --

-- object: public.ownership_certificate_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.ownership_certificate_id_seq CASCADE;
CREATE SEQUENCE public.ownership_certificate_id_seq
	INCREMENT BY 1
	MINVALUE -2147483648
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --

-- object: public.vehicle_passport_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.vehicle_passport_id_seq CASCADE;
CREATE SEQUENCE public.vehicle_passport_id_seq
	INCREMENT BY 1
	MINVALUE -2147483648
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --

-- object: public.registration_certificate_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.registration_certificate_id_seq CASCADE;
CREATE SEQUENCE public.registration_certificate_id_seq
	INCREMENT BY 1
	MINVALUE -2147483648
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --

-- object: public.accident_card_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.accident_card_id_seq CASCADE;
CREATE SEQUENCE public.accident_card_id_seq
	INCREMENT BY 1
	MINVALUE -2147483648
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --

-- object: public.notification_coupon_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.notification_coupon_id_seq CASCADE;
CREATE SEQUENCE public.notification_coupon_id_seq
	INCREMENT BY 1
	MINVALUE -2147483648
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --

-- object: public.prevention_receipt_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.prevention_receipt_id_seq CASCADE;
CREATE SEQUENCE public.prevention_receipt_id_seq
	INCREMENT BY 1
	MINVALUE -2147483648
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --

-- object: public.position_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.position_id_seq CASCADE;
CREATE SEQUENCE public.position_id_seq
	INCREMENT BY 1
	MINVALUE -2147483648
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --

-- object: public.employee_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.employee_id_seq CASCADE;
CREATE SEQUENCE public.employee_id_seq
	INCREMENT BY 1
	MINVALUE -2147483648
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --

-- object: public.employee | type: TABLE --
-- DROP TABLE IF EXISTS public.employee CASCADE;
CREATE TABLE public.employee (
	id integer NOT NULL DEFAULT nextval('public.employee_id_seq'::regclass),
	full_name varchar(255) NOT NULL,
	date_of_birth date NOT NULL,
	passport_numbrer integer NOT NULL,
	id_position integer NOT NULL,
	CONSTRAINT employee_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.employee OWNER TO ktxzkfkposkdiy;
-- ddl-end --

-- object: public.car_owner | type: TABLE --
-- DROP TABLE IF EXISTS public.car_owner CASCADE;
CREATE TABLE public.car_owner (
	id integer NOT NULL DEFAULT nextval('public.car_owner_id_seq'::regclass),
	full_name varchar(255) NOT NULL,
	date_of_birth date NOT NULL,
	passport_number integer NOT NULL,
	CONSTRAINT car_owner_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.car_owner OWNER TO ktxzkfkposkdiy;
-- ddl-end --

-- object: public."position" | type: TABLE --
-- DROP TABLE IF EXISTS public."position" CASCADE;
CREATE TABLE public."position" (
	id integer NOT NULL DEFAULT nextval('public.position_id_seq'::regclass),
	code integer NOT NULL,
	name varchar(255) NOT NULL,
	CONSTRAINT position_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public."position" OWNER TO ktxzkfkposkdiy;
-- ddl-end --

-- object: public.registration_application | type: TABLE --
-- DROP TABLE IF EXISTS public.registration_application CASCADE;
CREATE TABLE public.registration_application (
	id integer NOT NULL DEFAULT nextval('public.registration_application_id_seq'::regclass),
	receipt_number integer NOT NULL,
	brief_info text NOT NULL,
	appliance_date date NOT NULL,
	status integer NOT NULL,
	id_car_owner integer NOT NULL,
	id_vehicle integer NOT NULL,
	id_employee integer NOT NULL,
	CONSTRAINT registration_application_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.registration_application OWNER TO ktxzkfkposkdiy;
-- ddl-end --

-- object: public.registration_certificate | type: TABLE --
-- DROP TABLE IF EXISTS public.registration_certificate CASCADE;
CREATE TABLE public.registration_certificate (
	id integer NOT NULL DEFAULT nextval('public.registration_certificate_id_seq'::regclass),
	registration_number integer NOT NULL,
	registration_date date NOT NULL,
	id_employee integer NOT NULL,
	id_car_owner integer NOT NULL,
	id_registration_application integer NOT NULL,
	CONSTRAINT registration_certificate_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.registration_certificate OWNER TO ktxzkfkposkdiy;
-- ddl-end --

-- object: car_owner_fk | type: CONSTRAINT --
-- ALTER TABLE public.registration_certificate DROP CONSTRAINT IF EXISTS car_owner_fk CASCADE;
ALTER TABLE public.registration_certificate ADD CONSTRAINT car_owner_fk FOREIGN KEY (id_car_owner)
REFERENCES public.car_owner (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: public.insurance_policy | type: TABLE --
-- DROP TABLE IF EXISTS public.insurance_policy CASCADE;
CREATE TABLE public.insurance_policy (
	id integer NOT NULL DEFAULT nextval('public.insurance_policy_id_seq'::regclass),
	insurance_start date NOT NULL,
	insurance_end date NOT NULL,
	id_car_owner integer NOT NULL,
	id_vehicle integer NOT NULL,
	CONSTRAINT insurance_policy_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.insurance_policy OWNER TO ktxzkfkposkdiy;
-- ddl-end --

-- object: public.vehicle_passport | type: TABLE --
-- DROP TABLE IF EXISTS public.vehicle_passport CASCADE;
CREATE TABLE public.vehicle_passport (
	id integer NOT NULL DEFAULT nextval('public.vehicle_passport_id_seq'::regclass),
	identification_number integer NOT NULL,
	car_category varchar(255) NOT NULL,
	car_type varchar(255) NOT NULL,
	chassis_number integer NOT NULL,
	body_number integer NOT NULL,
	engine_power integer NOT NULL,
	own_weight integer NOT NULL,
	allowed_mass integer NOT NULL,
	issue_year smallint NOT NULL,
	ecology_class varchar(255) NOT NULL,
	id_vehicle integer NOT NULL,
	CONSTRAINT vehicle_passport_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.vehicle_passport OWNER TO ktxzkfkposkdiy;
-- ddl-end --

-- object: car_owner_fk | type: CONSTRAINT --
-- ALTER TABLE public.insurance_policy DROP CONSTRAINT IF EXISTS car_owner_fk CASCADE;
ALTER TABLE public.insurance_policy ADD CONSTRAINT car_owner_fk FOREIGN KEY (id_car_owner)
REFERENCES public.car_owner (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: public.theft_statement | type: TABLE --
-- DROP TABLE IF EXISTS public.theft_statement CASCADE;
CREATE TABLE public.theft_statement (
	id integer NOT NULL DEFAULT nextval('public.theft_statement_id_seq'::regclass),
	brief_info text NOT NULL,
	detailed_info text NOT NULL,
	appliance_date date NOT NULL,
	status integer NOT NULL,
	id_car_owner integer,
	id_vehicle integer NOT NULL,
	id_employee integer NOT NULL,
	CONSTRAINT theft_statement_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.theft_statement OWNER TO ktxzkfkposkdiy;
-- ddl-end --

-- object: public.accident_participants_id_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.accident_participants_id_seq CASCADE;
CREATE SEQUENCE public.accident_participants_id_seq
	INCREMENT BY 1
	MINVALUE -2147483648
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --

-- object: public.vehicle | type: TABLE --
-- DROP TABLE IF EXISTS public.vehicle CASCADE;
CREATE TABLE public.vehicle (
	id integer NOT NULL DEFAULT nextval('public.accident_participant_id_seq'::regclass),
	register_sign varchar(255) NOT NULL,
	car_model varchar(255) NOT NULL,
	color varchar(255) NOT NULL,
	id_car_owner integer NOT NULL,
	CONSTRAINT accident_participant_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.vehicle OWNER TO ktxzkfkposkdiy;
-- ddl-end --

-- object: public.accident_card | type: TABLE --
-- DROP TABLE IF EXISTS public.accident_card CASCADE;
CREATE TABLE public.accident_card (
	id integer NOT NULL DEFAULT nextval('public.accident_card_id_seq'::regclass),
	issue_date date NOT NULL,
	reason text NOT NULL,
	accident_type text NOT NULL,
	details text NOT NULL,
	id_employee integer NOT NULL,
	CONSTRAINT accident_card_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.accident_card OWNER TO ktxzkfkposkdiy;
-- ddl-end --

-- object: employee_fk | type: CONSTRAINT --
-- ALTER TABLE public.accident_card DROP CONSTRAINT IF EXISTS employee_fk CASCADE;
ALTER TABLE public.accident_card ADD CONSTRAINT employee_fk FOREIGN KEY (id_employee)
REFERENCES public.employee (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: public.accident_participants | type: TABLE --
-- DROP TABLE IF EXISTS public.accident_participants CASCADE;
CREATE TABLE public.accident_participants (
	id integer NOT NULL DEFAULT nextval('public.accident_participants_id_seq'::regclass),
	id_vehicle integer NOT NULL,
	id_accident_card integer NOT NULL,
	CONSTRAINT accident_participants_pk PRIMARY KEY (id,id_accident_card)

);
-- ddl-end --
ALTER TABLE public.accident_participants OWNER TO ktxzkfkposkdiy;
-- ddl-end --

-- object: vehicle_fk | type: CONSTRAINT --
-- ALTER TABLE public.accident_participants DROP CONSTRAINT IF EXISTS vehicle_fk CASCADE;
ALTER TABLE public.accident_participants ADD CONSTRAINT vehicle_fk FOREIGN KEY (id_vehicle)
REFERENCES public.vehicle (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: position_fk | type: CONSTRAINT --
-- ALTER TABLE public.employee DROP CONSTRAINT IF EXISTS position_fk CASCADE;
ALTER TABLE public.employee ADD CONSTRAINT position_fk FOREIGN KEY (id_position)
REFERENCES public."position" (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: car_owner_fk | type: CONSTRAINT --
-- ALTER TABLE public.theft_statement DROP CONSTRAINT IF EXISTS car_owner_fk CASCADE;
ALTER TABLE public.theft_statement ADD CONSTRAINT car_owner_fk FOREIGN KEY (id_car_owner)
REFERENCES public.car_owner (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: accident_card_fk | type: CONSTRAINT --
-- ALTER TABLE public.accident_participants DROP CONSTRAINT IF EXISTS accident_card_fk CASCADE;
ALTER TABLE public.accident_participants ADD CONSTRAINT accident_card_fk FOREIGN KEY (id_accident_card)
REFERENCES public.accident_card (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: employee_fk | type: CONSTRAINT --
-- ALTER TABLE public.registration_certificate DROP CONSTRAINT IF EXISTS employee_fk CASCADE;
ALTER TABLE public.registration_certificate ADD CONSTRAINT employee_fk FOREIGN KEY (id_employee)
REFERENCES public.employee (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: car_owner_fk | type: CONSTRAINT --
-- ALTER TABLE public.registration_application DROP CONSTRAINT IF EXISTS car_owner_fk CASCADE;
ALTER TABLE public.registration_application ADD CONSTRAINT car_owner_fk FOREIGN KEY (id_car_owner)
REFERENCES public.car_owner (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: registration_application_fk | type: CONSTRAINT --
-- ALTER TABLE public.registration_certificate DROP CONSTRAINT IF EXISTS registration_application_fk CASCADE;
ALTER TABLE public.registration_certificate ADD CONSTRAINT registration_application_fk FOREIGN KEY (id_registration_application)
REFERENCES public.registration_application (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: registration_certificate_uq | type: CONSTRAINT --
-- ALTER TABLE public.registration_certificate DROP CONSTRAINT IF EXISTS registration_certificate_uq CASCADE;
ALTER TABLE public.registration_certificate ADD CONSTRAINT registration_certificate_uq UNIQUE (id_registration_application);
-- ddl-end --

-- object: public.credentials | type: TABLE --
-- DROP TABLE IF EXISTS public.credentials CASCADE;
CREATE TABLE public.credentials (
	id integer NOT NULL,
	login varchar(255) NOT NULL,
	password varchar(255) NOT NULL,
	id_employee integer NOT NULL,
	CONSTRAINT login_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.credentials OWNER TO ktxzkfkposkdiy;
-- ddl-end --

-- object: employee_fk | type: CONSTRAINT --
-- ALTER TABLE public.credentials DROP CONSTRAINT IF EXISTS employee_fk CASCADE;
ALTER TABLE public.credentials ADD CONSTRAINT employee_fk FOREIGN KEY (id_employee)
REFERENCES public.employee (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: credentials_uq | type: CONSTRAINT --
-- ALTER TABLE public.credentials DROP CONSTRAINT IF EXISTS credentials_uq CASCADE;
ALTER TABLE public.credentials ADD CONSTRAINT credentials_uq UNIQUE (id_employee);
-- ddl-end --

-- object: vehicle_fk | type: CONSTRAINT --
-- ALTER TABLE public.insurance_policy DROP CONSTRAINT IF EXISTS vehicle_fk CASCADE;
ALTER TABLE public.insurance_policy ADD CONSTRAINT vehicle_fk FOREIGN KEY (id_vehicle)
REFERENCES public.vehicle (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: vehicle_fk | type: CONSTRAINT --
-- ALTER TABLE public.vehicle_passport DROP CONSTRAINT IF EXISTS vehicle_fk CASCADE;
ALTER TABLE public.vehicle_passport ADD CONSTRAINT vehicle_fk FOREIGN KEY (id_vehicle)
REFERENCES public.vehicle (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: car_owner_fk | type: CONSTRAINT --
-- ALTER TABLE public.vehicle DROP CONSTRAINT IF EXISTS car_owner_fk CASCADE;
ALTER TABLE public.vehicle ADD CONSTRAINT car_owner_fk FOREIGN KEY (id_car_owner)
REFERENCES public.car_owner (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: vehicle_fk | type: CONSTRAINT --
-- ALTER TABLE public.theft_statement DROP CONSTRAINT IF EXISTS vehicle_fk CASCADE;
ALTER TABLE public.theft_statement ADD CONSTRAINT vehicle_fk FOREIGN KEY (id_vehicle)
REFERENCES public.vehicle (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: vehicle_fk | type: CONSTRAINT --
-- ALTER TABLE public.registration_application DROP CONSTRAINT IF EXISTS vehicle_fk CASCADE;
ALTER TABLE public.registration_application ADD CONSTRAINT vehicle_fk FOREIGN KEY (id_vehicle)
REFERENCES public.vehicle (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: employee_fk | type: CONSTRAINT --
-- ALTER TABLE public.registration_application DROP CONSTRAINT IF EXISTS employee_fk CASCADE;
ALTER TABLE public.registration_application ADD CONSTRAINT employee_fk FOREIGN KEY (id_employee)
REFERENCES public.employee (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: employee_fk | type: CONSTRAINT --
-- ALTER TABLE public.theft_statement DROP CONSTRAINT IF EXISTS employee_fk CASCADE;
ALTER TABLE public.theft_statement ADD CONSTRAINT employee_fk FOREIGN KEY (id_employee)
REFERENCES public.employee (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --



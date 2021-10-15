-- Volcado de tablas basicas

--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 13.4

SET statement_timeout = 0;

SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: tipoamenaza; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.tipoamenaza (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (1, 'PANFLETO', NULL, '2018-11-30', NULL, '2018-12-03 21:25:05.485775', '2018-12-03 21:25:05.485775');
INSERT INTO public.tipoamenaza (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (101, 'ARMA DE FUEGO', '', '2021-05-04', NULL, '2021-05-04 16:37:51.272185', '2021-05-04 16:37:51.272185');
INSERT INTO public.tipoamenaza (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (102, 'ARMA BLANCA', '', '2021-05-04', NULL, '2021-05-04 16:39:28.917971', '2021-05-04 16:39:28.917971');
INSERT INTO public.tipoamenaza (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (103, 'SIGNOS DE TORTURA', '', '2021-05-04', NULL, '2021-05-04 16:40:05.805629', '2021-05-04 16:40:05.805629');
INSERT INTO public.tipoamenaza (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (104, 'MATERIAL EXPLOSIVO', '', '2021-05-04', NULL, '2021-05-04 16:41:05.175976', '2021-05-04 16:41:05.175976');
INSERT INTO public.tipoamenaza (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (105, 'DESAPARICIÓN Y TORTURA', '', '2021-05-04', NULL, '2021-05-04 16:41:31.605898', '2021-05-04 16:41:31.605898');
INSERT INTO public.tipoamenaza (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (106, 'LLAMADA EXTORSIVA Y/O ENGAÑO', '', '2021-05-04', NULL, '2021-05-04 16:42:06.042677', '2021-05-04 16:42:06.042677');
INSERT INTO public.tipoamenaza (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (107, 'HOMICIDO EN PERSONA PROTEGIDA', '', '2021-05-04', NULL, '2021-05-04 16:42:34.642282', '2021-05-04 16:42:34.642282');
INSERT INTO public.tipoamenaza (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (108, 'QUEMADURA QUÍMICA (ATAQUE CON ÁCIDO)', '', '2021-05-04', NULL, '2021-05-04 16:43:28.100235', '2021-05-04 16:43:28.100235');
INSERT INTO public.tipoamenaza (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (109, 'DAÑO BIEN MATERIAL- ANIMAL', '', '2021-05-04', NULL, '2021-05-04 16:43:52.34317', '2021-05-04 16:43:52.34317');
INSERT INTO public.tipoamenaza (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (110, 'GOLPES CON OBJETOS CONTUNDENTES', '', '2021-05-04', NULL, '2021-05-04 16:44:21.879121', '2021-05-04 16:44:21.879121');
INSERT INTO public.tipoamenaza (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (2, 'LLAMADA FIJO/CELULAR', NULL, '2018-11-30', NULL, '2018-12-03 21:25:05.485775', '2018-12-03 21:25:05.485775');
INSERT INTO public.tipoamenaza (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (3, 'CORREO ELECTRÓNICO', NULL, '2018-11-30', NULL, '2018-12-03 21:25:05.485775', '2018-12-03 21:25:05.485775');
INSERT INTO public.tipoamenaza (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (4, 'REDES SOCIALES', NULL, '2018-11-30', NULL, '2018-12-03 21:25:05.485775', '2018-12-03 21:25:05.485775');
INSERT INTO public.tipoamenaza (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (5, 'MENSAJE DE TEXTO', NULL, '2018-11-30', NULL, '2018-12-03 21:25:05.485775', '2018-12-03 21:25:05.485775');
INSERT INTO public.tipoamenaza (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (6, 'ASESINATO-ATENTADO DE FAMILIAR', NULL, '2018-11-30', NULL, '2018-12-03 21:25:05.485775', '2018-12-03 21:25:05.485775');
INSERT INTO public.tipoamenaza (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (7, 'HOSTIGAMIENTO (PERSECUCIÓN PERSONAS EXTRAÑAS - FOTOGRAFÍAS)', NULL, '2018-11-30', NULL, '2018-12-03 21:25:05.485775', '2018-12-03 21:25:05.485775');
INSERT INTO public.tipoamenaza (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (8, 'HOSTIGAMIENTO (AMENAZAS CON ARMA Y/O VERBALES)', NULL, '2018-11-30', NULL, '2018-12-03 21:25:05.485775', '2018-12-03 21:25:05.485775');


--
-- Name: tipoamenaza_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tipoamenaza_id_seq', 110, true);


--
-- PostgreSQL database dump complete
--


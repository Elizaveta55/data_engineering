--
-- PostgreSQL database dump
--

-- Dumped from database version 13.6 (Debian 13.6-1.pgdg110+1)
-- Dumped by pg_dump version 13.4 (Ubuntu 13.4-1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

CREATE TABLE public.big_data_storage (
    user_id bigint,
    user_username character varying,
    user_sex character varying,
    product_id bigint,
    product_name character varying
);

ALTER TABLE public.big_data_storage OWNER TO nifi;

CREATE TABLE public.products (
    id bigint NOT NULL,
    name character varying NOT NULL,
    owner character varying
);


ALTER TABLE public.products OWNER TO nifi;

CREATE SEQUENCE public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO nifi;

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;

CREATE TABLE public.users (
    id bigint NOT NULL,
    username character varying NOT NULL,
    name character varying,
    sex character varying,
    address character varying,
    mail character varying NOT NULL
);


ALTER TABLE public.users OWNER TO nifi;

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO nifi;

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);

COPY public.big_data_storage (user_id, user_username, user_sex, product_id, product_name) FROM stdin;
2	allanit	M	10	Milk 3.2
1	andrey	M	1	Apples Golden
1	andrey	M	6	Whiskas, 100g
2	allanit	M	4	Cake, BreadCom
4	diana	M	3	Tomates Red
2	allanit	M	6	Whiskas, 100g
\.

COPY public.products (id, name, owner) FROM stdin;
1	Apples Golden	Producer1
2	Spring Water	Producer1
3	Tomates Red	Producer1
4	Cake, BreadCom	Producer2
5	Towel	Producer2
6	Whiskas, 100g	Producer3
7	Gum	Producer4
8	Water	Producer4
9	Ice	Producer4
10	Milk 3.2	Producer5
\.

COPY public.users (id, username, name, sex, address, mail) FROM stdin;
1	andrey	Andrey Svyat	M	Moscow	andrey@mail.com
2	allanit	Alla Netuch	M	Moscow	allanit@mail.com
3	ololoev	Akakiy Stain	M	Moscow	ololo@mail.com
4	diana	Diana London	M	Moscow	diana@mail.com
5	lala	JayDee	M	Moscow	lala@mail.com
\.

SELECT pg_catalog.setval('public.products_id_seq', 10, true);

SELECT pg_catalog.setval('public.users_id_seq', 5, true);

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);

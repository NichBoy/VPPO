
CREATE DATABASE "BoardGames"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Russian_Russia.1251'
    LC_CTYPE = 'Russian_Russia.1251'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

    CREATE TABLE IF NOT EXISTS public.author
(
    id_author bigint NOT NULL,
    name_author character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT author_pkey PRIMARY KEY (id_author)
)


	CREATE TABLE IF NOT EXISTS public.country
(
    id_country bigint NOT NULL,
    name_country character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT country_pkey PRIMARY KEY (id_country)
)


	CREATE TABLE IF NOT EXISTS public.genre
(
    id_genre bigint NOT NULL,
    name_genre character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT genre_pkey PRIMARY KEY (id_genre)
)

	CREATE TABLE IF NOT EXISTS public.manufacturer
(
    id_manufacturer bigint NOT NULL,
    name_genre character varying(50) COLLATE pg_catalog."default",
    year_manufacturer integer NOT NULL,
    id_country bigint,
    CONSTRAINT manufacturer_pkey PRIMARY KEY (id_manufacturer),
    CONSTRAINT fks4p4eftcxvj7s1ljl7t86lu6d FOREIGN KEY (id_country)
        REFERENCES public.country (id_country) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT manufacturer_year_manufacturer_check CHECK (year_manufacturer >= 1900 AND year_manufacturer <= 2023)
)


	CREATE TABLE IF NOT EXISTS public.model_user
(
    id_user bigint NOT NULL DEFAULT nextval('model_user_id_user_seq'::regclass),
    active boolean NOT NULL,
    password character varying(255) COLLATE pg_catalog."default",
    username character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT model_user_pkey PRIMARY KEY (id_user)
)

	CREATE TABLE IF NOT EXISTS public.user_role
(
    user_id bigint NOT NULL,
    roles character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT fkhnk3nw6rsvkly3ww7umdq7ys1 FOREIGN KEY (user_id)
        REFERENCES public.model_user (id_user) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)


	CREATE TABLE IF NOT EXISTS public.status
(
    id_status bigint NOT NULL,
    name_status character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT status_pkey PRIMARY KEY (id_status)
)

	CREATE TABLE IF NOT EXISTS public.indent
(
    id_indent bigint NOT NULL,
    price_indent integer NOT NULL,
    id_status bigint,
    id_user bigint,
    CONSTRAINT indent_pkey PRIMARY KEY (id_indent),
    CONSTRAINT fk2ci4cvwlomxtmw60klpcxgn3u FOREIGN KEY (id_user)
        REFERENCES public.model_user (id_user) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk8rske5d66t62qluvmbtbavbou FOREIGN KEY (id_status)
        REFERENCES public.status (id_status) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT indent_price_indent_check CHECK (price_indent <= 100000 AND price_indent >= 0)
)

	CREATE TABLE IF NOT EXISTS public.game
(
    id_game bigint NOT NULL,
    max_players_game integer NOT NULL,
    min_players_game integer NOT NULL,
    name character varying(50) COLLATE pg_catalog."default",
    price_game integer NOT NULL,
    time_game integer NOT NULL,
    year_game integer NOT NULL,
    id_author bigint,
    id_genre bigint,
    id_manufacturer bigint,
    CONSTRAINT game_pkey PRIMARY KEY (id_game),
    CONSTRAINT fk162hcav37v2ya1nedaxvasiux FOREIGN KEY (id_author)
        REFERENCES public.author (id_author) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkb0b08j92jk2g4g6je297hjmu0 FOREIGN KEY (id_genre)
        REFERENCES public.genre (id_genre) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fks8uffdi71klgdqguvkjxkjvb9 FOREIGN KEY (id_manufacturer)
        REFERENCES public.manufacturer (id_manufacturer) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT game_max_players_game_check CHECK (max_players_game >= 1 AND max_players_game <= 50),
    CONSTRAINT game_min_players_game_check CHECK (min_players_game >= 1 AND min_players_game <= 10),
    CONSTRAINT game_price_game_check CHECK (price_game <= 100000 AND price_game >= 1),
    CONSTRAINT game_time_game_check CHECK (time_game <= 1000 AND time_game >= 5),
    CONSTRAINT game_year_game_check CHECK (year_game <= 2023 AND year_game >= 2000)
)

	CREATE TABLE IF NOT EXISTS public.indent_game
(
    indent_id bigint NOT NULL,
    game_id bigint NOT NULL,
    CONSTRAINT fkrt111c475fbgqqgrc33e874qj FOREIGN KEY (indent_id)
        REFERENCES public.indent (id_indent) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkstkvejbjl11plvxq8bc3hoe26 FOREIGN KEY (game_id)
        REFERENCES public.game (id_game) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
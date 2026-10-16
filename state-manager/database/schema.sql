/* SQLModel tables are the source of truth for database schema */
CREATE TABLE aro_users.auth_tokens (
    id uuid NOT NULL,
    user_id uuid CONSTRAINT auth_tokens_user_data_id_not_null NOT NULL,
    created_on timestamp with time zone NOT NULL,
    expiry timestamp with time zone NOT NULL,
    family_id uuid NOT NULL,
    token_hash character varying NOT NULL,
    rotated_at timestamp with time zone,
    revoked_at timestamp with time zone
);

CREATE TABLE aro_users.callsigns (
    call_sign character varying(6) NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    personal_address character varying(255),
    personal_city character varying(255),
    personal_province character varying(255),
    personal_postal_code character varying(255),
    qual_level_a boolean NOT NULL,
    qual_level_b boolean NOT NULL,
    qual_level_c boolean NOT NULL,
    qual_level_d boolean NOT NULL,
    qual_level_e boolean NOT NULL,
    club_name character varying(255),
    second_club_name character varying(255),
    club_address character varying(255),
    club_city character varying(255),
    club_province character varying(255),
    club_postal_code character varying(255)
);

CREATE TABLE aro_users.user_login (
    id uuid NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(128) NOT NULL,
    created_on timestamp with time zone NOT NULL,
    user_id uuid CONSTRAINT user_login_user_data_id_not_null NOT NULL
);

CREATE TABLE aro_users.users_data (
    id uuid NOT NULL,
    call_sign character varying(6),
    email character varying(255) NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255),
    phone_number character varying,
    is_callsign_verified boolean NOT NULL,
    is_active boolean NOT NULL,
    is_superuser boolean NOT NULL
);

CREATE TABLE main.commands (
    id integer NOT NULL,
    name character varying NOT NULL,
    params character varying,
    format character varying,
    data_size integer NOT NULL,
    total_size integer NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    CONSTRAINT ck_main_commands_data_size_ge_0 CHECK ((data_size >= 0))
);

CREATE SEQUENCE main.commands_id_seq AS integer START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

ALTER SEQUENCE main.commands_id_seq OWNED BY main.commands.id;

CREATE TABLE main.telemetry (
    id integer NOT NULL,
    name character varying NOT NULL,
    format character varying,
    data_size integer NOT NULL,
    total_size integer NOT NULL
);

CREATE SEQUENCE main.telemetry_id_seq AS integer START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

ALTER SEQUENCE main.telemetry_id_seq OWNED BY main.telemetry.id;

CREATE TABLE mcc_users.users_data (
    id uuid NOT NULL,
    email character varying(255) NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    phone_number character varying
);

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL");
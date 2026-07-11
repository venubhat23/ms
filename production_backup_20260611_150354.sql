--
-- PostgreSQL database dump
--

\restrict VsnpeZiR1W4hR2nVAenHFUW7FqMvnzKrhtoyp5iAHaAaIemNDWxI2hQLgx3xfgt

-- Dumped from database version 18.3 (Debian 18.3-1.pgdg12+1)
-- Dumped by pg_dump version 18.3 (Ubuntu 18.3-1.pgdg24.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: marlai_santhe_002_user
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO marlai_santhe_002_user;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: active_storage_attachments; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.active_storage_attachments (
    id bigint NOT NULL,
    name character varying NOT NULL,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    blob_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.active_storage_attachments OWNER TO marlai_santhe_002_user;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.active_storage_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.active_storage_attachments_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.active_storage_attachments_id_seq OWNED BY public.active_storage_attachments.id;


--
-- Name: active_storage_blobs; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.active_storage_blobs (
    id bigint NOT NULL,
    key character varying NOT NULL,
    filename character varying NOT NULL,
    content_type character varying,
    metadata text,
    service_name character varying NOT NULL,
    byte_size bigint NOT NULL,
    checksum character varying,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.active_storage_blobs OWNER TO marlai_santhe_002_user;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.active_storage_blobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.active_storage_blobs_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.active_storage_blobs_id_seq OWNED BY public.active_storage_blobs.id;


--
-- Name: active_storage_variant_records; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.active_storage_variant_records (
    id bigint NOT NULL,
    blob_id bigint NOT NULL,
    variation_digest character varying NOT NULL
);


ALTER TABLE public.active_storage_variant_records OWNER TO marlai_santhe_002_user;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.active_storage_variant_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNED BY public.active_storage_variant_records.id;


--
-- Name: affiliates; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.affiliates (
    id bigint NOT NULL,
    first_name character varying,
    last_name character varying,
    middle_name character varying,
    email character varying,
    mobile character varying,
    address text,
    city character varying,
    state character varying,
    pincode character varying,
    pan_no character varying,
    gst_no character varying,
    commission_percentage numeric(5,2),
    bank_name character varying,
    account_no character varying,
    ifsc_code character varying,
    account_holder_name character varying,
    account_type character varying,
    upi_id character varying,
    status boolean DEFAULT true,
    notes text,
    auto_generated_password character varying,
    joining_date date,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    company_name character varying,
    username character varying
);


ALTER TABLE public.affiliates OWNER TO marlai_santhe_002_user;

--
-- Name: affiliates_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.affiliates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.affiliates_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: affiliates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.affiliates_id_seq OWNED BY public.affiliates.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO marlai_santhe_002_user;

--
-- Name: banners; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.banners (
    id bigint NOT NULL,
    title character varying,
    description text,
    redirect_link character varying,
    display_start_date date,
    display_end_date date,
    display_location character varying,
    status boolean DEFAULT true,
    display_order integer DEFAULT 0,
    image character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    image_url character varying,
    r2_image_url character varying
);


ALTER TABLE public.banners OWNER TO marlai_santhe_002_user;

--
-- Name: banners_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.banners_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.banners_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: banners_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.banners_id_seq OWNED BY public.banners.id;


--
-- Name: booking_invoices; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.booking_invoices (
    id bigint NOT NULL,
    booking_id bigint NOT NULL,
    customer_id bigint,
    invoice_number character varying,
    invoice_date timestamp(6) without time zone,
    due_date timestamp(6) without time zone,
    subtotal numeric(10,2),
    tax_amount numeric(10,2),
    discount_amount numeric(10,2),
    total_amount numeric(10,2),
    payment_status integer,
    status integer,
    notes text,
    invoice_items text,
    paid_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    share_token character varying
);


ALTER TABLE public.booking_invoices OWNER TO marlai_santhe_002_user;

--
-- Name: booking_invoices_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.booking_invoices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.booking_invoices_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: booking_invoices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.booking_invoices_id_seq OWNED BY public.booking_invoices.id;


--
-- Name: booking_items; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.booking_items (
    id bigint NOT NULL,
    booking_id integer,
    product_id integer,
    quantity numeric(8,2),
    price numeric,
    total numeric,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    product_variant_id bigint
);


ALTER TABLE public.booking_items OWNER TO marlai_santhe_002_user;

--
-- Name: booking_items_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.booking_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.booking_items_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: booking_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.booking_items_id_seq OWNED BY public.booking_items.id;


--
-- Name: booking_schedules; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.booking_schedules (
    id bigint NOT NULL,
    customer_id bigint NOT NULL,
    product_id bigint NOT NULL,
    schedule_type character varying,
    frequency character varying,
    start_date date,
    end_date date,
    quantity integer,
    delivery_time time without time zone,
    delivery_address text,
    pincode character varying,
    latitude numeric,
    longitude numeric,
    status character varying,
    next_booking_date date,
    total_bookings_generated integer,
    notes text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.booking_schedules OWNER TO marlai_santhe_002_user;

--
-- Name: booking_schedules_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.booking_schedules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.booking_schedules_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: booking_schedules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.booking_schedules_id_seq OWNED BY public.booking_schedules.id;


--
-- Name: bookings; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.bookings (
    id bigint NOT NULL,
    customer_id integer,
    user_id integer,
    booking_number character varying,
    booking_date timestamp(6) without time zone,
    status character varying,
    payment_method character varying,
    payment_status character varying,
    subtotal numeric,
    tax_amount numeric,
    discount_amount numeric,
    total_amount numeric,
    notes text,
    booking_items text,
    customer_name character varying,
    customer_email character varying,
    customer_phone character varying,
    delivery_address text,
    invoice_generated boolean,
    invoice_number character varying,
    cash_received numeric,
    change_amount numeric,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    booking_schedule_id bigint,
    stage character varying,
    courier_service character varying,
    tracking_number character varying,
    shipping_charges numeric(10,2),
    expected_delivery_date date,
    delivery_person character varying,
    delivery_contact character varying,
    delivered_to character varying,
    delivery_time timestamp(6) without time zone,
    customer_satisfaction integer,
    processing_team character varying,
    expected_completion_time timestamp(6) without time zone,
    estimated_processing_time character varying,
    estimated_delivery_time character varying,
    package_weight numeric(8,2),
    package_dimensions character varying,
    quality_status character varying,
    cancellation_reason character varying,
    return_reason character varying,
    return_condition character varying,
    refund_amount numeric(10,2),
    refund_method character varying,
    transition_notes text,
    stage_history text,
    stage_updated_at timestamp(6) without time zone,
    stage_updated_by integer,
    store_id bigint,
    subscription_id integer,
    is_subscription boolean,
    final_amount_after_discount numeric,
    delivery_person_id bigint,
    franchise_id bigint,
    quick_invoice boolean DEFAULT false,
    booked_by character varying DEFAULT 'admin'::character varying,
    selected_shop_address text,
    delivery_store text,
    cashfree_order_id character varying,
    payment_session_id character varying,
    cashfree_payment_id character varying,
    gateway_response text,
    payment_gateway character varying DEFAULT 'cash'::character varying,
    payment_initiated_at timestamp(6) without time zone,
    payment_completed_at timestamp(6) without time zone,
    is_b2b boolean DEFAULT false NOT NULL
);


ALTER TABLE public.bookings OWNER TO marlai_santhe_002_user;

--
-- Name: bookings_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.bookings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bookings_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: bookings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.bookings_id_seq OWNED BY public.bookings.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    name character varying NOT NULL,
    description text,
    image character varying,
    status boolean DEFAULT true,
    display_order integer DEFAULT 0,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    image_backup_url character varying
);


ALTER TABLE public.categories OWNER TO marlai_santhe_002_user;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: client_requests; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.client_requests (
    id bigint NOT NULL,
    title character varying,
    description text,
    status character varying DEFAULT 'pending'::character varying,
    priority character varying DEFAULT 'medium'::character varying,
    customer_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    stage character varying DEFAULT 'new'::character varying,
    stage_updated_at timestamp(6) without time zone,
    stage_history text,
    assignee_id integer,
    department character varying,
    estimated_resolution_time timestamp(6) without time zone,
    actual_resolution_time timestamp(6) without time zone,
    name character varying,
    email character varying,
    phone_number character varying,
    ticket_number character varying,
    admin_response text,
    resolved_by_id integer,
    submitted_at timestamp(6) without time zone,
    resolved_at timestamp(6) without time zone
);


ALTER TABLE public.client_requests OWNER TO marlai_santhe_002_user;

--
-- Name: client_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.client_requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.client_requests_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: client_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.client_requests_id_seq OWNED BY public.client_requests.id;


--
-- Name: coupons; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.coupons (
    id bigint NOT NULL,
    code character varying,
    description text,
    discount_type character varying,
    discount_value numeric,
    minimum_amount numeric,
    maximum_discount numeric,
    usage_limit integer,
    used_count integer,
    valid_from timestamp(6) without time zone,
    valid_until timestamp(6) without time zone,
    status boolean,
    applicable_products text,
    applicable_categories text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.coupons OWNER TO marlai_santhe_002_user;

--
-- Name: coupons_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.coupons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.coupons_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: coupons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.coupons_id_seq OWNED BY public.coupons.id;


--
-- Name: customer_addresses; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.customer_addresses (
    id bigint NOT NULL,
    customer_id bigint NOT NULL,
    name character varying,
    mobile character varying,
    address_type character varying,
    address text,
    landmark character varying,
    city character varying,
    state character varying,
    pincode character varying,
    latitude numeric,
    longitude numeric,
    is_default boolean,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.customer_addresses OWNER TO marlai_santhe_002_user;

--
-- Name: customer_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.customer_addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customer_addresses_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: customer_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.customer_addresses_id_seq OWNED BY public.customer_addresses.id;


--
-- Name: customer_formats; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.customer_formats (
    id bigint NOT NULL,
    customer_id bigint NOT NULL,
    pattern character varying,
    quantity numeric,
    product_id bigint NOT NULL,
    delivery_person_id bigint NOT NULL,
    status character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    days text
);


ALTER TABLE public.customer_formats OWNER TO marlai_santhe_002_user;

--
-- Name: customer_formats_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.customer_formats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customer_formats_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: customer_formats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.customer_formats_id_seq OWNED BY public.customer_formats.id;


--
-- Name: customer_wallets; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.customer_wallets (
    id bigint NOT NULL,
    customer_id bigint NOT NULL,
    balance numeric(10,2) DEFAULT 0.0,
    status boolean DEFAULT true,
    notes text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.customer_wallets OWNER TO marlai_santhe_002_user;

--
-- Name: customer_wallets_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.customer_wallets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customer_wallets_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: customer_wallets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.customer_wallets_id_seq OWNED BY public.customer_wallets.id;


--
-- Name: customers; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.customers (
    id bigint NOT NULL,
    first_name character varying,
    last_name character varying,
    email character varying,
    mobile character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    longitude numeric(10,8),
    latitude numeric(10,8),
    whatsapp_number character varying,
    auto_generated_password character varying,
    location_obtained_at timestamp(6) without time zone,
    location_accuracy numeric(8,2),
    password_digest character varying,
    middle_name character varying,
    address text,
    birth_date date,
    gender character varying,
    marital_status character varying,
    pan_no character varying,
    gst_no character varying,
    company_name character varying,
    occupation character varying,
    annual_income numeric,
    emergency_contact_name character varying,
    emergency_contact_number character varying,
    blood_group character varying,
    nationality character varying,
    preferred_language character varying,
    notes text,
    status boolean DEFAULT true NOT NULL,
    is_registered_by_mobile boolean,
    password_reset_token character varying,
    password_reset_sent_at timestamp(6) without time zone
);


ALTER TABLE public.customers OWNER TO marlai_santhe_002_user;

--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.customers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customers_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;


--
-- Name: delivery_charges; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.delivery_charges (
    id bigint NOT NULL,
    pincode character varying NOT NULL,
    area character varying,
    charge_amount numeric(10,2) DEFAULT 0.0,
    is_active boolean DEFAULT true,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    free_delivery_allowed boolean DEFAULT false NOT NULL,
    min_order_for_free_delivery numeric(10,2) DEFAULT 0.0
);


ALTER TABLE public.delivery_charges OWNER TO marlai_santhe_002_user;

--
-- Name: delivery_charges_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.delivery_charges_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.delivery_charges_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: delivery_charges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.delivery_charges_id_seq OWNED BY public.delivery_charges.id;


--
-- Name: delivery_people; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.delivery_people (
    id bigint NOT NULL,
    first_name character varying,
    last_name character varying,
    email character varying,
    mobile character varying,
    vehicle_type character varying,
    vehicle_number character varying,
    license_number character varying,
    address text,
    city character varying,
    state character varying,
    pincode character varying,
    emergency_contact_name character varying,
    emergency_contact_mobile character varying,
    joining_date date,
    salary numeric,
    status boolean,
    profile_picture character varying,
    bank_name character varying,
    account_no character varying,
    ifsc_code character varying,
    account_holder_name character varying,
    delivery_areas text,
    notes text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    password_digest character varying,
    auto_generated_password character varying
);


ALTER TABLE public.delivery_people OWNER TO marlai_santhe_002_user;

--
-- Name: delivery_people_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.delivery_people_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.delivery_people_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: delivery_people_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.delivery_people_id_seq OWNED BY public.delivery_people.id;


--
-- Name: delivery_rules; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.delivery_rules (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    rule_type character varying NOT NULL,
    location_data text,
    is_excluded boolean DEFAULT false,
    delivery_days integer,
    delivery_charge numeric(8,2) DEFAULT 0.0,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.delivery_rules OWNER TO marlai_santhe_002_user;

--
-- Name: delivery_rules_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.delivery_rules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.delivery_rules_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: delivery_rules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.delivery_rules_id_seq OWNED BY public.delivery_rules.id;


--
-- Name: device_tokens; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.device_tokens (
    id bigint NOT NULL,
    customer_id bigint NOT NULL,
    delivery_person_id bigint NOT NULL,
    token character varying,
    device_type character varying,
    active boolean,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.device_tokens OWNER TO marlai_santhe_002_user;

--
-- Name: device_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.device_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.device_tokens_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: device_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.device_tokens_id_seq OWNED BY public.device_tokens.id;


--
-- Name: expenses; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.expenses (
    id bigint NOT NULL,
    store_id bigint NOT NULL,
    created_by_id bigint NOT NULL,
    title character varying NOT NULL,
    description text,
    amount numeric(10,2) NOT NULL,
    category character varying NOT NULL,
    expense_date date NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.expenses OWNER TO marlai_santhe_002_user;

--
-- Name: expenses_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.expenses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.expenses_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: expenses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.expenses_id_seq OWNED BY public.expenses.id;


--
-- Name: franchises; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.franchises (
    id bigint NOT NULL,
    name character varying,
    email character varying,
    mobile character varying,
    contact_person_name character varying,
    business_type character varying,
    address text,
    city character varying,
    state character varying,
    pincode character varying,
    pan_no character varying,
    gst_no character varying,
    license_no character varying,
    establishment_date date,
    territory character varying,
    franchise_fee numeric,
    commission_percentage numeric,
    status boolean,
    notes text,
    password_digest character varying,
    auto_generated_password character varying,
    longitude numeric,
    latitude numeric,
    whatsapp_number character varying,
    profile_image character varying,
    business_documents text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    user_id bigint
);


ALTER TABLE public.franchises OWNER TO marlai_santhe_002_user;

--
-- Name: franchises_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.franchises_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.franchises_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: franchises_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.franchises_id_seq OWNED BY public.franchises.id;


--
-- Name: invoice_items; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.invoice_items (
    id bigint NOT NULL,
    invoice_id bigint NOT NULL,
    milk_delivery_task_id bigint,
    description text,
    quantity numeric,
    unit_price numeric,
    total_amount numeric,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    product_id bigint
);


ALTER TABLE public.invoice_items OWNER TO marlai_santhe_002_user;

--
-- Name: invoice_items_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.invoice_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.invoice_items_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: invoice_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.invoice_items_id_seq OWNED BY public.invoice_items.id;


--
-- Name: invoices; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.invoices (
    id bigint NOT NULL,
    invoice_number character varying,
    payout_type character varying,
    payout_id integer,
    total_amount numeric,
    status character varying,
    invoice_date date,
    due_date date,
    paid_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    customer_id integer,
    payment_status integer,
    share_token character varying,
    quick_invoice boolean DEFAULT false,
    paid_amount numeric(10,2) DEFAULT 0.0
);


ALTER TABLE public.invoices OWNER TO marlai_santhe_002_user;

--
-- Name: invoices_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.invoices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.invoices_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: invoices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.invoices_id_seq OWNED BY public.invoices.id;


--
-- Name: leads; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.leads (
    id bigint NOT NULL,
    name character varying,
    contact_number character varying,
    email character varying,
    current_stage character varying,
    lead_source character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    product_category character varying,
    product_subcategory character varying,
    customer_type character varying,
    affiliate_id integer,
    is_direct boolean,
    first_name character varying,
    last_name character varying,
    middle_name character varying,
    company_name character varying,
    gender character varying,
    marital_status character varying,
    pan_no character varying,
    gst_no character varying,
    height numeric,
    weight numeric,
    annual_income numeric,
    business_job character varying
);


ALTER TABLE public.leads OWNER TO marlai_santhe_002_user;

--
-- Name: leads_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.leads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.leads_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: leads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.leads_id_seq OWNED BY public.leads.id;


--
-- Name: milk_delivery_tasks; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.milk_delivery_tasks (
    id bigint NOT NULL,
    subscription_id bigint,
    customer_id bigint NOT NULL,
    product_id bigint NOT NULL,
    quantity numeric(10,2),
    unit character varying,
    delivery_date date,
    delivery_person_id bigint,
    status character varying DEFAULT 'pending'::character varying,
    assigned_at timestamp(6) without time zone,
    completed_at timestamp(6) without time zone,
    delivery_notes text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    invoiced boolean DEFAULT false,
    invoiced_at timestamp(6) without time zone
);


ALTER TABLE public.milk_delivery_tasks OWNER TO marlai_santhe_002_user;

--
-- Name: milk_delivery_tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.milk_delivery_tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.milk_delivery_tasks_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: milk_delivery_tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.milk_delivery_tasks_id_seq OWNED BY public.milk_delivery_tasks.id;


--
-- Name: milk_subscriptions; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.milk_subscriptions (
    id bigint NOT NULL,
    customer_id bigint NOT NULL,
    product_id bigint NOT NULL,
    quantity numeric(10,2),
    unit character varying DEFAULT 'liter'::character varying,
    start_date date,
    end_date date,
    delivery_time character varying DEFAULT 'morning'::character varying,
    delivery_pattern character varying DEFAULT 'daily'::character varying,
    specific_dates text,
    total_amount numeric(10,2),
    status character varying DEFAULT 'active'::character varying,
    is_active boolean DEFAULT true,
    created_by integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    delivery_person_id integer
);


ALTER TABLE public.milk_subscriptions OWNER TO marlai_santhe_002_user;

--
-- Name: milk_subscriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.milk_subscriptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.milk_subscriptions_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: milk_subscriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.milk_subscriptions_id_seq OWNED BY public.milk_subscriptions.id;


--
-- Name: notes; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.notes (
    id bigint NOT NULL,
    title character varying NOT NULL,
    paid_to character varying NOT NULL,
    amount numeric(10,2) NOT NULL,
    payment_method character varying NOT NULL,
    reference_number character varying,
    description text,
    status character varying DEFAULT 'pending'::character varying,
    note_date date DEFAULT CURRENT_DATE NOT NULL,
    created_by_user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    paid_from character varying,
    paid_to_category character varying
);


ALTER TABLE public.notes OWNER TO marlai_santhe_002_user;

--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notes_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.notes_id_seq OWNED BY public.notes.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.notifications (
    id bigint NOT NULL,
    customer_id bigint NOT NULL,
    title character varying,
    message text,
    notification_type character varying,
    data json,
    read boolean,
    read_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.notifications OWNER TO marlai_santhe_002_user;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notifications_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.order_items (
    id bigint NOT NULL,
    order_id integer,
    product_id integer,
    quantity integer,
    price numeric,
    total numeric,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    product_variant_id bigint
);


ALTER TABLE public.order_items OWNER TO marlai_santhe_002_user;

--
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.order_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.orders (
    id bigint NOT NULL,
    customer_id integer,
    user_id integer,
    order_number character varying,
    order_date timestamp(6) without time zone,
    status character varying,
    payment_method character varying,
    payment_status character varying,
    subtotal numeric,
    tax_amount numeric,
    discount_amount numeric,
    shipping_amount numeric,
    total_amount numeric,
    notes text,
    order_items text,
    customer_name character varying,
    customer_email character varying,
    customer_phone character varying,
    delivery_address text,
    tracking_number character varying,
    delivered_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    processing_notes text,
    estimated_processing_time integer,
    processing_started_at timestamp(6) without time zone,
    packed_by character varying,
    package_weight numeric,
    package_dimensions character varying,
    packing_notes text,
    packed_at timestamp(6) without time zone,
    shipping_carrier character varying,
    estimated_delivery_date date,
    shipping_cost numeric,
    shipping_notes text,
    shipped_at timestamp(6) without time zone,
    delivered_to character varying,
    delivery_location character varying,
    delivery_notes text,
    cancelled_at timestamp(6) without time zone,
    cancellation_reason character varying,
    refund_method character varying,
    refund_amount numeric,
    cancellation_notes text,
    invoice_generated boolean DEFAULT false,
    invoice_number character varying,
    cash_received numeric(10,2),
    change_amount numeric(10,2),
    order_stage character varying DEFAULT 'draft'::character varying,
    booking_date timestamp(6) without time zone,
    booking_id integer
);


ALTER TABLE public.orders OWNER TO marlai_santhe_002_user;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: pending_amounts; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.pending_amounts (
    id bigint NOT NULL,
    customer_id bigint NOT NULL,
    amount numeric,
    description text,
    pending_date date,
    status integer,
    notes text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.pending_amounts OWNER TO marlai_santhe_002_user;

--
-- Name: pending_amounts_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.pending_amounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pending_amounts_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: pending_amounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.pending_amounts_id_seq OWNED BY public.pending_amounts.id;


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.permissions (
    id bigint NOT NULL,
    name character varying NOT NULL,
    resource character varying,
    action character varying,
    description text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.permissions OWNER TO marlai_santhe_002_user;

--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.permissions_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;


--
-- Name: product_ratings; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.product_ratings (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    customer_id bigint,
    user_id bigint,
    rating integer NOT NULL,
    comment text,
    status integer DEFAULT 0,
    reviewer_name character varying,
    reviewer_email character varying,
    verified_purchase boolean DEFAULT false,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.product_ratings OWNER TO marlai_santhe_002_user;

--
-- Name: product_ratings_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.product_ratings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_ratings_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: product_ratings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.product_ratings_id_seq OWNED BY public.product_ratings.id;


--
-- Name: product_reviews; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.product_reviews (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    customer_id bigint,
    user_id bigint,
    rating integer NOT NULL,
    comment text,
    reviewer_name character varying,
    reviewer_email character varying,
    status integer DEFAULT 0,
    verified_purchase boolean DEFAULT false,
    helpful_count integer DEFAULT 0,
    pros text,
    cons text,
    title character varying,
    images_data json,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.product_reviews OWNER TO marlai_santhe_002_user;

--
-- Name: product_reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.product_reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_reviews_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: product_reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.product_reviews_id_seq OWNED BY public.product_reviews.id;


--
-- Name: product_variants; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.product_variants (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    weight numeric(8,3) NOT NULL,
    unit character varying DEFAULT 'Kg'::character varying NOT NULL,
    buying_price numeric(10,2) DEFAULT 0.0,
    selling_price numeric(10,2) NOT NULL,
    discount_enabled boolean DEFAULT false,
    discount_type character varying,
    discount_value numeric(10,2),
    discount_amount numeric(10,2),
    available_stock integer DEFAULT 0 NOT NULL,
    is_default boolean DEFAULT false,
    display_order integer DEFAULT 0,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    gst_percentage numeric(5,2),
    gst_amount numeric(10,2),
    final_price_with_gst numeric(10,2)
);


ALTER TABLE public.product_variants OWNER TO marlai_santhe_002_user;

--
-- Name: product_variants_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.product_variants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_variants_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: product_variants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.product_variants_id_seq OWNED BY public.product_variants.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.products (
    id bigint NOT NULL,
    name character varying NOT NULL,
    description text,
    category_id bigint NOT NULL,
    price numeric(10,2) NOT NULL,
    discount_price numeric(10,2),
    stock integer DEFAULT 0,
    status character varying DEFAULT 'active'::character varying,
    sku character varying NOT NULL,
    weight numeric(8,3),
    dimensions character varying,
    meta_title text,
    meta_description text,
    tags text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    discount_type character varying,
    discount_value numeric(10,2),
    original_price numeric(10,2),
    discount_amount numeric(10,2),
    is_discounted boolean DEFAULT false,
    gst_enabled boolean DEFAULT false,
    gst_percentage numeric(5,2),
    cgst_percentage numeric(5,2),
    sgst_percentage numeric(5,2),
    igst_percentage numeric(5,2),
    gst_amount numeric(10,2),
    cgst_amount numeric(10,2),
    sgst_amount numeric(10,2),
    igst_amount numeric(10,2),
    final_amount_with_gst numeric(10,2),
    buying_price numeric(10,2),
    yesterday_price numeric(10,2),
    today_price numeric(10,2),
    price_change_percentage numeric(5,2),
    last_price_update timestamp(6) without time zone,
    price_history text,
    is_occasional_product boolean DEFAULT false NOT NULL,
    occasional_start_date timestamp(6) without time zone,
    occasional_end_date timestamp(6) without time zone,
    occasional_description text,
    occasional_auto_hide boolean DEFAULT true NOT NULL,
    product_type character varying DEFAULT 'Grocery'::character varying,
    occasional_schedule_type character varying,
    occasional_recurring_from_day character varying,
    occasional_recurring_from_time time without time zone,
    occasional_recurring_to_day character varying,
    occasional_recurring_to_time time without time zone,
    is_subscription_enabled boolean DEFAULT false,
    unit_type character varying,
    minimum_stock_alert integer,
    default_selling_price numeric,
    hsn_code character varying,
    image_url character varying,
    additional_images_urls text,
    display_order integer,
    base_price_excluding_gst numeric,
    r2_image_url character varying,
    r2_additional_images text,
    has_multiple_quantities boolean DEFAULT false NOT NULL,
    barcode character varying
);


ALTER TABLE public.products OWNER TO marlai_santhe_002_user;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: referrals; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.referrals (
    id bigint NOT NULL,
    affiliate_id bigint,
    referred_name character varying,
    referred_mobile character varying,
    referred_email character varying,
    referral_date date,
    status character varying,
    notes text,
    converted_at timestamp(6) without time zone,
    customer_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    referring_customer_id bigint,
    referral_source character varying DEFAULT 'affiliate'::character varying
);


ALTER TABLE public.referrals OWNER TO marlai_santhe_002_user;

--
-- Name: referrals_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.referrals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.referrals_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: referrals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.referrals_id_seq OWNED BY public.referrals.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying,
    description text,
    status boolean,
    permissions text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.roles OWNER TO marlai_santhe_002_user;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: sale_items; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.sale_items (
    id bigint NOT NULL,
    booking_id bigint NOT NULL,
    product_id bigint NOT NULL,
    stock_batch_id bigint NOT NULL,
    quantity numeric,
    selling_price numeric,
    purchase_price numeric,
    profit_amount numeric,
    line_total numeric,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.sale_items OWNER TO marlai_santhe_002_user;

--
-- Name: sale_items_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.sale_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sale_items_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: sale_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.sale_items_id_seq OWNED BY public.sale_items.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO marlai_santhe_002_user;

--
-- Name: solid_cache_entries; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.solid_cache_entries (
    id bigint NOT NULL,
    key bytea NOT NULL,
    value bytea NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    key_hash bigint NOT NULL,
    byte_size integer NOT NULL
);


ALTER TABLE public.solid_cache_entries OWNER TO marlai_santhe_002_user;

--
-- Name: solid_cache_entries_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.solid_cache_entries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.solid_cache_entries_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: solid_cache_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.solid_cache_entries_id_seq OWNED BY public.solid_cache_entries.id;


--
-- Name: solid_queue_blocked_executions; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.solid_queue_blocked_executions (
    id bigint NOT NULL,
    job_id bigint NOT NULL,
    queue_name character varying NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    concurrency_key character varying NOT NULL,
    expires_at timestamp(6) without time zone NOT NULL,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.solid_queue_blocked_executions OWNER TO marlai_santhe_002_user;

--
-- Name: solid_queue_blocked_executions_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.solid_queue_blocked_executions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.solid_queue_blocked_executions_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: solid_queue_blocked_executions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.solid_queue_blocked_executions_id_seq OWNED BY public.solid_queue_blocked_executions.id;


--
-- Name: solid_queue_claimed_executions; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.solid_queue_claimed_executions (
    id bigint NOT NULL,
    job_id bigint NOT NULL,
    process_id bigint,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.solid_queue_claimed_executions OWNER TO marlai_santhe_002_user;

--
-- Name: solid_queue_claimed_executions_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.solid_queue_claimed_executions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.solid_queue_claimed_executions_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: solid_queue_claimed_executions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.solid_queue_claimed_executions_id_seq OWNED BY public.solid_queue_claimed_executions.id;


--
-- Name: solid_queue_failed_executions; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.solid_queue_failed_executions (
    id bigint NOT NULL,
    job_id bigint NOT NULL,
    error text,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.solid_queue_failed_executions OWNER TO marlai_santhe_002_user;

--
-- Name: solid_queue_failed_executions_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.solid_queue_failed_executions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.solid_queue_failed_executions_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: solid_queue_failed_executions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.solid_queue_failed_executions_id_seq OWNED BY public.solid_queue_failed_executions.id;


--
-- Name: solid_queue_jobs; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.solid_queue_jobs (
    id bigint NOT NULL,
    queue_name character varying NOT NULL,
    class_name character varying NOT NULL,
    arguments text,
    priority integer DEFAULT 0 NOT NULL,
    active_job_id character varying,
    scheduled_at timestamp(6) without time zone,
    finished_at timestamp(6) without time zone,
    concurrency_key character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.solid_queue_jobs OWNER TO marlai_santhe_002_user;

--
-- Name: solid_queue_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.solid_queue_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.solid_queue_jobs_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: solid_queue_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.solid_queue_jobs_id_seq OWNED BY public.solid_queue_jobs.id;


--
-- Name: solid_queue_pauses; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.solid_queue_pauses (
    id bigint NOT NULL,
    queue_name character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.solid_queue_pauses OWNER TO marlai_santhe_002_user;

--
-- Name: solid_queue_pauses_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.solid_queue_pauses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.solid_queue_pauses_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: solid_queue_pauses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.solid_queue_pauses_id_seq OWNED BY public.solid_queue_pauses.id;


--
-- Name: solid_queue_processes; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.solid_queue_processes (
    id bigint NOT NULL,
    kind character varying NOT NULL,
    last_heartbeat_at timestamp(6) without time zone NOT NULL,
    supervisor_id bigint,
    pid integer NOT NULL,
    hostname character varying,
    metadata text,
    created_at timestamp(6) without time zone NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.solid_queue_processes OWNER TO marlai_santhe_002_user;

--
-- Name: solid_queue_processes_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.solid_queue_processes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.solid_queue_processes_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: solid_queue_processes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.solid_queue_processes_id_seq OWNED BY public.solid_queue_processes.id;


--
-- Name: solid_queue_ready_executions; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.solid_queue_ready_executions (
    id bigint NOT NULL,
    job_id bigint NOT NULL,
    queue_name character varying NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.solid_queue_ready_executions OWNER TO marlai_santhe_002_user;

--
-- Name: solid_queue_ready_executions_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.solid_queue_ready_executions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.solid_queue_ready_executions_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: solid_queue_ready_executions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.solid_queue_ready_executions_id_seq OWNED BY public.solid_queue_ready_executions.id;


--
-- Name: solid_queue_recurring_executions; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.solid_queue_recurring_executions (
    id bigint NOT NULL,
    job_id bigint NOT NULL,
    task_key character varying NOT NULL,
    run_at timestamp(6) without time zone NOT NULL,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.solid_queue_recurring_executions OWNER TO marlai_santhe_002_user;

--
-- Name: solid_queue_recurring_executions_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.solid_queue_recurring_executions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.solid_queue_recurring_executions_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: solid_queue_recurring_executions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.solid_queue_recurring_executions_id_seq OWNED BY public.solid_queue_recurring_executions.id;


--
-- Name: solid_queue_recurring_tasks; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.solid_queue_recurring_tasks (
    id bigint NOT NULL,
    key character varying NOT NULL,
    schedule character varying NOT NULL,
    command character varying(2048),
    class_name character varying,
    arguments text,
    queue_name character varying,
    priority integer DEFAULT 0,
    static boolean DEFAULT true NOT NULL,
    description text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.solid_queue_recurring_tasks OWNER TO marlai_santhe_002_user;

--
-- Name: solid_queue_recurring_tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.solid_queue_recurring_tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.solid_queue_recurring_tasks_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: solid_queue_recurring_tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.solid_queue_recurring_tasks_id_seq OWNED BY public.solid_queue_recurring_tasks.id;


--
-- Name: solid_queue_scheduled_executions; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.solid_queue_scheduled_executions (
    id bigint NOT NULL,
    job_id bigint NOT NULL,
    queue_name character varying NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    scheduled_at timestamp(6) without time zone NOT NULL,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.solid_queue_scheduled_executions OWNER TO marlai_santhe_002_user;

--
-- Name: solid_queue_scheduled_executions_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.solid_queue_scheduled_executions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.solid_queue_scheduled_executions_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: solid_queue_scheduled_executions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.solid_queue_scheduled_executions_id_seq OWNED BY public.solid_queue_scheduled_executions.id;


--
-- Name: solid_queue_semaphores; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.solid_queue_semaphores (
    id bigint NOT NULL,
    key character varying NOT NULL,
    value integer DEFAULT 1 NOT NULL,
    expires_at timestamp(6) without time zone NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.solid_queue_semaphores OWNER TO marlai_santhe_002_user;

--
-- Name: solid_queue_semaphores_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.solid_queue_semaphores_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.solid_queue_semaphores_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: solid_queue_semaphores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.solid_queue_semaphores_id_seq OWNED BY public.solid_queue_semaphores.id;


--
-- Name: stock_batches; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.stock_batches (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    vendor_id bigint NOT NULL,
    vendor_purchase_id bigint,
    quantity_purchased numeric,
    quantity_remaining numeric,
    purchase_price numeric,
    selling_price numeric,
    batch_date date,
    status character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    store_id bigint
);


ALTER TABLE public.stock_batches OWNER TO marlai_santhe_002_user;

--
-- Name: stock_batches_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.stock_batches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stock_batches_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: stock_batches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.stock_batches_id_seq OWNED BY public.stock_batches.id;


--
-- Name: stock_movements; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.stock_movements (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    reference_type character varying NOT NULL,
    reference_id integer,
    movement_type character varying NOT NULL,
    quantity numeric(10,2) NOT NULL,
    stock_before numeric(10,2) NOT NULL,
    stock_after numeric(10,2) NOT NULL,
    notes text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.stock_movements OWNER TO marlai_santhe_002_user;

--
-- Name: stock_movements_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.stock_movements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stock_movements_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: stock_movements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.stock_movements_id_seq OWNED BY public.stock_movements.id;


--
-- Name: stock_transfers; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.stock_transfers (
    id bigint NOT NULL,
    from_store_id bigint,
    to_store_id bigint NOT NULL,
    product_id bigint NOT NULL,
    requested_by_id bigint NOT NULL,
    approved_by_id bigint,
    quantity numeric(10,2) NOT NULL,
    status character varying DEFAULT 'pending'::character varying NOT NULL,
    notes text,
    rejection_reason text,
    approved_at timestamp(6) without time zone,
    completed_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    product_variant_id bigint,
    transfer_group_id character varying
);


ALTER TABLE public.stock_transfers OWNER TO marlai_santhe_002_user;

--
-- Name: stock_transfers_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.stock_transfers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stock_transfers_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: stock_transfers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.stock_transfers_id_seq OWNED BY public.stock_transfers.id;


--
-- Name: stores; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.stores (
    id bigint NOT NULL,
    name character varying,
    description text,
    address text,
    city character varying,
    state character varying,
    pincode character varying,
    contact_person character varying,
    contact_mobile character varying,
    email character varying,
    status boolean,
    gst_no character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    store_admin_user_id integer,
    admin_plain_password character varying,
    auto_transfer_threshold integer DEFAULT 10,
    is_main_inventory boolean DEFAULT false,
    commission_percentage numeric(5,2) DEFAULT 0.0
);


ALTER TABLE public.stores OWNER TO marlai_santhe_002_user;

--
-- Name: stores_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.stores_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stores_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: stores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.stores_id_seq OWNED BY public.stores.id;


--
-- Name: sub_agents; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.sub_agents (
    id bigint NOT NULL,
    first_name character varying,
    last_name character varying,
    middle_name character varying,
    email character varying,
    mobile character varying,
    password_digest character varying,
    plain_password character varying,
    original_password character varying,
    role_id integer,
    gender character varying,
    birth_date date,
    pan_no character varying,
    aadhar_no character varying,
    gst_no character varying,
    company_name character varying,
    address text,
    city character varying,
    state character varying,
    pincode character varying,
    country character varying,
    profile_picture character varying,
    bank_name character varying,
    account_no character varying,
    ifsc_code character varying,
    account_holder_name character varying,
    account_type character varying,
    upi_id character varying,
    emergency_contact_name character varying,
    emergency_contact_mobile character varying,
    joining_date date,
    salary numeric(10,2),
    notes text,
    status integer DEFAULT 0,
    distributor_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.sub_agents OWNER TO marlai_santhe_002_user;

--
-- Name: sub_agents_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.sub_agents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sub_agents_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: sub_agents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.sub_agents_id_seq OWNED BY public.sub_agents.id;


--
-- Name: subscription_templates; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.subscription_templates (
    id bigint NOT NULL,
    customer_id bigint NOT NULL,
    product_id bigint NOT NULL,
    delivery_person_id bigint,
    quantity numeric(8,2),
    unit character varying,
    price numeric(10,2),
    delivery_time character varying,
    is_active boolean,
    template_name character varying,
    notes text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.subscription_templates OWNER TO marlai_santhe_002_user;

--
-- Name: subscription_templates_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.subscription_templates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subscription_templates_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: subscription_templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.subscription_templates_id_seq OWNED BY public.subscription_templates.id;


--
-- Name: system_settings; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.system_settings (
    id bigint NOT NULL,
    key character varying,
    value text,
    setting_type character varying,
    description text,
    default_main_agent_commission numeric,
    default_affiliate_commission numeric,
    default_ambassador_commission numeric,
    default_company_expenses numeric,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    business_name character varying,
    address text,
    mobile character varying,
    email character varying,
    gstin character varying,
    pan_number character varying,
    account_holder_name character varying,
    bank_name character varying,
    account_number character varying,
    ifsc_code character varying,
    upi_id character varying,
    qr_code_path character varying,
    terms_and_conditions text,
    collect_from_store_enabled boolean,
    delivery_only_at_shop boolean,
    shop_addresses text,
    low_stock_alert_enabled boolean DEFAULT false,
    low_stock_alert_threshold integer DEFAULT 10,
    low_stock_alert_email character varying
);


ALTER TABLE public.system_settings OWNER TO marlai_santhe_002_user;

--
-- Name: system_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.system_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.system_settings_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: system_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.system_settings_id_seq OWNED BY public.system_settings.id;


--
-- Name: user_roles; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.user_roles (
    id bigint NOT NULL,
    name character varying NOT NULL,
    description text,
    active boolean DEFAULT true,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.user_roles OWNER TO marlai_santhe_002_user;

--
-- Name: user_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.user_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_roles_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: user_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.user_roles_id_seq OWNED BY public.user_roles.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    first_name character varying NOT NULL,
    last_name character varying NOT NULL,
    email character varying NOT NULL,
    mobile character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    middle_name character varying,
    encrypted_password character varying,
    user_type character varying DEFAULT 'admin'::character varying,
    role character varying DEFAULT 'super_admin'::character varying,
    role_id integer,
    status boolean DEFAULT true,
    is_active boolean DEFAULT true,
    is_verified boolean DEFAULT false,
    birth_date date,
    gender character varying,
    pan_no character varying,
    aadhar_no character varying,
    gst_no character varying,
    company_name character varying,
    address text,
    city character varying,
    state character varying,
    pincode character varying,
    country character varying DEFAULT 'India'::character varying,
    profile_picture character varying,
    bank_name character varying,
    account_no character varying,
    ifsc_code character varying,
    account_holder_name character varying,
    account_type character varying,
    upi_id character varying,
    emergency_contact_name character varying,
    emergency_contact_mobile character varying,
    department character varying,
    designation character varying,
    joining_date date,
    salary numeric(10,2),
    employee_id character varying,
    reporting_manager_id integer,
    permissions text,
    sidebar_permissions text,
    last_login_at timestamp(6) without time zone,
    login_count integer DEFAULT 0,
    email_verified_at timestamp(6) without time zone,
    mobile_verified_at timestamp(6) without time zone,
    two_factor_enabled boolean DEFAULT false,
    reset_password_token character varying,
    reset_password_sent_at timestamp(6) without time zone,
    remember_created_at timestamp(6) without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp(6) without time zone,
    last_sign_in_at timestamp(6) without time zone,
    current_sign_in_ip character varying,
    last_sign_in_ip character varying,
    confirmation_token character varying,
    confirmed_at timestamp(6) without time zone,
    confirmation_sent_at timestamp(6) without time zone,
    unlock_token character varying,
    locked_at timestamp(6) without time zone,
    failed_attempts integer DEFAULT 0,
    notes text,
    created_by integer,
    updated_by integer,
    deleted_at timestamp(6) without time zone,
    original_password character varying,
    authenticatable_type character varying,
    authenticatable_id bigint,
    assigned_store_id integer,
    store_permissions text,
    last_store_access timestamp(6) without time zone
);


ALTER TABLE public.users OWNER TO marlai_santhe_002_user;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: vendor_invoices; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.vendor_invoices (
    id bigint NOT NULL,
    vendor_purchase_id bigint NOT NULL,
    invoice_number character varying,
    total_amount numeric,
    status integer,
    invoice_date date,
    share_token character varying,
    notes text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.vendor_invoices OWNER TO marlai_santhe_002_user;

--
-- Name: vendor_invoices_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.vendor_invoices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vendor_invoices_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: vendor_invoices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.vendor_invoices_id_seq OWNED BY public.vendor_invoices.id;


--
-- Name: vendor_payments; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.vendor_payments (
    id bigint NOT NULL,
    vendor_id bigint NOT NULL,
    vendor_purchase_id bigint NOT NULL,
    amount_paid numeric,
    payment_date date,
    payment_mode character varying,
    notes text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.vendor_payments OWNER TO marlai_santhe_002_user;

--
-- Name: vendor_payments_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.vendor_payments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vendor_payments_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: vendor_payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.vendor_payments_id_seq OWNED BY public.vendor_payments.id;


--
-- Name: vendor_purchase_items; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.vendor_purchase_items (
    id bigint NOT NULL,
    vendor_purchase_id bigint NOT NULL,
    product_id bigint NOT NULL,
    quantity numeric,
    purchase_price numeric,
    selling_price numeric,
    line_total numeric,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.vendor_purchase_items OWNER TO marlai_santhe_002_user;

--
-- Name: vendor_purchase_items_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.vendor_purchase_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vendor_purchase_items_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: vendor_purchase_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.vendor_purchase_items_id_seq OWNED BY public.vendor_purchase_items.id;


--
-- Name: vendor_purchases; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.vendor_purchases (
    id bigint NOT NULL,
    vendor_id bigint NOT NULL,
    purchase_date date,
    total_amount numeric,
    paid_amount numeric,
    status character varying,
    notes text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.vendor_purchases OWNER TO marlai_santhe_002_user;

--
-- Name: vendor_purchases_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.vendor_purchases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vendor_purchases_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: vendor_purchases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.vendor_purchases_id_seq OWNED BY public.vendor_purchases.id;


--
-- Name: vendors; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.vendors (
    id bigint NOT NULL,
    name character varying,
    phone character varying,
    email character varying,
    address text,
    payment_type character varying,
    opening_balance numeric,
    status boolean,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.vendors OWNER TO marlai_santhe_002_user;

--
-- Name: vendors_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.vendors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vendors_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: vendors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.vendors_id_seq OWNED BY public.vendors.id;


--
-- Name: wallet_transactions; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.wallet_transactions (
    id bigint NOT NULL,
    customer_wallet_id bigint NOT NULL,
    transaction_type character varying,
    amount numeric(10,2),
    balance_after numeric(10,2),
    description character varying,
    reference_number character varying,
    metadata json,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.wallet_transactions OWNER TO marlai_santhe_002_user;

--
-- Name: wallet_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.wallet_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.wallet_transactions_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: wallet_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.wallet_transactions_id_seq OWNED BY public.wallet_transactions.id;


--
-- Name: wishlists; Type: TABLE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE TABLE public.wishlists (
    id bigint NOT NULL,
    customer_id bigint NOT NULL,
    product_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.wishlists OWNER TO marlai_santhe_002_user;

--
-- Name: wishlists_id_seq; Type: SEQUENCE; Schema: public; Owner: marlai_santhe_002_user
--

CREATE SEQUENCE public.wishlists_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.wishlists_id_seq OWNER TO marlai_santhe_002_user;

--
-- Name: wishlists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marlai_santhe_002_user
--

ALTER SEQUENCE public.wishlists_id_seq OWNED BY public.wishlists.id;


--
-- Name: active_storage_attachments id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.active_storage_attachments ALTER COLUMN id SET DEFAULT nextval('public.active_storage_attachments_id_seq'::regclass);


--
-- Name: active_storage_blobs id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.active_storage_blobs ALTER COLUMN id SET DEFAULT nextval('public.active_storage_blobs_id_seq'::regclass);


--
-- Name: active_storage_variant_records id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.active_storage_variant_records ALTER COLUMN id SET DEFAULT nextval('public.active_storage_variant_records_id_seq'::regclass);


--
-- Name: affiliates id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.affiliates ALTER COLUMN id SET DEFAULT nextval('public.affiliates_id_seq'::regclass);


--
-- Name: banners id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.banners ALTER COLUMN id SET DEFAULT nextval('public.banners_id_seq'::regclass);


--
-- Name: booking_invoices id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.booking_invoices ALTER COLUMN id SET DEFAULT nextval('public.booking_invoices_id_seq'::regclass);


--
-- Name: booking_items id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.booking_items ALTER COLUMN id SET DEFAULT nextval('public.booking_items_id_seq'::regclass);


--
-- Name: booking_schedules id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.booking_schedules ALTER COLUMN id SET DEFAULT nextval('public.booking_schedules_id_seq'::regclass);


--
-- Name: bookings id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.bookings ALTER COLUMN id SET DEFAULT nextval('public.bookings_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: client_requests id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.client_requests ALTER COLUMN id SET DEFAULT nextval('public.client_requests_id_seq'::regclass);


--
-- Name: coupons id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.coupons ALTER COLUMN id SET DEFAULT nextval('public.coupons_id_seq'::regclass);


--
-- Name: customer_addresses id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.customer_addresses ALTER COLUMN id SET DEFAULT nextval('public.customer_addresses_id_seq'::regclass);


--
-- Name: customer_formats id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.customer_formats ALTER COLUMN id SET DEFAULT nextval('public.customer_formats_id_seq'::regclass);


--
-- Name: customer_wallets id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.customer_wallets ALTER COLUMN id SET DEFAULT nextval('public.customer_wallets_id_seq'::regclass);


--
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);


--
-- Name: delivery_charges id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.delivery_charges ALTER COLUMN id SET DEFAULT nextval('public.delivery_charges_id_seq'::regclass);


--
-- Name: delivery_people id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.delivery_people ALTER COLUMN id SET DEFAULT nextval('public.delivery_people_id_seq'::regclass);


--
-- Name: delivery_rules id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.delivery_rules ALTER COLUMN id SET DEFAULT nextval('public.delivery_rules_id_seq'::regclass);


--
-- Name: device_tokens id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.device_tokens ALTER COLUMN id SET DEFAULT nextval('public.device_tokens_id_seq'::regclass);


--
-- Name: expenses id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.expenses ALTER COLUMN id SET DEFAULT nextval('public.expenses_id_seq'::regclass);


--
-- Name: franchises id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.franchises ALTER COLUMN id SET DEFAULT nextval('public.franchises_id_seq'::regclass);


--
-- Name: invoice_items id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.invoice_items ALTER COLUMN id SET DEFAULT nextval('public.invoice_items_id_seq'::regclass);


--
-- Name: invoices id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.invoices ALTER COLUMN id SET DEFAULT nextval('public.invoices_id_seq'::regclass);


--
-- Name: leads id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.leads ALTER COLUMN id SET DEFAULT nextval('public.leads_id_seq'::regclass);


--
-- Name: milk_delivery_tasks id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.milk_delivery_tasks ALTER COLUMN id SET DEFAULT nextval('public.milk_delivery_tasks_id_seq'::regclass);


--
-- Name: milk_subscriptions id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.milk_subscriptions ALTER COLUMN id SET DEFAULT nextval('public.milk_subscriptions_id_seq'::regclass);


--
-- Name: notes id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.notes ALTER COLUMN id SET DEFAULT nextval('public.notes_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: pending_amounts id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.pending_amounts ALTER COLUMN id SET DEFAULT nextval('public.pending_amounts_id_seq'::regclass);


--
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- Name: product_ratings id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.product_ratings ALTER COLUMN id SET DEFAULT nextval('public.product_ratings_id_seq'::regclass);


--
-- Name: product_reviews id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.product_reviews ALTER COLUMN id SET DEFAULT nextval('public.product_reviews_id_seq'::regclass);


--
-- Name: product_variants id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.product_variants ALTER COLUMN id SET DEFAULT nextval('public.product_variants_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: referrals id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.referrals ALTER COLUMN id SET DEFAULT nextval('public.referrals_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: sale_items id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.sale_items ALTER COLUMN id SET DEFAULT nextval('public.sale_items_id_seq'::regclass);


--
-- Name: solid_cache_entries id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.solid_cache_entries ALTER COLUMN id SET DEFAULT nextval('public.solid_cache_entries_id_seq'::regclass);


--
-- Name: solid_queue_blocked_executions id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.solid_queue_blocked_executions ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_blocked_executions_id_seq'::regclass);


--
-- Name: solid_queue_claimed_executions id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.solid_queue_claimed_executions ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_claimed_executions_id_seq'::regclass);


--
-- Name: solid_queue_failed_executions id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.solid_queue_failed_executions ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_failed_executions_id_seq'::regclass);


--
-- Name: solid_queue_jobs id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.solid_queue_jobs ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_jobs_id_seq'::regclass);


--
-- Name: solid_queue_pauses id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.solid_queue_pauses ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_pauses_id_seq'::regclass);


--
-- Name: solid_queue_processes id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.solid_queue_processes ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_processes_id_seq'::regclass);


--
-- Name: solid_queue_ready_executions id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.solid_queue_ready_executions ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_ready_executions_id_seq'::regclass);


--
-- Name: solid_queue_recurring_executions id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.solid_queue_recurring_executions ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_recurring_executions_id_seq'::regclass);


--
-- Name: solid_queue_recurring_tasks id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.solid_queue_recurring_tasks ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_recurring_tasks_id_seq'::regclass);


--
-- Name: solid_queue_scheduled_executions id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.solid_queue_scheduled_executions ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_scheduled_executions_id_seq'::regclass);


--
-- Name: solid_queue_semaphores id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.solid_queue_semaphores ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_semaphores_id_seq'::regclass);


--
-- Name: stock_batches id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.stock_batches ALTER COLUMN id SET DEFAULT nextval('public.stock_batches_id_seq'::regclass);


--
-- Name: stock_movements id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.stock_movements ALTER COLUMN id SET DEFAULT nextval('public.stock_movements_id_seq'::regclass);


--
-- Name: stock_transfers id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.stock_transfers ALTER COLUMN id SET DEFAULT nextval('public.stock_transfers_id_seq'::regclass);


--
-- Name: stores id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.stores ALTER COLUMN id SET DEFAULT nextval('public.stores_id_seq'::regclass);


--
-- Name: sub_agents id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.sub_agents ALTER COLUMN id SET DEFAULT nextval('public.sub_agents_id_seq'::regclass);


--
-- Name: subscription_templates id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.subscription_templates ALTER COLUMN id SET DEFAULT nextval('public.subscription_templates_id_seq'::regclass);


--
-- Name: system_settings id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.system_settings ALTER COLUMN id SET DEFAULT nextval('public.system_settings_id_seq'::regclass);


--
-- Name: user_roles id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.user_roles ALTER COLUMN id SET DEFAULT nextval('public.user_roles_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: vendor_invoices id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.vendor_invoices ALTER COLUMN id SET DEFAULT nextval('public.vendor_invoices_id_seq'::regclass);


--
-- Name: vendor_payments id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.vendor_payments ALTER COLUMN id SET DEFAULT nextval('public.vendor_payments_id_seq'::regclass);


--
-- Name: vendor_purchase_items id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.vendor_purchase_items ALTER COLUMN id SET DEFAULT nextval('public.vendor_purchase_items_id_seq'::regclass);


--
-- Name: vendor_purchases id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.vendor_purchases ALTER COLUMN id SET DEFAULT nextval('public.vendor_purchases_id_seq'::regclass);


--
-- Name: vendors id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.vendors ALTER COLUMN id SET DEFAULT nextval('public.vendors_id_seq'::regclass);


--
-- Name: wallet_transactions id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.wallet_transactions ALTER COLUMN id SET DEFAULT nextval('public.wallet_transactions_id_seq'::regclass);


--
-- Name: wishlists id; Type: DEFAULT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.wishlists ALTER COLUMN id SET DEFAULT nextval('public.wishlists_id_seq'::regclass);


--
-- Data for Name: active_storage_attachments; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.active_storage_attachments (id, name, record_type, record_id, blob_id, created_at) FROM stdin;
4	image	Category	2	4	2026-02-12 16:43:18.90868
8	personal_image	Customer	2	8	2026-02-16 11:41:09.107367
9	image	Category	5	9	2026-02-16 15:33:45.176034
10	image	Category	4	10	2026-02-16 15:36:49.145211
11	image	Category	6	11	2026-02-16 15:40:00.723689
12	image	Category	7	12	2026-02-16 15:43:43.084157
13	personal_image	Customer	4	13	2026-02-16 15:57:33.158563
14	images	Product	6	14	2026-02-17 11:36:34.789557
15	image	Category	12	15	2026-02-21 10:11:28.03443
16	image	Category	13	16	2026-02-21 10:13:49.354861
18	personal_image	Customer	20	18	2026-02-21 12:14:15.154785
19	personal_image	Customer	18	19	2026-02-23 12:37:55.947709
20	house_image	Customer	18	20	2026-02-23 12:37:56.446492
21	personal_image	Customer	48	21	2026-02-24 01:34:54.410908
23	banner_image	Banner	3	23	2026-02-24 03:43:45.911136
24	banner_image	Banner	4	24	2026-02-24 03:44:10.868693
25	image	Category	1	25	2026-02-27 00:42:18.108084
26	personal_image	Customer	469	26	2026-03-04 06:38:37.307697
\.


--
-- Data for Name: active_storage_blobs; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.active_storage_blobs (id, key, filename, content_type, metadata, service_name, byte_size, checksum, created_at) FROM stdin;
1	3t1l827fk1vzmzkquysqrq93k0oq	WhatsApp Image 2026-02-08 at 9.25.11 PM.jpeg	image/jpeg	{"identified":true}	local	22400	jl6yRAWPOl8M+oO/pe1gvg==	2026-02-12 11:54:12.716336
2	vhuvvt9jio63b6l39nxht19hbe6q	WhatsApp Image 2026-02-08 at 9.25.11 PM.jpeg	image/jpeg	{"identified":true}	local	22400	jl6yRAWPOl8M+oO/pe1gvg==	2026-02-12 13:21:23.988587
3	ygzl179oghvcnxckt5eocbgvx9j7	personal-care.png	image/png	{"identified":true}	local	4046	VgcfexvxBptpaTwlGk1YWw==	2026-02-12 16:39:33.274898
4	zt1kuuq8l3nf2gnfdpwdmktj1607	personal-care.png	image/png	{"identified":true}	local	4046	VgcfexvxBptpaTwlGk1YWw==	2026-02-12 16:43:18.783373
5	yn1mrxcw3vbldcriiucbl3xz2lhk	personal-care.png	image/png	{"identified":true}	local	4046	VgcfexvxBptpaTwlGk1YWw==	2026-02-12 16:45:24.682986
6	7s74a8nw3674ptsftayje2uuawom	personal-care.png	image/png	{"identified":true}	local	4046	VgcfexvxBptpaTwlGk1YWw==	2026-02-13 05:51:24.593515
7	nvf2nao6idmpl0vymxh2jqc8bxxi	personal-care.png	image/png	{"identified":true}	local	4046	VgcfexvxBptpaTwlGk1YWw==	2026-02-13 05:52:07.312809
8	9f0frgqvpg9cjalc9603r665d04y	WhatsApp Image 2026-02-08 at 9.25.11 PM.jpeg	image/jpeg	{"identified":true}	local	22400	jl6yRAWPOl8M+oO/pe1gvg==	2026-02-16 11:41:08.817681
9	jaz3ubzewvhtn77neu8ruuohq7zz	spices.png	image/png	{"identified":true}	local	45237	dAspij4PHNJoFdsZkn+LiQ==	2026-02-16 15:33:45.020741
10	tc15r646xou5d8flvvg0partcxqu	snacks.jpg	image/jpeg	{"identified":true}	local	34172	bXk3U1YuMI5BDUCkhgHwUA==	2026-02-16 15:36:49.018668
11	dy27b4phyoxwqirnzzltx96z2ziu	nuts.png	image/png	{"identified":true}	local	56205	WGHhqWyZvaux21dOAgXhtQ==	2026-02-16 15:40:00.590984
12	nh3f5gd6ntvfxndap2cvzdlg5wse	whole grain.jpg	image/jpeg	{"identified":true}	local	45428	DWrv7mWMUK7otw++v2Ce/g==	2026-02-16 15:43:42.956899
13	fjh1zqdph598cx6oqfoaiqyqnjhm	WhatsApp Image 2026-02-08 at 9.25.11 PM.jpeg	image/jpeg	{"identified":true}	local	22400	jl6yRAWPOl8M+oO/pe1gvg==	2026-02-16 15:57:33.008874
14	g5azzmt4v6zzy11lxhtrcjqwgw1x	IMG_0417.JPG.jpeg	image/jpeg	{"identified":true}	local	4067876	JvOuBFprbq1CFoPSwNm0YA==	2026-02-17 11:36:34.663576
15	o5voa6yzskkn47k1c5e9wnv3a3um	rice.png	image/png	{"identified":true}	local	5224	y1EouuVyZ5lB/m9hR17N2Q==	2026-02-21 10:11:27.916417
16	a8ux1f3qcf3bsjwg9tv5jykjbgum	vegetables.png	image/png	{"identified":true}	local	41944	vD9QCuNm2jyIwOuaPCY+9g==	2026-02-21 10:13:49.233074
17	nboq1rr17orjjxkjcpo2bpnh9l13	vegetables.png	image/png	{"identified":true}	local	41944	vD9QCuNm2jyIwOuaPCY+9g==	2026-02-21 10:15:07.687831
18	ubtvchb75fzy7yztblftq9og8h9x	Screenshot from 2026-02-07 09-03-44.png	image/png	{"identified":true}	local	685418	HUFnpChmydP1SW7+d+Diig==	2026-02-21 12:14:14.894435
19	6fvu5ef2jcyimnd4oo55901d6sa5	customer 1.png	image/png	{"identified":true}	local	26379	DoGnmczAvsxxCHXfQIn+tg==	2026-02-23 12:37:55.825003
20	d3ze7z5bkk95okr65ftmi6gfu98g	customer house.jpg	image/jpeg	{"identified":true}	local	36538	T38R2MKg0HTX2I3UCUrhoQ==	2026-02-23 12:37:56.326148
21	36282h2byxoioq30csq5mqgmphor	logo.jpeg	image/jpeg	{"identified":true}	local	22400	jl6yRAWPOl8M+oO/pe1gvg==	2026-02-24 01:34:54.13753
22	2aso4dabq6iaap4wf4om6ydngzyf	siddhadnt.jpeg	image/jpeg	{"identified":true}	local	12977	C7awdn7CLs24BA7wU3fmiQ==	2026-02-24 03:43:13.967668
23	cq4i0f7bqrg4w90juvy1fp32d3ye	siddhadnt.jpeg	image/jpeg	{"identified":true}	local	12977	C7awdn7CLs24BA7wU3fmiQ==	2026-02-24 03:43:45.790956
24	ary24yi1hov1l38yb3dpin9pxeub	siddhadnt.jpeg	image/jpeg	{"identified":true}	local	12977	C7awdn7CLs24BA7wU3fmiQ==	2026-02-24 03:44:10.748379
25	5pfk9e5jhpuxmgw9hziktiku8nz9	Screenshot from 2026-02-07 07-40-01.png	image/png	{"identified":true}	local	103977	MMlazV5x2k5IlxCZxk25dg==	2026-02-27 00:42:17.82227
26	vfairils192g7tnzi91fz2kdkp79	Screenshot from 2026-02-07 11-43-48.png	image/png	{"identified":true}	local	245237	7Raaaj42A+rSmSsDa6Ankw==	2026-03-04 06:38:37.306322
\.


--
-- Data for Name: active_storage_variant_records; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.active_storage_variant_records (id, blob_id, variation_digest) FROM stdin;
\.


--
-- Data for Name: affiliates; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.affiliates (id, first_name, last_name, middle_name, email, mobile, address, city, state, pincode, pan_no, gst_no, commission_percentage, bank_name, account_no, ifsc_code, account_holder_name, account_type, upi_id, status, notes, auto_generated_password, joining_date, created_at, updated_at, company_name, username) FROM stdin;
12	pramod	bhat	fdsfds	9093939393fdfds@gmail.com	09190939393	dfd	Bangalore	karnataka	560068			44.98				pramod			t		PRAM@2026	2026-05-09	2026-05-09 11:43:20.300104	2026-05-09 11:43:20.300104		pramodbhat
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
schema_sha1	9c6777daaa6ce85cc74b26c38000144a7834a947	2026-02-12 02:44:06.897761	2026-02-12 02:44:06.897764
environment	development	2026-02-12 02:44:05.79552	2026-02-22 10:18:57.284237
\.


--
-- Data for Name: banners; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.banners (id, title, description, redirect_link, display_start_date, display_end_date, display_location, status, display_order, image, created_at, updated_at, image_url, r2_image_url) FROM stdin;
5	Test	sd	https://web.whatsapp.com/	2026-05-10	2026-06-10	dashboard	t	1	\N	2026-05-10 08:37:09.737927	2026-05-10 08:37:09.737927	banners/banner-temp-2de1b96bbcaf715c	
6	sds	{{base_url}}/api/v1/mobile/banners	https://maralisanthe.com/customer	2026-05-10	2026-06-10	dashboard	t	2	\N	2026-05-10 08:46:41.755881	2026-05-10 08:46:41.755881	banners/banner-temp-1cff110facc4d366	
\.


--
-- Data for Name: booking_invoices; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.booking_invoices (id, booking_id, customer_id, invoice_number, invoice_date, due_date, subtotal, tax_amount, discount_amount, total_amount, payment_status, status, notes, invoice_items, paid_at, created_at, updated_at, share_token) FROM stdin;
27	75	481	INV2026032923147C	2026-03-29 06:30:36.262241	2026-04-28 06:30:36.262275	700.00	35.00	0.00	735.00	1	1	Invoice generated for booking #BK202603196879	[{"product_id":41,"product_name":"SUNFLOWER OIL [1LTR]","quantity":"2.0","price":"350.0","total":"700.0"}]	\N	2026-03-29 06:30:37.612659	2026-03-29 06:30:37.612659	zWuY78arR4dj3m4GxAAKY7SzvRIfSOUckTfPZiFHYy4
28	82	481	INV202603295B21A4	2026-03-29 06:42:22.716035	2026-04-28 06:42:22.716106	1500.00	75.00	0.00	1575.00	1	1	Invoice generated for booking #BK2026032465D905	[{"product_id":35,"product_name":"DESI COW GHEE [500ML]","quantity":"2.0","price":"750.0","total":"1500.0"}]	\N	2026-03-29 06:42:24.812446	2026-03-29 06:42:24.812446	p5DaJaQNml1P8lMvKZ7n8LcaX2FTkkMhOJAfnr7LNaA
29	125	486	INV2026032972464D	2026-03-29 06:54:05.464519	2026-04-28 06:54:05.464578	1.00	0.00	0.00	1.00	1	1	Invoice generated for booking #BK202603299963	[{"product_id":50,"product_name":"Test product","quantity":"1.0","price":"1.0","total":"1.0"}]	\N	2026-03-29 06:54:05.638192	2026-03-29 06:54:05.638192	71rYwLfQMWl2XvIO6gGedxLdYtmFh0Srvu5LIW8cdNo
30	125	486	INV20260329D799F1	2026-03-29 06:54:06.138785	2026-04-28 06:54:06.138842	1.00	0.00	0.00	1.00	1	1	Invoice generated for booking #BK202603299963	[{"product_id":50,"product_name":"Test product","quantity":"1.0","price":"1.0","total":"1.0"}]	\N	2026-03-29 06:54:06.306674	2026-03-29 06:54:06.306674	cHU-HTR38aousBUkcd4zZWpWOu6KxRrQjrPeXZp4CzI
31	126	486	INV202603295C801F	2026-03-29 07:04:53.909571	2026-04-28 07:04:53.909669	1.00	0.00	0.00	1.00	1	1	Invoice generated for booking #BK202603291670	[{"product_id":50,"product_name":"Test product","quantity":"1.0","price":"1.0","total":"1.0"}]	\N	2026-03-29 07:04:54.083447	2026-03-29 07:04:54.083447	iyLNM1yNH3gsgggyrl82QcMV4FUhtY4zJZ3yGVvp3Gs
32	128	486	INV20260329A80763	2026-03-29 07:13:49.210913	2026-04-28 07:13:49.210941	1.00	0.00	0.00	1.00	1	1	Invoice generated for booking #BK202603295419	[{"product_id":50,"product_name":"Test product","quantity":"1.0","price":"1.0","total":"1.0"}]	\N	2026-03-29 07:13:49.358083	2026-03-29 07:13:49.358083	YMSKLXILHhlzKVA716BrYoqmLhDDizxnlfMA-jE1xFU
33	129	486	INV20260329A4CB74	2026-03-29 10:04:26.671496	2026-04-28 10:04:26.671553	1.00	0.00	0.00	1.00	1	1	Invoice generated for booking #BK202603299884	[{"product_id":50,"product_name":"Test product","quantity":"1.0","price":"1.0","total":"1.0"}]	\N	2026-03-29 10:04:27.08547	2026-03-29 10:04:27.08547	qvh_zk7rsNxYqv3MysyZmzvY02FfiQaJsgI4Yfses04
34	189	488	INV20260506F9EECD	2026-05-06 15:48:53.223148	2026-06-05 15:48:53.2232	458.05	5.95	0.00	464.00	1	1	Invoice generated for booking #BK202605068946	[{"product_id":40,"product_name":"GROUNDNUT OIL [1LTR]","quantity":"1.0","price":"345.0","total":"345.0"},{"product_id":85,"product_name":"HIMALAYA CRYSTAL ROCK SALT [1KG]","quantity":"1.0","price":"119.0","total":"119.0"}]	\N	2026-05-06 15:48:53.623436	2026-05-06 15:48:53.623436	4H62K7lQ6Whozb1BQ1Q6JOwBLlNJ0CA-Io9vORbJvb4
35	189	488	INV20260506DAE35D	2026-05-06 15:48:54.659581	2026-06-05 15:48:54.659686	458.05	5.95	0.00	464.00	1	1	Invoice generated for booking #BK202605068946	[{"product_id":40,"product_name":"GROUNDNUT OIL [1LTR]","quantity":"1.0","price":"345.0","total":"345.0"},{"product_id":85,"product_name":"HIMALAYA CRYSTAL ROCK SALT [1KG]","quantity":"1.0","price":"119.0","total":"119.0"}]	\N	2026-05-06 15:48:55.063031	2026-05-06 15:48:55.063031	IMfqEL35_tE_dN6lopavqsIu9YRMQZReKrrB8UIWag0
36	198	524	INV20260509C662F4	2026-05-09 06:20:14.597801	2026-06-08 06:20:14.597832	1.00	0.00	0.00	1.00	1	1	Invoice generated for booking #BK202605091625	[{"product_id":99,"product_name":"zxxz","quantity":"1.0","price":"1.0","total":"1.0"}]	\N	2026-05-09 06:20:15.070444	2026-05-09 06:20:15.070444	YKViY4vAyPWjwuJ3CiIwQo_lqlwS4_JTXMzX-EWCguI
37	198	524	INV20260509C16053	2026-05-09 06:20:15.891188	2026-06-08 06:20:15.89127	1.00	0.00	0.00	1.00	1	1	Invoice generated for booking #BK202605091625	[{"product_id":99,"product_name":"zxxz","quantity":"1.0","price":"1.0","total":"1.0"}]	\N	2026-05-09 06:20:16.351278	2026-05-09 06:20:16.351278	VDHfkdORvEm1zUdJkb7I6dUK-ef9GbtvO5n9NJSTD8E
38	218	540	INV20260524A6467B	2026-05-24 12:43:31.094851	2026-06-23 12:43:31.094882	1.00	0.00	0.00	1.00	1	1	Invoice generated for booking #BK202605243741	[{"product_id":99,"product_name":"zxxz","quantity":"1.0","price":"1.0","total":"1.0"}]	\N	2026-05-24 12:43:31.531725	2026-05-24 12:43:31.531725	SI3wq7BDvxSU4ODPm6fcdcZ1X76ZSOHUIoep0-VNFYw
39	220	541	INV202605259B9A66	2026-05-25 05:02:33.503658	2026-06-24 05:02:33.503691	1.00	0.00	0.00	1.00	1	1	Invoice generated for booking #BK202605255894	[{"product_id":106,"product_name":"Raw","quantity":"1.0","price":"1.0","total":"1.0"}]	\N	2026-05-25 05:02:34.156452	2026-05-25 05:02:34.156452	1H5qhP257NXWcmQLNpzl4-_ueOIaCE24jCxtmIAEvX8
\.


--
-- Data for Name: booking_items; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.booking_items (id, booking_id, product_id, quantity, price, total, created_at, updated_at, product_variant_id) FROM stdin;
94	75	41	2.00	350.0	700.0	2026-03-19 09:39:03.137552	2026-03-19 09:39:03.137552	\N
95	76	42	1.00	650.0	650.0	2026-03-21 07:07:02.040847	2026-03-21 07:07:02.040847	\N
96	77	37	1.00	600.0	600.0	2026-03-21 07:08:58.493462	2026-03-21 07:08:58.493462	\N
97	78	38	1.00	270.0	270.0	2026-03-23 04:42:26.834461	2026-03-23 04:42:26.834461	\N
98	79	35	1.00	750.0	750.0	2026-03-24 03:55:24.662452	2026-03-24 03:55:24.662452	\N
99	80	46	2.00	130.0	260.0	2026-03-24 04:29:49.361441	2026-03-24 04:29:49.361441	\N
100	80	47	1.00	130.0	130.0	2026-03-24 04:29:55.850262	2026-03-24 04:29:55.850262	\N
101	81	35	2.00	750.0	1500.0	2026-03-24 10:58:24.980045	2026-03-24 10:58:24.980045	\N
102	82	35	2.00	750.0	1500.0	2026-03-24 10:59:22.105473	2026-03-24 10:59:22.105473	\N
103	83	35	2.00	750.0	1500.0	2026-03-24 11:00:36.5163	2026-03-24 11:00:36.5163	\N
104	84	35	2.00	750.0	1500.0	2026-03-24 11:01:11.300621	2026-03-24 11:01:11.300621	\N
105	85	47	3.00	130.0	390.0	2026-03-25 03:25:44.56704	2026-03-25 03:25:44.56704	\N
106	86	46	1.00	130.0	130.0	2026-03-25 04:22:59.963128	2026-03-25 04:22:59.963128	\N
107	87	49	1.00	100.0	100.0	2026-03-25 04:28:00.682795	2026-03-25 04:28:00.682795	\N
108	88	49	1.00	100.0	100.0	2026-03-25 04:33:55.775067	2026-03-25 04:33:55.775067	\N
109	89	49	1.00	100.0	100.0	2026-03-25 06:48:39.967015	2026-03-25 06:48:39.967015	\N
110	90	35	1.00	750.0	750.0	2026-03-25 07:07:15.603734	2026-03-25 07:07:15.603734	\N
111	91	41	1.00	350.0	350.0	2026-03-25 07:13:21.880822	2026-03-25 07:13:21.880822	\N
112	91	49	3.00	100.0	300.0	2026-03-25 07:13:24.70646	2026-03-25 07:13:24.70646	\N
113	91	47	1.00	130.0	130.0	2026-03-25 07:13:27.091765	2026-03-25 07:13:27.091765	\N
114	92	35	1.00	750.0	750.0	2026-03-25 07:50:28.97529	2026-03-25 07:50:28.97529	\N
115	93	35	1.00	750.0	750.0	2026-03-25 07:50:48.115913	2026-03-25 07:50:48.115913	\N
116	94	35	2.00	750.0	1500.0	2026-03-26 03:34:08.654629	2026-03-26 03:34:08.654629	\N
117	95	49	1.00	100.0	100.0	2026-03-26 04:41:57.239112	2026-03-26 04:41:57.239112	\N
118	96	49	1.00	100.0	100.0	2026-03-26 04:42:01.431032	2026-03-26 04:42:01.431032	\N
119	97	49	1.00	100.0	100.0	2026-03-26 04:42:01.850392	2026-03-26 04:42:01.850392	\N
120	98	49	1.00	100.0	100.0	2026-03-26 04:42:06.133447	2026-03-26 04:42:06.133447	\N
121	99	49	1.00	100.0	100.0	2026-03-26 04:42:38.927271	2026-03-26 04:42:38.927271	\N
122	99	43	1.00	490.0	490.0	2026-03-26 04:42:39.238588	2026-03-26 04:42:39.238588	\N
123	100	41	1.00	350.0	350.0	2026-03-26 04:46:27.68721	2026-03-26 04:46:27.68721	\N
124	100	49	4.00	100.0	400.0	2026-03-26 04:46:37.852671	2026-03-26 04:46:37.852671	\N
125	100	43	1.00	490.0	490.0	2026-03-26 04:46:40.208235	2026-03-26 04:46:40.208235	\N
126	101	49	1.00	100.0	100.0	2026-03-26 05:01:26.611069	2026-03-26 05:01:26.611069	\N
127	101	43	1.00	490.0	490.0	2026-03-26 05:01:29.399495	2026-03-26 05:01:29.399495	\N
128	102	35	1.00	750.0	750.0	2026-03-26 06:51:08.577394	2026-03-26 06:51:08.577394	\N
129	103	35	1.00	750.0	750.0	2026-03-26 06:52:54.11984	2026-03-26 06:52:54.11984	\N
130	104	49	1.00	100.0	100.0	2026-03-26 06:56:48.084677	2026-03-26 06:56:48.084677	\N
131	105	49	1.00	100.0	100.0	2026-03-26 07:25:17.899387	2026-03-26 07:25:17.899387	\N
132	106	49	1.00	100.0	100.0	2026-03-26 08:33:05.094017	2026-03-26 08:33:05.094017	\N
133	107	49	2.00	100.0	200.0	2026-03-26 08:43:15.064452	2026-03-26 08:43:15.064452	\N
134	108	49	1.00	100.0	100.0	2026-03-26 08:47:47.050134	2026-03-26 08:47:47.050134	\N
135	109	49	1.00	100.0	100.0	2026-03-26 10:19:50.183308	2026-03-26 10:19:50.183308	\N
136	110	35	2.00	750.0	1500.0	2026-03-28 12:35:45.592594	2026-03-28 12:35:45.592594	\N
137	111	35	2.00	750.0	1500.0	2026-03-28 12:35:55.862009	2026-03-28 12:35:55.862009	\N
138	112	35	2.00	750.0	1500.0	2026-03-28 12:35:55.854155	2026-03-28 12:35:55.854155	\N
139	113	35	2.00	750.0	1500.0	2026-03-28 12:36:23.330823	2026-03-28 12:36:23.330823	\N
140	114	35	2.00	750.0	1500.0	2026-03-28 12:36:42.774151	2026-03-28 12:36:42.774151	\N
141	115	47	1.00	130.0	130.0	2026-03-29 01:44:42.876341	2026-03-29 01:44:42.876341	\N
142	115	49	1.00	100.0	100.0	2026-03-29 01:44:57.267767	2026-03-29 01:44:57.267767	\N
143	116	38	1.00	270.0	270.0	2026-03-29 04:02:02.603738	2026-03-29 04:02:02.603738	\N
144	117	47	1.00	130.0	130.0	2026-03-29 04:08:17.329975	2026-03-29 04:08:17.329975	\N
145	118	47	1.00	130.0	130.0	2026-03-29 04:13:19.906712	2026-03-29 04:13:19.906712	\N
146	119	38	1.00	270.0	270.0	2026-03-29 05:29:01.903455	2026-03-29 05:29:01.903455	\N
147	120	49	1.00	100.0	100.0	2026-03-29 05:33:23.187119	2026-03-29 05:33:23.187119	\N
148	121	50	1.00	1.0	1.0	2026-03-29 05:38:48.879461	2026-03-29 05:38:48.879461	\N
149	122	50	1.00	1.0	1.0	2026-03-29 06:02:59.706512	2026-03-29 06:02:59.706512	\N
150	123	50	1.00	1.0	1.0	2026-03-29 06:21:25.334551	2026-03-29 06:21:25.334551	\N
151	124	50	1.00	1.0	1.0	2026-03-29 06:33:33.676361	2026-03-29 06:33:33.676361	\N
152	125	50	1.00	1.0	1.0	2026-03-29 06:53:33.636613	2026-03-29 06:53:33.636613	\N
153	126	50	1.00	1.0	1.0	2026-03-29 07:04:16.126595	2026-03-29 07:04:16.126595	\N
154	127	50	1.00	1.0	1.0	2026-03-29 07:04:17.114926	2026-03-29 07:04:17.114926	\N
155	128	50	1.00	1.0	1.0	2026-03-29 07:13:06.581735	2026-03-29 07:13:06.581735	\N
156	129	50	1.00	1.0	1.0	2026-03-29 10:03:42.01115	2026-03-29 10:03:42.01115	\N
157	130	50	1.00	1.0	1.0	2026-03-29 10:06:24.582848	2026-03-29 10:06:24.582848	\N
158	131	38	1.00	270.0	270.0	2026-03-29 10:06:56.365203	2026-03-29 10:06:56.365203	\N
159	132	38	1.00	270.0	270.0	2026-03-29 10:07:19.957879	2026-03-29 10:07:19.957879	\N
160	133	40	1.00	345.0	345.0	2026-03-29 10:08:36.67652	2026-03-29 10:08:36.67652	\N
161	134	40	1.00	345.0	345.0	2026-03-29 10:09:02.431239	2026-03-29 10:09:02.431239	\N
162	135	50	1.00	1.0	1.0	2026-03-29 10:17:20.219863	2026-03-29 10:17:20.219863	\N
163	135	40	1.00	345.0	345.0	2026-03-29 10:17:26.954002	2026-03-29 10:17:26.954002	\N
164	136	45	1.00	530.0	530.0	2026-03-29 10:18:08.048529	2026-03-29 10:18:08.048529	\N
165	137	50	1.00	1.0	1.0	2026-03-29 10:19:09.361031	2026-03-29 10:19:09.361031	\N
166	138	50	1.00	1.0	1.0	2026-03-29 10:23:52.37302	2026-03-29 10:23:52.37302	\N
167	139	50	1.00	1.0	1.0	2026-03-29 10:27:58.141785	2026-03-29 10:27:58.141785	\N
168	140	50	1.00	1.0	1.0	2026-03-29 10:31:11.072966	2026-03-29 10:31:11.072966	\N
169	141	50	1.00	1.0	1.0	2026-03-29 10:41:18.872434	2026-03-29 10:41:18.872434	\N
170	142	37	1.00	600.0	600.0	2026-04-16 07:38:08.134588	2026-04-16 07:38:08.134588	\N
171	142	46	2.00	130.0	260.0	2026-04-16 07:38:08.844798	2026-04-16 07:38:08.844798	\N
172	142	51	2.00	160.0	320.0	2026-04-16 07:38:09.546127	2026-04-16 07:38:09.546127	\N
173	142	52	2.00	80.0	160.0	2026-04-16 07:38:10.246506	2026-04-16 07:38:10.246506	\N
174	142	53	1.00	140.0	140.0	2026-04-16 07:38:10.945689	2026-04-16 07:38:10.945689	\N
175	143	50	3.00	1.0	3.0	2026-04-16 14:24:13.843626	2026-04-16 14:24:13.843626	\N
176	143	39	1.00	380.0	380.0	2026-04-16 14:24:14.69274	2026-04-16 14:24:14.69274	\N
177	144	54	2.00	600.0	1200.0	2026-04-19 15:26:25.136267	2026-04-19 15:26:25.136267	\N
178	145	37	1.00	600.0	600.0	2026-05-02 05:12:02.915968	2026-05-02 05:12:02.915968	\N
179	146	36	1.00	350.0	350.0	2026-05-02 12:46:53.487345	2026-05-02 12:46:53.487345	\N
181	148	35	1.00	750.0	750.0	2026-05-03 01:23:54.545695	2026-05-03 01:23:54.545695	\N
182	148	42	1.00	650.0	650.0	2026-05-03 01:23:55.418541	2026-05-03 01:23:55.418541	\N
183	149	42	1.00	650.0	650.0	2026-05-03 01:40:17.470456	2026-05-03 01:40:17.470456	\N
184	149	57	1.00	1035.0	1035.0	2026-05-03 01:40:18.332213	2026-05-03 01:40:18.332213	\N
185	150	56	1.00	1100.0	1100.0	2026-05-03 01:48:57.392643	2026-05-03 01:48:57.392643	\N
186	151	56	1.00	1100.0	1100.0	2026-05-03 01:55:05.363833	2026-05-03 01:55:05.363833	\N
187	152	37	1.00	600.0	600.0	2026-05-03 01:57:31.431703	2026-05-03 01:57:31.431703	\N
188	153	37	1.00	600.0	600.0	2026-05-03 01:58:22.557451	2026-05-03 01:58:22.557451	\N
189	154	37	1.00	600.0	600.0	2026-05-03 04:11:50.577717	2026-05-03 04:11:50.577717	\N
190	155	49	1.00	100.0	100.0	2026-05-03 04:12:35.395328	2026-05-03 04:12:35.395328	\N
191	156	52	1.00	80.0	80.0	2026-05-03 04:17:52.087102	2026-05-03 04:17:52.087102	\N
192	157	52	1.00	80.0	80.0	2026-05-03 04:20:59.710323	2026-05-03 04:20:59.710323	\N
193	158	39	1.00	380.0	380.0	2026-05-03 04:29:02.788664	2026-05-03 04:29:02.788664	\N
194	159	39	1.00	380.0	380.0	2026-05-03 04:43:58.478542	2026-05-03 04:43:58.478542	\N
195	160	42	1.00	650.0	650.0	2026-05-03 05:12:33.720607	2026-05-03 05:12:33.720607	\N
196	160	46	2.00	130.0	260.0	2026-05-03 05:12:34.42538	2026-05-03 05:12:34.42538	\N
197	161	54	1.00	600.0	600.0	2026-05-03 05:12:45.838372	2026-05-03 05:12:45.838372	\N
200	164	42	1.00	650.0	650.0	2026-05-03 06:28:50.250967	2026-05-03 06:28:50.250967	\N
201	164	46	2.00	130.0	260.0	2026-05-03 06:28:51.129655	2026-05-03 06:28:51.129655	\N
202	165	54	1.00	600.0	600.0	2026-05-03 06:29:13.287794	2026-05-03 06:29:13.287794	\N
203	166	36	1.00	100.0	100.0	2026-05-03 07:21:36.915758	2026-05-03 07:21:36.915758	\N
204	167	36	1.00	100.0	100.0	2026-05-03 07:23:07.915105	2026-05-03 07:23:07.915105	\N
205	168	57	1.00	100.0	100.0	2026-05-03 07:28:18.674224	2026-05-03 07:28:18.674224	\N
206	169	50	1.00	100.0	100.0	2026-05-03 07:33:23.660347	2026-05-03 07:33:23.660347	\N
207	170	36	1.00	350.0	350.0	2026-05-03 07:47:11.387212	2026-05-03 07:47:11.387212	\N
208	171	50	1.00	1.0	1.0	2026-05-03 07:48:47.788499	2026-05-03 07:48:47.788499	\N
209	172	50	1.00	1.0	1.0	2026-05-03 09:03:17.550952	2026-05-03 09:03:17.550952	\N
210	173	50	1.00	1.0	1.0	2026-05-03 09:03:54.548506	2026-05-03 09:03:54.548506	\N
211	174	50	1.00	1.0	1.0	2026-05-03 09:04:54.055119	2026-05-03 09:04:54.055119	\N
212	175	50	1.00	1.0	1.0	2026-05-03 09:05:20.400769	2026-05-03 09:05:20.400769	\N
213	176	50	1.00	1.0	1.0	2026-05-03 09:10:25.359177	2026-05-03 09:10:25.359177	\N
214	177	50	1.00	1.0	1.0	2026-05-03 09:12:36.07334	2026-05-03 09:12:36.07334	\N
215	178	50	1.00	1.0	1.0	2026-05-03 09:15:45.964706	2026-05-03 09:15:45.964706	\N
216	179	55	1.00	350.0	350.0	2026-05-03 10:02:44.191859	2026-05-03 10:02:44.191859	\N
217	180	50	1.00	1.0	1.0	2026-05-03 10:03:20.39931	2026-05-03 10:03:20.39931	\N
218	181	50	1.00	1.0	1.0	2026-05-03 10:13:56.611362	2026-05-03 10:13:56.611362	\N
219	182	50	1.00	1.0	1.0	2026-05-03 10:15:25.73258	2026-05-03 10:15:25.73258	\N
220	183	50	1.00	1.0	1.0	2026-05-03 10:18:49.488574	2026-05-03 10:18:49.488574	\N
221	184	50	1.00	1.0	1.0	2026-05-03 10:19:20.586677	2026-05-03 10:19:20.586677	\N
222	185	51	1.00	160.0	160.0	2026-05-03 11:03:35.461647	2026-05-03 11:03:35.461647	\N
223	186	50	1.00	1.0	1.0	2026-05-03 11:13:44.613669	2026-05-03 11:13:44.613669	\N
224	187	50	1.00	1.0	1.0	2026-05-03 11:14:10.908768	2026-05-03 11:14:10.908768	\N
225	188	55	1.00	350.0	350.0	2026-05-04 11:05:47.506187	2026-05-04 11:05:47.506187	\N
226	189	40	1.00	345.0	345.0	2026-05-06 15:48:05.270879	2026-05-06 15:48:05.270879	\N
227	189	85	1.00	119.0	119.0	2026-05-06 15:48:05.990183	2026-05-06 15:48:05.990183	\N
228	190	50	1.00	1.0	1.0	2026-05-09 04:44:38.435128	2026-05-09 04:44:38.435128	\N
229	190	98	1.00	160.0	160.0	2026-05-09 04:44:39.139258	2026-05-09 04:44:39.139258	\N
230	191	80	1.00	90.0	90.0	2026-05-09 05:38:43.525165	2026-05-09 05:38:43.525165	\N
231	192	50	1.00	1.0	1.0	2026-05-09 06:02:53.767426	2026-05-09 06:02:53.767426	\N
232	192	98	1.00	160.0	160.0	2026-05-09 06:02:54.456264	2026-05-09 06:02:54.456264	\N
233	193	94	1.00	65.0	65.0	2026-05-09 06:04:11.058207	2026-05-09 06:04:11.058207	\N
234	194	95	1.00	270.0	270.0	2026-05-09 06:05:23.744121	2026-05-09 06:05:23.744121	\N
235	195	94	1.00	65.0	65.0	2026-05-09 06:06:06.965376	2026-05-09 06:06:06.965376	\N
236	195	95	1.00	270.0	270.0	2026-05-09 06:06:07.750394	2026-05-09 06:06:07.750394	\N
237	196	99	1.00	1.0	1.0	2026-05-09 06:11:47.779862	2026-05-09 06:11:47.779862	\N
238	197	99	1.00	1.0	1.0	2026-05-09 06:14:23.884292	2026-05-09 06:14:23.884292	\N
239	198	99	1.00	1.0	1.0	2026-05-09 06:19:37.408693	2026-05-09 06:19:37.408693	\N
240	199	80	1.00	90.0	90.0	2026-05-09 06:24:36.645317	2026-05-09 06:24:36.645317	\N
241	200	99	1.00	1.0	1.0	2026-05-09 06:43:39.774225	2026-05-09 06:43:39.774225	\N
242	201	80	1.00	90.0	90.0	2026-05-09 13:09:32.715971	2026-05-09 13:09:32.715971	\N
243	202	59	1.00	290.0	290.0	2026-05-09 13:17:17.792504	2026-05-09 13:17:17.792504	\N
244	203	105	1.00	6.0	6.0	2026-05-10 00:32:44.630322	2026-05-10 00:32:44.630322	10
245	204	104	1.00	45.0	45.0	2026-05-10 05:09:12.87926	2026-05-10 05:09:12.87926	\N
246	204	105	1.00	44.55	44.55	2026-05-10 05:09:13.757563	2026-05-10 05:09:13.757563	9
247	205	105	1.00	6.0	6.0	2026-05-10 05:11:24.556328	2026-05-10 05:11:24.556328	\N
248	205	98	1.00	160.0	160.0	2026-05-10 05:11:25.411467	2026-05-10 05:11:25.411467	\N
249	206	106	1.00	1.0	1.0	2026-05-10 05:26:20.209752	2026-05-10 05:26:20.209752	\N
250	207	54	1.00	600.0	600.0	2026-05-10 07:04:05.205763	2026-05-10 07:04:05.205763	\N
251	208	106	1.00	1.0	1.0	2026-05-10 08:55:27.112822	2026-05-10 08:55:27.112822	\N
252	209	73	1.00	160.0	160.0	2026-05-10 08:56:03.206135	2026-05-10 08:56:03.206135	\N
253	210	81	1.00	180.0	180.0	2026-05-10 09:39:26.471587	2026-05-10 09:39:26.471587	\N
254	210	106	1.00	1.0	1.0	2026-05-10 09:39:27.434046	2026-05-10 09:39:27.434046	\N
255	210	59	1.00	290.0	290.0	2026-05-10 09:39:28.136083	2026-05-10 09:39:28.136083	\N
256	210	105	1.00	45.0	45.0	2026-05-10 09:39:28.830154	2026-05-10 09:39:28.830154	\N
257	211	106	1.00	1.0	1.0	2026-05-10 09:40:45.952004	2026-05-10 09:40:45.952004	\N
258	212	59	1.00	290.0	290.0	2026-05-10 09:58:09.671241	2026-05-10 09:58:09.671241	\N
259	212	78	1.00	600.0	600.0	2026-05-10 09:58:10.572019	2026-05-10 09:58:10.572019	\N
260	213	106	1.00	1.0	1.0	2026-05-14 02:01:04.214458	2026-05-14 02:01:04.214458	\N
261	214	58	1.00	280.0	280.0	2026-05-17 09:57:01.516547	2026-05-17 09:57:01.516547	\N
262	215	59	2.00	290.0	580.0	2026-05-17 10:10:59.232438	2026-05-17 10:10:59.232438	\N
263	216	70	1.00	90.0	90.0	2026-05-17 13:41:13.243648	2026-05-17 13:41:13.243648	\N
264	217	39	1.00	380.0	380.0	2026-05-24 12:36:19.911688	2026-05-24 12:36:19.911688	\N
265	218	99	1.00	1.0	1.0	2026-05-24 12:42:41.8159	2026-05-24 12:42:41.8159	\N
266	219	46	16.00	130.0	2080.0	2026-05-24 15:17:26.486113	2026-05-24 15:17:26.486113	\N
267	220	106	1.00	1.0	1.0	2026-05-25 05:01:26.797614	2026-05-25 05:01:26.797614	\N
268	221	83	3.00	180.0	540.0	2026-05-25 05:10:25.793649	2026-05-25 05:10:25.793649	\N
269	221	84	2.00	450.0	900.0	2026-05-25 05:10:26.692034	2026-05-25 05:10:26.692034	\N
270	221	39	1.00	380.0	380.0	2026-05-25 05:10:27.58623	2026-05-25 05:10:27.58623	\N
271	222	55	1.00	380.0	380.0	2026-06-02 15:46:27.932325	2026-06-02 15:46:27.932325	\N
272	223	58	1.00	280.0	280.0	2026-06-03 03:39:39.464304	2026-06-03 03:39:39.464304	\N
273	224	83	1.00	180.0	180.0	2026-06-03 03:42:14.936546	2026-06-03 03:42:14.936546	\N
274	224	84	1.00	450.0	450.0	2026-06-03 03:42:16.179037	2026-06-03 03:42:16.179037	\N
275	224	89	1.00	1675.0	1675.0	2026-06-03 03:42:17.00808	2026-06-03 03:42:17.00808	\N
276	224	44	1.00	370.0	370.0	2026-06-03 03:42:17.857248	2026-06-03 03:42:17.857248	\N
277	224	45	1.00	530.0	530.0	2026-06-03 03:42:18.715482	2026-06-03 03:42:18.715482	\N
278	225	99	1.00	1.0	1.0	2026-06-03 11:45:38.236813	2026-06-03 11:45:38.236813	\N
279	225	42	1.00	650.0	650.0	2026-06-03 11:45:42.09675	2026-06-03 11:45:42.09675	\N
280	226	42	1.00	650.0	650.0	2026-06-03 12:58:31.163518	2026-06-03 12:58:31.163518	\N
281	227	44	1.00	370.0	370.0	2026-06-03 15:48:35.557083	2026-06-03 15:48:35.557083	\N
282	228	45	1.00	530.0	530.0	2026-06-03 16:02:07.572691	2026-06-03 16:02:07.572691	\N
283	228	47	1.00	130.0	130.0	2026-06-03 16:02:08.770475	2026-06-03 16:02:08.770475	\N
284	228	52	1.00	80.0	80.0	2026-06-03 16:02:09.545988	2026-06-03 16:02:09.545988	\N
285	229	42	1.00	650.0	650.0	2026-06-04 09:39:28.189019	2026-06-04 09:39:28.189019	\N
286	230	37	1.00	600.0	600.0	2026-06-04 09:41:38.955876	2026-06-04 09:41:38.955876	\N
287	231	84	1.00	450.0	450.0	2026-06-04 11:08:14.519052	2026-06-04 11:08:14.519052	\N
288	232	105	1.00	45.0	45.0	2026-06-04 12:18:06.590712	2026-06-04 12:18:06.590712	\N
289	232	78	1.00	600.0	600.0	2026-06-04 12:18:07.571866	2026-06-04 12:18:07.571866	\N
290	232	55	1.00	380.0	380.0	2026-06-04 12:18:08.368828	2026-06-04 12:18:08.368828	\N
291	233	106	1.00	1.0	1.0	2026-06-04 12:46:37.638302	2026-06-04 12:46:37.638302	\N
292	234	78	1.00	600.0	600.0	2026-06-04 14:30:44.018894	2026-06-04 14:30:44.018894	\N
293	235	78	1.00	600.0	600.0	2026-06-04 14:31:25.03475	2026-06-04 14:31:25.03475	\N
294	236	78	1.00	600.0	600.0	2026-06-04 14:51:47.018835	2026-06-04 14:51:47.018835	\N
295	237	89	1.00	1675.0	1675.0	2026-06-04 15:09:27.503975	2026-06-04 15:09:27.503975	\N
296	238	55	8.00	380.0	3040.0	2026-06-06 09:47:29.893497	2026-06-06 09:47:29.893497	\N
297	239	106	1.00	1.0	1.0	2026-06-06 10:16:12.21025	2026-06-06 10:16:12.21025	\N
298	239	106	1.00	1.0	1.0	2026-06-06 10:16:13.183401	2026-06-06 10:16:13.183401	\N
299	240	83	1.00	180.0	180.0	2026-06-07 04:52:08.006538	2026-06-07 04:52:08.006538	\N
300	240	53	1.00	140.0	140.0	2026-06-07 04:52:09.036194	2026-06-07 04:52:09.036194	\N
301	240	96	1.00	135.0	135.0	2026-06-07 04:52:09.823404	2026-06-07 04:52:09.823404	\N
\.


--
-- Data for Name: booking_schedules; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.booking_schedules (id, customer_id, product_id, schedule_type, frequency, start_date, end_date, quantity, delivery_time, delivery_address, pincode, latitude, longitude, status, next_booking_date, total_bookings_generated, notes, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: bookings; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.bookings (id, customer_id, user_id, booking_number, booking_date, status, payment_method, payment_status, subtotal, tax_amount, discount_amount, total_amount, notes, booking_items, customer_name, customer_email, customer_phone, delivery_address, invoice_generated, invoice_number, cash_received, change_amount, created_at, updated_at, booking_schedule_id, stage, courier_service, tracking_number, shipping_charges, expected_delivery_date, delivery_person, delivery_contact, delivered_to, delivery_time, customer_satisfaction, processing_team, expected_completion_time, estimated_processing_time, estimated_delivery_time, package_weight, package_dimensions, quality_status, cancellation_reason, return_reason, return_condition, refund_amount, refund_method, transition_notes, stage_history, stage_updated_at, stage_updated_by, store_id, subscription_id, is_subscription, final_amount_after_discount, delivery_person_id, franchise_id, quick_invoice, booked_by, selected_shop_address, delivery_store, cashfree_order_id, payment_session_id, cashfree_payment_id, gateway_response, payment_gateway, payment_initiated_at, payment_completed_at, is_b2b) FROM stdin;
80	484	\N	BK202603241314	2026-03-24 04:29:43.560732	confirmed	2	unpaid	390.0	19.5	\N	409.5	\N	\N	Dharani Kannan	tkdharani@gmail.com	9655761911	Sample Address, Street 1, City Name, State Name - 123456	\N	\N	\N	\N	2026-03-24 04:29:49.085987	2026-03-24 04:29:49.085987	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	409.5	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
84	481	\N	BK202603243C2E44	2026-03-24 11:01:08.171152	draft	6	\N	1500.0	75.0	\N	1575.0	\N	\N	raghunandan kt	drwisedev@gmail.com	9844070041	123 Test Street, Test City	\N	\N	\N	\N	2026-03-24 11:01:11.052037	2026-03-24 11:01:11.052037	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1575.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cashfree	\N	\N	f
86	484	\N	BK202603251687	2026-03-25 04:22:50.029144	confirmed	2	unpaid	130.0	6.5	\N	136.5	\N	\N	Dharani Kannan	tkdharani@gmail.com	9655761911	Sample Address, Street 1, City Name, State Name - 123456	\N	\N	\N	\N	2026-03-25 04:22:59.103605	2026-03-25 04:22:59.103605	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	136.5	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
89	484	1	BK20260325333240	2026-03-24 18:30:00	completed	0	unpaid	100.0	5.0	0.0	105.0		\N	Dharani Kannan	tkdharani@gmail.com	9655761911	assa	\N	\N	\N	0.0	2026-03-25 06:48:39.715889	2026-03-25 06:48:39.715889	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	105.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
92	486	\N	BK202603258061	2026-03-25 07:50:23.660811	confirmed	5	paid	750.0	37.5	\N	787.5	\N	\N	Payment Test	paymenttest@test.com	9876543210	123 Test Street, Test City	\N	\N	\N	\N	2026-03-25 07:50:28.556241	2026-03-25 07:50:40.034921	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	787.5	\N	\N	f	admin	\N	\N	MKS_20260325132038_40DA3D6B	\N	\N	{"payment_method":"cod","order_status":"COMPLETED","payment_amount":"787.5"}	cashfree	2026-03-25 07:50:33.134022	2026-03-25 07:50:39.624904	f
78	484	\N	BK202603238636	2026-03-23 04:42:26.601017	completed	2	unpaid	270.0	13.5	\N	283.5	\N	\N	Dharani Kannan	tkdharani@gmail.com	9655761911	Sample Address, Street 1, City Name, State Name - 123456	\N	\N	\N	\N	2026-03-23 04:42:26.799151	2026-03-25 12:18:59.858635	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-25 06:47:00	5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Delivered to home 	[{"from_stage":"confirmed","to_stage":"delivered","timestamp":"2026-03-25T17:47:48.958+05:30","user_id":1,"user_name":"Admin User","delivery_person":"","delivery_time":"2026-03-25T12:17","customer_satisfaction":"5"},{"from_stage":"delivered","to_stage":"completed","timestamp":"2026-03-25T17:48:59.216+05:30","user_id":1,"user_name":"Admin User","notes":"Delivered to home "}]	2026-03-25 12:18:59.217031	1	\N	\N	\N	283.5	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
93	486	\N	BK202603253650	2026-03-25 07:50:45.255746	confirmed	5	paid	750.0	37.5	\N	787.5	\N	\N	Payment Test	paymenttest@test.com	9876543210	123 Test Street, Test City	\N	\N	\N	\N	2026-03-25 07:50:47.7166	2026-03-25 07:50:53.549309	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	787.5	\N	\N	f	admin	\N	\N	MKS_20260325132052_29ADA307	\N	\N	{"payment_method":"cod","order_status":"COMPLETED","payment_amount":"787.5"}	cashfree	2026-03-25 07:50:51.710411	2026-03-25 07:50:53.187926	f
95	481	\N	BK202603265323	2026-03-26 04:41:56.994696	confirmed	5	paid	100.0	5.0	\N	105.0	\N	\N	Customer Name	drwisedev@gmail.com	9876543210	PICKUP: abc,bcd,	\N	\N	\N	\N	2026-03-26 04:41:57.203324	2026-03-26 04:41:58.393479	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	105.0	\N	\N	f	admin	\N	\N	MKS_20260326101158_BB744B41	\N	\N	{"payment_method":"cod","order_status":"COMPLETED","payment_amount":"105.0"}	cashfree	2026-03-26 04:41:57.627136	2026-03-26 04:41:58.363759	f
102	\N	\N	BK202603263497	2026-03-26 06:51:00.889943	confirmed	5	paid	750.0	37.5	\N	787.5	\N	\N	Test Customer	test@cod.com	9876543210	PICKUP: Test Shop Location	\N	\N	\N	\N	2026-03-26 06:51:07.963248	2026-03-26 06:51:35.448241	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	787.5	\N	\N	f	admin	\N	\N	\N	\N	\N	{"payment_method":"cod","order_status":"COMPLETED","payment_amount":"787.5"}	cash	\N	2026-03-26 06:51:17.582657	f
97	481	\N	BK202603269319	2026-03-26 04:42:01.632651	confirmed	5	paid	100.0	5.0	\N	105.0	\N	\N	Customer Name	drwisedev@gmail.com	9876543210	PICKUP: abc,bcd,	\N	\N	\N	\N	2026-03-26 04:42:01.817736	2026-03-26 04:42:04.587415	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	105.0	\N	\N	f	admin	\N	\N	MKS_20260326101204_F36965B7	\N	\N	{"payment_method":"cod","order_status":"COMPLETED","payment_amount":"105.0"}	cashfree	2026-03-26 04:42:04.4305	2026-03-26 04:42:04.556365	f
112	481	\N	BK202603285228	2026-03-28 12:35:50.778954	confirmed	5	paid	1500.0	75.0	\N	1575.0	\N	\N	Customer Name	drwisedev@gmail.com	9876543210	PICKUP: abc,bcd,	\N	\N	\N	\N	2026-03-28 12:35:54.802204	2026-03-28 12:36:41.255952	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1575.0	\N	\N	f	admin	\N	\N	\N	\N	\N	{"payment_method":"cod","order_status":"COMPLETED","payment_amount":"1575.0"}	cash	\N	2026-03-28 12:36:41.000544	f
116	486	\N	BK202603295078	2026-03-29 02:51:41.364553	confirmed	5	unpaid	270.0	13.5	\N	283.5	\N	\N	Customer Name	paymenttest@test.com	9876543210	abc,bcd,	\N	\N	\N	\N	2026-03-29 04:02:01.130643	2026-03-29 04:02:01.130643	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	283.5	\N	\N	f	admin	\N	abc,bcd,	\N	\N	\N	\N	cash	\N	\N	f
106	481	\N	BK202603261832	2026-03-26 08:33:03.000907	confirmed	5	paid	100.0	5.0	\N	105.0	\N	\N	Customer Name	drwisedev@gmail.com	9876543210	PICKUP: abc,bcd,	\N	\N	\N	\N	2026-03-26 08:33:04.840023	2026-03-26 08:33:15.093713	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	105.0	\N	\N	f	admin	\N	\N	\N	\N	\N	{"payment_method":"cod","order_status":"COMPLETED","payment_amount":"105.0"}	cash	\N	2026-03-26 08:33:08.803886	f
108	481	\N	BK202603269007	2026-03-26 08:47:44.960094	confirmed	5	paid	100.0	5.0	\N	105.0	\N	\N	Customer Name	drwisedev@gmail.com	9876543210	PICKUP: abc,bcd,	\N	\N	\N	\N	2026-03-26 08:47:46.800437	2026-03-26 08:47:55.10005	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	105.0	\N	\N	f	admin	\N	\N	\N	\N	\N	{"payment_method":"cod","order_status":"COMPLETED","payment_amount":"105.0"}	cash	\N	2026-03-26 08:47:50.236188	f
104	487	1	BK20260326530FF8	2026-03-25 18:30:00	completed	0	paid	100.0	5.0	0.0	105.0		\N	Ajji G	mamathanagaraju08@gmail.com	9739001874	xdsds	t	INV20260326A71239	\N	0.0	2026-03-26 06:56:47.818555	2026-03-26 14:07:25.722023	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	105.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
110	481	\N	BK202603283269	2026-03-28 12:35:42.249109	confirmed	5	paid	1500.0	75.0	\N	1575.0	\N	\N	Customer Name	drwisedev@gmail.com	9876543210	PICKUP: abc,bcd,	\N	\N	\N	\N	2026-03-28 12:35:45.320334	2026-03-28 12:36:01.489369	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1575.0	\N	\N	f	admin	\N	\N	\N	\N	\N	{"payment_method":"cod","order_status":"COMPLETED","payment_amount":"1575.0"}	cash	\N	2026-03-28 12:35:51.488269	f
113	481	\N	BK202603289869	2026-03-28 12:36:19.63482	draft	5	paid	1500.0	75.0	\N	1575.0	\N	\N	Customer Name	drwisedev@gmail.com	9876543210	PICKUP: abc,bcd,	\N	\N	\N	\N	2026-03-28 12:36:23.027271	2026-03-28 12:37:01.998063	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1575.0	\N	\N	f	admin	\N	\N	\N	\N	\N	{"payment_method":"cod","order_status":"COMPLETED","payment_amount":"1575.0"}	cash	\N	2026-03-28 12:37:01.533486	f
100	481	\N	BK202603262829	2026-03-26 04:46:17.477381	draft	5	unpaid	1240.0	62.0	\N	1302.0	\N	\N	Customer Name	drwisedev@gmail.com	9876543210	PICKUP: abc,bcd,	t	INV202603264282FD	\N	\N	2026-03-26 04:46:27.363644	2026-03-29 01:36:34.734264	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1302.0	\N	\N	f	admin	\N	\N	MKS_20260326101648_095F7F98	\N	\N	{"failure_reason":"Transaction failed","failed_at":"2026-03-29T07:06:04.393+05:30"}	cashfree	2026-03-26 04:46:42.49063	2026-03-26 04:46:48.943235	f
119	486	\N	BK202603293522	2026-03-29 05:29:00.344689	draft	6	unpaid	270.0	13.5	\N	283.5	\N	\N	Customer Name	paymenttest@test.com	9876543210	abc,bcd,	\N	\N	\N	\N	2026-03-29 05:29:01.610417	2026-03-29 05:29:10.323473	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	283.5	\N	\N	f	admin	\N	abc,bcd,	MKS_20260329105908_BEC51955	session_aQBZJ_ChkcO40idNQIxldmhD7pwZ6F416qCkXYE1BrBlzgEQndV6uMEhVryDgU_7Kxk7RjS220CMGJt0sEQKiA_G2TDmjRSOaixXhrTbFW7UhO1uJANEUVuf3Hsujgpaymentpayment	\N	\N	cashfree	2026-03-29 05:29:09.099174	\N	f
122	486	\N	BK202603292270	2026-03-29 06:02:59.017736	draft	6	unpaid	1.0	0.0	\N	1.0	\N	\N	Customer Name	paymenttest@test.com	9876543210	abc,bcd,	\N	\N	\N	\N	2026-03-29 06:02:59.67041	2026-03-29 06:03:01.05382	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	admin	\N	abc,bcd,	MKS_20260329113300_EBADED60	\N	\N	{"failure_reason":"authentication Failed","failed_at":"2026-03-29T11:33:01.022+05:30"}	cashfree	2026-03-29 06:03:00.578042	\N	f
124	486	\N	BK202603295209	2026-03-29 06:33:33.464762	draft	6	unpaid	1.0	0.0	\N	1.0	\N	\N	Customer Name	paymenttest@test.com	9876543210	abc,bcd,	\N	\N	\N	\N	2026-03-29 06:33:33.64216	2026-03-29 06:33:35.051771	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	admin	\N	abc,bcd,	MKS_20260329120334_9C12F08C	session_9UQULUDo-nLZhYJRQIDcD-n8TAmOV8IRLWc5DF6R0eirhC24LbWTJAhp8B_gwW-ypYIWvi8Rw5yQ80BVtFqKPzXZLzmYYyrxLPgHS57X69iimImRYcGWeXuF_1tt	\N	\N	cashfree	2026-03-29 06:33:34.592743	\N	f
82	481	\N	BK2026032465D905	2026-03-24 10:59:13.561826	draft	2	paid	1500.0	75.0	\N	1575.0	\N	\N	raghunandan kt	drwisedev@gmail.com	9844070041	123 Test Street, Test City	\N	\N	\N	\N	2026-03-24 10:59:21.464158	2026-03-29 06:42:12.320612	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1575.0	\N	\N	f	admin	\N	\N	webhook_test_order_82	\N	test_payment_real_82	{"cf_payment_id":"test_payment_real_82","payment_method":"upi","order_status":"PAID","payment_amount":100.0,"bank_reference":"test_ref_82","auth_id":"test_auth_82"}	cashfree	\N	2026-03-29 06:42:05.432614	f
77	482	\N	BK202603211041	2026-03-21 07:08:58.307731	confirmed	2	unpaid	600.0	30.0	\N	630.0	\N	\N	John Doe	gepeucoubourou-9168@yopmail.com	7349673793	Sample Address, Street 1, City Name, State Name - 123456	\N	\N	\N	\N	2026-03-21 07:08:58.460299	2026-03-21 07:08:58.460299	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	630.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
79	484	\N	BK202603243672	2026-03-24 03:55:21.825438	confirmed	2	unpaid	750.0	37.5	\N	787.5	\N	\N	Dharani Kannan	tkdharani@gmail.com	9655761911	Sample Address, Street 1, City Name, State Name - 123456	\N	\N	\N	\N	2026-03-24 03:55:24.419089	2026-03-24 03:55:24.419089	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	787.5	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
83	481	\N	BK20260324C183D2	2026-03-24 11:00:29.742986	draft	6	\N	1500.0	75.0	\N	1575.0	\N	\N	raghunandan kt	drwisedev@gmail.com	9844070041	123 Test Street, Test City	\N	\N	\N	\N	2026-03-24 11:00:36.265809	2026-03-24 11:00:36.265809	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1575.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cashfree	\N	\N	f
85	484	\N	BK202603256117	2026-03-25 03:25:39.452761	confirmed	2	unpaid	390.0	19.5	\N	409.5	\N	\N	Dharani Kannan	tkdharani@gmail.com	9655761911	Sample Address, Street 1, City Name, State Name - 123456	\N	\N	\N	\N	2026-03-25 03:25:43.6437	2026-03-25 03:25:43.6437	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	409.5	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
87	484	\N	BK202603253240	2026-03-25 04:27:56.933892	confirmed	2	unpaid	100.0	5.0	\N	105.0	\N	\N	Dharani Kannan	tkdharani@gmail.com	9655761911	Sample Address, Street 1, City Name, State Name - 123456	\N	\N	\N	\N	2026-03-25 04:28:00.403264	2026-03-25 04:28:00.403264	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	105.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
88	484	\N	BK202603254355	2026-03-25 04:33:54.243829	confirmed	2	unpaid	100.0	5.0	\N	105.0	\N	\N	Dharani Kannan	tkdharani@gmail.com	9655761911	Sample Address, Street 1, City Name, State Name - 123456	\N	\N	\N	\N	2026-03-25 04:33:55.514376	2026-03-25 04:33:55.514376	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	105.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
130	486	\N	BK202603292302	2026-03-29 10:06:24.308278	confirmed	5	unpaid	1.0	0.0	\N	1.0	\N	\N	Customer Name	paymenttest@test.com	9876543210	abc,bcd,	\N	\N	\N	\N	2026-03-29 10:06:24.55184	2026-03-29 10:06:24.55184	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	admin	\N	abc,bcd,	\N	\N	\N	\N	cash	\N	\N	f
132	486	\N	BK202603299750	2026-03-29 10:07:19.777825	confirmed	5	unpaid	270.0	13.5	\N	283.5	\N	\N	Customer Name	paymenttest@test.com	9876543210	abc,bcd,	\N	\N	\N	\N	2026-03-29 10:07:19.927351	2026-03-29 10:07:19.927351	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	283.5	\N	\N	f	admin	\N	abc,bcd,	\N	\N	\N	\N	cash	\N	\N	f
107	481	\N	BK202603268892	2026-03-26 08:43:12.506946	confirmed	5	paid	200.0	10.0	\N	210.0	\N	\N	Customer Name	drwisedev@gmail.com	9876543210	PICKUP: abc,bcd,	\N	\N	\N	\N	2026-03-26 08:43:14.657575	2026-03-26 08:43:24.77067	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	210.0	\N	\N	f	admin	\N	\N	\N	\N	\N	{"payment_method":"cod","order_status":"COMPLETED","payment_amount":"210.0"}	cash	\N	2026-03-26 08:43:18.954632	f
90	486	\N	BK202603251338	2026-03-25 07:07:12.354208	draft	5	paid	750.0	37.5	\N	787.5	\N	\N	Payment Test	paymenttest@test.com	9876543210	123 Test Street, Test City	\N	\N	\N	\N	2026-03-25 07:07:15.343568	2026-03-25 07:07:23.606998	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	787.5	\N	\N	f	admin	\N	\N	MKS_20260325123722_B35BB1B2	\N	\N	{"payment_method":"cod","order_status":"COMPLETED","payment_amount":"787.5"}	cashfree	2026-03-25 07:07:18.537246	2026-03-25 07:07:23.351688	f
133	486	\N	BK202603297478	2026-03-29 10:08:36.493538	confirmed	5	unpaid	345.0	0.0	\N	345.0	\N	\N	Customer Name	paymenttest@test.com	9876543210	abc,bcd,	\N	\N	\N	\N	2026-03-29 10:08:36.645406	2026-03-29 10:08:36.645406	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	345.0	\N	\N	f	admin	\N	abc,bcd,	\N	\N	\N	\N	cash	\N	\N	f
91	484	\N	BK202603252619	2026-03-25 07:13:17.904197	confirmed	5	paid	780.0	39.0	\N	819.0	\N	\N	Customer Name	tkdharani@gmail.com	9876543210	PICKUP: abc,bcd,	\N	\N	\N	\N	2026-03-25 07:13:21.618501	2026-03-25 07:13:34.571703	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	819.0	\N	\N	f	admin	\N	\N	MKS_20260325124333_B4FBCAB4	\N	\N	{"payment_method":"cod","order_status":"COMPLETED","payment_amount":"819.0"}	cashfree	2026-03-25 07:13:29.419241	2026-03-25 07:13:34.252562	f
94	481	\N	BK2026032628F16A	2026-03-26 03:34:05.037557	confirmed	6	\N	1500.0	75.0	\N	1575.0	\N	\N	raghunandan kt	drwisedev@gmail.com	9844070041	123 Test Street, Test City, Test State - 12345	\N	\N	\N	\N	2026-03-26 03:34:08.386923	2026-03-26 03:34:16.858054	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1575.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cashfree	\N	\N	f
81	481	\N	BK20260324E2C6A5	2026-03-24 10:58:13.645738	confirmed	2	paid	1500.0	75.0	\N	1575.0	\N	\N	raghunandan kt	drwisedev@gmail.com	9844070041	123 Test Street, Test City	\N	\N	\N	\N	2026-03-24 10:58:24.686232	2026-03-26 03:38:30.588463	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1575.0	\N	\N	f	admin	\N	\N	\N	\N	TEST_PAYMENT_123	{"cf_payment_id":"TEST_PAYMENT_123","payment_method":"upi"}	cashfree	\N	2026-03-26 03:38:23.691343	f
96	481	\N	BK202603269770	2026-03-26 04:42:00.733774	confirmed	5	paid	100.0	5.0	\N	105.0	\N	\N	Customer Name	drwisedev@gmail.com	9876543210	PICKUP: abc,bcd,	\N	\N	\N	\N	2026-03-26 04:42:01.394745	2026-03-26 04:42:02.522262	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	105.0	\N	\N	f	admin	\N	\N	MKS_20260326101202_7DF73386	\N	\N	{"payment_method":"cod","order_status":"COMPLETED","payment_amount":"105.0"}	cashfree	2026-03-26 04:42:01.841465	2026-03-26 04:42:02.47948	f
76	482	\N	BK202603211826	2026-03-21 07:07:01.604412	confirmed	5	unpaid	650.0	32.5	\N	682.5	\N	\N	John Doe	gepeucoubourou-9168@yopmail.com	7349673793	Sample Address, Street 1, City Name, State Name - 123456	t	INV20260326581348	\N	\N	2026-03-21 07:07:02.009844	2026-03-26 03:40:09.769026	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	682.5	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
98	481	\N	BK202603263124	2026-03-26 04:42:05.895081	confirmed	5	paid	100.0	5.0	\N	105.0	\N	\N	Customer Name	drwisedev@gmail.com	9876543210	PICKUP: abc,bcd,	\N	\N	\N	\N	2026-03-26 04:42:06.099374	2026-03-26 04:42:06.615006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	105.0	\N	\N	f	admin	\N	\N	MKS_20260326101206_2A126032	\N	\N	{"payment_method":"cod","order_status":"COMPLETED","payment_amount":"105.0"}	cashfree	2026-03-26 04:42:06.443327	2026-03-26 04:42:06.581358	f
99	481	\N	BK202603269739	2026-03-26 04:42:38.567331	confirmed	5	paid	590.0	29.5	\N	619.5	\N	\N	Customer Name	drwisedev@gmail.com	9876543210	PICKUP: abc,bcd,	\N	\N	\N	\N	2026-03-26 04:42:38.893055	2026-03-26 04:42:39.744988	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	619.5	\N	\N	f	admin	\N	\N	MKS_20260326101239_D8ED92FA	\N	\N	{"payment_method":"cod","order_status":"COMPLETED","payment_amount":"619.5"}	cashfree	2026-03-26 04:42:39.58403	2026-03-26 04:42:39.711922	f
101	481	\N	BK202603262029	2026-03-26 05:01:23.746519	confirmed	5	paid	590.0	29.5	\N	619.5	\N	\N	Customer Name	drwisedev@gmail.com	9876543210	PICKUP: abc,bcd,	\N	\N	\N	\N	2026-03-26 05:01:26.345019	2026-03-26 05:01:35.819676	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	619.5	\N	\N	f	admin	\N	\N	\N	\N	\N	{"payment_method":"cod","order_status":"COMPLETED","payment_amount":"619.5"}	cash	\N	2026-03-26 05:01:31.665863	f
103	\N	\N	BK202603268254	2026-03-26 06:52:48.751418	draft	5	\N	750.0	37.5	\N	787.5	\N	\N	Test Customer	test@cod.com	9876543210	PICKUP: Shop 1	\N	\N	\N	\N	2026-03-26 06:52:53.192816	2026-03-26 06:52:53.192816	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	787.5	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
105	481	\N	BK202603265071	2026-03-26 07:25:15.288773	confirmed	5	paid	100.0	5.0	\N	105.0	\N	\N	Customer Name	drwisedev@gmail.com	9876543210	PICKUP: abc,bcd,	\N	\N	\N	\N	2026-03-26 07:25:17.645312	2026-03-26 07:25:32.072861	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	105.0	\N	\N	f	admin	\N	\N	\N	\N	\N	{"payment_method":"cod","order_status":"COMPLETED","payment_amount":"105.0"}	cash	\N	2026-03-26 07:25:22.71677	f
109	481	\N	BK202603269097	2026-03-26 10:19:43.744281	confirmed	5	paid	100.0	5.0	\N	105.0	\N	\N	Customer Name	drwisedev@gmail.com	9876543210	PICKUP: abc,bcd,	\N	\N	\N	\N	2026-03-26 10:19:49.286263	2026-03-26 10:19:56.883258	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	105.0	\N	\N	f	admin	\N	\N	\N	\N	\N	{"payment_method":"cod","order_status":"COMPLETED","payment_amount":"105.0"}	cash	\N	2026-03-26 10:19:56.271183	f
111	481	\N	BK202603286450	2026-03-28 12:35:50.777371	confirmed	5	paid	1500.0	75.0	\N	1575.0	\N	\N	Customer Name	drwisedev@gmail.com	9876543210	PICKUP: abc,bcd,	\N	\N	\N	\N	2026-03-28 12:35:54.796108	2026-03-28 12:36:21.036987	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1575.0	\N	\N	f	admin	\N	\N	\N	\N	\N	{"payment_method":"cod","order_status":"COMPLETED","payment_amount":"1575.0"}	cash	\N	2026-03-28 12:36:20.533182	f
117	486	\N	BK202603298827	2026-03-29 04:08:15.465939	confirmed	5	unpaid	130.0	6.5	\N	136.5	\N	\N	Customer Name	paymenttest@test.com	9876543210	abc,bcd,	\N	\N	\N	\N	2026-03-29 04:08:17.066596	2026-03-29 04:08:17.066596	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	136.5	\N	\N	f	admin	\N	abc,bcd,	\N	\N	\N	\N	cash	\N	\N	f
114	481	\N	BK202603287537	2026-03-28 12:36:39.329502	draft	5	paid	1500.0	75.0	\N	1575.0	\N	\N	Customer Name	drwisedev@gmail.com	9876543210	PICKUP: abc,bcd,	\N	\N	\N	\N	2026-03-28 12:36:42.417167	2026-03-28 12:37:18.393942	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1575.0	\N	\N	f	admin	\N	\N	\N	\N	\N	{"payment_method":"cod","order_status":"COMPLETED","payment_amount":"1575.0"}	cash	\N	2026-03-28 12:37:16.930648	f
115	486	\N	BK202603298039	2026-03-29 01:44:34.449158	confirmed	2	unpaid	230.0	11.5	\N	241.5	\N	\N	Payment Test	paymenttest@test.com	9876543210	Sample Address, Street 1, City Name, State Name - 123456	\N	\N	\N	\N	2026-03-29 01:44:42.606375	2026-03-29 01:44:42.606375	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	241.5	\N	\N	f	admin	\N	abc,bcd	\N	\N	\N	\N	cash	\N	\N	f
118	486	\N	BK202603295267	2026-03-29 04:12:45.638318	confirmed	5	unpaid	130.0	6.5	\N	136.5	\N	\N	Customer Name	paymenttest@test.com	9876543210	abc,bcd,	\N	\N	\N	\N	2026-03-29 04:13:18.460375	2026-03-29 04:13:18.460375	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	136.5	\N	\N	f	admin	\N	abc,bcd,	\N	\N	\N	\N	cash	\N	\N	f
120	486	\N	BK202603299503	2026-03-29 05:33:21.109695	draft	6	unpaid	100.0	5.0	\N	105.0	\N	\N	Customer Name	paymenttest@test.com	9876543210	abc,bcd,	\N	\N	\N	\N	2026-03-29 05:33:22.825499	2026-03-29 05:33:29.387847	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	105.0	\N	\N	f	admin	\N	abc,bcd,	MKS_20260329110326_114874F0	session_t1c8xizXsC6nPZnEWSiupbBVQhrtsTivmJgNy7RIad7B8fOVYZupRhuefi626mZU3lOBda-JOYIUj1_zOkaz0DsVWrHG1NmLOL0AhnexGSbRGvvCYLbuAXUwxG8z7gpaymentpayment	\N	\N	cashfree	2026-03-29 05:33:27.45196	\N	f
121	486	\N	BK202603291596	2026-03-29 05:38:45.035273	draft	6	unpaid	1.0	0.0	\N	1.0	\N	\N	Customer Name	paymenttest@test.com	9876543210	abc,bcd,	\N	\N	\N	\N	2026-03-29 05:38:48.622463	2026-03-29 05:38:57.6234	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	admin	\N	abc,bcd,	MKS_20260329110856_DFF55C67	session_lvBy0maSef4aHZ1lxq45Vaj0ltMz00DpT6fnGEhmWBdIPnp_T597welEwQZWX6rJYW8WMFYPgIyaf6xST7ovXhdEHnd5CavNugMqjCgALPEsUnOYXj0YLa5skPPfTApaymentpayment	\N	\N	cashfree	2026-03-29 05:38:56.591078	\N	f
126	486	\N	BK202603291670	2026-03-29 07:04:15.153148	confirmed	2	paid	1.0	0.0	\N	1.0	\N	\N	Customer Name	paymenttest@test.com	9876543210	abc,bcd,	\N	\N	\N	\N	2026-03-29 07:04:16.095371	2026-03-29 07:04:51.336624	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	admin	\N	abc,bcd,	MKS_20260329123416_EE6AAB25	session_TFDZ8sBYaNKGx50XsDsvdRuZTCeSYozOBaXO-OQppuAYDBvcvyqE2IWLNHE7lUya95GmGftHRzYKlgSDMMHC_8lKvhtUR4_-czHRL1Ro73u0v9lUr5MiNLu3Qt5l	5253745760	{"cf_payment_id":5253745760,"payment_method":"upi","order_status":"PAID","payment_amount":1.0,"bank_reference":"967523209146","auth_id":null}	cashfree	2026-03-29 07:04:17.014132	2026-03-29 07:04:51.196425	f
208	528	\N	BK202605107201	2026-05-10 08:55:26.505673	confirmed	5	unpaid	1.0	0.0	\N	1.0	\N	\N	Eeuhhhj Ggbbvh	hah@gmail.com	9632859632	Hrh	\N	\N	\N	\N	2026-05-10 08:55:26.991147	2026-05-10 08:55:26.991147	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
209	518	93	BK20260510BEE5B5	2026-05-09 18:30:00	completed	0	unpaid	152.0	8.0	0.0	160.0	assa	\N	Bdbhd Nxn	pramodbha87@gmail.com	9632850870	sd	\N	\N	\N	0.0	2026-05-10 08:56:03.126915	2026-05-10 08:56:03.126915	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	160.0	\N	12	f	franchise	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
131	486	\N	BK202603298339	2026-03-29 10:06:56.149862	confirmed	5	unpaid	270.0	13.5	\N	283.5	\N	\N	Customer Name	paymenttest@test.com	9876543210	abc,bcd,	\N	\N	\N	\N	2026-03-29 10:06:56.331161	2026-03-29 10:06:56.331161	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	283.5	\N	\N	f	admin	\N	abc,bcd,	\N	\N	\N	\N	cash	\N	\N	f
134	486	\N	BK202603292419	2026-03-29 10:09:02.246428	confirmed	5	unpaid	345.0	0.0	\N	345.0	\N	\N	Customer Name	paymenttest@test.com	9876543210	abc,bcd,	\N	\N	\N	\N	2026-03-29 10:09:02.401482	2026-03-29 10:09:02.401482	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	345.0	\N	\N	f	admin	\N	abc,bcd,	\N	\N	\N	\N	cash	\N	\N	f
123	486	\N	BK202603298398	2026-03-29 06:21:24.825326	draft	6	unpaid	1.0	0.0	\N	1.0	\N	\N	Customer Name	paymenttest@test.com	9876543210	abc,bcd,	\N	\N	\N	\N	2026-03-29 06:21:25.304737	2026-03-29 06:21:26.723315	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	admin	\N	abc,bcd,	MKS_20260329115126_3D9B85D0	session_zA4u5SkO3iH_ToMvyydoryMZ37roc3G70Us5OvpvPNjAEva3a2a1McThk0L0Q5VQwxX_Wgspk2f0XM6vn7MosBItyJDwCc0KfAtoKbkESOA2e0Gfms7uNbwXcrsD	\N	\N	cashfree	2026-03-29 06:21:26.117024	\N	f
127	486	\N	BK202603293592	2026-03-29 07:04:16.926115	draft	6	unpaid	1.0	0.0	\N	1.0	\N	\N	Customer Name	paymenttest@test.com	9876543210	abc,bcd,	\N	\N	\N	\N	2026-03-29 07:04:17.084312	2026-03-29 07:04:19.223562	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	admin	\N	abc,bcd,	MKS_20260329123418_83E4D949	session_1_HbbYf1ZEXrl8iZ93zVvTK8r5AuKVDKwNc59uZQ-Qyv3tWSclkZOkT2_m7hTd1ZeqhZq5pz2yjLvnSedgQfnZQUflG08JRWNXstMajMFfLHp06p_uZTBDdbealU	\N	\N	cashfree	2026-03-29 07:04:18.767152	\N	f
128	486	\N	BK202603295419	2026-03-29 07:13:06.295923	confirmed	2	paid	1.0	0.0	\N	1.0	\N	\N	Customer Name	paymenttest@test.com	9876543210	abc,bcd,	\N	\N	\N	\N	2026-03-29 07:13:06.495304	2026-03-29 07:13:47.437691	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	admin	\N	abc,bcd,	MKS_20260329124306_ECB740D7	session_seYJXy20lx9Af5Z7lrNpmJ-ktbDwDWdgQyngGsnu5dW2CNi6MM6dpvzYEp8ZuJ8IMxqGWJgWZ4t1fWHhGtBYfGuheNobmithWRshDfvSh9yKgNC4i8YvAzK0pTcy	5253780159	{"cf_payment_id":5253780159,"payment_method":"upi","order_status":"PAID","payment_amount":1.0,"bank_reference":"912011262139","auth_id":null}	cashfree	2026-03-29 07:13:06.916614	2026-03-29 07:13:47.318184	f
135	486	\N	BK202603299933	2026-03-29 10:17:08.041589	confirmed	5	unpaid	346.0	0.0	\N	346.0	\N	\N	Customer Name	paymenttest@test.com	9876543210	abc,bcd,	\N	\N	\N	\N	2026-03-29 10:17:18.616588	2026-03-29 10:17:18.616588	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	346.0	\N	\N	f	admin	\N	abc,bcd,	\N	\N	\N	\N	cash	\N	\N	f
137	486	\N	BK202603292375	2026-03-29 10:19:04.862714	confirmed	5	unpaid	1.0	0.0	\N	1.0	\N	\N	Customer Name	paymenttest@test.com	9876543210	abc,bcd,	\N	\N	\N	\N	2026-03-29 10:19:08.076431	2026-03-29 10:19:08.076431	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	admin	\N	abc,bcd,	\N	\N	\N	\N	cash	\N	\N	f
125	486	\N	BK202603299963	2026-03-29 06:53:32.799215	confirmed	2	paid	1.0	0.0	\N	1.0	\N	\N	Customer Name	paymenttest@test.com	9876543210	abc,bcd,	\N	\N	\N	\N	2026-03-29 06:53:33.604453	2026-03-29 06:54:04.537799	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	admin	\N	abc,bcd,	MKS_20260329122334_E5BB50BA	session_qkDbOqSCLTmhvZXdN7p9Zra91Ne5EMU7azXZlpSnM85fyQMSCK-C-o7yPFI50R3UKOjA58voEocjMpQOIW3-XhtGR1fe9oPWV3iodUWSZJNrnS1SPpe6lfFelVym	5253704533	{"cf_payment_id":5253704533,"payment_method":"upi","order_status":"PAID","payment_amount":1.0,"bank_reference":"075466707749","auth_id":null}	cashfree	2026-03-29 06:53:34.518227	2026-03-29 06:54:03.182937	f
129	486	\N	BK202603299884	2026-03-29 10:03:41.819754	confirmed	2	paid	1.0	0.0	\N	1.0	\N	\N	Customer Name	paymenttest@test.com	9876543210	abc,bcd,	\N	\N	\N	\N	2026-03-29 10:03:41.982828	2026-03-29 10:04:23.856267	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	admin	\N	abc,bcd,	MKS_20260329153342_43D26D56	session_O-wFG0WDwq2OYWsbad56tkjwZjcofbwt2O09LRGlVzGwIcbT3f6EBqIyOtGrxz_6l8047fQtaDHsNEv61b-CBkm8RQB_pj3j-wjTnrDxQMY73c6OOHS7fuaFxujJ	5254661112	{"cf_payment_id":"5254661112","payment_method":"upi","order_status":"PAID","payment_amount":1.0,"bank_reference":"927065988467","auth_id":null}	cashfree	2026-03-29 10:03:42.84789	2026-03-29 10:04:23.722716	f
136	486	\N	BK202603291331	2026-03-29 10:18:04.395767	confirmed	5	unpaid	530.0	26.5	\N	556.5	\N	\N	Customer Name	paymenttest@test.com	9876543210	abc,bcd,	\N	\N	\N	\N	2026-03-29 10:18:07.367645	2026-03-29 10:18:07.367645	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	556.5	\N	\N	f	admin	\N	abc,bcd,	\N	\N	\N	\N	cash	\N	\N	f
138	486	\N	BK202603296916	2026-03-29 10:23:50.42873	confirmed	5	unpaid	1.0	0.0	\N	1.0	\N	\N	Customer Name	paymenttest@test.com	9876543210	abc,bcd,	\N	\N	\N	\N	2026-03-29 10:23:52.073634	2026-03-29 10:23:52.073634	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	admin	\N	abc,bcd,	\N	\N	\N	\N	cash	\N	\N	f
139	486	\N	BK202603297255	2026-03-29 10:27:55.577459	confirmed	5	unpaid	1.0	0.0	\N	1.0	\N	\N	Customer Name	paymenttest@test.com	9876543210	abc,bcd,	\N	\N	\N	\N	2026-03-29 10:27:57.824112	2026-03-29 10:27:57.824112	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	admin	\N	abc,bcd,	\N	\N	\N	\N	cash	\N	\N	f
140	486	\N	BK202603291834	2026-03-29 10:31:09.20468	confirmed	5	unpaid	1.0	0.0	\N	1.0	\N	\N	Payment Test	paymenttest@test.com	9876543210	Sample Address, Street 1, City Name, State Name - 123456	\N	\N	\N	\N	2026-03-29 10:31:10.743647	2026-03-29 10:31:10.743647	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	admin	\N	abc,bcd	\N	\N	\N	\N	cash	\N	\N	f
142	\N	1	BK202604164B395B	2026-04-15 18:30:00	packed	4	unpaid	1480.0	74.0	0.0	1554.0	Porter shipment 	\N	Ramya madhusudhan 		+91 99866 32326	LnT Raintree boulevard	t	INV20260416BEC96E	\N	0.0	2026-04-16 07:38:08.054443	2026-04-16 11:19:13.289885	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1554.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
141	486	\N	BK202603291709	2026-03-29 10:41:18.672402	confirmed	5	unpaid	1.0	0.0	\N	1.0	\N	\N	Payment Test	paymenttest@test.com	9876543210	Sample Address, Street 1, City Name, State Name - 123456	t	INV202604162B3EFA	\N	\N	2026-03-29 10:41:18.841403	2026-04-16 11:48:05.595508	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	admin	\N	abc,bcd	\N	\N	\N	\N	cash	\N	\N	f
143	495	\N	BK202604165814	2026-04-16 14:24:13.071771	draft	6	unpaid	383.0	19.0	\N	402.0	\N	\N	Ramya V	ramyav244@gmail.com	7975374829	Sample Address, Street 1, City Name, State Name - 123456	\N	\N	\N	\N	2026-04-16 14:24:13.763566	2026-04-16 14:24:16.074143	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	402.0	\N	\N	f	admin	\N	abc,bcd	MKS_20260416195415_C75F2D29	\N	\N	{"failure_reason":"order_meta.return_url : invalid url entered. Value received: 2/payment/success?booking_id=143","failed_at":"2026-04-16T19:54:15.996+05:30"}	cashfree	2026-04-16 14:24:15.527322	\N	f
201	514	\N	BK202605094191	2026-05-09 13:09:32.175246	confirmed	5	unpaid	85.5	4.5	\N	90.0	\N	\N	Rajesh Raj	raj3@gmail.com	9879879871	bangalore	\N	\N	\N	\N	2026-05-09 13:09:32.637695	2026-05-09 13:09:32.637695	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	90.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
144	\N	1	BK2026041904E672	2026-04-18 18:30:00	processing	2	unpaid	1200.0	60.0	0.0	1260.0		\N	srikanth 		+91 93412 82244	ramamurthy nagar 	t	INV20260419F94193	\N	0.0	2026-04-19 15:26:25.053352	2026-04-19 15:31:06.764845	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	[{"from_stage":"completed","to_stage":"processing","timestamp":"2026-04-19T21:00:41.478+05:30","user_id":1,"user_name":"Admin User"}]	2026-04-19 15:30:41.478992	1	\N	\N	\N	1260.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
145	486	1	BK2026050246AA12	2026-05-01 18:30:00	completed	0	unpaid	600.0	30.0	0.0	630.0		\N	Payment Test	paymenttest@test.com	9876543210	sd	\N	\N	\N	0.0	2026-05-02 05:12:02.837203	2026-05-02 05:12:02.837203	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	630.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
146	514	\N	BK20260502963D66	2026-05-02 12:46:49.945278	ordered_and_delivery_pending	5	\N	350.0	0.0	\N	350.0	\N	\N	Rajesh Raj	raj3@gmail.com	9879879871	Test bangalore	\N	\N	\N	\N	2026-05-02 12:46:53.403089	2026-05-02 12:46:53.403089	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	350.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
197	524	\N	BK202605091460	2026-05-09 06:14:21.942798	draft	2	unpaid	1.0	0.0	\N	1.0	\N	\N	test bhat	test@gmail.com	9797979797	Sample Address, Street 1, City Name, State Name - 123456	t	INV-05-00001	\N	\N	2026-05-09 06:14:23.584174	2026-05-09 06:22:52.473128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	t	admin	\N	abc,bcd	MKS_20260509114433_D1F5F1B7	session_CIuJBgzUI-MzSR7W5wwWUnEIGXlz7o_zgQDUt9b69ubbK-aKIDEbkQkKuYrlSelnZ3fsVZFq-DRAqH_RI10gYLkXgFEpqds-NqndKKlj7URRaOFdja6kMml8od4o	\N	\N	cashfree	2026-05-09 06:14:33.855293	\N	f
204	494	1	BK2026051034D4EB	2026-05-09 18:30:00	completed	0	unpaid	87.75	1.8	0.0	89.55		\N	Abhishek Vadoni	abhishekvadoni@gmail.com	7026182080	sds	\N	\N	\N	0.0	2026-05-10 05:09:12.79862	2026-05-10 05:09:12.79862	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	89.55	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
206	527	\N	BK202605101661	2026-05-10 05:26:19.725959	confirmed	5	unpaid	1.0	0.0	\N	1.0	\N	\N	sds sds	909dsds3939393fdfds@gmail.com	8888999999	Sample Address, Street 1, City Name, State Name - 123456	\N	\N	\N	\N	2026-05-10 05:26:20.126627	2026-05-10 05:26:20.126627	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	admin	\N	abc,bcd	\N	\N	\N	\N	cash	\N	\N	f
148	515	\N	BK202605035578	2026-05-03 01:23:53.6763	draft	2	unpaid	1367.5	32.5	\N	1400.0	\N	\N	ssd ds	pramodbha88@gmail.com	9292919191	Sample Address, Street 1, City Name, State Name - 123456	\N	\N	\N	\N	2026-05-03 01:23:54.463839	2026-05-03 01:23:58.796063	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1400.0	\N	\N	f	admin	\N	abc,bcd	MKS_20260503065357_A914E806	\N	\N	{"failure_reason":"order_meta.return_url : invalid url entered. Value received: 2/payment/success?booking_id=148","failed_at":"2026-05-03T06:53:58.716+05:30"}	cashfree	2026-05-03 01:23:57.60151	\N	f
149	515	\N	BK202605035026	2026-05-03 01:40:16.676895	draft	2	unpaid	1600.75	84.25	\N	1685.0	\N	\N	ssd ds	pramodbha88@gmail.com	9292919191	Sample Address, Street 1, City Name, State Name - 123456	\N	\N	\N	\N	2026-05-03 01:40:17.391336	2026-05-03 01:40:21.506505	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1685.0	\N	\N	f	admin	\N	abc,bcd	MKS_20260503071020_E9C75C0C	\N	\N	{"failure_reason":"order_meta.return_url : invalid url entered. Value received: 2/payment/success?booking_id=149","failed_at":"2026-05-03T07:10:21.428+05:30"}	cashfree	2026-05-03 01:40:20.331557	\N	f
150	515	\N	BK202605035500	2026-05-03 01:48:56.791127	draft	2	unpaid	1045.0	55.0	\N	1100.0	\N	\N	ssd ds	pramodbha88@gmail.com	9292919191	Sample Address, Street 1, City Name, State Name - 123456	\N	\N	\N	\N	2026-05-03 01:48:57.314136	2026-05-03 01:49:00.07553	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1100.0	\N	\N	f	admin	\N	abc,bcd	MKS_20260503071859_ECA42A46	\N	\N	{"failure_reason":"order_meta.return_url : invalid url entered. Value received: 2/payment/success?booking_id=150","failed_at":"2026-05-03T07:18:59.999+05:30"}	cashfree	2026-05-03 01:48:59.527721	\N	f
151	515	\N	BK202605035642	2026-05-03 01:55:04.73454	confirmed	5	unpaid	1045.0	55.0	\N	1100.0	\N	\N	ssd ds	pramodbha88@gmail.com	9292919191	Sample Address, Street 1, City Name, State Name - 123456	\N	\N	\N	\N	2026-05-03 01:55:05.283238	2026-05-03 01:55:05.283238	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1100.0	\N	\N	f	admin	\N	abc,bcd	\N	\N	\N	\N	cash	\N	\N	f
152	515	\N	BK202605035441	2026-05-03 01:57:30.022162	draft	6	unpaid	570.0	30.0	\N	600.0	\N	\N	ssd ds	pramodbha88@gmail.com	9292919191	Sample Address, Street 1, City Name, State Name - 123456	\N	\N	\N	\N	2026-05-03 01:57:31.348748	2026-05-03 01:57:34.743385	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	600.0	\N	\N	f	admin	\N	abc,bcd	MKS_20260503072733_064329F7	\N	\N	{"failure_reason":"order_meta.return_url : invalid url entered. Value received: 2/payment/success?booking_id=152","failed_at":"2026-05-03T07:27:34.662+05:30"}	cashfree	2026-05-03 01:57:33.699938	\N	f
153	515	\N	BK202605032298	2026-05-03 01:58:22.004419	draft	2	unpaid	570.0	30.0	\N	600.0	\N	\N	ssd ds	pramodbha88@gmail.com	9292919191	Sample Address, Street 1, City Name, State Name - 123456	\N	\N	\N	\N	2026-05-03 01:58:22.478003	2026-05-03 01:58:25.279834	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	600.0	\N	\N	f	admin	\N	abc,bcd	MKS_20260503072824_B9AE3B7B	\N	\N	{"failure_reason":"order_meta.return_url : invalid url entered. Value received: 2/payment/success?booking_id=153","failed_at":"2026-05-03T07:28:25.201+05:30"}	cashfree	2026-05-03 01:58:24.739706	\N	f
154	515	\N	BK202605039207	2026-05-03 04:11:50.041181	draft	2	unpaid	570.0	30.0	\N	600.0	\N	\N	ssd ds	pramodbha88@gmail.com	9292919191	Sample Address, Street 1, City Name, State Name - 123456	\N	\N	\N	\N	2026-05-03 04:11:50.499685	2026-05-03 04:11:53.378248	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	600.0	\N	\N	f	admin	\N	abc,bcd	MKS_20260503094152_1EBEE126	session_GaExAMm07MJ9Z_OOKwmF0coLFyj_z-w4xttI20dRQ-_4WHKg_5aCCRXy7faLVCJC744iO99ygrRgE9pN9zcHmUBljPSFs7Tslgq2Dp471B-i5ZWrWkxc9sSFjKmF	\N	\N	cashfree	2026-05-03 04:11:52.712751	\N	f
155	515	\N	BK202605039695	2026-05-03 04:12:34.923352	draft	2	unpaid	95.0	5.0	\N	100.0	\N	\N	ssd ds	pramodbha88@gmail.com	9292919191	Sample Address, Street 1, City Name, State Name - 123456	\N	\N	\N	\N	2026-05-03 04:12:35.307698	2026-05-03 04:12:36.889428	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	100.0	\N	\N	f	admin	\N	abc,bcd	MKS_20260503094236_D462BEF5	session_R-oQ3iB5Co4l79S4G1zicpcUmR3ZemIUy1Onn8sYWBg7_p0YqZNzpzVIAOOXcOp0WbL1i_g_ZOMgtrQeFlDLG80HKTZXn4HF0dybYdiXeJIv4N-B5QqmveABPW0T	\N	\N	cashfree	2026-05-03 04:12:36.251707	\N	f
156	515	\N	BK202605032505	2026-05-03 04:17:50.773345	draft	2	unpaid	76.0	4.0	\N	80.0	\N	\N	ssd ds	pramodbha88@gmail.com	9292919191	Sample Address, Street 1, City Name, State Name - 123456	\N	\N	\N	\N	2026-05-03 04:17:52.008315	2026-05-03 04:17:54.854692	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	80.0	\N	\N	f	admin	\N	abc,bcd	MKS_20260503094754_F6EC6187	session_6SSdeYbJZHRgtxwC-KCP9PluHXQ63gOFc2fpTCrZ4nhc9VPQgCbo4vfGDS8Xm0eQvA_inJZKY_xb14N_43wMzbK9E3XQbeStdKa5CSavhNu64RecKzLHk9fvSKaP	\N	\N	cashfree	2026-05-03 04:17:54.243932	\N	f
157	515	\N	BK202605036344	2026-05-03 04:20:59.172068	draft	2	unpaid	76.0	4.0	\N	80.0	\N	\N	ssd ds	pramodbha88@gmail.com	9292919191	Sample Address, Street 1, City Name, State Name - 123456	\N	\N	\N	\N	2026-05-03 04:20:59.630893	2026-05-03 04:21:02.559625	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	80.0	\N	\N	f	admin	\N	abc,bcd	MKS_20260503095101_271D9502	session_ms4pFkCaVeXRg9evYuU7VpFUCuQoX_j0e2UvTDQQ9DH2q8kA6F10oEq_w003OZZhzruOrJwf0Jicnx-pGXdduEp2WPDegQ9VLRonEi9lzU4PZ6BZC-woY3ax05Lx	\N	\N	cashfree	2026-05-03 04:21:01.877396	\N	f
158	515	\N	BK202605036532	2026-05-03 04:29:02.156863	draft	2	unpaid	361.0	19.0	\N	380.0	\N	\N	ssd ds	pramodbha88@gmail.com	9292919191	Sample Address, Street 1, City Name, State Name - 123456	\N	\N	\N	\N	2026-05-03 04:29:02.709719	2026-05-03 04:29:05.890912	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	380.0	\N	\N	f	admin	\N	abc,bcd	MKS_20260503095905_EA75C69A	session_UtUjZQNPB-9nX1gJDm_9Gd_D-8hsvL7dHHqzgdhfJe5jdKdBbHEbkRUahXGTP16Cg_845e-vb4x3myKfFqvJ2ltS5jnNAcfrx3jJ41n9pqWqudQYC08Az5O3Kev8	\N	\N	cashfree	2026-05-03 04:29:05.244644	\N	f
160	516	\N	BK202605036999	2026-05-03 05:12:32.856002	confirmed	5	unpaid	864.5	45.5	\N	910.0	\N	\N	Test Customer	testcustomer@example.com	9876543210	123 Main Street, MG Road, Bangalore - 560001	\N	\N	\N	\N	2026-05-03 05:12:33.640847	2026-05-03 05:12:33.640847	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	910.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
161	516	\N	BK202605032806	2026-05-03 05:12:45.29711	draft	6	unpaid	570.0	30.0	\N	600.0	\N	\N	Test Customer	testcustomer@example.com	9876543210	123 Main Street, MG Road, Bangalore - 560001	\N	\N	\N	\N	2026-05-03 05:12:45.756187	2026-05-03 05:12:49.114931	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	600.0	\N	\N	f	admin	\N	\N	MKS_20260503104248_4BAAECC9	session_CEHgRoI-oVMkDqKo1PcRIepMVcg629JDy7EYn5WAclY4qv77bJsAa1qf64J3gNpjI44eQIR6imczM5VY5XQDgDBOCEjebYe5y-d3zlg9tM7P5LRiOrgG-hDrYzW2	\N	\N	cashfree	2026-05-03 05:12:48.252897	\N	f
164	516	\N	BK202605031310	2026-05-03 06:28:49.387371	confirmed	5	unpaid	864.5	45.5	\N	910.0	\N	\N	Test Customer	testcustomer@example.com	9876543210	123 Main Street, MG Road, Bangalore - 560001	\N	\N	\N	\N	2026-05-03 06:28:50.164025	2026-05-03 06:28:50.164025	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	910.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
165	516	\N	BK202605031586	2026-05-03 06:29:12.656622	draft	6	unpaid	570.0	30.0	\N	600.0	\N	\N	Test Customer	testcustomer@example.com	9876543210	123 Main Street, MG Road, Bangalore - 560001	\N	\N	\N	\N	2026-05-03 06:29:13.206846	2026-05-03 06:29:16.435912	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	600.0	\N	\N	f	admin	\N	\N	MKS_20260503115915_C1F39DDA	session__MX40EgYLHZ570_JxQTV-EHW7IaLe7i3CkhrIoSSO5IQi13VDywI6dojbTG-8SnmoZHqAwZPEOR5ipJAsmmo2f1qIm6dSYtYuXyBP7vnhJOAMA9Vgq6hYqz81XJc	\N	\N	cashfree	2026-05-03 06:29:15.558788	\N	f
159	515	\N	BK202605035080	2026-05-03 04:43:57.604106	draft	2	unpaid	361.0	19.0	\N	380.0	\N	\N	ssd ds	pramodbha88@gmail.com	9292919191	Sample Address, Street 1, City Name, State Name - 123456	\N	\N	\N	\N	2026-05-03 04:43:58.400909	2026-05-03 06:44:26.010434	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	380.0	\N	\N	f	admin	\N	abc,bcd	MKS_20260503101400_2FD163EC	session_xfuuhxC3ujt-_CkUvzWDMEB76yN0ZAkKzM0D86LHdld0poA6WzA6-ffWwudHrZ4unJVl7-1--JFJn5x5qiV-ADEEJt6kKCWmePmXSvnc4Zkm8PMH8RmtL4Dm4Ujo	\N	{"failure_reason":"Payment cancelled by user","failed_at":"2026-05-03T12:14:23.906+05:30"}	cashfree	2026-05-03 04:44:00.629173	\N	f
166	516	\N	BK202605038430	2026-05-03 07:21:36.173982	confirmed	5	unpaid	100.0	0.0	\N	100.0	Handle with care	\N	John Doe	john.doe@example.com	9876543210	123 Main Street, Bangalore	\N	\N	\N	\N	2026-05-03 07:21:36.82182	2026-05-03 07:21:36.82182	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	100.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
167	516	\N	BK202605032180	2026-05-03 07:23:07.449118	draft	6	unpaid	100.0	0.0	\N	100.0	Handle with care	\N	John Doe	john.doe@example.com	9876543210	123 Main Street, Bangalore	\N	\N	\N	\N	2026-05-03 07:23:07.837132	2026-05-03 07:23:10.905322	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	100.0	\N	\N	f	admin	\N	\N	MKS_20260503125309_90C8CB54	session_PGgMqa9wMzmQc4ePigHPK08Zoxmbr1Jf8pbSpG3uUCe7Kasgj1kqYpB--1PncXZY2gPO8DvGvPJX-Kg4lTnIqpZrT_aOMAa5N9TbUT3VyMHi9xOjKtX5HD9wusB1	\N	\N	cashfree	2026-05-03 07:23:09.546478	\N	f
168	514	\N	BK202605035619	2026-05-03 07:28:18.043704	confirmed	5	unpaid	95.0	5.0	\N	100.0	Handle with care	\N	John Doe	john.doe@example.com	9876543210	123 Main Street, Bangalore	\N	\N	\N	\N	2026-05-03 07:28:18.594042	2026-05-03 07:28:18.594042	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	100.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
169	514	\N	BK202605032698	2026-05-03 07:33:23.200132	draft	6	unpaid	100.0	0.0	\N	100.0	Handle with care	\N	John Doe	john.doe@example.com	9876543210	123 Main Street, Bangalore	\N	\N	\N	\N	2026-05-03 07:33:23.581325	2026-05-03 07:33:26.20145	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	100.0	\N	\N	f	admin	\N	\N	MKS_20260503130324_B5C44380	session_0J2IJoUBQpAKLhBTnFcC5FD-3FtiFzig_2UG60W5b1s4are7DcaR3iti3s7JClk2iWaXH4o_x4BeX9fowG-eb8VwF60QjnJDhcjYJeHRNUDmuDCr1lxc_ITP11u-	\N	\N	cashfree	2026-05-03 07:33:25.301096	\N	f
170	514	\N	BK202605038198	2026-05-03 07:47:10.832584	confirmed	5	unpaid	350.0	0.0	\N	350.0	\N	\N	Rajesh Raj	raj3@gmail.com	9879879871	Cod bangalore	\N	\N	\N	\N	2026-05-03 07:47:11.30644	2026-05-03 07:47:11.30644	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	350.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
198	524	\N	BK202605091625	2026-05-09 06:19:36.771272	confirmed	2	paid	1.0	0.0	\N	1.0	\N	\N	test bhat	test@gmail.com	9797979797	Sample Address, Street 1, City Name, State Name - 123456	\N	\N	\N	\N	2026-05-09 06:19:37.315247	2026-05-09 06:20:13.236578	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	admin	\N	abc,bcd	MKS_20260509114939_2808F272	session_LrcVoDKufF3If3WMFTBX5KZQzhsKyNuBgWUTzm6MUqsQQUU2tD471qJJyusPCnVdHmBJODESLJ-OXhfu8o4WoA7kIS3IQBLPmWG6qZd3p3I8dpvhI4EMsO5-bssl	5539595904	{"cf_payment_id":5539595904,"payment_method":"upi","order_status":"PAID","payment_amount":1.0,"bank_reference":"498945921551","auth_id":null}	cashfree	2026-05-09 06:19:39.668932	2026-05-09 06:20:11.302999	f
171	514	\N	BK202605038742	2026-05-03 07:48:47.313115	draft	6	unpaid	1.0	0.0	\N	1.0	\N	\N	Rajesh Raj	raj3@gmail.com	9879879871	Cod bangalore	\N	\N	\N	\N	2026-05-03 07:48:47.708734	2026-05-03 07:48:49.801123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	admin	\N	\N	MKS_20260503131848_D4BBE6DB	session_0Kf35iy6RewmcXNVkMGc9L88llZlbuVC-FdYp6qx2ltchi3Q1Ze2t-xtzO9mOtv4hVnTnkdp5EGlhHkWLBdXjHHGlgf2ATXtqQXy4qDiBbGfYH0rBXZKhpJL3zZS	\N	\N	cashfree	2026-05-03 07:48:48.912887	\N	f
172	514	\N	BK202605031769	2026-05-03 09:03:16.872474	draft	6	unpaid	1.0	0.0	\N	1.0	\N	\N	Rajesh Raj	raj3@gmail.com	9879879871	Cod bangalore	\N	\N	\N	\N	2026-05-03 09:03:17.468892	2026-05-03 09:03:19.508895	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	admin	\N	\N	MKS_20260503143318_FB1F63B2	session_gB0lweDyT1Qs7_bUbC_ABjzWpDUQVewhVWXn4X7R7wNA4twL74gdOH9GMe2OkKZ55PliBkj2K9saX3Lxa8oR5bOa46HfIVzSis9nUK_2TrhQyRtB6T4rErsEaz9a	\N	\N	cashfree	2026-05-03 09:03:18.675123	\N	f
173	514	\N	BK202605033849	2026-05-03 09:03:53.992087	confirmed	5	unpaid	1.0	0.0	\N	1.0	\N	\N	Rajesh Raj	raj3@gmail.com	9879879871	bangalore	\N	\N	\N	\N	2026-05-03 09:03:54.465821	2026-05-03 09:03:54.465821	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
174	514	\N	BK202605032382	2026-05-03 09:04:53.575395	confirmed	5	unpaid	1.0	0.0	\N	1.0	\N	\N	Rajesh Raj	raj3@gmail.com	9879879871	bangalore	\N	\N	\N	\N	2026-05-03 09:04:53.974175	2026-05-03 09:04:53.974175	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
199	516	1	BK20260509592224	2026-05-08 18:30:00	completed	0	unpaid	85.5	4.5	34.0	56.0		\N	Test Customer	testcustomer@example.com	9876043210	asds	t	INV-05-00002	\N	0.0	2026-05-09 06:24:36.564802	2026-05-09 06:24:45.809779	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	56.0	\N	\N	t	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	t
202	514	\N	BK202605094859	2026-05-09 13:17:16.989875	confirmed	5	unpaid	275.5	14.5	\N	290.0	\N	\N	Rajesh Raj	raj3@gmail.com	9879879871	bangalkire	\N	\N	\N	\N	2026-05-09 13:17:17.713738	2026-05-09 13:17:17.713738	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	290.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
175	514	\N	BK202605035412	2026-05-03 09:05:19.939344	draft	6	unpaid	1.0	0.0	\N	1.0	\N	\N	Rajesh Raj	raj3@gmail.com	9879879871	bangalore	\N	\N	\N	\N	2026-05-03 09:05:20.323406	2026-05-03 09:05:23.019386	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	admin	\N	\N	MKS_20260503143521_FDCD2579	session_F3RGmldDpDppFZq7I10b5Tx3u3MNoMC6aLXmFjzB4l4Cx4FiRsN7XJkRs1EApE3TG4xbpr7wkPcs5lLRGZ_BMqv7tA0OAMY1tGLbnhLnaqeU63MU423EUlOhhEvu	\N	\N	cashfree	2026-05-03 09:05:21.493307	\N	f
205	526	\N	BK202605108893	2026-05-10 05:11:23.786612	confirmed	5	unpaid	158.0	8.0	\N	166.0	\N	\N	sd sdd	sdds@gmail.com	9898989891	Sample Address, Street 1, City Name, State Name - 123456	\N	\N	\N	\N	2026-05-10 05:11:24.477659	2026-05-10 05:11:24.477659	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	166.0	\N	\N	f	admin	\N	abc,bcd	\N	\N	\N	\N	cash	\N	\N	f
210	529	\N	BK202605106114	2026-05-10 09:39:25.207341	confirmed	5	unpaid	492.48	23.52	\N	516.0	\N	\N	dddssdd dsd	ddd@gmail.com	9898128989	Sample Address, Street 1, City Name, State Name - 123456	\N	\N	\N	\N	2026-05-10 09:39:26.391344	2026-05-10 09:39:26.391344	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	516.0	\N	\N	f	customer	\N	abc,bcd	\N	\N	\N	\N	cash	\N	\N	f
176	514	\N	BK202605037831	2026-05-03 09:10:24.897428	draft	6	unpaid	1.0	0.0	\N	1.0	\N	\N	Rajesh Raj	raj3@gmail.com	9879879871	bana	\N	\N	\N	\N	2026-05-03 09:10:25.280821	2026-05-03 09:10:27.440182	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	admin	\N	\N	MKS_20260503144026_5F8C019A	session_QbTV2XUZ3GtgrNp7dPr9SQYUk0z2_1vVO_ZZx71N3Y8aWaSFWeqPs7sWX-CYawDIT8D3_W3VnMpjVsrTaKBfY1HlkF7rU7bnYH2_C6eGL6tt8rpFTS8lsmbLtnzt	\N	\N	cashfree	2026-05-03 09:10:26.466184	\N	f
177	514	\N	BK202605033216	2026-05-03 09:12:35.593083	draft	6	unpaid	1.0	0.0	\N	1.0	\N	\N	Rajesh Raj	raj3@gmail.com	9879879871	bana	\N	\N	\N	\N	2026-05-03 09:12:35.992701	2026-05-03 09:12:38.135529	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	admin	\N	\N	MKS_20260503144236_2C1B2B49	session_uQPeNHQ_7N9lKbsGW3U1b_PNTb9AR_R9av_h_4RUDePgmfkzCLTkncNyVnjY4-owXtCOW5uQcqiDt159m9csKzWZ6DvDOgSmwpPBGSmCBR-7VoSfFtPM0XbPy-N3	\N	\N	cashfree	2026-05-03 09:12:37.210234	\N	f
178	514	\N	BK202605031711	2026-05-03 09:15:45.485287	draft	6	unpaid	1.0	0.0	\N	1.0	\N	\N	Rajesh Raj	raj3@gmail.com	9879879871	bana	\N	\N	\N	\N	2026-05-03 09:15:45.880683	2026-05-03 09:15:48.670129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	admin	\N	\N	MKS_20260503144546_B8C535D1	session_qtHLxMhhVjxfPG4BtuKBpFgxmQJMAWKDjj2b8qsvC_nFs62Wt3bt7FrqSQhPKlSezIlhNBvZO7ktV3Eup4x3gF3O6c6swgolx1ZvlBcEhnqdyfE8vutIBi0YwqY1	\N	\N	cashfree	2026-05-03 09:15:47.074857	\N	f
179	518	\N	BK202605035671	2026-05-03 10:02:43.449976	confirmed	5	unpaid	332.5	17.5	\N	350.0	\N	\N	Bdbhd Nxn	pramodbha87@gmail.com	9632850870	Nnffn	\N	\N	\N	\N	2026-05-03 10:02:44.112341	2026-05-03 10:02:44.112341	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	350.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
180	518	\N	BK202605039645	2026-05-03 10:03:19.495513	draft	6	unpaid	1.0	0.0	\N	1.0	\N	\N	Bdbhd Nxn	pramodbha87@gmail.com	9632850870	Nnffn	\N	\N	\N	\N	2026-05-03 10:03:20.32147	2026-05-03 10:03:23.685645	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	admin	\N	\N	MKS_20260503153322_23A9987A	session_YbUg-WthSe2hybthblPVPUiBikYND43Ku_k4AkrnIJQARaVjd4LYcVm19ftIkWWXNnoVoKLluOrYPlemHFlJPyxC7D2IeGqZ5sStXBkRr68vRHXDutTsM2axRd-x	\N	\N	cashfree	2026-05-03 10:03:22.799396	\N	f
181	514	\N	BK202605039687	2026-05-03 10:13:55.834593	draft	6	unpaid	1.0	0.0	\N	1.0	\N	\N	Rajesh Raj	raj3@gmail.com	9879879871	hh	\N	\N	\N	\N	2026-05-03 10:13:56.513445	2026-05-03 10:13:59.06172	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	admin	\N	\N	MKS_20260503154357_8B54F153	session_a9WTcENgnegLcUKcMN4L0cbME4MamLlQWCvpyK8NzVF_OsetHxymHX0D00ySyqK4tXsi8bsDKvaLCj2f9cO6kxLocyCZ6oHEWlbzri5rOcMG0GHo9vPAExhGIASw	\N	\N	cashfree	2026-05-03 10:13:57.785493	\N	f
182	514	\N	BK202605036005	2026-05-03 10:15:25.182393	draft	6	unpaid	1.0	0.0	\N	1.0	\N	\N	Rajesh Raj	raj3@gmail.com	9879879871	hh	\N	\N	\N	\N	2026-05-03 10:15:25.648444	2026-05-03 10:15:27.855374	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	admin	\N	\N	MKS_20260503154526_0FD6A8F7	session_VKsW_5x9m3LhKOsPEYZr5jOchPpV78Vk9F4qOYwG9F_lAkIwW_toksGmH8Jll46UpGG7mIDZL_QPlV7SwgjOQd49495qidwS2YYtzCRMnpt79KbuaUOyFIgE4N_u	\N	\N	cashfree	2026-05-03 10:15:26.896373	\N	f
183	514	\N	BK202605039214	2026-05-03 10:18:49.016492	draft	6	unpaid	1.0	0.0	\N	1.0	\N	\N	Rajesh Raj	raj3@gmail.com	9879879871	hh	\N	\N	\N	\N	2026-05-03 10:18:49.408169	2026-05-03 10:18:51.49219	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	admin	\N	\N	MKS_20260503154850_9BADC35F	session_ATuKoqTH917MZmPaUffeI8IBacIBem21jSwUXN_MFs0cFe4z-BTSABrAzAZArk77RJ2MFU8T-nliN55I2Widm7W826zFCCI2OtqPXvkXt8XDpbj8rqZpqiy51zGF	\N	\N	cashfree	2026-05-03 10:18:50.635477	\N	f
184	514	\N	BK202605036472	2026-05-03 10:19:20.119395	draft	6	unpaid	1.0	0.0	\N	1.0	\N	\N	Rajesh Raj	raj3@gmail.com	9879879871	hh	\N	\N	\N	\N	2026-05-03 10:19:20.507969	2026-05-03 10:19:22.490857	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	admin	\N	\N	MKS_20260503154921_8ABF7C04	session_IpMOdARatJU3BpyUQMtIQziUPUMaNFZS8pTwW9Ym3VcVquVDg3BbsbT6HGE13CjcAd11kBz1FqUKdUJsFym8fFBgyGHBMIYpERkBOsboKET-CBOnRsqSdjN5Ufhq	\N	\N	cashfree	2026-05-03 10:19:21.677825	\N	f
185	519	\N	BK202605037058	2026-05-03 11:03:34.869344	draft	6	unpaid	152.0	8.0	\N	160.0	Vv	\N	Ncnf Ffnn	pramodbha8dh@gmail.com	9632626265	Ghh	\N	\N	\N	\N	2026-05-03 11:03:35.377655	2026-05-03 11:03:41.257141	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	160.0	\N	\N	f	admin	\N	\N	MKS_20260503163339_7B6625E7	session_xtGgQAZx0r5Ha5f-VtHJ2hiAnSExDUyx_U83tou26WEqmNq5urX2YX-gp6epabDg5xGE7M73lfACRYtb8vK_LAPFp_tkSSQQf2sXfFG8_oC7LBp0rAUw2lFqGKoP	\N	\N	cashfree	2026-05-03 11:03:39.854659	\N	f
186	519	\N	BK202605037254	2026-05-03 11:13:43.957186	confirmed	5	unpaid	1.0	0.0	\N	1.0	\N	\N	Ncnf Ffnn	pramodbha8dh@gmail.com	9632626265	Bb	\N	\N	\N	\N	2026-05-03 11:13:44.510787	2026-05-03 11:13:44.510787	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
187	519	\N	BK202605035487	2026-05-03 11:14:10.434671	draft	6	unpaid	1.0	0.0	\N	1.0	\N	\N	Ncnf Ffnn	pramodbha8dh@gmail.com	9632626265	Bb	\N	\N	\N	\N	2026-05-03 11:14:10.830446	2026-05-03 11:14:15.106362	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	admin	\N	\N	MKS_20260503164413_E40DD1EF	session_KDrGosKqT3cOV6xiDWrII3BvaoH0obsc_zpsVThY_s5jjZ1mjUAZrQEj47-zaQ6Ghi3zWOfBKXD6wzljholYjEykb835tIEjQHNVB0DXe7jjbJhO_cKAB7YnTKEH	\N	\N	cashfree	2026-05-03 11:14:13.787653	\N	f
188	520	\N	BK202605041318	2026-05-04 11:05:46.794791	confirmed	5	unpaid	332.5	17.5	\N	350.0	\N	\N	Raghu Kt	raghukt.shetty89@gmail.com	9035408833	5 8th cross NR layout \nRM Nagar Bangalore	\N	\N	\N	\N	2026-05-04 11:05:47.424828	2026-05-04 11:05:47.424828	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	350.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
190	514	\N	BK202605098957	2026-05-09 04:44:37.652098	confirmed	5	unpaid	153.0	8.0	\N	161.0	\N	\N	Rajesh Raj	raj3@gmail.com	9879879871	bangalroe	\N	\N	\N	\N	2026-05-09 04:44:38.355995	2026-05-09 04:44:38.355995	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	161.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
189	488	\N	BK202605068946	2026-05-06 15:48:04.475255	draft	2	paid	458.05	5.95	\N	464.0	\N	\N	raghu kt	raghubit040@gmail.com	9035378833	Sample Address, Street 1, City Name, State Name - 123456	t	INV20260509E8A008	\N	\N	2026-05-06 15:48:05.19006	2026-05-09 04:46:31.712416	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	464.0	\N	\N	f	admin	\N	abc,bcd	MKS_20260506211808_B3BA0597	session_w6v73DhIfyF_nebXmESdg7Q1CQPNFEuCQ2GTcbH6b5d7a4eqvRSN3DGo4nhjFccLTFOjXwjevLMDkQTKVm5mrWD2wZWSP7HpjwiNnNcvrXHmXQkCfjniilxTj7Rk	5520253650	{"cf_payment_id":5520253650,"payment_method":"upi","order_status":"PAID","payment_amount":464.0,"bank_reference":"032383483337","auth_id":null}	cashfree	2026-05-06 15:48:08.103946	2026-05-06 15:48:50.706068	f
191	\N	1	BK2026050911A50A	2026-05-08 18:30:00	completed	0	unpaid	85.5	4.5	30.0	60.0		\N	pramod bhat	pramodbha8@gmail.com	09190939393	dfd	\N	\N	\N	0.0	2026-05-09 05:38:43.445107	2026-05-09 05:38:43.445107	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	60.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
192	519	\N	BK202605098763	2026-05-09 06:02:52.91726	confirmed	5	unpaid	153.0	8.0	\N	161.0	\N	\N	Ncnf Ffnn	pramodbha8dh@gmail.com	9632626265	Vv	\N	\N	\N	\N	2026-05-09 06:02:53.68954	2026-05-09 06:02:53.68954	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	161.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
193	519	\N	BK202605094755	2026-05-09 06:04:10.597271	confirmed	5	unpaid	61.75	3.25	\N	65.0	\N	\N	Ncnf Ffnn	pramodbha8dh@gmail.com	9632626265	Vv	\N	\N	\N	\N	2026-05-09 06:04:10.978894	2026-05-09 06:04:10.978894	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	65.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
194	519	\N	BK202605095446	2026-05-09 06:05:23.277039	confirmed	5	unpaid	256.5	13.5	\N	270.0	\N	\N	Ncnf Ffnn	pramodbha8dh@gmail.com	9632626265	Vv	\N	\N	\N	\N	2026-05-09 06:05:23.664026	2026-05-09 06:05:23.664026	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	270.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
195	519	\N	BK202605094178	2026-05-09 06:06:06.181125	confirmed	5	unpaid	318.25	16.75	\N	335.0	\N	\N	Ncnf Ffnn	pramodbha8dh@gmail.com	9632626265	7tfuf	\N	\N	\N	\N	2026-05-09 06:06:06.886235	2026-05-09 06:06:06.886235	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	335.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
196	519	\N	BK202605093878	2026-05-09 06:11:47.309497	draft	6	unpaid	1.0	0.0	\N	1.0	\N	\N	Ncnf Ffnn	pramodbha8dh@gmail.com	9632626265	Ghhjjjju	\N	\N	\N	\N	2026-05-09 06:11:47.700203	2026-05-09 06:11:49.800671	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	admin	\N	\N	MKS_20260509114148_BBB9AC4E	session_rn2emWO-gs79goSJVz_6HYGAyPHezzrrIYibOHiawQJRM14l9pp0QSx4epCmOt_TPh6NTFd6rYRMPQXC2gtUpdxlNK8SyOoAQdEciNSbxLM7UGQIGa98-3yI3_UV	\N	\N	cashfree	2026-05-09 06:11:48.906108	\N	f
200	524	\N	BK202605095552	2026-05-09 06:43:39.140957	confirmed	5	unpaid	1.0	0.0	\N	1.0	\N	\N	test bhat	test@gmail.com	9797979797	Sample Address, Street 1, City Name, State Name - 123456	\N	\N	\N	\N	2026-05-09 06:43:39.693683	2026-05-09 06:43:39.693683	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	admin	\N	abc,bcd	\N	\N	\N	\N	cash	\N	\N	f
203	522	1	BK2026051096BBD7	2026-05-09 18:30:00	completed	0	unpaid	6.0	0.0	0.0	6.0		\N	Ashwini Seetharam	ashwini_74@yahoo.com	9686758463	asd	\N	\N	\N	0.0	2026-05-10 00:32:44.329776	2026-05-10 00:32:44.329776	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	t
207	520	\N	BK202605108000	2026-05-10 07:04:04.88476	confirmed	5	unpaid	570.0	30.0	\N	600.0	\N	\N	Raghu Kt	raghukt.shetty89@gmail.com	9035408833	RM NAGAR	\N	\N	\N	\N	2026-05-10 07:04:05.120808	2026-05-10 07:04:05.120808	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	600.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
75	481	\N	BK202603196879	2026-03-19 09:39:02.957287	delivered	2	paid	700.0	35.0	\N	735.0	\N	\N	raghunandan kt	raghubit040@gmail.com	9844070041	Sample Address, Street 1, City Name, State Name - 123456	t	INV20260416A32B6E	\N	\N	2026-03-19 09:39:03.106065	2026-05-10 07:25:17.026409	\N	\N	\N	\N	\N	\N	\N	917975918232	\N	2026-03-20 02:43:00	5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	[{"from_stage":"confirmed","to_stage":"out_for_delivery","timestamp":"2026-03-20T13:29:49.237+05:30","user_id":1,"user_name":"Admin User","delivery_person_id":"17","delivery_person":"","delivery_contact":"917975918232"},{"from_stage":"out_for_delivery","to_stage":"delivered","timestamp":"2026-03-20T13:43:52.993+05:30","user_id":1,"user_name":"Admin User","delivery_person":"","delivery_time":"2026-03-20T08:13","customer_satisfaction":"5"}]	2026-03-20 08:13:52.993614	1	\N	\N	\N	735.0	17	\N	f	admin	\N	\N	\N	\N	test_payment_123	{"cf_payment_id":"test_payment_123","payment_method":"upi","order_status":"PAID","payment_amount":"735.0"}	cash	\N	2026-03-29 06:30:19.346983	f
211	528	\N	BK202605101787	2026-05-10 09:40:45.555941	confirmed	5	unpaid	1.0	0.0	\N	51.0	\N	\N	Eeuhhhj Ggbbvh	hah@gmail.com	9632859632	Hx	\N	\N	\N	\N	2026-05-10 09:40:45.865224	2026-05-10 09:40:45.865224	\N	\N	\N	\N	50.00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	mobile_api	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
212	494	1	BK20260510766A9B	2026-05-09 18:30:00	completed	0	unpaid	845.5	44.5	0.0	890.0		\N	Abhishek Vadoni	abhishekvadoni@gmail.com	7026182080	as	\N	\N	\N	0.0	2026-05-10 09:58:09.586651	2026-05-10 09:58:09.586651	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	890.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
213	514	\N	BK202605149089	2026-05-14 02:01:03.728231	confirmed	5	unpaid	1.0	0.0	\N	51.0	\N	\N	Rajesh Raj	raj3@gmail.com	9879879871	test	\N	\N	\N	\N	2026-05-14 02:01:04.127098	2026-05-14 02:01:04.127098	\N	\N	\N	\N	50.00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	mobile_api	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
214	\N	106	BK202605178EBDDE	\N	\N	0	paid	266.03	13.97	0.0	280.0	sdd	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-05-17 09:57:00.702617	2026-05-17 09:57:00.702617	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	13	\N	\N	280.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
215	\N	106	BK2026051740F180	\N	completed	0	paid	551.0	29.0	0.0	580.0		\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-05-17 10:10:58.921871	2026-05-17 10:10:58.921871	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	13	\N	\N	580.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
216	\N	106	BK202605178983E0	\N	completed	0	paid	85.5	4.5	0.0	90.0		\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-05-17 13:41:13.163835	2026-05-17 13:41:13.163835	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	13	\N	\N	90.0	\N	\N	f	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
217	494	1	BK202605241048BD	2026-05-23 18:30:00	completed	0	unpaid	361.0	19.0	0.0	380.0	aas	\N	Abhishek Vadoni	abhishekvadoni@gmail.com	7026182080	asas	t	INV-05-00003	\N	0.0	2026-05-24 12:36:19.820341	2026-05-24 12:36:34.25792	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	380.0	\N	\N	t	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
218	540	\N	BK202605243741	2026-05-24 12:42:41.379695	confirmed	2	paid	1.0	0.0	\N	1.0	\N	\N	as sa	9093939ss393fdfds@gmail.com	9181818181	Sample Address, Street 1, City Name, State Name - 123456	\N	\N	\N	\N	2026-05-24 12:42:41.727436	2026-05-24 12:43:28.759767	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	customer	\N	abc,bcd	MKS_20260524181244_F1C6F25F	session_EmZeumAfC4k0etcxk8oE7RUaROQ4o_U5p0BQqKDD0IQeuarF6iRh0qJlhjNMAN3ottrrXAs2bicx7XIAkWVVKH187HA0oHhJvFKph5G4l4HwPJ90REvkLC7-hV-b	5648273895	{"cf_payment_id":5648273895,"payment_method":"upi","order_status":"PAID","payment_amount":1.0,"bank_reference":"392516600818","auth_id":null}	cashfree	2026-05-24 12:42:44.423729	2026-05-24 12:43:28.399502	f
219	\N	1	BK20260524911B8B	2026-05-23 18:30:00	completed	0	paid	1976.0	104.0	0.0	2080.0	Pending Payment given to sidhu sir 	\N	anil Shop		+91 87229 83349	Jayanagar 	t	INV-05-00004	\N	0.0	2026-05-24 15:17:26.390845	2026-05-24 15:17:30.762409	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2080.0	\N	\N	t	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	t
220	541	\N	BK202605255894	2026-05-25 05:01:26.263711	confirmed	2	paid	1.0	0.0	\N	1.0	\N	\N	smart ariser test	smar@gmail.com	8281989898	Sample Address, Street 1, City Name, State Name - 123456	\N	\N	\N	\N	2026-05-25 05:01:26.706922	2026-05-25 05:02:31.980315	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	customer	\N	abc,bcd	MKS_20260525103129_2599337B	session_c-mV9RIPnBJ-kV8xZSYlZOeu8vlMl2VCmmT-R4bifuwlK4_-52vg3_aWejyxBwgtkC_lgGtSiOSmH_1tDwqUZRDEzP9fMuTfbbEWpK92MGT6E4U9t331bd4uGOVF	5652479548	{"cf_payment_id":5652479548,"payment_method":"upi","order_status":"PAID","payment_amount":1.0,"bank_reference":"054391847352","auth_id":null}	cashfree	2026-05-25 05:01:29.472365	2026-05-25 05:02:30.096201	f
221	542	\N	BK202605256475	2026-05-25 05:10:25.519924	confirmed	5	unpaid	1729.0	91.0	\N	1870.0	\N	\N	Ndnd Jdnd	smarr@gmail.com	9632569686	Dyud	\N	\N	\N	\N	2026-05-25 05:10:25.702382	2026-05-25 05:10:25.702382	\N	\N	\N	\N	50.00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1820.0	\N	\N	f	mobile_api	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
222	\N	1	BK20260602F306F8	2026-05-30 18:30:00	completed	4	paid	362.0	18.0	0.0	380.0		\N	Srikanth 	raghubit040@gmail.com	+91 93412 82244	8th cross , Narayana Reddy Layout\r\nNext to Shanideva temple	t	INV-06-00001	\N	0.0	2026-06-02 15:46:27.850527	2026-06-02 15:46:34.230818	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	380.0	\N	\N	t	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	t
223	546	\N	BK202606032326	2026-06-03 03:39:39.045329	confirmed	5	unpaid	267.0	13.0	\N	330.0	\N	\N	Raghu	test-customer@gmail.com	9844070041	RM NAGAR	\N	\N	\N	\N	2026-06-03 03:39:39.384348	2026-06-03 03:39:39.384348	\N	\N	\N	\N	50.00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	280.0	\N	\N	f	mobile_api	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
224	546	\N	BK202606039537	2026-06-03 03:42:14.691452	confirmed	5	unpaid	3052.0	153.0	\N	3255.0	\N	\N	Raghu	test-customer@gmail.com	9844070041	RM NAGAR	\N	\N	\N	\N	2026-06-03 03:42:14.85619	2026-06-03 03:42:14.85619	\N	\N	\N	\N	50.00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3205.0	\N	\N	f	mobile_api	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
225	550	\N	BK202606031587	2026-06-03 11:45:35.224659	confirmed	5	unpaid	620.0	31.0	\N	651.0	\N	\N	Customer Name	venubha1477@gmail.com	9876543210	abc,bcd,	\N	\N	\N	\N	2026-06-03 11:45:37.559108	2026-06-03 11:45:37.559108	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	651.0	\N	\N	f	customer	\N	abc,bcd,	\N	\N	\N	\N	cash	\N	\N	f
226	520	\N	BK202606031364	2026-06-03 12:58:30.915839	confirmed	5	unpaid	619.0	31.0	\N	700.0	\N	\N	Raghu Kt	raghukt.shetty89@gmail.com	9035408833	5 8th cross Ramamurthy nagar	\N	\N	\N	\N	2026-06-03 12:58:31.085331	2026-06-03 12:58:31.085331	\N	\N	\N	\N	50.00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	650.0	\N	\N	f	mobile_api	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
227	553	\N	BK202606037875	2026-06-03 15:48:35.129071	confirmed	5	unpaid	352.0	18.0	\N	420.0	\N	\N	Neethu Shree	neethushreeneethushree005@gmail.com	9900770296	rm nagar	\N	\N	\N	\N	2026-06-03 15:48:35.471528	2026-06-03 15:48:35.471528	\N	\N	\N	\N	50.00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	370.0	\N	\N	f	mobile_api	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
228	553	\N	BK202606038774	2026-06-03 16:02:07.334846	confirmed	5	unpaid	705.0	35.0	\N	790.0	\N	\N	Neethu Shree	neethushreeneethushree005@gmail.com	9900770296	Rm nagar	\N	\N	\N	\N	2026-06-03 16:02:07.494163	2026-06-03 16:02:07.494163	\N	\N	\N	\N	50.00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	740.0	\N	\N	f	mobile_api	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
229	550	\N	BK202606046526	2026-06-04 09:39:27.705612	draft	6	unpaid	619.0	31.0	\N	650.0	\N	\N	Customer Name	venubha1477@gmail.com	9876543210	abc,bcd,	\N	\N	\N	\N	2026-06-04 09:39:28.106507	2026-06-04 09:39:31.220217	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	650.0	\N	\N	f	customer	\N	abc,bcd,	MKS_20260604150930_1B1D4291	session_EPZELwCpfV0_tzizxmYsmhpluUSdhWU0OhxDbe07PXheviph4gzcZyUjJKjyrxRek62TXqsH2MLwJlSZWpKYRb7SqrYDmQ4V59KKPdS43EHnOC61AgPAwjz1aNDU	\N	\N	cashfree	2026-06-04 09:39:30.529819	\N	f
230	550	\N	BK202606046563	2026-06-04 09:41:38.528212	draft	6	unpaid	571.0	29.0	\N	600.0	\N	\N	Customer Name	venubha1477@gmail.com	9876543210	abc,bcd,	\N	\N	\N	\N	2026-06-04 09:41:38.873209	2026-06-04 09:41:40.556571	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	600.0	\N	\N	f	customer	\N	abc,bcd,	MKS_20260604151139_5186A79D	session_pWAG0l6umJYyB89LWU2ofUeDEP9737lz5EPsULuSTMT502orQlvoX1z-4Gd7u6AWzDdQBwK8hK1wqSuWKwH5TDSm2EuM3ARFHF7L64p8XRndxu1PKr07fs20NPbi	\N	\N	cashfree	2026-06-04 09:41:39.939867	\N	f
231	550	\N	BK202606045660	2026-06-04 11:08:14.038609	confirmed	5	unpaid	429.0	21.0	\N	450.0	\N	\N	Customer Name	venubha1477@gmail.com	9876543210	abc,bcd,	\N	\N	\N	\N	2026-06-04 11:08:14.43871	2026-06-04 11:08:14.43871	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	450.0	\N	\N	f	customer	\N	abc,bcd,	\N	\N	\N	\N	cash	\N	\N	f
232	550	\N	BK202606042033	2026-06-04 12:18:05.765038	draft	6	unpaid	978.0	47.0	\N	1025.0	\N	\N	Customer Name	venubha1477@gmail.com	9876543210	abc,bcd,	\N	\N	\N	\N	2026-06-04 12:18:06.499257	2026-06-04 12:18:11.217326	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1025.0	\N	\N	f	customer	\N	abc,bcd,	MKS_20260604174810_5A0F2DB5	session_TfLuYXf3-pg8PzTL5Tx-mE_tQ4P3xpsGb84kiKiLGf44WOKucol7BntNVX9xBfRx8lwyXWXdaZOm-QRBRZuY6hdsAKHiwWeQC9WZ5c5-d_6Yndxj26wpgatHCwO7	\N	\N	cashfree	2026-06-04 12:18:10.518127	\N	f
233	551	\N	BK202606044337	2026-06-04 12:46:36.766028	confirmed	5	unpaid	1.0	0.0	\N	51.0	\N	\N	Lakshmi K T	kt.laxmi87@gmail.com	9743766433	Nagendra block	\N	\N	\N	\N	2026-06-04 12:46:37.554581	2026-06-04 12:46:37.554581	\N	\N	\N	\N	50.00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.0	\N	\N	f	mobile_api	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
234	550	\N	BK202606044456	2026-06-04 14:30:43.508001	draft	6	unpaid	571.0	29.0	\N	600.0	\N	\N	Customer Name	venubha1477@gmail.com	9876543210	abc,bcd,	\N	\N	\N	\N	2026-06-04 14:30:43.932924	2026-06-04 14:30:45.698061	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	600.0	\N	\N	f	customer	\N	abc,bcd,	MKS_20260604200044_6EE2C72F	session_DcFiOoCBFspVwIMdRjUKjEfJMTeieOyBXsgFc_fGCQFigbLXYtPD2Eh6uL5LsHWBzF0UgSuHmzlAJyhfsMII02c0k7tZsVVkqOo-hm1fmuSAvsMYRUIehzgehROC	\N	\N	cashfree	2026-06-04 14:30:45.044084	\N	f
235	550	\N	BK202606045262	2026-06-04 14:31:24.542271	draft	6	unpaid	571.0	29.0	\N	600.0	\N	\N	Customer Name	venubha1477@gmail.com	9876543210	abc,bcd,	\N	\N	\N	\N	2026-06-04 14:31:24.951855	2026-06-04 14:31:28.286556	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	600.0	\N	\N	f	customer	\N	abc,bcd,	MKS_20260604200127_A1175D39	session_k-m5Kk5suJdZIOy1pWW-2K2f_XAZFAlcB7bT7oOcMm-k7cpwsTpBylXL3wSZzYHW1E8odHLoFZbwScy26OtHDrxRJPFOsLckU3PlMDSe88r0-tpvTiEGT5Qjrw0k	\N	\N	cashfree	2026-06-04 14:31:27.682723	\N	f
236	550	\N	BK202606044467	2026-06-04 14:51:46.357292	draft	6	unpaid	571.0	29.0	\N	600.0	\N	\N	Customer Name	venubha1477@gmail.com	9876543210	abc,bcd,	\N	\N	\N	\N	2026-06-04 14:51:46.936192	2026-06-04 14:51:50.893775	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	600.0	\N	\N	f	customer	\N	abc,bcd,	MKS_20260604202149_CAF18D56	session_r89XTV151lhHoekC5TP4DVvPbURugAhkNjl-4SwI6d5_yAp7ooI3V4DXiPP9hObudANmeDsHiUmI0T7W6bB2aIBvLk7aq_AaVqCjl8GkYbIwJOeNMOBEcfdNSO5b	\N	\N	cashfree	2026-06-04 14:51:49.648892	\N	f
237	550	\N	BK202606047653	2026-06-04 15:09:26.972527	confirmed	5	unpaid	1595.0	80.0	\N	1675.0	\N	\N	pramod bhat	venubha1477@gmail.com	09190939393	dfd, Bangalore, karnataka, 560091	\N	\N	\N	\N	2026-06-04 15:09:27.414223	2026-06-04 15:09:27.414223	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1675.0	\N	\N	f	customer	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
238	\N	1	BK2026060668EB49	2026-06-05 18:30:00	shipped	4	unpaid	2896.0	144.0	0.0	3040.0		\N	BILVA NATURALS		+91 94814 35515	SRINIVASAPURA TALUK , KOLAR DISTRICT - 563135	t	INV-06-00002	\N	0.0	2026-06-06 09:47:29.814039	2026-06-06 09:52:43.72474	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3040.0	\N	\N	t	admin	\N	\N	\N	\N	\N	\N	cash	\N	\N	t
239	551	\N	BK202606063000	2026-06-06 10:16:11.855718	confirmed	5	unpaid	2.0	0.0	\N	52.0	\N	\N	Lakshmi K T	kt.laxmi87@gmail.com	9743766433	Giri nagar	\N	\N	\N	\N	2026-06-06 10:16:12.127439	2026-06-06 10:16:12.127439	\N	\N	\N	\N	50.00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2.0	\N	\N	f	mobile_api	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
240	564	\N	BK202606076193	2026-06-07 04:52:07.766462	confirmed	5	unpaid	433.0	22.0	\N	505.0	\N	\N	Sreenivasa Thimmaiah	sreenidsport@gmail.com	9845691412	Banashankari	\N	\N	\N	\N	2026-06-07 04:52:07.9277	2026-06-07 04:52:07.9277	\N	\N	\N	\N	50.00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	455.0	\N	\N	f	mobile_api	\N	\N	\N	\N	\N	\N	cash	\N	\N	f
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.categories (id, name, description, image, status, display_order, created_at, updated_at, image_backup_url) FROM stdin;
11	Dairy Products	At Marali Santhe, we bring you pure, farm-fresh dairy products sourced directly from trusted local farmers. Our dairy range is rooted in traditional methods, ensuring natural taste, high nutrition, and zero compromise on quality.	\N	t	0	2026-03-19 08:15:24.703238	2026-03-19 08:15:24.703238	\N
12	Dairy & Farm Fresh	At Marali Santhe, we bring you pure, farm-fresh dairy products sourced directly from trusted local farmers. Our dairy range is rooted in traditional methods, ensuring natural taste, high nutrition, and zero compromise on quality.	\N	t	0	2026-03-19 08:17:09.223285	2026-03-19 08:17:09.223285	/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsiZGF0YSI6MTUsInB1ciI6ImJsb2JfaWQifX0=--7924a1d2f51547fc8e0255ca8e95bac974ef3fb4/rice.png
13	Natural Sweeteners	“Unprocessed • Farm Sourced • No Added Sugar” 	\N	t	0	2026-03-19 08:53:32.125964	2026-03-19 08:53:32.125964	/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsiZGF0YSI6MTYsInB1ciI6ImJsb2JfaWQifX0=--a90217915751dc7fcca4e3fe78f24dc27301e20c/vegetables.png
14	OILS 	At Marali Santhe, we follow a refined wood pressing process that blends traditional wisdom with precise extraction techniques. Our oils are produced without any harmful substances, ensuring they remain clean, safe, and unadulterated.\r\n\r\nEvery drop reflects purity—free from chemicals, free from contamination, and rich in natural goodness. With farm-sourced ingredients and careful processing, Marali Santhe Wood Pressed Oils deliver authenticity, nutrition, and trust in every use.	\N	t	0	2026-03-19 09:09:10.004612	2026-03-19 09:09:10.004612	\N
15	Grains & Millets	At Marali Santhe, our Grains & Millets collection brings together carefully sourced staples rooted in traditional food culture. From native rice varieties to nutrient-rich millets like ragi, jowar, and foxtail, every product is selected with a focus on quality and authenticity.\r\n\r\nSourced directly from farms, our grains and millets are free from harmful substances and unnecessary processing, ensuring you receive food in its most natural form. Whether for daily meals or traditional recipes, they offer a wholesome and balanced way to nourish your family.\r\n\r\n	\N	t	0	2026-03-19 09:28:30.674074	2026-03-19 09:28:30.674074	\N
\.


--
-- Data for Name: client_requests; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.client_requests (id, title, description, status, priority, customer_id, created_at, updated_at, stage, stage_updated_at, stage_history, assignee_id, department, estimated_resolution_time, actual_resolution_time, name, email, phone_number, ticket_number, admin_response, resolved_by_id, submitted_at, resolved_at) FROM stdin;
\.


--
-- Data for Name: coupons; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.coupons (id, code, description, discount_type, discount_value, minimum_amount, maximum_discount, usage_limit, used_count, valid_from, valid_until, status, applicable_products, applicable_categories, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: customer_addresses; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.customer_addresses (id, customer_id, name, mobile, address_type, address, landmark, city, state, pincode, latitude, longitude, is_default, created_at, updated_at) FROM stdin;
3	550	asa	09190939393	home	dfd		Bangalore	karnataka	560068	\N	\N	\N	2026-06-03 11:44:51.401697	2026-06-03 11:44:51.401697
4	550	sdd	09190939393	office	dfd	sds	Bangalore	karnataka	560068	\N	\N	\N	2026-06-03 11:45:14.414749	2026-06-03 11:45:14.414749
5	550	pramod bhat	09190939393	home	dfd	sds	Bangalore	karnataka	560001	\N	\N	\N	2026-06-03 13:24:55.493766	2026-06-03 13:24:55.493766
6	550	pramod bhat	09190939393	home	dfd		Bangalore	karnataka	560091	\N	\N	\N	2026-06-04 05:45:38.320729	2026-06-04 05:45:38.320729
7	550	pramod bhat	09190939393	home	dfd		Bangalore	karnataka	560091	\N	\N	\N	2026-06-04 05:45:38.342297	2026-06-04 05:45:38.342297
\.


--
-- Data for Name: customer_formats; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.customer_formats (id, customer_id, pattern, quantity, product_id, delivery_person_id, status, created_at, updated_at, days) FROM stdin;
\.


--
-- Data for Name: customer_wallets; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.customer_wallets (id, customer_id, balance, status, notes, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.customers (id, first_name, last_name, email, mobile, created_at, updated_at, longitude, latitude, whatsapp_number, auto_generated_password, location_obtained_at, location_accuracy, password_digest, middle_name, address, birth_date, gender, marital_status, pan_no, gst_no, company_name, occupation, annual_income, emergency_contact_name, emergency_contact_number, blood_group, nationality, preferred_language, notes, status, is_registered_by_mobile, password_reset_token, password_reset_sent_at) FROM stdin;
484	Dharani	Kannan	tkdharani@gmail.com	9655761911	2026-03-23 04:41:03.999238	2026-03-25 07:32:04.762238	\N	\N	\N	\N	\N	\N	$2a$12$ibrA9s9fdzW9DGn66zpm7uFsNpBat8WREnXYm/o63GnDeccgsulPm	\N	904, A block, Nester Raga Apartments, Mahadevapura, Bangalore 560048	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	ag50GLF28aW-Aipgp8ejmz89YUt_jLg02WCu2N3m4OI	2026-03-25 07:32:04.760871
487	Ajji	G	mamathanagaraju08@gmail.com	9739001874	2026-03-25 10:14:56.163746	2026-03-25 10:14:56.163746	\N	\N	\N	\N	\N	\N	$2a$12$rUKMyhjNoEYL.X2qZh8M8OYdlGrFPsdOwFlTXQqaf1BOGX9BW7Cca	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
481	raghunandan	kt	drwisedev@gmail.com	9844070041	2026-03-19 08:07:57.31055	2026-03-26 04:32:20.94922	\N	\N	\N	\N	\N	\N	$2a$12$gyqj7jB9ewkbR2pwgUS48erf/AkROt9Z/LOvPNzIYO5o9KF0Rg73m	\N	5 8th cross N.R Layout R.M Nagar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	532cd3806192bd80d241829dc89e74a2574681e930b96d9cd4e4160672934e46	2026-03-26 04:38:33.855333
482	John	Doe	gepeucoubourou-9168@yopmail.com	7349673793	2026-03-21 07:05:43.706315	2026-03-21 07:05:43.706315	\N	\N	\N	\N	\N	\N	$2a$12$b11ijjC00wkGnr6d9vLJeuWTMrEJRZwzanI5zCP91gRvL1uEY9d5i	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
483	Swapna	K	sapnasappu813@gmail.com	7019988524	2026-03-21 09:50:59.420494	2026-03-21 09:50:59.420494	\N	\N	\N	\N	\N	\N	$2a$12$C/BIvt8hurt.pTcVkqUd8OOmT0orz2D7GX6oZ.OSznbBAQ5uSRWMy	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
489	Sunil 	Cr	sunilkumar.blg6@gmail.com	9880624210	2026-03-28 17:48:01.414324	2026-03-28 17:48:01.414324	\N	\N	\N	\N	\N	\N	$2a$12$bhno6U/RxI0J6mm3uQR.N.qXqFNIEJ5Y/0hYH7Gjhp9uI445qF2p.	\N	DG63, D2 block, Ittina neela apartment, glass factory road, anantha nagara, Electronic city phase 2, Sarjapura, Anekal Taluka.	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
486	Payment	Test	paymenttest@test.com	9876543210	2026-03-25 07:01:01.958534	2026-03-29 01:39:46.934999	\N	\N	\N	\N	\N	\N	$2a$12$f7gdPNFLkUCwGETq64Hzuuj4B6ScGtek1ryPdt8vb9PkwmnVYItqO	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
490	BHAGYA 	H P 	BHAGYA081@GMAIL.COM	9741111199	2026-04-14 10:55:04.335654	2026-04-14 10:55:04.335654	\N	\N	\N	\N	\N	\N	$2a$12$XWyMI5w3VspqqX37exujtePp.N.dHNGLcCPGgXPVmvo97xbE1BKwW	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
491	GIRISH 	KJ	girideepa@yahoo.co.in	9448646855	2026-04-14 18:22:51.022123	2026-04-14 18:22:51.022123	\N	\N	\N	\N	\N	\N	$2a$12$qF4WU7M/YoJNw2neKwaYfeGqUi5foN7MI4ecTJ0uEA8mSJ33Po5PW	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
493	Leena	M	suruleena24@gmail.com	9591058526	2026-04-15 12:06:59.012457	2026-04-15 12:06:59.012457	\N	\N	\N	\N	\N	\N	$2a$12$IRyW.fBNkp9FfUqwl2yGLuysJcj2Yp9Lrbdzq.jfTUQwhddU7m3KS	\N	#24,12mina road 12th cross, Rajajinagar, shivanagar Bangalore 10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
494	Abhishek 	Vadoni 	abhishekvadoni@gmail.com	7026182080	2026-04-16 07:11:33.940443	2026-04-16 07:11:33.940443	\N	\N	\N	\N	\N	\N	$2a$12$cYikShLxorISdBZyEElxi.uHusKvmcISX.3NgyATtcU5xcET3iouC	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
495	Ramya 	V	ramyav244@gmail.com	7975374829	2026-04-16 14:15:05.172162	2026-04-16 14:15:05.172162	\N	\N	\N	\N	\N	\N	$2a$12$qDc/7HWnwDutJiRoSqc5Y.PX54kynoJcghBc6PQ9Ty5b.QoiyZjA.	\N	#101 B block Brocade Vista Apartment RR nagar 560098	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
496	Pramod Test	Bhat	pramodbha8@gmail.com	9632850872	2026-04-17 10:42:03.777822	2026-04-17 10:42:03.777822	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N
497	Mary	Kumari	maryparasannakumari567@gmail.com	7411138534	2026-04-17 16:49:51.637682	2026-04-17 16:49:51.637682	\N	\N	\N	\N	\N	\N	$2a$12$V3j1zjiBKl5Av9UUoELhX.1X0j8rYR599wwoWGFvXt5GxIhNymJ5O	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
510	Aruna 	Satish	arunakumaricv@gmail.com	8197996520	2026-04-26 02:38:44.294067	2026-04-26 02:38:44.294067	\N	\N	\N	\N	\N	\N	$2a$12$DoYtID.sHwTytd2ONfANz..HcidKZYrK3UEVSxU2viDXJShJ0eROW	\N	4th cross govt school road Ramagondanahalli, Whitefield, Bengaluru, Karnataka 560066, India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
511	Shivu	N	nsiddaraju828@gmail.com	6361006295	2026-04-27 09:01:11.763605	2026-04-27 09:01:11.763605	\N	\N	\N	\N	\N	\N	$2a$12$DjHd53uPfBvq0viKtSvakOA5xflxa/yttcuQfkFaMvz5JzkzHMb66	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
498	Nandeesh	Km	nandeesh166@gmail.com	9535160056	2026-04-19 08:37:42.99288	2026-04-19 08:41:11.86629	\N	\N	\N	\N	\N	\N	$2a$12$RChLVUwYw/6Fp/HiLEpD6eXG6rxafv0YVmLvNYiR8AnNy/nyovJAC	\N	310, Apoorva dew drops apartments, anjanapura village, anjanapura	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
499	Gokul	Krishna Mudaliar 	gokul.k26@gmail.com	9620261535	2026-04-19 10:22:48.084165	2026-04-19 10:22:48.084165	\N	\N	\N	\N	\N	\N	$2a$12$XjUu4edrL1.i7QaE0728FezBaaJLoVvp.hxQNVmG4CY6Zltt0va9i	\N	gokul.k26@gmail.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
500	Chitra 	Jayaram 	jayaram.chitra@gmail.com	9008055774	2026-04-19 13:32:54.63178	2026-04-19 13:32:54.63178	\N	\N	\N	\N	\N	\N	$2a$12$7eCRHjWThtza8fdfq5/5jeCT9jiPxloa9g3qD6.7VFjbVqAYouZyy	\N	F1 Sai Madhura Elegance\r\n24th Main road , JP Nagar 6th phase	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
512	R RAJA	CHANDRA	r.rajachandra@gmail.com	9845541370	2026-04-30 17:23:45.481303	2026-04-30 17:23:45.481303	\N	\N	\N	\N	\N	\N	$2a$12$JMqQ/0yfsKCG9fe13Yq50.jol/nMuEfgff7lZ7b4apNm28k8eczKm	\N	241 , 15th MAIN ,, RMV EXTENSION\r\nRMV EXTENSION	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
492	Bhuvana 	Kumar	bhuvanacm88@gmail.com	8050152460	2026-04-15 06:08:00.720193	2026-04-15 06:08:00.720193	\N	\N	\N	\N	\N	\N	$2a$12$ovl3.DEnTkjYZjjLnubu4eqSfC1B4JCZa9bw89QWY/G.jTtakaJ0a	\N	D/o Chandrappa C M, Mylaralingeshwara nilaya, Behind Police station, Near Nadakacheri, Gandasi Arsikere taluk, Hassan District	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	9dbc8308815867050778a86ca6e929e8eecd9fd8baf65f3d3cdc63ea1db560cb	2026-04-19 19:26:21.974904
501	Bhuvan	Kumar 	muddammas19@gmail.com	9741850615	2026-04-19 19:33:42.081605	2026-04-19 19:33:42.081605	\N	\N	\N	\N	\N	\N	$2a$12$lVymGm6JIjhSOrFkktin6u5A02b7oWxy8N8gpgyK.HYejRFqf4yB6	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
502	Subramani	B y	subbucmr@gmail.com	9611418529	2026-04-20 11:50:47.323885	2026-04-20 11:50:47.323885	\N	\N	\N	\N	\N	\N	$2a$12$novDu3w/iNYiN.qt/M2IBeVduFoy2rd7fuakpZj1sxlM8RJf7v462	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
503	Ankitha	Shetty	ksankitha@gmail.com	9480524150	2026-04-20 22:05:05.994796	2026-04-20 22:05:05.994796	\N	\N	\N	\N	\N	\N	$2a$12$NZTwiHJprZMCL9lMHS57iOa3S8eCF0WTMkwffVPlksTgPYEhp0cq.	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
504	Shwetha	Jagadish	shwetha.computers@gmail.com	9844425999	2026-04-24 16:10:07.535975	2026-04-24 16:10:07.535975	\N	\N	\N	\N	\N	\N	$2a$12$/w0nTBwaySBd1LDdsMIlTuiEL08NxgVv10YUHeDjs.JWXLo4pEXmS	\N	Surya Kiran Residency, #105, 1st Floor, ITI layout, Ullal RTO Road, near Mallathalli Club, Annapurneshwarinagar, Bangalore-560091	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
505	Amrutha	Shetty	shettyamrutha77@gmail.com	7975274591	2026-04-25 08:55:49.813311	2026-04-25 08:55:49.813311	\N	\N	\N	\N	\N	\N	$2a$12$nNlvA0FmIDtTI.WDdsOA9.RfgECMrUJCuW6j06evg00weKdTYQds6	\N	Hebri 	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
506	Bhuvana	G	2000bhuvanagowda@gmail.com	8088069886	2026-04-25 09:09:27.767852	2026-04-25 09:09:27.767852	\N	\N	\N	\N	\N	\N	$2a$12$/2HmJbv02cC2F4hNAZ7OKuxaQsowOT5HqjBo0N.kVtRbsmVN2NBtu	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
507	Syed	Rukhiya	rukhiya21@gmail.com	9686770820	2026-04-25 10:21:39.510294	2026-04-25 10:21:39.510294	\N	\N	\N	\N	\N	\N	$2a$12$RRS8lw5m1s7rXwzafQZNleXuezSIyLlF/F73RjxT7xCGhna5ZCBKG	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
508	Kavya	S	kavyashreesacharya95@gmail.com	9008042168	2026-04-25 10:34:27.75733	2026-04-25 10:34:27.75733	\N	\N	\N	\N	\N	\N	$2a$12$N6t7CvbGLUVLleZatXoe5OoWIPuv4Gl10XI9lQMIsdmnlp7m3lGvm	\N	#7, 11th cross, Bendrenagar bsk 2nd stage Bangalore-70	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
509	Narasimha 	S	simhajog@gmail.com	9482519010	2026-04-25 12:26:04.808207	2026-04-25 12:26:04.808207	\N	\N	\N	\N	\N	\N	$2a$12$cDSgAaV.Xvjked8wq/IlguFGe9DR/4dhAVqtAck1piJj3EqYqCdym	\N	\r\n	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
513	John	Doe	johdn.doe@example.com	9876543010	2026-05-02 07:19:22.43174	2026-05-02 07:19:22.43174	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N
514	Rajesh	Raj	raj3@gmail.com	9879879871	2026-05-02 10:26:16.492507	2026-05-03 07:33:24.601808	77.59460000	12.97160000	\N	\N	2026-05-03 07:33:24.4468	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N
515	ssd	ds	pramodbha88@gmail.com	9292919191	2026-05-03 01:04:33.74768	2026-05-03 01:04:33.74768	\N	\N	\N	\N	\N	\N	$2a$12$VGzTC6epko6NoR3aTN7xP.XZJ3nsw7BJXu/dkQyKori94dMmRzbvi	\N	dfd	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
517	Shrikanth	B	shrikanthb842@gmail.com	9902744321	2026-05-03 05:33:06.254374	2026-05-03 05:33:06.254374	\N	\N	\N	\N	\N	\N	$2a$12$LJXutyUFcPxmN4VzSsJTEunsGGZZgDCuGrCTKwn9zL2ludvRyD9Ku	\N	1450, 12th cross, 21st main road, HSR layout sector1 vanganahalli 560102	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
516	Test	Customer	testcustomer@example.com	9876043210	2026-05-03 05:02:28.202585	2026-05-03 07:23:08.853699	77.59460000	12.97160000	\N	\N	2026-05-03 07:23:08.699267	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N
518	Bdbhd	Nxn	pramodbha87@gmail.com	9632850870	2026-05-03 10:01:25.500252	2026-05-03 10:01:25.500252	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N
521	pramod	bhat	pramodbha8899@gmail.com	9898989898	2026-05-06 07:54:21.102936	2026-05-06 07:54:21.102936	\N	\N	\N	\N	\N	\N	$2a$12$PsNgEks5tWjin7q.01/EdOyAez5HsQ1cVaw.vxAX.XUmOvaJTMfN2	\N	ds	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
522	Ashwini	Seetharam	ashwini_74@yahoo.com	9686758463	2026-05-06 11:24:26.973129	2026-05-06 11:24:26.973129	\N	\N	\N	\N	\N	\N	$2a$12$n.P/cmWVEOXX3FJyIIFvQeTLKVYtMKfRBddmnSX6BJ3jre3LH1ax6	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
520	Raghu	Kt	raghukt.shetty89@gmail.com	9035408833	2026-05-04 10:46:16.277596	2026-06-03 12:56:24.671579	\N	\N	\N	\N	\N	\N	$2a$12$5KdoEtnfKuGzKdtw.fCdOO3teZR9FSueURBCkGqLEyyEwWmDxJ/Hy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N
523	Surabhi 	Dhanush 	surabhi.unnathi@gmail.com	8217495716	2026-05-07 06:49:18.521691	2026-05-07 06:49:18.521691	\N	\N	\N	\N	\N	\N	$2a$12$lJGP.8bLvF6m9lfHc8158ujmgVlCTQ9rdG3ra8YKsTiMvucLCtfyq	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
524	test	bhat	test@gmail.com	9797979797	2026-05-09 04:41:33.167209	2026-05-09 04:41:33.167209	\N	\N	\N	\N	\N	\N	$2a$12$tTQKIqt1hEpPnajgr62iQ.i4TsYvuXKc5mN0qVAi.omiXSdLaBO9S	\N	sdsd	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
519	Ncnf	Ffnn	pramodbha8dh@gmail.com	9632626265	2026-05-03 11:02:04.772037	2026-05-09 06:05:24.668138	74.41209537	14.42396656	\N	\N	2026-05-09 06:05:24.512145	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N
525	Mohan	Kumar	muralidreammohana@gmail.com	9997234533	2026-05-09 14:30:44.735566	2026-05-09 14:30:44.735566	\N	\N	\N	\N	\N	\N	$2a$12$LPq6g5e6xmrEcrycNAPs/.5qlxjIUnLL4p1rRKjktQCjIRP4K8JY2	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
526	sd	sdd	sdds@gmail.com	9898989891	2026-05-10 05:10:24.20987	2026-05-10 05:10:24.20987	\N	\N	\N	\N	\N	\N	$2a$12$4IL2qsfKCJA94B8C0j3JhuLLhRj9AJ7R2IYPChvHW4k34IxgLF1Vq	\N	sdsd	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
527	sds	sds	909dsds3939393fdfds@gmail.com	8888999999	2026-05-10 05:20:08.260449	2026-05-10 05:20:08.260449	\N	\N	\N	\N	\N	\N	$2a$12$6PNn6ljl5sHjrab00uKPp.jFyeKZoVCK5cJp0TfG./FkcUuxiv8j.	\N	dfd	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
528	Eeuhhhj	Ggbbvh	hah@gmail.com	9632859632	2026-05-10 07:10:23.391313	2026-05-10 07:10:23.391313	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N
529	dddssdd	dsd	ddd@gmail.com	9898128989	2026-05-10 09:11:52.64347	2026-05-10 09:11:52.64347	\N	\N	\N	\N	\N	\N	$2a$12$g1rGw.BKHR8SGmYLJ4sdUu8MmQ0/crVSn.zsgLJUXxGZhCQHO.OEq	\N	sds	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
530	Kavitha	k v	kavithapdo6@gmail.com	8722325585	2026-05-13 17:12:33.757306	2026-05-13 17:12:33.757306	\N	\N	\N	\N	\N	\N	$2a$12$VPgH1qzovxVyuGgx9Iz6yuZNvIpWkPbQIYww5xdxvF35.bofX7P1K	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
531	Rakesh	Hiremath	rakeshhiremath06@gmail.com	8904408548	2026-05-14 10:25:56.113755	2026-05-14 10:25:56.113755	\N	\N	\N	\N	\N	\N	$2a$12$UM.vf8gCSaRI8DacmaCSUuOsY0P.9dxu0YhpaV8b3CR68rpsINwhq	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
532	Manjunatha 	G V	manjunath7121999@gmail.com	7483427580	2026-05-17 05:39:33.300109	2026-05-17 05:39:33.300109	\N	\N	\N	\N	\N	\N	$2a$12$vdjlUhkL8FfrbsY6JAmRleIu2UszpeamUK2rVkjmSfsGh.SkHj4vO	\N	Devasamudra Rd	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
533	Chethan 	Vd	chethan199419@gmail.com	9535133070	2026-05-17 06:46:27.588625	2026-05-17 06:46:27.588625	\N	\N	\N	\N	\N	\N	$2a$12$MPISKtBGGaZsp4EPuaTJNuy7w.smgCX31Ra6nyyWOY6VUEydrxPHm	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
534	Chethan 	Vd	chethan199419@gmail.com	9535133070	2026-05-17 06:46:27.798708	2026-05-17 06:46:27.798708	\N	\N	\N	\N	\N	\N	$2a$12$IHDjQFBZPu3AMN7kSw1aZu99yq6ql/eUO9FsdiWL77tcwYFXgnuWm	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
535	Naveen 	Kumar nc 	Naveenshetty2892@gmail.com	7892392953	2026-05-17 14:43:25.080212	2026-05-17 14:43:25.080212	\N	\N	\N	\N	\N	\N	$2a$12$iLM8YD/Lxc7HSZRN0A8EvOnGZgzfKumMll4kq2OqBpivWshKgY8MC	\N	Laggere	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
536	Priya	Sharma	priya.sharma@example.com	9876543211	2026-05-18 11:47:24.764677	2026-05-18 11:47:24.764677	77.20900000	28.61390000	9876543211	PRIY@2026	\N	\N	$2a$12$P2/ul1dGn8Mn7tA.Np5nmODdtV67utRIJZ1MeAPkRvRhPzZCL.ng.		456 Park Avenue, Delhi, 110001	1988-05-20	female	single	FGHIJ5678K			Doctor	800000.0	Raj Sharma	9876543212	B+	Indian	Hindi	Regular Customer	t	\N	\N	\N
537	srivatsa	bs	srivatsa.bs@gmail.com	9880886500	2026-05-19 08:03:43.374038	2026-05-19 08:03:43.374038	\N	\N	\N	\N	\N	\N	$2a$12$Az7qRGgLkZVl1bI6ARekQu3HwZglEWKW9Mvr8.B0f8YQ9HIpXg2yq	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
538	Thejaswini 	Shivakumar 	tejaswinibangalore519@gmail.com	9206335932	2026-05-19 15:04:26.995119	2026-05-19 15:04:26.995119	\N	\N	\N	\N	\N	\N	$2a$12$S3.jVtsMAhAlZ/LpuZNLi.mwib7o3Xj.vi1Gbmik4cqAh0.Qscr6a	\N	No 59/A,3rd Cross, Dhanvantarivana Layout,Mariyappana Palya,Jnana Bharathi post, Bangalore -560056	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
539	Upendra	Prabhu	upensahana@gmail.com	9148095790	2026-05-24 03:44:36.627756	2026-05-24 03:44:36.627756	\N	\N	\N	\N	\N	\N	$2a$12$pY4Mde5uDfy4ON5RwuwOMOExP3uuQaxreuhVs6qIOlKz52wuoNWNW	\N	Century Pragati Apt Lakshmi Layout Arekere 560076	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
540	as	sa	9093939ss393fdfds@gmail.com	9181818181	2026-05-24 12:39:49.083754	2026-05-24 12:39:49.083754	\N	\N	\N	\N	\N	\N	$2a$12$GhLhix/Kt5zH9frbJwP06uevzf.7DU6qVytqiRSXcgVjAHTGKYJfq	\N	dfd	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
541	smart ariser	test	smar@gmail.com	8281989898	2026-05-25 04:59:47.566687	2026-05-25 04:59:47.566687	\N	\N	\N	\N	\N	\N	$2a$12$5UwgU0ublfb6oZsZsVDvyuERCAHEo803nOE3BnJsaDGyZoOHV6SgK	\N	test	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
542	Ndnd	Jdnd	smarr@gmail.com	9632569686	2026-05-25 05:07:07.378186	2026-05-25 05:10:29.108835	74.41204160	14.42417315	\N	\N	2026-05-25 05:10:28.664206	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N
543	 Eena	Mp	veenarangaiah@gmail.com	9164213727	2026-05-25 11:51:07.204199	2026-05-25 11:51:07.204199	\N	\N	\N	\N	\N	\N	$2a$12$VzkAeD6ordRYJOwSCjpcUuBcbTcixqNxhWWjGIPvD1zXlr.ILSEqy	\N	Flat27,1st cross,#1st main, Aditya layout, Ayyappangar, Krpuram-560036	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
544	ROOPA	DEVARAJ	roopadevraj666@gmail.com	7619671065	2026-05-27 09:40:31.409606	2026-05-27 09:40:31.409606	\N	\N	\N	\N	\N	\N	$2a$12$l0ndFpuHOFz3GDgHyhNEcu893b0VoGvX7qx5NOZgsBdKV5c4E9BV.	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
545	Tilak	Rao	tilakraok@gmail.com	9611922524	2026-05-30 15:49:58.153605	2026-05-30 15:49:58.153605	\N	\N	\N	\N	\N	\N	$2a$12$IWAa3W2fMrolvwPA.RGb1ufA5TG.Xm/TC45ntcUYwjqXpOH4rQBse	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
546	Hdu	Sjj	test-customer@gmail.com	9632859639	2026-06-02 10:49:33.000037	2026-06-03 03:42:21.260847	77.68065208	13.01388953	\N	\N	2026-06-03 03:42:20.870112	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N
547	Raghu	Shetty	meghana.siddaraju97@gmail.com	9880393831	2026-06-03 05:38:50.903871	2026-06-03 05:38:50.903871	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N
548	Egh	Eh	abcabc@gmail.com	9696969696	2026-06-03 07:04:28.765705	2026-06-03 07:04:28.765705	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N
551	Lakshmi	K T	kt.laxmi87@gmail.com	9743766433	2026-06-03 15:16:53.817741	2026-06-03 15:16:53.817741	\N	\N	\N	\N	\N	\N	$2a$12$G3qt9utqu1VdueEwfip17.arzO8pufZj9kpfzU2WpvfqJaiV6cDIi	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N
552	Rajesh	Bit	rajeshkbit@gmail.com	9980325999	2026-06-03 15:44:20.630697	2026-06-03 15:44:20.630697	\N	\N	\N	\N	\N	\N	$2a$12$rU9wJDQ8d8WE0xf7F1T.eOCOrTm7wmvYQs64q1xQvqC39le7Z0MQC	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N
553	Neethu	Shree	neethushreeneethushree005@gmail.com	9900770296	2026-06-03 15:46:00.649282	2026-06-03 15:46:00.649282	\N	\N	\N	\N	\N	\N	$2a$12$zpbfTA5uqixfUmQtYM./B.kym99jCl4ZI5pAoVxISn/UYYQ125Wdi	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N
554	Raghavendra	RBN	raghavendra.rbn059@gmail.com	9663095152	2026-06-03 17:12:17.084021	2026-06-03 17:12:17.084021	\N	\N	\N	\N	\N	\N	$2a$12$/KKZFy1upMj.w980utxLtuyy4Or8xBIG9VSrfshPqoY1ANOuVr4ZC	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N
555	Doddabasayya	Am	doddabasayyaa@gmail.com	8884630173	2026-06-04 05:38:22.733044	2026-06-04 05:38:22.733044	\N	\N	\N	\N	\N	\N	$2a$12$cp76CpoFNLTiDEHUjl7NaeMlMXd7VQxoEy93vMzYcfaDGZFKejY2e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N
549	Venu	Bhat	venubha147@gmail.com	9606889562	2026-06-03 09:44:42.227232	2026-06-03 10:36:26.199539	\N	\N	\N	\N	\N	\N	$2a$12$EwuAepmW1RgCLOro5CHt8Owa9GSSxJDbZd0w6Q7RgEwm0acfMt/iK	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N
550	Bdhd	Bddjj	venubha1477@gmail.com	9632850875	2026-06-03 10:38:24.553762	2026-06-03 11:09:13.935369	\N	\N	\N	\N	\N	\N	$2a$12$C25wENxWYWCWn34FAwAlLesjD9lHnru5..lo036hdHEjSvMZHrIa.	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N
556	Dhiraj	Raj	racerdhiraj123@gmail.com	7619128988	2026-06-04 10:53:29.035876	2026-06-04 10:53:29.035876	\N	\N	\N	\N	\N	\N	$2a$12$CJOBDmEQBTTW/0iBMd8fzelxr1ThMhz0tPyy6lLQalsCLaluw99aC	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N
557	NAVEEN	NAVEEN	naveengowdapr@gmail.com	7019218203	2026-06-04 13:01:02.070391	2026-06-04 13:01:02.070391	\N	\N	\N	\N	\N	\N	$2a$12$XVSnx/u1lme4xHPH/owAn.asp92jO3h0oRRa6WxjeNB2B50yfcFrO	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N
488	raghu	kt	raghubit040@gmail.com	9035378833	2026-03-27 15:04:43.94646	2026-06-03 12:48:54.77197	\N	\N	\N	\N	\N	\N	$2a$12$V2MFGdVmQNdFuvVP3C0oo.6dZR3gRYXAYOL0xj10bL5xDQOdO9Q4a	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
561	Jayasudha	Raj	jayasudharaj54@gmaii.com	9880753433	2026-06-06 10:45:41.001025	2026-06-06 10:45:41.001025	\N	\N	\N	\N	\N	\N	$2a$12$ipmP0KWmcfz8OdDIjT7KHO05XvPFxkWwOEWXIp9fZ.w9/A7dXFKB.	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N
558	Kp	Mdy	raghave32kp@gmail.com	9035109925	2026-06-05 04:24:35.711518	2026-06-05 04:24:35.711518	\N	\N	\N	\N	\N	\N	$2a$12$nGpWhm09a43wU5pPajHNHeiuAphIAz3y0r8KBsy1AfIIcmQI3DQc6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N
559	Santhosh 	C	sankgl.007@gmail.com	8431579359	2026-06-05 13:58:07.672189	2026-06-05 13:58:07.672189	\N	\N	\N	\N	\N	\N	$2a$12$j8klJN/Ue3Avv.BJobEQJO2lWRHnVqsve9uGQqGb./HpDNOM0O2Dq	\N	CANARA bank MATHIKERE gokula Bombay dyeing road yashwanthpura Banglore 	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
560	Pramila 	Gopalakrishna 	pramilagkr@gmail.com	9945758762	2026-06-06 08:57:57.306762	2026-06-06 08:57:57.306762	\N	\N	\N	\N	\N	\N	$2a$12$YL4jFw2rcA0YRJCd/IseqO6yvyAhd7NBcA7XHSY85pOzD2PmZ7K/e	\N	Near kempamma temple	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
562	Appu	K	appukori44@gmail.com	7019664613	2026-06-06 17:55:44.335119	2026-06-06 17:55:44.335119	\N	\N	\N	\N	\N	\N	$2a$12$PeUqSh1vuf6CD17X1hGFBefuhwhOogfhk31a5x2U3CxGHxN43EBta	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
563	Madan 	N	nmadan.ec1950@gmail.com	7676418851	2026-06-07 03:39:02.828342	2026-06-07 03:39:02.828342	\N	\N	\N	\N	\N	\N	$2a$12$MloGnEr98YGBsSpBLJca5uXyCklQ9eoh9QvMwXct1HgQD3BeTl0hG	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
564	Sreenivasa	Thimmaiah	sreenidsport@gmail.com	9845691412	2026-06-07 04:19:58.538441	2026-06-07 04:19:58.538441	\N	\N	\N	\N	\N	\N	$2a$12$aMcZ3eiXqtL4f30S4xK7CeCtZjVvcngcqQXLHCumwfEUB6bHcQdrG	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N
565	Abhishek 	Gowda	shobhithabhi@gmail.com	9019711436	2026-06-07 09:29:27.904519	2026-06-07 09:29:27.904519	\N	\N	\N	\N	\N	\N	$2a$12$ZxusPeSTLGHRP68XoOfJKOziu3rSBG1Q21gdOFDRZs2i5QZ4dKKPS	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
566	Chandrashekara 	S	scshekara@gmail.com	9448603409	2026-06-07 11:08:12.367134	2026-06-07 11:08:12.367134	\N	\N	\N	\N	\N	\N	$2a$12$yv6Rn5apkWjFytDEwrOQDO9v3vjiRpSu0m.gYMv1VRLptE7mjG0Re	\N	No 48 2nd Main K G S Layout Vijayanagar Bangalore 560040	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
567	Sumanth	Chiplunkar	sumanthchiplunkar@gmail.com	9743750610	2026-06-07 18:20:53.889131	2026-06-07 18:20:53.889131	\N	\N	\N	\N	\N	\N	$2a$12$a0iMN.AfBK4nrPkMTtpbIO1ZwPtmhM6wxW7Tj4.xk.OkEjAE17BdO	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
568	Yamuna	Patil	yamunapatill@gmail.com	9880898802	2026-06-08 04:52:56.458947	2026-06-08 04:52:56.458947	\N	\N	\N	\N	\N	\N	$2a$12$5BPaP2.f.YCFdA/KN8ABouPEax6arCqEZAzKBkBiz3cKg0cdeMBI.	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N
569	Mahalakshmi	Hegde	mahalakshmihegde20@gmail.com	9482017220	2026-06-08 06:59:24.605087	2026-06-08 06:59:24.605087	\N	\N	\N	\N	\N	\N	$2a$12$Tk9xONz9ANFk9aH8jEVamuhDqSyECBwY00SIgiUSbmEa48LghHpg6	\N	13-19, 1st cross Rd, M V Colony Layout, Sagar Layout, Devarachiknahalli,\r\nShloka residency,Devarachiknahalli	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
570	harsha	r	KUNCHAKI@GMAIL.COM	7829089150	2026-06-08 08:43:00.975527	2026-06-08 08:43:00.975527	\N	\N	\N	\N	\N	\N	$2a$12$gQHAHNjM4qcgaToeAH7DCevUCbDTo9OkHvUJ21DCKPeyHnU2.Q/jS	\N	#4757/32, 4TH MAIN, 2ND CROSS,\r\nB BLOCK, SS LAYOUT,	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
571	harsha	r	SUMAHARSHA1992@GMAIL.COM	9482909370	2026-06-08 08:43:47.96623	2026-06-08 08:43:47.96623	\N	\N	\N	\N	\N	\N	$2a$12$2py73AUoAAJwWL/v4RIyE.zdl3zzvPLIt6Fq.w2slEU0kRZO8isH.	\N	#4757/32, 4TH MAIN, 2ND CROSS,\r\nB BLOCK, SS LAYOUT,	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
572	Navya	Shree	gs175445@gmail.com	9482122486	2026-06-09 08:46:09.629762	2026-06-09 08:46:09.629762	\N	\N	\N	\N	\N	\N	$2a$12$jyiuQQBsM2iUmb8wwI1eauxpoBkLYByAWjZ.hfN1W87EgwCEPCg1m	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
573	Sahana 	Halli 	dhanyapatil98@gmail.com	8660081994	2026-06-09 14:52:50.457465	2026-06-09 14:52:50.457465	\N	\N	\N	\N	\N	\N	$2a$12$urgmC37M1sDax4nqhH0Q0.t450Ik3l6NGrmOAfGaDDsGsG5zchePq	\N	Singasandra banglore 560068	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
574	Pooja	U	poojau26r@gmail.com	9740019486	2026-06-10 05:35:39.069199	2026-06-10 05:35:39.069199	\N	\N	\N	\N	\N	\N	$2a$12$3bvgw/67QbkLwRTD4iXAmehmCxrCiXty61AG7Tnqr/BLgHr07NnjO	\N	No 1 Gangotri Layout Margondanahalli KR Puram Post	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
575	Raghu	Tk	raghutk.07@gmail.com	9742115931	2026-06-11 05:36:32.770276	2026-06-11 05:36:32.770276	\N	\N	\N	\N	\N	\N	$2a$12$YQg2/0Cd37tpIfEHklrXc./sYyqdonFUbTvabl2G3w2JoSyof3Jqa	\N	#22, 2nd Main Road, 2nd Cross\r\nDeepanjalinagar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
\.


--
-- Data for Name: delivery_charges; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.delivery_charges (id, pincode, area, charge_amount, is_active, created_at, updated_at, free_delivery_allowed, min_order_for_free_delivery) FROM stdin;
3	560003	Malleshwaram	60.00	t	2026-04-17 11:26:47.950762	2026-05-04 16:34:52.895851	f	0.00
4	560004	Rajajinagar	55.00	t	2026-04-17 11:26:49.154149	2026-05-04 16:51:40.407046	f	0.00
5	560005	Basavanagudi	45.00	t	2026-04-17 11:26:50.366011	2026-05-04 16:54:12.406144	f	0.00
1	560001	MG Road	50.00	t	2026-04-17 11:26:45.526608	2026-05-04 16:54:23.542827	f	0.00
2	560002	Brigade Road	56.00	t	2026-04-17 11:26:46.740864	2026-05-05 00:30:32.856511	f	0.00
6	560097	sd	344.00	t	2026-05-05 00:32:02.002367	2026-05-05 00:32:13.91043	f	0.00
7	560086	MgRoad	50.00	t	2026-05-09 04:35:26.912701	2026-05-09 04:35:26.912701	f	0.00
8	560091	sa	12.00	t	2026-06-04 05:43:29.676659	2026-06-04 05:43:29.676659	t	800.00
\.


--
-- Data for Name: delivery_people; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.delivery_people (id, first_name, last_name, email, mobile, vehicle_type, vehicle_number, license_number, address, city, state, pincode, emergency_contact_name, emergency_contact_mobile, joining_date, salary, status, profile_picture, bank_name, account_no, ifsc_code, account_holder_name, delivery_areas, notes, created_at, updated_at, password_digest, auto_generated_password) FROM stdin;
17	Javeed	Patel	maralisanthe@gmail.com	917975918232	0	KA01HE1711	12345678	NR colony Bangalore	Bangalore	Karnataka	560004	marali santhe 	919035408833	2025-12-03	15000.0	t	\N					bangalore 		2026-03-20 07:59:01.645379	2026-03-20 07:59:01.645379	$2a$12$fQKLXUAsdXmubzS3QXLGv.oyF1LIonmfs8SD0pDCskzzyW2aFz9fi	\N
\.


--
-- Data for Name: delivery_rules; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.delivery_rules (id, product_id, rule_type, location_data, is_excluded, delivery_days, delivery_charge, created_at, updated_at) FROM stdin;
42	45	0	[]	f	7	0.00	2026-03-19 09:25:14.380198	2026-03-19 14:16:08.250853
37	40	0	[]	f	7	0.00	2026-03-19 09:11:09.334159	2026-03-19 14:18:47.724587
39	42	0	[]	f	7	0.00	2026-03-19 09:15:33.460407	2026-03-19 14:20:23.015878
35	38	0	[]	f	7	0.00	2026-03-19 08:58:29.728736	2026-03-19 14:25:37.333121
36	39	0	[]	f	7	0.00	2026-03-19 09:01:27.951028	2026-03-19 14:27:19.51386
44	47	0	[]	f	7	0.00	2026-03-19 09:33:46.3973	2026-03-19 14:32:00.784716
45	48	0	[]	f	7	0.00	2026-03-19 09:35:13.537666	2026-03-19 14:33:31.185736
46	49	0	[]	f	7	0.00	2026-03-25 03:36:34.055139	2026-03-25 04:48:03.229601
34	37	0	[]	f	7	0.00	2026-03-19 08:49:25.784459	2026-03-19 13:53:14.21838
38	41	0	[]	f	7	0.00	2026-03-19 09:13:09.575057	2026-03-19 14:09:41.870206
41	44	0	[]	f	7	0.00	2026-03-19 09:23:10.661685	2026-03-19 14:11:36.35594
40	43	0	[]	f	7	0.00	2026-03-19 09:18:09.79611	2026-03-19 14:13:29.675313
48	51	3	[]	f	7	0.00	2026-04-16 07:23:03.416989	2026-04-16 07:23:03.416989
50	53	3	[]	f	7	0.00	2026-04-16 07:28:59.774079	2026-04-16 07:28:59.774079
49	52	0	[]	f	7	0.00	2026-04-16 07:26:39.373474	2026-04-16 07:30:01.490238
32	35	0	[]	f	7	0.00	2026-03-19 08:25:49.294029	2026-04-19 15:14:44.151326
51	54	0	[]	f	7	0.00	2026-04-19 15:18:46.40988	2026-04-19 15:19:07.081212
53	56	0	[]	f	7	0.00	2026-04-30 15:40:23.546484	2026-04-30 15:40:23.546484
54	57	2	[]	f	7	0.00	2026-04-30 15:45:12.055085	2026-04-30 15:45:12.055085
33	36	0	[]	f	7	0.00	2026-03-19 08:34:02.666634	2026-05-02 12:46:54.741779
47	50	0	[]	f	7	0.00	2026-03-29 05:32:37.859672	2026-05-03 05:18:49.575559
55	58	2	[]	f	7	0.00	2026-05-04 12:39:06.249068	2026-05-04 12:39:06.249068
56	59	0	[]	f	7	0.00	2026-05-04 12:41:01.609614	2026-05-04 12:41:01.609614
57	60	2	[]	f	7	0.00	2026-05-04 12:42:51.110164	2026-05-04 12:42:51.110164
58	61	1	["Karnataka"]	f	7	0.00	2026-05-04 12:44:45.652835	2026-05-04 12:44:45.652835
59	62	2	[]	f	7	0.00	2026-05-04 12:46:48.016044	2026-05-04 12:46:48.016044
60	63	2	[]	f	7	0.00	2026-05-04 12:52:47.31481	2026-05-04 12:52:47.31481
61	64	2	[]	f	7	0.00	2026-05-04 12:54:28.977776	2026-05-04 12:54:28.977776
62	65	2	[]	f	7	0.00	2026-05-04 12:58:26.257228	2026-05-04 12:58:26.257228
63	66	0	[]	f	7	0.00	2026-05-04 12:59:27.373861	2026-05-04 12:59:27.373861
64	67	2	[]	f	7	0.00	2026-05-04 13:16:48.812054	2026-05-04 13:16:48.812054
65	68	2	[]	f	7	0.00	2026-05-04 13:17:17.474131	2026-05-04 13:17:17.474131
66	69	2	[]	f	7	0.00	2026-05-04 13:21:13.44993	2026-05-04 13:21:13.44993
67	70	2	[]	f	7	0.00	2026-05-04 13:22:38.963357	2026-05-04 13:22:38.963357
68	71	2	[]	f	7	0.00	2026-05-04 13:25:42.406826	2026-05-04 13:25:42.406826
69	72	2	[]	f	7	0.00	2026-05-04 13:27:13.230778	2026-05-04 13:27:13.230778
70	73	3	["560001"]	f	7	0.00	2026-05-04 13:31:06.162451	2026-05-04 13:37:28.42174
71	74	3	["560001"]	f	7	0.00	2026-05-04 13:39:14.256965	2026-05-04 13:39:14.256965
72	75	3	["560001"]	f	7	0.00	2026-05-04 13:57:22.966983	2026-05-04 13:57:22.966983
73	76	3	["560001"]	f	7	0.00	2026-05-04 13:58:49.949331	2026-05-04 13:58:49.949331
74	77	3	["560001"]	f	7	0.00	2026-05-04 14:00:41.816215	2026-05-04 14:00:41.816215
75	78	3	["560001"]	f	7	0.00	2026-05-04 14:14:44.92126	2026-05-04 14:14:44.92126
76	79	3	["560001"]	f	7	0.00	2026-05-04 14:40:50.216756	2026-05-04 14:40:50.216756
77	80	3	["560001"]	f	7	0.00	2026-05-04 14:54:37.546416	2026-05-04 14:54:37.546416
78	81	3	["560001"]	f	7	0.00	2026-05-04 14:56:46.207475	2026-05-04 14:56:46.207475
79	82	3	["560001"]	f	7	0.00	2026-05-04 15:03:39.734505	2026-05-04 15:03:39.734505
80	83	3	["560001"]	f	7	0.00	2026-05-04 15:12:50.914528	2026-05-04 15:12:50.914528
81	84	3	["560001"]	f	7	0.00	2026-05-04 15:17:41.157159	2026-05-04 15:17:41.157159
82	85	3	["560001"]	f	7	0.00	2026-05-04 15:21:34.976605	2026-05-04 15:21:34.976605
83	86	0	[]	f	7	0.00	2026-05-04 15:22:51.852593	2026-05-04 15:23:36.679615
84	87	3	["560001"]	f	7	0.00	2026-05-04 15:25:05.30222	2026-05-04 15:25:05.30222
85	88	3	["560001"]	f	7	0.00	2026-05-04 15:26:23.33448	2026-05-04 15:26:23.33448
86	89	3	["560001"]	f	7	0.00	2026-05-04 15:31:43.736586	2026-05-04 15:31:43.736586
87	90	3	["560001"]	f	7	0.00	2026-05-04 15:34:01.675134	2026-05-04 15:34:01.675134
88	91	3	["560001"]	f	7	0.00	2026-05-04 15:35:33.353415	2026-05-04 15:35:33.353415
89	92	3	["560001"]	f	7	0.00	2026-05-04 15:37:35.440954	2026-05-04 15:37:35.440954
90	93	3	["560001"]	f	7	0.00	2026-05-06 07:48:36.626719	2026-05-06 07:48:36.626719
91	94	3	["56001"]	f	7	0.00	2026-05-06 07:51:47.549878	2026-05-06 07:51:47.549878
92	95	0	[]	f	7	0.00	2026-05-06 09:40:57.724792	2026-05-06 09:40:57.724792
93	96	0	[]	f	7	0.00	2026-05-06 09:48:20.362355	2026-05-06 09:48:20.362355
94	97	0	[]	f	7	0.00	2026-05-06 09:50:24.699697	2026-05-06 09:50:24.699697
95	98	0	[]	f	7	0.00	2026-05-06 09:54:11.009733	2026-05-06 09:54:11.009733
96	99	0	[]	f	7	0.00	2026-05-09 06:09:05.508702	2026-05-09 06:10:09.921569
97	100	0	[]	f	7	0.00	2026-05-09 10:39:29.125812	2026-05-09 10:39:29.125812
98	101	0	[]	f	7	0.00	2026-05-09 10:49:53.444114	2026-05-09 11:03:39.749451
99	103	0	[]	f	7	0.00	2026-05-10 00:06:46.718892	2026-05-10 00:06:46.718892
100	104	0	[]	f	7	0.00	2026-05-10 00:14:48.140072	2026-05-10 00:14:48.140072
101	105	0	[]	f	7	0.00	2026-05-10 00:31:09.802034	2026-05-10 00:31:09.802034
102	106	0	[]	f	7	0.00	2026-05-10 05:16:07.193786	2026-05-10 05:16:07.193786
43	46	0	[]	f	7	0.00	2026-03-19 09:30:21.404347	2026-05-24 15:19:46.787853
52	55	0	[]	f	7	0.00	2026-04-19 15:21:06.419069	2026-06-06 11:26:06.205789
\.


--
-- Data for Name: device_tokens; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.device_tokens (id, customer_id, delivery_person_id, token, device_type, active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: expenses; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.expenses (id, store_id, created_by_id, title, description, amount, category, expense_date, created_at, updated_at) FROM stdin;
1	13	106	sdfds	sd	23.00	Staff Salaries	2026-05-17	2026-05-17 13:41:25.503147	2026-05-17 13:41:25.503147
\.


--
-- Data for Name: franchises; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.franchises (id, name, email, mobile, contact_person_name, business_type, address, city, state, pincode, pan_no, gst_no, license_no, establishment_date, territory, franchise_fee, commission_percentage, status, notes, password_digest, auto_generated_password, longitude, latitude, whatsapp_number, profile_image, business_documents, created_at, updated_at, user_id) FROM stdin;
11	dsdsfdsd	dfsfdfdsfdsfds9093939393fdfds@gmail.com	09190939001	sdfdd	\N	sdfa	Bangalore	karnataka	\N	\N	\N	\N	\N	\N	\N	10.0	t	\N	\N	f4S%1F6A#g	\N	\N	\N	\N	\N	2026-05-09 12:57:07.618526	2026-05-09 12:57:07.618526	92
12	aadad	9093939sdsd393fdfds@gmail.com	+91 98099 80101		\N	sasa	Bangalore	karnataka	\N	\N	\N	\N	\N	\N	\N	10.0	t	\N	\N	3mLq@fZ3#m	\N	\N	\N	\N	\N	2026-05-10 05:28:17.895079	2026-05-10 05:28:17.895079	93
\.


--
-- Data for Name: invoice_items; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.invoice_items (id, invoice_id, milk_delivery_task_id, description, quantity, unit_price, total_amount, created_at, updated_at, product_id) FROM stdin;
409	318	\N	zxxz - Booking #BK202605091460 (09 May 2026)	1.0	1.0	1.0	2026-05-09 06:22:52.006426	2026-05-09 06:22:52.006426	99
410	319	\N	BARLEY WHOLE [500GM] - Booking #BK20260509592224 (09 May 2026)	1.0	33.6734693877551057142857142857143979591836734694	33.6734693877551057142857142857143979591836734694	2026-05-09 06:24:45.334384	2026-05-09 06:24:45.334384	80
411	320	\N	HONEY WILD [300GM] - Booking #BK202605241048BD (24 May 2026)	1.0	361.90476190476190476190476190476	361.90476190476190476190476190476	2026-05-24 12:36:33.677243	2026-05-24 12:36:33.677243	39
412	321	\N	RAJMUDI RICE [1KG] - Booking #BK20260524911B8B (24 May 2026)	16.0	123.80952380952380952380952380952	1980.95238095238095238095238095232	2026-05-24 15:17:30.405112	2026-05-24 15:17:30.405112	46
413	322	\N	DESI COW GHEE [300ML] - Booking #BK20260602F306F8 (31 May 2026)	1.0	361.90476190476190476190476190476	361.90476190476190476190476190476	2026-06-02 15:46:33.917272	2026-06-02 15:46:33.917272	55
414	323	\N	DESI COW GHEE [300ML] - Booking #BK2026060668EB49 (06 Jun 2026)	8.0	361.90476190476190476190476190476	2895.23809523809523809523809523808	2026-06-06 09:52:43.255061	2026-06-06 09:52:43.255061	55
\.


--
-- Data for Name: invoices; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.invoices (id, invoice_number, payout_type, payout_id, total_amount, status, invoice_date, due_date, paid_at, created_at, updated_at, customer_id, payment_status, share_token, quick_invoice, paid_amount) FROM stdin;
318	INV-05-00001	\N	\N	1.0	sent	2026-05-09	2026-06-08	2026-05-09 06:22:51.294302	2026-05-09 06:22:51.927605	2026-05-09 06:22:51.927605	524	2	E1GjXn2nNoFADNqLXJ7IC5q_6sst4zk8aGA7nm-NJDI	t	0.00
319	INV-05-00002	\N	\N	33.6734693877551057142857142857143979591836734694	sent	2026-05-09	2026-06-08	2026-05-09 06:24:44.857335	2026-05-09 06:24:45.256421	2026-05-09 06:24:45.256421	516	2	vcbIIEZk3in65XnvblFjOoNTTnKlrwHf38WV2C8_Kt0	t	0.00
320	INV-05-00003	\N	\N	361.90476190476190476190476190476	sent	2026-05-24	2026-06-23	2026-05-24 12:36:32.77616	2026-05-24 12:36:33.516691	2026-05-24 12:36:33.516691	494	2	Tzzj2LuLyhKJUMB8SmT4Y3bTQN_y_cgKqklxeVHdpHA	t	0.00
321	INV-05-00004	\N	\N	1980.95238095238095238095238095232	sent	2026-05-24	2026-06-23	2026-05-24 15:17:29.584981	2026-05-24 15:17:30.314896	2026-05-24 15:17:30.314896	\N	2	7UK47uF6n4sxgrZhB-s8Dv1kmk_BAB0VbIfOLRMz61I	t	0.00
322	INV-06-00001	\N	\N	361.90476190476190476190476190476	sent	2026-06-02	2026-07-02	2026-06-02 15:46:33.211853	2026-06-02 15:46:33.838506	2026-06-02 15:46:33.838506	\N	2	UbqoJFxRGM9lL0El2HCLxQumPeGwi254r3zdSU5e7xY	t	0.00
323	INV-06-00002	\N	\N	2895.23809523809523809523809523808	sent	2026-06-06	2026-07-06	2026-06-06 09:52:42.281557	2026-06-06 09:52:43.17688	2026-06-06 09:52:43.17688	\N	2	Vkbg9qXTiCnQ2dpj0weEll9AMU0Z990vMrw98KDLbiw	t	0.00
\.


--
-- Data for Name: leads; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.leads (id, name, contact_number, email, current_stage, lead_source, created_at, updated_at, product_category, product_subcategory, customer_type, affiliate_id, is_direct, first_name, last_name, middle_name, company_name, gender, marital_status, pan_no, gst_no, height, weight, annual_income, business_job) FROM stdin;
\.


--
-- Data for Name: milk_delivery_tasks; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.milk_delivery_tasks (id, subscription_id, customer_id, product_id, quantity, unit, delivery_date, delivery_person_id, status, assigned_at, completed_at, delivery_notes, created_at, updated_at, invoiced, invoiced_at) FROM stdin;
\.


--
-- Data for Name: milk_subscriptions; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.milk_subscriptions (id, customer_id, product_id, quantity, unit, start_date, end_date, delivery_time, delivery_pattern, specific_dates, total_amount, status, is_active, created_by, created_at, updated_at, delivery_person_id) FROM stdin;
\.


--
-- Data for Name: notes; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.notes (id, title, paid_to, amount, payment_method, reference_number, description, status, note_date, created_by_user_id, created_at, updated_at, paid_from, paid_to_category) FROM stdin;
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.notifications (id, customer_id, title, message, notification_type, data, read, read_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.order_items (id, order_id, product_id, quantity, price, total, created_at, updated_at, product_variant_id) FROM stdin;
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.orders (id, customer_id, user_id, order_number, order_date, status, payment_method, payment_status, subtotal, tax_amount, discount_amount, shipping_amount, total_amount, notes, order_items, customer_name, customer_email, customer_phone, delivery_address, tracking_number, delivered_at, created_at, updated_at, processing_notes, estimated_processing_time, processing_started_at, packed_by, package_weight, package_dimensions, packing_notes, packed_at, shipping_carrier, estimated_delivery_date, shipping_cost, shipping_notes, shipped_at, delivered_to, delivery_location, delivery_notes, cancelled_at, cancellation_reason, refund_method, refund_amount, cancellation_notes, invoice_generated, invoice_number, cash_received, change_amount, order_stage, booking_date, booking_id) FROM stdin;
\.


--
-- Data for Name: pending_amounts; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.pending_amounts (id, customer_id, amount, description, pending_date, status, notes, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.permissions (id, name, resource, action, description, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: product_ratings; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.product_ratings (id, product_id, customer_id, user_id, rating, comment, status, reviewer_name, reviewer_email, verified_purchase, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: product_reviews; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.product_reviews (id, product_id, customer_id, user_id, rating, comment, reviewer_name, reviewer_email, status, verified_purchase, helpful_count, pros, cons, title, images_data, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: product_variants; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.product_variants (id, product_id, weight, unit, buying_price, selling_price, discount_enabled, discount_type, discount_value, discount_amount, available_stock, is_default, display_order, created_at, updated_at, gst_percentage, gst_amount, final_price_with_gst) FROM stdin;
1	100	34.000	Kg	40.00	103.00	t	fixed	3.00	3.00	23323	f	0	2026-05-09 10:39:28.206915	2026-05-09 10:39:28.206915	5.00	5.00	105.00
2	100	1.000	Kg	12.00	501.00	t	fixed	1.00	1.00	100	f	0	2026-05-09 10:39:28.513073	2026-05-09 10:39:28.513073	5.00	25.00	525.00
4	101	2.000	Kg	34.00	102.00	t	fixed	2.00	2.00	23333	f	0	2026-05-09 10:49:51.724442	2026-05-09 10:49:51.724442	5.00	5.00	105.00
3	101	23.000	Kg	23.00	1001.00	t	fixed	1.00	1.00	122	f	0	2026-05-09 10:49:50.886427	2026-05-09 11:03:38.685306	5.00	50.00	1050.00
7	103	1.000	Kg	12.00	100.00	t	percentage	1.00	1.00	242	f	0	2026-05-10 00:06:45.947963	2026-05-10 00:06:45.947963	6.00	5.94	104.94
8	103	3.000	Kg	34.00	200.00	t	fixed	2.00	2.00	32	f	0	2026-05-10 00:06:46.357021	2026-05-10 00:06:46.357021	34.00	67.32	265.32
10	105	2.000	Kg	34.00	6.00	f		\N	\N	4	f	0	2026-05-10 00:31:08.522445	2026-05-10 00:31:08.522445	3.00	0.18	6.18
11	106	1.000	Kg	1.00	1.00	f		\N	\N	10	t	0	2026-05-10 05:16:06.308404	2026-05-10 05:16:06.308404	1.00	0.01	1.01
12	106	2.000	Kg	1.00	0.99	f		\N	\N	332	f	0	2026-05-10 05:16:06.875562	2026-05-10 05:16:06.875562	1.00	0.01	1.00
9	105	1.000	Kg	45.00	45.00	t	percentage	1.00	0.45	1	t	0	2026-05-10 00:31:07.167074	2026-05-10 00:31:07.167074	4.00	1.78	46.33
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.products (id, name, description, category_id, price, discount_price, stock, status, sku, weight, dimensions, meta_title, meta_description, tags, created_at, updated_at, discount_type, discount_value, original_price, discount_amount, is_discounted, gst_enabled, gst_percentage, cgst_percentage, sgst_percentage, igst_percentage, gst_amount, cgst_amount, sgst_amount, igst_amount, final_amount_with_gst, buying_price, yesterday_price, today_price, price_change_percentage, last_price_update, price_history, is_occasional_product, occasional_start_date, occasional_end_date, occasional_description, occasional_auto_hide, product_type, occasional_schedule_type, occasional_recurring_from_day, occasional_recurring_from_time, occasional_recurring_to_day, occasional_recurring_to_time, is_subscription_enabled, unit_type, minimum_stock_alert, default_selling_price, hsn_code, image_url, additional_images_urls, display_order, base_price_excluding_gst, r2_image_url, r2_additional_images, has_multiple_quantities, barcode) FROM stdin;
83	HONEY SMALL BHEE [150GM]	✨ Collected from small (stingless) bees 🐝\r\n✨ Thick, dark & highly potent\r\n✨ Strong medicinal value\r\n✨ Raw & unprocessed\r\n\r\n🌱 No additives • No sugar mixing • Pure forest honey\r\n\r\n💪 Key Benefits\r\n\r\n1. Powerful Immunity Booster 💪\r\nRich in antioxidants\r\nHelps fight infections naturally\r\n\r\n2. Good for Cold & Cough 🤧\r\nTraditionally used in home remedies\r\nSoothes throat and improves recovery\r\n\r\n3. Supports Eye & Skin Health ✨\r\nUsed in Ayurveda for eye care\r\nHelps improve skin glow\r\n\r\n4. Aids Digestion 🌿\r\nImproves gut health\r\nNatural detox support\r\n\r\n5. Natural Energy Source ⚡\r\nInstant energy without chemicals\r\n\r\n🍽️ How to Use\r\n1 spoon daily on empty stomach\r\nMix with warm water or milk\r\nWith herbal drinks or home remedies	13	180.00	\N	0	active	NAT160720	1.000					2026-05-04 15:12:50.83273	2026-05-04 15:12:50.83273	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	9.00	\N	\N	\N	180.00	120.00	180.00	180.00	0.00	2026-05-04 15:12:50.83245	[{"date":"2026-05-04","price":"180.0","timestamp":1777907570}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	171.0	\N	\N	f	PRD-000083
42	COCONUT OIL [1LTR]	Marali Santhe Wood Pressed Coconut Oil is crafted using traditional extraction methods combined with precise milling to preserve its natural purity and aroma. Made from carefully sourced coconuts, this oil is free from harmful substances, additives, and contamination.\r\n\r\nWith its rich natural fragrance and smooth texture, it is perfect for cooking, sautéing, and traditional recipes. It also serves as a versatile oil for daily use, bringing authenticity, purity, and nourishment into your lifestyle.	14	650.00	\N	0	active	OIL16DE03	\N					2026-03-19 09:15:33.429197	2026-03-19 14:20:22.988153	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	30.95	\N	\N	\N	650.00	450.00	650.00	650.00	0.00	2026-03-19 09:15:33.42893	[{"date":"2026-03-19","price":"650.0","timestamp":1773911733}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Liter	\N	\N	\N	products/product-temp-8f3c981bdf9adb09		\N	619.05			f	PRD-000042
40	GROUNDNUT OIL [1LTR]	Experience the purity of Marali Santhe Wood Pressed Groundnut Oil, produced through a carefully controlled traditional process that ensures clean and consistent extraction. Free from chemicals, additives, and harmful contaminants, this oil retains its authentic taste and natural goodness.\r\n\r\nSourced directly from farms and processed with precision, it delivers rich flavor, nutritional value, and unmatched quality—making it a trusted choice for daily cooking.	14	345.00	\N	0	active	OIL058162	\N					2026-03-19 09:11:09.303212	2026-03-19 14:18:47.698323	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	345.00	250.00	345.00	345.00	0.00	2026-03-19 09:11:09.302943	[{"date":"2026-03-19","price":"345.0","timestamp":1773911469}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Liter	\N	\N	\N	products/product-temp-83daca59c366f761		\N	\N			f	PRD-000040
43	SESAME OIL [1LTR]	Marali Santhe Wood Pressed Sesame Oil is crafted using traditional extraction methods combined with precise milling to preserve its natural richness and purity. Made from farm-sourced sesame seeds, this oil is free from harmful substances, additives, and contamination.\r\n\r\nKnown for its distinct aroma and deep flavor, it enhances traditional dishes and everyday cooking. Carefully processed to retain its natural qualities, it brings authenticity, taste, and nourishment to your kitchen.	14	490.00	\N	0	active	OIL345526	\N					2026-03-19 09:18:09.767699	2026-03-19 14:13:29.644354	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	23.33	\N	\N	\N	490.00	360.00	490.00	490.00	0.00	2026-03-19 09:18:09.767433	[{"date":"2026-03-19","price":"490.0","timestamp":1773911889}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Liter	\N	\N	\N	products/product-temp-4d39ebc75ee49e62		\N	466.67			f	PRD-000043
60	DOSA RICE [1KG]	“Perfect dosa starts with the right rice 🌾✨\r\nSingle polished dosa rice for that soft idli & crispy golden dosa 😍\r\n\r\nLess processed, more authentic taste!	15	110.00	\N	0	active	GRA927EDD	\N					2026-05-04 12:42:51.031957	2026-05-04 12:42:51.031957	\N	\N	\N	\N	f	t	4.99	\N	\N	\N	5.00	\N	\N	\N	110.00	49.00	110.00	110.00	0.00	2026-05-04 12:42:51.031366	[{"date":"2026-05-04","price":"110.0","timestamp":1777898571}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	105.0	\N	\N	f	PRD-000060
61	IDLI RICE [1KG]	✨ Single polished – retains more natural nutrients\r\n✨ Perfect for soft, fluffy idlis\r\n✨ Ferments well for better rise & texture\r\n✨ Clean, quality grains for everyday use\r\n\r\n🌱 Traditional taste with a healthier touch	15	110.00	\N	5	active	GRA59049E	1.000					2026-05-04 12:44:45.574035	2026-05-04 12:44:45.574035	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	5.00	\N	\N	\N	110.00	65.00	110.00	110.00	0.00	2026-05-04 12:44:45.573807	[{"date":"2026-05-04","price":"110.0","timestamp":1777898685}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	105.0	\N	\N	f	PRD-000061
62	MAPILLAI SAMBA RICE [1KG]	✨ Ancient Tamil Nadu variety 🌾\r\n✨ Naturally rich in iron & minerals\r\n✨ High fiber – keeps you full longer\r\n✨ Known for boosting strength & stamina 💪\r\n\r\n🌱 Unpolished • Traditional • Nutrient-rich	15	180.00	\N	0	active	GRA7096FF	\N					2026-05-04 12:46:47.936456	2026-05-04 12:46:47.936456	percentage	\N	\N	\N	f	t	5.00	\N	\N	\N	9.00	\N	\N	\N	180.00	120.00	180.00	180.00	0.00	2026-05-04 12:46:47.936208	[{"date":"2026-05-04","price":"180.0","timestamp":1777898807}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	171.0	\N	\N	f	PRD-000062
39	HONEY WILD [300GM]	Experience the true taste of nature with our raw honey, sourced directly from trusted farms and forests. This honey is completely unprocessed, ensuring that all its natural nutrients, enzymes, and rich flavor are preserved just as nature intended.\r\n\r\nFree from any form of adulteration, our honey contains no additives, no preservatives, and absolutely no added sugar. What you get is 100% pure honey, untouched and unfiltered, with its natural aroma, texture, and goodness intact.\r\n\r\nCarefully collected and minimally handled, this honey retains its authentic taste and health benefits, making it a perfect natural sweetener for your daily needs.	13	380.00	\N	0	active	NATE21547	\N					2026-03-19 09:01:27.91591	2026-03-19 14:27:19.483523	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	18.10	\N	\N	\N	380.00	195.00	380.00	380.00	0.00	2026-03-19 09:01:27.915658	[{"date":"2026-03-19","price":"380.0","timestamp":1773910887}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N	products/product-temp-afa91f0185a16277		\N	361.9			f	PRD-000039
47	SONA MASURI RICE [1KG]	Marali Santhe Sona Masuri Rice is a popular everyday rice variety known for its light texture, subtle aroma, and versatility. Sourced directly from farms and carefully processed, it retains its natural qualities without exposure to harmful substances or unnecessary refinement.\r\n\r\nPerfect for daily cooking, this rice cooks soft and fluffy, making it ideal for a variety of dishes. With its balanced taste and purity, it brings consistency, quality, and comfort to your everyday meals.	15	130.00	\N	15	active	GRA9F3769	\N					2026-03-19 09:33:46.36704	2026-03-19 14:32:00.757379	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	6.19	\N	\N	\N	130.00	68.00	130.00	130.00	0.00	2026-03-19 09:33:46.366803	[{"date":"2026-03-19","price":"130.0","timestamp":1773912826}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N	products/product-temp-d185cec48ee0c9f7		\N	123.81			f	PRD-000047
37	DESI BUTTER [500GM]	Indulge in the richness of Marali Santhe A2 Fresh Butter, crafted from high-quality milk sourced from indigenous cows. Made in small batches, our butter is fresh, natural, and full of authentic flavor, bringing you the taste of traditional homemade makkhan.\r\n\r\nPrepared with care and without any additives, this butter retains its natural aroma, soft texture, and wholesome goodness — perfect for everyday use and traditional recipes.\r\n\r\nPacked in eco-friendly, biodegradable packaging, we ensure not just purity in what you eat, but responsibility in how it’s delivered.	12	600.00	\N	0	active	DAIEF43F7	\N					2026-03-19 08:49:25.758241	2026-03-19 13:53:14.187043	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	28.57	\N	\N	\N	600.00	480.00	600.00	600.00	0.00	2026-03-19 08:49:25.757978	[{"date":"2026-03-19","price":"600.0","timestamp":1773910165}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N	products/product-temp-d3529647965d4da3		\N	571.43			f	PRD-000037
35	A2 DESI COW GHEE [500ML]	Experience purity the traditional way with Marali Santhe A2 Desi Cow Ghee, crafted using the time-honored Bilona method. This authentic process preserves the natural nutrients, aroma, and richness that modern methods often lose.\r\n\r\nOur ghee is made from fresh, cultured butter sourced from high-quality milk of indigenous cows. The butter is slowly churned and gently simmered in small batches to bring out the golden texture, grainy consistency, and rich aroma that define true desi ghee.\r\n\r\nEvery jar reflects our commitment to tradition, quality, and purity — delivering not just taste, but nourishment rooted in heritage.	12	750.00	\N	0	active	DAI6D3E30	\N					2026-03-19 08:25:49.262541	2026-05-10 07:25:02.820005	percentage	\N	\N	\N	f	f	5.00	\N	\N	\N	\N	\N	\N	\N	750.00	500.00	750.00	750.00	0.00	2026-03-19 08:25:49.262216	[{"date":"2026-03-19","price":"750.0","timestamp":1773908749}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Liter	\N	\N	\N	products/product-temp-66ccfd5c98557d3e		\N	714.0			f	PRD-000035
38	HONEY RAW [300GM]	Experience the true taste of nature with our raw honey, sourced directly from trusted farms and forests. This honey is completely unprocessed, ensuring that all its natural nutrients, enzymes, and rich flavor are preserved just as nature intended.\r\n\r\nFree from any form of adulteration, our honey contains no additives, no preservatives, and absolutely no added sugar. What you get is 100% pure honey, untouched and unfiltered, with its natural aroma, texture, and goodness intact.\r\n\r\nCarefully collected and minimally handled, this honey retains its authentic taste and health benefits, making it a perfect natural sweetener for your daily needs.	13	270.00	\N	0	active	NATB11DA3	\N					2026-03-19 08:58:29.700127	2026-03-19 14:25:37.304229	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	12.86	\N	\N	\N	270.00	180.00	270.00	270.00	0.00	2026-03-19 08:58:29.699889	[{"date":"2026-03-19","price":"270.0","timestamp":1773910709}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N	products/product-temp-b03032958a2f40c3		\N	257.14			f	PRD-000038
41	SUNFLOWER OIL [1LTR]	Marali Santhe Wood Pressed Sunflower Oil is produced through a refined traditional process that ensures clean and consistent extraction. Free from chemicals, additives, and harmful contaminants, this oil maintains its natural lightness and purity.\r\n\r\nSourced directly from farms and processed with precision, it delivers a smooth cooking experience with a clean finish—making it an ideal choice for modern and everyday cooking needs	14	350.00	\N	0	active	OIL642EB9	\N					2026-03-19 09:13:09.545141	2026-03-19 14:09:41.833902	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	16.67	\N	\N	\N	350.00	250.00	350.00	350.00	0.00	2026-03-19 09:13:09.544919	[{"date":"2026-03-19","price":"350.0","timestamp":1773911589}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Liter	\N	\N	\N	products/product-temp-0e5d0690afd68444		\N	333.33			f	PRD-000041
48	SONA MASURI RICE [5KG]	Marali Santhe Sona Masuri Rice is a popular everyday rice variety known for its light texture, subtle aroma, and versatility. Sourced directly from farms and carefully processed, it retains its natural qualities without exposure to harmful substances or unnecessary refinement.\r\n\r\nPerfect for daily cooking, this rice cooks soft and fluffy, making it ideal for a variety of dishes. With its balanced taste and purity, it brings consistency, quality, and comfort to your everyday meals.	15	600.00	570.00	5	active	GRA1E5641	\N					2026-03-19 09:35:13.505614	2026-03-19 14:33:31.155797	percentage	\N	\N	\N	t	t	5.00	\N	\N	\N	27.14	\N	\N	\N	570.00	360.00	600.00	600.00	0.00	2026-03-19 09:35:13.50536	[{"date":"2026-03-19","price":"600.0","timestamp":1773912913}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N	products/product-temp-a72d95ec8a8e061d		\N	542.86			f	PRD-000048
49	Test	we	11	100.00	\N	308	active	23	\N					2026-03-25 03:36:33.683134	2026-03-25 04:48:02.974255	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	5.00	\N	\N	\N	100.00	12.00	100.00	100.00	0.00	2026-03-25 03:36:33.682656	[{"date":"2026-03-25","price":"100.0","timestamp":1774409793}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	95.0	\N	\N	f	PRD-000049
50	Test product	sd	11	1.00	\N	982	active	23sdsdsdss	\N					2026-03-29 05:32:37.587278	2026-05-03 05:18:49.497935	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	1.00	23.00	1.00	1.00	0.00	2026-03-29 05:32:37.587002	[{"date":"2026-03-29","price":"1.0","timestamp":1774762357}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	\N	\N	\N	f	PRD-000050
58	BASUMATHI-RICE [1KG]	“Perfect balance of taste and health 🌾✨\r\nSingle polished basmati rice – not too processed, not too raw.\r\n\r\nLong, aromatic grains that cook fluffy every time 🍽️	15	280.00	\N	3	active	GRAA53C15	1.000					2026-05-04 12:39:06.166803	2026-05-04 12:39:06.166803	\N	\N	\N	\N	f	t	4.99	\N	\N	\N	13.00	\N	\N	\N	280.00	142.00	280.00	280.00	0.00	2026-05-04 12:39:06.165978	[{"date":"2026-05-04","price":"280.0","timestamp":1777898346}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	267.0	\N	\N	f	PRD-000058
46	RAJMUDI RICE [1KG]	Experience the legacy of traditional grains with Marali Santhe Rajamudi Rice—a heritage variety known for its rich character and cultural significance. Farm sourced and carefully handled to preserve its natural integrity, this rice remains free from harmful substances and excessive processing.\r\n\r\nWith its unique color, texture, and depth of flavor, Rajamudi Rice reflects purity, tradition, and mindful eating—bringing back the essence of authentic, wholesome food.	15	130.00	\N	0	active	GRAFA358B	\N					2026-03-19 09:30:21.373073	2026-05-24 15:19:46.699165	\N	\N	\N	\N	f	t	4.99	\N	\N	\N	6.00	\N	\N	\N	130.00	83.00	130.00	130.00	0.00	2026-03-19 09:30:21.37285	[{"date":"2026-03-19","price":"130.0","timestamp":1773912621}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N	products/product-temp-447efd9a2e6afc90		\N	124.0			f	PRD-000046
52	WHEAT-FLOUR-1KG	Pure grains. Honest nourishment 🌾✨\r\n\r\nBring home the goodness of Organic Wheat Flour from Marali Santhe – stone-ground and naturally processed to preserve its nutrition, aroma, and authentic taste. Made from carefully sourced grains, it’s the perfect choice for soft rotis and healthy meals every day.\r\n\r\n🌿 100% Organic & chemical-free\r\n💛 Rich in fiber & nutrients\r\n🔥 Freshly milled for better taste & quality\r\n\r\nWholesome food begins with the right flour.	15	80.00	\N	5	active	GRACBFF4A	1.000					2026-04-16 07:26:39.295637	2026-04-16 07:30:01.407274	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	4.00	\N	\N	\N	80.00	47.00	80.00	80.00	0.00	2026-04-16 07:26:39.295274	[{"date":"2026-04-16","price":"80.0","timestamp":1776324399}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	76.0	\N	\N	f	PRD-000052
84	HONEY RAW [500ML]	✨ 100% raw & unfiltered\r\n✨ No heating, no processing\r\n✨ Retains natural enzymes & nutrients\r\n✨ Thick, aromatic & naturally sweet\r\n\r\n🌱 No sugar mixing • No additives • Pure honey\r\n\r\n💪 Key Benefits\r\n\r\n1. Boosts Immunity 💪\r\nRich in antioxidants\r\nHelps protect against infections\r\n\r\n2. Natural Energy Source ⚡\r\nQuick and clean energy boost\r\nBetter alternative to refined sugar\r\n\r\n3. Good for Cold & Cough 🤧\r\nSoothes throat\r\nCommonly used in home remedies\r\n\r\n4. Supports Digestion 🌿\r\nHelps improve gut health\r\nAids metabolism\r\n\r\n5. Skin & Wellness ✨\r\nUsed for glowing skin\r\nNatural healing properties\r\n\r\n🍽️ How to Use\r\n1 spoon daily (empty stomach)\r\nMix with warm water & lemon\r\nAdd to tea, milk or herbal drinks\r\nUse as natural sweetener	13	450.00	\N	6	active	NAT3244F0	\N					2026-05-04 15:17:41.078826	2026-05-04 15:17:41.078826	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	21.00	\N	\N	\N	450.00	275.00	450.00	450.00	0.00	2026-05-04 15:17:41.078535	[{"date":"2026-05-04","price":"450.0","timestamp":1777907861}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	429.0	\N	\N	f	PRD-000084
53	JAGGERY-POWDER-1KG	Sweetness the natural way 🌿✨\r\n\r\nSwitch to healthier living with Organic Jaggery Powder from Marali Santhe – unrefined, chemical-free, and packed with natural goodness. Made using traditional methods, it retains essential minerals and gives you that rich, authentic taste in every spoon.\r\n\r\n🌾 No chemicals | No refining\r\n💛 Rich in iron & nutrients\r\n🍯 Perfect natural sweetener for daily use\r\n\r\nDitch refined sugar. Choose purity.	15	140.00	\N	8	active	GRA09A69C	1.000					2026-04-16 07:28:59.693081	2026-04-16 07:28:59.693081	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	7.00	\N	\N	\N	140.00	85.00	140.00	140.00	0.00	2026-04-16 07:28:59.692822	[{"date":"2026-04-16","price":"140.0","timestamp":1776324539}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	133.0	\N	\N	f	PRD-000053
51	HANDPOUNDED-RICE-UNPOLISHED-1KG	Back to roots. Back to real food 🌾✨\r\n\r\nExperience the goodness of Handpounded Unpolished Rice at Marali Santhe – traditionally processed to retain its natural fiber, nutrients, and authentic taste. Unlike polished rice, every grain carries the richness of nature just the way it should be.\r\n\r\n🌿 Rich in fiber & nutrients\r\n💛 Naturally wholesome & healthy\r\n🍚 Perfect for everyday traditional meals\r\n\r\nEat clean. Eat real.	15	160.00	\N	0	active	GRABD59D6	1.000					2026-04-16 07:23:03.334696	2026-04-16 07:23:03.334696	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	8.00	\N	\N	\N	160.00	112.00	160.00	160.00	0.00	2026-04-16 07:23:03.334331	[{"date":"2026-04-16","price":"160.0","timestamp":1776324183}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	152.0	\N	\N	f	PRD-000051
56	DESI COW GHEE [1LTR]	Liquid Gold from Our Roots ✨🐄\r\n\r\nCrafted the traditional way using Bilona method, our Desi Cow Ghee is a celebration of purity, nourishment, and heritage.\r\n\r\nMade from A2 milk of indigenous cows, this ghee carries the rich aroma of authenticity and the goodness your body truly deserves.\r\n\r\n✔️ Hand-churned from curd\r\n✔️ Slow-cooked for rich texture & aroma\r\n✔️ No additives. No shortcuts.\r\n✔️ Pure, sattvic, and wholesome\r\n\r\nFrom boosting digestion to enhancing immunity, every spoon is a step towards healthier living 💛	11	1100.00	\N	0	active	DAI0562CB	1.000					2026-04-30 15:40:23.465432	2026-04-30 15:40:23.465432	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	52.00	\N	\N	\N	1100.00	780.00	1100.00	1100.00	0.00	2026-04-30 15:40:23.465184	[{"date":"2026-04-30","price":"1100.0","timestamp":1777563623}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Liter	\N	\N	\N			\N	1048.0	\N	\N	f	PRD-000056
54	DESI COW GHEE [500ML]	Pure Desi Ghee – Made the Traditional Way ✨🥄\r\n\r\nCrafted from the milk of mixed A2 desi cows, our ghee brings you the richness of authentic Indian goodness. Slow-churned using traditional methods to preserve aroma, taste, and nutrition.\r\n\r\nGolden in color, rich in flavor, and packed with natural benefits — this is not just ghee, it’s purity in every spoon 🌿\r\n\r\nPerfect for daily cooking, पूजा, and adding that nostalgic desi touch to your meals.	11	600.00	\N	0	active	DAI7A15C2	1.000					2026-04-19 15:18:46.333291	2026-04-19 15:19:07.002706	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	29.00	\N	\N	\N	600.00	370.00	600.00	600.00	0.00	2026-04-19 15:18:46.332991	[{"date":"2026-04-19","price":"600.0","timestamp":1776611926}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Liter	\N	\N	\N			\N	571.0	\N	\N	f	PRD-000054
57	GROUND NUT OIL [3LTRs]	Purity You Can Taste. Tradition You Can Trust. 🌿✨\r\n\r\nExtracted using the age-old wood-pressed (Lakdi Ghani) method, our Groundnut Oil retains its natural nutrients, aroma, and authentic flavor.\r\n\r\nSlow extraction ensures the oil stays chemical-free, unrefined, and full of life—just the way nature intended.\r\n\r\n✔️ Cold pressed in wooden churner\r\n✔️ No chemicals. No refining.\r\n✔️ Rich in natural antioxidants & healthy fats\r\n✔️ Perfect for everyday cooking\r\n\r\nFrom crispy dosas to soulful curries, elevate your cooking with the richness of tradition 🥜💛\r\n\r\nBecause real food deserves real oil.	14	1035.00	\N	0	active	OILC70C7B	\N					2026-04-30 15:45:11.971201	2026-04-30 15:45:11.971201	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	49.00	\N	\N	\N	1035.00	750.00	1035.00	1035.00	0.00	2026-04-30 15:45:11.970945	[{"date":"2026-04-30","price":"1035.0","timestamp":1777563911}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Liter	\N	\N	\N			\N	986.0	\N	\N	f	PRD-000057
45	SAFFLOWER OIL [1LTR]	Marali Santhe Wood Pressed Safflower Oil is produced through a refined traditional process that ensures clean and consistent extraction. Free from chemicals, additives, and harmful contaminants, this oil maintains its naturally light character and purity.\r\n\r\nSourced directly from farms and processed with precision, it delivers a smooth and clean cooking experience—making it an ideal choice for everyday use	14	530.00	\N	2	active	OILC25966	\N					2026-03-19 09:25:14.348315	2026-03-19 14:16:08.222553	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	25.24	\N	\N	\N	530.00	395.00	530.00	530.00	0.00	2026-03-19 09:25:14.348038	[{"date":"2026-03-19","price":"530.0","timestamp":1773912314}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Liter	\N	\N	\N	products/product-temp-202d1204e5679f80		\N	504.76			f	PRD-000045
63	BARNYARD - OODHLU [1KG]	Barnyard millet is one of the lightest and healthiest millets—perfect for everyday eating 👇\r\n\r\n💪 Key Benefits\r\n\r\n1. Diabetic-Friendly 🩺\r\nLow glycemic index\r\nHelps control blood sugar levels\r\n\r\n2. High in Fiber 🌿\r\nImproves digestion\r\nKeeps you full for longer (good for weight loss)\r\n\r\n3. Rich in Iron & Minerals\r\nSupports energy levels\r\nHelps prevent anemia\r\n\r\n4. Gluten-Free 🌱\r\nIdeal for people with gluten intolerance\r\nLight on the stomach\r\n\r\n5. Supports Heart Health ❤️\r\nHelps reduce cholesterol\r\nGood for overall cardiovascular health\r\n\r\n6. Detox & Gut Health ✨\r\nEasy to digest\r\nHelps cleanse the system\r\n\r\n🍽️ How to Use\r\nUpma / Pongal\r\nMillet rice replacement\r\nKhichdi\r\nDosa / Idli mix	15	175.00	\N	0	active	GRA303082	\N					2026-05-04 12:52:47.188238	2026-05-04 12:52:47.188238	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	8.00	\N	\N	\N	175.00	115.00	175.00	175.00	0.00	2026-05-04 12:52:47.188025	[{"date":"2026-05-04","price":"175.0","timestamp":1777899167}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	167.0	\N	\N	f	PRD-000063
64	BARNYARD - OODHLU [500GM]	Barnyard millet is one of the lightest and healthiest millets—perfect for everyday eating 👇\r\n\r\n💪 Key Benefits\r\n\r\n1. Diabetic-Friendly 🩺\r\nLow glycemic index\r\nHelps control blood sugar levels\r\n\r\n2. High in Fiber 🌿\r\nImproves digestion\r\nKeeps you full for longer (good for weight loss)\r\n\r\n3. Rich in Iron & Minerals\r\nSupports energy levels\r\nHelps prevent anemia\r\n\r\n4. Gluten-Free 🌱\r\nIdeal for people with gluten intolerance\r\nLight on the stomach\r\n\r\n5. Supports Heart Health ❤️\r\nHelps reduce cholesterol\r\nGood for overall cardiovascular health\r\n\r\n6. Detox & Gut Health ✨\r\nEasy to digest\r\nHelps cleanse the system\r\n\r\n🍽️ How to Use\r\nUpma / Pongal\r\nMillet rice replacement\r\nKhichdi\r\nDosa / Idli mix	15	90.00	\N	0	active	GRAB544B8	\N					2026-05-04 12:54:28.899474	2026-05-04 12:54:28.899474	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	4.00	\N	\N	\N	90.00	57.00	90.00	90.00	0.00	2026-05-04 12:54:28.899269	[{"date":"2026-05-04","price":"90.0","timestamp":1777899268}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	86.0	\N	\N	f	PRD-000064
65	BROWNTOP - KORLE [1KG]	Browntop millet is one of the most powerful traditional millets, especially for detox and weight control 👇\r\n\r\n💪 Key Benefits\r\n\r\n1. Excellent for Weight Loss ⚖️\r\nVery high fiber\r\nKeeps you full for longer, reduces cravings\r\n\r\n2. Supports Detox & Liver Health ✨\r\nHelps cleanse the body naturally\r\nGood for gut and liver function\r\n\r\n3. Diabetic-Friendly 🩺\r\nLow glycemic index\r\nHelps regulate blood sugar levels\r\n\r\n4. Rich in Fiber & Minerals 🌿\r\nImproves digestion\r\nSupports overall gut health\r\n\r\n5. Good for Heart Health ❤️\r\nHelps reduce cholesterol\r\nSupports better circulation\r\n\r\n6. Naturally Gluten-Free 🌱\r\nEasy to digest\r\nGreat alternative to rice/wheat\r\n\r\n🍽️ How to Use\r\nMillet rice (instead of white rice)\r\nUpma / Pongal\r\nDosa / Idli batter\r\nKhichdi	15	320.00	\N	0	active	GRA77D4EC	\N					2026-05-04 12:58:26.1765	2026-05-04 12:58:26.1765	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	15.00	\N	\N	\N	320.00	135.00	320.00	320.00	0.00	2026-05-04 12:58:26.176238	[{"date":"2026-05-04","price":"320.0","timestamp":1777899506}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	305.0	\N	\N	f	PRD-000065
44	MUSTARD OIL [1LTR]	Experience the bold character of Marali Santhe Wood Pressed Mustard Oil, produced through a refined traditional process that ensures clean and consistent extraction. Free from chemicals, additives, and harmful contaminants, this oil retains its natural pungency and richness.\r\n\r\nSourced directly from farms and processed with precision, it offers depth of flavor, purity, and reliability—perfect for traditional cooking and everyday use.	14	370.00	\N	3	active	OIL2FB4ED	\N					2026-03-19 09:23:10.632063	2026-03-19 14:11:28.201931	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	17.62	\N	\N	\N	370.00	275.00	370.00	370.00	0.00	2026-03-19 09:23:10.631858	[{"date":"2026-03-19","price":"370.0","timestamp":1773912190}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Liter	\N	\N	\N	products/product-temp-1512885373b596f8		\N	352.38			f	PRD-000044
66	BROWNTOP - KORLE [500GM]	Browntop millet is one of the most powerful traditional millets, especially for detox and weight control 👇\r\n\r\n💪 Key Benefits\r\n\r\n1. Excellent for Weight Loss ⚖️\r\nVery high fiber\r\nKeeps you full for longer, reduces cravings\r\n\r\n2. Supports Detox & Liver Health ✨\r\nHelps cleanse the body naturally\r\nGood for gut and liver function\r\n\r\n3. Diabetic-Friendly 🩺\r\nLow glycemic index\r\nHelps regulate blood sugar levels\r\n\r\n4. Rich in Fiber & Minerals 🌿\r\nImproves digestion\r\nSupports overall gut health\r\n\r\n5. Good for Heart Health ❤️\r\nHelps reduce cholesterol\r\nSupports better circulation\r\n\r\n6. Naturally Gluten-Free 🌱\r\nEasy to digest\r\nGreat alternative to rice/wheat\r\n\r\n🍽️ How to Use\r\nMillet rice (instead of white rice)\r\nUpma / Pongal\r\nDosa / Idli batter\r\nKhichdi	15	180.00	\N	0	active	GRA95B147	\N					2026-05-04 12:59:27.289822	2026-05-04 12:59:27.289822	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	9.00	\N	\N	\N	180.00	42.00	180.00	180.00	0.00	2026-05-04 12:59:27.289573	[{"date":"2026-05-04","price":"180.0","timestamp":1777899567}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	171.0	\N	\N	f	PRD-000066
67	FINGER MILLET - RAGI [1KG]	Ragi is one of the most powerful and widely used millets in South India—perfect for daily nutrition 👇\r\n\r\n💪 Key Benefits\r\n\r\n1. Rich in Calcium 🦴\r\nOne of the best plant-based calcium sources\r\nGreat for bones, kids & elderly\r\n\r\n2. Excellent for Weight Loss ⚖️\r\nHigh fiber keeps you full longer\r\nReduces overeating\r\n\r\n3. Diabetic-Friendly 🩺\r\nLow glycemic index\r\nHelps control blood sugar levels\r\n\r\n4. Boosts Energy & Strength 💪\r\nRich in iron & nutrients\r\nTraditionally given for stamina\r\n\r\n5. Good for Digestion 🌿\r\nImproves gut health\r\nEasy to digest when prepared well\r\n\r\n6. Naturally Gluten-Free 🌱\r\nSafe for gluten intolerance\r\nGreat alternative to wheat\r\n\r\n🍽️ How to Use\r\nRagi mudde (traditional)\r\nRagi dosa / roti\r\nPorridge (for kids & adults)\r\nRagi malt drink	15	90.00	\N	5	active	GRAA7BC1C	1.000					2026-05-04 13:16:48.728165	2026-05-04 13:16:48.728165	\N	\N	\N	\N	f	t	4.99	\N	\N	\N	4.00	\N	\N	\N	90.00	56.00	90.00	90.00	0.00	2026-05-04 13:16:48.727946	[{"date":"2026-05-04","price":"90.0","timestamp":1777900608}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	86.0	\N	\N	f	PRD-000067
68	FINGER MILLET - RAGI [1KG]	Ragi is one of the most powerful and widely used millets in South India—perfect for daily nutrition 👇\r\n\r\n💪 Key Benefits\r\n\r\n1. Rich in Calcium 🦴\r\nOne of the best plant-based calcium sources\r\nGreat for bones, kids & elderly\r\n\r\n2. Excellent for Weight Loss ⚖️\r\nHigh fiber keeps you full longer\r\nReduces overeating\r\n\r\n3. Diabetic-Friendly 🩺\r\nLow glycemic index\r\nHelps control blood sugar levels\r\n\r\n4. Boosts Energy & Strength 💪\r\nRich in iron & nutrients\r\nTraditionally given for stamina\r\n\r\n5. Good for Digestion 🌿\r\nImproves gut health\r\nEasy to digest when prepared well\r\n\r\n6. Naturally Gluten-Free 🌱\r\nSafe for gluten intolerance\r\nGreat alternative to wheat\r\n\r\n🍽️ How to Use\r\nRagi mudde (traditional)\r\nRagi dosa / roti\r\nPorridge (for kids & adults)\r\nRagi malt drink	15	90.00	\N	5	active	GRA5D39E9	1.000					2026-05-04 13:17:17.389205	2026-05-04 13:17:17.389205	\N	\N	\N	\N	f	t	4.99	\N	\N	\N	4.00	\N	\N	\N	90.00	56.00	90.00	90.00	0.00	2026-05-04 13:17:17.388965	[{"date":"2026-05-04","price":"90.0","timestamp":1777900637}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	86.0	\N	\N	f	PRD-000068
69	FOXTAIL MILLET - NAVANE [1KG]	Foxtail millet is one of the best everyday millet alternatives to rice—light, nutritious, and versatile 👇\r\n\r\n💪 Key Benefits\r\n\r\n1. Diabetic-Friendly 🩺\r\nLow glycemic index\r\nHelps control blood sugar levels\r\n\r\n2. Supports Weight Loss ⚖️\r\nHigh fiber keeps you full longer\r\nReduces unnecessary cravings\r\n\r\n3. Good for Heart Health ❤️\r\nHelps reduce bad cholesterol\r\nSupports overall cardiovascular health\r\n\r\n4. Improves Digestion 🌿\r\nRich in dietary fiber\r\nPromotes healthy gut function\r\n\r\n5. Boosts Energy & Immunity 💪\r\nPacked with protein, iron & minerals\r\nKeeps you active throughout the day\r\n\r\n6. Gluten-Free 🌱\r\nSafe for gluten intolerance\r\nHealthy alternative to rice & wheat\r\n\r\n🍽️ How to Use\r\nMillet rice (replace white rice)\r\nUpma / Pongal\r\nDosa / Idli batter\r\nKhichdi	15	160.00	\N	0	active	GRA3BF076	\N					2026-05-04 13:21:13.373077	2026-05-04 13:21:13.373077	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	8.00	\N	\N	\N	160.00	75.00	160.00	160.00	0.00	2026-05-04 13:21:13.372846	[{"date":"2026-05-04","price":"160.0","timestamp":1777900873}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	152.0	\N	\N	f	PRD-000069
71	KODO MILLET [1KG]	Kodo millet (Harka) is a light, detox-friendly traditional grain—great for regular healthy eating 👇\r\n\r\n💪 Key Benefits\r\n\r\n1. Helps in Weight Loss ⚖️\r\nHigh fiber keeps you full longer\r\nReduces cravings & overeating\r\n\r\n2. Diabetic-Friendly 🩺\r\nLow glycemic index\r\nHelps manage blood sugar levels\r\n\r\n3. Detox & Gut Health ✨\r\nCleanses digestive system\r\nSupports better gut function\r\n\r\n4. Good for Heart Health ❤️\r\nHelps lower cholesterol\r\nSupports healthy blood circulation\r\n\r\n5. Rich in Fiber & Nutrients 🌿\r\nImproves digestion\r\nPromotes overall wellness\r\n\r\n6. Naturally Gluten-Free 🌱\r\nSafe for gluten intolerance\r\nLight and easy to digest\r\n\r\n🍽️ How to Use\r\nMillet rice alternative\r\nUpma / Pongal\r\nKhichdi\r\nDosa / Idli batter	15	160.00	\N	0	active	GRAB8FDB0	\N					2026-05-04 13:25:42.326982	2026-05-04 13:25:42.326982	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	8.00	\N	\N	\N	160.00	94.00	160.00	160.00	0.00	2026-05-04 13:25:42.326754	[{"date":"2026-05-04","price":"160.0","timestamp":1777901142}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	152.0	\N	\N	f	PRD-000071
72	KODO MILLET - HARKA [500GM]	Kodo millet (Harka) is a light, detox-friendly traditional grain—great for regular healthy eating 👇\r\n\r\n💪 Key Benefits\r\n\r\n1. Helps in Weight Loss ⚖️\r\nHigh fiber keeps you full longer\r\nReduces cravings & overeating\r\n\r\n2. Diabetic-Friendly 🩺\r\nLow glycemic index\r\nHelps manage blood sugar levels\r\n\r\n3. Detox & Gut Health ✨\r\nCleanses digestive system\r\nSupports better gut function\r\n\r\n4. Good for Heart Health ❤️\r\nHelps lower cholesterol\r\nSupports healthy blood circulation\r\n\r\n5. Rich in Fiber & Nutrients 🌿\r\nImproves digestion\r\nPromotes overall wellness\r\n\r\n6. Naturally Gluten-Free 🌱\r\nSafe for gluten intolerance\r\nLight and easy to digest\r\n\r\n🍽️ How to Use\r\nMillet rice alternative\r\nUpma / Pongal\r\nKhichdi\r\nDosa / Idli batter	15	90.00	\N	5	active	GRAAE0DBD	1.000					2026-05-04 13:27:13.152535	2026-05-04 13:27:13.152535	\N	\N	\N	\N	f	t	4.99	\N	\N	\N	4.00	\N	\N	\N	90.00	47.00	90.00	90.00	0.00	2026-05-04 13:27:13.152315	[{"date":"2026-05-04","price":"90.0","timestamp":1777901233}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	86.0	\N	\N	f	PRD-000072
86	HIMALAYA ROCK CRSTAL SALT [500GM]	✨ Natural rock salt from Himalayan ranges\r\n✨ Unrefined & chemical-free\r\n✨ Rich in trace minerals\r\n✨ Mild, natural salty taste\r\n\r\n🌱 No bleaching • No additives • Pure crystals\r\n\r\n💪 Key Benefits\r\n\r\n1. Rich in Minerals 🌿\r\nContains trace minerals like potassium, magnesium\r\nSupports overall wellness\r\n\r\n2. Better Alternative to Regular Salt 🧂\r\nLess processed than refined table salt\r\nMore natural choice for daily use\r\n\r\n3. Supports Hydration 💧\r\nHelps maintain electrolyte balance\r\n\r\n4. Aids Digestion 🌱\r\nTraditionally used to improve digestion\r\n\r\n🍽️ How to Use\r\nDaily cooking (replace regular salt)\r\nIn salads & seasoning\r\nDetox drinks (with warm water & lemon)\r\nUse in grinders or crush as needed	15	70.00	66.51	10	active	GRA2F30AB	\N					2026-05-04 15:22:51.774517	2026-05-04 15:23:36.600885	percentage	\N	\N	\N	t	t	5.00	\N	\N	\N	3.51	\N	\N	\N	66.51	26.00	70.00	70.00	0.00	2026-05-04 15:22:51.774315	[{"date":"2026-05-04","price":"70.0","timestamp":1777908171}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	63.0	\N	\N	f	PRD-000086
74	LITTLE MILLET - SAAME  [500GM]	Little millet is a light, everyday-friendly grain—perfect for those starting their millet journey 👇\r\n\r\n💪 Key Benefits\r\n\r\n1. Supports Weight Loss ⚖️\r\nHigh fiber keeps you full longer\r\nHelps reduce overeating\r\n\r\n2. Diabetic-Friendly 🩺\r\nLow glycemic index\r\nHelps control blood sugar levels\r\n\r\n3. Improves Digestion 🌿\r\nEasy to digest\r\nGood for gut health\r\n\r\n4. Boosts Heart Health ❤️\r\nHelps reduce cholesterol\r\nSupports overall heart function\r\n\r\n5. Rich in Nutrients & Minerals 💪\r\nProvides energy\r\nSupports overall wellness\r\n\r\n6. Naturally Gluten-Free 🌱\r\nSafe for gluten intolerance\r\nGreat rice alternative\r\n\r\n🍽️ How to Use\r\nDaily rice replacement\r\nUpma / Pongal\r\nKhichdi\r\nDosa / Idli batter	15	90.00	\N	0	active	GRAF25A4A	\N					2026-05-04 13:39:14.180132	2026-05-04 13:39:14.180132	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	4.00	\N	\N	\N	90.00	47.00	90.00	90.00	0.00	2026-05-04 13:39:14.179925	[{"date":"2026-05-04","price":"90.0","timestamp":1777901954}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	86.0	\N	\N	f	PRD-000074
76	PROSO MILLET - BARAGU [1KG]	Proso millet is a light, protein-rich millet—great for daily energy and balanced nutrition 👇\r\n\r\n💪 Key Benefits\r\n\r\n1. High in Protein 💪\r\nSupports muscle strength\r\nKeeps you energized throughout the day\r\n\r\n2. Helps in Weight Loss ⚖️\r\nHigh fiber keeps you full longer\r\nReduces frequent hunger\r\n\r\n3. Diabetic-Friendly 🩺\r\nLow glycemic index\r\nHelps manage blood sugar levels\r\n\r\n4. Supports Heart Health ❤️\r\nHelps reduce cholesterol\r\nGood for overall cardiovascular health\r\n\r\n5. Improves Digestion 🌿\r\nEasy to digest\r\nSupports gut health\r\n\r\n6. Naturally Gluten-Free 🌱\r\nSafe for gluten intolerance\r\nHealthy alternative to rice & wheat\r\n\r\n🍽️ How to Use\r\nRice replacement\r\nUpma / Pongal\r\nKhichdi\r\nDosa / Idli batter	15	190.00	\N	0	active	GRA94358C	\N					2026-05-04 13:58:49.871175	2026-05-04 13:58:49.871175	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	9.00	\N	\N	\N	190.00	120.00	190.00	190.00	0.00	2026-05-04 13:58:49.870979	[{"date":"2026-05-04","price":"190.0","timestamp":1777903129}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	181.0	\N	\N	f	PRD-000076
77	PROSO MILLET - BARAGU [500GM]	Proso millet is a light, protein-rich millet—great for daily energy and balanced nutrition 👇\r\n\r\n💪 Key Benefits\r\n\r\n1. High in Protein 💪\r\nSupports muscle strength\r\nKeeps you energized throughout the day\r\n\r\n2. Helps in Weight Loss ⚖️\r\nHigh fiber keeps you full longer\r\nReduces frequent hunger\r\n\r\n3. Diabetic-Friendly 🩺\r\nLow glycemic index\r\nHelps manage blood sugar levels\r\n\r\n4. Supports Heart Health ❤️\r\nHelps reduce cholesterol\r\nGood for overall cardiovascular health\r\n\r\n5. Improves Digestion 🌿\r\nEasy to digest\r\nSupports gut health\r\n\r\n6. Naturally Gluten-Free 🌱\r\nSafe for gluten intolerance\r\nHealthy alternative to rice & wheat\r\n\r\n🍽️ How to Use\r\nRice replacement\r\nUpma / Pongal\r\nKhichdi\r\nDosa / Idli batter	15	100.00	\N	5	active	GRA85EBC9	\N					2026-05-04 14:00:41.737575	2026-05-04 14:00:41.737575	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	5.00	\N	\N	\N	100.00	60.00	100.00	100.00	0.00	2026-05-04 14:00:41.737325	[{"date":"2026-05-04","price":"100.0","timestamp":1777903241}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	95.0	\N	\N	f	PRD-000077
79	BUFFALO BUTTER [500GM]	✨ Made from fresh buffalo milk\r\n✨ Extra creamy, thick & rich texture\r\n✨ Naturally high in fat for better taste\r\n✨ Perfect for cooking & indulgence\r\n\r\n🌱 No preservatives • Pure & farm-fresh\r\n\r\n💪 Key Benefits\r\n\r\n1. High Energy Food 🔥\r\nRich in fats – gives instant energy\r\nIdeal for active lifestyle\r\n\r\n2. Enhances Taste 🍽️\r\nMakes dishes richer & more flavorful\r\nPerfect for curries, rotis & sweets\r\n\r\n3. Good for Weight Gain ⚖️\r\nHelps in healthy weight gain when needed\r\n\r\n4. Rich in Nutrients 💪\r\nContains essential vitamins (A, D, E, K)\r\n\r\n🍽️ How to Use\r\nOn roti / paratha\r\nIn curries & gravies\r\nFor sweets & desserts\r\nAs a base for ghee	11	600.00	\N	0	active	DAI899BE2	\N					2026-05-04 14:40:50.135813	2026-05-04 14:40:50.135813	\N	\N	\N	\N	f	t	4.99	\N	\N	\N	29.00	\N	\N	\N	600.00	480.00	600.00	600.00	0.00	2026-05-04 14:40:50.13553	[{"date":"2026-05-04","price":"600.0","timestamp":1777905650}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	571.0	\N	\N	f	PRD-000079
55	DESI COW GHEE [300ML]	Pure Desi Ghee – Made the Traditional Way ✨🥄\r\n\r\nCrafted from the milk of mixed A2 desi cows, our ghee brings you the richness of authentic Indian goodness. Slow-churned using traditional methods to preserve aroma, taste, and nutrition.\r\n\r\nGolden in color, rich in flavor, and packed with natural benefits — this is not just ghee, it’s purity in every spoon 🌿\r\n\r\nPerfect for daily cooking, पूजा, and adding that nostalgic desi touch to your meals.	11	380.00	\N	10	active	DAIB1E91E	1.000					2026-04-19 15:21:06.338423	2026-06-06 11:26:06.126283	percentage	\N	\N	\N	f	t	5.00	\N	\N	\N	18.00	\N	\N	\N	380.00	250.00	350.00	380.00	8.57	2026-05-04 15:27:48.062052	[{"date":"2026-04-19","price":"350.0","timestamp":1776612066},{"date":"2026-05-04","price":"380.0","timestamp":1777908468}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Bottle	\N	\N	\N			\N	362.0	\N	\N	f	PRD-000055
81	BYADAGI CHILLI [100GM]	✨ Famous Karnataka variety 🌶️\r\n✨ Deep red colour – enhances dish appearance\r\n✨ Low spice, high flavour & aroma\r\n✨ Perfect for authentic South Indian cooking\r\n\r\n🌱 Naturally sun-dried • No artificial colour\r\n\r\n💪 Why Choose Byadagi Chilli?\r\n\r\n1. Natural Colour Booster 🔴\r\nGives rich red colour to curries & chutneys\r\nNo need for artificial colour\r\n\r\n2. Mild Spice Level 🌶️\r\nLess pungent, more flavour\r\nPerfect for family cooking\r\n\r\n3. Rich Aroma 🍲\r\nEnhances taste of sambar, rasam & gravies\r\n\r\n4. High Quality Traditional Variety 🌾\r\nSourced from Byadagi region (Karnataka)\r\n\r\n🍽️ Best Used For\r\nSambar & rasam\r\nChutney & podi\r\nCurry masalas\r\nHomemade chilli powder	15	180.00	\N	4	active	GRA5990AA	\N					2026-05-04 14:56:46.120922	2026-05-04 14:56:46.120922	\N	\N	\N	\N	f	t	5.01	\N	\N	\N	9.00	\N	\N	\N	180.00	56.00	180.00	180.00	0.00	2026-05-04 14:56:46.120712	[{"date":"2026-05-04","price":"180.0","timestamp":1777906606}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	171.0	\N	\N	f	PRD-000081
82	BYADAGI CHILLI [200GM]	✨ Famous Karnataka variety 🌶️\r\n✨ Deep red colour – enhances dish appearance\r\n✨ Low spice, high flavour & aroma\r\n✨ Perfect for authentic South Indian cooking\r\n\r\n🌱 Naturally sun-dried • No artificial colour\r\n\r\n💪 Why Choose Byadagi Chilli?\r\n\r\n1. Natural Colour Booster 🔴\r\nGives rich red colour to curries & chutneys\r\nNo need for artificial colour\r\n\r\n2. Mild Spice Level 🌶️\r\nLess pungent, more flavour\r\nPerfect for family cooking\r\n\r\n3. Rich Aroma 🍲\r\nEnhances taste of sambar, rasam & gravies\r\n\r\n4. High Quality Traditional Variety 🌾\r\nSourced from Byadagi region (Karnataka)\r\n\r\n🍽️ Best Used For\r\nSambar & rasam\r\nChutney & podi\r\nCurry masalas\r\nHomemade chilli powder	15	408.00	387.64	5	active	GRA76156F	\N					2026-05-04 15:03:39.656816	2026-05-04 15:03:39.656816	percentage	\N	\N	\N	t	t	5.00	\N	\N	\N	18.64	\N	\N	\N	387.64	225.00	408.00	408.00	0.00	2026-05-04 15:03:39.656535	[{"date":"2026-05-04","price":"408.0","timestamp":1777907019}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	369.0	\N	\N	f	PRD-000082
80	BARLEY WHOLE [500GM]	✨ Whole grain – minimally processed\r\n✨ Rich in fiber & essential nutrients\r\n✨ Light, wholesome & versatile\r\n\r\n🌱 No chemicals • No polishing • Pure grain goodness\r\n\r\n💪 Key Benefits\r\n\r\n1. Supports Heart Health ❤️\r\nHelps reduce bad cholesterol (LDL)\r\nGood for overall cardiovascular health\r\n\r\n2. Excellent for Digestion 🌿\r\nHigh in soluble fiber (beta-glucan)\r\nImproves gut health & regularity\r\n\r\n3. Helps in Weight Management ⚖️\r\nKeeps you full for longer\r\nReduces frequent hunger\r\n\r\n4. Diabetic-Friendly 🩺\r\nHelps control blood sugar levels\r\nSlow digestion prevents spikes\r\n\r\n5. Detox & Cooling Effect ✨\r\nBarley water helps cool the body\r\nSupports natural detox\r\n\r\n🍽️ How to Use\r\nBarley water (very popular in summer)\r\nSoups & stews\r\nReplace rice in meals\r\nSalads & porridge	15	90.00	\N	0	active	GRA0BDB08	\N					2026-05-04 14:54:37.469236	2026-05-04 14:54:37.469236	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	4.00	\N	\N	\N	90.00	36.00	90.00	90.00	0.00	2026-05-04 14:54:37.469034	[{"date":"2026-05-04","price":"90.0","timestamp":1777906477}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	86.0	\N	\N	f	PRD-000080
87	HIMALAYA ROCK SALT POWDER [1KG]	✨ Natural rock salt from Himalayan ranges\r\n✨ Unrefined & chemical-free\r\n✨ Rich in trace minerals\r\n✨ Mild, natural salty taste\r\n\r\n🌱 No bleaching • No additives • Pure crystals\r\n\r\n💪 Key Benefits\r\n\r\n1. Rich in Minerals 🌿\r\nContains trace minerals like potassium, magnesium\r\nSupports overall wellness\r\n\r\n2. Better Alternative to Regular Salt 🧂\r\nLess processed than refined table salt\r\nMore natural choice for daily use\r\n\r\n3. Supports Hydration 💧\r\nHelps maintain electrolyte balance\r\n\r\n4. Aids Digestion 🌱\r\nTraditionally used to improve digestion\r\n\r\n🍽️ How to Use\r\nDaily cooking (replace regular salt)\r\nIn salads & seasoning\r\nDetox drinks (with warm water & lemon)\r\nUse in grinders or crush as needed	15	125.00	118.76	9	active	GRAB55334	\N					2026-05-04 15:25:05.223519	2026-05-04 15:25:05.223519	percentage	\N	\N	\N	t	t	5.00	\N	\N	\N	5.76	\N	\N	\N	118.76	45.00	125.00	125.00	0.00	2026-05-04 15:25:05.223251	[{"date":"2026-05-04","price":"125.0","timestamp":1777908305}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	113.0	\N	\N	f	PRD-000087
78	COW BUTTER [500GM]	✨ Made from A2 desi cow milk\r\n✨ Traditionally hand-churned (Bilona method)\r\n✨ Pure, chemical-free & farm-fresh\r\n✨ Rich, creamy texture with natural aroma\r\n\r\n🌱 No preservatives • No additives • 100% natural\r\n\r\n💪 Key Benefits\r\n\r\n1. Rich in Healthy Fats 🧈\r\nSupports energy and nourishment\r\nGood for overall strength\r\n\r\n2. Boosts Immunity 💪\r\nContains fat-soluble vitamins (A, D, E, K)\r\nSupports body’s natural defense\r\n\r\n3. Good for Digestion 🌿\r\nTraditionally known to improve gut health\r\nEasy to digest when consumed in moderation\r\n\r\n4. Supports Skin & Glow ✨\r\nNatural healthy fats help nourish skin\r\n\r\n🍽️ How to Use\r\nWith hot rice or roti\r\nSpread on dosa / chapati\r\nAdd to dal for rich taste\r\nUse as a base for making ghee	15	600.00	\N	0	active	GRAA34D1F	\N					2026-05-04 14:14:44.837073	2026-05-04 14:14:44.837073	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	29.00	\N	\N	\N	600.00	480.00	600.00	600.00	0.00	2026-05-04 14:14:44.836817	[{"date":"2026-05-04","price":"600.0","timestamp":1777904084}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	571.0	\N	\N	f	PRD-000078
88	HIMALAYA ROCK SALT POWDER [500GM]	✨ Natural rock salt from Himalayan ranges\r\n✨ Unrefined & chemical-free\r\n✨ Rich in trace minerals\r\n✨ Mild, natural salty taste\r\n\r\n🌱 No bleaching • No additives • Pure crystals\r\n\r\n💪 Key Benefits\r\n\r\n1. Rich in Minerals 🌿\r\nContains trace minerals like potassium, magnesium\r\nSupports overall wellness\r\n\r\n2. Better Alternative to Regular Salt 🧂\r\nLess processed than refined table salt\r\nMore natural choice for daily use\r\n\r\n3. Supports Hydration 💧\r\nHelps maintain electrolyte balance\r\n\r\n4. Aids Digestion 🌱\r\nTraditionally used to improve digestion\r\n\r\n🍽️ How to Use\r\nDaily cooking (replace regular salt)\r\nIn salads & seasoning\r\nDetox drinks (with warm water & lemon)\r\nUse in grinders or crush as needed	15	70.00	66.51	10	active	GRA16ABD5	\N					2026-05-04 15:26:23.255535	2026-05-04 15:26:23.255535	percentage	\N	\N	\N	t	t	4.99	\N	\N	\N	3.51	\N	\N	\N	66.51	23.00	70.00	70.00	0.00	2026-05-04 15:26:23.255337	[{"date":"2026-05-04","price":"70.0","timestamp":1777908383}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	63.0	\N	\N	f	PRD-000088
90	SUNFLOWER OIL [3LTR]	✨ Wood pressed  extraction\r\n✨ Unfiltered – retains natural nutrients\r\n✨ Light, aromatic & natural golden colour\r\n✨ No chemicals, no refining\r\n\r\n🌱 Pure • Traditional • Nutrient-rich\r\n\r\n💪 Key Benefits\r\n\r\n1. Heart Friendly ❤️\r\nRich in healthy fats\r\nSupports better cholesterol balance\r\n\r\n2. Retains Natural Nutrients 🌿\r\nUnfiltered oil keeps vitamins intact\r\nBetter than refined oils\r\n\r\n3. Light & Easy to Digest 🍽️\r\nPerfect for everyday cooking\r\nDoesn’t feel heavy\r\n\r\n4. Good for Skin & Wellness ✨\r\nContains Vitamin E\r\nSupports skin health\r\n\r\n🍽️ Best Used For\r\nDaily cooking\r\nLight frying & sautéing\r\nSouth Indian dishes\r\nHealthy meal preparation	14	1050.00	1020.00	4	active	OIL3E5F2C	\N					2026-05-04 15:34:01.59837	2026-05-04 15:34:01.59837	fixed	30.00	\N	30.00	t	t	4.99	\N	\N	\N	48.00	\N	\N	\N	1020.00	750.00	1050.00	1050.00	0.00	2026-05-04 15:34:01.598135	[{"date":"2026-05-04","price":"1050.0","timestamp":1777908841}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Liter	\N	\N	\N			\N	972.0	\N	\N	f	PRD-000090
92	GINGELLY - SESAME OIL [500ML]	✨ Wood pressed (chekku) extraction\r\n✨ Rich aroma & deep traditional flavour\r\n✨ Unrefined – retains natural nutrients\r\n✨ Pure, chemical-free\r\n\r\n🌱 No additives • No refining • Authentic oil\r\n\r\n💪 Key Benefits\r\n\r\n1. Heart Healthy ❤️\r\nRich in good fats & antioxidants\r\nSupports cholesterol balance\r\n\r\n2. Great for Skin & Hair ✨\r\nDeep nourishment\r\nTraditionally used for massage & hair care\r\n\r\n3. Improves Digestion 🌿\r\nKnown to support gut health\r\nWidely used in Ayurvedic cooking\r\n\r\n4. Anti-Inflammatory Properties 💪\r\nHelps reduce internal inflammation\r\n\r\n🍽️ Best Used For\r\nSouth Indian cooking (especially traditional dishes)\r\nPickles & chutneys\r\nTempering (tadka)\r\nAyurvedic use & oil pulling	14	240.00	\N	4	active	OIL747F8E	\N					2026-05-04 15:37:35.360455	2026-05-04 15:37:35.360455	\N	\N	\N	\N	f	t	4.99	\N	\N	\N	11.00	\N	\N	\N	240.00	169.00	240.00	240.00	0.00	2026-05-04 15:37:35.360261	[{"date":"2026-05-04","price":"240.0","timestamp":1777909055}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Liter	\N	\N	\N			\N	229.0	\N	\N	f	PRD-000092
89	GROUNDNUT OIL [5LTR]	✨ Wood pressed  extraction\r\n✨ Slow-processed – retains nutrients & aroma\r\n✨ Natural golden colour & rich flavour\r\n✨ No chemicals, no refining\r\n\r\n🌱 Unrefined • Pure • Traditional method\r\n\r\n💪 Key Benefits\r\n\r\n1. Heart Healthy ❤️\r\nRich in good fats (MUFA)\r\nHelps manage cholesterol levels\r\n\r\n2. Retains Nutrients 🌿\r\nCold/wood pressed method preserves vitamins\r\nBetter than refined oils\r\n\r\n3. High Smoke Point 🔥\r\nIdeal for Indian cooking & frying\r\n\r\n4. Improves Taste 🍽️\r\nEnhances flavour of curries, chutneys & snacks\r\n\r\n🍽️ Best Used For\r\nDaily cooking & frying\r\nSouth Indian dishes\r\nChutneys & podis\r\nTraditional recipes	14	1725.00	1675.00	3	active	OILE68872	\N					2026-05-04 15:31:43.658925	2026-05-04 15:31:43.658925	fixed	50.00	\N	50.00	t	t	5.00	\N	\N	\N	80.00	\N	\N	\N	1675.00	1250.00	1725.00	1725.00	0.00	2026-05-04 15:31:43.658679	[{"date":"2026-05-04","price":"1725.0","timestamp":1777908703}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Liter	\N	\N	\N			\N	1595.0	\N	\N	f	PRD-000089
105	dsd	sd	11	45.00	\N	1	active	DAI73AF93	\N	\N				2026-05-10 00:31:06.53723	2026-05-10 00:31:06.53723	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	45.00	45.00	0.00	2026-05-10 00:31:06.536433	[{"date":"2026-05-10","price":"45.0","timestamp":1778373066}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	\N	\N	\N	t	PRD-000105
106	Raw	sewqwq	11	1.00	\N	331	active	sd2113	\N	\N				2026-05-10 05:16:06.149225	2026-05-10 05:16:06.149225	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.00	1.00	0.00	2026-05-10 05:16:06.148895	[{"date":"2026-05-10","price":"1.0","timestamp":1778390166}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	\N	\N	\N	t	PRD-000106
96	MOONGDAL [500GM]		15	135.00	\N	4	active	GRAB5FA4A	\N					2026-05-06 09:48:20.283121	2026-05-06 09:48:20.283121	percentage	\N	\N	\N	f	t	5.00	\N	\N	\N	6.00	\N	\N	\N	135.00	76.50	135.00	135.00	0.00	2026-05-06 09:48:20.282628	[{"date":"2026-05-06","price":"135.0","timestamp":1778060900}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	129.0	\N	\N	f	PRD-000096
99	zxxz	xzxz	11	1.00	\N	313	active	DAICD6757	\N					2026-05-09 06:09:05.205823	2026-05-09 06:10:09.618427	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	1.00	1.00	1.00	1.00	0.00	2026-05-09 06:09:05.205177	[{"date":"2026-05-09","price":"1.0","timestamp":1778306945}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	\N	\N	\N	f	PRD-000099
91	SUNFLOWER OIL [5LTR]	✨ Wood pressed (chekku) extraction\r\n✨ Unfiltered – retains natural nutrients\r\n✨ Light, aromatic & natural golden colour\r\n✨ No chemicals, no refining\r\n\r\n🌱 Pure • Traditional • Nutrient-rich\r\n\r\n💪 Key Benefits\r\n\r\n1. Heart Friendly ❤️\r\nRich in healthy fats\r\nSupports better cholesterol balance\r\n\r\n2. Retains Natural Nutrients 🌿\r\nUnfiltered oil keeps vitamins intact\r\nBetter than refined oils\r\n\r\n3. Light & Easy to Digest 🍽️\r\nPerfect for everyday cooking\r\nDoesn’t feel heavy\r\n\r\n4. Good for Skin & Wellness ✨\r\nContains Vitamin E\r\nSupports skin health\r\n\r\n🍽️ Best Used For\r\nDaily cooking\r\nLight frying & sautéing\r\nSouth Indian dishes\r\nHealthy meal preparation	14	1750.00	1700.00	5	active	OIL1E7F2C	\N					2026-05-04 15:35:33.274343	2026-05-04 15:35:33.274343	fixed	50.00	\N	50.00	t	t	5.00	\N	\N	\N	81.00	\N	\N	\N	1700.00	1250.00	1750.00	1750.00	0.00	2026-05-04 15:35:33.274103	[{"date":"2026-05-04","price":"1750.0","timestamp":1777908933}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Liter	\N	\N	\N			\N	1619.0	\N	\N	f	PRD-000091
101	Testing PRiduct 1	dsds	11	102.00	\N	0	active	ds	\N	\N				2026-05-09 10:49:49.840188	2026-05-09 10:49:49.840188	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	102.00	102.00	0.00	2026-05-09 10:49:49.839726	[{"date":"2026-05-09","price":"102.0","timestamp":1778323789}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	\N	\N	\N	t	PRD-000101
97	MOTHMATKI [500 KG]		15	135.00	\N	5	active	GRA0F2C1D	\N					2026-05-06 09:50:24.619754	2026-05-06 09:50:24.619754	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	6.00	\N	\N	\N	135.00	57.50	135.00	135.00	0.00	2026-05-06 09:50:24.61945	[{"date":"2026-05-06","price":"135.0","timestamp":1778061024}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	129.0	\N	\N	f	PRD-000097
98	KHANDSARISUGAR [1 KG]		15	160.00	\N	2	active	GRA9C7798	\N					2026-05-06 09:54:10.873433	2026-05-06 09:54:10.873433	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	8.00	\N	\N	\N	160.00	120.00	160.00	160.00	0.00	2026-05-06 09:54:10.873207	[{"date":"2026-05-06","price":"160.0","timestamp":1778061250}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	152.0	\N	\N	f	PRD-000098
85	HIMALAYA CRYSTAL ROCK SALT [1KG]	✨ Natural rock salt from Himalayan ranges\r\n✨ Unrefined & chemical-free\r\n✨ Rich in trace minerals\r\n✨ Mild, natural salty taste\r\n\r\n🌱 No bleaching • No additives • Pure crystals\r\n\r\n💪 Key Benefits\r\n\r\n1. Rich in Minerals 🌿\r\nContains trace minerals like potassium, magnesium\r\nSupports overall wellness\r\n\r\n2. Better Alternative to Regular Salt 🧂\r\nLess processed than refined table salt\r\nMore natural choice for daily use\r\n\r\n3. Supports Hydration 💧\r\nHelps maintain electrolyte balance\r\n\r\n4. Aids Digestion 🌱\r\nTraditionally used to improve digestion\r\n\r\n🍽️ How to Use\r\nDaily cooking (replace regular salt)\r\nIn salads & seasoning\r\nDetox drinks (with warm water & lemon)\r\nUse in grinders or crush as needed	15	125.00	118.75	7	active	GRA878BB1	\N					2026-05-04 15:21:34.89825	2026-05-04 15:21:34.89825	percentage	\N	\N	\N	t	t	5.00	\N	\N	\N	5.75	\N	\N	\N	118.75	52.00	125.00	125.00	0.00	2026-05-04 15:21:34.898039	[{"date":"2026-05-04","price":"125.0","timestamp":1777908094}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	113.0	\N	\N	f	PRD-000085
93	MASOOR DAL [500GM]		15	130.00	\N	5	active	GRA7FB0E0	\N					2026-05-06 07:48:36.539034	2026-05-06 07:48:36.539034	percentage	\N	\N	\N	f	t	5.00	\N	\N	\N	6.00	\N	\N	\N	130.00	57.00	130.00	130.00	0.00	2026-05-06 07:48:36.538768	[{"date":"2026-05-06","price":"130.0","timestamp":1778053716}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	124.0	\N	\N	f	PRD-000093
103	dsds32	ds	11	100.00	\N	0	active	sds	\N	\N				2026-05-10 00:06:45.639743	2026-05-10 00:06:45.639743	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	100.00	100.00	0.00	2026-05-10 00:06:45.639229	[{"date":"2026-05-10","price":"100.0","timestamp":1778371605}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	\N	\N	\N	t	PRD-000103
73	LITTLE MILLET - SAAME [1KG]	Little millet is a light, everyday-friendly grain—perfect for those starting their millet journey 👇\r\n\r\n💪 Key Benefits\r\n\r\n1. Supports Weight Loss ⚖️\r\nHigh fiber keeps you full longer\r\nHelps reduce overeating\r\n\r\n2. Diabetic-Friendly 🩺\r\nLow glycemic index\r\nHelps control blood sugar levels\r\n\r\n3. Improves Digestion 🌿\r\nEasy to digest\r\nGood for gut health\r\n\r\n4. Boosts Heart Health ❤️\r\nHelps reduce cholesterol\r\nSupports overall heart function\r\n\r\n5. Rich in Nutrients & Minerals 💪\r\nProvides energy\r\nSupports overall wellness\r\n\r\n6. Naturally Gluten-Free 🌱\r\nSafe for gluten intolerance\r\nGreat rice alternative\r\n\r\n🍽️ How to Use\r\nDaily rice replacement\r\nUpma / Pongal\r\nKhichdi\r\nDosa / Idli batter	15	160.00	\N	4	active	GRA092B76	\N					2026-05-04 13:31:06.082673	2026-05-04 13:37:28.342679	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	8.00	\N	\N	\N	160.00	95.00	160.00	160.00	0.00	2026-05-04 13:31:06.082395	[{"date":"2026-05-04","price":"160.0","timestamp":1777901466}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	152.0	\N	\N	f	PRD-000073
94	MEDIUMRAVA [500GM]		15	65.00	\N	3	active	GRAD237C7	\N					2026-05-06 07:51:47.469284	2026-05-06 07:51:47.469284	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	3.00	\N	\N	\N	65.00	32.50	65.00	65.00	0.00	2026-05-06 07:51:47.468756	[{"date":"2026-05-06","price":"65.0","timestamp":1778053907}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	62.0	\N	\N	f	PRD-000094
95	MOONGDAL [1 KG]		15	270.00	\N	3	active	GRAA64988	\N					2026-05-06 09:40:57.639708	2026-05-06 09:40:57.639708	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	13.00	\N	\N	\N	270.00	200.00	270.00	270.00	0.00	2026-05-06 09:40:57.638513	[{"date":"2026-05-06","price":"270.0","timestamp":1778060457}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	257.0	\N	\N	f	PRD-000095
100	sddsds		11	501.00	\N	0	active	sddss	\N	\N				2026-05-09 10:39:27.610426	2026-05-09 10:39:27.610426	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	501.00	501.00	0.00	2026-05-09 10:39:27.609819	[{"date":"2026-05-09","price":"501.0","timestamp":1778323167}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	\N	\N	\N	t	PRD-000100
104	sd	ds	11	45.00	\N	2	active	dsdwdrewrwe	45.000					2026-05-10 00:14:47.766146	2026-05-10 00:14:47.766146	percentage	\N	\N	\N	f	t	4.00	\N	\N	\N	2.00	\N	\N	\N	45.00	23.00	45.00	45.00	0.00	2026-05-10 00:14:47.764309	[{"date":"2026-05-10","price":"45.0","timestamp":1778372087}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Bottle	\N	\N	\N			\N	43.0	\N	\N	f	PRD-000104
36	A2 DESI COW GHEE [225ML]	Experience purity the traditional way with Marali Santhe A2 Desi Cow Ghee, crafted using the time-honored Bilona method. This authentic process preserves the natural nutrients, aroma, and richness that modern methods often lose.\r\n\r\nOur ghee is made from fresh, cultured butter sourced from high-quality milk of indigenous cows. The butter is slowly churned and gently simmered in small batches to bring out the golden texture, grainy consistency, and rich aroma that define true desi ghee.\r\n\r\nEvery jar reflects our commitment to tradition, quality, and purity — delivering not just taste, but nourishment rooted in heritage.	12	350.00	\N	0	active	DAIE90911	\N					2026-03-19 08:34:02.625067	2026-05-02 12:46:54.662762	\N	\N	\N	\N	f	f	5.00	\N	\N	\N	\N	\N	\N	\N	350.00	250.00	350.00	350.00	0.00	2026-03-19 08:34:02.624833	[{"date":"2026-03-19","price":"350.0","timestamp":1773909242}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Liter	\N	\N	\N	products/product-temp-4a27681675e12237		\N	333.0			f	PRD-000036
59	BLACK RICE  [1KG]	Black rice isn’t just different in color—it’s one of the most nutrient-dense grains you can offer 👇\r\n\r\n💪 Key Benefits\r\n\r\n1. Rich in Antioxidants (Anthocyanins)\r\nGives the dark purple/black color\r\nHelps fight inflammation & supports overall health\r\n\r\n2. Supports Heart Health ❤️\r\nMay help reduce bad cholesterol (LDL)\r\nImproves blood circulation\r\n\r\n3. High in Fiber 🌿\r\nAids digestion\r\nKeeps you full longer (great for weight management)\r\n\r\n4. Good for Diabetics 🩺\r\nLower glycemic impact compared to white rice\r\nHelps in better blood sugar control\r\n\r\n5. Natural Detox Support ✨\r\nSupports liver function\r\nHelps remove toxins from the body\r\n\r\n6. Rich in Iron & Nutrients\r\nHelps boost energy levels\r\nGood for people with low hemoglobin\r\n\r\n🍽️ How to Use\r\nRice meals (like regular rice)\r\nSalads & bowls\r\nKheer / desserts\r\nMix with normal rice for beginners	15	290.00	\N	0	active	GRA5ECBF6	1.000					2026-05-04 12:41:01.529394	2026-05-04 12:41:01.529394	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	14.00	\N	\N	\N	290.00	150.00	290.00	290.00	0.00	2026-05-04 12:41:01.529199	[{"date":"2026-05-04","price":"290.0","timestamp":1777898461}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	276.0	\N	\N	f	PRD-000059
70	FOXTAIL MILLET - NAVANE [500GM]	Foxtail millet is one of the best everyday millet alternatives to rice—light, nutritious, and versatile 👇\r\n\r\n💪 Key Benefits\r\n\r\n1. Diabetic-Friendly 🩺\r\nLow glycemic index\r\nHelps control blood sugar levels\r\n\r\n2. Supports Weight Loss ⚖️\r\nHigh fiber keeps you full longer\r\nReduces unnecessary cravings\r\n\r\n3. Good for Heart Health ❤️\r\nHelps reduce bad cholesterol\r\nSupports overall cardiovascular health\r\n\r\n4. Improves Digestion 🌿\r\nRich in dietary fiber\r\nPromotes healthy gut function\r\n\r\n5. Boosts Energy & Immunity 💪\r\nPacked with protein, iron & minerals\r\nKeeps you active throughout the day\r\n\r\n6. Gluten-Free 🌱\r\nSafe for gluten intolerance\r\nHealthy alternative to rice & wheat\r\n\r\n🍽️ How to Use\r\nMillet rice (replace white rice)\r\nUpma / Pongal\r\nDosa / Idli batter\r\nKhichdi	15	90.00	\N	4	active	GRA115444	1.000					2026-05-04 13:22:38.878487	2026-05-04 13:22:38.878487	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	4.00	\N	\N	\N	90.00	37.00	90.00	90.00	0.00	2026-05-04 13:22:38.878225	[{"date":"2026-05-04","price":"90.0","timestamp":1777900958}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	86.0	\N	\N	f	PRD-000070
75	PEARL MILLET SAJJE [1KG]	✨ Traditional powerhouse grain\r\n✨ Rich in iron, fiber & essential minerals\r\n✨ Keeps body warm & energetic\r\n✨ Ideal for daily strength and stamina 💪\r\n\r\n🌱 Naturally gluten-free • Unprocessed • Nutrient-rich\r\n\r\n💪 Key Benefits\r\n\r\n1. Boosts Energy & Strength 💪\r\nHigh in iron and nutrients\r\nGreat for daily stamina\r\n\r\n2. Good for Digestion 🌿\r\nRich in fiber\r\nSupports gut health\r\n\r\n3. Diabetic-Friendly 🩺\r\nHelps manage blood sugar levels\r\nSlow digestion keeps energy stable\r\n\r\n4. Supports Heart Health ❤️\r\nHelps reduce cholesterol\r\nGood for overall cardiovascular health\r\n\r\n5. Keeps Body Warm 🔥\r\nIdeal for all seasons, especially beneficial in cooler weather\r\n\r\n🍽️ How to Use\r\nSajje rotti / Bajra roti\r\nPorridge / malt\r\nUpma / khichdi\r\nMix with other flours	15	70.00	\N	0	active	GRAFF9457	\N					2026-05-04 13:57:22.891334	2026-05-04 13:57:22.891334	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	3.00	\N	\N	\N	70.00	22.00	70.00	70.00	0.00	2026-05-04 13:57:22.891104	[{"date":"2026-05-04","price":"70.0","timestamp":1777903042}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	67.0	\N	\N	f	PRD-000075
\.


--
-- Data for Name: referrals; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.referrals (id, affiliate_id, referred_name, referred_mobile, referred_email, referral_date, status, notes, converted_at, customer_id, created_at, updated_at, referring_customer_id, referral_source) FROM stdin;
8	12	Ramu	0919093939	9093939393fdfds@gmail.com	2026-05-09	converted	ds | Marked as registered on 2026-05-09 | Converted on 2026-05-09	2026-05-09 11:59:42.982911	\N	2026-05-09 11:56:48.709226	2026-05-09 11:59:43.589579	\N	affiliate
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.roles (id, name, description, status, permissions, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sale_items; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.sale_items (id, booking_id, product_id, stock_batch_id, quantity, selling_price, purchase_price, profit_amount, line_total, created_at, updated_at) FROM stdin;
1	91	41	48	1.0	350.0	250.0	100.0	350.0	2026-03-25 07:13:39.161428	2026-03-25 07:13:39.161428
2	91	49	58	3.0	100.0	12.0	264.0	300.0	2026-03-25 07:13:40.715216	2026-03-25 07:13:40.715216
3	91	47	54	1.0	130.0	68.0	62.0	130.0	2026-03-25 07:13:42.315825	2026-03-25 07:13:42.315825
4	92	35	43	1.0	750.0	500.0	250.0	750.0	2026-03-25 07:50:44.249167	2026-03-25 07:50:44.249167
5	93	35	43	1.0	750.0	500.0	250.0	750.0	2026-03-25 07:50:57.689838	2026-03-25 07:50:57.689838
6	94	35	43	2.0	750.0	500.0	500.0	1500.0	2026-03-26 03:34:19.837869	2026-03-26 03:34:19.837869
7	81	35	43	2.0	750.0	500.0	500.0	1500.0	2026-03-26 03:38:34.479238	2026-03-26 03:38:34.479238
8	95	49	58	1.0	100.0	12.0	88.0	100.0	2026-03-26 04:41:58.819926	2026-03-26 04:41:58.819926
9	96	49	58	1.0	100.0	12.0	88.0	100.0	2026-03-26 04:42:02.984925	2026-03-26 04:42:02.984925
10	97	49	58	1.0	100.0	12.0	88.0	100.0	2026-03-26 04:42:05.008453	2026-03-26 04:42:05.008453
11	98	49	58	1.0	100.0	12.0	88.0	100.0	2026-03-26 04:42:06.912385	2026-03-26 04:42:06.912385
12	99	49	58	1.0	100.0	12.0	88.0	100.0	2026-03-26 04:42:40.137386	2026-03-26 04:42:40.137386
13	99	43	50	1.0	490.0	360.0	130.0	490.0	2026-03-26 04:42:40.333161	2026-03-26 04:42:40.333161
14	101	49	58	1.0	100.0	12.0	88.0	100.0	2026-03-26 05:01:39.458557	2026-03-26 05:01:39.458557
15	101	43	50	1.0	490.0	360.0	130.0	490.0	2026-03-26 05:01:40.964505	2026-03-26 05:01:40.964505
16	102	35	60	1.0	750.0	600.0	150.0	750.0	2026-03-26 06:51:40.512567	2026-03-26 06:51:40.512567
17	105	49	58	1.0	100.0	12.0	88.0	100.0	2026-03-26 07:25:39.569628	2026-03-26 07:25:39.569628
18	106	49	58	1.0	100.0	12.0	88.0	100.0	2026-03-26 08:33:19.196775	2026-03-26 08:33:19.196775
19	107	49	58	2.0	100.0	12.0	176.0	200.0	2026-03-26 08:43:28.450674	2026-03-26 08:43:28.450674
20	108	49	58	1.0	100.0	12.0	88.0	100.0	2026-03-26 08:47:58.218007	2026-03-26 08:47:58.218007
21	109	49	58	1.0	100.0	12.0	88.0	100.0	2026-03-26 10:20:03.758192	2026-03-26 10:20:03.758192
22	110	35	60	2.0	750.0	600.0	300.0	1500.0	2026-03-28 12:36:08.157741	2026-03-28 12:36:08.157741
23	111	35	60	2.0	750.0	600.0	300.0	1500.0	2026-03-28 12:36:25.852371	2026-03-28 12:36:25.852371
24	112	35	60	2.0	750.0	600.0	300.0	1500.0	2026-03-28 12:36:45.730328	2026-03-28 12:36:45.730328
25	125	50	62	1.0	1.0	23.0	-22.0	1.0	2026-03-29 06:54:04.005942	2026-03-29 06:54:04.005942
26	125	50	62	1.0	1.0	23.0	-22.0	1.0	2026-03-29 06:54:04.853281	2026-03-29 06:54:04.853281
27	126	50	62	1.0	1.0	23.0	-22.0	1.0	2026-03-29 07:04:51.65695	2026-03-29 07:04:51.65695
28	128	50	62	1.0	1.0	23.0	-22.0	1.0	2026-03-29 07:13:47.706769	2026-03-29 07:13:47.706769
29	129	50	62	1.0	1.0	23.0	-22.0	1.0	2026-03-29 10:04:24.1765	2026-03-29 10:04:24.1765
30	189	40	47	1.0	345.0	250.0	95.0	345.0	2026-05-06 15:48:51.041974	2026-05-06 15:48:51.041974
31	189	85	86	1.0	125.0	52.0	73.0	125.0	2026-05-06 15:48:51.522185	2026-05-06 15:48:51.522185
32	198	99	100	1.0	1.0	1.0	0.0	1.0	2026-05-09 06:20:12.913351	2026-05-09 06:20:12.913351
33	198	99	100	1.0	1.0	1.0	0.0	1.0	2026-05-09 06:20:14.253581	2026-05-09 06:20:14.253581
34	218	99	100	1.0	1.0	1.0	0.0	1.0	2026-05-24 12:43:29.342359	2026-05-24 12:43:29.342359
35	218	99	100	1.0	1.0	1.0	0.0	1.0	2026-05-24 12:43:30.512248	2026-05-24 12:43:30.512248
36	220	106	104	1.0	1.0	1.0	0.0	1.0	2026-05-25 05:02:30.948932	2026-05-25 05:02:30.948932
37	220	106	104	1.0	1.0	1.0	0.0	1.0	2026-05-25 05:02:33.15326	2026-05-25 05:02:33.15326
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.schema_migrations (version) FROM stdin;
0
20260107092810
20260107101240
20260107111549
20260107131159
20260107131309
20260107131913
20260107150605
20260107150728
20260107150805
20260107150814
20260107151651
20260107171920
20260108042049
20260108042658
20260108043706
20260108045016
20260108045914
20260108060039
20260108072509
20260108104259
20260108110047
20260108171419
20260109024857
20260111014913
20260111020543
20260111020547
20260111031353
20260111032424
20260111060641
20260111070348
20260111071020
20260111071120
20260111071219
20260111071659
20260111092557
20260111101523
20260111101527
20260111105247
20260208061341
20260208062719
20260208101409
20260208101558
20260208101609
20260208101620
20260208101643
20260208101648
20260208102424
20260208102434
20260208103030
20260208103125
20260208153931
20260209090000
20260209090001
20260211095237
20260212010028
20260212023145
20260212114420
1
20260212133027
20260213005145
20260214025047
20260216073135
20260217163319
20260218014142
20260218014153
20260218014204
20260218073032
20260218073033
20260218073034
20260218073035
20260218073036
20260218073037
20260218104948
20260218105107
20260218105116
20260218111202
20260218111627
20260218113731
20260219063828
20260219065729
20260219114349
20260219163202
20260219163237
20260219163249
20260219163301
20260220121130
20260220170323
20260221051144
20260221051526
20260221071051
20260222101845
20260222113448
20260223003701
20260223004840
20260223012155
20260223013159
20260223093122
20260223112829
20260223140936
20260223140939
20260225162412
20260226005401
20260227012037
20260227042837
20260302070828
20260303124807
20260303140745
20260304040431
20260304150744
20260305011138
20260305013049
20260305013057
20260306005034
20260306133011
20260307032837
20260308030449
20260308054700
20260318032032
20260318041321
20260319105840
20260324011944
20260417110754
20260505000000
20260509054344
20260509120000
20260509130000
20260510120000
20260510120001
20260511100001
20260511100002
20260517101341
20260517101731
20260518100001
20260518200001
20260518200002
20260518210000
20260518210001
20260604004804
\.


--
-- Data for Name: solid_cache_entries; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.solid_cache_entries (id, key, value, created_at, key_hash, byte_size) FROM stdin;
121	\\x70726f64756374696f6e3a6d6f62696c655f6170692f762f62616e6e6572732f616c6c	\\x001104000000000000f0bfffffffff6163306330306137	2026-06-03 03:37:08.509635	-8836894317673552056	198
123	\\x70726f64756374696f6e3a6d6f62696c655f6170692f63617465676f726965732f3534383739316333	\\x0011819d56f0efe887da41ffffffff789ce555cb721b45144d5294e34785323654b6b7bc6025eb6529b2a462118a38c885e35072ca0416ae56cf1d4dc34cf7a4bbc78ac8c61fc11236142b3ecb05ffc1e919c98f60d8b162a5d1e8deee73cf3de7e883d5efd6df6d0c1eaa487d3458d322e3d1cee32f84b273fa940e84cde8c0b24b56062bcf4e069b113b6955ee95d1a39dfb7f3ef57424ac48158d85f609d768c634b14a4f696e0aca0b8b57310ed98dc3211495e7e6d64485f48e9c29ace488226559fa744eb13519795b388fb7a991222dbbd9ba3a1d1776d16f859e322947d69850a8347a44a4022a7464ec1313b91ab1764589450b5f00257981836b94a86942baf0b6eca891d011fdc8d6903419b065ca31194d6f0a0ce6e7f595e1c393c1872a13533e2b6c8ab97f4bbccfdda0d1c8cae15d397b1ddd0d2b54ea1a427a75ce67ce1b8ba6c6243513d7b05c8dd9e0f9612cb3837cf2e5913ad64e7dfbfca0f97a3c7a7274f2ca8df4e72da9464f46d9a19bb40f6371fab58abf697eb6bbdbebb73ba215b5e36eabdbe9c5729f9bed6e578a7dee772742f67b1d8ef7e249a76195e47aaea725eced25d767d214daabd5c156a45c9e8af999b1115b75efddc6f09eda1cae8c76b6abadbf5c7484fee1eaff6acbc3b5e6705d6d0d3716b47c1c68f9e43996aa1ddc70a4d294af8979d07ef07766302bbddf801bf129038c8a3647de4c819f2d4961392e52b0b2a4c97991a7fc4f63c7c644248b14a3721dd60493981b6aa3b0773a1756b1571c6ea88667ed77f15342d9024caa7e40b198aa1a7d6f66c256ccc4e6ad877641e7395f2f2fd0ef3860079299f2090954cac2dd60ae6c1705a681be64a0f2d1faa3f5f19d4b0f6b761549d38aa4d0bc44062a50c65cd526a80533e48a0928d192abe2426bc6b31315caf008466fc82048127772e0a4640b0c2a9c9e19e7af34121b9bd5e934a996806f41744099b148319cbdc5394e533903378ae764e2182d826689c19a4cc625ac89480346b024e625f79851c10bf3306b2c3062c5cbb5cc76af64b61564f6f8c502da78c6ec59c30d4ba10d2f2f7e7ea517c3e28acb8b5fab645e921c5ebc30f4348af0655c4c85bdbcf885aaab60e0dfffa3b87afd2f7125facd76abd76f757bdd562491575274782fe6de7edcee44b2dddb6bb6b8dd948d738613c404542e430bdcac5d71b31db8593f1e7d35a62bdffd71ffce448ae13233c366e028a5c32ac2f6735b296429162c5178c27d3a72b7b63c532e82ec4a95e761e5c8077e8b8acab89e65a2d59b82172165c05ca9d8ca2a0b7f98c2430ef33bc47b43a1a58c2c673000c99405c2c989986b0b7d8b08f6662be0b95232cf4a4746d6e461b260461732174ebbbcf8e9da2f32e14c214b71d38d97467b882f44c43203cb30c0cd4b2b4cc1920631b04318bdccf16516016dd0019c5d996f9156b78c776b11741a387f692ba11e078e224ea12e7b2b226aef0773f96f105055f15338be11c89b410d7f01ebed0620	2026-06-03 03:37:11.797508	5455011470339357977	1265
158	\\x70726f64756374696f6e3a6d6f62696c655f6170692f63617465676f726965732f3732303636326465	\\x001181a80e04921388da41ffffffff789ce555cb721b45144d5294e34785323654b6b7bc6025eb6529b2a462118a38c885e35072ca0416ae56cf1d4dc34cf7a4bbc78ac8c61fc11236142b3ecb05ffc1e919c98f60d8b162a5d1e8deee73cf3de7e883d5efd6df6d0c1eaa487d3458d322e3d1cee32f84b273fa940e84cde8c0b24b56062bcf4e069b113b6955ee95d1a39dfb7f3ef57424ac48158d85f609d768c634b14a4f696e0aca0b8b57310ed98dc3211495e7e6d64485f48e9c29ace488226559fa744eb13519795b388fb7a991222dbbd9ba3a1d1776d16f859e322947d69850a8347a44a4022a7464ec1313b91ab1764589450b5f00257981836b94a86942baf0b6eca891d011fdc8d6903419b065ca31194d6f0a0ce6e7f595e1c393c1872a13533e2b6c8ab97f4bbccfdda0d1c8cae15d397b1ddd0d2b54ea1a427a75ce67ce1b8ba6c6243513d7b05c8dd9e0f9612cb3837cf2e5913ad64e7dfbfca0f97a3c7a7274f2ca8df4e72da9464f46d9a19bb40f6371fab58abf697eb6bbdbebb73ba215b5e36eabdbe9c5729f9bed6e578a7dee772742f67b1d8ef7e249a76195e47aaea725eced25d767d214daabd5c156a45c9e8af999b1115b75efddc6f09eda1cae8c76b6abadbf5c7484fee1eaff6acbc3b5e6705d6d0d3716b47c1c68f9e43996aa1ddc70a4d294af8979d07ef07766302bbddf801bf129038c8a3647de4c819f2d4961392e52b0b2a4c97991a7fc4f63c7c644248b14a3721dd60493981b6aa3b0773a1756b1571c6ea88667ed77f15342d9024caa7e40b198aa1a7d6f66c256ccc4e6ad877641e7395f2f2fd0ef3860079299f2090954cac2dd60ae6c1705a681be64a0f2d1faa3f5f19d4b0f6b761549d38aa4d0bc44062a50c65cd526a80533e48a0928d192abe2426bc6b31315caf008466fc82048127772e0a4640b0c2a9c9e19e7af34121b9bd5e934a996806f41744099b148319cbdc5394e533903378ae764e2182d826689c19a4cc625ac89480346b024e625f79851c10bf3306b2c3062c5cbb5cc76af64b61564f6f8c502da78c6ec59c30d4ba10d2f2f7e7ea517c3e28acb8b5fab645e921c5ebc30f4348af0655c4c85bdbcf885aaab60e0dfffa3b87afd2f7125facd76abd76f757bdd562491575274782fe6de7edcee44b2dddb6bb6b8dd948d738613c404542e430bdcac5d71b31db8593f1e7d35a62bdffd71ffce448ae13233c366e028a5c32ac2f6735b296429162c5178c27d3a72b7b63c532e82ec4a95e761e5c8077e8b8acab89e65a2d59b82172165c05ca9d8ca2a0b7f98c2430ef33bc47b43a1a58c2c673000c99405c2c989986b0b7d8b08f6662be0b95232cf4a4746d6e461b260461732174ebbbcf8e9da2f32e14c214b71d38d97467b882f44c43203cb30c0cd4b2b4cc1920631b04318bdccf16516016dd0019c5d996f9156b78c776b11741a387f692ba11e078e224ea12e7b2b226aef0773f96f105055f15338be11c89b410d7f01ebed0620	2026-06-03 15:44:48.101752	4762777136454031212	1265
159	\\x70726f64756374696f6e3a6d6f62696c655f6170692f66656174757265642f38386330646566322f6c696d69745f35	\\x00118153b829931388da41ffffffff789cbd964b6f1b5514c7edaaf278ec38b69b367d108871692805bb77fc88937b1775503bc8246aabd608892cac1bcf1de7a6931977ee4c4c4825366cd820c1274062c116b16289ba61cd928fc0962d4870ee1dbf9226e629167edc3367cee37f7e67ecf3c9edd451096bdce21ed65dbacf5ac5e4233a48e0c4bd36ce594c747dde0fb8e7b68a69c1064f074f13446be354dfe75d66270cbc6071d1f54237e82813c21704731ceef6a27353c7399bbbd4191faf4c6e607e97b901ed311ec317c6e6e0b00f6126710fa8134a83e7f3de241218043d803ca243f7a59f9d40382502affb849fbb1fc749f12494355b15c3a8aa9af5d0e541aba86df6d4313d60bcb71b209cb5f83e7305f42810cef77dcf0abb5115ade2dc3bbed765fea1ba636e87fa5dcf0273f6e1a3bb2584908156d595ccae703bf212c23af4235ac598b2cba6fa0e3dec78bec57c8497b8e88870672c6a87b974c7619689afc115afdba5b20cd5a2aac2c4b99e08265e0bf234910de14c9706ace7f987471a89f11c49b48a0b7729f70f0b0fa308221a17df57ee69f529b66338edd300c43bd2f01c3d603e589b299c5282c33072500d773b4a4de8024ea369c82af27076bc4174198eea134e3408a1f34ccb2d3c96169539dbf51994687568f01e2e6c74037ec01e87fdbee70718b741f8f779b0fb81e7b2ed642bc4bab464ee7dbefcfdcfe64e3381f58fe00a6a15f31b82d3db9b9ef3840654c66d85e4adccbb91df7709528229867d6b9488bc29a381c738127834afbc78d3d22e159dfdd00978df619da72185ee03cec4d4e446d85eb6984dc11370f439f87560657238333c896ded68514e00a71cbac39c5651370a1168e45253271727dce577c2c3a9f52069087e690cfb68d4647ec810c9227c717c39421d2cccb69912731c6719e264251fc375d0511919f8aabadca176c0fcf110c1f3223da0dc91b9a231f22cceca31474db6c94a5bf593275568a5326ec54e54a67a213559bfccb4be4eeac76a26ab88349a37655564ad799dacc377cccf6dc5093165f012047725ae494b58ea9e24841d7ed56dad56272904da94c81cbc323c46e6910c9b4324df4c910b5c230bade2fcdd8d56a3ba61aeab0d9faeec12228b885c3ebec1e4caf4ead695e92a22d74665bf84c892495e36c92b265946a4305aaa669ebc8a48713b46ae83e935c87f030a5a6993d74d72b34dde8042b6bcc1847a726b82601378fbacb2fb6c0a4133329d972652feebaeb7db04d9a95aad5caf1383cf93ca10ba7935a43378831995948ef5b69c4f76f2f4882605ceab72822078a379872cdb891a59b375a3dc5883a1dd81a1250819f3903dc14373e5582a5babd60088c4eaa9346cc9e855191d950d197d0ba2eb5340ec4b20b4291e2c11f100e59fa4e194564ed29103b40696cf06fe808df848bfed0581c386d597c8e2a8c899a8d466a0d206c6cdff8e95e7dffc8aa700b81799be3d8d9559aeb74d82a03d0301253125ae23c54d8324a25a7941603b69b04aa4f11e68bc77dac6c5a4a64931bce5efed5af5dfee9aa9f433a57ef9076150f0ecb325fcfdf94fd74ee802a62f4e937096ab5a370d9e6c069f1befdadcec5db335a3a2349cb16df06a349f01355b7215eae5f51aacc2335885f82fc35d9089322a517592e8fef1a5de843d4b56606851a694cd3f64d630c90a2459210d18eafa1ae4d9843ca9d546b95a8144f14f20d38da9a5db935c2cb69990ff070a0f1f71f9b7a1608c10d12d3105091a4212ff142881b7b330d1fe1125c6ff45c92d98f36f3f2efd30357a14991e9ca4e4cf5c2525306f031e642346f4d90f49393aa9ddd9838378f0a4acc30f67fc4b18d99efce5bcb13d0547526648552674d85aa57a3c49fc2bf9cb6c80aca7251a6228d7be0a84409a353b59678604e46b48f77194ec0f9caa3507	2026-06-03 15:44:52.766658	-3064767725587859703	1579
161	\\x70726f64756374696f6e3a6d6f62696c655f6170692f70726f647563742f38386330646566322f3834	\\x00118161988ba61388da41ffffffff789c8d56cf731c471556426a258d35b624e338090e6e96c4d889ac8c240b52d317c98ed6daf20f8cb5291354a9add64cef4e9766a697ee1ead37ba509c4325509c28281754aaa0e04415077248c2dfc1d1472ef80fe0c0f77a77b592097154258dfaf59bd7dffbd1df372fcc1c46f1b44ad57bf16c290ad9acbfb8fdc3bb5befb1fb9b0fd8ee7a14ddb9fd7e2dae6db5e2f954dac4a89e53ba6cd69f7fee1b8f7ffb27b61245af3323faec12abca8eca9d34320d03dabaab59268553657789959af58c4ea4b5580eb7ef4b27546959295c6544ce64f9c1a0901681caca19254b67878ead4c25fb4b4c185d205a420ec357f201b37d295d1884c193471ffe954eb455571856a88738873dfed91fc826d254397580d864b85719c9325dcac1f0bd5ffd99dd9203765d96b2a3e8cc30585966d7b5b6ceb2665154a57203467e61705f2519532513258af050a5c283dc9679cf527e4e268e892ea5e5e0d6c112b5f2215797d9dd51a25ba534dd01dbd19549247bfc9bdf87c18f2aa488a8294b72294ad4c2bbec118830b82e1dcaca041517a92313e63433805bca7498311db1b6cc6e6a9db28e36ec86ce5314ea86aeba19b07ff2c730d8d1da65a881cb8c16887a4317852e51c3ca220a92ca742111b590a9921ef3b565b653f57adaa010efa8aeb4940da27df8c5386755206bc0e9568e7a9dbb2c0c36556a5981e6eee95cd98202ad23d03e4eb8c41ec83c2f31050c8d0d8377e96482dbcd759f1a66e11506e3425144b2e28c9e346e84eac9a35f7cf6efbf7fc4b6759fca80186818b33d0d6ca95048e8b22c7a689975189824bb120677d443d6572e637d610afca16a5e62b944fec09ba614c749b184b9c9f719f064d2ec01406a54b96f3d4e262693ea878e5a54e3d3ad38e81995c80eaab52e57e3b3a9b289ae4ad7f6e6285eb44819590cd71b33f13cda26f2a3e54b931724e6a174a22bd554bc786476831ec24ce21e88bc228336aa3b890483150738c7b645417e9d5a14072841b2afe6e219bb5f35eba7ef6eb6d656af5d6b441ef82c4d76b33e7dabeb97a7fa52753317c5675255c8d2d2e436eb537e6f012d48ab6408a6599fbb4977d90cfcdedc9e30894e613e73effe3b5723fcbc7dcdef84992ddbb415c5b348eb281ae5d6cbc5a0ad4d2a4d145f50b66dabbd237269cb52ece5326dc4af6047278920303e538fa211cf77ad1b7bb5e2b3b49a54af535b8fc3044dee6a33389ce6536a91d79af5f3e3b1da19b7cf0efba70abc14c5a7fcd3ee4ec5a78c67adc3e9784e1c4803ebc66c1cf8eaa333f3c0a4cab62f2d72c16adc1a42bc80358679bcbde09f58e16ce41f364bb643167ff299c4801f65da16eedd986d2674b347172e8e5b68c203ccec4fc054bb33cd2a9e254bf8d1c717fff1afb55f366af1ec07d8899af5854dabc45bb774be2f9ca0b8cd8a2f85bf1efa7d5ee357d1d1aa978e0fe26f5234781c4582c7c6cbfffbd2854cd87651e54ef572d9fe69459c4777b031e9df7886cfa7b223e089d9340a7e6d954671385a5045cf19997b00a30edadddae15534e6c7d49857877ab37367f3f66d767d7b6b8bedaeac4737efbc4fc9f01948cd7f9e271d00a7e56054a20c4801b30514805db6d4aa1c947285ed49d0db93471fffee846ea4c2ece3b667186e70430f245dbaa1c38e331af4428497d04d62fe6a8dd469246923d5224d9b88cc4941f932d5f122036603673e5b6beee9be349d2a9fa88d571f90d4b355a74377f698d64cb471a43a5f25092d232811ba5bff5f074eea8617a911ed5b7825789ac1487e8ed4626b207194e7fc6d2f0bc7f81eb6cd41650e642a3c2e09df4418f9b4a690167861184991d795a765a83946725c81c6173d954e3f446f3ca8910e7d850837a1da28ed587c493034a226992c5422f2af293ef8e784fc7cb9fa68e3b5260ce88a9f941baf3fc75be0afc16c0793f2b65ce541c44f6dbcc6e7f01baa297e3ae267223e1ff1858d59bea86afcec90e757be1ffd60d5f33cffe611c7f3739dda0a7f71c4c3fcfc4926e72f1da7f0356f7a39e2af8cddbf15f10b0dfe6a837fbbc52f6ecc73f64c6ee5df89787d778a7f179eaf01dfeb007ca9c5bfd7e0975bfc0a80de46198ff890bf71929cfef9b7a5b5a7c809a6bf90892f7f7dd7b71a3c42b15622be0a269a33f240c93e91d2622a7345d30b3aefe84348b138400b495440e11010ba4fbbc8eef42688a659a6cad36b7c9e26b0f074368e808fe6b5abeb6cafc2e72d7ddda462301497733653bd1ec97f920983d96dd62f368cc4748fec0c9f4918f6c73fff149fdaf4ca7f014c1de297	2026-06-03 15:46:10.297025	6944763469747156969	1850
165	\\x70726f64756374696f6e3a6d6f62696c655f6170692f63617465676f726965732f3933316461616136	\\x001181cca665d71388da41ffffffff789ce555cb721b45144d5294e34785323654b6b7bc6025eb6529b2a462118a38c885e35072ca0416ae56cf1d4dc34cf7a4bbc78ac8c61fc11236142b3ecb05ffc1e919c98f60d8b162a5d1e8deee73cf3de7e883d5efd6df6d0c1eaa487d3458d322e3d1cee32f84b273fa940e84cde8c0b24b56062bcf4e069b113b6955ee95d1a39dfb7f3ef57424ac48158d85f609d768c634b14a4f696e0aca0b8b57310ed98dc3211495e7e6d64485f48e9c29ace488226559fa744eb13519795b388fb7a991222dbbd9ba3a1d1776d16f859e322947d69850a8347a44a4022a7464ec1313b91ab1764589450b5f00257981836b94a86942baf0b6eca891d011fdc8d6903419b065ca31194d6f0a0ce6e7f595e1c393c1872a13533e2b6c8ab97f4bbccfdda0d1c8cae15d397b1ddd0d2b54ea1a427a75ce67ce1b8ba6c6243513d7b05c8dd9e0f9612cb3837cf2e5913ad64e7dfbfca0f97a3c7a7274f2ca8df4e72da9464f46d9a19bb40f6371fab58abf697eb6bbdbebb73ba215b5e36eabdbe9c5729f9bed6e578a7dee772742f67b1d8ef7e249a76195e47aaea725eced25d767d214daabd5c156a45c9e8af999b1115b75efddc6f09eda1cae8c76b6abadbf5c7484fee1eaff6acbc3b5e6705d6d0d3716b47c1c68f9e43996aa1ddc70a4d294af8979d07ef07766302bbddf801bf129038c8a3647de4c819f2d4961392e52b0b2a4c97991a7fc4f63c7c644248b14a3721dd60493981b6aa3b0773a1756b1571c6ea88667ed77f15342d9024caa7e40b198aa1a7d6f66c256ccc4e6ad877641e7395f2f2fd0ef3860079299f2090954cac2dd60ae6c1705a681be64a0f2d1faa3f5f19d4b0f6b761549d38aa4d0bc44062a50c65cd526a80533e48a0928d192abe2426bc6b31315caf008466fc82048127772e0a4640b0c2a9c9e19e7af34121b9bd5e934a996806f41744099b148319cbdc5394e533903378ae764e2182d826689c19a4cc625ac89480346b024e625f79851c10bf3306b2c3062c5cbb5cc76af64b61564f6f8c502da78c6ec59c30d4ba10d2f2f7e7ea517c3e28acb8b5fab645e921c5ebc30f4348af0655c4c85bdbcf885aaab60e0dfffa3b87afd2f7125facd76abd76f757bdd562491575274782fe6de7edcee44b2dddb6bb6b8dd948d738613c404542e430bdcac5d71b31db8593f1e7d35a62bdffd71ffce448ae13233c366e028a5c32ac2f6735b296429162c5178c27d3a72b7b63c532e82ec4a95e761e5c8077e8b8acab89e65a2d59b82172165c05ca9d8ca2a0b7f98c2430ef33bc47b43a1a58c2c673000c99405c2c989986b0b7d8b08f6662be0b95232cf4a4746d6e461b260461732174ebbbcf8e9da2f32e14c214b71d38d97467b882f44c43203cb30c0cd4b2b4cc1920631b04318bdccf16516016dd0019c5d996f9156b78c776b11741a387f692ba11e078e224ea12e7b2b226aef0773f96f105055f15338be11c89b410d7f01ebed0620	2026-06-03 15:49:25.626632	6546180962445640545	1265
124	\\x70726f64756374696f6e3a6d6f62696c655f6170692f66656174757265642f31323833373633612f6c696d69745f35	\\x001181206db6f1e887da41ffffffff789cbd964b6f1b5514c7edaaf278ec38b69b367d108871692805bb77fc88937b1775503bc8246aabd608892cac1bcf1de7a6931977ee4c4c4825366cd820c1274062c116b16289ba61cd928fc0962d4870ee1dbf9226e629167edc3367cee37f7e67ecf3c9edd451096bdce21ed65dbacf5ac5e4233a48e0c4bd36ce594c747dde0fb8e7b68a69c1064f074f13446be354dfe75d66270cbc6071d1f54237e82813c21704731ceef6a27353c7399bbbd4191faf4c6e607e97b901ed311ec317c6e6e0b00f6126710fa8134a83e7f3de241218043d803ca243f7a59f9d40382502affb849fbb1fc749f12494355b15c3a8aa9af5d0e541aba86df6d4313d60bcb71b209cb5f83e7305f42810cef77dcf0abb5115ade2dc3bbed765fea1ba636e87fa5dcf0273f6e1a3bb2584908156d595ccae703bf212c23af4235ac598b2cba6fa0e3dec78bec57c8497b8e88870672c6a87b974c7619689afc115afdba5b20cd5a2aac2c4b99e08265e0bf234910de14c9706ace7f987471a89f11c49b48a0b7729f70f0b0fa308221a17df57ee69f529b66338edd300c43bd2f01c3d603e589b299c5282c33072500d773b4a4de8024ea369c82af27076bc4174198eea134e3408a1f34ccb2d3c96169539dbf51994687568f01e2e6c74037ec01e87fdbee70718b741f8f779b0fb81e7b2ed642bc4bab464ee7dbefcfdcfe64e3381f58fe00a6a15f31b82d3db9b9ef3840654c66d85e4adccbb91df7709528229867d6b9488bc29a381c738127834afbc78d3d22e159dfdd00978df619da72185ee03cec4d4e446d85eb6984dc11370f439f87560657238333c896ded68514e00a71cbac39c5651370a1168e45253271727dce577c2c3a9f52069087e690cfb68d4647ec810c9227c717c39421d2cccb69912731c6719e264251fc375d0511919f8aabadca176c0fcf110c1f3223da0dc91b9a231f22cceca31474db6c94a5bf593275568a5326ec54e54a67a213559bfccb4be4eeac76a26ab88349a37655564ad799dacc377cccf6dc5093165f012047725ae494b58ea9e24841d7ed56dad56272904da94c81cbc323c46e6910c9b4324df4c910b5c230bade2fcdd8d56a3ba61aeab0d9faeec12228b885c3ebec1e4caf4ead695e92a22d74665bf84c892495e36c92b265946a4305aaa669ebc8a48713b46ae83e935c87f030a5a6993d74d72b34dde8042b6bcc1847a726b82601378fbacb2fb6c0a4133329d972652feebaeb7db04d9a95aad5caf1383cf93ca10ba7935a43378831995948ef5b69c4f76f2f4882605ceab72822078a379872cdb891a59b375a3dc5883a1dd81a1250819f3903dc14373e5582a5babd60088c4eaa9346cc9e855191d950d197d0ba2eb5340ec4b20b4291e2c11f100e59fa4e194564ed29103b40696cf06fe808df848bfed0581c386d597c8e2a8c899a8d466a0d206c6cdff8e95e7dffc8aa700b81799be3d8d9559aeb74d82a03d0301253125ae23c54d8324a25a7941603b69b04aa4f11e68bc77dac6c5a4a64931bce5efed5af5dfee9aa9f433a57ef9076150f0ecb325fcfdf94fd74ee802a62f4e937096ab5a370d9e6c069f1befdadcec5db335a3a2349cb16df06a349f01355b7215eae5f51aacc2335885f82fc35d9089322a517592e8fef1a5de843d4b56606851a694cd3f64d630c90a2459210d18eafa1ae4d9843ca9d546b95a8144f14f20d38da9a5db935c2cb69990ff070a0f1f71f9b7a1608c10d12d3105091a4212ff142881b7b330d1fe1125c6ff45c92d98f36f3f2efd30357a14991e9ca4e4cf5c2525306f031e642346f4d90f49393aa9ddd9838378f0a4acc30f67fc4b18d99efce5bcb13d0547526648552674d85aa57a3c49fc2bf9cb6c80aca7251a6228d7be0a84409a353b59678604e46b48f77194ec0f9caa3507	2026-06-03 03:37:19.42271	2296485457748180900	1579
127	\\x70726f64756374696f6e3a6d6f62696c655f6170692f63617465676f726965732f6131386135386130	\\x001181706c8828e987da41ffffffff789ce555cb721b45144d5294e34785323654b6b7bc6025eb6529b2a462118a38c885e35072ca0416ae56cf1d4dc34cf7a4bbc78ac8c61fc11236142b3ecb05ffc1e919c98f60d8b162a5d1e8deee73cf3de7e883d5efd6df6d0c1eaa487d3458d322e3d1cee32f84b273fa940e84cde8c0b24b56062bcf4e069b113b6955ee95d1a39dfb7f3ef57424ac48158d85f609d768c634b14a4f696e0aca0b8b57310ed98dc3211495e7e6d64485f48e9c29ace488226559fa744eb13519795b388fb7a991222dbbd9ba3a1d1776d16f859e322947d69850a8347a44a4022a7464ec1313b91ab1764589450b5f00257981836b94a86942baf0b6eca891d011fdc8d6903419b065ca31194d6f0a0ce6e7f595e1c393c1872a13533e2b6c8ab97f4bbccfdda0d1c8cae15d397b1ddd0d2b54ea1a427a75ce67ce1b8ba6c6243513d7b05c8dd9e0f9612cb3837cf2e5913ad64e7dfbfca0f97a3c7a7274f2ca8df4e72da9464f46d9a19bb40f6371fab58abf697eb6bbdbebb73ba215b5e36eabdbe9c5729f9bed6e578a7dee772742f67b1d8ef7e249a76195e47aaea725eced25d767d214daabd5c156a45c9e8af999b1115b75efddc6f09eda1cae8c76b6abadbf5c7484fee1eaff6acbc3b5e6705d6d0d3716b47c1c68f9e43996aa1ddc70a4d294af8979d07ef07766302bbddf801bf129038c8a3647de4c819f2d4961392e52b0b2a4c97991a7fc4f63c7c644248b14a3721dd60493981b6aa3b0773a1756b1571c6ea88667ed77f15342d9024caa7e40b198aa1a7d6f66c256ccc4e6ad877641e7395f2f2fd0ef3860079299f2090954cac2dd60ae6c1705a681be64a0f2d1faa3f5f19d4b0f6b761549d38aa4d0bc44062a50c65cd526a80533e48a0928d192abe2426bc6b31315caf008466fc82048127772e0a4640b0c2a9c9e19e7af34121b9bd5e934a996806f41744099b148319cbdc5394e533903378ae764e2182d826689c19a4cc625ac89480346b024e625f79851c10bf3306b2c3062c5cbb5cc76af64b61564f6f8c502da78c6ec59c30d4ba10d2f2f7e7ea517c3e28acb8b5fab645e921c5ebc30f4348af0655c4c85bdbcf885aaab60e0dfffa3b87afd2f7125facd76abd76f757bdd562491575274782fe6de7edcee44b2dddb6bb6b8dd948d738613c404542e430bdcac5d71b31db8593f1e7d35a62bdffd71ffce448ae13233c366e028a5c32ac2f6735b296429162c5178c27d3a72b7b63c532e82ec4a95e761e5c8077e8b8acab89e65a2d59b82172165c05ca9d8ca2a0b7f98c2430ef33bc47b43a1a58c2c673000c99405c2c989986b0b7d8b08f6662be0b95232cf4a4746d6e461b260461732174ebbbcf8e9da2f32e14c214b71d38d97467b882f44c43203cb30c0cd4b2b4cc1920631b04318bdccf16516016dd0019c5d996f9156b78c776b11741a387f692ba11e078e224ea12e7b2b226aef0773f96f105055f15338be11c89b410d7f01ebed0620	2026-06-03 03:40:58.17209	-7706749770886257561	1265
275	\\x70726f64756374696f6e3a6d6f62696c655f6170692f63617465676f726965732f3932656436626563	\\x0011819823631d3e89da41ffffffff789ce555cb721b45144d5294e34785323654b6b7bc6025eb6529b2a462118a38c885e35072ca0416ae56cf1d4dc34cf7a4bbc78ac8c61fc11236142b3ecb05ffc1e919c98f60d8b162a5d1e8deee73cf3de7e883d5efd6df6d0c1eaa487d3458d322e3d1cee32f84b273fa940e84cde8c0b24b56062bcf4e069b113b6955ee95d1a39dfb7f3ef57424ac48158d85f609d768c634b14a4f696e0aca0b8b57310ed98dc3211495e7e6d64485f48e9c29ace488226559fa744eb13519795b388fb7a991222dbbd9ba3a1d1776d16f859e322947d69850a8347a44a4022a7464ec1313b91ab1764589450b5f00257981836b94a86942baf0b6eca891d011fdc8d6903419b065ca31194d6f0a0ce6e7f595e1c393c1872a13533e2b6c8ab97f4bbccfdda0d1c8cae15d397b1ddd0d2b54ea1a427a75ce67ce1b8ba6c6243513d7b05c8dd9e0f9612cb3837cf2e5913ad64e7dfbfca0f97a3c7a7274f2ca8df4e72da9464f46d9a19bb40f6371fab58abf697eb6bbdbebb73ba215b5e36eabdbe9c5729f9bed6e578a7dee772742f67b1d8ef7e249a76195e47aaea725eced25d767d214daabd5c156a45c9e8af999b1115b75efddc6f09eda1cae8c76b6abadbf5c7484fee1eaff6acbc3b5e6705d6d0d3716b47c1c68f9e43996aa1ddc70a4d294af8979d07ef07766302bbddf801bf129038c8a3647de4c819f2d4961392e52b0b2a4c97991a7fc4f63c7c644248b14a3721dd60493981b6aa3b0773a1756b1571c6ea88667ed77f15342d9024caa7e40b198aa1a7d6f66c256ccc4e6ad877641e7395f2f2fd0ef3860079299f2090954cac2dd60ae6c1705a681be64a0f2d1faa3f5f19d4b0f6b761549d38aa4d0bc44062a50c65cd526a80533e48a0928d192abe2426bc6b31315caf008466fc82048127772e0a4640b0c2a9c9e19e7af34121b9bd5e934a996806f41744099b148319cbdc5394e533903378ae764e2182d826689c19a4cc625ac89480346b024e625f79851c10bf3306b2c3062c5cbb5cc76af64b61564f6f8c502da78c6ec59c30d4ba10d2f2f7e7ea517c3e28acb8b5fab645e921c5ebc30f4348af0655c4c85bdbcf885aaab60e0dfffa3b87afd2f7125facd76abd76f757bdd562491575274782fe6de7edcee44b2dddb6bb6b8dd948d738613c404542e430bdcac5d71b31db8593f1e7d35a62bdffd71ffce448ae13233c366e028a5c32ac2f6735b296429162c5178c27d3a72b7b63c532e82ec4a95e761e5c8077e8b8acab89e65a2d59b82172165c05ca9d8ca2a0b7f98c2430ef33bc47b43a1a58c2c673000c99405c2c989986b0b7d8b08f6662be0b95232cf4a4746d6e461b260461732174ebbbcf8e9da2f32e14c214b71d38d97467b882f44c43203cb30c0cd4b2b4cc1920631b04318bdccf16516016dd0019c5d996f9156b78c776b11741a387f692ba11e078e224ea12e7b2b226aef0773f96f105055f15338be11c89b410d7f01ebed0620	2026-06-07 04:39:57.590457	1755067568580486914	1265
151	\\x70726f64756374696f6e3a6d6f62696c655f6170692f63617465676f726965732f3635363837303830	\\x001181cb09e2bd0988da41ffffffff789ce555cb721b45144d5294e34785323654b6b7bc6025eb6529b2a462118a38c885e35072ca0416ae56cf1d4dc34cf7a4bbc78ac8c61fc11236142b3ecb05ffc1e919c98f60d8b162a5d1e8deee73cf3de7e883d5efd6df6d0c1eaa487d3458d322e3d1cee32f84b273fa940e84cde8c0b24b56062bcf4e069b113b6955ee95d1a39dfb7f3ef57424ac48158d85f609d768c634b14a4f696e0aca0b8b57310ed98dc3211495e7e6d64485f48e9c29ace488226559fa744eb13519795b388fb7a991222dbbd9ba3a1d1776d16f859e322947d69850a8347a44a4022a7464ec1313b91ab1764589450b5f00257981836b94a86942baf0b6eca891d011fdc8d6903419b065ca31194d6f0a0ce6e7f595e1c393c1872a13533e2b6c8ab97f4bbccfdda0d1c8cae15d397b1ddd0d2b54ea1a427a75ce67ce1b8ba6c6243513d7b05c8dd9e0f9612cb3837cf2e5913ad64e7dfbfca0f97a3c7a7274f2ca8df4e72da9464f46d9a19bb40f6371fab58abf697eb6bbdbebb73ba215b5e36eabdbe9c5729f9bed6e578a7dee772742f67b1d8ef7e249a76195e47aaea725eced25d767d214daabd5c156a45c9e8af999b1115b75efddc6f09eda1cae8c76b6abadbf5c7484fee1eaff6acbc3b5e6705d6d0d3716b47c1c68f9e43996aa1ddc70a4d294af8979d07ef07766302bbddf801bf129038c8a3647de4c819f2d4961392e52b0b2a4c97991a7fc4f63c7c644248b14a3721dd60493981b6aa3b0773a1756b1571c6ea88667ed77f15342d9024caa7e40b198aa1a7d6f66c256ccc4e6ad877641e7395f2f2fd0ef3860079299f2090954cac2dd60ae6c1705a681be64a0f2d1faa3f5f19d4b0f6b761549d38aa4d0bc44062a50c65cd526a80533e48a0928d192abe2426bc6b31315caf008466fc82048127772e0a4640b0c2a9c9e19e7af34121b9bd5e934a996806f41744099b148319cbdc5394e533903378ae764e2182d826689c19a4cc625ac89480346b024e625f79851c10bf3306b2c3062c5cbb5cc76af64b61564f6f8c502da78c6ec59c30d4ba10d2f2f7e7ea517c3e28acb8b5fab645e921c5ebc30f4348af0655c4c85bdbcf885aaab60e0dfffa3b87afd2f7125facd76abd76f757bdd562491575274782fe6de7edcee44b2dddb6bb6b8dd948d738613c404542e430bdcac5d71b31db8593f1e7d35a62bdffd71ffce448ae13233c366e028a5c32ac2f6735b296429162c5178c27d3a72b7b63c532e82ec4a95e761e5c8077e8b8acab89e65a2d59b82172165c05ca9d8ca2a0b7f98c2430ef33bc47b43a1a58c2c673000c99405c2c989986b0b7d8b08f6662be0b95232cf4a4746d6e461b260461732174ebbbcf8e9da2f32e14c214b71d38d97467b882f44c43203cb30c0cd4b2b4cc1920631b04318bdccf16516016dd0019c5d996f9156b78c776b11741a387f692ba11e078e224ea12e7b2b226aef0773f96f105055f15338be11c89b410d7f01ebed0620	2026-06-03 12:57:03.57172	5792266482633394864	1265
276	\\x70726f64756374696f6e3a6d6f62696c655f6170692f70726f647563742f36626332333161392f3833	\\x0011816bd891233e89da41ffffffff789c8d56cd6f1b45140f0539b193cd5769534a4b0743430b49baf9826ae792b48d1bab492889ab52a2ca1aef8ebda3ecee9899d9386e2e8873510be284401508090427240e70e0e3efe0982317fa0770e0bdb11d272db4444a9c79efcdfb9edfcfcff5edba5eaf08c4bb5e3661312fe64f2fbfbdb6748b6cac2eaeac904bcb4b4b64737adebdba7a3be365964ade70c0b5af44dd089914f347fe3eb2f7f9b7e4b28c22ee1b1e90aa9231d1318b22724e1b91d422aef57952e15c93870fee7fe1e4d0be140a7f6b82044c6d9171128a5a1835495d1a9e9896c1865132a9919807c217098bc8368b52ded2adb3065c4a93ba923e38e7819373720f1fdcfd81ac49c2824018b10dd1f63ef80a053aad314562b103b958d9f5547152958a6b434299f066ebfa27df916bbc492ef1845785d1289c9e22d76583ab6a1a91621ca789306020a5365c11bce1e4d6851f12911096403f7644009f70759947754daa50960165153a03cdd224612655d0191b71668a5c9532c04cb07d01947459a6b5101c7ffd8d932b298685c804ed490a55629850c69c288e6de11067434a1342a92654921948028c62680b96afb80f9fcac69a9d221b69bd2e95d164a9c921d4c616785be62c3221819e3ab91bed088bcd546df380d9bc38d8fa4cf14e456de744e3ed5a241be87c6e8a2c8a40932ba2062d858ca182bbbf39b96227935a0a8db6a19cdc5aab0524e046eec06c6c52e8657e8a74744b0957b526d990a9f239d9fbec4bf0956803ad25bca56a08134af0ea873c163e8b746b841ffdf2d74ff7c8b26c10230914041324ba2e21a38009e822fcc3e33acc501b19331fd259153bd619693015c31f1cacc46d89b69cdc4d54845c55305f25922d8dba4323c8d0de9297ab2be1f32aaccb453ee31d0d84f6659a98b215bbdea8e65104cbd73a2ff479c355dce8fde389ee050e052786d5b8e8f146f7c5a65907375dbff62980402a51eb7a028166db104797598c76d58cebe5a0527f4b64bc3ebd9516f3836b8ba5e937ddb7665c9b781637ba98efbd56b3c7fe06c78dad66a6bda140c43cd1b8b5c57c8fd58ec03483d46fa553cc0f5cc5d7a79a56375061ca97018887aeaf5f9974e1e7e2acd538a14ecaa872bd2c14b6ef0dabab47ac59962ae0caf54e095dd669651f59ca3c6195880705ef2468a4ef336ddf42b99d45c11bae69d3b12a7947f1d4ed5f3533ef393e8cb3265573b797f688519a29e6c73a2bb6d1e0dce032b5272862b8e47afdf6536ff678fd8a2178edf67a030c5e114817b25ecef61f66330c3989a46c9b0bb5c0a9331ccc7804cef0363aea11fb0927880df50faec07e6ea0c8861ef215873c833233373cb2e82376b5dfaae795600ab885ef014c6df615532f8b12e7defd33bffff1e3c46cc6cbde018d5bcc8f2c6ac12e5c93d116330cfd16533ae17cdab2fb3e43275d6f28ad079d40f40df40616fb9ec062e1e4e3974e854c97e33432a21ef1f2fb29c29c81bd2f7407d859e3b180571958c27a2a01766511b89ed33e604b8f291ed904da23d49b99dd4998cc2d9cccf116e9ac2fde249bf3aebbba721baba07dc030cf3c8ba03fedba67896a237f5544f05211f85105200ff082e39a2089246d5a80639b2eb861a28bbe8021779a31c0d2384952a304b7887d809418301878f3d1a003d844e3c21ce499c768e531eeb13cf35482b174a2bbf4f2745a81fa0c300a61352ceb20c1b469e50938fa4e0a255a9ef023ce920e9e5630092777891b044086cd85d2a112045205e926400eb6e2369b3c89b90e939293bb2ce35826ff4d629641f6e9e95116394c3c07a9c4924e0cc3adc848e8b84d2296d8c6c94dc0dc04b6e000b961bac859383024b02e19a14794420c8010d3ceeae97c72ee109b9cff773a19271187fa21df20403f86b3094b30964c0eb28bcd93b0eea6ea0e4ad9b790ad42a3e6f90ccdb9b47fe12c1d805f47f4d041970eb974d8a5230b593a2afae9d116d0cfcecccd152cd0d3e7f7419e1e73e9f13608d3b1c3304e4f1cc4ef392b7ac1a5273be62fbaf454819e2ed0974af4ccc208254f0556fab24bf39b3df415b07c15b23b0be98e97e86b057aae44cf17f34e31e942217dfd302efd39fb71e1115c02d1af28a253ffdff44281bad0a96997ce00080d28be2d7803f16834e091c06f4800e555b90b44ccb661ac482800df401ef8a436a1b8c145f8325b4c026191d51bc3fd8c2d92753c007ecd4ece934a0aa8834b17b0668b588ee950d4eb48fe7ec8146c76317fa6a0387c836acb096c2fecf5de873f03eae1957f004cc9e29d	2026-06-07 04:40:22.911881	4661574323931098942	1837
133	\\x70726f64756374696f6e3a6d6f62696c655f6170692f70726f64756374732f39636537613862352f3635663232323764373636373966313561633831393965646565346235623033	\\x001181a6c74b7fee87da41ffffffff789ced9d0d7024c775980f2073f83be0eef82792a274a31309df49c0defe03bb4b9a5800bbc0f280c3110bf0449e6468b0d3bb3bc4ecce7266f6704bba1c16e5380a4dd1e68f9ca24816239b0c2db954b6548acdc83275a1a272c971acc891448ae594a42b2b51984a99765251a5e22ae5bdeee9d99ed9d99fdb43d12ceb2412dceded99e979d3fdf57bfd5ebfb97af8a1a1e435354357ea05cbdc52644b3e1b7e683a39a42aea9dc991aa5c21b9a337cda7f39babe98de5dcf47a6e21239d0d9d5cfad8fee4fecc46f29042cc82a1d62c55afe68e0e7ce1e2c3cf9d264691142c695bd6e46a81487a51b264d322925c55a4329135ab2cbdfdc263af5e7cee77c747f36ab5a411a9a66baa59260a1c6456644b950c158ebcf8f0535255b7244bd725686281982651a69c2243de0d8c8f8e8faee8d5d294241b3a1e59904a86ac564dc92acb9654d0f51da9a8d58bc58644ce11a321596a85c0e53ff5277ff3ca6fec4f0d6f24476b78ade26838304bc2c96b15d52ce8f5aab5458b83c96b4ca269d048f67d6e3479a8a85665cdf97a63f300621448d5924b44dd97bcc629b61a35384df3bce764ad8e05baa1969a678202533e07d731b7e40ad62bee0f26474d4b2feca8c3c96173a79e3b3ab1b49e4ec7220ba1186df848bdaa5ab9a343274bf4ebd82e514b65382e943ca8c04d564d782466eee83efaeb61fb11d3e6e48e1e5842711a0dfadb816dd928e80a141f3cbdbe381d84ffc566e92fe365b3ba853f0593237063ced9f0ee6a9adcd8d20d8518c1e42daab965d6b79d9eb045aaf2b646946cf266f8452f14646c0cbd57da8a6cf250c9b478ad8de4b5f8ad29bfe24834904824c70bb2454abad1786828b55fbd2e35943b7afd127bb893d2aaaa69c432d923542b7054303946ff6b9edd971c33a02b544bd0b70fc8f0d8a1746e2c394a1f003c9c43d028b5ba45a50b3703dff8d3c1261f86ef9abecb7f3e4cff0bdf64ab0e029858d177a53c16d14b1f2c18045aa96cc9d666524a172cf51cc9d76b35ddb092c90d780c6754ab7c9f5e25678773f5e408968c3ff69b472e3cf5ebdbcfed4f8e3c08bf0473470fa74d553e7152d77660fce17973f5d4f4f893acdeadfb538160f260bda6f00ba5a6f06c50c33913d498bba5f5a05bcab2b955a96b965ad3c8d60375196edf5289996d3e41de8fdfa390a20c35a17f1a2ad4db52956072dcfe02227d681a9ec13df80cde3b7f6f7a31bd94931696732b2b39a04130b8b4fa316c766a247774f0d54118d95216bbb1299d948d2adcd38e2ce1a988d5c0a1ff8730f6c647b1d6222135c980715fd035bd6ed0114faa65e486294113cb925cab11d9c00276048adfac419ba7a432f47718dcf2393c7292018055e2082aea8624d7ad32742b00435e878f52aeaac02d5132400f417e408bbe289d82c76bc89ad690cc7a755a81b62ad09adf964ee970624b2daa0555d6ec66b2839efcbc74a6dc9016caba6e1269be212b724985afd031d53bb14a28c0cf2a2db0db9b87aa163140064f7f797c7409fa8a89a42b8b22b074a95037e0fad8cb0be5ba55250d737c14da5125508bde925f83c2011c138a9447e1482b403bad29eb1540a754ab574b208929a9a21b840b6e7c54145651aea8200241389180b48e2d4ca374119c5f1a1fcdf027c4b80e8037e50a40640a900c9fa0ddc0e0737007788268405ac60775775dd65478fe1b86aca816c581744fb34fbc0a730134a780b7089772e4699012d4958e391de938933e05b8344f4c4bda845941caea702b79da0cb83e6dc7f8e802131f14d4744585ef20d88654811f35191ab7ac574845560888191f1a54da059cd18e3c5a84c70713426a2c983a3037991a877f27d47da983c1d4a160ea703075cddc58ea5a7524751de3722c9108a6d3f4d0eb1d26a76e08a6de63333375a39bbaa99b04dcce8668d1cdc1d47b79f55b82a9f76553efcfa68e6ca4a4e2482c100ca53ec04138777dea6830f5c1b3fb52b742d16dd0944968db2f6ca48e6553c737521ff2622af5e126331e0740dcf7c68f2e0acc789a15dd8f45a913bd570d665321904b38988ad88038e30b88f015405c01c43f3a400c4783b3a9b1e258647626108f0225ee044adc999aa8270fceaba54552006d443b189a4d0603d1448284520761c437951c7a169b25a07d060391380065940365261e8ac5b37d0325dc0528fb63bdd064a32b4d7e0378f007ffe4c1090f22a0e8d7bc34e95695d2e417459a9c409abc67616d61edd4e686b4965b015d636563bd49929f0eacc2d08707930725a54ca433baae48a70d6a27c0902ae8d5ba25ada99aa49a52c1908ba03f4975133aae64099d8c9c876f05fc22558855d615a8ac57b6d52ad4de05f50d6c0f789830842b2a350570044291498c7344522d53aada83b85637b003a39d435903030e3b0fedae05d920c53ac587dd8b0bac7de614982ad03e9d35b36810fb88b26c54e00809156b8b0e273072146cf539fab18aa780ae54012b021b4f6d215437699b283578c38aa0015344d2a3cc8aae432d0beebb6e0026550b2f5c1346b93dbca760d8d6adaf7f8e7ec42345a9a14c6ac40c48394b92355397a83c4c49867f24d0b94d68145876785b784a45466ed44db8deb6012744393ae405a94dd9d26317aa828c00ee60c540dbaa20ef06924f538b309c1b1a09f0393a1e88f139fa3e187df7f9cdd1c3744841ef09c51733c1081f52a32baa658fe55e4755b4cba89acbd983ea5aecb8a370c9bc446b1d05d3f89365cbaa99c91327a0e7040a0065059e9bd10840573ba114b74bb1071aa1e0096ac19ca8d7345d564e14b68ad0e3a68a5b20287daabc150f06a71e605f76b76683c113e74227b8e9ce3f4c5ba4529b9e2d460a89d9d0b6524cc8ca763071e7967cc77c7ae1ae487e7185b6e88367f7bfebda74e9ba8cfae8910b9f7aec865f14905265457fe8a50f96ffdf6bf5bb85aa262bfa66933ef789f4c9dbf43923cd6f6e6c64d6a5b331b71ef3bfa91ed31ce2e9b0a4105385d1b38ba8d861aa86309dc100807951998649db40b81c9b573528b7a973dc564de8982c9449452dc8da34e5c124ccbb46053f9b65560ba75ca805c667a5c1473283151ff3b6b6c3b517075932e587a3ba70a0d002b0e46ee32770749893303fce932a2902566cad854ef86a555aa6ab390dd0e580386fbff0f227618665c6af095a1a314a0def6806a506198d44d0d130d7806f9641aa25ab6ceb28540532a55ca582eb1b38f53ff9799898917468f917656bdad4b5fa36b0e59c4ae9674ac7d253d2e2949499924e1e179ab0ad2b8d8b0f3fd30434d8b8a46a125b6d715ab2a896802bc87f90d5d7c647dd8f6ca7aaef5691f96a05fa3320bf04930a5bc7024d47361bf89b424f21ed02cf90ca66bd02cf172454d14161a078b6551da77179202c3cd8250d7a0b5d0ae3aa60d9166a11855a265a8dcb4f32e11051b9598643e1da9b784714fc65dd622b677053866e81429387a72e2b12dc9aa29bb274023a965c93f197b4a2d086cb8ccf74bea0eadaf8289c90617c5b864ff86b45c6f9402a9509e1da4f9c83d702f05a1d8da37424ba18ea5b979999ed91ba7b60187dfb1b7f9e1408f1142bfa929f61d4a92a858925c2e44308931b1733f95c3b9adc390886475d2b11ec36a8cce013a9a25a0eeab35bcd01d0641105d27cdd82396ccad16d98de00caf4f403b6328d1c72340efab35ac5be5a45db0b4065da3a0a5cd3ace068dc962d600fe81738e16ed3f3db6a8909c0b107129ba4519dc1c6350d286a3218c20c0fd336bd17c70e10358832d7aea177ed0018a90203da5b4d36b8e6855a13bd167e03eb0c3e374425886a4e762b0dc208216a641482a0c6e845aba9efd0f395758d98d000a90414a062bef8f0d32e2588ae172b32555ada6a3fb4c97261878d7652d001d22aa92a1a2832db2a0c7ed0bb145ce5946a504b2e51556a97001d4d24362e65df5f0770d8aa239c6317d7ad516e44064b0cee0dae65d60029eab6aad975cad087558ba24d211a88020466eb44d0ed3a8fcafd74542ea673996c34929de9775446667a1c9587e934ba28ab069a595998c758e7fd87518c94482c9c88476712f1981255e4c8bb4131eadaa64b675919549b1f3df1ec373c8a1114ad7a595681f2df79f3e2773c8a11147db40dcb6ec7277a3365196a474bcb998c7436120caeae3469f69d01d463a445d4879660d6a00b3794348803d1c43f03230ce6bfb75f78e95771302d8828c3ba9460408e8a7a1e8a051dcb6614ce490c38a6831b119d4d3ad90b3b7cc0c35c0c73afa38cb5da85dc1814cd3d1b289467b6a952b70cd5b1bf96744d011540add285175cf0b055258e463ca4c680e152d7b66d0d8b6288620dfe71f0803739c5877c9315cca50574705417f76a0d33ba1c6bee872f7efe872f3df2c3179ffbe18bafb296204af1ae913955d0bb64ad0482a212b6f43a6a04b6e95501a5c474ccae48736974e005000dfca1a469bbc041c933cac9331fca2442193f436c6ea237fac4623dd2e710f6d56b197d4edba38f91a75f35417ffcc8859f1e271bc278b158d19ffbad783cfabff6e99e150f28fa6fcda105b213c65615db3bac980a1f4943f6c7d1e25034668bfc1514f92b7e701fe2229e89a4b389881fdc839d041b0a76126c3625059b729d1bf8ddfea538f7c4910b8f87cbbf2c8826cb8aaef64ab15bd5e0462a541c8d4603b1582aac4e8028871eba019a38911cd5e46da2e58e8e84242e00e8604d79240f6fd71b4ddf2e8814859bbcdef1d57207a56fcf9e9b485ee7d4b49db623c1403496bc8e147108c2bccccffc67b8e4164d1e443f27af1a0acccc266fa215b6907986e38584fac9ebe4733078f1f2cc11a9ee4f1e444725f3d26d8098e94d1e4cc5e0fec2cefd15f787c5071e2f0e45a2a903c5fdf1d44c16ef621f1f95b3c154626ee00d6c572495c486876653292cb91d14f73bb27801ec90cbd8218f6473a79640675dcdadac6436a469691d97f759180027fe8d57ade3722cae645599aa87f0d651b7d177814975cd56e44063a13a9542d7d308200f48262cbd03006b2d0c73280b9c7be29ff7629b2ec85a41ad57a0febffef2f8e85ab34ddb68a8d53450a5a7d1be5140c96435999a0ce759429f2ebdf836dc0bcc333baa828bed04d86e680ddb50cd9c2f10687f95d53c43bdefd28a8e9ae4677e8b2eaad365eda2ba0dcae90e2135363f51ad19ccfe1231c647d70910098c6fb485097559dbb6e9a20a5d1726ade9acad4ec27d7cee2b18ebb02b95b446015707509527e7e13260239a742dd0d06122d1d0ac35eb25d990345ce4e78becb6619d6176f9248c4b6677db1636979b6ae868975281c3cd995e73b804ddba4a6fd9646b8f78fa58076b3ac7cc66b3abdd5c73547f902b9e351e10bc2e4b5add22559007c1f88dc7be888bf945669d96e84f74a15023b62b883d43b81841b700b419af069791ad761634edbe95ba023aca31410d386eff62dbcfccac3ead1b86aa80ad760caf6f770f19cc37cbe4f5c19ab22405f4921d6e31a30f8001fc0708f01ff801dc59ff4fcfcc2f84165a00deeb0419efa69e5fbb3746f3a7603e23b78c2d782210a0e88fbd1cef5695cd863f1067c3dc15f85c81cf15f85c3e7c705cf58c9ed862249149f48f9e6eeb757b889ecdb7afcf787802457fe2879e4e557dd07312d1736b76ed231be9dc4a933da7d2f7a44f655a16ef3e7055563f6f012c6cac78484447bdb39e645711ba07b531511104fc683894a71ce6d46d575fd3a3d68d417b3d7ac3c2a2f5e581a65ead120ce294c1182b182cdcd1bb16bf4c64c3b21d0bd2c5e75f6497a0cd34e869a46d19a84997ef407eba26acf7738f42413614553f279b85ba06b7c2873d059103042f293882149558d8407a47b81ea957748b98ceb23c82a458af16f89a7eac156e1edfc569c1dc878b5b44ad4e71d201c3b0cd2086938eece4024346d9d0eb25baea897d087a8e8da54b841177d2787044fd04939da9c4822c59d56300484d860fbb65b0d76919d066b35641309d86278d2ea345c6a99ca2a9b8926ca1044f9641b28ada3b881cbf4128148b46a37d836826f8ce380e902effb254b9cf431728fa4b3f1075aaea0322194174740975a095957b0141f94c3ebd9a61e11031f7aadbf7a847924641d4ec2888638532d9d9a91f17a21c9a1e44b69c05bd40c1302b71edcb09fec1aa9b55030053a5014f4f39ebec7ce54a98acdbf82f452fa4dbe10805f4d4b80885dfd3ce629dae76f4408a9868389ce063b8446982fe339818e174fa795591690b1d560804e191ea36ec9a0a98eda25b965583b9e868349acb9be9564fa862c9fc6540b9128eaf321e8c6e0c1b746df97392bb194dd64497c67246505ca14de946dd3847141093108805704bc3bd4ee7aaf0f02a15d9d2d99a17e8b318f36bc3c88552e0042241830ff63136d4da854ff904c849c7885923186b060d14bb1046e711d4484eab851dcd13adb6412ad02e7ab8252b3468ab7953e87099a49123b53a8db8e1eb8ee14094af3b0e1e1d0080e0dfb604811132139dc9cefaae34f6e8e648740bf9b8b619f231b7dd3f4370a970e8e1d86f0960f8342b7abfdfaa62a7aa942128180122bf8410b969697d6df3d4a2134b1573c5523dd1ca8e1666d005736727869b069c02ee404beed42eb175713b8471922d8bbb200328e0d030718f870306871e22867e9b72867ed86859b2df0b701c5bddcca68ff3f15291ab389c4568b814a4755b0aa71c29b041bd00b77d625794296ba1e350309d2086f1d17942fd9856190617bf5318045c45a27a56bea2ef10986e61e46290e84b60e128c476e17bc6e5a454341a4d3638e0d9a0be587b840bb19a3c501674563bbe74ca19b07032b30a6a8cd9010e8ba2b341b8ba0b1a0c0a4ee0a569475eba0d3dee5db587fd4868261c4b8dc17fe333311cfa493af4e1ef443d159da01196613bc072b4886e22b6c8591c8e412185c2e01d03221632f1d9d999f065606136d17b24587b2cf4165ef93fc7bff22b9eb10e45fbfdb0d0a92ac342c28585fb100bb72de756d32be97bd3d2c2fabdf98df48ab4beb67052caa757363cab2cdf1f14873488664732d1d0a4beba650c77951bd8776550fb4dafea30e9d5091c2504e31d0cd42c9bca300dac5235c58938a0176af00095a63ab1ad11b950e6ea438b7e412151301ae8d9327b59b859b59be08c5f3becc8dd4049537770d31a34c754eb9529e043a94af0a38f35820b0ae86fe4f14d6c94a7dddaf83a29515b258ff27cfb85971fe121d90e6c5d58b0684801ca0494740cd6e6620242a1b2ee8ab8b4f9e1346cb9a1b0902454095e6e224ea5f72a118d14d01c6c5844d48c50bdc0a50697def2455f0d4888955278ed7626869b1a8e9161d8f2c05b040ae7aaf849a62b1d26914d9d4d0c8bc4d2cfb3750e203635b07631c0605746114f02a32b7af5380b6842ba1b68f61a268647158c3a6e1e3069d03ce13eb6e11025cd5828341b60acd9a4acd964ac399000d4c43a87728fc403708e6bd503dc8a999d999d9f0ff51dc9ddaba7b3a740ee7110645bd0fcd997a7eff1b82aa1e82ffc40d3a92a03cd860b34671134930e68286016d6296c18673ceb295748738534ffc8493383dea0e2683c1e88851034350a9a1a034d8fdb4646225007587390b3269c8d04d3f37db326fe8eb1a6feedd4590f40a0e83ffbb126f6e1dc2f79aa42d1f704d6e82ed67c94aedcba594321737aedcc22065e5ed169ae90e6e78734742ae62a4d1c49f32825cda397461ad06aa2409a094e9af9582c12695d9bed9534bd468f5e3e698ea879c5830f28fa2b3fd274aaeaa7d57ccc47ab7191e68a567385353f5fac81a9788c6a31fd69347383e680a8cf84e2e9f9c558df94d9134f744f9439f15f4dd5830e28fa911f653a55f5d367ee45cadcb0bc762a73afb49e3ed3e2f419b80a473bddba65c8bbf0d4ead5a28aa38328ceca6a99c577d075557b48d00e4019e2f1e790ea838d0a5daef7787636ca6a614748b433c90fc14dadbb845822589817b9a29eefcc96b25e258d4e60f1df0ec671e376eeb081485dac054b924b785bb87f940663ea554e100e60db5fcb76954b173ff3d9f1d1bbeb708b6c6b2d80b1ca37b16d63239c055aaf23d5660abd63af3b1b178041500be8c985b6bff832ae87ea56195dfe654347d7eb825e8151267877705f0c9cb54294e60e79073e5eb711bb67bfad6994361578b8db985ca962fbaa6d9fd6191baaccafb5c9fd56254ddfc507c6769a893bd2b0b4e63893dad1286407a333761e23951a3c32d3820e53281f477ff279a90d659c0d691691a7eca07f74dd1bdbe84aa2847236a639731a763a7c44dc3f146d6e071efc2aa5cf577dfd436c6de6547a23128e46b3c1bef912ed518bb986ee81e1e2ccf366f71489de113b6f459ec87a580245affa61a75355869dafbab0f3116cf3fb1876f2a0e1ac48f374a34728e6d269fe9eea34d0cd71d6e3fb36d856b263a645b37b99e671699b500fe46f3eef4289221b3be823554b65e82ea00f509f2af534c10c0a3d0ec74001b36449346d960d2c9b72cedcded1bfdc0222ca1de8ece8bde88a9fd33c7cd0015033454737101569ac4c133f4d5c724f73074af8a805ad6870a384724be56e1e831450836a78b5974c039dab14033ccac64140d3b52cb32d705097f9aedd98413c5056b4556cda85de9d7276e2a2e661bbba6d3475e072ae8a29102cce63be1bd07118f6c623f8e022923f90d07d4f776fb32db522812892c44760ab3d935dd204ede7bc09c58333e156def41ad1321be91d387383ff7ee0f2fcd16f7e792ae2210614fd9e1f5c3a556dcd12348f68b92eb7b89293847c82365106fe9a8e7f4f5e40d1d55c1115766ff48910bc8bbb3ea778f63f55d154bb4e961815eaa345cb8245dab289dd5069e081bd5194555e403d604ae2fb69ede482defda10e81442f26dbf44abb976c0f0015fdbbb8b18acf58a140c899b1dea233d65bbe3356333833118c26327df7a078974c537b15138599e9f2afbdf1254fa0131425bdfda75b553639bde59a9c927442bd2bbdb49459bf779a99dbd3d08b9c69e9ab037496a52a0e46cff1eeb22bd364425fa3cc0380c2d361bbdc9acf47533130913db735a3245741d5bd4b2e9570abdd699a00884d72ee3dd9d841ebdc58f7c43fb5dff5d7dc8b48f746b6dd834893b4f0fe8f731e4c37f82bb7a7f1fc253aebb12d90320dda2b4f09bb1f596f746f1a0cd8fdf65557f485f4cb625c169d1b9f95da476803777fdf19772daa59ab29bd4845eed29a033c4916dbda18688e8e66bccfc0208e0ef8eb333a9c55a960221d4ff4bf6b22d62b5f7b1a1d6d35b7a1c78f5cb8f7a9af98428f3fc08afe87777074abca06074845181c25ba3ff7e472fad4623ebd9ecb6f2ea571d55b1220bbaf2961278fc3e08d54c237fa4a78884b38b130339398ed57634ebc43b91cbe0900f97efe0b6f0862fb162bfab857c2ddaa3209dfe892f02a4a583ab9b6b8d68c0c5f4eaf9f4cb72cf9fdcde0495dd179c8f7b1655078e5e3181d2e4b76a037d5849cac01aec14f279b8b0f3f5d722212f9b20e0f4666667dd790705b7bab5e66fc368fd9c6e03cd79e91703f51e7764c957fd039ee42a12ae2a4b454b75c9a2a9d914d9afe8f2a9ca88f36806de2daa13da17b63b5a3bd059a6ba8f4b78931e79267cd2ea806c6980bb1e09c93592ad0c9968830472b1656f69c1873bf25cfcbd987b2429f364e0ec4b5e5a597786f6195a325ccdb0ee9f68bf7ee63bf493a135c9c5fec3fccbbd710cd3d08f37e3dff979a474f81a2bff60bf3ee54d527ccfb1445ca4a6e636325d3844a3e8da1de6e8fe57f1a5c512d4b23c2561307265c276df2843344dcd5062a05ccb560511916dbfd4f54839fed7e1dd32134ba22e532b784b8c290f700269db7b0748abbce7846860308d16c15f7b075dfa1d279774a991eefd942c2b1714a08a3157c29741b09b45f5508cfacd5c55372f9dbd75a29d0c903416bdbde07161a7fc9ccc049b6bb2632d2d4f5c2f333f17e3591993d55f53a53e36fe765317bc153aca825d101dd1c92fcc6a73d55a1e87d6d35916d6a08ada6f36b6bebd2627ac5ab80088a5ec451f4ce52f19e1dec3d69072624cdce07337d2f9526de2171ff2908ec3389e5d70419fe4756749757dcddaa32719f7589bbc0c49d59cc6daeaea7ef69d1f7b8b887e276ae8e4193cadaf4edcac35cb68be1c8cc42dfa99812bd2e43ef816c6f3dfed3bff0080c8aeef1936da7aa4cb6a64bb60a5d155a5d5b3bb5443bb2bfc1120ecc38fdf8512adb473bcb361d8f2666fb3758f624fcb23783e5af5e7be6773c5608147dd8cf60e95495c9f651976c097d794253b6febd763814e1ddf6b354b49fbd3444ccc7b2e968df49d0137b127dd69ba8fff6eec57fe7911f14e5fc44dda92a13f5675da22e3244ac6d2cafa6374ee6a8ac7d7a323dcc4fd66d94e46036bc106a55927b95ed9ec4dbf426dbb7ac7ff14d8fc0a0e86e3fd976aaea27db1093ed667e23bdbee89710fa8f0632e7715f19c15cc774e7357a560a6519b73111a33595a22b63f46a1d75620533464f492c451b0d1ca1fb7041c976a247041bdd7642b1353796d5cfb49dc77686665335d1af256ca60a485927cbb3b0e7c993dc99e77f76923c575db9a2fdd21db204ee059675952741a38b7c3c75baa21a600580be462f8e5965d9e261334e46c8780d4da50b8f7ab188511f0aa9c14f20429ecb4cccd86c100d94769aa1d06b6d08d2e2712ad42415d6cf85cc624dbc7f8b8e8b6f75d002a10784b3f3d18c332efa49eadcebec696fe579a7b3038662a1f0ec6c2c3213d98e25e2c5d97743c6c2ae6dea2f95f3cf5efcdc473d190ba1e83b7ea99cffc3755f9ff6642c84a29704727ccb458e75ba8bfaf4fa5a5e58b29b4fafa797365bd6ec7e3408a696a9fbd9d7f6f6fd69ba7d91fdee5a9f630bdd42ea633b004cb9841c32d4780653f034bb966dfd39c65ea56e163076cdc99adc4c1c40afab3ed8649627774078cf56028b0679a08e502bd7d90f7de68de9b8062886bd5ca2d1dd9264ba6d4a88d8252c0d38ad712f0d5c8ea97d19c919d62fdbe20685cf81ed4f286c7fd25909998d65e6175a33c3f46a72bf434a086667fe85f4b3831e3b1a8a1ef44be4dca92a43c94f5c28d1698ac67579970363cc24bb0fec3e60eb75134ca01320ce093f610e9e1a40718e994a3814ea2743632735f9523234663bfaa8324f1cb9f0dfb3db738264ee6245af7885d8ad2a2668045984a1493c37e3219ab6b04d5ac6541cbea204fd52164e403f9960090b83a1540a3edfae1e4cdde124443cec49883837f0dd9653e3c18984efe9076fba8a5d606ef0faabe0f4f8fd7675706540488918a69be9f3e96c7665ed4c66dd4f0f7db6d38b49000845e662b05f4df26e57357968b34bd904d6d14951d0aea922c93cb897ad73da79ad71eeb5df57d28ccae45a2471747d9884ed14f52afa3b24956e8a1782b9456593eb9a316149ecfd5721fee06fa717882c8441db71561cfbd1357b5d4df807d235c3c1b0120a07a324169f49146783ef065db36b9bfad3359f3dfd63c5a36b4251cbb6102cbf977c62cea36b42d12bc20401fd4698202ac887212185afc2e3c4065ef1c9e0db7971853ade0f29a6b2ab1864d7d825bcfb8dcdebe805e2947ba5a71e180a76b37606bebd87197e5ffb83ff27be2321c38a5a5ea7d0ad2a7397bd22ca384a5f34975f3b959656d3f9cd75bf48b2c11f7b289cc797adacca004e55a2da1355ed6b7a8dea840e22a8f2c5df46c7defe810841f631e2396f1230ebdbe888b393828b69da908152370036df0925bcdd5608f4114d7b168086797c78f023d04fa72f11c0e8a596774561a8a2986f8d4d28a82706ba6409a7d8a732c02293bd3c81beef8146d24d494dd2aa4eee91e6ebfbf4a29de42320392fa372aca0e68b80f9da019cc54edeeecc5f8586136fc75f7355296246249e8cbc99494fc84a4e97eafdfc1b6e985fef04b2642333f1be75d9e825eab2eff83b0542b3b10229446709091612c5997703c9bbb6e992955404f985677efc6b0238745634e107f24f3c3ef6b098b69d150db7f5f6c4da40267605323faf90b170cf7e8c2e5202688a546b84bfbd2607198ec0ef82411dcac4e2d1be7383442f319aee9d1ef0f24c5849c44861569e25c17848793740a86b9b2e3d49135268e28f5e7fcc432128bace8f429ffef8dffd330f85a068bccdcb56b698b1b9794a3436232e63f30b3d646edb74f604f692c37185ad76b6eef473e771eb35719b6faa36ba3dc7be2c5d4fed9eb5cd5956f4a66d135f99d61a05d83ed5a393b6cdbe3b6fb09e2035b483d9a2a8f3d639348a0b56d7bc6d2c086f52e2ab896c95b19980edb4df3ba79cbc8e8b3a31ab171f7e067e2784060f9d6b7843197df7f4395bafef61ed95328264e8069ee60a662f19dd7834214beb86fb88f9bb41dba478e34b9bc84f3bbd360d94b4cdefb150201823119a9a20100cc32700ea2728503f7195b065383c1b6f4ded3637a85e656f18860f823b28928965c34e00783f091fbb258ded29e1636f99ddb63f70d3273de9daa0e890df069b4e5599eaf288cb06fdb81f36dc091fffcd25248bbd828f2bf878d7e16386e1031ef00ca3c7f3941ecff7408f3b06c4bc90a3ce1b82333397498f5eb757ed013d5e3e71dde31e2440d10d7ef4e85495d1e339173de2488f910d789cce1a96bdf0344abd21dd5d468351eae5180afb7a387a526e7b4db179998e8e0ffefa910bbfa2ddfca4209fe3ace866af286f85f2dfff2f810b42d50fb1a2e5b6dea21914e5e10dfada0fa6873a22e56ff6eaee32fade5528cc83e188a9d0ff9bfd0a35d66976db3be7d14b209589fff391470441fd1e2b1af5ca94405f3cf8cc7b4e0a55ef67455f6fca7442946882c6099e59cea437a66176db746ffc7b93bd7890edd304f2e33b542cd7fbc471bf9bbdfd6f9e66a0a63b7ad174775e050ae625dff977065db05296a62d6eb3edcfb4e022d32543afe31bf5f095808e8744483fe37d673c8f0798122d7bcf76bdce2f9067f7e8bc16109bc3e36e04cf07b5acf1c5216c39a02c60d5b4f702c28cc177027e8d2512e177df9274c8b517b068ef71716d067cfa25f67e4fcd7ed18522eeb065a6f924b7bcf1a2679c37b1167142da26259c75a84788bdca91ce1a287f1e24343ccb5fa434789112ffa2afdb668c1bd90bf3d9ac4f5862cf9b027b7debfbe56f0afcee23d6fd9e9d7e5074d16f53e05bf11bce0b55c759d13e8143175d482f53a43f78fefc837ca88c9c7fd0fed203819203fccd820b8bf19958ffb1ca9da8be77009a7ce2c8859f7d307fab20a10fb3a2e7bcc2c4aa7fac3f73cc53158afe551b006928ca31e47024dceae3e96d7edc87e21c36155f92770900e8144adf9b08b34d111e5eab63805f7b1fcecf5efbfecd1ec70c143de9e7c3e95495bea57128914885d5034e18c081ce6100c5a150d816e44cbb7730a666e1dfc4dca074353aafdec0c88058201145d73d14ddae0efc9dedb9c7eb8dd3eb4584e08037ddc10103afa70e1487c3246c5fd0a5350e7c172e067f12c5e15062162ff73a5c6e343e138884f17ad378bddb8440019576145351f8731663ad63410eb1f0d5d84fe06fbb7e328aa7e8a7a75cfe6cdf6b4ff9103ceb074fffdbe785c71f6445b7797b4ab7aab4a70c63229fb03ae47495a12e112383b75d6dcbd2e7c939bd64f16acaeb6471281cc347b6888f4c157ac87ebccc68242a7491d7dd7d72380ab30f74121887be9de44dec246fe2c5a0dbd28bc1bf29faed7675f0bd6785fe713fcdec85ba21aa21a7d755540fa5900368a7df60a45690872a6cd0eeb2d1bebb0cf545954e96cbdef795bffff62d7feae90050b4e6d7573a55a5a14554e356479cae32d22d040847399560a741eefffc6e3b2b749661da59c24d9e40b78a78ba65e56a8c3782a118ead03131102f625f0c4d52b8dc03d833ff29bb58f290a55bb2b6455f0eab86ff3f6b9b8ef7	2026-06-03 05:12:02.157048	8278744596024971271	10233
152	\\x70726f64756374696f6e3a6d6f62696c655f6170692f66656174757265642f39636537613862352f6c696d69745f35	\\x0011817589f9be0988da41ffffffff789cbd964b6f1b5514c7edaaf278ec38b69b367d108871692805bb77fc88937b1775503bc8246aabd608892cac1bcf1de7a6931977ee4c4c4825366cd820c1274062c116b16289ba61cd928fc0962d4870ee1dbf9226e629167edc3367cee37f7e67ecf3c9edd451096bdce21ed65dbacf5ac5e4233a48e0c4bd36ce594c747dde0fb8e7b68a69c1064f074f13446be354dfe75d66270cbc6071d1f54237e82813c21704731ceef6a27353c7399bbbd4191faf4c6e607e97b901ed311ec317c6e6e0b00f6126710fa8134a83e7f3de241218043d803ca243f7a59f9d40382502affb849fbb1fc749f12494355b15c3a8aa9af5d0e541aba86df6d4313d60bcb71b209cb5f83e7305f42810cef77dcf0abb5115ade2dc3bbed765fea1ba636e87fa5dcf0273f6e1a3bb2584908156d595ccae703bf212c23af4235ac598b2cba6fa0e3dec78bec57c8497b8e88870672c6a87b974c7619689afc115afdba5b20cd5a2aac2c4b99e08265e0bf234910de14c9706ace7f987471a89f11c49b48a0b7729f70f0b0fa308221a17df57ee69f529b66338edd300c43bd2f01c3d603e589b299c5282c33072500d773b4a4de8024ea369c82af27076bc4174198eea134e3408a1f34ccb2d3c96169539dbf51994687568f01e2e6c74037ec01e87fdbee70718b741f8f779b0fb81e7b2ed642bc4bab464ee7dbefcfdcfe64e3381f58fe00a6a15f31b82d3db9b9ef3840654c66d85e4adccbb91df7709528229867d6b9488bc29a381c738127834afbc78d3d22e159dfdd00978df619da72185ee03cec4d4e446d85eb6984dc11370f439f87560657238333c896ded68514e00a71cbac39c5651370a1168e45253271727dce577c2c3a9f52069087e690cfb68d4647ec810c9227c717c39421d2cccb69912731c6719e264251fc375d0511919f8aabadca176c0fcf110c1f3223da0dc91b9a231f22cceca31474db6c94a5bf593275568a5326ec54e54a67a213559bfccb4be4eeac76a26ab88349a37655564ad799dacc377cccf6dc5093165f012047725ae494b58ea9e24841d7ed56dad56272904da94c81cbc323c46e6910c9b4324df4c910b5c230bade2fcdd8d56a3ba61aeab0d9faeec12228b885c3ebec1e4caf4ead695e92a22d74665bf84c892495e36c92b265946a4305aaa669ebc8a48713b46ae83e935c87f030a5a6993d74d72b34dde8042b6bcc1847a726b82601378fbacb2fb6c0a4133329d972652feebaeb7db04d9a95aad5caf1383cf93ca10ba7935a43378831995948ef5b69c4f76f2f4882605ceab72822078a379872cdb891a59b375a3dc5883a1dd81a1250819f3903dc14373e5582a5babd60088c4eaa9346cc9e855191d950d197d0ba2eb5340ec4b20b4291e2c11f100e59fa4e194564ed29103b40696cf06fe808df848bfed0581c386d597c8e2a8c899a8d466a0d206c6cdff8e95e7dffc8aa700b81799be3d8d9559aeb74d82a03d0301253125ae23c54d8324a25a7941603b69b04aa4f11e68bc77dac6c5a4a64931bce5efed5af5dfee9aa9f433a57ef9076150f0ecb325fcfdf94fd74ee802a62f4e937096ab5a370d9e6c069f1befdadcec5db335a3a2349cb16df06a349f01355b7215eae5f51aacc2335885f82fc35d9089322a517592e8fef1a5de843d4b56606851a694cd3f64d630c90a2459210d18eafa1ae4d9843ca9d546b95a8144f14f20d38da9a5db935c2cb69990ff070a0f1f71f9b7a1608c10d12d3105091a4212ff142881b7b330d1fe1125c6ff45c92d98f36f3f2efd30357a14991e9ca4e4cf5c2525306f031e642346f4d90f49393aa9ddd9838378f0a4acc30f67fc4b18d99efce5bcb13d0547526648552674d85aa57a3c49fc2bf9cb6c80aca7251a6228d7be0a84409a353b59678604e46b48f77194ec0f9caa3507	2026-06-03 12:57:08.014116	3053204644125105916	1579
119	\\x70726f64756374696f6e3a6d6f62696c655f6170692f762f70726f6475637473	\\x001104000000000000f0bfffffffff3935643063656330	2026-06-02 15:46:34.428732	-1347409204918588129	195
120	\\x70726f64756374696f6e3a6d6f62696c655f6170692f762f63617465676f72696573	\\x001104000000000000f0bfffffffff3432663234383364	2026-06-02 15:46:34.507233	-411474056052991194	197
108	\\x70726f64756374696f6e3a6d6f62696c655f6170692f62616e6e6572732f61323465663937362f616c6c	\\x00110100a9e3faae87da41ffffffff04085b077b103a076964690a3a0a7469746c6549220954657374063a0645543a106465736372697074696f6e4922077364063b07543a1272656469726563745f6c696e6b49221e68747470733a2f2f7765622e77686174736170702e636f6d2f063b07543a15646973706c61795f6c6f636174696f6e49220e64617368626f617264063b07463a12646973706c61795f6f7264657269063a0e696d6167655f75726c4922018668747470733a2f2f7265732e636c6f7564696e6172792e636f6d2f6466626735717931302f696d6167652f75706c6f61642f635f66696c6c2c665f6175746f2c685f3430302c715f6175746f2c775f3830302f76312f62616e6e6572732f62616e6e65722d74656d702d326465316239366262636166373135633f5f613d4241434a3353444c063b07543a17646973706c61795f73746172745f6461746549220f323032362d30352d3130063b07543a15646973706c61795f656e645f6461746549220f323032362d30362d3130063b07543a0e69735f616374697665543a0f637265617465645f6174492218323032362d30352d31302031343a30373a3039063b07547b103b00690b3b06492208736473063b07543b084922277b7b626173655f75726c7d7d2f6170692f76312f6d6f62696c652f62616e6e657273063b07543b0949222668747470733a2f2f6d6172616c6973616e7468652e636f6d2f637573746f6d6572063b07543b0a400a3b0b69073b0c4922018668747470733a2f2f7265732e636c6f7564696e6172792e636f6d2f6466626735717931302f696d6167652f75706c6f61642f635f66696c6c2c665f6175746f2c685f3430302c715f6175746f2c775f3830302f76312f62616e6e6572732f62616e6e65722d74656d702d316366663131306661636334643336363f5f613d4241434a3353444c063b07543b0d49220f323032362d30352d3130063b07543b0e49220f323032362d30362d3130063b07543b0f543b10492218323032362d30352d31302031343a31363a3431063b0754	2026-06-02 10:48:03.985925	-2878576828447152086	947
109	\\x70726f64756374696f6e3a6d6f62696c655f6170692f63617465676f726965732f3362366135333265	\\x0011811fd897cfad87da41ffffffff789ce555cb721b45144d5294e34785323654b6b7bc6025eb6529b2a462118a38c885e35072ca0416ae56cf1d4dc34cf7a4bbc78ac8c61fc11236142b3ecb05ffc1e919c98f60d8b162a5d1e8deee73cf3de7e883d5efd6df6d0c1eaa487d3458d322e3d1cee32f84b273fa940e84cde8c0b24b56062bcf4e069b113b6955ee95d1a39dfb7f3ef57424ac48158d85f609d768c634b14a4f696e0aca0b8b57310ed98dc3211495e7e6d64485f48e9c29ace488226559fa744eb13519795b388fb7a991222dbbd9ba3a1d1776d16f859e322947d69850a8347a44a4022a7464ec1313b91ab1764589450b5f00257981836b94a86942baf0b6eca891d011fdc8d6903419b065ca31194d6f0a0ce6e7f595e1c393c1872a13533e2b6c8ab97f4bbccfdda0d1c8cae15d397b1ddd0d2b54ea1a427a75ce67ce1b8ba6c6243513d7b05c8dd9e0f9612cb3837cf2e5913ad64e7dfbfca0f97a3c7a7274f2ca8df4e72da9464f46d9a19bb40f6371fab58abf697eb6bbdbebb73ba215b5e36eabdbe9c5729f9bed6e578a7dee772742f67b1d8ef7e249a76195e47aaea725eced25d767d214daabd5c156a45c9e8af999b1115b75efddc6f09eda1cae8c76b6abadbf5c7484fee1eaff6acbc3b5e6705d6d0d3716b47c1c68f9e43996aa1ddc70a4d294af8979d07ef07766302bbddf801bf129038c8a3647de4c819f2d4961392e52b0b2a4c97991a7fc4f63c7c644248b14a3721dd60493981b6aa3b0773a1756b1571c6ea88667ed77f15342d9024caa7e40b198aa1a7d6f66c256ccc4e6ad877641e7395f2f2fd0ef3860079299f2090954cac2dd60ae6c1705a681be64a0f2d1faa3f5f19d4b0f6b761549d38aa4d0bc44062a50c65cd526a80533e48a0928d192abe2426bc6b31315caf008466fc82048127772e0a4640b0c2a9c9e19e7af34121b9bd5e934a996806f41744099b148319cbdc5394e533903378ae764e2182d826689c19a4cc625ac89480346b024e625f79851c10bf3306b2c3062c5cbb5cc76af64b61564f6f8c502da78c6ec59c30d4ba10d2f2f7e7ea517c3e28acb8b5fab645e921c5ebc30f4348af0655c4c85bdbcf885aaab60e0dfffa3b87afd2f7125facd76abd76f757bdd562491575274782fe6de7edcee44b2dddb6bb6b8dd948d738613c404542e430bdcac5d71b31db8593f1e7d35a62bdffd71ffce448ae13233c366e028a5c32ac2f6735b296429162c5178c27d3a72b7b63c532e82ec4a95e761e5c8077e8b8acab89e65a2d59b82172165c05ca9d8ca2a0b7f98c2430ef33bc47b43a1a58c2c673000c99405c2c989986b0b7d8b08f6662be0b95232cf4a4746d6e461b260461732174ebbbcf8e9da2f32e14c214b71d38d97467b882f44c43203cb30c0cd4b2b4cc1920631b04318bdccf16516016dd0019c5d996f9156b78c776b11741a387f692ba11e078e224ea12e7b2b226aef0773f96f105055f15338be11c89b410d7f01ebed0620	2026-06-02 10:48:06.416381	1327148808651136229	1265
110	\\x70726f64756374696f6e3a6d6f62696c655f6170692f66656174757265642f36633563306262632f6c696d69745f35	\\x001181afba99d0ad87da41ffffffff789cbd964b6f1b5514c7edaaf278ec38b69b367d108871692805bb77fc88937b1775503bc8246aabd608892cac1bcf1de7a6931977ee4c4c4825366cd820c1274062c116b16289ba61cd928fc0962d4870ee1dbf9226e629167edc3367cee37f7e67ecf3c9edd451096bdce21ed65dbacf5ac5e4233a48e0c4bd36ce594c747dde0fb8e7b68a69c1064f074f13446be354dfe75d66270cbc6071d1f54237e82813c21704731ceef6a27353c7399bbbd4191faf4c6e607e97b901ed311ec317c6e6e0b00f6126710fa8134a83e7f3de241218043d803ca243f7a59f9d40382502affb849fbb1fc749f12494355b15c3a8aa9af5d0e541aba86df6d4313d60bcb71b209cb5f83e7305f42810cef77dcf0abb5115ade2dc3bbed765fea1ba636e87fa5dcf0273f6e1a3bb2584908156d595ccae703bf212c23af4235ac598b2cba6fa0e3dec78bec57c8497b8e88870672c6a87b974c7619689afc115afdba5b20cd5a2aac2c4b99e08265e0bf234910de14c9706ace7f987471a89f11c49b48a0b7729f70f0b0fa308221a17df57ee69f529b66338edd300c43bd2f01c3d603e589b299c5282c33072500d773b4a4de8024ea369c82af27076bc4174198eea134e3408a1f34ccb2d3c96169539dbf51994687568f01e2e6c74037ec01e87fdbee70718b741f8f779b0fb81e7b2ed642bc4bab464ee7dbefcfdcfe64e3381f58fe00a6a15f31b82d3db9b9ef3840654c66d85e4adccbb91df7709528229867d6b9488bc29a381c738127834afbc78d3d22e159dfdd00978df619da72185ee03cec4d4e446d85eb6984dc11370f439f87560657238333c896ded68514e00a71cbac39c5651370a1168e45253271727dce577c2c3a9f52069087e690cfb68d4647ec810c9227c717c39421d2cccb69912731c6719e264251fc375d0511919f8aabadca176c0fcf110c1f3223da0dc91b9a231f22cceca31474db6c94a5bf593275568a5326ec54e54a67a213559bfccb4be4eeac76a26ab88349a37655564ad799dacc377cccf6dc5093165f012047725ae494b58ea9e24841d7ed56dad56272904da94c81cbc323c46e6910c9b4324df4c910b5c230bade2fcdd8d56a3ba61aeab0d9faeec12228b885c3ebec1e4caf4ead695e92a22d74665bf84c892495e36c92b265946a4305aaa669ebc8a48713b46ae83e935c87f030a5a6993d74d72b34dde8042b6bcc1847a726b82601378fbacb2fb6c0a4133329d972652feebaeb7db04d9a95aad5caf1383cf93ca10ba7935a43378831995948ef5b69c4f76f2f4882605ceab72822078a379872cdb891a59b375a3dc5883a1dd81a1250819f3903dc14373e5582a5babd60088c4eaa9346cc9e855191d950d197d0ba2eb5340ec4b20b4291e2c11f100e59fa4e194564ed29103b40696cf06fe808df848bfed0581c386d597c8e2a8c899a8d466a0d206c6cdff8e95e7dffc8aa700b81799be3d8d9559aeb74d82a03d0301253125ae23c54d8324a25a7941603b69b04aa4f11e68bc77dac6c5a4a64931bce5efed5af5dfee9aa9f433a57ef9076150f0ecb325fcfdf94fd74ee802a62f4e937096ab5a370d9e6c069f1befdadcec5db335a3a2349cb16df06a349f01355b7215eae5f51aacc2335885f82fc35d9089322a517592e8fef1a5de843d4b56606851a694cd3f64d630c90a2459210d18eafa1ae4d9843ca9d546b95a8144f14f20d38da9a5db935c2cb69990ff070a0f1f71f9b7a1608c10d12d3105091a4212ff142881b7b330d1fe1125c6ff45c92d98f36f3f2efd30357a14991e9ca4e4cf5c2525306f031e642346f4d90f49393aa9ddd9838378f0a4acc30f67fc4b18d99efce5bcb13d0547526648552674d85aa57a3c49fc2bf9cb6c80aca7251a6228d7be0a84409a353b59678604e46b48f77194ec0f9caa3507	2026-06-02 10:48:10.446297	-4585073475482385725	1579
111	\\x70726f64756374696f6e3a6d6f62696c655f6170692f70726f64756374732f36633563306262632f6331376664353266653063333661643866643361393931656266366633363232	\\x00118161bb0ed4ad87da41ffffffff789ced9c7b8c24477dc7ef0eb2773b7b7b0f9f6d6c305cb1c0e60ef631b333b38f19c03bfb98ddc9ed3dd89df5e13b6055d35d33d36c4ff7b81fb737388a2c8412e4988731210a31b2424c0c449102b21022e05849f8230845224188a0489853944896a2584a2414297fe4fbabeaeee9999d7d787d2208ce3adfcdd454775755d7ef53df5ffd7eddaf3ff6e8d1dc5d4dc7d67dcd733774eef1ebf73f3a9a3b6ae8c683b97e8b374469e8feb9c2dafac54279b934ba5a9a5f64d75317963ed897eb5b2ce74ee9c2d51ca3e919b6551a3afc17b71e7bfa8a70aa42f358859bdcd204b3abcce3ae2718b7745617dcf4eaec95679e78e1d6d35f1e4cac1956cd14ac699b865b173a0e721bdc339863e0c85b8f3dc52cdb639e6d33345113ae2bf491a8c8e15b638389c1c48a6dd54618776c3a526335871b96cbbc3af79866db9bac6afad56a8b891bc26931cf68085cfe13dff9cf6f7eaa2f7fac9c4b34e95ad5c4c4d8b498c89dd10d57b37dcbdb90c5c9dc5dae304d34527d9f4de44e550d8b9bd1d7fbda0708471396c76bc23894bb2b2af65a4d9ca67dde1bdcf4a9c0768c5afb4c2870f90d5cc7dde00daa57ed4be612ae676b9b467fee98bbe997864e2cad160ad9f47c2a2b1bdeef5b86571a3a7aa126bf0e6c09a356c771a9dc491d9db45cdc12b7347448fe7a3ab8c5b239a5a1e34b349c4e4bfe76bcc21dcdd6517cf2caeac26812ff65a7e52f8375d7daa09f92b97e742c3a1bf5ae69f2d686ede8c249e61e30dc0dd7af4433614358bc620abd987b237eb1358d5363645f652b8ab95335d70b6b957367e85b7bfcaafd99b19999dca0c63d51b39dd6a347f37dc6ddf9a3a5a17b96d4cd1d66170dd3149eab6ea1d1c051c9dc80fcd7bd7e2837e0602a5835ccede31cb71da5b303b984bc01b839a7d028c3da90a38bcee05b7877a8c9a7f1ddb4b7c29f4fcb7ff18d7b3e06e0c48abdc5d6a8485efaa4e608b452dfe0de7a8e1534cfb821d6fc66d376bc5cae8cdb70d5f0ead76c4b5c3f56f273fd5432f8c4a7cfbef8d4ef579eeecbf57f04bf244b43a70baec1c72fd8e626ec8fce5bf2f3a3839f51f5dede971f4be64efa4d3dbc507e84ce861ad1995063f681ed073d50e7ee46c3373da3698a8d477c8eee7b86708bed3b18cee337e8a2ca5113f3d331506fc3d093b9c1e00b86f4d151dc8387e81ebc69eee1c24261a9c4e6974b2b2b25d020995cbaf8416a76bebf3474e48523b06c56a469ecb20bdcb1d0a74dcee854c26b91e97f03b63798a05a0b42349903bbd76cd3f61d69f1c2aa13375c8626d6196f360577a8401d41c3ef36d1e61156c77c8771f31b74e4b00280aa1422a86a3b8cfb5e1dd30a6058b3f191952c1d5d9264c00c217ea0455f6397707b1d6e9a2de6fad6a88eb6ea68cd17d9251b27f68caaa119dc0c9aa90efacc57d9d57a8bcdd76ddb156caec5755e33f01513d37890aaa4c6c2b3b279d5bd3954f5848331f8ecf3838925cc159748578f0f816733cd77707d9ae55addf72cd1720713688725504b76a9578326c6c82674b64683c356403bb33dd62b40276bfa560d2331c21ab623c2811b4cc407abca1b0686203638e931b64a2d2cd0e81238bf3e98580cef90e23a00eff20620320224e313da0d06df400fe8049931b64c37ea7d3e370ddcffb2c375c39338600fb5e7c40b580bd01c8dba884b45e3e9881aeab273d1443aaf465f029ccd09d763eb581558d14657d66433707dd98ec1c4bc1a3e14346dddc0770c6c8b35f0a3c9d1b865bb211a5c171866ba69a8b4059cc9899ca8e2f66141c80f24f3c76787f383f8ff8471287f32993f95cc9f4ee6ef9a1dc89f31faf3772b2e6767669285823cf49e88c9f97b93f93704ccccdfd749ddfcfd31dc4ea764d11b93f93785d51f48e6df5cccbfa5983f5bceb36a7f762c99cabf3504e1ec3df9a164fe6dd70fe5df8ea277a029c368db6f96f3e78af9f3e5fc3bbb31957f579b199f0420aefdf867b762ccf8ac2afa3015e5c7f75f3559cca7302e13c97c3a00c4d59e8098b803883b80f89503c4b14c723a3f501d484f4f8d4d66408907418907f327fcdcc939a3b62034a811f3646a3a971ccbcccc8854fe242cbe2d72e4590296407d26c7d293004a2204cad4642a3b593c305026f6004a5f763f3429ef49934f81077ff91b1f39d1850814fd6e374df6aa2a69f2de384dc689266f98bf3c7ff9d27a995d2ead406bac9457db24f9f9e18b307ddc98358894ba60576d5b67571ce927c0a434dbf23d76d93099e132cde155e827e6bb98b8cc8b4d327113df34fac21ac2abdb3a2adb8d8a61a1f616e41b7c0fdc4c9870c390ae0059208a5ce1dc10ccf05c660546dcf41d9ac0e4e748d6c0e068f2c8e9aa7147547d898f60166baa7dee085c15b4cf56cdac3a2238a2ce9d068e6024ac3d694e7072746af50df9d1a253602a35e04550e3a52f447253b64952236c58150a5822521ee5366c1bb53cf4db778049c3a30b3763561e98f708ccd6f7fef62bf2231d191f351a93a670c758c963dc746d26c7c3651c7f1834b78b46c1b3a36ed129754edcf05d5cafe2e084348e1179316a23c1e8a90b591823c01d5e0cda6661bc5b443ed3a8c29c5ba6180bd7e8c9b16cb8465f83f55debb5461f932685d9939a5c584ca643934aac185e60cbfbb5aacc1e56355b0a8cea0c4ddc042eb9c664ad21b8c61faf7b5ed3cd8d8f63e68c6980b28efbe6b4c630d5c6f56aa5967da4954a8e4b0f66dc6f9a36d7c7b58d2a66dc48750303658fd4372693c99147d497ad8de96472fc466a3c74ddc30fa39e683447a7ab696d663a55d1ab335caf24671edce0ef992bccff567a6d6145b6e86dd7fb7ee9daf4eab58cf1f8d9173ff1c4bdef8d21c55245dfe8a60f95ffcf19fb7db1aaae2afafb367daec5e9b316d0e72a9b5b2f971757d9f56ca78ef96fa963da265e9860ba700d58cf16a16253498dd8720603c0baa88f62d176082ee7e60c13e50175ce07d244daa456170d43e3e6a8e4c130d65da7419fddbaaa454b2e6ac1f96cb4424b56b00a6d3e503ba17a8990c5253f22e912024516c0937b47788248c35cc0fa38272c51055602d522177cc362cb7237a7052d07e2bcf2cc731fc70aab9c5f172a4d38b556b73543d410a389083639e626f8e639c2aa79f540a34809e4b252a341fb1bb4f47fe6ab58988974e4f957b937eadaa65f015b6e18927e2e3b5718610b236c71845d381f6b42c5d65bb71efba336a0e1e30acb15816c895ab260d4c015e23fc6eaaf07139db76cd3b2b72c62bed1c07c06f26b5854d43e16940e775bf49b2e4fc1b6c033a2b2eb37707f31420d1b8241e239903a51e3d64058dcd82513b3456e858552b01e0c6a9506b52ecc66387eccc5217171b38c4371ed75ea91047fddf6d4ce193ae5d81e04cd1aee3ad719baa6db2e67e39858bcc9e99782aecb8673c567b95e48b93698c00915c62b1c9fe8d706a7f580d5ea4284ea673204af07f07abb3a478574662175602d3335bd4feade06c7e807dffd7e2e4688a754d1d77b3946bb559530f1e2307927c1e4be85c5b5d24e3479f0081c0fdfac099a362466e88e5824cb219f3b650e40532414b039dfc31a3612691ba51b20a6471f09c4347128521cf267c3a2b96a91ef0550b98146c135dd065963857b600ff4052db81579fe4096b8004e60486a912639438d6b3b50d26570622b3c966dd997c80f882b887aa8ae31bb3601462960a0de9adc099517a926792dfa06ef0c9f5b7111249553d04a472842c415998420648c5df5da7a479eaf6e9bc24503580d1490c37cebb1cf768820b95fac73295a76543fb2c95cdb54d62e341b903684a59b10321503c60fdda5d32e276ba216af4929b525404797884d5bd91ff6018e403ae21c5bb46f4de326383c31f40dd7729b408a5131cca04e1d73d8f024da7461622830608126c2b4dbdd2afba4552e144a8bc54cba387550ab4c4fedd32a4fcb6574811b0eb95945ac636af2feff08233d9d9d9899cc4ccd4c66f58cced3bf0cc268cf36bd7a96d5216d7ef6e41f7fb74b18a1e86237cb1a28ffd39fdcfa61973042d1077660d9bbe98ebe51b28cd4d1d2f2e222bb9e4e262faeb469f6c3c3a463d802e9a125ac1a72e3469286701077f1afc2c2b0febdf2cc973e46c6341f4719d5950403391ac64d14c73456c0285a931470dc08377174b6e9146cec84068fb5186b6f24c6b6fb85a1331877f702a0489e05ae8aef3946e47f2dd9a60e09605872e385363c02a914a2910e692a6074c8b54aa0b0248624d6f027c20375722434f9362b54480b7488a44be76e8d72ba226feea567bffad2973efad2b34fbff4ec0baa258452ea3531c782eee2660d032547d8b37d520481ebd580287123b72bddde1a3dfc0c4083bf246976dce090e41908c933975a9c492df672c4664fec8f3ed9ec3ee9738ae6ea19459f2b81f529f2ec2e13064b566fcbb23f79f6c59f9f17e598b978aae8fbbd363c1effaf4376d786078afebd6d5918ba986959d4dc63baab87867434f898a81ecd648311ff268df8377bb1fd6838c253e9427126dd8bedc9ddc63595dc6d5c8b79966c0febece12f1f5c6bcd3e79f6c54f4ed47f3b36344555f4faee51dcab6ab29c4f551399cc58369b9f304e60288f3e7a2f9a78229730794598a5a1fe140b0700f3ab3d1eb9d315bfd50eed6248697073f744a1da303ed97362cf9ec8dd1dd50c62b6fdc9b14c3677b7a8920562590ecffc3dda71cbe44e529833ac9a1a9b9acedd2f2b6c10f29c280889fab9bbf90dd82e5d5ec5218dbedc498a53aa205d19c32c3b79329f45ff26a2fe55fb26e2377cb27a349dc91faff64de6a78ad48b43a1514e27f333b3877f4ced4ae773d4f0d4743e4f25ef866e7f4f912e4013729926e4d962e9d21224ebc5d2caca62998db255dadd57590021f0ef7bdd2aedc6d24696a5941eb1db2669636f0149be19e838081629a974b99d26403c802cb6f30efe35b7212c822c30f7e4efedc7359de7a666f80dd4ffb3e7071397db6daa909fd634a1a447c9bdd1a131554da592719e250ae9ca8b57d0172c339b864e7bed026877cc56e0a72eded404da6fa99a5765f09dadd824243fff39b9a72e77b5ab4605da745388a65a9ea46886d75f13ce6062550048f0bdc9151632621db8a60b06a62ed6acd162a026d18faf7c8b521db658cd6c69b439404a5edcc465e022ba722bd0b1b18e98e4d5ba7e8d3bcca43dfe708f3df0ab17955b3e0cbb546e77e06087e3663836b9a572c0d139b7db1bae615a5bb2cbaeda7aa4d3677771a64bca6b76f7749b9b91f2c7b8d25927c762419725d3f78485f11094bef1c4d7682fbfaa9cd39afc49ee139a228804a97b888b098a0aa0cd74355c867b3b39d072fa367c1d12e55c4c059c0f7e09dc67e5555fb11dc7d0e1aa9da3eb07d383c37bf3dcb03e9c298fe990259ba1c34c210005f09f12c07fda0be0d1f67f616a6e3e35bf0de0fb5d1f27f752e7676e8fcffc09ac67e28181f9ae040414fd5537c7f7aaaa56c39fc657c3d21df8dc81cf1df8bc76f8905ded1b3dd985f4cce2ccc1d1b3d776dd6d44cffa2bf72c76f10445dfe9859eddaaf640cf0542cfdb8b97df5f2e9456daecb95478a8706971dbdedd5b5f57b46f7a804580952e1249ab8fb693822ab1e9215d4c1282c08f49a63c1231c70f227ded80da5e0cbaddd63b11dbb37e6da0f12d4b500e27872fa6392adbb17b2b7e5970c70be20aecd6179e559790cd74e4695885839a72f70ee3679bb1edfe30a0a0714737ec1bdcd57c135d09cd5e8228024237294204e986f0a881b247b41d69376c4fb8d1ae3c81a4ea5b5ab8a59fdd0eb7aed0c59598b78f8b7bc2b04642d28161d4660cc38568ecb8a69051776cbf26373d690e61e604587a95300a63345d38926182e1dda9a4722c55d57300a4c9f161ab0e775d968136ebcd0681e90aee34458c1614a74aba69d046b2472378a18e91d58dfd83280a1ba452d94c267360104d257f317103a2cb1fd61ad7bae882a27fec05a2ddaaf6001127100d2d91065a597918085a5b5c2b5c5c54d910d9ce4db71fc980a44c8268064910e7b4bad8dcf4cfc7921cda0144b59b8559a05396557ceb2bcafda1aaeb9603c05832dfe9a9689b3ddcb88a2dd63b842fe341c8ce78230ae4a9690f8abe17a2bd3adbd8350019c7442be24468c33549130a9f6161c4e9ec9b86ce650b2356c4081226aa07b06b0bb02042b7cc0d4745e864325a4730b3539e4861a9c265a05c8decab4e0753142300dd8efcb91046195dd5c40ec57235265cd1a642cb776e081dc314cbc302dc0ae8eb68c9c2cd6b34b867ab2d2fe8594af90d60d4815270829060e243704c00b59db2a77ae4c7b173c26d0a4a354303e3538892f30429922b86b6697625ab954503ed92877b5c97395bed4e51bc6558268e347d9970136e3b4e8c65c26dc72343870110fa7b4782c042a63253c5e99e1b8dfb8c72ccec95f171a69df1315b39384368abf0e863d9cfc5c0f007aae82dbd761577ab2a1942031383c8870822f72fad5e5ebfb410a552653b52a99edcce8e6dcc90fbe5d183189d340829d0996719c6b46b6a5b3cc8601c56bbe21d90010a4268b8f488470486881e710c7d5172467e286fdbb1bf1de0387771bd58381fda4b835b64ce71687408a4d560142e45a3a08c7a1edd1edf8a8fa96a61144f70a31c86c1c49c90614caf0ee30a7b0a23082592d4596b0d7b5360b985e5528ee897e0e1e82288e077d9e530ab3aad361b22f094652836b0f058aa6698270bcd1aa4978e44068b93b916648cbb0b1c16e2b186d8d53ba0a1a010e55dba41e265a7a317065703b3ef4f4d4d64f303f877722a4ba69f93a68fbf4ff8f9cc0999603911e45726aa1425529b9cd56359144a281c79cfe1c8c3c1dc5f9c9c9e9e9a780d58989ed97f22d8ce58d85f76e57f0c7eeb77ba6c1d457dbdb0b05b558585990e2c5c232cbc63b974b1b05278b8c0e6571f5e2b1756d8eae5f90b6cadb052eeda65f9e7237193c6d06c32971c4d19aa5ba66c57dea2b9cb21fbdd6ee930dcad09221142e90e0e29cbb61896795586a9470907f242ad303fa52d272aa6e05a3d940fdbf4858484e6b428b0e5ee67e3e662d084c87e83aca3ce0632d3d8a467d6d01cd7f01b23e043cd12f4b18737421b0a146e0cd39b9495173ad5f8aaa8495f658dc6f395679efb6898911dc1b6030b9ecc28a0318148a75ced7098402812eb1d0997013fa2862db77495914492e0b936e20cd957264ca1913bd8f2445c1991bca0ad860eddf2b59e0a28962aa587b57772313aa91139194e301ed44550b864d1272e773a5cc15d5b2d0c0bc2b36faa7d0e105b3a585b945fb0c5698887c1e8866d9d57f94c447787dc5ec7a5ec28cdf1e9d90157e6cc8b30c6762c254933904a4d8f29d6ac4bd6ac2bd61c9f016ab2bb6772f74f8ee11c678ce3a117333d353d37973a7022f77e039dfbcae3de31aa49f4f8def3a30f75852a51f40fbd40b35b55059a720768ae13688623d048c0ccaf4ad828ce74eda7dc21cd1dd2fc8a93668aa241d5c4e4e4583645a0694ad0341568f6f9d4487f1a75c09a93216b268ae96461eec0ac99fc85b1c6ff41fe7a174050f44fbd58937d57e9435d5551f4a3186bec0ed67c40eedc76b24642e6cae5ab0b94777947d3dc21cdaf0f69e4521c4a9a4922cde392348fbf3ad240d564409a132169e6b2d9747afbdeec7e49b3dfe4d1d74e9ab3c69ade850f14fd4b2fd2ec56b597aaf9600f55d3419a3baae60e6b7ebd5883a57840aa9883299ad923eee1b89e494d16e616b207a6cc6d8944ef8b32e3ffe61a5de840d1cf7a5166b7aabdf4ccc344997b972f5f5a7c98ad16ae6e0bfa1c7e1d59bb7c72cbe15bb86bbe5535c83a841eedacd6557e87dc570d4c424e00c990ae788eb03ed26ac8edfaaec84eb96e689bb1f7ec0c8787d033ad5b427871b0a82872c3b8b93b5beab6255abb81a5f7d360216e3a833bca10658855f318af51b7e8f151998c695b2141420007f15af55039bbf5f93f194cbccf4717d593b500a3153ec356a146441bb4dd81d48029b2c7dde16cda00c640cd5324176d7ff639da0fb5bd3a85fceb8e4da1d779bb012b8b4577e8b1189cb521f4f603f2117cbac346aacfbd9e4c93b469e0e656e8dd4a8d20561dc4b4ae06505571adf5306e5533ed2dba61ea41b3f8036954da8c82493bd12815e4a22b769e138d266e99eb61c268f5f3144fbec976a04cf43c9a27f84890f34fa17ba742a12449a8e8b9b4684da34947b7288c0f65da4f031ff9b6a4cfb77bc68706255f2e15cae9894ca6983c305f32fb543177c94760c2e15c0b9bfdda12d189252fa79f2c76b104452ff4c2ce6e551576bedd819df7539bdfacb0b30685b3c2e6e4731ea96c87a6f95fa96930cd69d50b1fdb504f929d733df9722fd73dcf2a4246203ffd850e94e8dcd9a418a951ab63ba400fc898aa8c346105c58c231bd0e825594cbe352b005640b9686ddf35bebc0d44923b98ec14bdd8133f57c2f4c10840ed3774ec05a2aacc9569e3a78dcb30d2bc0b257ac882ed68e84489e4961186791ca191826a75ab97c51605572506c22c9b0801edd032574fc0a1ae8a5d776286f02059b1a3b0d929f5ee52f4202e298f20d41da069172e972c7a038217f2387c18300a18ee8f47f8d041a4de40a2f0bd7c785b3d511b27904452fc1604b267788fb7041d0d79939a4c4e4d6ce7cd7e335aa6d3fb07ceec91bf3bfcdae2d13f797e24dd450c14fd792fb8ec5675fb4b82e6082d779716564a2cf63ac1802887ff55da7fd76b01e3a1e6465cb077679fc49277e9a1cf91f0e57f866e1a419da2701a32464b9e85cab4550bbb63c8c483e0395155799e74c0080b1fa70dde2dd8fd786844a07814533df32aa7170f0cc0a0f82e3d5715ae58a9b154b462bd2c57ac977bae58ede4cc99646666f1c03368728f174dddae9c287a31dddadffcf8eb5d894e28ca75cf9fbdaaaac5e9e57071ca9df2e0379a1bea5d7e13ff07375b41c0	2026-06-02 10:48:22.574906	-8112077434866331959	6654
113	\\x70726f64756374696f6e3a6d6f62696c655f6170692f70726f647563742f36633563306262632f313036	\\x001181a8d4a7efad87da41ffffffff789cbd56cd6f1b4514774a657b9df82b699a361462dcef16a763c74e9a998b0389cbd21655ad11881cacb177361ebad9757776ed3a411c7a4542d05b250e5c38710071027189e07fe0c6851bff00170ef066d61f9b340d1142c8f2c7bc79fbe6bddfeff7c6ef647c17e11837b883359b6e333d1fbf4f7b511cdda8e38cc144cbe51d8f3bb69e9f14acf7a8f7284a62759ce8b8bcc5cc6811cf185cb41cdff61aca84f0b46096c5edad605d8de38cc96d6a8d9667c60f30b7c56c8f6e311ec1d323b3d7ef409871dc2eb57c69705cbe358e040641bb708e68d06de96746114e08cf693de427de99c071f1d097391ba5627149e5acf936f7f47cecf6965a4ef618df6a7b08a70dbecd6c01350a84b31dd731fc5690859e9fbae53a2de6f6d513534deab61c03cce97bf7d70b08a1225a563bc9b6b01b720b610dea117a3ea2ecb2a88e45fb0dc735988bf0392e1ac26f8e406d309b362d66d4f03cec38ad169569a8125516359cd912ded86b46aec6b0219c6c518f6d396e7f3746223c43a27a7e669d72b79fbb174410015d7c5bb94faa6fb119c1932ef500bcdd189ea25de682b5aae184021cc8c84036dc6e2834a10a580dd9905964616d39bd601b96ea1b56d4f3a1f2a46ee71e488b3a39dd7219a46834a8f72eceadb53cde650ffc4ec7713d8ceb00fc7bdc6b7fe0d86c33aefb589396e4c6e70b7bbfd79ad528d6766007e9f9ec9ae0f4c66dc77a483d2ae3ea3e793df976e0f77d94148045bf630c0f22d76534f01845028feadcf30f9d6b53d1d8f62d8f772cd678e453a8dee34c84981bca76ce6026054f90a3cbc1af012d93c1c9c14a6cc6764f4b0670c2a24d66e979ad980b844666ab71726aacbb6cd3ef87da834c42f0d991d8875493d44043248df0a9d1762075b030d3640acc519c05889396fa18b483861651119f55db0d6a7acc1d91089ea76897724b9e15d0c8d3382d690e8aac934b75554f962c4129a5512966b414aa859465fef2a4d55552d99733594664a57a5966456e56f364157e637ee2ce042135088e675d6629ba064a179b89dd021c684b09c70d61a83871386af0533363e50a4920c0ab40a6e09de4119242f2a80c22d9aa46a6798ccce8f9d4fa9abeb2b4565b555d1fce761691d388ccedef6a7226dcce15653a8bc8fcb0949711395723afd4c8ab35b28048eec84623af2192df8c90f3e0750152ba08395eaa93cb3572a54eae426e779cdeb839c8b5b152ab20cb4f4bed8f424aad05a693d244168fef7aa34e90992897172b1552e429521a6833a5b87c812c81ca8282b6529734a6c7974c4028382f4ba28183956a952c98d132b9696ac5c5959bc06d15b88d1232924dfa806caa17f71d65c696caa09be8f2a1a2b92ba32fc9e868b128a3df85e85aa01ba591b6445fdb79fc78672812edf1ce60a141a24a24711049fc30919cc0134399bcb9bebc5259394c26c39c8e100b5a5d3db658aae523945193cad8776b86857109a8fdebfc830b21b6af07a62f0e0a43bafee83cbb72c0154c5f06c2a811049814114822a290dc9648c642cd6688018a85e75aed10511c6cbd0cf46dcf7059cfedb121aa936f389e67b1810e0ac782b688ca47405b874be5d631b13d46d7fdf4ed9f3884d84660faeeb0ae3bca55815b0883bb22c1cdd699f072834beeb93bed9fc5facb4b12d874694918ea25fead5a2be8ff50eb579f2ceca5fe78ff4908a5af0353e220a0ecb385bdf4b3b9db21d70f03d3cf2f50ebb2ea7b09e808c881ce34335e64a500cb89a700267c1c866659b57eac74e85fc371502c1fd5f375797155fe131ccf03681f5bf34f43e05c0d4cf30771bc00f66f7e5ddc0bb95e0b4c6f8d71043c0220f194cbba9cf5e40c386d300b2608b70fb39ee9ecc2683e1e0a2c07264b39126f02e6a935cbcae9b6c1d5ec85e780011824e5bff730829e3fbd54a8e49abee036132267d07e3079ce8a36ef74e4bcd36a5317664f3dbf507319cb0ded39da74ba2cf7db931f2a4849f46f58d75cd3	2026-06-02 10:50:14.741385	-5923477783437014192	1633
160	\\x70726f64756374696f6e3a6d6f62696c655f6170692f70726f647563742f38386330646566322f313036	\\x001181cfe1a1971388da41ffffffff789cbd56cd6f1b4514774a657b9d0fdb49d3b4a160e37eb7381d3b76d2cc5c1c485c96b6a86a8d40e4608d7767e3a19b5d776737ae13c4a1572404bd55e2c08513071027109708fe076e5cb8f10f70e1006f66fdb149d31021842c7fcc9bb76fdefbfd7e6ffc4e2677114e7093bb5873e816d30bc9fbb41bc7f1f506ce984c181eeff8dc75f4c2b860dd47dd47719268e054c7e306b3e2253c637261b881e3379509e169c16c9b3b9be1ba96c4198b3bd41e2ecf8c1e609ec11c9f6e321ec3d343b3dfeb409851dc6d6a07d2e07a7c7314090c826ec339a249b7a49f154738257cd778c84fbc338693e261207336cba5d2a2ca590b1ceeeb85c4ed4db51cef32bed9f6114e9b7c8b39026a1408673b9e6b064698855e98b8e5b906f37aea898916f50cd70473fadefdb52242a88496d4ce645b384db985b006f508bd1053765954c7a6bda6eb99cc43f81c174d11b486a03699435b3633eb781e765cc3a0320d55a2caa28e339bc21f79cdc8d5083684270deab34dd7ebed26488c67485c2fccac51eef5f2f7c20822a48b6f29f771f52d366278dca33e80b79bc013749b7960ad6938a500073232900d779a0a4da80256033664165958db6e37dc86a5fa8615f503a87c5277f20fa4459d9c363c06299a4deabf8bf3ab86cfb7d983a0d3713d1fe30600ff1ef7db1fb80edb48ea01d6a46572fdf3dcdeeff5562d8eb51dd8417a21bb2a38bd71dbb51f529fcab87a405e9f7c3bf4fb3e4e8ac062d031070791eb321a780c2381476deef987ceb5a9686e05b6cf3b366b3e0a2854ef732622cc0d643b67328b8227c8d1e3e0d78496c9e0c9fe4a6c24764f4b0670caa62d66eb05ad940f8546666b49726aa4bb6c2be845da838c43f0d9a1d8075493a9be86481ae153c3ed50ea606196c51498c33839889396fae8b783861650099f55db4d6af9cc1b92089ea7e836e5b63c2ba491a7715ad21c16d920971aaa9e2c598452cac352ac7839520ba9c8fce5492b2ba4ba2f67b284c872edb2cc8adcac15c80afcc6fcc49d3142ea101ccf7acc5674f5952e3652bb4538d091124e9ac25471927054ffa766252a5592428057914cc07b92c7c81492476510c9d63432cd1364462f4cadadeacb8babf515d5f5d16c6711398dc8dcfeae2667a2ed5c55a6b388cc0f4a7919917375f24a9dbc5a273944f247361a790d91c2468c9c07af0b90d245c8f152835cae932b0d721572bbe37647cd41ae8d945a03597e5a6e7f14516a3d349d9426b2707cd71b0d82ac54a5b250ad92129f22e5be36a714972f9025505954d0561b92c6f4e892090905e725493470b05cab919c15af909b96565a58be09dcd680db382143d9a40fc8a67671df515662b102ba892f1d2a9abb32faa28c8e164a32fa5d88ae85ba511a694bf4b59dc78f770622d11eeff4171a24aa44920491240f13c98995b1814cde5c5b5aae2e1f2693414e478805adac1c5b2cb5ca11caa84b65ecbb35a3c2b804d4fe75fec18508dbd743d3170785215d7f749f5d39e00aa62f4361d409024c4a08241153486e492413916633451fc5e273ad7688280eb65e06fab66b7aaceb75d900d5f1375cdfb7595f07c563415b429523a06dc0a572eb98d81ea3eb7efaf64f1c416c3d347d7758d71de5aac02d46c15d96e0661b4cf8f9fe25f7dc9df6cf62fde525096cbabc284cf512ff56ad55f47fa8f5ab4f727b537fbcff2482d2d7a129751050f6596e2ffd6cee76c4f5c3d0f4f30bd4baa4fa5e023a04b2af33cd4a965839c472ec2980091f87a15951ad9f281ffad7701c142b47f57c435e5cd5ff04c7f300dac7f6fcd308385743d3fc411c2f80fd9b5f17f622aed742d35b231c018f10483ce1b16dceba72069c36990d1384d78359cf727761341f0d05b60b93a51c893700f3a955dbceeb8ec9d5ec85e780011824e5bff720825e38bd58ace65b81e00e13226fd25e3879ce8a36ef74e4bc63b4a907b3a75ec8d53dc6f2037b9eb6dc6d96ffedc90f55a424fa3753385cd2	2026-06-03 15:45:10.64546	4019098854590306640	1634
167	\\x70726f64756374696f6e3a6d6f62696c655f6170692f70726f647563742f61643361356331392f313036	\\x001181426053071488da41ffffffff789cbd56cd6f1b4514774a657b9d0fdb49d3b4a160e37eb7381d3b76d2cc5c1c485c96b6a86a8d40e4608d7767e3a19b5d776737ae13c4a1572404bd55e2c08513071027109708fe076e5cb8f10f70e1006f66fdb149d31021842c7fcc9bb76fdefbfd7e6ffc4e2677114e7093bb5873e816d30bc9fbb41bc7f1f506ce984c181eeff8dc75f4c2b860dd47dd47719268e054c7e306b3e2253c637261b881e3379509e169c16c9b3b9be1ba96c4198b3bd41e2ecf8c1e609ec11c9f6e321ec3d343b3dfeb409851dc6d6a07d2e07a7c7314090c826ec339a249b7a49f154738257cd778c84fbc338693e261207336cba5d2a2ca590b1ceeeb85c4ed4db51cef32bed9f6114e9b7c8b39026a1408673b9e6b064698855e98b8e5b906f37aea898916f50cd70473fadefdb52242a88496d4ce645b384db985b006f508bd1053765954c7a6bda6eb99cc43f81c174d11b486a03699435b3633eb781e765cc3a0320d55a2caa28e339bc21f79cdc8d5083684270deab34dd7ebed26488c67485c2fccac51eef5f2f7c20822a48b6f29f771f52d366278dca33e80b79bc013749b7960ad6938a500073232900d779a0a4da80256033664165958db6e37dc86a5fa8615f503a87c5277f20fa4459d9c363c06299a4deabf8bf3ab86cfb7d983a0d3713d1fe30600ff1ef7db1fb80edb48ea01d6a46572fdf3dcdeeff5562d8eb51dd8417a21bb2a38bd71dbb51f529fcab87a405e9f7c3bf4fb3e4e8ac062d031070791eb321a780c2381476deef987ceb5a9686e05b6cf3b366b3e0a2854ef732622cc0d643b67328b8227c8d1e3e0d78496c9e0c9fe4a6c24764f4b0670caa62d66eb05ad940f8546666b49726aa4bb6c2be845da838c43f0d9a1d8075493a9be86481ae153c3ed50ea606196c51498c33839889396fae8b783861650099f55db4d6af9cc1b92089ea7e836e5b63c2ba491a7715ad21c16d920971aaa9e2c598452cac352ac7839520ba9c8fce5492b2ba4ba2f67b284c872edb2cc8adcac15c80afcc6fcc49d3142ea101ccf7acc5674f5952e3652bb4538d091124e9ac25471927054ffa766252a5592428057914cc07b92c7c81492476510c9d63432cd1364462f4cadadeacb8babf515d5f5d16c6711398dc8dcfeae2667a2ed5c55a6b388cc0f4a7919917375f24a9dbc5a273944f247361a790d91c2468c9c07af0b90d245c8f152835cae932b0d721572bbe37647cd41ae8d945a03597e5a6e7f14516a3d349d9426b2707cd71b0d82ac54a5b250ad92129f22e5be36a714972f9025505954d0561b92c6f4e892090905e725493470b05cab919c15af909b96565a58be09dcd680db382143d9a40fc8a67671df515662b102ba892f1d2a9abb32faa28c8e164a32fa5d88ae85ba511a694bf4b59dc78f770622d11eeff4171a24aa44920491240f13c98995b1814cde5c5b5aae2e1f2693414e478805adac1c5b2cb5ca11caa84b65ecbb35a3c2b804d4fe75fec18508dbd743d3170785215d7f749f5d39e00aa62f4361d409024c4a08241153486e492413916633451fc5e273ad7688280eb65e06fab66b7aaceb75d900d5f1375cdfb7595f07c563415b429523a06dc0a572eb98d81ea3eb7efaf64f1c416c3d347d7758d71de5aac02d46c15d96e0661b4cf8f9fe25f7dc9df6cf62fde525096cbabc284cf512ff56ad55f47fa8f5ab4f727b537fbcff2482d2d7a129751050f6596e2ffd6cee76c4f5c3d0f4f30bd4baa4fa5e023a04b2af33cd4a965839c472ec2980091f87a15951ad9f281ffad7701c142b47f57c435e5cd5ff04c7f300dac7f6fcd308385743d3fc411c2f80fd9b5f17f622aed742d35b231c018f10483ce1b16dceba72069c36990d1384d78359cf727761341f0d05b60b93a51c893700f3a955dbceeb8ec9d5ec85e780011824e5bff720825e38bd58ace65b81e00e13226fd25e3879ce8a36ef74e4bc63b4a907b3a75ec8d53dc6f2037b9eb6dc6d96ffedc90f55a424fa3753385cd2	2026-06-03 15:52:37.420526	208121814024180836	1634
168	\\x70726f64756374696f6e3a6d6f62696c655f6170692f70726f64756374732f61643361356331392f3635663232323764373636373966313561633831393965646565346235623033	\\x001181671ede0e1488da41ffffffff789ced9d0d7024c775980f2073f83be0eef82792a274a31309df49c0defe2f769734b1007681e5018723b0e0893cc9d060a7777788d99de5ccece19674392cca71149aa2cd1f3945912c4636195a72a96ca9149b9165ea4245e592e35891238914cb29495756a2309532eda4a24ac555ca7bddd3b33db3b33f8743d12ceb2412dceded99e979d3fdf57bfd5ebfb97af8a1a1d4357543571a45cbdc54644b3e1b7e683a35a42aea9da9919a5c25f9a337cd65d637563285a5fcf45a7e3e2b9d0d9d5cfcd8fed4fe6c2175482166d150eb96aad7f24707be70f1e1e74e13a3448a96b4256b72ad4824bd2459b2691149ae295285c89a5591de7ee1b1572f3ef7bbe3a3eb6aadac11a9ae6baa59210a1c6456654b950c158ebcf8f053524db7244bd725686291982651a69c2243de098c8f8e8f2eebb5f294241b3a1e5994ca86acd64cc9aac89654d4f56da9a4354aa5a644ce11a329596a95c0e53ff5277ff3ca6fec4f0f1752a375bc5669341c9821e1d4b58a6a16f546cddaa4c5c1d43526d1346824fb3e3b9a3a54526bb2e67cbdb17500318aa466c965a2ee4b5de3145bcd3a9ca675de73b2d6c002dd50cbad334181299f83eb989b7215eb95f60753a3a6a517b7d5e1d4b0b9ddc81f9d585ccb646291f9508c367ca45153adfcd1a19365fa756c87a8e50a1c174a1d54e0266b263c12337f741ffdf5b0fd886973f2470f2ca2388d26fdedc0966c1475058a0f9e5e5b980ec2ff6233f497f18a59dbc49f82a911b831e76c7877754d6e6eea86428c60ea16d5dc341b5b4e4fd82435794b234a2e7533fca2178b323686de2b6d452e75a86c5abc5621752d7e6bc9af34120d2493a9f1a26c91b26e341f1a4aef57af4b0fe58f5ebfc81eeea4b4a26a1ab14cf608d52a1c154c8dd1ff9a67f7a5c60ce80ab532f4ed03323c76289d1d4b8dd207000fe710344aad6d52e9c2cdc037fe74b0c987e1bba6eff09f0fd3ffc237d96a80002696f51d691d8be8a50f160d02ad5436656b2325658a967a8eac37ea75ddb052a9023c8633aa55b94faf91b3c3f9466a044bc61ffbcd23179efaf5ade7f6a7461e845f82f9a38733a62a9f38a96bdb30fef0bcf9467a7afc4956efd6fde9403075b05157f885d2537836a8e19c096accded27ed02d15d9dcac36344bad6b64f381860cb76fa9c4ccb59e20efc7ef514849869ad03f0d15ea6daa4a30356e7f01913e340dcfe01e7c06ef9dbb37b39059cc4bf34bf9e5e53cd020185c5cf918363b3d923f3af8ea208c6c2987ddd8944eca460dee695b96f054c46ae2d0ff43187be3a3586b8190ba64c0b82fea9ade30e88827b50a72c394a0891549aed7896c60013b02c56fd6a1cd535205fa3b0c6ef91c1e39c900c02a7104957443921b5605ba1580615d878f52bea6c02d5132400f417e408bbe289d82c76bc89ad694cc466d5a81b62ad09adf964ee970624b2da94555d6ec66b2839efcbc74a6d294e62bba6e1269ae292b725985afd031d53bb14a28c0cf2acdb3db9b83aa163140064f7f797c7411fa8a89a4ab8822b074a9d830e0fad8cb8b958655234d737c14da5123508bde925f83c2011c138ab48ec2919681765a4bd6cb804ea9dea8954112535255370817dcf8a828ac925c55410482702201690d5b9841e92238bf343e9ae54f88711d006fca5580c81420193e41bb81c1e7e00ef004d180b4840feaee86aca9f0fc0b86aca816c581744fab4fbc0a730134a788b7089772e4699032d4958e391de938933e05b834474c4bda805941cae9702bebb419707dda8ef1d179263e28a8eb8a0adf41b04da90a3f6a32346e49af92aaac1010333e34a8b40338a31d79b4048f0f2684f458307d6076323d0eff4ea8fbd20783e943c1f4e160fa9ad9b1f4b5ea48fa3ac6e5583219cc64e8a1d73b4c4edf104cbfc76666fa463775d33709b89d09d1a29b83e9f7f2eab704d3efcba5df9f4b1f29a4a5d2482c100ca53fc041387b7dfa6830fdc1b3fbd2b742d16dd0944968db2f14d2c772e9e385f487bc984a7fb8c58cc70110f7bdf1a38b02339e6645f76351fa44ff5583b97408e4120ea6233620cef802227c05105700f18f0e10c3d1e04c7aac3416994904e251a0c49d40893bd3138dd4c139b5bc408aa08d68074333a960209a4c9250fa208cf8969243cf62b304b4cf60201207a08c72a024e2a1583cb76ba0847b00657fac1f9a147ad2e43780077ff04f1e9cf020028a7ecd4b935e55294d7e51a4c909a4c97be657e7574f6d14a4d5fc32e81acb85b516497e3ab002431f1ecc3a282915229dd175453a6d503b01865451af352c6955d524d5948a865c02fd496a98d071254be864e43c7c2be217a94aac8aae4065bdbaa5d6a0f60ea86f607bc0c384215c55a9298023108a4c629c23926a9952cd1ec4f586811d18ed1cca1a1870d87968772dca062935283eec5e5c64ed33a7c05481f6e9ac992583d8475464a30a4748a8585b74388191a360abcfd18f353c0574a52a5811d8786a0ba1ba49db44a9c11b56020d9822921e6556751d6a5970df0d0330a95a78e1ba30caede13d05c3b6617dfd73f4231e294a0d6552276640ca5b92ac99ba44e5614a32fc2381ce6d42a3c0b2c3dbc2532a3272a361c2f5b60c3821cad1212f486dca961ebb500d640470072b06da56037937917c9a5a82e1dcd44880cfd1f1408ccfd1f7c1e8bbcf6f8ede4f8714f49e507c211b8cf02135baac5af658ee7754457b8caad9bc3da8aec58e3b0a975c9768ada3601a7fb26259753375e204f49c4011a0acc073339a01e86a2794d25639f64033143c412d98138dbaa6cbca89e266097adc54691304a54f5536e3c1e0d403eccbcee64c3078e25ce80437ddf987698b54ebd333a548313913da524a4959d90a26efdc94ef98cbccdf15595f58a62dfae0d9fdefba365dba2ea33e7ae4c2a71ebbe11705a4d458d11f7ae983e5fff75afd6ea1aac98abed9a2cf7d227dd66dfa9c91e6360a85ec9a7436e6d663fe37d5635a433c13961462aa307a761015db4cd510a6331800302f2ad330691b08976373aa06e536758edbaa091d93c50aa9aa45599ba63c988479d7a8e267b3c26ae1940bb5c0f8ac36f94866b0e263ded676b8f6e2204ba6fc7054170e145a0096dc6dfc048e0e7312e6c739522325c08aadb5d0095fad494b7435a709ba1c10e7ed175efe24ccb0ccf835414b2346b9e91dcda0d420a391083a1ae61af0cd3248ad6c556c1d85aa40a694af56717d03a7fe273f0f1333920e2dff926c4d9bbad6d802b69c5329fd4ce958664a5a9892b253d2c9e34213b674a579f1e1675a80061b97d44c62ab2d4e4b16d4327005f90fb2fadaf8a8fb916dd7f49d1a325fad427f06e497615261eb58a0e9c866137f53e829a41de01952d96c54e1f98284aa3a280c14cfb6aae3346e1d080b0f765183de4297c2b82a58b1855a42a1568856e7f2934c3844546e96e050b8f606de11057f45b7d8ca19dc94a15ba0d0acc3539715096e4dd14d593a011d4baecbf84b465168c365c6673a5f50756d7c144ec830be25c327fcb52ae37c20952b8470ed27cec16b0178adaec65126125d08ed5a9749ccf449dd3d308cbefd8d3f4f0984788a157dc9cf30ea5695c2c41261f22184c98d0bd9f57c279adc39088647432b13ec36a8cce013a9a15a0eeab35bcd01d0e41005d25cc382396ccad16d98de00caf4f403b6328d1c72340efab35ac3be5a43db0b4065da3a0a5cd3ace268dc922d600fe81738e16ed1f3db6a8909c0b107129ba4519dc1c6b50c286a3218c20c0fd336bd17c70e1035880ad7aea1776d0318a90203da5b5d36b8e6855a13bd167e03eb0c3e374525886a4e762b0dc208216a641482a0c6e825aba5efd0f355748d98d000a90c14a062bef8f0d32e2588ae172b32555a3a6a3fb4c972719b8d7652d401d22aa9291a28325b2a0c7ed0bb145ce594ea504b2e53556a87001d4d24362e65dfdf0070d8aa239c6307d7ad516e44064b0cee0dae65d60129ea96aad9752ad087558ba24d211a88020466eb44d0edba8f4aa60e2d64f2d95c34924bec765446127d8ecac3741a5d905503cdac1ccc63acf3fec328464a24164ec6a389643ca6441539f26e508c7ab6e9d2595601d5e6474f3cfb0d8f6204452b5e9655a1fc77debcf81d8f6204451fedc0b2dbf189de4c5986dad1e252362b9d8d04832bcb2d9a7d6700f5186901f5a1459835e8c20d250de24034f1cfc00883f9efed175efa551c4cf322cab02e251890a3aa9e876241c7b219857312038ee9e04644678b4ef6c20e1ff03017c3dceb2863ed762137064573cf060ae5996daa342c4375ecaf455d534005506b74e105173c6c5589a3110fa93360b8d4b52d5bc3a218a258837f1c3ce04d4ef121df62057369011d1cd5c5bd5ac38c2ec79afbe18b9fffe14b8ffcf0c5e77ef8e2abac258852bc6b644e0df42e592b83a0a8842dbd811a816d7a554129311db32bd25a1a1d780140037f28693a2e7050f28c72f2cc85b2c950d6cf109b9de88f3eb1589ff439847df55a469fd3f6e863e4d9ad9aa03f7ee4c24f8f9382305e2c56f4e77e2b1e8ffeaf7dba67c5038afe5b6b6881ec84b155c3f60e2ba6c247d290fd71b434148dd9227f0545fe8a1fdc87b88813914c2e19f1837bb09b6043c16e82cda5a5604baeb303bfbb7b29ce3e71e4c2e3e1ca2f0ba2c9b1a2abbd52ec55355848874aa3d16820164b87d50910e5d0433740132752a39abc45b4fcd19190c405001dac258fd4e1ad46b3e5db0591a27053d73bbe5aeea0f4edd9b313a9eb9c9ab6d376241888c652d791120e419897f999ff0c97dca2a983e8e7e4554381c44cea265a61139967385e48a89fba4e3e0783172fcf1c91eafed4417454322f5d01c44c6ff2603a06f71776eeafb43f2c3ef0786928124d1f28ed8fa71339bc8b7d7c54ce04d3c9d98137b05d91740a1b1e9a49a7b1e47650dcefc8e105b0432e61873c92cb9f5a049d7525bfbc9c2d48d3d21a2eefb330004efc1baf5ac3e5585cc9aa31550fe1ada36ea3ef00931a9aadc881c642752a85aea711401e904c587a0700d6db18e6501638f7c43fefc7369d97b5a2daa842fd7ffde5f1d1d5569bb6d050ab6ba04a4fa37da38092c96a323519ceb3883e5d7af12db8179867b6550517db09b0ddd09ab6a19a3d5f24d0fe1aab79867adfa5651d35c9cffc165d54a7cbda25750b94d36d42ea6c7ea25a3398fd65628c8fae11201218df680b13eab2b66dd30515ba2e4c5ad3395b9d84fbf8dc5730d661472a6bcd22ae0ea02a4fcec365c04634e95aa0a1c344a2a1596b36cab22169b8c8cf17d96dc33acbecf2491897cceeb62d6c2e37d5d0d12ea502879b33bde67019ba758ddeb2c9d61ef1f4b12ed6749e99cd664fbbb9eea8fe20573c6b3c20785d16b586456a200f82f11b8f7d1117f34bcc3a2dd39fe842a1466c57107b867031826e0168335e0d2e235b9d2c68da7dab0d05749463821a70dcfec5b69f99597d5a370c55015bed185edfee1e32986f96c9eb833565490ae825dbdc62461f0003f80f10e03ff003b8b3fe9f49cccd87e6db00deef0419efa59e5fbb3746f3a7603e23b78ccd7b2210a0e88fbd1cef5595cd863f1067c3fc15f85c81cf15f85c3e7c705cf58d9ed84224994dee1e3dbdd6ebf6103d1b6f5f9ff5f0048afec40f3dddaafaa0e724a2e7d6dcea470a99fc728b3da732f7644e65db16ef3e70554e3f6f012c6cac78484447bdb39e645711ba07b531511104fc683894a71ce6346c575fcba3d68b417b3d7ac3c2a2f5e581a651ab110ce294c1182b1a2cdcd1bb16bf4464c3b21d0bd2c5e75f6497a0cd34e869a42d19a84997ef407eba26acf7738f42513614553f279bc58606b7c2873d059103042f293882149558d8407a47b81ea957758b98ceb23c82a4d4a815f99a7eac1d6e1edfc569c1dc878b5b44ad4d71d201c3b0cd2086938eece4224346c5d01b65baea897d087a8e8da54b841177d2787044fd0493dda9c4822c59d56300484d860f3b15b0d76919d066a35e45309d86278d2ea305c6a9bca2a9b8926ca1044f5640b28ada3f881cbf4128148b46a3bb065122f8ce380e902effb25cbdcf431728fa4b3f1075abea0322194174741175a0e5e57b0141ebd9f5cc4a968543c4dcab6edfa31e491a0551b7a3208e152b647bbb715c8872687910d97216f40205c3acc4b52f27f807ab6ed40c004c8d063c3de5acb3f3952b61b2eee0bf14bd906e872314d053e322147ecf388b75badad5032962a2e970828fe132a509facf606284d3e9e75545a62d745821108447aadbb06b2960b68b6e49560de6a2a3d1682e6fa65b3da18a25f39701e5ca38be2a7830ba316cd075e4cf49ee663459135d1acb1941718536659a0de31c51404c422016c02d03f73a9dafc1c3ab56654b676b5ea0cf62ccaf0d23174a811388040d3ed8c7d850eb143ee51320271d23669d60ac193450ec42189d47502339ad16b7354fb45a8154a15df4704b5668d056eba6d0e132492347ea0d1a71c3d71dc381285f771c3c3a0000c1bf1d09022324114de4667c571afb7473247b857c5cdb0af998ddda3d4370a970e8e1d86f0960f8342b7abfdfaa62b7aa942128180122bf8410b969716d75e3d482134b1573c5523dd1ce8e3666d005736727869b069c02ee404beed42eb375713b8471922d8bbb200328e0d030718f870306871e22867e9b72867e28b42dd9ef05388ead6ce432c7f978a9ca351cce22345c0ad29a2d85538e14d8a09e87db3eb123ca94b5d07128984e10c3f8e81ca17e4cab02838bdf290c02ae22513d6bbdaa6f13986e61e46290e84b60e128c476e17bc6e5a454329a2d3638e029505fac3dc285584d1e280b3aab1d5f3ae50c583899590335c6ec028705d1d9205cdd050d060527f0d2b4232fdd861ef7aedac37e249408c7d263f0df782286433f45873efc9d68a4a31334c2326c07588e96d04dc416394bc33128a45018bc6340c442363e3393085f06166692fd478275c6427fe195ff73fc2bbfe219eb50b4df0f0bddaa322c245d58b80fb170db527e25b39cb93723cdafddbb5ec82c4b6babf327a5f5cc72c1b3caf2fd4171488368b625130d4deaab5bc27057b9897d5706b5dff4aa0e935e9dc0514230dec140cdb2a50cd3c02a55539c88037aa1260f5069a9135b1a918b15ae3eb4e917141245a3899e2db39f859b15bb09cef8b5c38edc0d9434751b37ad41734cb5519d023e946b043ffa5823b8a080fe461edfc44679c6ad8daf9132b555d6519e6fbff0f2233c24db81ad0b0b160d29409980928ec1da5c4c402854d65d1197363f9c862d35151692842ac1cb2dc4a9f45e25a291229a834d8b889a11aa17b8d4e0d25bbee8ab0109b1520aafddc9c47053c331320c5b1e788b40e17c0d3fc974a5c324b2a9b389618158fa79b6ce01c4a606d60e0618ecc828e249607455af1d67014d487703cd5ec3c4f0a8a2d1c0cd03260d9a27dcc7361ca2a4190b8566028c351b94351b8c350792809a58f750ee917800ce71ad7a805b31338999b9b9d0ae23b9fbf574f615c83d0e82ec089a3ffbf2f43d1e572514fd851f68ba5565a029b84073164133e9808602667e8dc28671c6b39e7285345748f38f9c3409f4069546e3f1402c84a0a953d0d41968fadc363212813ac09a839c35e15c249899db356be2ef186b1adf4e9ff500048afeb31f6b621fceff92a72a147d4f608dee62cd47e9caad9b351432a757cf2c60e0e5159de60a697e7e4843a762aed2c491348f52d23c7a69a401ad260aa499e0a4998bc52291f6b5d97e49d36ff4e8e593e688baae78f001457fe5479a6e55fdb49a8ff968352ed25cd16aaeb0e6e78b3530158f512d66771acdeca03920ea33a178666e21b66bcaec8927ba2fca9cf8afa6ea410714fdc88f32ddaafae933f722656e585a3d95bd575acb9c6973fa0c5c85a39d6edd32e41d786a8d5a49c5d141146765b5c2e23be8baaa3d246807a00cf1f87348edc166952ed77b3c3b858a5adc1612ed4cf2437053eb0e21960816e645aeaae7bbb3a5a2d748b31b58fcb78371dcb89d3b6c2052176bd192e432de16ee1fa5c1987a8d138403d8f6d7b25de5d2c5cf7c767cf4ee06dc22db5a0b60acf14d6c5bd8086781d6eb48b59942efd8ebcec6056010d43c7a72a1ed2fbe8ceba1ba5541977fc5d0d1f53aaf57619409de1ddc170367ad12a5b543de818fd76dc4eed96f6b1aa54d151eee162657aadabe6adba775c6862af36b6d70bf5559d377f081b19d66e28e342cad3bcea44e340ad9c1e88c9dc748b50e8fccb4a0c3142bc7d19f7c5eea401967439a45e4293be81f5df7c616ba9228a19c8d69ce9c869d0e1f11f70f455bdb8107bf4ae9f3555fff105b9b39952944c2d1682eb86bbe44fbd462aea17b60b838d779b3fb8a44ef8a9db7224fe43c2c81a257fdb0d3ad2ac3ce575dd8f908b6f97d0c3beba0e12c4b7374a34728e6d269fe9eea34d0cd71d6e3fb36d856b263a645b37b99e671698b500fe46f3eef4289221bdbe82355cb15e82ea00f509f2af534c10c0a3d0ec74011b36449346d960d2c9b72cedcded5bfdc0622ca1de8ece8bde8899fd33c7cd001502b45472f109568ac4c0b3f2d5c724f73174af8a805ed6870a384724be56e1e831451836a7ab5976c139dab14033ccac64140cbb52cb32d705097f9aedd98413c505674546c3a85de9d7276e2a2e661bbba6d3475e172be8629102cce63be1bd07118f6c723f8e022923f90d07d4f776fb32db522812892c44760ab3d933dd204ede7bc09c58389703b6ffa8d689989f40f9cd9c17f3f7079fee837bf3c15f110038a7ecf0f2eddaab667099a43b45c975f58ce4b423e419b28037f4dc7bf272fa0e86aae8a0abb37fa4408dec55d9f533cfb9faa68aa5d27478c2af5d1a265c1226dd9c46ea834f0c0de28ca2acfa31e3025f1fdb4767241effe508740a217936d7aa5dd4bb607808afe5ddc58c567ac5020e4cc586fd119eb2ddf19ab159c990c4693d95df7a0788f4c537b15138599e9d65f7be34b9e4027284a79fb4fafaa6c727acb3539a5e8847a57667131bb76ef3433b7a7a11739d3d25707e82c4b551c8c9ee3dd6547a6c984be4699070085a7c376b9b59e8fa66260227b6eab4659ae81aa7b975c2ee356bbd33401109be4dc7bb2b18336b8b1ee897feabcebafb51791ee8decb807912669e1fd1fe73c986ef0576e4fe3f9cb74d6635b20651ab4579912763fb2dee8de3418b0fbedabaee80be997c5b82c3a373e2b758ed006eefebe33eeda54b376537a818adca5350778922cb6b531d01a1dad789f81411c1df0d7677438ab52c164269edcfdae8958bf7ced6b7474d4dc861e3f72e1dea7be620a3dfe002bfa1fdec1d1ab2a1b1c2015617094e9fedc934b99530beb99b5fcfac6620657bd2501b2fb5a1276f2380cde48257ca3af8487b88493f389447266b71a73f21dcae5f04d00c8f7d7bff08620b66fb1a28f7b25dcab2a93f08d2e09afa084a593ab0babadc8f0a5ccdac94cdb92dfdf0c9ed4159d877c1f5b0285573e8ed1e1b264077a534dc8c91ae01afc74b2b9f8f0d3652722912febf0606466d6f70c09b7b5b7da65c66ff3986d0cce73ed1909ef26eadc8ea9f20f3ac75d2854459c94161b964b53a533b249d3ff518513f5d126b04d5c3bb427746fac76b4bf40730d95fe0e31e65cf2acd945d5c0187321169c733247053ad91611e668c5c2ca9e1363eeb7e47939fb5096e9d3c6c981b8b6bcf413ef2dac72b48579db21dd7ef1debbd86f92c90617e616761fe6dd6f88e61e8479bfbefe979a474f81a2bff60bf3ee56d527ccfb1445ca72be5058ceb6a0b29ec1506fb7c7f23f0d2eab96a51161ab890313ae93b678c21922ee6a039502e65ab0a80c8bedfe27aac1cf76bf8ee9109a3d9172995b425c61c87b0093ee5b58bac55d673d23c3018468b68a7bd87aef50e9be3ba5428ff76c21e1d8382584d10abe14ba8d04daaf2a8467d6eae129b9fced6bed14e8e681a0b56def030b8dbf6466e024db5b131969e97ae1b9447cb79a48624f55bdeed4f8db3959cc5ef0142b6a4b74403787a4bef1694f55287a5f474d648b1a422b99f5d5d5356921b3ec554004452fe2287a67a978cf0ef69fb4031392e6e682d95d2f9526df2171ff2908ec33c9a5d70419fe4756749757dcbdaa32719f7589bbc8c49d5dc86facac65ee69d3f7b8b887e276ae8e4193cadaf4edcac35cb60be148627ed7a99892fd2e43ef816c6f3dfed3bff0080c8aeef1936db7aa4cb6a64bb60a5d155a595d3db5483bb2bfc1120e249c7efc2895eda3dd659b89479333bb3758f624fcb23f83e5af5e7be6773c5608147dd8cf60e95695c9f651976c097d79424bb6febd763814e1ddf6b354b49fbd3444ccc57299e8ae93a027f724faac3f51ffeddd0bffce233f28cafb89ba5b5526eacfba445d6288582d2cad640a27f354d63e3d991ee627eb0e4a7230179e0fb52bc9fdca764fe26dfa93ed5bd6bff8a647605074b79f6cbb55f5936d88c97663bd90595bf04b08fd4703d9f3b8af8c60ae63baf31a3d2bc58a8cdb9888d19e4ad195317aa5813ab18219a3a72496a28d068ed07db8a0643bd123828d6e3ba1d89a1bcbea67dace633b43b3a99ae8d712365305a49c93e559d8f3e449eeccf33f3b499e6bae5cd17ee90e5902f722cbbaca93a0d1453e9e3a5d510db002405fa317c7acb26cf1b015272364bc86a6d28547bd54c2a80f85d4e1271021cf6526666c3688064a3bcd50e8b5360469f138156a920aebe74266b116debf45c7c5b7bae01d7a40383717cd3ae36237499dfb9d3dedad3cef7476c0502c149e9989451291ad58325e9a7937642cecd9a6dda572fed98b9ffba8276321147dc72f95f37fb8eeebd39e8c8550f492408e6fb9c8b14677519f5e5b5d1796ece6326b99c58db635bb1f0d82a965ea7ef6b5bd7d7f9a6e5f64bfbbd6e7d842b790fad80e00532e21870c359ec1143ccdae655b7f8eb1576d98458c5d73b226b71207d0ebaa0fb698e5c91d10deb395c092411e6820d42a0df6c32ef3c6745d0314c35e2ed1e86e4b32dd312544ec1296069cd6b897062ec7d4be8ce40c6b976d7183c2e7c0f62714b63fe9ae84ccc4b273f3ed9961fa35b9df212504b333ff42e6d9418f1d0d450ffa2572ee5695a1e4272e94e83445e39abcc3813166929d07761eb0f5ba0926d00910e7849f30074f0da038c74c251c0aed2643633735f9523234e6bafaa8b24f1cb9f0df735bb38264ee6245af7885d8ab2a2668045984a1493c37e3219ab6b0435ac6741cbea204fd52164e403f9960090b83a1741a3edfae1e4cdfe124443cec4988383bf0ddb653e3c1c9a4efe9076fba8a5d6076f0faabe0f4f8fd7675707940488918a69be9d733b9dcf2ea99ec9a9f1efa6cb7179300104accc560bf9ae4ddae6af2d06697b209aca393a2a05d53459279702f5be7b4f35ae3dc6bbfafa41595c9b548e2e8fa3009db29ea55f477482add142f04738bca26d73563c292d8fbaf42fcc1df6ebae67c18b41d67c57137ba66bfab09ff40ba6638185642e16094c4e289646926f86ed0357bb66977bae6b3a77fac78744d286adb1682e5f7924fcc7a744d287a459820a0df08134415f93024a4f055789cd8c02b3e197cbb2fae50c7fb21c554761483ec183b8477bfb1391dbd409c72aff4d50343c15ed6cec0b7f730c3ef6b7ff0ffc47724645951dbeb147a5565eeb257441947e98be6d6574f65a495ccfac69a5f24d9e08f3d145ec797adacc8004e55a2da1355edeb7a9dea840e22a8f2c5df46c7defe810841f631e2396f12301b5be888b393828b69da9081522f00b6de0925bcdd5608f4114d7b168086797c78f023d04fa72f11c0e8a5b6774561a8a2986f8d4d28a827067a6409a7d8a732c02293bd3c81beef8146d24d492dd2aa4eee91d6ebfbf4929de42320392fa372aca0d68b80f9da019cc54edeeecc5fc5a6136fc75f73552d6146249e8cbc95494fc84a4e97eafdfc1b6e985fef04b2e42289f8ae75d9e825eab2eff83b054233b12229466708091693a5c4bb81e43ddb74c94a2a82fcc2333ffe35011c3a2b9af003f9271e1f7b584cdbce8a863b7a7b621d2013bb02999f57c858b8673f461729013425aa35c2df7e93830c47e077c1a00e6563f1e8ae7383442f319aee9d1ef07222ac2463a43823cf90603ca4bc1b20d4b34d979ea4092934f147af3fe6a110145de747a14f7ffceffe9987425034dee1652b9bccd8dc38251a9b1197b1f9853e32b76d387b02fbc9e1b8cc563bdb77fab9f3b8f59bb8cd37551bdd9e635f96aea7f6cedae62c2b7ad3b689af4c6b8f02ec9cead149db66df9d37584f901adac16c51d479eb1c1ac545ab67de3616843729f1d544b6cad84ac076daef9d534e5ec7059d98b58b0f3f03bf13428387ce35bda18cbe7bfa9cadd7f7b0f64a59413274034f6b05b39f8c6e3c9a90a575c37dc4fcdda01d52bcf1a54de4a79d5e9b064adae6f75828108c91084d4d100886e11300f51314a89fb84ad8321c9e89b7a7769b1d54afb2370cc30721b35b241bcb859d00f0dd247cec9534b6af848ffd6576dbfac04d9ff4a46b83a2437e1b6cba5565aacb232e1bf4e37ed870277cfc3797902cf60a3eaee0e35d878f04c3073ce004a3c7f3941ecff7418f3b06c4bc90a3ce1b82b389cba447bfdbabf6801e2f9fb8ee710f12a0e8063f7a74abcae8f19c8b1e71a4c748011ea7b386652f3c8d526f486f97d160947a3986c2be1e8ebe94db7e536c5ea6a3e383bf7ee4c2af68373f29c8e7382bbad92bca5ba1fcf7ff4be08250f543ac68a9a3b72881a23c5ca0affd607aa82352fe66afde2ea3ef5d85c23c188e980afdbfb95ba1c6bacd6e7be73c7a09a432f17f3ef28820a8df6345a35e9912e88b079f79cf49a1eafdace8eb2d994e88124dd238c1334bd94c611a66b70df7c6bf37d98b07d93e4d203fbe43c572bd4f1cf7bbd9dbffe668066abaa3174d77e755a0605ef29d7f67d0052be568dae20edbfe4c0b2e325d36f406be510f5f09e8784884f433de77c6f3788029d1b2f76cd7ebfe0279768fce6b01b1393cee46f07c50cb1a5f1cc296032a02564d7b2f20cc187c27e0d75822117ef76d49875c7b014bf61e17d766c0a75f62eff7d4ec175d28e20e5b669a4f72cb1b2f7ac679136b0927a42d52c659877a84d8ab1ce9ac81f2e74142c333fc454a831729f12ffaba6dc6b8913d3f97cbf98425f6bd29b0dfb7be5ffea6c0ef3e62ddefd9e9074517fd3605be15bfe1bc50759c15ed133874d185f40a45fa83e7cf3fc887cac8f907ed2f7d102839c0df2c38bf104fc4761fabdc8dea7b07a0c9278e5cf8d907d76f1524f46156f49c579858f58ff5678e79aa42d1bfea00200d4539861c8e84db7d3cfdcd8ffb509cc3a6e24bf21e0100dd42e9fb1361ae25c2c3ab0d0cf0ebecc3f9d96bdfbfd9e39881a227fd7c38ddaad2b7340e2593e9b07ac0090338d03d0ca034140adb824c747a07637a06fe4dce0e4a57a3f3ea0d8c0c8805925174dd43d1edeac0dfd99e7bbcde38bd5e44080e78d31d1c30f07afa4069384cc2f6055d5ae3c077e162f027591a0e2567f072afc3e546e38940248cd79bc6ebdd26040aa8b4a3988ac29fb3186b1d0b728885afc67e027f3bf593513cc56e7acae5cff6fdf6940fc1b37ef0f4bf7d5e78fc4156749bb7a7f4aa4a7bca3026f209ab434e5719ea11313278dbd5b62c7d9e9cd34b16aea6bc4e9586c2317c640bf8c854a187ecc7cb8c46a2421779dddd2787a330fb40278171e8db49dec44ef2265e0cba2dbd18fc9ba6df6e5707df7b56e81ff7d3cc5ea81ba21a727a4d45f5500a398076fa0d466a0579a84281769742e7ee32b42baa74b35cf6beaffcfdb76ff9534f0780a255bfbed2ad2a0d2da21ab73ae27495915e214038caa904bb0d72ffe777db59a1b30cd3ce126ef104ba55c4d32dab5763bc110cc550978e89817811fb626892c2e51ec09ef94fd9c552872cdd92b54dfa725835fcff0129628ef3	2026-06-03 15:53:07.504843	6707909124198720732	10232
166	\\x70726f64756374696f6e3a6d6f62696c655f6170692f66656174757265642f61643361356331392f6c696d69745f35	\\x001181238264d81388da41ffffffff789cbd964b6f1b5514c7edaaf278ec38b69b367d108871692805bb77fc88937b1775503bc8246aabd608892cac1bcf1de7a6931977ee4c4c4825366cd820c1274062c116b16289ba61cd928fc0962d4870ee1dbf9226e629167edc3367cee37f7e67ecf3c9edd451096bdce21ed65dbacf5ac5e4233a48e0c4bd36ce594c747dde0fb8e7b68a69c1064f074f13446be354dfe75d66270cbc6071d1f54237e82813c21704731ceef6a27353c7399bbbd4191faf4c6e607e97b901ed311ec317c6e6e0b00f6126710fa8134a83e7f3de241218043d803ca243f7a59f9d40382502affb849fbb1fc749f12494355b15c3a8aa9af5d0e541aba86df6d4313d60bcb71b209cb5f83e7305f42810cef77dcf0abb5115ade2dc3bbed765fea1ba636e87fa5dcf0273f6e1a3bb2584908156d595ccae703bf212c23af4235ac598b2cba6fa0e3dec78bec57c8497b8e88870672c6a87b974c7619689afc115afdba5b20cd5a2aac2c4b99e08265e0bf234910de14c9706ace7f987471a89f11c49b48a0b7729f70f0b0fa308221a17df57ee69f529b66338edd300c43bd2f01c3d603e589b299c5282c33072500d773b4a4de8024ea369c82af27076bc4174198eea134e3408a1f34ccb2d3c96169539dbf51994687568f01e2e6c74037ec01e87fdbee70718b741f8f779b0fb81e7b2ed642bc4bab464ee7dbefcfdcfe64e3381f58fe00a6a15f31b82d3db9b9ef3840654c66d85e4adccbb91df7709528229867d6b9488bc29a381c738127834afbc78d3d22e159dfdd00978df619da72185ee03cec4d4e446d85eb6984dc11370f439f87560657238333c896ded68514e00a71cbac39c5651370a1168e45253271727dce577c2c3a9f52069087e690cfb68d4647ec810c9227c717c39421d2cccb69912731c6719e264251fc375d0511919f8aabadca176c0fcf110c1f3223da0dc91b9a231f22cceca31474db6c94a5bf593275568a5326ec54e54a67a213559bfccb4be4eeac76a26ab88349a37655564ad799dacc377cccf6dc5093165f012047725ae494b58ea9e24841d7ed56dad56272904da94c81cbc323c46e6910c9b4324df4c910b5c230bade2fcdd8d56a3ba61aeab0d9faeec12228b885c3ebec1e4caf4ead695e92a22d74665bf84c892495e36c92b265946a4305aaa669ebc8a48713b46ae83e935c87f030a5a6993d74d72b34dde8042b6bcc1847a726b82601378fbacb2fb6c0a4133329d972652feebaeb7db04d9a95aad5caf1383cf93ca10ba7935a43378831995948ef5b69c4f76f2f4882605ceab72822078a379872cdb891a59b375a3dc5883a1dd81a1250819f3903dc14373e5582a5babd60088c4eaa9346cc9e855191d950d197d0ba2eb5340ec4b20b4291e2c11f100e59fa4e194564ed29103b40696cf06fe808df848bfed0581c386d597c8e2a8c899a8d466a0d206c6cdff8e95e7dffc8aa700b81799be3d8d9559aeb74d82a03d0301253125ae23c54d8324a25a7941603b69b04aa4f11e68bc77dac6c5a4a64931bce5efed5af5dfee9aa9f433a57ef9076150f0ecb325fcfdf94fd74ee802a62f4e937096ab5a370d9e6c069f1befdadcec5db335a3a2349cb16df06a349f01355b7215eae5f51aacc2335885f82fc35d9089322a517592e8fef1a5de843d4b56606851a694cd3f64d630c90a2459210d18eafa1ae4d9843ca9d546b95a8144f14f20d38da9a5db935c2cb69990ff070a0f1f71f9b7a1608c10d12d3105091a4212ff142881b7b330d1fe1125c6ff45c92d98f36f3f2efd30357a14991e9ca4e4cf5c2525306f031e642346f4d90f49393aa9ddd9838378f0a4acc30f67fc4b18d99efce5bcb13d0547526648552674d85aa57a3c49fc2bf9cb6c80aca7251a6228d7be0a84409a353b59678604e46b48f77194ec0f9caa3507	2026-06-03 15:49:29.689913	-7561771847489811839	1579
284	\\x70726f64756374696f6e3a6d6f62696c655f6170692f62616e6e6572732f61633063303061372f616c6c	\\x001101ec9dcfdaa989da41ffffffff04085b077b103a076964690a3a0a7469746c6549220954657374063a0645543a106465736372697074696f6e4922077364063b07543a1272656469726563745f6c696e6b49221e68747470733a2f2f7765622e77686174736170702e636f6d2f063b07543a15646973706c61795f6c6f636174696f6e49220e64617368626f617264063b07463a12646973706c61795f6f7264657269063a0e696d6167655f75726c4922018668747470733a2f2f7265732e636c6f7564696e6172792e636f6d2f6466626735717931302f696d6167652f75706c6f61642f635f66696c6c2c665f6175746f2c685f3430302c715f6175746f2c775f3830302f76312f62616e6e6572732f62616e6e65722d74656d702d326465316239366262636166373135633f5f613d4241434a3353444c063b07543a17646973706c61795f73746172745f6461746549220f323032362d30352d3130063b07543a15646973706c61795f656e645f6461746549220f323032362d30362d3130063b07543a0e69735f616374697665543a0f637265617465645f6174492218323032362d30352d31302031343a30373a3039063b07547b103b00690b3b06492208736473063b07543b084922277b7b626173655f75726c7d7d2f6170692f76312f6d6f62696c652f62616e6e657273063b07543b0949222668747470733a2f2f6d6172616c6973616e7468652e636f6d2f637573746f6d6572063b07543b0a400a3b0b69073b0c4922018668747470733a2f2f7265732e636c6f7564696e6172792e636f6d2f6466626735717931302f696d6167652f75706c6f61642f635f66696c6c2c665f6175746f2c685f3430302c715f6175746f2c775f3830302f76312f62616e6e6572732f62616e6e65722d74656d702d316366663131306661636334643336363f5f613d4241434a3353444c063b07543b0d49220f323032362d30352d3130063b07543b0e49220f323032362d30362d3130063b07543b0f543b10492218323032362d30352d31302031343a31363a3431063b0754	2026-06-08 10:58:43.285975	-9220336656781284498	947
181	\\x70726f64756374696f6e3a6d6f62696c655f6170692f63617465676f726965732f3933636331616137	\\x001181d0c8c1754488da41ffffffff789ce555cb721b45144d5294e34785323654b6b7bc6025eb6529b2a462118a38c885e35072ca0416ae56cf1d4dc34cf7a4bbc78ac8c61fc11236142b3ecb05ffc1e919c98f60d8b162a5d1e8deee73cf3de7e883d5efd6df6d0c1eaa487d3458d322e3d1cee32f84b273fa940e84cde8c0b24b56062bcf4e069b113b6955ee95d1a39dfb7f3ef57424ac48158d85f609d768c634b14a4f696e0aca0b8b57310ed98dc3211495e7e6d64485f48e9c29ace488226559fa744eb13519795b388fb7a991222dbbd9ba3a1d1776d16f859e322947d69850a8347a44a4022a7464ec1313b91ab1764589450b5f00257981836b94a86942baf0b6eca891d011fdc8d6903419b065ca31194d6f0a0ce6e7f595e1c393c1872a13533e2b6c8ab97f4bbccfdda0d1c8cae15d397b1ddd0d2b54ea1a427a75ce67ce1b8ba6c6243513d7b05c8dd9e0f9612cb3837cf2e5913ad64e7dfbfca0f97a3c7a7274f2ca8df4e72da9464f46d9a19bb40f6371fab58abf697eb6bbdbebb73ba215b5e36eabdbe9c5729f9bed6e578a7dee772742f67b1d8ef7e249a76195e47aaea725eced25d767d214daabd5c156a45c9e8af999b1115b75efddc6f09eda1cae8c76b6abadbf5c7484fee1eaff6acbc3b5e6705d6d0d3716b47c1c68f9e43996aa1ddc70a4d294af8979d07ef07766302bbddf801bf129038c8a3647de4c819f2d4961392e52b0b2a4c97991a7fc4f63c7c644248b14a3721dd60493981b6aa3b0773a1756b1571c6ea88667ed77f15342d9024caa7e40b198aa1a7d6f66c256ccc4e6ad877641e7395f2f2fd0ef3860079299f2090954cac2dd60ae6c1705a681be64a0f2d1faa3f5f19d4b0f6b761549d38aa4d0bc44062a50c65cd526a80533e48a0928d192abe2426bc6b31315caf008466fc82048127772e0a4640b0c2a9c9e19e7af34121b9bd5e934a996806f41744099b148319cbdc5394e533903378ae764e2182d826689c19a4cc625ac89480346b024e625f79851c10bf3306b2c3062c5cbb5cc76af64b61564f6f8c502da78c6ec59c30d4ba10d2f2f7e7ea517c3e28acb8b5fab645e921c5ebc30f4348af0655c4c85bdbcf885aaab60e0dfffa3b87afd2f7125facd76abd76f757bdd562491575274782fe6de7edcee44b2dddb6bb6b8dd948d738613c404542e430bdcac5d71b31db8593f1e7d35a62bdffd71ffce448ae13233c366e028a5c32ac2f6735b296429162c5178c27d3a72b7b63c532e82ec4a95e761e5c8077e8b8acab89e65a2d59b82172165c05ca9d8ca2a0b7f98c2430ef33bc47b43a1a58c2c673000c99405c2c989986b0b7d8b08f6662be0b95232cf4a4746d6e461b260461732174ebbbcf8e9da2f32e14c214b71d38d97467b882f44c43203cb30c0cd4b2b4cc1920631b04318bdccf16516016dd0019c5d996f9156b78c776b11741a387f692ba11e078e224ea12e7b2b226aef0773f96f105055f15338be11c89b410d7f01ebed0620	2026-06-04 05:39:11.387356	-7934965288240704543	1265
182	\\x70726f64756374696f6e3a6d6f62696c655f6170692f66656174757265642f64363765363633392f6c696d69745f35	\\x00118119103f774488da41ffffffff789cbd964b6f1b5514c7edaaf278ec38b69b367d108871692805bb77fc88937b1775503bc8246aabd608892cac1bcf1de7a6931977ee4c4c4825366cd820c1274062c116b16289ba61cd928fc0962d4870ee1dbf9226e629167edc3367cee37f7e67ecf3c9edd451096bdce21ed65dbacf5ac5e4233a48e0c4bd36ce594c747dde0fb8e7b68a69c1064f074f13446be354dfe75d66270cbc6071d1f54237e82813c21704731ceef6a27353c7399bbbd4191faf4c6e607e97b901ed311ec317c6e6e0b00f6126710fa8134a83e7f3de241218043d803ca243f7a59f9d40382502affb849fbb1fc749f12494355b15c3a8aa9af5d0e541aba86df6d4313d60bcb71b209cb5f83e7305f42810cef77dcf0abb5115ade2dc3bbed765fea1ba636e87fa5dcf0273f6e1a3bb2584908156d595ccae703bf212c23af4235ac598b2cba6fa0e3dec78bec57c8497b8e88870672c6a87b974c7619689afc115afdba5b20cd5a2aac2c4b99e08265e0bf234910de14c9706ace7f987471a89f11c49b48a0b7729f70f0b0fa308221a17df57ee69f529b66338edd300c43bd2f01c3d603e589b299c5282c33072500d773b4a4de8024ea369c82af27076bc4174198eea134e3408a1f34ccb2d3c96169539dbf51994687568f01e2e6c74037ec01e87fdbee70718b741f8f779b0fb81e7b2ed642bc4bab464ee7dbefcfdcfe64e3381f58fe00a6a15f31b82d3db9b9ef3840654c66d85e4adccbb91df7709528229867d6b9488bc29a381c738127834afbc78d3d22e159dfdd00978df619da72185ee03cec4d4e446d85eb6984dc11370f439f87560657238333c896ded68514e00a71cbac39c5651370a1168e45253271727dce577c2c3a9f52069087e690cfb68d4647ec810c9227c717c39421d2cccb69912731c6719e264251fc375d0511919f8aabadca176c0fcf110c1f3223da0dc91b9a231f22cceca31474db6c94a5bf593275568a5326ec54e54a67a213559bfccb4be4eeac76a26ab88349a37655564ad799dacc377cccf6dc5093165f012047725ae494b58ea9e24841d7ed56dad56272904da94c81cbc323c46e6910c9b4324df4c910b5c230bade2fcdd8d56a3ba61aeab0d9faeec12228b885c3ebec1e4caf4ead695e92a22d74665bf84c892495e36c92b265946a4305aaa669ebc8a48713b46ae83e935c87f030a5a6993d74d72b34dde8042b6bcc1847a726b82601378fbacb2fb6c0a4133329d972652feebaeb7db04d9a95aad5caf1383cf93ca10ba7935a43378831995948ef5b69c4f76f2f4882605ceab72822078a379872cdb891a59b375a3dc5883a1dd81a1250819f3903dc14373e5582a5babd60088c4eaa9346cc9e855191d950d197d0ba2eb5340ec4b20b4291e2c11f100e59fa4e194564ed29103b40696cf06fe808df848bfed0581c386d597c8e2a8c899a8d466a0d206c6cdff8e95e7dffc8aa700b81799be3d8d9559aeb74d82a03d0301253125ae23c54d8324a25a7941603b69b04aa4f11e68bc77dac6c5a4a64931bce5efed5af5dfee9aa9f433a57ef9076150f0ecb325fcfdf94fd74ee802a62f4e937096ab5a370d9e6c069f1befdadcec5db335a3a2349cb16df06a349f01355b7215eae5f51aacc2335885f82fc35d9089322a517592e8fef1a5de843d4b56606851a694cd3f64d630c90a2459210d18eafa1ae4d9843ca9d546b95a8144f14f20d38da9a5db935c2cb69990ff070a0f1f71f9b7a1608c10d12d3105091a4212ff142881b7b330d1fe1125c6ff45c92d98f36f3f2efd30357a14991e9ca4e4cf5c2525306f031e642346f4d90f49393aa9ddd9838378f0a4acc30f67fc4b18d99efce5bcb13d0547526648552674d85aa57a3c49fc2bf9cb6c80aca7251a6228d7be0a84409a353b59678604e46b48f77194ec0f9caa3507	2026-06-04 05:39:17.112306	-6400542018677114527	1579
183	\\x70726f64756374696f6e3a6d6f62696c655f6170692f70726f647563742f64363765363633392f313036	\\x001181b387bd7d4488da41ffffffff789cbd56cd6f1b4514774a657b9d0fdb49d3b4a160e37eb7381d3b76d2cc5c1c485c96b6a86a8d40e4608d7767e3a19b5d776737ae13c4a1572404bd55e2c08513071027109708fe076e5cb8f10f70e1006f66fdb149d31021842c7fcc9bb76fdefbfd7e6ffc4e2677114e7093bb5873e816d30bc9fbb41bc7f1f506ce984c181eeff8dc75f4c2b860dd47dd47719268e054c7e306b3e2253c637261b881e3379509e169c16c9b3b9be1ba96c4198b3bd41e2ecf8c1e609ec11c9f6e321ec3d343b3dfeb409851dc6d6a07d2e07a7c7314090c826ec339a249b7a49f154738257cd778c84fbc338693e261207336cba5d2a2ca590b1ceeeb85c4ed4db51cef32bed9f6114e9b7c8b39026a1408673b9e6b064698855e98b8e5b906f37aea898916f50cd70473fadefdb52242a88496d4ce645b384db985b006f508bd1053765954c7a6bda6eb99cc43f81c174d11b486a03699435b3633eb781e765cc3a0320d55a2caa28e339bc21f79cdc8d5083684270deab34dd7ebed26488c67485c2fccac51eef5f2f7c20822a48b6f29f771f52d366278dca33e80b79bc013749b7960ad6938a500073232900d779a0a4da80256033664165958db6e37dc86a5fa8615f503a87c5277f20fa4459d9c363c06299a4deabf8bf3ab86cfb7d983a0d3713d1fe30600ff1ef7db1fb80edb48ea01d6a46572fdf3dcdeeff5562d8eb51dd8417a21bb2a38bd71dbb51f529fcab87a405e9f7c3bf4fb3e4e8ac062d031070791eb321a780c2381476deef987ceb5a9686e05b6cf3b366b3e0a2854ef732622cc0d643b67328b8227c8d1e3e0d78496c9e0c9fe4a6c24764f4b0670caa62d66eb05ad940f8546666b49726aa4bb6c2be845da838c43f0d9a1d8075493a9be86481ae153c3ed50ea606196c51498c33839889396fae8b783861650099f55db4d6af9cc1b92089ea7e836e5b63c2ba491a7715ad21c16d920971aaa9e2c598452cac352ac7839520ba9c8fce5492b2ba4ba2f67b284c872edb2cc8adcac15c80afcc6fcc49d3142ea101ccf7acc5674f5952e3652bb4538d091124e9ac25471927054ffa766252a5592428057914cc07b92c7c81492476510c9d63432cd1364462f4cadadeacb8babf515d5f5d16c6711398dc8dcfeae2667a2ed5c55a6b388cc0f4a7919917375f24a9dbc5a273944f247361a790d91c2468c9c07af0b90d245c8f152835cae932b0d721572bbe37647cd41ae8d945a03597e5a6e7f14516a3d349d9426b2707cd71b0d82ac54a5b250ad92129f22e5be36a714972f9025505954d0561b92c6f4e892090905e725493470b05cab919c15af909b96565a58be09dcd680db382143d9a40fc8a67671df515662b102ba892f1d2a9abb32faa28c8e164a32fa5d88ae85ba511a694bf4b59dc78f770622d11eeff4171a24aa44920491240f13c98995b1814cde5c5b5aae2e1f2693414e478805adac1c5b2cb5ca11caa84b65ecbb35a3c2b804d4fe75fec18508dbd743d3170785215d7f749f5d39e00aa62f4361d409024c4a08241153486e492413916633451fc5e273ad7688280eb65e06fab66b7aaceb75d900d5f1375cdfb7595f07c563415b429523a06dc0a572eb98d81ea3eb7efaf64f1c416c3d347d7758d71de5aac02d46c15d96e0661b4cf8f9fe25f7dc9df6cf62fde525096cbabc284cf512ff56ad55f47fa8f5ab4f727b537fbcff2482d2d7a129751050f6596e2ffd6cee76c4f5c3d0f4f30bd4baa4fa5e023a04b2af33cd4a965839c472ec2980091f87a15951ad9f281ffad7701c142b47f57c435e5cd5ff04c7f300dac7f6fcd308385743d3fc411c2f80fd9b5f17f622aed742d35b231c018f10483ce1b16dceba72069c36990d1384d78359cf727761341f0d05b60b93a51c893700f3a955dbceeb8ec9d5ec85e780011824e5bff720825e38bd58ace65b81e00e13226fd25e3879ce8a36ef74e4bc63b4a907b3a75ec8d53dc6f2037b9eb6dc6d96ffedc90f55a424fa3753385cd2	2026-06-04 05:39:43.07828	1182655415519740873	1634
184	\\x70726f64756374696f6e3a6d6f62696c655f6170692f70726f64756374732f64363765363633392f3635663232323764373636373966313561633831393965646565346235623033	\\x0011811e76377f4488da41ffffffff789ced9d0d901cc77598710706f703dc0120418aa4286104916740ba5becffdeee92e6edddedde2d718703ef871009c9a7b99ddedde1cdee2c67667158d2e5b028c751688a367fe41445b218d96468c9a5b2a5526c469629848aca25c7b1224712299653925056a2309532eda4a24ac555ca7bddd3b33db3b33f585cd12c0b1279dceded99e979d3fdf57bfd5ebfb966f8a1a1d4b5354357ea05cbdc54644b3e177e682a35a42aea9da991aa5c21f96337cd66d6369633eb8bf9a9d5fc5c563a173ab5f0b17da97dd9f5d42185980543ad59aa5ecd1f1bf8c2a5879f3b438c222958d296acc9d50291f4a264c9a64524b9aa4865226b56597afb85c75ebdf4dcef8e8daea9d59246a49aaea9669928709059912d55325438f2d2c34f4955dd922c5d97a08905629a4499748a0c792730363a36baa4574b93926ce87864412a19b25a3525ab2c5b5241d7b7a5a2562f161b12394f8c8664a9150297ffd49ffccd2bbfb12f3dbc9e1aade1b58aa3e1c03409a7ae5354b3a0d7abd6262d0ea6ae3589a64123d9f799d1d4a1a25a9535e7eb8dcd03885120554b2e11754fea5aa7d86ad4e034cdf39e97b53a16e8865a6a9e090a4cf93c5cc7dc942b58afb82f981a352dbdb0ad0ea786cded7afed8f8c26a26138bcc8562b4e123f5aa6ae58f0d9d2ad1affb77885a2ac371a1d441056eb26ac22331f3c7f6d05f0fdb8f9836277fecc0028ad368d0df0e6cc9464157a0f8e099d5f9a920fc2f364d7f192b9bd54dfc29981a811b73ce867757d3e4c6a66e28c408a66e51cd4db3bee5f4844d5295b734a2e45237c32f7aa1206363e8bdd256e452874aa6c56bada7aec36f4df91547a28164323556902d52d28dc64343e97dea91f450fed8f50bece14e48cbaaa611cb648f50adc051c1d47efa5ff3dc9ed47e03ba42b5047dfb800c8f1d4a67f6a746e903808773081aa55637a974e166e01b7f3ad8e4c3f05dd377f8cf87e97fe19b6cd54100e34bfa8eb48645f4d2070b0681562a9bb2b5919232054b3d4fd6eab59a6e58a9d43a3c86b3aa55be4faf9273c3f97a6a044bc61efbcda3179ffaf5ade7f6a5461e845f82f9638733a62a9f3ca56bdb30fef0bcf97a7a6aec4956efd67de9403075b05e53f885d2937836a8e19c096accdcd27ad02d65d9dcacd4354bad6964f381ba0cb76fa9c4cc359f20efc7ef514851869ad03f0d15ea6daa4a3035667f01913e3405cfe01e7c06ef9dbd37339f59c84b738bf9a5a53cd020185c58fe18363b3d923f36f8ea208c6c2987ddd8944ec94615ee695b96f054c46ae0d0ff43187b63a3586b9e909a64c0b82fe89a5e37e88827d53272c394a0896549aed5886c60013b02c56fd6a0cd935219fa3b0c6ef93c1e39c100c02a710415754392eb5619ba1580614d878f52beaac02d5132400f417e408bbe289d86c76bc89ad690cc7a754a81b62ad09adf964eeb70624b2daa0555d6ec66b2839efcbc74b6dc90e6caba6e1269b6212b724985afd031d53bb14a28c0cf2acdb1db9b85aa163140064f7f796c7401fa8a89a42b8b22b074a95037e0fad8cb0be5ba55250d736c14da5125508bde925f83c2011c138ab486c2919680765a53d64b804ea956af964012935245370817dcd8a828aca25c5141048270220169155b9841e92238bf34369ae54f88711d006fca1580c82420193e41bb81c1e7e10ef004d180b4880feaeebaaca9f0fcd70d59512d8a03e99e669f7815e602684e016f112ee5c8d32025a82b1d773ad209267d0a7069969896b401b38294d3e156d66833e0fab41d63a3734c7c5050d31515be83601b52057ed46468dca25e2115592120667c6850690770463bf268111e1f4c08e9fdc1f4819989f418fc3baeee491f0ca60f05d38783e96b67f6a7af5347d247189763c9643093a1875eef30397d4330fd1e9b99e91bddd44ddf24e0763a448b6e0ea6dfcbabdf124cbf2f977e7f2e7d743d2d154762816028fd010ec299ebd3c782e90f9edb93be158a6e83a64c40db7e613d7d3c973eb19efe901753e90f3799f13800e2be377e744960c6d3ace87e2c4a9fecbd6a30970e815cc2c174c406c4595f4084af02e22a20fed10162381a9c4eef2fee8f4c2702f12850e24ea0c49de9f17aeae0ac5a9a2705d046b483a1e95430104d2649287d10467c53c9a167b15902da67301089035046395012f1502c9eeb1b28e12e40d917eb8526eb5d69f21bc0833ff8270f8e7b100145bfe6a549b7aa9426bf28d2e424d2e43d732b732ba737d6a595fc12e81a4bebab4d92fc746019863e3c98355052ca443aabeb8a74c6a076020ca9825ead5bd28aaa49aa29150cb908fa935437a1e34a96d0c9c805f856c02f528558655d81ca7a654bad42ed1d50dfc0f680870943b8a252530047201499c4384f24d532a5aa3d886b75033b30da39943530e0b0f3d0ee5a900d52ac537cd8bdb8c0da674e82a902edd359338b06b18f28cb46058e9050b1b6e870022347c1569fa71fab780ae84a15b022b0f1d416427593b689528337ac081a3045243dcaace83ad4b2e0beeb066052b5f0c2356194dbc37b12866dddfafae7e8473c52941acaa446cc8094b72459337589cac39464f847029ddb8446816587b785a75464e446dd84eb6d19704294a3435e90daa42d3d76a12ac808e00e560cb4ad0af26e20f934b508c3b9a191009fa3e381189fa3ef83d1779fdf1cbd8f0e29e83da1f87c3618e1436a7449b5ecb1dceba88a76195533797b505d871d77142eb926d15ac7c034fe64d9b26a66eae449e8398102405981e7663402d0d54e2ac5ad52ec81462878925a3027eb354d97959385cd22f4b8c9e226084a9f2c6fc683c1c907d8979dcde960f0e4f9d0496ebaf30f5316a9d4a6a68b9142723ab4a51493b2b2154cdeb929df319b99bb2bb236bf445bf4c173fbde756dba7c5d467df4e8c54f3d76c32f0a48a9b2a23ff4d207cbffef75fadd425593157db3499ffb44faacd9f4392bcd6eacaf6757a57331b71ef3bfa91ed31ce299b0a4105385d1b383a8d866aa86309dc100807951998249db40b81c9f553528b7a973c2564de8982c9449452dc8da14e5c104ccbb46053f9b65560ba75ca805c667a5c1473283151ff3b6b6c3b517075932e587a3ba70a0d002b0e46ee32770749853303fce922a2902566cad854ef86a555aa4ab390dd0e580386fbff0f227618665c6af095a1a314a0def6806a506198d44d0d130d7806f9641aa25ab6ceb28540532a57ca582eb1b38f53ff9799898917468f917656bcad4b5fa16b0e5bc4ae9674ac73393d2fca4949d944e9d109ab0a52b8d4b0f3fd30434d8b8a46a125b6d715a32af96802bc87f90d5d7c646dd8f6cbbaaef5491f96a05fa3320bf04930a5bc7024d47361bf89b424f21ed00cf90ca66bd02cf172454d14161a078b6551da7716b405878b00b1af416ba14c655c1b22dd4220ab54cb41a979f64c221a272b30887c2b537f08e28f8cbbac556cee0a60cdd0285660d9ebaac48706b8a6ecad249e858724dc65f328a421b2e333ed3f982aa6b63a3704286f12d193ee1af1519e703a95426846b3f710e5e0bc06b75348e3291e87ca86f5d2631dd237577c130faf637fe3c2510e22956f4253fc3a853550a134b84c987102637ce67d7f2ed6872e720181e75ad44b0dba032834fa48a6a39a8cf6e35074093431448b3750be6b04947b7617a0328d3530fd8ca3472c8d138e8cf6a15fb6a156d2f009569eb28704db382a3714bb6803da05fe084bb45cf6fab252600c71e486c924675061bd734a0a8c96008333c4cdbf45e1c3b40d420ca5cbb86deb50d60a40a0c686f35d9e09a176a4df45af80dac33f8dc109520aa39d9ad34082384a8915108821aa317ada6be43cf57d635624203a41250808af9d2c34fbb9420ba5eacc8546969abfdd026cb856d36da49410748aba4aa68a0c86ca930f841ef52709553aa412db94455a91d02743491d8b8947d7f1dc061ab8e708e1d5cb746b911192c31b837b8965903a4a85baa66d729431f562d8a368568200a1098ad1341b7eb3c2a993a349fc96773d1482ed1efa88c247a1c9587e9343a2fab069a593998c758e7fd87518c94482c9c8c4713c9784c892a72e4dda018756dd3e5b3ac0caacd8f9e78f61b1ec5088a96bd2cab40f9efbc79e93b1ec5088a3eda8665b7e313bd99b20cb5a385c56c563a17090697979a34fbce00ea31d23cea430b306bd0851b4a1ac48168e29f851106f3dfdb2fbcf4ab3898e64494615d4a30204745bd00c5828e65330ae724061cd3c18d88ce269dec851d3ee0612e86b9d751c65aed426e0c8ae69e0d14ca33db54a95b86ead85f0bbaa6800aa056e9c20b2e78d8aa1247231e5263c070a96b5bb686453144b106ff3878c09b9ce443bec90ae6d2023a38aa8b7bb586195d8e35f7c3173fffc3971ef9e18bcffdf0c557594b10a578d7c89c2ae85db256024151095b7a1d3502dbf4aa8052623a6657a4b9343af0028006fe50d2b45de0a0e419e5e4990d6593a1ac9f213633de1b7d62b11ee97308fbea758c3e67ecd1c7c8d3af9aa03f7ef4e24f4f907561bc58ace8cffd563c1efd5f7b74cf8a0714fdb7e6d002d90963ab8aed1d564c858fa421fbe36871281ab345fe0a8afc153fb80f71112722995c32e207f76027c186829d049b4b4bc1a65c67067eb77f29ce3c71f4e2e3e1f22f0ba2c9b1a26bbc52ec5635b89e0e1547a3d1402c960eabe320caa1876e80268ea74635798b68f9632321890b003a58531ea9c35bf546d3b70b2245e1a6ae777cb5dc41e9dbb367c653479c9ab6d376241888c6524748118720cccbfccc7f864b6ed1d441f473f2aaa140623a7513adb089cc331c2f24d44f1d91cfc3e0c5cb3347a4ba2f75101d95cc4bb70e62a63779301d83fb0b3bf757dc17161f78bc381489a60f14f7c5d3891cdec51e3e2aa783e9e4ccc01bd8ae483a850d0f4da7d358723b28ee77e4f002d82117b1431ecde54f2f80ceba9c5f5acaae4b53d22a2eefb330004efc1bf7aee2722cae645599aa87f0d651b7d177804975cd56e44063a13a9542d7d308200f48262cbd03006b2d0c73280b9c7be29ff7629bcec95a41ad57a0febffef2d8e84ab34d5b68a8d53450a5a7d0be5140c96435999a0ce759409f2ebdf816dc0bcc33dbaa828bed04d86e680ddb50cd5e2810687f95d53c4bbdefd2928e9ae4677e8b2eaad365eda2ba05cae9362135363f51ad19ccfe1231c646570910098c6fb485097559dbb6e9bc0a5d1726ada99cad4ec27d7cee2b18ebb02395b44601570750952717e03260239a742dd0d06122d1d0ac35eb25d990345ce4e78becb6619d6576f9048c4b6677db1636979b6ae868975281c3cd995e73b804ddba4a6fd9646b8f78fa58076b3acfcc66b3abdd5c73547f902b9e351e10bc2e0b5add22559007c1f88dc7be888bf945669d96e84f74a15023b62b883d43b81841b700b419af069791ad761634edbe95ba023aca71410d3861ff62dbcfccac3ea31b86aa80ad761caf6f770f19cc37cbe4f5c19ab22405f4926d6e31a30f8001fc0708f01ff801dc59ffcf2466e742732d00ef75828c7753cfafdb1da3f953309f915bf6cf792210a0e88fbd1cef5695cd863f1067c3fc55f85c85cf55f85c397c705cf58c9ed87c24994df68f9e6eeb75bb889e8db7afcf7a7802457fe2879e4e557dd0730ad1736b6ee523eb99fc52933da733f7644e675b16ef3eb037a75fb0001636563c24a2a3de594fb2ab08dd83da98a808027e341cca930e73eab6abafe951ebc6a0dd1ebd6161d1faca4053af56090671ca608c150c16eee85d8b5f24b261d98e05e9d2f32fb24bd0661af434d2960cd4a4cb77203f5d13d6fbb947a1201b8aaa9f97cd425d835be1c39e82c8018297141c418a4a2c6c20bd235c8fd42bba454c67591e4152ac570b7c4d3fd60a378fefe28c60eec3c52da2562739e98061d86610c3294776728121a36ce8f5125df5c43e043dc7c6d265c2883b693c38a27e8289ce54624196acea7100a426c3879d32d8ebb40c68b351ab2098cec0934697d13ce3545ed1545c49b65082a7ca205945ed1d448edf20148a45a3d1be419408be338e03a4cbbf2c55eef3d0058afed20f449daafa804846101d5b401d6869e95e40d05a762db39c65e11031f7aadbf7a847924641d4ec2888e38532d9deae9f10a21c9a1e44b69c05bd40c1302b71edcb09fec1aa1b55030053a5014f4f39ebec7ce54a98acdbf82f452fa4dbe10805f4d4b80885df33ce629dae76f4408a9868389ce063b8446982fe339818e174fa055591690b1d560804e191ea36ec9a0a98eda25b945583b9e868349acb9be9564fa862c9fc6540b9128eaf321e8c6e0c1b746df9738abb194dd64497c67256505ca14d9946dd384f14109310880570cbc0bd4ee5abf0f02a15d9d2d99a17e8b318f36bc3c88552e0042241830ff63136d4da854ff904c849c7895923186b060d14bb1046e711d448cea8856dcd13adb64e2ad02e7ab8252b3468ab7953e87099a09123b53a8db8e1eb8ee14094af3b0e1e1b0080e0dfb604811192882672d3be2b8d3dba3992dd423eae6b867ccc6cf5cf105c2a1c7a38f65b02183ecd8adeefb7aad8a92a65080a4680c82f21446e5a585dd9383defc452c55cb1544fb4b2a3851974c1dcd989e1a601a7803bd0923bb54b6c5ddc0e619c60cbe22ec8000a38344cdce3e180c1a18788a1dfa69ca11fd65b96ec77031cc797377299137cbc54e42a0e67111a2e0569d596c269470a6c50cfc16d9fdc1165ca5ae838144c2788616c7496503fa65586c1c5ef1406015791a89eb556d1b7094cb730723148f425b0701462bbf03de372422a1a8d261b1cf0ac535fac3dc285584d1e280b3aab1d5f3ae90c583899590535c6ec008779d1d9205cdd050d060527f0d2b4232fdd861ef7aedac37e249408c7d2fbe1bff1440c877e8a0e7df83b5e4f47c7698465d80eb01c2da29b882d721687635048a13078c78088856c7c7a3a11be022c4c277b8f046b8f85dec22bffe7d8577ec533d6a1689f1f163a55655848bab0701f62e1b6c5fc726629736f469a5bbd776d3db324adaecc9d92d6324beb9e5596ef0f8a431a44b32d996868525fdd2286bbca0decbb32a8fda6577598f0ea048e1282f10e066a964d65980656a99ae2441cd00b3578804a539dd8d2885c2873f5a145bfa09028180df46c99bd2cdc2cdb4d70c6af1d76e46ea0a4a9dbb8690d9a63aaf5ca24f0a15425f8d1c71ac10505f437f2f82636ca336e6d7c9594a8adb286f27cfb85971fe121d90e6c5d58b0684801ca0494740cd6e6620242a1b2ee8ab8b4f9e1346cb1a1b0902454095e6e224ea5f72a118d14d01c6c5844d48c50bdc0a50697def2455f0d4888955278ed7626869b1a8e9161d8f2c05b040ae7abf849a62b1d26914d9d4d0cf3c4d22fb0750e203635b07630c0604746114f00a32b7af5040b6842ba1b68f61a268647158c3a6e1e3069d03ce13eb6e11025cdfe50683ac058b34159b3c158732009a889750ee51e8907e01cd7a907b815339d989e9d0df51dc9ddaba7b3a740ee3110645bd0fcd997a7eef1b82aa1e82ffc40d3a92a03cdba0b34e71034130e682860e656296c18673ceb295749739534ffc84993406f5071341e0fc442089a1a054d8d81a6c76d232311a803ac39c85913ce458299d9be59137fc75853ff76fa9c072050f49ffd5813fb70fe973c55a1e87b026b74176b3e4a576eddaca19039b372761e032fafea345749f3f3431a3a157395268ea4799492e6d1cb230d68355120cd3827cd6c2c1689b4aecdf64a9a5ea347af9c3447d535c5830f28fa2b3fd274aaeaa7d57ccc47ab7191e6aa567395353f5fac81a9783fd562fad3686606cd01519f09c533b3f3b1be29b32b9ee89e2873f2bf9aaa071d50f4233fca74aaeaa7cfdc8b94b96171e574f65e693573b6c5e933b017473bddba65c83bf0d4ead5a28aa38328ceca6a99c577d075557b48d00e4019e2f1e790ea838d0a5daef77876d6cb6a615b48b433c10fc14dad3b845822589817b9a25ee8cc96b25e258d4e60f1df0ec671e376eeb081485dac054b924b785bb87f940663ea554e100e60db5fcb76954b973ef3d9b1d1bbeb708b6c6b2d80b1ca37b16d61239c055aaf23d5660abd63af3b1b1780415073e8c985b6bff832ae87ea56195dfe654347d7eb9c5e8151267877705f0c9cb54294e60e79073e5eb711bb67bfad6994361578b85b985ca962fbaa6d9fd6591baaccafb5c1fd56254ddfc107c6769a893bd2b0b4e63893dad1286407a333761e27951a3c32d3820e53289f407ff205a90d659c0d69169127eda07f74dd1b5be84aa2847236a639731a763a7c44dc3f146d6e071efc2aa5cf577dfd436c6de674663d128e4673c1bef912ed518bb996ee81e1e25ce3cdee2912bd2376de8a3c91f3b0048a5ef5c34ea7aa0c3b5f7561e723d8e6f731ecac8186b324cdd28d1ea1984ba7f97baad34037c7598fefdb605bc98e9b16cdee659a27a42d423d90bff9bc0b258a6c6ca38f542d95a1bb803e407daad4d3043328f4381c0305cc9225d1b45936b06cca39737b47ff720b882877a0b3a3f7a22b7ecef0f0410740cd141ddd4054a4b1324dfc3471c93dcd1d28e1a316b4a2c18d12ca2d95bb790c52400daae1d55eb20d74ae520cf0281b07014dd7b2ccb6c0415de6bb766306f14059d156b169177a77dad9898b9a87edeab6d1d481cbf92aa640b0388ff96e40c761d81b8fe0838b48fe4042f73dddbdcdb6d48a04a248121f81adf64c744913b48ff326140f26c2adbce935a2653ad23b706606fffdc095f9a3dffcf264c4430c28fa3d3fb874aada9a256816d172243fbf9497847c82365106fe9a8e7f4f5e40d1d55c1115766ff48910bc8bbb3e2779f63f55d154bb4e8e1815eaa345cb8245dab289dd5069e081bd5194559e433d6052e2fb69ede482defda10e81442f26dbf44abb976c0f0015fdbbb8b18acf58a140c899b1dea233d65bbe3356333833198c26b37df7a078974c53bb15138599e9d65e7be34b9e4027284a79fb4fb7aa6c727acb3539a5e8847a57666121bb7aef1433b7a7a01739d3d25707e82c4b551c8c9ee3dd6547a6c984be4699070085a7c376b9359f8fa66260227b6e2b4649ae82aa7b975c2ae156bb333401109be4dc7bb2b183d6b9b1ee897f6abfebafb91791ee8d6cbb07912669e1fd1fe73c986ef0576e4fe3f94b74d6635b20651ab4579e14763fb2dee8de3418b0fbedabaee80be997c5b82c3a373e2bb58fd006eefebe33ee5a54b356537a9e8adca5350778922cb6b531d01c1dcd789f81411c1df0d7677438ab52c164269eec7fd744ac57bef6343ada6a6e438f1fbd78ef535f31851e7f8015fd0fefe0e856950d0e908a30384a747feea9c5cce9f9b5cc6a7e6d632183abde9200d93d4d093b791c066fa412bed157c2435cc2c9b9442239ddafc69c7c8772397c1300f2fdb52fbc2188ed5bace8e35e0977abca247ca34bc2cb2861e9d4cafc4a33327c31b37a2ad3b2e4f73783a77445e721dfc71741e1954f6074b82cd981de541372b206b8063f9d6c2e3dfc74c98948e4cb3a3c189999f55d43c26dedad7a85f1db3c661b83f35c7b46c2fd449ddb3155fe41e7b80b85aa8813d242dd7269aa74463669fa3faa70a23eda00b6896b87f684ee8dd58ef61668aea1d2df26c69c4b9e35bba01a18632ec482734ee6a840275a22c21cad5858d97362ccfd963caf641fca127dda383910d796975ee2bd85558e96306f3ba4db2fdebb8ffd26996c707e76beff30ef5e43347721ccfbf5b5bfd43c7a0a14fdb55f9877a7aa3e61dea7295296f2ebeb4bd92654d63218eaedf658fea7c125d5b234226c357160c275d2264f3843c45d6da052c05c0b169561b1ddff4435f8d9eed7311d42a32b52ae704b882b0c791760d2790b4ba7b8ebac6764388010cd56710f5bf71d2a9d77a794e9f19e2d241c1ba785305ac19742b79140fb5585f0cc5a5d3c2557be7dad95029d3c10b4b6ed7d60a1f197cd0c9c64bb6b22234d5d2f3c9b88f7ab89247655d5eb4c8dbf9d95c5ec054fb1a2964407747348ea1b9ff65485a2f7b5d544b6a821b49c595b595995e6334b5e054450f4228ea2778e8af7dc60ef493b3021696e3698ed7ba934f90e89fb4f41609f492ebe26c8f03fb2a2bbbce2ee569589fb9c4bdc0526eeec7c7e637935734f8bbec7c53d14b773750c9a54d6a66f571ee6b29d0f4712737da7624af6ba0cbd0bb2bdf5c44fffc2233028bac74fb69daa32d99a2ed92a7455687965e5f402edc8fe064b389070faf1a354b68f76966d261e4d4ef76fb0ec4af8656f06cb5fbdf6ccef78ac1028fab09fc1d2a92a93eda32ed912faf284a66cfd7bed7028c2bbed67a9683f7b7988988de532d1be93a0277725faac3751ffedddf3ffce233f28cafb89ba535526eacfba445d648858595f5cceac9fca5359fbf4647a989facdb28c9c15c782ed4aa24f72adb5d89b7e94db66f59ffe29b1e8141d1dd7eb2ed54d54fb62126db8db5f5cceabc5f42e83f1ac85ec07d6504731dd39dd7e859299465dcc6448cd6548aae8cd1cb75d48915cc183d29b1146d347084eec30525db891e116c74db09c5d6dc58563fd3761edb199a4dd544bf96b0992a20e59c2ccfc29e274f72679effd949f25c75e58af64b77c812b81758d6559e048d2ef2f1d4e98a6a801500fa1abd386695658b87cd381921e33534952e3ceac522467d28a4063f8108792e333163b3413450da698642afb521488bc7a9509354583f17328b35f1fe2d3a2ebed501efd003c2b9d968d61917fd2475ee75f6b4b7f2bcd3d90143b150787a3a164944b662c97871fadd90b1b06b9bfa4be5fcb3173ff7514fc64228fa8e5f2ae7ff70e4eb539e8c8550f492408e6fb9c8b14a77519f595d591396ec6633ab99858d9635bb1f0d82a965ea7ef6b5bd7d7f8a6e5f64bfbbd6e7d842b790fad80e00532e23870c359ec1143cc3ae655b7f8eb157a99b058c5d73b226371307d0ebaa0f3699e5c91d10deb595c0a2411ea823d4ca75f6439f79633aae018a612f976974b724996e9b122276194b034e6bdc4b0357626a5f417286d52bb6b841e17360fb130adb9f745642a663d9d9b9d6cc30bd9adcef901282d9997f21f3eca0c78e86a207fd123977aaca50f213174a749aa27155dee1c0d86f929d07761eb0f5ba7126d07110e7b89f30074f0fa038f79b4a3814ea2743632735f9723234e63afaa8b24f1cbdf8df735b338264ee6245af7885d8ad2a2668045984a1493c37e3219ab6b04d5ac6741cbea204fd52168e433f1967090b83a1741a3edfae1e4cdfe124443cec49883833f0dd9653e3c1c9a4efe9076fdacb2e303378fd5e383d7ebf5d1d5c1a10522286e966fab54c2eb7b47236bbeaa7873edbe9c5240084227331d8af2679b7ab9a3cb4d9a56c02ebe8a42868d75491641edc2bd639edbcd638f7daef2b694665722d9238ba3e4cc2768a7a15fd1d924a37c50bc1dca2b2c975cd98b024f6febd883ff8dbd6f7094f792e0cda8eb3e2d88faed9eb6ac23f90ae190e869550381825b17822599c0ebe1b74cdae6dea4fd77cf6cc8f158fae09452ddb42b0fc5ef289198fae0945af081304f41b6182a8201f868414be0a8f131b78c527836fe7c515daf90e29a6b2a31864c7d821bcfbed9fd5d10bc429f74a4f3d3014ec66ed0c7c7b1733fcbef607ff4f7c47429615b5bc4ea15b55e62e7b45947194be686e6de574465aceac6dacfa45920dfed843e1357cd9cab20ce05425aa3d51d5bea6d7a84ee820822a5ffc6d74eced1f8810641f239ef32601b3be858e383b29b898a60d1928750360f39d50c2db6d85401fd1b467016898c787073f02fd74fa12018c5e6a795714862a8af9d6d884827a62a04b96708a7d2a032c32d9cb13e8fb1e6824dda4d424adeae41e69bebe4f2fda493e0292f3322ac70a6abe0898af1dc059ece4edcefc556838f176fc355795226644e2c9c89b99f484ace474a9decfbfe186f9112790251749c4fbd665a397a9cbbee3ef14084dc70aa4109d262458481613ef0692776dd3652ba908f28bcffcf8d70470e8ac68dc0fe49f787cffc362da765634dcd6db136b0399d855c8fcbc42c6c23dfb31ba4809a02952ad11fef69a1c643802bf0b0675281b8b47fbce0d12bdcc68ba777ac0cb89b0928c91c2b43c4d82f190f26e8050d7365d7e9226a4d0f81fbdfe9887425074c48f429ffef8dffd330f85a068accdcb563699b1b9715a3436232e63f30b3d646edb70f604f692c37189ad76b6eef473e771eb35719b6faa36ba3dc7be2c5d4fed9eb5cd5956f4a66d135f99d61a05d83ed5a393b6cdbe3b6fb09e2035b483d9a2a8f3d639348a0b56d7bc6d2c086f42e2ab896c95b19980ed8cdf3ba79cbc8ef33a31ab971e7e067e2784060f9d6f7843197df7f4395bafef61ed95b28264e8069ee60a662f19dd7834214beb86fb88f9bb41dba478e34b9bc84f3bbd360d94b4cdeffda1403046223435412018864f00d44f50a07e62afb065383c1d6f4ded3633a8eeb5370cc30721b35b241bcb859d00f07e123e764b1adb53c2c7de32bb6d7de0a64f7ad2b541d121bf0d369daa32d5e511970dfa713f6cb8133efe9bcb48167b151f57f1f1aec34782e1031e7082d1e3794a8fe77ba0c71d03625ec851e70dc1d9c415d2a3d7ed55bb408f974f1e79dc830428bac18f1e9daa327a3ce7a2471ce931b20e8fd359c3b2179e46a937a4bbcb68304abd1c43615f0f474fca6daf2936afd0d1f1c15f3f7af157b49b9f14e4738215ddec15e5ad50fefbff257051a8fa2156b4d8d65b9440511e5ea7affd607aa82352fe66afee2ea3efed45611e0c474c85fedfec57a8b14eb3dbee398f5e02a98cff9f8f3c2208eaf758d1a857a604fae2c167de734aa87a3f2bfa7a53a6e3a24493344ef0ec6236b33e05b3db867be3df9becc5836c9f26901fdfa162b9de278efbddeced7fb3340335ddd18ba6bbf32a50302ff9cebfb3e8829572346d719b6d7fa60517992a197a1ddfa887af04743c2442fa19ef3be3793cc0a468d97bb6eb757e813cbb47e7b580d81c1e7723783ea8658d2f0e61cb016501aba6bd1710660cbe13f06b2c9108bffb96a443aebd80457b8f8b6b33e0d32fb1f77b6af68b2e1471872d33cd27b8e58d173debbc89b58813d21629e1ac433d42ec558e74d640f9f320a1e169fe22a5c14b94f8977cdd368e913d379bcbf98425f6bc29b0d7b7be5fa1db1ab7fa7df711eb7ecf563f28bae4b72bf0adf80d1784aa63ac688f00a24b2ea69729d31fbc70e1413e56462e3c687fe90141c901fe6ac1b9f97822d67fb07227acef1e81269e387af1671f5cbb5590d08759d1735e6162d53fd69f39eea90a45ffaa0d813414e57e047124dceae4e96d82dc83e21c36155f94778900e8144bdf9b08734d111e5ea963845f7b27cecf5efbfecd1ecf0c143de9e7c4e95495bea67128994c87d5034e1cc081ce7100c5a150d81664a2dd4b18d3d3f06f726650ba06bd576f6068402c908ca2ef1e8a6e5707fece76dde3f5c6e8f5224274c09beee88081d7d3078ac36112b62fe8521b07be0b17833fc9e27028398d977b1d2e371a4f042261bcde145eef36215240a51dc55414fe9cc560eb5890532c7c0df613f8dbae9f8ce229fae929573eddf7da533e04cffac133fff679e1f10759d16dde9ed2ad2aed29c398c927ac0e395d65a84bc8c8e06dd7d8b2f479724e2f99bf86023b551c0ac7f091cde32353851eb20f2f331a890a5de475779f1c8ec2f4039d04c6a16f2779133bc99b7831e8b6f462f06f9a7ebb5d1d7cef39a17fdc4f537ba172887ac8995515f54329e400dae93718aa15e4b10aebb4bbacb7ef2e437d51a593e9b2fb7de5efbf7dcb9f7a3a0014adf8f5954e55696c1155b9d511a7ab8c748b01c2514e25d86990fb3fbfdbce099d65987696709327d0ad229e6e59b906038e6028863a744c8cc48bd817439b142ef700f6cc7fca2e963a64e996ac6dd2b7c3aae1ff0f7f5c8f6c	2026-06-04 05:39:48.613738	4706912690735282116	10236
191	\\x70726f64756374696f6e3a6d6f62696c655f6170692f63617465676f726965732f3862643463616363	\\x0011814999f8e65688da41ffffffff789ce555cb721b45144d5294e34785323654b6b7bc6025eb6529b2a462118a38c885e35072ca0416ae56cf1d4dc34cf7a4bbc78ac8c61fc11236142b3ecb05ffc1e919c98f60d8b162a5d1e8deee73cf3de7e883d5efd6df6d0c1eaa487d3458d322e3d1cee32f84b273fa940e84cde8c0b24b56062bcf4e069b113b6955ee95d1a39dfb7f3ef57424ac48158d85f609d768c634b14a4f696e0aca0b8b57310ed98dc3211495e7e6d64485f48e9c29ace488226559fa744eb13519795b388fb7a991222dbbd9ba3a1d1776d16f859e322947d69850a8347a44a4022a7464ec1313b91ab1764589450b5f00257981836b94a86942baf0b6eca891d011fdc8d6903419b065ca31194d6f0a0ce6e7f595e1c393c1872a13533e2b6c8ab97f4bbccfdda0d1c8cae15d397b1ddd0d2b54ea1a427a75ce67ce1b8ba6c6243513d7b05c8dd9e0f9612cb3837cf2e5913ad64e7dfbfca0f97a3c7a7274f2ca8df4e72da9464f46d9a19bb40f6371fab58abf697eb6bbdbebb73ba215b5e36eabdbe9c5729f9bed6e578a7dee772742f67b1d8ef7e249a76195e47aaea725eced25d767d214daabd5c156a45c9e8af999b1115b75efddc6f09eda1cae8c76b6abadbf5c7484fee1eaff6acbc3b5e6705d6d0d3716b47c1c68f9e43996aa1ddc70a4d294af8979d07ef07766302bbddf801bf129038c8a3647de4c819f2d4961392e52b0b2a4c97991a7fc4f63c7c644248b14a3721dd60493981b6aa3b0773a1756b1571c6ea88667ed77f15342d9024caa7e40b198aa1a7d6f66c256ccc4e6ad877641e7395f2f2fd0ef3860079299f2090954cac2dd60ae6c1705a681be64a0f2d1faa3f5f19d4b0f6b761549d38aa4d0bc44062a50c65cd526a80533e48a0928d192abe2426bc6b31315caf008466fc82048127772e0a4640b0c2a9c9e19e7af34121b9bd5e934a996806f41744099b148319cbdc5394e533903378ae764e2182d826689c19a4cc625ac89480346b024e625f79851c10bf3306b2c3062c5cbb5cc76af64b61564f6f8c502da78c6ec59c30d4ba10d2f2f7e7ea517c3e28acb8b5fab645e921c5ebc30f4348af0655c4c85bdbcf885aaab60e0dfffa3b87afd2f7125facd76abd76f757bdd562491575274782fe6de7edcee44b2dddb6bb6b8dd948d738613c404542e430bdcac5d71b31db8593f1e7d35a62bdffd71ffce448ae13233c366e028a5c32ac2f6735b296429162c5178c27d3a72b7b63c532e82ec4a95e761e5c8077e8b8acab89e65a2d59b82172165c05ca9d8ca2a0b7f98c2430ef33bc47b43a1a58c2c673000c99405c2c989986b0b7d8b08f6662be0b95232cf4a4746d6e461b260461732174ebbbcf8e9da2f32e14c214b71d38d97467b882f44c43203cb30c0cd4b2b4cc1920631b04318bdccf16516016dd0019c5d996f9156b78c776b11741a387f692ba11e078e224ea12e7b2b226aef0773f96f105055f15338be11c89b410d7f01ebed0620	2026-06-04 10:53:56.010026	60795695400307794	1265
192	\\x70726f64756374696f6e3a6d6f62696c655f6170692f66656174757265642f39376563616235392f6c696d69745f35	\\x0011811f4ecce85688da41ffffffff789cbd964b6f1b5514c7edaaf278ec38b69b367d108871692805bb77fc88937b1775503bc8246aabd608892cac1bcf1de7a6931977ee4c4c4825366cd820c1274062c116b16289ba61cd928fc0962d4870ee1dbf9226e629167edc3367cee37f7e67ecf3c9edd451096bdce21ed65dbacf5ac5e4233a48e0c4bd36ce594c747dde0fb8e7b68a69c1064f074f13446be354dfe75d66270cbc6071d1f54237e82813c21704731ceef6a27353c7399bbbd4191faf4c6e607e97b901ed311ec317c6e6e0b00f6126710fa8134a83e7f3de241218043d803ca243f7a59f9d40382502affb849fbb1fc749f12494355b15c3a8aa9af5d0e541aba86df6d4313d60bcb71b209cb5f83e7305f42810cef77dcf0abb5115ade2dc3bbed765fea1ba636e87fa5dcf0273f6e1a3bb2584908156d595ccae703bf212c23af4235ac598b2cba6fa0e3dec78bec57c8497b8e88870672c6a87b974c7619689afc115afdba5b20cd5a2aac2c4b99e08265e0bf234910de14c9706ace7f987471a89f11c49b48a0b7729f70f0b0fa308221a17df57ee69f529b66338edd300c43bd2f01c3d603e589b299c5282c33072500d773b4a4de8024ea369c82af27076bc4174198eea134e3408a1f34ccb2d3c96169539dbf51994687568f01e2e6c74037ec01e87fdbee70718b741f8f779b0fb81e7b2ed642bc4bab464ee7dbefcfdcfe64e3381f58fe00a6a15f31b82d3db9b9ef3840654c66d85e4adccbb91df7709528229867d6b9488bc29a381c738127834afbc78d3d22e159dfdd00978df619da72185ee03cec4d4e446d85eb6984dc11370f439f87560657238333c896ded68514e00a71cbac39c5651370a1168e45253271727dce577c2c3a9f52069087e690cfb68d4647ec810c9227c717c39421d2cccb69912731c6719e264251fc375d0511919f8aabadca176c0fcf110c1f3223da0dc91b9a231f22cceca31474db6c94a5bf593275568a5326ec54e54a67a213559bfccb4be4eeac76a26ab88349a37655564ad799dacc377cccf6dc5093165f012047725ae494b58ea9e24841d7ed56dad56272904da94c81cbc323c46e6910c9b4324df4c910b5c230bade2fcdd8d56a3ba61aeab0d9faeec12228b885c3ebec1e4caf4ead695e92a22d74665bf84c892495e36c92b265946a4305aaa669ebc8a48713b46ae83e935c87f030a5a6993d74d72b34dde8042b6bcc1847a726b82601378fbacb2fb6c0a4133329d972652feebaeb7db04d9a95aad5caf1383cf93ca10ba7935a43378831995948ef5b69c4f76f2f4882605ceab72822078a379872cdb891a59b375a3dc5883a1dd81a1250819f3903dc14373e5582a5babd60088c4eaa9346cc9e855191d950d197d0ba2eb5340ec4b20b4291e2c11f100e59fa4e194564ed29103b40696cf06fe808df848bfed0581c386d597c8e2a8c899a8d466a0d206c6cdff8e95e7dffc8aa700b81799be3d8d9559aeb74d82a03d0301253125ae23c54d8324a25a7941603b69b04aa4f11e68bc77dac6c5a4a64931bce5efed5af5dfee9aa9f433a57ef9076150f0ecb325fcfdf94fd74ee802a62f4e937096ab5a370d9e6c069f1befdadcec5db335a3a2349cb16df06a349f01355b7215eae5f51aacc2335885f82fc35d9089322a517592e8fef1a5de843d4b56606851a694cd3f64d630c90a2459210d18eafa1ae4d9843ca9d546b95a8144f14f20d38da9a5db935c2cb69990ff070a0f1f71f9b7a1608c10d12d3105091a4212ff142881b7b330d1fe1125c6ff45c92d98f36f3f2efd30357a14991e9ca4e4cf5c2525306f031e642346f4d90f49393aa9ddd9838378f0a4acc30f67fc4b18d99efce5bcb13d0547526648552674d85aa57a3c49fc2bf9cb6c80aca7251a6228d7be0a84409a353b59678604e46b48f77194ec0f9caa3507	2026-06-04 10:54:03.787751	4391704665210210639	1579
193	\\x70726f64756374696f6e3a6d6f62696c655f6170692f70726f647563742f39376563616235392f313035	\\x0011815be363ed5688da41ffffffff789cbd564b6f5b4514764be567fccaa369434b1cf7415f49c7afa49ed93890182ead50d51a81f0c21afb8eeda137f7ba77eeb5eb04b1e8160941779558b061c502c40ac42682ffc08e0d3bfe001b167066ae1fb76948a30a21cbb6e69b73cf3de73be79b39a7c27b0887b8ce4d1c31e90ed3b2615de8411cdcaee194ce44cbe63d875ba6960d014c42351cedd9bcc5daa16209cfe95cb42cd7741a0a43785630c3e066c75b57c238d5e6263526cb33d30798dd62a6433b8c07f0ec0476863d7033f5dba7862b01cbe69da9270004edc37b4483ee48bb7610e1a870acd6031ec261f1c0d5b289ad4d6da3b0592d1754d411d7e40e2471bba396b101e39dae837052e73bcc1490a14038ddb32ddd6d796168d999b76cabc5eca17a62a649ed96a5039cbc7b6f6b1521944325b513ef0ab321b7108e404242cb06142eb3ea1974d8b06c9dd9089fe3a221dce684d2063369d3607a152fc18ed56a511986ca514551c5a98e70a656737235e50de1788b3aac63d9c3bd1009f014096ad9b92dcaed61e6aee7417805e33bca3ca6fe453d8063367580bdbd109ea17d66035a89e0a8621caa918268b8d950744216b01a9743469186b5610dc6db69f50f2beab89079e28e35c8dc97907a75b2653388516f50e73d9cd96c39bccfeebbbd9e653b18d780f9f7b9d3fdd032593dacb938229178e58be5fdcff2dd8f8338b20b3b48cba63705a7376f5bc603ea50e95773c98d78d5b33b1524ab5046b7a78f5f44ae4b6f6031f1041695c5e71f3ad7a5a2b1e31a0eef19acf1d0a590bec399f095ceebf568b1b8562ae1459db529984357da1c8c1b209b048e8f56a21eda3b0d7548e0a8419bccd0b2915cc66b37b2d00ee6c8fcb4fdd24d77e8930989813616264d3faa788d24a0d9a605579e9295153c3fb11c757f04ad811ae759bbcd14c523bfe7c9723b58c449d93763cbdcdac62d7c56ed3768db61f6a4b895f3789ef62937e4cbbdf2f2204ecaf27b69d7c8e59aca30490a905cde975cde971c29b643852289b583eba454953904bcc811594764a37243465520b764d4b95ba40c00e61142aae01e2fd8cc50751c6940d4a37babf0caae6ceec8eea347bbca5718168f76478b486585441170b84266e01be7019240f2752944d2950899e527cb27c89c7724bcb9b5be51da50cff9425e40e4f438cec567854fce4c158fca65059d4564696cfe2a22e7aae47c95bc5625cb88648ed4225941245b0f900b60751142bb04b15eae91d7abe44a955cd5b271cd9caa875c9bb6f265e8dbbf2fdcbfe86be5eb1ef4a584c8dab3a63f594faf1c3005e82b657ab34a10d09443245f0f28722d196df81e1d8cb98d0936783878785c76df55ecc6849ecfe50a87518b8e223587d68f4d6a85bc3483dbc0c11fd566c547cb3b1ef4c341065f647ab3e6310811e547a24f29494cf50edb7e45c0521278981c56c8327c951a500ed4b0026a481232115bfa80d82a579ff32c9f2d970ff5ce3cef150a9e19783e79e784a73455f81d59f8d1bd2eeb1ed2c5a8e661afe661a879d8abf9214791af0742b2035230390c749b0dec011bb741ec0dcb710c368a3d7c2c99e550f1888ea8414a978ed91235d912cfde49fe9e9017c4cfdffd857d85def6a0ef0ff6c48b4c95aac27e556d4872d335269ccce8309bd03c62fc18d2faf515496c325f10bafa88973db94ae8ff10d9d79f2eef27fefce0b18fa56f3c287a9050f6f9f27ef2e9e26d9fe9471ef4cbbf1c53ebea0e90844e881cf559a41dceb1bcc7e589274026fc1cc666511d54a1fca187d471582c1e75fed7e4c556fa4f78bc00a47d622c3df19173d583960ef27811f06f7f5bdbf7995ef3a0b7a73c021f1e9178c6667dce06720a9cd59901c3823d8469af6dedc1743ebdfe0d0b664b3914d781f3c4a661643453e76af8c28b50011825e52d3df6a0654f17564b99a62bb8c984c8e874e8cd9e0ba2cb7b3d39eab4bad486e953cb2e576dc632633c439b569f657e7ffc6309a916fd07d25a5dc3	2026-06-04 10:54:21.739495	-1378581344686428559	1633
194	\\x70726f64756374696f6e3a6d6f62696c655f6170692f70726f647563742f39376563616235392f313031	\\x001181a92365f55688da41ffffffff789cbd57cd6f1b4514774a657bed24b693a6694b4ab66e534aeba4b3769c3433970da48b4c0bad52231039586bef6c3ced66d7ddd98de304095471434270acc4810b272e8813884b0507ce5cf803b8f10f700109deccfaab4994443d545194ccdbb76fdefc3e9ec7a7937b082798c51e62c535b768257fb64a79c0dc4df5fe3ab3c246a06a711cbf5dc5598bf286cf5a01f3dc4a5eb1b8c5e32451c5a996cf1ad44e6aa888272dc61b5ee806351944788253c78162d15a4fe2accd5cd3e92fcf0d5ea07e83ba81b949590c4ff4c341a705650675b74d271401cf679b834a10e0e636ecc36be696c8b3e308a778e0351e41b5247f1456f2896ebf4ae8b200967736e532dda66cb319209cb1d81675399c8e239c6bf99e38bcdcbf921f7ddbf71ad4efc83746eba6dff02c0867eeafafcd238434a4c927634deed6c42384153809afe463322e8ed372cc4ecdf32dea233cc3788d87f53e9c35ea9a75875a06be004fbc46c3146dc8c3c92e0c9cdde4c1206b52ac0680213cd63003bae9f99dbd0489b12c8957f2936b26f33beafda842972ab625d3d3f22fdf88e1b46f0aaef71278d4dca63e447505a724d4005c16ba616e4de268e00958f578105de460ed78eddee39cfc0b2b3308e1e4b97b61a07ab6fa4044e5ee99864fa14dab6606ef6375b511b06dfa206cb53c3fc0b80ae07fc082e6479e4b379295102b223276fdabd967fffe3ef35b1c2bbbf00441dd55cecc9b773ce7911998a26e2524853114e5dd8b937960326c59bd8dc80d510d32fa9520439f3ef8d24cd3e4b5add00958cba1b5c7a10908048cf221f67a42a7453c6d51db8464d0a3cf20b5060e52f05877c537127b67810880d231ebd401bb14d5486f64ca8e17c99981fe72f5b0d337889d282d9234f862aa2ff82ee955325ec9a76cb6432d5926a35fc267fa4991e84588da3695c8762d7691ccdaf132ce08c574b3e6f079f9ac66da01f5fb94ea17f11973db648ed82f22959d9adbc019417b745a835cadca83254909ba299606874a144b43a7228bfa3592b6150dbc41ca077ab7e31a59d20b6459805922b3fa1cb96527cb54232bfa3cc1ec1342c45678caa78e24b2eb03be91da9b87ed5d21f0244c20592e09db76ff55ecc46299a410605822a3f03bc662641c910c22594472ba422658824c56f2e36bab95e5d2aab15292ef0d753e85c85944a69ff73c39376cf6b20c9d47e442d7e0e45544660c72d120af19641611f5481b924b88e43762e432645d8196e6a0c7ab55f2ba41ae55c91bd0db5daf3db00db93ed0b00e82fda2d8fc7848c346143a2d4264e1e4a937ab04d9a9c5c5857299686c9c14bb921d17cc2a5a9f5860e9395a4b12da88d2cc6004753559204bb68216808365dd10ca5b0462156d61f916306b00b37142aa3d1165e4560363e8979edfea322828be44ca86d82bc219785c42507b5dd42e89da684113b5d7a1b612a9462aa429b057767776767b12517676bb0b05da94122980440a8749e4d4ca484f246fad2d2d97970f1349afa723a48256564e2c151d1fa10b43e862ace21e2e8bab40ec7f971f5c19e2fa4614fa7abf2c44eacfded36bfb5221f44d240b8320c0444320889844d2935e5b37db3d20d39cb61fb71f9f14caf72494696e1535ed45ccb6f43210bc0d18fc65d4f52158de89423fee47f0b854612c812074d4f354f6184f15248087e9bc00b3b110c91c89e158009967862c943bc642053184d1c2cacaa1d5473e8bcaeb239f426d586176eaeec8908bb604f789a1311b5da180f6d281217bc838d83f74b330b1db964fdb7e9bf694907ed30b028776db2f9dc8561a5a3c42145538d4bb2754c509e6ed2fdfff8387b8be1d857e386cde1e952a8d551a36d6b20037272edb6af7e3edc0a7d9f1eefae315016ca658e296fce12f3aa9cae865f8ecdbcf679f8dfffde1932194be8b42a9fd80d22f679f659e4edf194a7d18857e3d38a9f0a84fb7196d8b2bed84451db8fff81db8badade1e7cc718dc6a1c0f2ecae286bf01d88faf3a8e5a712d26af91785a7cedd992d78d5e05f832549a2fabf590339772ae5a6627ba484ff1266bb5c4b5add1347db84a57f2b3864fa9da8bab66dddba6ea9f4f7e2a2389ecff0eeb9412	2026-06-04 10:54:53.705247	-1224637664213038199	1714
195	\\x70726f64756374696f6e3a6d6f62696c655f6170692f70726f647563742f39376563616235392f313036	\\x0011815ea427fb5688da41ffffffff789cbd56cd6f1b4514774a657b9d0fdb49d3b4a160e37eb7381d3b76d2cc5c1c485c96b6a86a8d40e4608d7767e3a19b5d776737ae13c4a1572404bd55e2c08513071027109708fe076e5cb8f10f70e1006f66fdb149d31021842c7fcc9bb76fdefbfd7e6ffc4e2677114e7093bb5873e816d30bc9fbb41bc7f1f506ce984c181eeff8dc75f4c2b860dd47dd47719268e054c7e306b3e2253c637261b881e3379509e169c16c9b3b9be1ba96c4198b3bd41e2ecf8c1e609ec11c9f6e321ec3d343b3dfeb409851dc6d6a07d2e07a7c7314090c826ec339a249b7a49f154738257cd778c84fbc338693e261207336cba5d2a2ca590b1ceeeb85c4ed4db51cef32bed9f6114e9b7c8b39026a1408673b9e6b064698855e98b8e5b906f37aea898916f50cd70473fadefdb52242a88496d4ce645b384db985b006f508bd1053765954c7a6bda6eb99cc43f81c174d11b486a03699435b3633eb781e765cc3a0320d55a2caa28e339bc21f79cdc8d5083684270deab34dd7ebed26488c67485c2fccac51eef5f2f7c20822a48b6f29f771f52d366278dca33e80b79bc013749b7960ad6938a500073232900d779a0a4da80256033664165958db6e37dc86a5fa8615f503a87c5277f20fa4459d9c363c06299a4deabf8bf3ab86cfb7d983a0d3713d1fe30600ff1ef7db1fb80edb48ea01d6a46572fdf3dcdeeff5562d8eb51dd8417a21bb2a38bd71dbb51f529fcab87a405e9f7c3bf4fb3e4e8ac062d031070791eb321a780c2381476deef987ceb5a9686e05b6cf3b366b3e0a2854ef732622cc0d643b67328b8227c8d1e3e0d78496c9e0c9fe4a6c24764f4b0670caa62d66eb05ad940f8546666b49726aa4bb6c2be845da838c43f0d9a1d8075493a9be86481ae153c3ed50ea606196c51498c33839889396fae8b783861650099f55db4d6af9cc1b92089ea7e836e5b63c2ba491a7715ad21c16d920971aaa9e2c598452cac352ac7839520ba9c8fce5492b2ba4ba2f67b284c872edb2cc8adcac15c80afcc6fcc49d3142ea101ccf7acc5674f5952e3652bb4538d091124e9ac25471927054ffa766252a5592428057914cc07b92c7c81492476510c9d63432cd1364462f4cadadeacb8babf515d5f5d16c6711398dc8dcfeae2667a2ed5c55a6b388cc0f4a7919917375f24a9dbc5a273944f247361a790d91c2468c9c07af0b90d245c8f152835cae932b0d721572bbe37647cd41ae8d945a03597e5a6e7f14516a3d349d9426b2707cd71b0d82ac54a5b250ad92129f22e5be36a714972f9025505954d0561b92c6f4e892090905e725493470b05cab919c15af909b96565a58be09dcd680db382143d9a40fc8a67671df515662b102ba892f1d2a9abb32faa28c8e164a32fa5d88ae85ba511a694bf4b59dc78f770622d11eeff4171a24aa44920491240f13c98995b1814cde5c5b5aae2e1f2693414e478805adac1c5b2cb5ca11caa84b65ecbb35a3c2b804d4fe75fec18508dbd743d3170785215d7f749f5d39e00aa62f4361d409024c4a08241153486e492413916633451fc5e273ad7688280eb65e06fab66b7aaceb75d900d5f1375cdfb7595f07c563415b429523a06dc0a572eb98d81ea3eb7efaf64f1c416c3d347d7758d71de5aac02d46c15d96e0661b4cf8f9fe25f7dc9df6cf62fde525096cbabc284cf512ff56ad55f47fa8f5ab4f727b537fbcff2482d2d7a129751050f6596e2ffd6cee76c4f5c3d0f4f30bd4baa4fa5e023a04b2af33cd4a965839c472ec2980091f87a15951ad9f281ffad7701c142b47f57c435e5cd5ff04c7f300dac7f6fcd308385743d3fc411c2f80fd9b5f17f622aed742d35b231c018f10483ce1b16dceba72069c36990d1384d78359cf727761341f0d05b60b93a51c893700f3a955dbceeb8ec9d5ec85e780011824e5bff720825e38bd58ace65b81e00e13226fd25e3879ce8a36ef74e4bc63b4a907b3a75ec8d53dc6f2037b9eb6dc6d96ffedc90f55a424fa3753385cd2	2026-06-04 10:55:16.746914	-1825831264630365935	1634
287	\\x70726f64756374696f6e3a6d6f62696c655f6170692f63617465676f726965732f3432663234383364	\\x001181f6794ff6a989da41ffffffff789ce555cb721b45144d5294e34785323654b6b7bc6025eb6529b2a462118a38c885e35072ca0416ae56cf1d4dc34cf7a4bbc78ac8c61fc11236142b3ecb05ffc1e919c98f60d8b162a5d1e8deee73cf3de7e883d5efd6df6d0c1eaa487d3458d322e3d1cee32f84b273fa940e84cde8c0b24b56062bcf4e069b113b6955ee95d1a39dfb7f3ef57424ac48158d85f609d768c634b14a4f696e0aca0b8b57310ed98dc3211495e7e6d64485f48e9c29ace488226559fa744eb13519795b388fb7a991222dbbd9ba3a1d1776d16f859e322947d69850a8347a44a4022a7464ec1313b91ab1764589450b5f00257981836b94a86942baf0b6eca891d011fdc8d6903419b065ca31194d6f0a0ce6e7f595e1c393c1872a13533e2b6c8ab97f4bbccfdda0d1c8cae15d397b1ddd0d2b54ea1a427a75ce67ce1b8ba6c6243513d7b05c8dd9e0f9612cb3837cf2e5913ad64e7dfbfca0f97a3c7a7274f2ca8df4e72da9464f46d9a19bb40f6371fab58abf697eb6bbdbebb73ba215b5e36eabdbe9c5729f9bed6e578a7dee772742f67b1d8ef7e249a76195e47aaea725eced25d767d214daabd5c156a45c9e8af999b1115b75efddc6f09eda1cae8c76b6abadbf5c7484fee1eaff6acbc3b5e6705d6d0d3716b47c1c68f9e43996aa1ddc70a4d294af8979d07ef07766302bbddf801bf129038c8a3647de4c819f2d4961392e52b0b2a4c97991a7fc4f63c7c644248b14a3721dd60493981b6aa3b0773a1756b1571c6ea88667ed77f15342d9024caa7e40b198aa1a7d6f66c256ccc4e6ad877641e7395f2f2fd0ef3860079299f2090954cac2dd60ae6c1705a681be64a0f2d1faa3f5f19d4b0f6b761549d38aa4d0bc44062a50c65cd526a80533e48a0928d192abe2426bc6b31315caf008466fc82048127772e0a4640b0c2a9c9e19e7af34121b9bd5e934a996806f41744099b148319cbdc5394e533903378ae764e2182d826689c19a4cc625ac89480346b024e625f79851c10bf3306b2c3062c5cbb5cc76af64b61564f6f8c502da78c6ec59c30d4ba10d2f2f7e7ea517c3e28acb8b5fab645e921c5ebc30f4348af0655c4c85bdbcf885aaab60e0dfffa3b87afd2f7125facd76abd76f757bdd562491575274782fe6de7edcee44b2dddb6bb6b8dd948d738613c404542e430bdcac5d71b31db8593f1e7d35a62bdffd71ffce448ae13233c366e028a5c32ac2f6735b296429162c5178c27d3a72b7b63c532e82ec4a95e761e5c8077e8b8acab89e65a2d59b82172165c05ca9d8ca2a0b7f98c2430ef33bc47b43a1a58c2c673000c99405c2c989986b0b7d8b08f6662be0b95232cf4a4746d6e461b260461732174ebbbcf8e9da2f32e14c214b71d38d97467b882f44c43203cb30c0cd4b2b4cc1920631b04318bdccf16516016dd0019c5d996f9156b78c776b11741a387f692ba11e078e224ea12e7b2b226aef0773f96f105055f15338be11c89b410d7f01ebed0620	2026-06-08 11:20:33.294516	-6099505338402572361	1265
201	\\x70726f64756374696f6e3a6d6f62696c655f6170692f63617465676f726965732f3233663238626637	\\x001181fc8f94f45c88da41ffffffff789ce555cb721b45144d5294e34785323654b6b7bc6025eb6529b2a462118a38c885e35072ca0416ae56cf1d4dc34cf7a4bbc78ac8c61fc11236142b3ecb05ffc1e919c98f60d8b162a5d1e8deee73cf3de7e883d5efd6df6d0c1eaa487d3458d322e3d1cee32f84b273fa940e84cde8c0b24b56062bcf4e069b113b6955ee95d1a39dfb7f3ef57424ac48158d85f609d768c634b14a4f696e0aca0b8b57310ed98dc3211495e7e6d64485f48e9c29ace488226559fa744eb13519795b388fb7a991222dbbd9ba3a1d1776d16f859e322947d69850a8347a44a4022a7464ec1313b91ab1764589450b5f00257981836b94a86942baf0b6eca891d011fdc8d6903419b065ca31194d6f0a0ce6e7f595e1c393c1872a13533e2b6c8ab97f4bbccfdda0d1c8cae15d397b1ddd0d2b54ea1a427a75ce67ce1b8ba6c6243513d7b05c8dd9e0f9612cb3837cf2e5913ad64e7dfbfca0f97a3c7a7274f2ca8df4e72da9464f46d9a19bb40f6371fab58abf697eb6bbdbebb73ba215b5e36eabdbe9c5729f9bed6e578a7dee772742f67b1d8ef7e249a76195e47aaea725eced25d767d214daabd5c156a45c9e8af999b1115b75efddc6f09eda1cae8c76b6abadbf5c7484fee1eaff6acbc3b5e6705d6d0d3716b47c1c68f9e43996aa1ddc70a4d294af8979d07ef07766302bbddf801bf129038c8a3647de4c819f2d4961392e52b0b2a4c97991a7fc4f63c7c644248b14a3721dd60493981b6aa3b0773a1756b1571c6ea88667ed77f15342d9024caa7e40b198aa1a7d6f66c256ccc4e6ad877641e7395f2f2fd0ef3860079299f2090954cac2dd60ae6c1705a681be64a0f2d1faa3f5f19d4b0f6b761549d38aa4d0bc44062a50c65cd526a80533e48a0928d192abe2426bc6b31315caf008466fc82048127772e0a4640b0c2a9c9e19e7af34121b9bd5e934a996806f41744099b148319cbdc5394e533903378ae764e2182d826689c19a4cc625ac89480346b024e625f79851c10bf3306b2c3062c5cbb5cc76af64b61564f6f8c502da78c6ec59c30d4ba10d2f2f7e7ea517c3e28acb8b5fab645e921c5ebc30f4348af0655c4c85bdbcf885aaab60e0dfffa3b87afd2f7125facd76abd76f757bdd562491575274782fe6de7edcee44b2dddb6bb6b8dd948d738613c404542e430bdcac5d71b31db8593f1e7d35a62bdffd71ffce448ae13233c366e028a5c32ac2f6735b296429162c5178c27d3a72b7b63c532e82ec4a95e761e5c8077e8b8acab89e65a2d59b82172165c05ca9d8ca2a0b7f98c2430ef33bc47b43a1a58c2c673000c99405c2c989986b0b7d8b08f6662be0b95232cf4a4746d6e461b260461732174ebbbcf8e9da2f32e14c214b71d38d97467b882f44c43203cb30c0cd4b2b4cc1920631b04318bdccf16516016dd0019c5d996f9156b78c776b11741a387f692ba11e078e224ea12e7b2b226aef0773f96f105055f15338be11c89b410d7f01ebed0620	2026-06-04 12:37:14.36757	-5636231158101935370	1265
203	\\x70726f64756374696f6e3a6d6f62696c655f6170692f66656174757265642f37383430633761322f6c696d69745f35	\\x001181b11b21f65c88da41ffffffff789cbd964b6f1b5514c7edaaf278ec38b69b367d108871692805bb77fc88937b1775503b6848d456ad1112595813cf1de7a6931977ee4c4c4825366cd820c1274062c116b16289ba61cd928fc0962d4870ee1d3f2669629e62e1c73d73e63cfee777c63e9fdece1c55b0c22ce661d535f7a9514e3f3287299cbad7c1058bf29ecf0601f35ca39ce574f874f83445940ece0c7cd6a3764ac30b16e33d2f7483ae34217c8153c7616e3f3ab7555cb0996b3a93e395e90dd4ef513730fb9425f0858939381c409869dc03d30985c1f3597f1a090cdc3c803cbc6bee0b3f3b857086075eef093b773f89d3fc49286ab66a9a569735aba1cb02a3ac6cf6e5313ba4acbf1b209cb7d83e7539f4c8112e0e7ccf0a7b51154679ee1ddfeb51ff50de31b763fa3dcf0273fee1a3bb1584908656e595dc2e77bbe212c22af4c38d7242da455303c73cec7abe457d849718eff27067226a97bae68e432d1d5f832b5eaf678a32648bb20a1d17fa3c987a2d88d3543684733d33a07dcf3f3c5248821548ca282fdc35997f587a1845e0d1b8d8be74cfca4fbe9dc059df0c40bc2305cf9907d4076b3b83335270184601aa616e57aa095dc0693c0d514511ce8e378c2ec3517ec2c90c42e83c67b8a5c7c22233e77b3e8512adae19bc874b1bbd801dd0c7e160e0f901c61d10fe7d16ec7ee0b9743b6d84581596dcbdcf97bfff59df69a7b0fa115c4146b9b8c199797bd3739e988129e21a21792bf76ee4f75d8a54608ae1c01a27226f8a68e03189041eed2b2fdeb4b46bf2ee7ee8046ce0d0eed3d084ee0346796c72636c2f5bd436c11370f419f87561650a38373af16de568514c00671c73873a4659d54a1168e4525b2517a7dc1577c2c3d87a902c04bf34817d3c6a323f6288e411be38b91ca10e166adb548a3989b30c71f2828fd13aa8a88a347c555eee9a7640fdc910c1f3a279603247e48ac6c8f2382fc61c35d9212b1dd94f91d4a195daa4153b558bf5421aa27e91697d9d348fd54c561169b56f8aaac85afb3a5987ef989ddb4a12a28be01508ee0a5cd316b7e43d69083bfaaada4aa3493208b4a9903978e55882cc2311b68048b19d2117588a2c18e5f9bb1b46abbea1afcb0d8f5776099145442e1fdf607225beba4d69ba8ac8b571d92f21b2a4939775f28a4e9611298d97aa5d24af2252de4e90eb607a0df2df8082563ae4759ddcec9037a0902d6f38a59edc9a22d806de3eabed3e8b21a847a6f3c244aa7fddf57687203bd368549b4da2b179521b41372f8774066f30a38ad4b1d911f3c94f9f1ed1a4c079554c10046fb5ef90653bd5206bb6aa555b6b30b43b30b41421131ef2277868af1c4b652bf50600915a3d95862d11bd2ea2a3aa26a26f41743506c4be004289f160f1880728ff240da7b412a34311741400ada1e5d3a13fa4633eb26f7b41e0d051f515b2382e72262a8d19a8748071fdbf63e5f937bfe21800f722d3b7a7b132cbf5b64e10b4a721a02421c57584b8599084d76b2f086ca7355a8b34de038df74edbb884d034cd47b7fcbd5dabffdb5dd3a57ebad0aff8200c4a9e7db684bf3fffe9da095dc0f4c56912ce7295eba6c0934d6373935d9b9bbd6bb6a2d5a48633b60d5eadf633a0664bac42b3bade80557806ab90fc65b40b22514e26aa4f13dd3fbed49bb067e91a0c2dca94b1d987d41a255981242ba405435d5f833c9b9027b3daaad66b9028f90964ba115bba3dc1c5628772f17fa0f4f011137f1b4ada1811d5e23148d00892e4a74009bc9d8589f28f28d1fe2f4a6ec19c7ffb71e987d8e851647a7092923f731594c0bc3578908d1951673f24c5e88476670f0ee2c193b2093f9cc92f61647be297f3c6760c8eb4c890a94de9b0955afd7892e457e2975903594f4b34c250ac7d1d0881346b76ba493501c8d790eee328d91f95453506	2026-06-04 12:37:20.637674	-5327544562135237637	1582
202	\\x5f5f736f6c69645f63616368655f656e7472795f73697a655f6d6f76696e675f617665726167655f657374696d61746573	\\x313331353533	2026-06-04 12:37:14.706858	6706543775222517821	195
204	\\x70726f64756374696f6e3a6d6f62696c655f6170692f70726f647563742f37383430633761322f313036	\\x0011812e3d5b205d88da41ffffffff789cbd56cd6f1b45144f4a657b9d38b693a6694321c6fd6e713afe4a9a998b0389cbd21655ad11881cacb177d61ebad9757776ed3a411c7a4542d05b250e5c38710071027189e07fe0c6851bff00170ef066d61f9b340d1142c8f2c7bc79fbe6bddfeff7c6ef646c17e12837b883359b6e333d1bbb4f7b111cd9ace194c144d3e51d8f3bb69e9d12acf7a8f72842a2351cefb8bcc9cc481ecf195c341ddff6eaca84f0ac6096c5ed56b0aec470cae436b546cb33e30798db64b6475b8c4fe0d991d9eb7720cc386e975abe34382e6f8d238141d02e9c23ea745bfa991184e3c2739a0ff9897726714c3cf465ce46219f2faa9c35dfe69e9e8dde6ea9e5548ff156db433869f06d660ba851209ceeb88ee137832cf4ecf42dd76932b7af9e986e50b7e918604edebbbf914308e5d18ada49b4855d975b086b508fd0b313ca2e8bea58b45f775c83b9089fe3a22efcc608d43ab369c36246152fc28ed36c5299862a516551c5a996f0c65e737235860de144937aace5b8fddd2899e02912d1b3731b94bbfdccbd208208e8e2dbca7d4a7d8bad093ce5520fc0db8de269da652e582b1a8e2bc0818c1464c3edba4213aa80d5900d99451ad696d30bb661a9be61453d1f2a4fe876e681b4a893934d97418a469d7aefe2cc7ad3e35df6c0ef741cd7c3b806c0bfc7bdf6078ecdb662ba8f3569496c7ebeb4f77bb55189606d0776909e4daf0b4e6fdc76ac87d4a332aeee93d7136f077edf47480e58f43bc6f020725d46038f5124f0a82c3cffd0b93615f56ddff278c762f5473e85ea3dce4488b9a16c170c6652f00439ba1cfcead032299c18acc45674f7b46400c72dda60969ed5f299406864be1223a7c6ba4b37fc7ea83dc814049f1f897d48359919688824113e35da0ea40e16669a4c81398ab3047192521f8376d0d032cae3b36abb4e4d8fb92312c1f314ed526ec9b3021a79122725cd41913572a9a6ea4993229452189562460aa15a4849e62f4f5a5b23e57d39931544562b976556e466254bd6e037e627ee4c125285e078de6596a26ba074b115dfcdc181b69470cc10868a1383a3063f35335a2a933802bc72641ade093e4166903c2a8548baa291591e21737a7666635d5f2dae57d754d787b39d47e434220bfbbb9a9c09b7735999ce22b2382ce56544ce55c92b55f26a952c219239b2d1c86b8864b726c879f0ba00295d841c2fd5c8e52ab952235721b73b4e6fdc1ce4da58a91590e5a785f64721a55603d3496922cbc777bd5123c88c974acbe532c9f319521868734671f90259029539056db926694c8e2f998050705e91440307ab950a5932232572d3d4f2cbab3781db0a701b2164249be401d9542eee3bca8c164ba09bc8caa1a2b92ba3176574b49c97d1ef42742dd08dd2485ba2afed3c7ebc331489f67867b0d0205125921888247698484eac4d0e65f2e6c6ca6a79f530990c733a422c686dedd862a9948e5046552a63dfad1916c625a0f6aff30f2e84d8be1e98be38280ce9faa3f3ecca0157307d1908a34a1060924720890985e4b644321a6a36430c50cc3dd76a878822846a54629a82beed192eebb93d364475ea0dc7f32c36d041ee58d0e651e908686b70a9dc3a26b6c7e8ba9fbefd138710db0c4cdf1dd67547b92a707361705725b8e91a135e6670c93d77a7fdb3587f7949029b2c1485a15ee2dfaab58cfe0fb57ef5c9d2decc1fef3f09a1f475608a1f04947db6b4977cb6703be4fa6160faf9056a5d517d2f011d0139d09966c6f2ac106039f914c0848fc3d02ca9d68f160efd6b380e8aa5a37abe262faef27f82e37900ed636bf169089cab8169f1208e17c0fecdafcb7b21d76b81e9ad318e804700249e765997b39e9c01670d66c104e1f661d6339d5d18cdc74381e5c0642947e22dc07c66ddb232ba6d70357be10560000649f9ef3d8ca0674f1773e54cc317dc6642640cda0f26cf79d1e69d8e9c779a6deac2eca96797aa2e6399a13d431b4e97657e7bf243192989fe0d4b735cd1	2026-06-04 12:40:09.545997	7510930866009226279	1636
288	\\x70726f64756374696f6e3a6d6f62696c655f6170692f66656174757265642f39356430636563302f6c696d69745f35	\\x001181021f82f7a989da41ffffffff789cbd964b6f1b5514c7edaaf278ec38b69b367d108871692805bb77fc88937b1775503b684844abd608892cac1bcf1de7a6931977ee4c4c4825366cd820c1274062c116b16289ba61cd928fc0b65b90e0dc193f2669629e62e1c73d73e63cfee777c63e9fdece1c55b0c24dee62d5a1fbcc28a71fd2610aa7ee7570c164a2e7f181cf5dc72867051b3e193e4911a58333038ff79895d2f082c945cf0d1cbf1b9a10be20986d73a71f9ddb2a2e58dca1f6e478657a03f37accf1699ff104be3031fb870308338d7b40ed401a5c8ff7a791c020e801e4115dba2ffdac14c219e1bbbdc7fcdc6612a7c5e340d66cd634ad1ed6ac060ef78db2b2d90f8fd921e3fd5d1fe1bcc9f79923a047817071e0b966d08baa30ca73ef786e8f7987e11d733bd4ebb92698f30f1edead208434b41a5ec9ed0aa72b2f21ac423fc2282742bb6c6a60d3c3aeeb99cc4378898bae087626a2769943776c66eaf81a5c717b3d2acb085b0cabd071a12ffca9d7823c4d654338d7a33eebbbdee1914212bc40524679e12ee5de61e941144144e3e2fba17b36fc14db099cf5a80fe21d29788e1e300faced0cce8482c3300a500d77baa19ad0059cc6d3905514e16cbbc3e8321cc34f38513f80ce7386537a242d61e67ccf6350a2d9a5fefbb8b4d1f3f9017b140c06aee763dc01e13fe0feee87aec3b6d346805569c9ddfb62f9875ff49d760aab1fc31564948b1b82d3db9baefd98fa54c63502f256eeddc8effb14a9c0148381394e44de94d1c06312093cda575ebc6969978aee7e60fb7c60b3ee938042f73e672236b931b6974d6651f0041c3d0e7e5d589902ce8d4e625b395a9413c0199bee30db28ab5a29028d5c6aabe4e294bbe24e70185b0f9285e09726b08f474de6470c913cc217279723d4c1c22c8b85624ee22c439cbce463b40e2aaa220d5f0d2f77a9e5336f3244f0bc480f28b765ae688c3c8ff372cc51931db2d209fb29923ab4529bb462a56ab15e4843d62f33adaf93e6b19ac92a22adf64d5915596b5f27ebf01df3735b49427419bc02c11d896bda1466784f1ac28ebeaa96d268920c026d2a640e5e399e20f348862d20526c67c8059e220b4679feee86d1aa6fe8ebe186c72bbb84c82222978f6f30b9125fdd6668ba8ac8b571d92f21b2a4939775f28a4e9611298d97aa5d24af2252de4e90eb607a0df2df8082563ae4759ddcec9037a0902d7738a59edc9a22d806de3eafed3e8d21a847a6f3d244aa7fddf57687202bd368549b4da2f179521b41371f0ee90cde60469550c76647ce273f7d7a449302e755394110bcd5be4396ad5483ac59aa566dadc1d0eec0d052844c78c89fe0a1bd722c95a5d41b00446af5541ab664f4ba8c8eaa9a8cbe05d1d51810fb120825c68329221ea0fc93349cd24a8c0e45d25100b486a6c786de908df9c8beedfabecd46d557c8e2b8c899a83466a0d201c6f5ff8e9567dffe8a6300dc8b4cdf9dc6ca2cd7db3a41d09e8680924428ae2dc5cd8224a25e7b41602badb15aa4f11e68bc77dac625a4a66931bae5efed5afddfee9a1eeaa74bfd8af703bfe45a674bf8fbb39faf9dd0054c5f9e26e12cd770dd1478b2697c6eb26b73b377cd52b45aa8e18c6d8357abfd14a8d992abd0acae3760159ec22a249f8f764126ca8589ead344ef1d5fea4dd8b3740d861665ca58fc23668e92ac409215d282a1aeaf419e4dc893596d55eb354894fc1432dd882ddd9ee462b1c384fc3f507af090cbbf0d256d8c886a8a1824680449f233a004decec244f9479468ff1725b760cebffdb4f4636cf42832dd3f49c99fb94a4a60de1a3cc8c68ca8b31f92727452bbb30707f1e049d9841fcee45730b23df9cb79633b06475a66c8d4a674584aad7e3c49f26bf9cbac81aca7251a6128d7be0e84409a352bdd649a04e41b48f74994ec0f736d3503	2026-06-08 11:20:38.177516	-114676495731508696	1582
205	\\x70726f64756374696f6e3a6d6f62696c655f6170692f70726f647563742f37383430633761322f313033	\\x001181ca92f3215d88da41ffffffff789cbd57cd6f1b45144f4a657bed38b693a6694b4b6cb7292d21eef82bae673838909a2ead68d51a81c8c15a7b67e3a19b5d7767378e130ea8e28684805b250e5c3871419c405caaf23f2071e5c69503170ef066d61f9b0f92a8071445cebc7dfb3e7eeff71bbf9c8eec221c663a33b162699b54cdc674aef362218443b71a38a953de7658d765b6a566c33a0f91700347bb0e6b532392a7053cab33deb63dcb6d4a23c2339c9a26b336fc732d829306b33473743c377e813a6d6ab9da06651378666476fb5d08338ebba5999e30d80edb18470203d7b6200f6f6a9bc2cf08211ce5aedd7e04d122fc91a766237c50b0e259cc85faef6cc863ac47d946c74538a1b34d6a71688e239cea3ab6eeb5fd02d4ecd4db8edda64e5fbe31d5d29cb6ad833971ffc1da3242288f8af249bcc3ada67884b002ad70353b21eda29faea9f59bb6a35307e18b8c37b9d71aa1d9a496d632a95ec717e089dd6e6ba20cd99daca28e931bdc1d7bcd8ad3183184e36dcda51bb6d3df0d9309962421353bbba631a79fbeef4718cc8a6d4af798fce4eb1338e6682ee0b61bc653da1675c05a537054620dc825a11a66352590753c03a7e120441529389b766ff838253fe1a4b91e749ebae7b969db483f1456993dd1762894a93735f73d9c5e6dbb6c8b3ef4ba5ddb71316e00f8ef33b7f3a16dd1f588ea614558e2b52f179efdf3fcb70b21acecc01304715739d36edcb1cd479aab89b8aa475e8fdff2fdbe0a916598a4d7d58789c89288061ea348e0519b3ff8d2c58ec69b9b9ee9b2ae499b8f3d0d107019e581e9f94c0f57ab785ea78606bec04787816713443385e383135f0fef9e85394ce1a8a9b5a8a966957cdaa71b9933427972664cbf54cbeb8f046284f30512035dcc8d083f9879834c03ddc62397b112b50c3e33f2f4992f4cd430a84477a0b34b64c108ade08460cd401f4a39572de1f3f27953335cea8c465bbb84cf685b1a3345627fb86cf24f9c10d3f7bbae93ab0dd9609c14a1b762a0b762a0375232c2c512891991022d90b26c216ab06daafbd51ba10259a9e548052e8fea4db2505b22378de84a25572c906aed06c16c9110910bcf39d494031de881af47779721bf25881e813b4a068c40e6c19f8a112e9549140198653205bf713641a61149209244245553c80c0b9159353bbdb6aa568aabf5aa1470b0f83944ce2232bf57fbe45c50f465693a8fc88581d0c9cb885cac934b75f24a9d2c20923e528e248348767d825c06af2b50d222d478b5415ead936b0d721d6abb6bf7c6f221afede5f2e785cec7012ed77dd3696122b993bbde681064444ba55cb94cf26c9a1406dc9d96a31dd3b696d933598054405bfe2f5e92154341399841a5765bb0af04a355f2b9ca4d98ec6d986c8890c690450999aa304e95db9b6a09522d92725da4f2618631ae2008bd08a4b92e22a35c5e445e84c88acf19c98f8e405ed9d9dede191244d9de191c14285212240304c91c469053d5c92145de5a5ba9942b87516458d2114441d5ea8989527be30856d4052be2aa753829ae8adbecf2c32b81492ff9a6aff79342b8fe6c3fbdb6cf154cdff8a4a8130498e411d0614222694ba53dd07a4320639cf61ef71e9f14ca77259431ae17f2f91791dacaff81a0f83ef8a3deaa056079c737fdb81fc1e35c85ac048250d15051c963149591001e46f30cd03ce3d31ce581e619a0792220a0d4310282c8e2dd6af5d0e8939ffae16b939f406c386176eaee6440459b62f6e1c025eb2f5230f68357ec219741800661418224dcd73ddda13da747874c88bd69bbae4907e5974f24ab3c2a1d418a063475ef84ac38c16dfbfcfbbff1becd014c3f1c76db1ee52a85550e0aab22c04d352877d3832fb703df65c7abebd79704b0894291ebf287bfe84d5546ff87cebefd6ce1d9f45f1f3c09a0f49d6f8aee07947eb1f02cf174fe4ec0f523dff4cbc19b0a4f39748bd19e586c67746ac206e4f4618135ec5df85763bcd39836accb62cf5f07eca7574d33ad5a3a93cb249e8749c0762c968d6104357bb6b85c4eb73cce2cca795ad7fafe3a3dc73bacdb15db5bbba339b050abd985ba43697a684f6b2d7b8ba67f7ff253194964ff05ab419386	2026-06-04 12:40:12.054324	951766975477047271	1709
209	\\x70726f64756374696f6e3a6d6f62696c655f6170692f63617465676f726965732f3336363363316332	\\x001181ff49f8605e88da41ffffffff789ce555cb721b45144d5294e34785323654b6b7bc6025eb6529b2a462118a38c885e35072ca0416ae56cf1d4dc34cf7a4bbc78ac8c61fc11236142b3ecb05ffc1e919c98f60d8b162a5d1e8deee73cf3de7e883d5efd6df6d0c1eaa487d3458d322e3d1cee32f84b273fa940e84cde8c0b24b56062bcf4e069b113b6955ee95d1a39dfb7f3ef57424ac48158d85f609d768c634b14a4f696e0aca0b8b57310ed98dc3211495e7e6d64485f48e9c29ace488226559fa744eb13519795b388fb7a991222dbbd9ba3a1d1776d16f859e322947d69850a8347a44a4022a7464ec1313b91ab1764589450b5f00257981836b94a86942baf0b6eca891d011fdc8d6903419b065ca31194d6f0a0ce6e7f595e1c393c1872a13533e2b6c8ab97f4bbccfdda0d1c8cae15d397b1ddd0d2b54ea1a427a75ce67ce1b8ba6c6243513d7b05c8dd9e0f9612cb3837cf2e5913ad64e7dfbfca0f97a3c7a7274f2ca8df4e72da9464f46d9a19bb40f6371fab58abf697eb6bbdbebb73ba215b5e36eabdbe9c5729f9bed6e578a7dee772742f67b1d8ef7e249a76195e47aaea725eced25d767d214daabd5c156a45c9e8af999b1115b75efddc6f09eda1cae8c76b6abadbf5c7484fee1eaff6acbc3b5e6705d6d0d3716b47c1c68f9e43996aa1ddc70a4d294af8979d07ef07766302bbddf801bf129038c8a3647de4c819f2d4961392e52b0b2a4c97991a7fc4f63c7c644248b14a3721dd60493981b6aa3b0773a1756b1571c6ea88667ed77f15342d9024caa7e40b198aa1a7d6f66c256ccc4e6ad877641e7395f2f2fd0ef3860079299f2090954cac2dd60ae6c1705a681be64a0f2d1faa3f5f19d4b0f6b761549d38aa4d0bc44062a50c65cd526a80533e48a0928d192abe2426bc6b31315caf008466fc82048127772e0a4640b0c2a9c9e19e7af34121b9bd5e934a996806f41744099b148319cbdc5394e533903378ae764e2182d826689c19a4cc625ac89480346b024e625f79851c10bf3306b2c3062c5cbb5cc76af64b61564f6f8c502da78c6ec59c30d4ba10d2f2f7e7ea517c3e28acb8b5fab645e921c5ebc30f4348af0655c4c85bdbcf885aaab60e0dfffa3b87afd2f7125facd76abd76f757bdd562491575274782fe6de7edcee44b2dddb6bb6b8dd948d738613c404542e430bdcac5d71b31db8593f1e7d35a62bdffd71ffce448ae13233c366e028a5c32ac2f6735b296429162c5178c27d3a72b7b63c532e82ec4a95e761e5c8077e8b8acab89e65a2d59b82172165c05ca9d8ca2a0b7f98c2430ef33bc47b43a1a58c2c673000c99405c2c989986b0b7d8b08f6662be0b95232cf4a4746d6e461b260461732174ebbbcf8e9da2f32e14c214b71d38d97467b882f44c43203cb30c0cd4b2b4cc1920631b04318bdccf16516016dd0019c5d996f9156b78c776b11741a387f692ba11e078e224ea12e7b2b226aef0773f96f105055f15338be11c89b410d7f01ebed0620	2026-06-04 13:01:31.914389	-5674015731098436537	1265
210	\\x70726f64756374696f6e3a6d6f62696c655f6170692f66656174757265642f34633739316237652f6c696d69745f35	\\x001181f80926625e88da41ffffffff789cbd964b6f1b5514c7edaaf278ec38b69b367d108871692805bb77fc88937b1775503b6848a0556b844416d68de78e73d3c98c3b772626a4121b366c90e01320b1608b58b144ddb066c94760cb16243877c68f499a98a758f871cf9c398ffff99db1cfa7b7334715ac7093bb5875e83e33cae9877498c2a97b1d5c3099e8797ce073d731ca59c1864f864f5244e9e0ccc0e33d66a534bc6072d17303c7ef8626842f0866dbdce947e7b68a0b1677a83d395e99dec0bc1e737cda673c812f4cccfee100c24ce31e503b9006d7e3fd692430087a00794497ee4b3f2b857046f86eef313ff74e12a7c5e340d66cd634ad1ed6ac060ef78db2b2d90f8fd921e3fd5d1fe1bcc9f79923a047817071e0b966d08baa30ca736f796e8f7987e11d733bd4ebb92698f30f1edead208434b41a5ec9ed0aa72b2f21ac423fc2282742bb6c6a60d3c3aeeb99cc4378898bae087626a2769943776c66eaf81a5c717b3d2acb085b0cabd071a12ffca9d7823c4d654338d7a33eebbbdee1914212bc40524679e12ee5de61e941144144e3e2fba17b36fc14db099cf5a80fe21d29788e1e300faced0cce8482c3300a500d77baa19ad0059cc6d3905514e16cbbc3e8321cc34f38513f80ce7386537a242d61e67ccf6350a2d9a5fe7bb8b4d1f3f9017b140c06aee763dc01e1dfe7feee07aec3b6d346805569c9ddfb7cf9fb9ff59d760aab1fc11564948b1b82d3db9baefd98fa54c63502f246eeedc8efbb14a9c0148381394e445e97d1c06312093cda579ebf6969978aee7e60fb7c60b3ee938042f73e672236b931b6974d6651f0041c3d0e7e5d589902ce8d4e625b395a9413c0199bee30db28ab5a29028d5c6aabe4e294bbe24e70185b0f9285e09726b08f474de6470c913cc217279723d4c1c22c8b85624ee22c439cbce463b40e2aaa220d5f0d2f77a9e5336f3244f0bc480f28b765ae688c3c8ff372cc51931db2d209fb29923ab4529bb462a56ab15e4843d62f33adaf93e6b19ac92a22adf64d5915596b5f27ebf01df3735b49427419bc02c11d896bda1466784f1ac28ebeaa96d268920c026d2a640e5e399e20f348862d20526c67c8059e220b4679feee86d1aa6fe8ebe186c72bbb84c82222978f6f30b9125fdd6668ba8ac8b571d92f20b2a4931775f2924e9611298d97aa5d242f2352de4e90eb607a05f2df8082563ae4559ddcec90d7a0902d7738a59edc9a22d806de3eabed3e8d21a847a6f3d244aa7fddf57687202bd368549b4da2f179521b41371f0ee90cde60469550c76647ce273f7d7a449302e755394110bcd5be4396ad5483ac59aa566dadc1d0eec0d052844c78c89fe0a1bd722c95a5d41b00446af5541ab664f4ba8c8eaa9a8cbe05d1d51810fb120825c68329221ea0fc93349cd24a8c0e45d25100b486a6c786de908df9c8bee9fabecd46d557c8e2b8c899a83466a0d201c6f5ff8e9567dffc8a6300dc8b4cdf9ec6ca2cd7db3a41d09e8680924428ae2dc5cd8224a25e7b4e602badb15aa4f11e68bc77dac625a4a66931bae5efed5afddfee9a1eeaa74bfd8af703bfe45a674bf8fbb39fae9dd0054c5f9c26e12cd770dd1478b2697c6eb26b73b377cd52b45aa8e18c6d8357abfd14a8d992abd0acae3760159ec22a247f19ed824c940b13d5a789de3dbed49bb067e91a0c2dca94b1f887cc1c255981242ba405435d5f833c9b9027b3daaad66b9028f90964ba115bba3dc9c5628709f97fa0f4e021977f1b4ada1811d5143148d00892e4a74009bc9d8589f28f28d1fe2f4a6ec19c7ffb71e987d8e85164ba7f92923f739594c0bc3578908d1951673f24e5e8a476670f0ee2c193b2093f9cc92f61647bf297f3c6760c8eb4cc90a94de9b0945afd7892e457f2975903594f4b34c250ae7d1d0881346b56bac93409c8d790eee328d91f89fd3505	2026-06-04 13:01:36.708113	-169257848194812202	1582
211	\\x70726f64756374696f6e3a6d6f62696c655f6170692f70726f647563742f34633739316237652f3834	\\x0011813503c66d5e88da41ffffffff789c8d56cf731c471516815a49238d2dc9384e82839b253136c8ca48b220357d91ec68ad2dff88b13665822ab5d59ae9dde9d2ccf4d2dda3f546178a73a8048a1305e5824a15149ca8e20007207f478e3e72c17f00877caf77572b99104755d2a85fbf79fdbd1ffd7df3b599a3289e56a97a379e2d45219bf51777debeb7fd2e7bb0f590ed6d44d1dd3befd5e2da762b5e48a54d8cea39a5cb66fd85af7cf5c96ffec856a3e87566449f5d6655d951b99346a661405bf734cba470aaec2eb352b39ed189b416cbe1f603e9842a2d2b85ab8cc8992cdf1f14d222505939a364e9ecd0b195a9e4609909a30b444bc861f84a3e60b62fa50b833078faf883bfd089b6ea0ac30af508e7b0273ffd3dd9449a2aa70e119b0cf72b2359a64b3918bef7cb3fb1db72c06ec85276149d1906ab2bec86d6d659d62c8aaa546ec0c82f0c1ea82463aa64a244111ea95478903b32ef59cacfc9c431d1a5b41cdc3a58a2563ee4da0abb374a74bb94a63b60bbba3289644f7efdbb30f8618514113565492e45895a78977d02110637a4435999a0e2227564c29c6606704b990e33a623d657d82dad53d6d186ddd4798a42ddd4553703f68fff1006bb5abb0c357099d102516feaa2d0256a5859444152992e24a2163255d263bebec276ab5e4f1b14e22dd59596b241b40ffe35ce5915c81a70ba95a35ee72e0b832d955a56a0b9fb3a57b6a0401b087480132eb38732cf4b4c014363c3e01d3a99e07673dda786597885c1b8501491ac38a3278d1ba17afaf8e7fff8cfdf3e643bba4f65400c348cd99e06b65428247445163db4cc3a0c4c925d0d83bbea11eb2b97b1be3005fe50352fb35c227fe04d538ae3a458c6dce4070c783269f6012035aa3cb01e27139349f543472daaf1e9561cf48c4a6407d5da906bf1b954d94457a56b7b73142f59a48c2c86ebcd9978016d13f9f1f2a5c90b12f3503ad1956a2a5e3a36bb410f6126710f455e91411bd59d4482c18a439c63dba220bf4e2d8a039420395073f18c3da89af533f7b65aeb6bd7af37220f7c9626bb599fbeddf5cbb9be54ddcc45f1d95415b2b434b9cdfa94df5b440bd22a198269d6e76fd15d3603bf37bf2f4ca25398cfde7ff0d6b5083f6f5ef73b6166cb366d45f12cd23a8e46b9f57231686b934a13c517956ddb6aff985cdab214fbb94c1bf12bd8d14922088ccfd4a368c40b5debc65eadf81cad26d5ebd436e2304193bbda0c8ea6f9945ae2b566fdc278ac76c7edb3c3fea9022f45f19c7fdabda978ce78d63a9a8ee7c5a134b06ecec681af3e3ab3004caa6cfbd22217acc6ad21c48b586398c7db8bfe8915ce46fe61b364bb64f1279f4d0cf851a66de1de89d95642377b74e1e2b885263cc4ccfe184cb537d3ace259b2841f7e74e9937fafffa2518b67dfc74ed4ac2f6e5925deb8adf303e104c56d567c39fcd5d0ef9f357e0d1dad7ae9f820fe3d8a068fe348f0d87cf97f5fba9809db2eaadca95e2edb3fa988f3e80e3626fd1bcff0855476043c319b46c1afadd2280e470baae87923730f60d441bb573bba86c6fc881af3ea506f76ef6eddb9c36eec6c6fb3bdd58de8d6ddf728193e03a9f9ef0ba403e0b41c8c4a94012960b68002b02b965a958352aeb27d097a7bfaf8a3df9ed28d549803dcf60cc30d6ee881a44b3774d87546835e88f012ba49cc5fad913a8d246da45aa4691391392d289fa73a5e64c06ce0cce76bcd7ddd97a653e513b5f1ea03927abeea74e8ce9ed09a89368e54e78b24a16504254277ebffebc069ddf02235a27d0baf044f3318c9cfb15a6c0f248ef29cbfe365e104dfc3b635a8cca14c85c725e19b08239fd514d2022f0c2329f2baf2ac0c35c7484e2ad0f8a2a7d2e947e88d0735d2a12f10e126541ba51d8b2f098646d42493854a44fe25c507ff9c929fcf571f6dbcd684015df1d372e3f5e7640bfc3598ed6052de946b3c88f8dce66b7c1ebfa19ae267227e36e20b115fdc9ce54baac6cf0d797ef5fbd10fd63ccff3af1f733c3fdfa9adf217473ccc2f9c6672fed2490a5ff7a69723fecad8fd1b11bfd8e0af36f8375bfcd2e60267cfe556fead88d7f7a6f8b7e1f91af0bd0ec0975bfc3b0d7ea5c5af02e81d94f1980ff9774f93d3a77f5d5e7f869c60fa3399f8ca97777da3c123146b35e26b60a279230f95ec13292da5325734bda0f38e3e82148b43b4904405140e01a1fbb487ecce6c81689a65aa3cbdc61768020b4f67e308f8685ebfb6c1f62b7cded2d74d2a064371396f33d5eb91fc27993098dd66fd52c3484cf7c8cef09984617ff2b3bfe3539b5ef90c4470e296	2026-06-04 13:02:23.71308	-6713774109850636985	1849
212	\\x70726f64756374696f6e3a6d6f62696c655f6170692f70726f647563742f34633739316237652f3833	\\x0011819bfd59935e88da41ffffffff789c8d56cd6f1b45140f0539b193cd5769534a4b0743430b49baf9826ae792b48d1bab492889ab52a2ca1aef8ebda3ecee9899d9386e2e8873510be284401508090427240e70e0e3efe0982317fa0770e0bdb11d272db4444a9c79efcdfb9edfcfcff5edba5eaf08c4bb5e3661312fe64f2fbfbdb6748b6cac2eaeac904bcb4b4b64737adebdba7a3be365964ade70c0b5af44dd089914f347fe3eb2f7f9b7e4b28c22ee1b1e90aa9231d1318b22724e1b91d422aef57952e15c93870fee7fe1e4d0be140a7f6b82044c6d9171128a5a1835495d1a9e9896c1865132a9919807c217098bc8368b52ded2adb3065c4a93ba923e38e7819373720f1fdcfd81ac49c2824018b10dd1f63ef80a053aad314562b103b958d9f5547152958a6b434299f066ebfa27df916bbc492ef1845785d1289c9e22d76583ab6a1a91621ca789306020a5365c11bce1e4d6851f12911096403f7644009f70759947754daa50960165153a03cdd224612655d0191b71668a5c9532c04cb07d01947459a6b5101c7ffd8d932b298685c804ed490a55629850c69c288e6de11067434a1342a92654921948028c62680b96afb80f9fcac69a9d221b69bd2e95d164a9c921d4c616785be62c3221819e3ab91bed088bcd546df380d9bc38d8fa4cf14e456de744e3ed5a241be87c6e8a2c8a40932ba2062d858ca182bbbf39b96227935a0a8db6a19cdc5aab0524e046eec06c6c52e8657e8a74744b0957b526d990a9f239d9fbec4bf0956803ad25bca56a08134af0ea873c163e8b746b841ffdf2d74ff7c8b26c10230914041324ba2e21a38009e822fcc3e33acc501b19331fd259153bd619693015c31f1cacc46d89b69cdc4d54845c55305f25922d8dba4323c8d0de9297ab2be1f32aaccb453ee31d0d84f6659a98b215bbdea8e65104cbd73a2ff479c355dce8fde389ee050e052786d5b8e8f146f7c5a65907375dbff62980402a51eb7a028166db104797598c76d58cebe5a0527f4b64bc3ebd9516f3836b8ba5e937ddb7665c9b781637ba98efbd56b3c7fe06c78dad66a6bda140c43cd1b8b5c57c8fd58ec03483d46fa553cc0f5cc5d7a79a56375061ca97018887aeaf5f9974e1e7e2acd538a14ecaa872bd2c14b6ef0dabab47ac59962ae0caf54e095dd669651f59ca3c6195880705ef2468a4ef336ddf42b99d45c11bae69d3b12a7947f1d4ed5f3533ef393e8cb3265573b797f688519a29e6c73a2bb6d1e0dce032b5272862b8e47afdf6536ff678fd8a2178edf67a030c5e114817b25ecef61f66330c3989a46c9b0bb5c0a9331ccc7804cef0363aea11fb0927880df50faec07e6ea0c8861ef215873c833233373cb2e82376b5dfaae795600ab885ef014c6df615532f8b12e7defd33bffff1e3c46cc6cbde018d5bcc8f2c6ac12e5c93d116330cfd16533ae17cdab2fb3e43275d6f28ad079d40f40df40616fb9ec062e1e4e3974e854c97e33432a21ef1f2fb29c29c81bd2f7407d859e3b180571958c27a2a01766511b89ed33e604b8f291ed904da23d49b99dd4998cc2d9cccf116e9ac2fde249bf3aebbba721baba07dc030cf3c8ba03fedba67896a237f5544f05211f85105200ff082e39a2089246d5a80639b2eb861a28bbe8021779a31c0d2384952a304b7887d809418301878f3d1a003d844e3c21ce499c768e531eeb13cf35482b174a2bbf4f2745a81fa0c300a61352ceb20c1b469e50938fa4e0a255a9ef023ce920e9e5630092777891b044086cd85d2a112045205e926400eb6e2369b3c89b90e939293bb2ce35826ff4d629641f6e9e95116394c3c07a9c4924e0cc3adc848e8b84d2296d8c6c94dc0dc04b6e000b961bac859383024b02e19a14794420c8010d3ceeae97c72ee109b9cff773a19271187fa21df20403f86b3094b30964c0eb28bcd93b0eea6ea0e4ad9b790ad42a3e6f90ccdb9b47fe12c1d805f47f4d041970eb974d8a5230b593a2afae9d116d0cfcecccd152cd0d3e7f7419e1e73e9f13608d3b1c3304e4f1cc4ef392b7ac1a5273be62fbaf454819e2ed0974af4ccc208254f0556fab24bf39b3df415b07c15b23b0be98e97e86b057aae44cf17f34e31e942217dfd302efd39fb71e1115c02d1af28a253ffdff44281bad0a96997ce00080d28be2d7803f16834e091c06f4800e555b90b44ccb661ac482800df401ef8a436a1b8c145f8325b4c026191d51bc3fd8c2d92753c007ecd4ece934a0aa8834b17b0668b588ee950d4eb48fe7ec8146c76317fa6a0387c836acb096c2fecf5de873f03eae1957f004cc9e29d	2026-06-04 13:04:53.525126	-8018966987731143859	1837
228	\\x70726f64756374696f6e3a6d6f62696c655f6170692f70726f647563742f33666633316366642f3435	\\x001181c68fa58a6a88da41ffffffff789ced59df6f1c471d7710727cd75cec246dd3b4a5991a4893629ff7ce3effd815c2767c971c759cc877262a068eb9ddd9bb91f776ae3bbb768f482882975201e5474142052155ada0483cf0802848884a7de415f1c453241e11fc07f099d9dbbbb5ebc6ae82aa3e345212cfcc777e7cbff3fd7e3e9f597f72ec8e619ee40e2f9a199f765875f2426da55259bf79bbbc496e56d7c97661bdbef9d55173b45c37271c26ed8077432efceae4275e3b718306d4e3a446fdb0cdc86d211c722b605232077daeeb893d16909bdc235c926e209cc8c648d80e44d46a134a02e6725ff504d4e16a51ea29331b2bc08a8684f932c27ac4f618f509f51d620b5f7219321f832f629eada6e54925608cb881e810bbcd3adca69e9c22d451abee32f523a6b669d071234f2d11d20ef771688c846d9c4de0881dcad1cf7d497828894fc308be793de2f1563bc4b2546d0677d452dd28e0612f9fcbe6b2351105ca2b8707cc0e61af4fe1622f199bc6fec0628f876d3499cd25ce3c856d88c33c9c2f8025911d2130ae7dd4deda42ec70bf0537bb2ce0ccb7d9bdbbaf76a8eec3545870872160765b701bce8b8030acd573688f44928d5a27eb66b61b60cccd96f2b3ac689e73b8b445e4870ddd6d986725f33cac17b797c7cc09dc07f506cdc78613189c44785a8c8f986707dd61af8b6586ebee522f521d22e0ade14ae8907417fbc806ed283b77d430b33214f60e3f698ec99da83a791ab976b5585a9a9fd707cf443e0fab93d9758e90eb9e87f698ba08c31c777807798110caeae4881e3b13e7567c9eeae4a96b2ae6414f8f9d6ad2c0160ebac76f6dae4d1bf83357d223b9b6f41b6ac83033f06cb09a72afebd15e43040e0b0cf3492e1b326a0e32bfc17cdaf49853311fc788b06d2a75ea36faa7a898132d19265675f39c6a0d03e88e96cc9c4d43d61241efce496b849fb346e12a025023f1adf10eecaa93275e6a8761579a3333a881bced89c84150835ede169d19c76db64a2ff40ac68cb69e89ba9ea0ce8cdd70b9e74db90d1a8562aadd98378ca917e2c65e63d13066760b33fd73cae487e99075bad345a3e8148ac61c2bcd2f2cb98bc6171af4f3ab2b57bf385b5b5b8f6f406f24b7473f7a270b6888f4ba73d23c455102d874396366754a225d27704bdc6fe87cc3eda295e4abbac3336803a792e133fa7fb450ffc888d3eb628fd45497de68dc0e186ece69d070cb242bb642975ad4ed8a2034cd3af2f2366afccbc267db63d5c8cca89e1c7ff9e23bafddfaa7336a66be8111a33a796645723af39cf0766848d5bad5c89acaf9b1dd3f46ad692479d475928daccfa9d5fa16cfb36f2f2b8be52774978cbbded6939e6c53d9e8445ec8bb1e6bbc1001e0807f4c5686299d54f67987b91496a8d880c3aec11dc3ccf51b727bc47c24609e3e407225dbd93bd3c8d5afab5cbd50dbda4853444953041cb1c6400bbfffc4bd9fff3a26836e9f0c2e03957776a22b29ccce6595d5968fa44089c3e6dedd1f83106204eea32ff1a350415f2863eb7585000073202c2edc269706862de1394c61265231888d37449a0b7c11b30dd244a1f67f7ef9dddf915be0166cfb3aa9a7f847b537fadb4e235aedd8fc47bf21cfb11e59653e5651e7c9650b79729dd12004f9c0d801f4dffbc51bff7efb955c7613d308f7491bf81cb6410954cde8278a244d162a2201707b0c5416088f34a94781f06ad9629e6cf6c3b0d1f72e398f2438f75f72d954d41473ed30d69564976b56037d0166ec30975d8db70191fa03a685b93efb6c3e0e264258a6b2474241d6388a3bc40edffbb376e2160b5c30da7e62e993522ebb2698f4efddfd19c619f394a7bb3db5f05c9e5c5337af66d5608a0d6e83647c45e9b8955cf6aae8b3ec97e2f392722a32726710b538ecfa2c883a0eb6a512a92270bb6b947ba9a3c48eb8414f31e325220129efbea547c0cda0d4aaef20ab41d0b2cde0fcf5fea57498561bac4b157a085fe76fc67da8905f28b1592bebe28217f0c343cbcf58a7f0371799e3abbcb506feee506fbcb0681af9e2e23c2b58a781de2e7f91397a897177ac84ce09c33ab3fcac759667ad7331bd15ca0b95e2556df3709adaac470cebd13ef958e7f7d397f5588ab7960abaeb82613d9e983f61584f56ac4f55aca7ead6c5e5098b1c4628d6d38635b93d627d1a839f59ce589fe523d6a5baf54cddba5cb7ae1c0439ebd921e2bcf2838beffc6ae6e1efa710e72771d7a3aacbca1fdf74a66219cb97ac826115b747349414d429cfdfd8aad55736d7d25a3301923f9c280fb40f5102b3892a4f2931e192fb08d01b11403c7094fc9cfac88bcf04f852d21322d36fc1f59e9eaf904815d1836b4ee1ba4a713aac8b2184d0f5e8ae08a6fa9a363e2dc09fd326f7d001d1d94d21413a5a89425533d2d233df2f25a0cc022b5a590335b48a1a5ab572c8bcd386356ec4e59141798c25e551acacce95d71ea03ce6e68e5f1ecb45ebe90f5bc6144a85e2e262697661b6099deb2e1e9431a8d10f5d5a1d79a683985139123394def9ef1b6f7d2505047edcf5b78398a1fafffaf0bbd307040dbade1c62c66a1a33a8c28cc96bd58d6be5f5f5e7c934a9956b2b37ca7d19621837d687f0f1f70fa04334636b5d010671c0a7fb125d9748a22bb6fc04398ea15894c4981ac0c2b40ba418c80f08940148c4b263a851747b05ec85a52074001147cb9084d80eaa9096e6634810b8a624a178913bd4dfa748de5f8a5c538237cde6d7290f62265f5361f21117102b5e64501c291de56924887540874a896cc5e4b69a6cd380f53548b5836c54eec7e20333fb0ae7395fecf94a95c8f888a415850361701b0fdf647d9c69a51705bbcc4198069240eb9015f83a5df571791dc8453cb6400d0258a6243151a1545ac08372828e023728ddc40275dd3c99a3d3e37d65c83e759160e16526bb405b1d80740ac5eae30a6415b777106b04c36e47a1cf7ab8873a4a113ca7a687d4d9a1301b3a053761ac48a21be9d77a82aec5fc5c82aedb40d7edc3d03593a0ebc2dc4265b1fc20e2a3787f74753373f9a5a5fd087bb8ec381a4294963879b7f4d3035a025d4f1d263bee67aa21643b0d218dc35e30b3fb84c76fdf8b1c1fbf5c3e7eb97cf45f2e46fc72513f15f5d32504308478ba5873f77db0cc260f96bd3466cc964b0ff860318e5064cde3e0c5f19e29cda72fbc740004d03571185edccf54e3854ce3c5d7345e5cdbbcb9b5b1b6b1553fec8bc70f8f8117354fec4d0f85f93ecc1814c9a51821fa30701842c04495f67e49723460a445cbeb87c34787856de1fc3f64c6e51b5b95952b09bb76a8afc83f8d191eaa32aee634641c808aab707b662f1dd3f884bac902a51a12e0381231aea3d048ad237618b9258032d8e2d53773d9aafe80ae0afe008b5fea17651f170632a54ee1c11068ca7e5b619f4c6e433da7ec28801b726a40efaab07d6aefc8e3e2426af74361e0ea70e1ae40e73edd45d45bafcb641f133285856209889029cc2f948007275e0620e01f8508a76344587a2f202c3f3bfc7c31789f95e71717178a0f80068b4b1fec7df62068f0afdc9fbe79a0c4d1357a181adccf54a3c189eff4e1c03c15b05dcef6d4f7d1b3fd5fddf41a508be2ce98f918ddc525aa4ffe0d4fd81a97f5a7f2d32b9e17dfa0fe827c5ec9dc8efeb29aac509d7c7476ba449a91e49a6cc056fafacc47649b77bbeaf733ea9b0738ae3a79517f6b48fa096d222dc9bd6ffd114f1f35e57f6513008b	2026-06-04 16:29:06.707816	-2074435023218109914	2877
229	\\x70726f64756374696f6e3a6d6f62696c655f6170692f70726f647563742f33666633316366642f3434	\\x0011816cb3d28b6a88da41ffffffff789ced99df6f5c4715c79d0a39de4d36767e34e92f9aa9813429f6faeedaeb1ff70a613bde4d96384ee45d13b5862ee37be7ee8e7cf7cef6cebdeb2c9150042f5505941f0109158454b58222f1c003a220212af59157c4134f967844f01fc077e6eedd5d3b4ee22aa8ea432335dd397366e6cccc399f73eee43323770cf3287778ce4cf9b4c9cae3e7ae6f54aa4beb2be44679956ce656abeb5f1f36878b5573cc61d20e782be4c22f8f3ff18723c5db2d1670e6db8c840d46b684e710bb41036a872c20c225d7f1dbe3a4427dd57f4b0887dc0c9894cc21d72319d2c02137b837415a8170221bd2b01188a8de209404cce5be9204d4e16a45ea29351ba3a14543c27c19612e627b8cfa84fa585af892cb90f9e8bc1d2a2b302c4b4a0163c40d4413b6b126b7a927270875d4ac6da67e62288c6eba91a7a6086993fb30183d61834b22b8076342ca7d497828894fc32850c6447e1d5befe8f101b71b3e4ccb66d29974454481da8cc30366875e275edcc512522b77b7018d1d1e36d0643697307502f3e3d45c1648e2b016ba7084ae47db22c01145010f3bb1b501f338dde21e04bb77efe10e5cac435c11ec392d5b886deed7f508d66641c7a11d1249961db68e56cd740b3633373d9d9d6379f3b4c3a52d223fac69b1619e92ccf3303a6e2f8e9863b80eeaf59a4ff507306c16a756677cc83cd513879d16a6e9cfdba65ea40422e0f5fe4c1048dac63ab2469b4acf1d36ccb40c85bdcd47cc11b91d95c74fc00ff3a5e599e28a363c15f93c2c8fa757399c4c4b8eed305e6f848639eaf026dc02db97e5f121dd773276add89ef2f8f12beaec838eee3bbe45035b38108fde5c5f9934f0676646f7641ad2afa92ec34c6167bdd9d4f65a1eedd444e0b0c0309fe3b226a3ad5e54d4984fb73ce694cc67d0236c9b4a7d17b5ae152573ac2ec344ab6a9e56adfe01bac3053363d390d545d0b973d41ae2a7ad616c15075021f1adf126f4cae3475e6f84614b9a53530881aced89c8c1a1069dac2d9a538ebb552fbcd6c919535a7b2a6a79823a5376cde59e37e1d668148a89466dd630265e8b1b3bb579c3986ae7a6ba76cae4c764c89aadc95c21979f9f2f4ccf4d6f151666ddf92fd7e89796972e7f65bab2b21adf805e486e0e7ff22c0b6808f7ba73d43c4e110358743165a6b54bc25dc7704bdcaf697fc3eda295f8abbac393687b6227e93ea9ff8f1600008f38b12a76484589f442a376c070734e8d861b2659b2155c2a51ab2582d034abf0cb5b88f55784cf3647ca919952920c7fe3fc07ff7de7bdaf0d9ba96fa2c7288f9f5c929c4e5d13de360da99ab71c5913193fd6fbdbb03509278f5a4eb290f545355b57e3af673e9c541a8bcf6a918c45efea41cf35a8ac35232fe42d8fd55e8bc0376082c952dfa593c83ee730974213111b70e8d5b86398996e436e0e994f023fda80e44a36d37726e1abdf50befa746563adb47ae356713d4e1f059d3eb0116b0429e3f74fecfefcd7711e6875f3c04540797b3bba3480ec4c5a696df8700a84387476effeb887e004bf7e14aad413ca587b55110074046971e136b9d053ac232b311f34842b06b1f29a184c05be88930ddc44d1fb3fbffceeefc84da4162cfb36a90e0055b5d7bacb4e2ae2c7ea3ffa0db9c63a6499f99845d99349e7b2e42aa34188dc0365072960f717effcfbfd3733e9750c23dc270d46bdb081d440d588aea348b2c542953aed86f0183259203cb2453d8a0caba6cd67c97af718d6babb4bec910476ff25931e383595b8b6196b49d2e63aa9217f01337698492fc7cb208ffabd440b756dfb74363e4c1c6191ca0e090559e108ee102b7cefcf7a133707324e2fb374d34d26bd2298f477effe0cfd8c796aa7ed8e9a78264baea89b57a32a50c502b7906454da24b8954cfab24abecaccafc6f692e2c0c9c8eddea9c5c7ae6dc1a9c3b00de5482581db5da1dc1b3025de881b74541ebc402490f2e17bba07391af9b5ec3bf06a246ad960d8fcd5eea534992e36588b2a7a085ffb6fca3d96cbce15d8b4957671c173f8716cf145eb38fecb44e6e832afaf208f37a9379a9b378d6c7e7e96e5ac13a0b7cb6f33474f31ea8e14201c33ac938b2f59a778da3a1da7b75c71ae94bfac75ce0ca636eb49c33adb4d3ed6b9bde9cb7a6a206f2de4b4e869c37a26517fd6b09e2b599f2d59cf57adf38b63163928a1582f18d6f8e690f539747e7e31657d810f5917aad68b55eb62d5bab41f72d64b7de2bcf983f31ffc6aeaccf70788f39358745689acece155a74a96b178c1ca19567e7348a3842a2bc7af94d7ae1457575f2693a452ac2c5d2f76916218d757fb4cf9fb47608a8e3ecd08788383d8d85330e9522b61c4869f04c621e8a37031d163caa48b8ab38712c0a6576cc608e9f346b797e089980ad042083e1a298993ee274a5dc7167082ad29bc8bdbdca1fe1eba3c182b5754f21a8cccab94077154aea863f2712e08125457a0c700133d5d51c631dda45222bf6270430db669c0ba3c2937912ad4f6639060649756d77cb1e32bc2c8d844528fc25e90dfe20e4be6874d4b9d28683307c7d40b6fcd9425ec75b2ece3f29a403f0a277c6208d4542abd1175942aae3d50104cc4378662200bd475f3648c768f0722650f29929afa22932d44bb3e8041178a49720988e4f636ce1a876137a2d0671ddc4315150bbe97d4f0903adb146afd4d619b5056cc6e45baf2ee4207b733c3f256da006d96419b652b83183d6158a3460c921440924a40323733579a2f3e0e48f20f07899b9ac92e2cf461b2987f10424a8742c8d1bb859feee30244cf1f849087a96a842c0f22a476503532bda71af9edfde4f8b40af9b40af9e45721465c85a85f795d866c020c9b2843ac9987161fd349f1f1ea2033a68b85c72c3e8c47141fe5c3f0e27025c7d60b4fbfbe0f02108d1dc48b87a96a5ebc32c88b57352faeacdfd8585b59dba81ef4f5f2c343f0a2820fc6c9fe03cf1e66f482e4424c882e060e2204545468ef2d491e0d8cc1a2e5ed83f1d164614338ff8f32e3e2f58dd2d2a524bb36a9af92ff20333c44651ccd83c8d8878acbd8f6d4cee099c616ea260b54d59080e391c4b88a402395a6d866e4a60065b0c4bd7733e9b2a3224905fcbe2c7ea11b945d2ef4ca942ac50efaa029fa0dc53e99dc867a96b3a300db9013bdf4ae02dba7f6b63c2c1706563f100397fb13b704847bea2ea2de0c5b4c769990cacde50b20422a373b57000fdae0415bf3e044cc8385fb71802f90de87c848c282e2ecfcfc5cfe315830bf70f80f91c765c1bf327ffad6be008768f820163c4c55b3201a64413eae1d964a83b5436e0f0bde3af290b7ed0a755d70009e7a03d98fcb4ffcfb769372ffbe176eb8aaa73357ff495fbf5eeb87e8c77fe846710ffb026812d91402fd7a8f7ab74988b0de3f30ecdebdd7a45a86a1d0e03aa6411b8e927e4f0580423a299d0bd9e9a4743ef20642027f1d503c1f4d9cff72beb0303bfb18ce3f53f868ceff71bf96e68dbc93cb1b33ac303bb7e0ce1bfb5f4b118b1ffb0bee236dfae8df15ea59f5ad9bff740602de8f45ffd8cf06257f997d6771dfbb2944eff7d900b789e1601e0f589bb31df50a7aaaebbf9d1abe23c59d11f329da06ded5c37ecd13b6aed8f483f88925cf8bd9aedf89cfa90fe0a67e3f4d66288f9f9d9e2c90ad48725d86c28b35d8cd276583b75aea5f615408a2fa2d8f9fd7d19ec809dd42c222bbdffe63c1d045d8ff009d41005f	2026-06-04 16:29:11.413136	466417804245809131	2872
230	\\x70726f64756374696f6e3a6d6f62696c655f6170692f70726f64756374732f33666633316366642f3635663232323764373636373966313561633831393965646565346235623033	\\x0011810779c6946a88da41ffffffff789ced9d7d7023c775e0975cddf26bc9dd9556b225cbdef15aa27765128b6f10807c22480224b4e4922648ad561b871e621ac088c00c3533582e56a99ccab9533e6c29fa725292e5529c4871ec942bb1cb77d139177923572a958f8b935cecc8a9a44ade8aefea7475153997bafc71aef2bdf77a66d0180e012cc95254f15a1605347a667ade74fffaf57bafdfdcd4ff685feae64d4357ea45cb5c53644bbe78e6d1f1549faaa8f7a50634b9c6f2276f9fca145617322b73f9f1e5fc7456ba183a3bfbf143a943d995d45185994543ddb4545dcb9fecf9f2b5c75e5c624689152d695daeca5a91497a49b264d36292ac295285c955ab22bdfdd2a75fbbf6e26f0c0f1654ad5c65d2a65e55cd0a53e020b3265baa64a870e4b5c79e9534dd922c5d97a08945669a4c19738b0c792b303c383c38af6be5314936743cb228950d59d54cc9aac89654d4f50da954ad974a0d895d624643b2d41a83cb3ff17bfff0ea2f1e4af7afa40637f15aa5c17060828553b728aa59d4eb9ab546c5c1d4cd26ab56a191fcfbe460ea6849d5e4aafbf5bdcd039851649a2597997a2075b35b6c3536e134cdf35e92ab752cd00db5dc3c131498f225b88eb926d7b05ee9503035685a7a7143ed4ff59b1bf5fcc991d9e54c2616990ec5a8e103754db5f227fbce96e9ebd01653cb15382e943aa2c04d6a263c12337ff200fd7acc7ec4d49cfcc9c3b3284ea341bf1d5e978da2ae40f191a5e599f120fc2f3641bf0c574c6d0d7f0aa606e0c6dcb3e1dd6d56e5c69a6e28cc08a6ee54cd35b3beeef68435a6c9eb55a6e45277c02f7ab1286363e85ea915b9d4d1b26939b55652b7e0b7a6fc4a03d14032991a2eca162beb46e3d1bef421f578ba2f7ff2d659fe7047a505b55a6596c91fa15a83a382a921faaf79f1406ac880aea095a16f1f96e1b143e9e4506a901e003c9ca3d028555b23e9c2cdc037e7e960938fc1f7aabee5fc7c8cfe0bdf64ab0e021899d7b7a40216d1a58f140d06ad54d6646b3525658a967a8915ea9b9bba61a5522bf018ceab56e5215d6317fbf3f5d400960c7ffaa913579ffdd4fa8b87520357e09760fee4b18ca9ca67ceead50d187f78de7c3d3d3efc0caf77d7a17420983a52df549c0ba5c7f06c50c33d13d498bc73fb4177566473ad56af5aea6695ad3d5297e1f62d9599b9e61374faf17b145692a126f44f43857a6baa124c0ddb5f40a48f8ec33378009fc1fba62e646632b379697a2e3f3f9f071a0483b30b1fc766a707f2277b5feb85912de5b01b9bd259d9d0e09e3664094fc5ac060efdff04636f78106bcd30b6291930ee8b7a55af1b34e29956416e981234b122c99b9b4c36b0801f81e23737a1cd635205fa3b0c6ef9121e39ca01c02b39082ae98624d7ad0a742b004341878f525e53e096880cd043901fd0a2af48e7e0f11a72b5da90ccba36ae405b1568cdaf4ae77438b1a596d4a22a57ed66f2839ef99274bed290a62bba6e3269aa212b725985afd031d5fbb04a28e09c559ae6b73705552d66800c9efbdaf0e02cf415134957114560e952b16ec0f5b197172b754b630d737810daa131a845b7e4d7a07000c78422155038d23cd0aeda94f53ca053daac6b6590c49854d30de6086e7850145649aea9200241389180b48c2dcca074119c5f1d1ecc3a4f88731d006fca3580c81820193e41bb81c197e00ef004d18034870fea6375b9aac2f35f316445b50807d203cd3ef11acc05d09c22de225cca95a7c1ca50573ae576a4d35cfa0470698a9996b40ab38294d3e1560ad40cb83eb56378709a8b0f0a36754585ef20d88654831fab32346e4eafb19aac3010333e34a8b40538a38e3c5882c70713427a28983e3c399a1e867f47d403e923c1f4d160fa58307df3e450fa1675207d9c7339964c0633193af45697c9e9db82e9f7d8cc4cbfb795bae9db05dc4e84a8e88e60fa7d4ef53b83e9f7e7d21fc8a54faca4a5d2402c100ca53fe88070f2d6f4c960fa43170fa4ef82a2bba129a3d0b60fafa44fe5d2a757d2f7783195fe4893194f02201e7ae37bd704663cc78b1ec6a2f499eeab0673e910c8251c4c476c409cf70544f806206e00e25f1d20faa3c189f4506928329108c4a34089fb8012f7a547eaa923536a798615411ba91e094da482816832c942e92330e29b4a0e9dc56609689fc140240e4019748092888762f1dcae8112ee009443b16e68b2d29126bf083cf8ed7f7365c48308287adc4b934e558926ff56a4c9bd48933b66b20540c9e27969762e0b6b8f4830b830df84c95ff52cd5a1b3ce305395662b8c2f1a16f099c1a86ee94be7e5860463ffed975ef9f7d843a60db964399d09eb42c7dec0ae5a532f4371262c2978cea2be658e4938eeca78f675037574a9a1d7e9181c9b1a0e1d38aec9119b20655d57f0c78054007d721c86aaa1c199eb269c42b28496d59855d1151347f6a6c14c665c621c56637c008dd1d249ab5b061d418b9e59bdaa304d52351ae138b27010c2571ab6063f64532e6ec015b7400795349b34eb4c6325d5324150cfc13da8a604ffc725d5c375182a789363926a5d7bec79e4818103124ecad74ee6a60e230dc6e237b00522161459a0c298f4e6cb5f7af3954fbef9f28b6fbefc1a6f89ac2874d7b828d3807172b50c8222095b7a1d5a0ef7de4029d7608168069c3938d29c831f82d1f5109f83771c47c29c3c93c94f85b2c950d6194283f3aa658fdddb2647ba1b46b158fb613499b747d151eca9b7ccc82a4869c95e4c53f55d4fd3fa9327aefef369b6228c168b17fda9dfc0fa85ff7340f70c2c28fa1fcd81f59038b0346c6ebf622ace30eab33f0e96faa2312e6f13e46dfae93c871cf92622995c32e287a8603ba98682eda49a4b4bc1a650278bbb97e0e4d327ae3e19aefc9420961c2fbac92bc14e55832be95069301a0dc462e9b03a0272ec7bf43668e1486ab02aafb36afee4404872ee1f3a57531ca963ebf546d37c60a26053b7bac6006705ecdba7274752c7dd9ab6556000269358ea382be1d003f5c03e6fcf63c8f468ea082ea49daaa1406222753b555843d619ee3217eaa78ecb9760d0e2e5f94a573d943a822b61be0c5c0121d32d1e49c7e0eec2eedd950e85c5a71d2ff54560ee2b1d8aa71339bc8b03ce789c08a693933d4f62bb22e914363c34914e63c9bd30443f9ac30b605f9cc3be7822973f379b5d96164061ccae48e3d232ea8fdccee490febd079771be075ac1a299ac4a086d60094ecbc0a27a9548b3a52a0c5854c739bfc68d04483041b703f06d6e63974b57e0dbd33feb2a7067413998b28969ab6ccb3668a7e56a51add7a0feaf83aeb6d86cd33aea1cb0b8d6acf175199b51b46b9aa4bfc07966d16840175f877b81f9654355509b63c074a3dab0b5b5ece52283f66bbce67932ef807a0bb3cdb5177e89b436d29b4aea3a688c1ba028f37909045195aa3aa872a0f02c33601128623a009c914dc4d6d96654e8b830598de740c3d2942aea585ffc3a1ad3b6a472b5516435e0b3aa29ec325c8655e1dc455db30c1d26902acc6ba004974191aaa216e96871a4bc9a525663461955aa826530ad4cd6be67be044db1e5a61a20e4512e70b839385a98a5a11d65e8d61add324c13355593f1f4b180348b97c5e219b50c1256dda9285fdb3474d494cb75cb3630820a2a9b0d9c5414aa2c6dc1d48c93eba68c9af416c815cf1a0f086afd6cb56e310de4c1d040f8e9afa0b6586274c532fd048db7f42ab3d71afc19c2c518ea9dd066bc1a5c46b644fd730ec409e5a0818200b0fbd6ea0ae826a784e9ffb4fd8ba29bb2744632740b14d1251d347ca50c35f1fa76f790151899a6531fb44b4b827588b6e128a4a86412bb7b3e03f0863f3ef47615cc4c626a3a34bd8ddedd4e8df14487a9f196fd59ae3e013319bb7368da63e282a2dff552bc53559a07412ac24498bf019f1bf0b9019fbdc307c755d7e889cd4492d9e4eed133f1cea167f5ed5bb31e9e40d1eff9a1a75d551ff49c45f4dc955b7c7025939f6fb2e75ce681cc3958e6c65a6d661f3c98d32f5b000b1b2b1e12d1a8a7459a02ab5cbb8ad03d686d898a20e0a78a4379cc654edde42b3438d884ba55d69141fb3d7a8136b6cbc4dc2368ea9ac6d04b28c332ac68707f9a8d1c7700cf31d9b0f02ffa21af7dee657e096aa641a791d665a06605061b9ae27418ab6eeb1064305c81a986a2ea9764b358afc2ad38c39e40e402c14b0a07418aca2c6c20dd110c3658e8eb16d4e7676910484a75ad8887daf4f1c22d5faba1f3af61c36d4958e6c3c52da66a630ee98061d86610c3595776729123a362e8f57205e626ea43d0736c2c5d278ce6ec867b70442edcd1f654e25e3c5ef51400b22ac387ad0aacd4a90c68b3ba5943302dc19396e151cc704ee595aa0acfc9b25082672b205945ed1e44aed53e148a45a3d15d832811ecd23cb00f20fae572ed210f5da0e82ffd40d4aeaa0f886404d1c959d481e6e72f00820ad94266212b2d02961043a2b5ed3b64ba3f8f63092d55a85f9c2a56d8c646fdb4c42ec3bc62f75aac45fd9dcc58d00b14b4e38b362fd7ba8c5557350300a39145fd5918861639791d8b95305993edbe6eb03118a08819b93a5e825eda34d2eb6469e2c8b3adf3746a343ee1f78c6ba4d3d56a3bc8899868b89c70c6709968225b3431c2e9f4cbaa22530b5d5608047142216cd83515b0c2868a63744e560d89c221c8dda1815c54b35283767ad513522cf1c89a0c942be3f8aae0c1002466836e47fe9cd5f42d0d479ec99bd8a2b19c1714576853a651372e3105c42458fa016e19b8d7f1bc060faf56932d9d5bbb409f45a7b20da316940227100955f8601f63436d27fbbc8f07463ac5cc4d86ce0c68a0d885d0fdc3502359528b1b558f3b6485d5a05d74b8252be41568de14dc2654861e206dd629bac3b137860351c7ded8f306f2e38d9df901e323114de4267c2d8c5ddae9931decf4ae2a730b0ed241b86441da9b5d118d857d8fc57e4900c46778d107fcec8aedaa7296bc21b2e427b199b7cf2e2fae9e9b39b7ba6233647e65b98990a7b723641b3ac85eee46fcb442c18141ab43cff1a395b959dc76958d72ab780b6b80080e3b4c8c2572f9e04244a4d1af126ee8c3ca368bfd7ef0e3d4c26a2e73da19363559c3512db2a3454f5ab6a570ce95021fdbd370db67b64499f216bafe0453baa4d28206ce34c570de445bbc2639770a63c1d19448dd2ad4f40d06b32e0c607446be020b1d8521b6813d9ee1392a958c4613112e7f56c8f7670f74c127e838644175b5fd9863eeb88593991a6833661b46cc88be06e1ea2dece06c701d7ca6ede16b5defc1dd17d54d66daa37f209408c7d243f0df78228604f80112e007e9917a3a3a427ebcb0edc61b2ca18f885b3a4bfd31282436f4fc13c0a1df8143363e319108ef010e13c92ed50b80c364cf9b7b73e2fdefe1afffb467a043d1213f26b4abca99f0b6c88487900977cfe51732f3990b19697af9426125332f2d2f4e9f950a99f9158fa5e5bbbde27806d16c48262e36c94f37873e55b9811d5706d5dff4aa0fa35ebdc0554460d0216398a010e36fe8111f73350dbc5083fbdc449562bdcae462c55121b6e9184488a2d140af96d98df166c16e823b78353eaa5b1b2855d50d8c8c84e6986abd360670286b0c3ffaac48d0a880be469b13f610cfb46ae4cbac4ceb9502caf3ed97bef049c7efef92b68509163a074826a0a86344802326c0132aec4dfb55dd74b40fb761730dc5906dede3992f34f9a6d2bd4aacca8ab8246c584cd48e50c54073438beef2155f2d08ee47e5a8b1cd2c1ecd425c66b422c35d6818b63cf01601c1790d3fc964ed30996cea7c569861967e99db3a00d7b4c8da928d1afc41118f02a06bba862b159311da0d5cfa1af068402d33ea18a162526406735c6cfd21c2cc5028341120d0f41eee01d2e05f44cde1249026d63e5e60201e8073dca21e765632138989a9a9d0aec305baf57376152d300c82dc91337ffcb5f1073c8e4a28fa333fceb4ab4a9ce91dea114173114133ea82860033bd4cb0e19cf1d8546e90e60669fe959326811ea1d2603c1e888510341f26d07c9883a6cbd8a48108d401d61c715813ce458299a95db326fe8eb1a6fe17e98b1e8040d17ff3634dec23f99ff45485a2ef08ac196d61cd4f90f5b695350499a5c5f333d9e51b3acd0dd2fc389186a66247a589236932449accf59106b49a289066c421cd542c16896cb7cf764b9a4e2eeafd23cd09b5a078f001457feb479a7655fdb49a8ffb68352da4b9a1d5dc60cd8f176b602a1e222d66771acd64ef3d3da23e138a67a66662bba6ccbe78a3bba2cc99ff6eaa1e7440d1f7fc28d3aeaa9f3e73012973dbdce2b9ec056939737e9be3a7e7208ef6503078376ebb84a756d74a2a8e0ea6b866d50a8ff120a3aa3d24a80310433c3e1da65d69d4c864eff1eeac54d4e286b09b73d43904375e6c31668960e19ee49a7ab93d5b2abac61aedc062fb573d6e550737ad0e1e3e10c9cd5ab424b98cb765a17f839101db21880360db67cbb72e48d75ef8fcf0e0c7ea708be4732f0218612cf32aebd808d73aeb75a6da4ca13bf6bab4d1fa0b829a466f2eb4fde52fa03154b72ae8f6af183aba5fa7f51a8c32c1c353d16b38806b4c696ec370e1e3751df17b767021fa8d88363578b8ebb883b766fbab6dbfd6791baadcb7b5eaf8aeca557d0b1f9809b586071d41e119b174d37528ed44a3901d88ced9798ad536e1919916749862e534fa942f4b3b5006daab10f92c268fd901ffe8be37d6d19d4484e21c929b3d953a1d3e22c747140dc41c1f51af49f481bf3e5ea221e2cbb9cc4a241c8de682bbe64bb44b2de6661cc2ef71c459709add551c7a5becbc15793ae7610914bde6879d76553976cc16ec3c886d7e3fc74e01349c79698a367984622d3acd0f49a7816e8eb39eb367c3ace1c47dcab4680bb9699e96d61979219ffa5c0b4a14d9d8403fa95aae4077017d80fcaae4668219147a1c8e81226ec596686fb60d2c9b72eedcded6c7bc0d44c41de8ece8bae8889f252784d00550731f58271095285ea6899f262e1d6f731b4af8a805dbd1d08a12e296eaf8780c56440daae1d55eb20d74b012069c481b17014df7b24ced625097fbaf5b3183782056eca8d8ec147ee78c0185340fdbdd6da3a90d97f3007210adc3636408c6c6b8dec2ee78041f5a88e40f2474e1037ed0f10e3fb4108890243e025bed19edb017f590c39b503c98086fe74db7512d1391ee8133d9fb68cfde7cd17ff3b5b188871850f49b7e70695775fb56d42944cbf1fccc7c5e129256d844e9f97b1aff9ee413a29fb9262aecde08142180d7d44bd69893624255aaaa5d27c78c1a39687165c1a36df9c46ea8147c60b1cb706e1b36d3a8078c498fd83b20ed0c1634389c983e7b894004125d987c8725752fd91e002a3a77715395336385022177c6fa3ccd589ff79db19a019ac9603499dd750f8a77d8cebc5f715198fea0f0fa1b5ff5043b4151cadb7f3a55e593d3e75b26a7144da8f7676667b3cb17c6f9727b1c7a913b2dfd971e9a6549c5c1083aa7bb6cc9b463f51bc43c00283c1dbec3adf97caa2a0627f2e7b66894650d54ddfbe57219b7d92dd12e533ec92dc8704215569c1a5e003b68dd59ac7b62a076def1d7dc8748fb2277dc7f88fbfedcfe8f731e4c37f8abb39ec6f39769d6e3db1f650adcab8c093b1f796f6cdd3018b0fbed6b2da117d24f89b15934377e56da394a1bb8fb5beeb8dba69a6d5f4acf90c85bb4e680b3139b6f6b0c3447871bf3d3fb2a8d8e577d47876b950a2633f1e4ee774ec4bae56b57a36347cdadefc913572f3cfb7553e8f18779d1fff20e8e4e55f9e078b5657094696feed9b9ccb9994266395f589dcda0d55b12207ba029e1b82be16f9184bfe52be13e47c2c9e9442239b15b8d39d96945be4ff8f92300c8770b5f7e4310dbb778d127bc12ee54954bf85b2d125e40094b671767169bd1e17399e5b3996d26bf7fe83dab2bba13f67d6a0e145ef9344688cb921dec4d9a1060c28ed716073f4d36d71e7baeec46253a661d2720992feb3b8685dbda9bb6c7186e276e1b03f45af68d847713796e0754f9079ee34e14521147a5d9bad5a2a9d28c6c528e095238511f6d00db44dba13da17be3b5a3dd059b5751e9df21cedc913c6f76513530ce5c880777389923818e6e0b0773b562c1b2e7c699fb993cf7b217659e9e364e0eac65db4b3731df8295635ba8b71dd6ed17f3bd8b3d27996c70666a66f7a1dedd066aee43a8f75f17feb2ead153a0e8effd42bddb55f509f53e474899cfafaccc679b50296430dcbbd563f9e7bdf3aa655599b0ddc48589a3933679e23044dcd9062a05ccb5b0a2322cbef39fa98673b687754c85d0e888943d6e0b690945de0798b4dfc6d22ef63aeb19192e20c465abb88fadf32e95f63b542a74bc671b89838d73420cade04ba1ad24d07e55813be08be00e9e92bd6f61db4e81761e08aa6d7b1f7878fc75330327d9ce9ac84053d70b4f25e2bbd54412fbaaeab5a7c60fa664317fc1b3bc685baa03da2092fa83cf78aa42d1fb77d444d66921b490292c2e2e4b339979af0222287a1157d1bbb917c50b7fbb48d9d1cc7a939b0a66776d2a4dbe43e2fe4310d80bc9b9d70519fe575e74bf57dc9daa72718394047117b9b8b333f9d585e5cc03dbf43d47dc7d713b5547ef3d24eb7b7afdba72bf23db997024319dd8b56cbb3543ef836cef3afdcf7fe61118143de027db7655b96cef6991ad4256a185c5c573b3d491fd172ce140c2edc719926da6bd6c33f1687262f70b967d09bfec6ec1f2b7af3fff6b9e5508147dc46fc1d2ae2a976da645b68c32743665ebdf6bfb4311a7db3e48a27df0fa103115cb65a2bbceb497dc97e8b3ee44fd838fcdfcbe477e5094f71375bbaa5cd40fb688bac411b1b832b79059399b2759fbf4643acc4fd63b28c9c15c783ab45d49ee56b6fb126fd39d6cdfb27efe8f3c0283a28ff9c9b65d553fd986b86c570b2b99e519be8329d4b283e9777ab297716f19c3ecc6b4fb1a3d2bc58a8c7b98186d6c6935dbd166a7257b63ce421d7562455a54ab6312cf874b8123b41717946c377a4458a3db4e286e73639a593770a14cce637223eb9aa99ae8d71276520524d2c4c88a286c78725d57dc5e088daea1e709555bca77005ae1184f0b86dbe31c6b20e60b73ac6e3c4b60b141c73b09d0c8c8e7e4e75354035601a0afd1c54b70096e3c6cc6c9d85b955951c5c4c06478d44b258cfa50d826fc042274f298716b1d6fadc1aaa0b4ab6824f7ae36046939712ab42415ece74256b126de1fa771f1781bbc430f08e7a6a259775cec622b4fb4dbd9d3d9ca933fd9f37315cbda345367cec0c30e14ab7a5d81c763340245bd764629ad97638f3442c13394f2f84c7db3aacbca99e25a09165863a535b96ee96395b5783038f608ffb2b536110c9eb9143ae3e4fa763e8c5bacb6391e8a85c21313b14822b21e4bc64b13f7adc91f9dca4cdf1f29cccc53733f74f1d0bbae4dd78f0ef5174e5cfdd1cb5ffc0981071a2ffa2b2f3ab0fc4f8e7f735ca86af2a25704743cde828e65da4abdb4bc58106c765399e5ccecea36a3ddf77a61ad65ea7e0b6c7b0fff386d5ee4bfb718e8b8a5db7653622fb723c094eb482443ab67580b2ef16bd9cb3f77b557ab9b450c5eb3b3a888d903e8baea9526b43c0904c2fb660a2c19ec913a52ad52e73fec32794c5b23a018f7729dab6e7715df312f44ec3a6c036e6b5a6d037b596bef2143c3f29e97dca0f1b9b47d8968fb527b2d6422969d9ade9e1ea6db35f73ba4856072e40f673edbeb594843d115bf3ccaedaa7294bcd482129d52342ecb5b0e30864cb6f5c8d623b66237c2053a02e21cf11366ef420f8a73c854c2a1d06e7234b6d393af234763aead8f2afbf489abff33b73e2908e67e5ef4aa57869daa628a461045185ae464673c4aa90b7748cc988ec35714a05fdac211e826233c696130944ec3e77bd523e98fba49118f7992224ef67c6adba9f1e064d2f7f4bd7fdecb2f30d9fba7bd707afc7eafda3bdf23a4450cd34efa4226979b5f3c9f5df6d3433fdbd346cd041e94b88b01144d9c5ddeedaaa613dadca26c02ea684e14b46b5224b90777cf3aa702fa24e63d025998350c7312a2321d2d92b9ba3eccc13599ca54f477482aed881782b94565d3d135638249ecdb44bf6ffbd2afcfd135a7c3a0ecb816c7dde89add5a13fea574cd7030ac84c2c1288bc513c9d244f0dda06b766cd3ee74cdcf2e7d5ff1e89a50b46d5f08965f603f33e9d135a1e8556182f876cb04514340f409297c152750ccdc96c0b7bd6985bade51c554b614836d195bcce97c43533afa806cc6995d75bf50b0d352a7e767f72fbfefebbffdff5282d0b2bce8ab7ef97ddb5525f99aa274a3f42283c2e2b98cb49029ac2efb0591f57edf03e002101496fec04c5522bd8994fa4d7d93b441970ea476396f3bd8a0ac3c480fc41e879d1d1b3606baea3afae0ec5ce0629636c49fd4897d1855898a75437c7b9210e323aeea79ec19a6f171e21e017c3ae29f02976c76e34b7e2c9ec6035a2ca65be373096a88810ec9c189f824032c3229828e9acb83e8709f8e0359d5cd39d27c3d845eb2937b04248a9dc49b70d73fcd174d396603388b9db3dd9dba8a0d37d46ecc9ed46a254c88e4e4206f26d21392919395decfb5d1caf1e36e0c4b2e9288ef5a8b8d5ea716fb4ef352094dc48aac189d602c584c9612ef0686776cd375eba788f0abcf7fff71811b3a2f1af143f8cf3c39f49898af9d17f5efe8e889ed0099d80dc8fc9842a6d44f9172a836a2891258f38183c81af8db6d6a90fe08fc2eaca643d9583cbaebcc20d1eb8ca57ba7c7bc9c082bc9182b4ec8132c180f29ef060e756cd3f5676842108dfcce5f7fda0322283aee07a2cf7ce21fff83074450342c80e8fd074510adf1c5e6ea3971b11969596c7eb98bb46dabee9ec06ef238ce7363e7f69d7ead49dcbacddae69ba78db6e7d89725736ae7946dae55d19bb3cd09cac3b46ddba300774ef7e8e66cb3efce1bac27480dd7c1dc26ea646b433b1e88b863d2361e84372a39c6446e646c665f1351e992c7cded38a33353bbf6d8f3f03b63143c74a9e10d65f4ddd3e76ebd7e80b757ca0a92a10d3c4d036637e9dc9c68429ed30df711c380fbe61777ceefe6583611a2768a6d0a94b4713a140a04632c42a90902c1307c02a4a609a9e983c296e1f0447c7b66b7c9de0f1eb4370cc30721ed63241bcb85dd00f0dda47dec9438f6967dccecb6fec1db7fce93ae0d8a8efaedb06957957323d5c28d4ff871a335dde37fbc8e8cb137f871831fef3a7e24383fe00127383e56091fab9df1d1f34f425ac841071ea16c628ff0e87677d57ec0e30b678e3fe9210214dde6078f7655393c565ae01147780cacc0d3744d58b6e969909c219d3d46bd517272f4857d1d1c5da9b7dda6d8dc9b9fe3439f3a71f5a7ab773c2388e7342fbac32bc9bba0fcb7fe2e7055a87a0f2f9adbd1579440491e5ba1377f7045d495a8f35eafce0ea3ef1c44591e09474c85fe31772bd358bbc96ddf5c47af805046feef839f14e4f49bbc68d02b52063df1c8f3ef392b547d98177db329d21151a0498a123c3f97cdac8cc3d4b6dabaedef6ff82b07f92e4dc03ebe45c512b376375f6f0edca51cd4b49f1757efce5e3c5c613afbfecea3ff55ca51c6e21d36fd99165c64bc6ce8757c971ebe0cd0f58f08c96784d707d2aadb0906181317f79ecd7af6a640eebb7197f2a6bde8e7f7e8be10109be344dd087e0f5a5ce3ab434ce11deff6c2d6de0908d385b30ff01b3c8d8873f7db520eb5ec042cd93b5c5ab6023ef70a3a9c4cdcce4fd1118ab8bf96afce479dc5375ef43ccdadf8084a381badb3324e39e40fe22f71a42903e5ef2ec3279c5729f5be40b887bfed5cd6d353b99c4f5062d75b023bed2ed9279f356ef4fbf627ad873d1bfda0e89adf9ec0b7e2b75d16aa0ef3a20302875e68217a85887ee5f2e52bce5819b87cc5fed20581923dce9b05a767e289d8ee4395db417ddf0034faf489ab3ffa50e12e41401fe1452f7a6589557f577ffe94a72a14fdca0e00aaa2248710c391f076074f77b3e3019466bfa9f882bc83f7bf5d207d5712cc3525786cb18ed17d3b3b717ef4fa77eff07866a0e8193f274ebbaaf492c6be64321d560fbb310087dbc70094fa42615b8e899d5ec2989e807f9393bd6f1c44e7d5931816100b24a3e8b787a27bd59e7fb4ddf678bd61ba5e44880c78aa3532a0e789f4e1527f9885ed0bb66a8c9f828bc19f64a93f949cc0cb3d01971b8c270291305eeffb78bdbb85280195fa89a928ce631603ad634187616f11c3def265187593413cc56e3aca9ee7fa6e3bca3df0a8af2cfde7cf094f3fc88beef676944e55a9a3f463129fb0dae7f694be0ed122bd7f77d016a5cf83733bc90f0f12ad53a5be700c9fd80ff189a94207398497198c44851ef2446b97ec8fc2dc037d0446a16f1f790afbc85378b1977af9c5e0df347dbb57ed7ddf45a17b3c4c59bd5031442564695945dd500ab97476bb0d0669059d3085c3375136ea9b76ec2d7dbb624abb65cbbe77951ffec59d7fe879fe50b4e8d755da55a5a822d2b6d501b7a70c748afec1314e026c37c4fd1fdfdd1785bed24f7d25dca409f4aa88a757de7d13861ac1400cb5e997188217b12f06ab51b8dae99be06aff8e5f2b75d4d22db9ba46af8655cffc7f07ee2952	2026-06-04 16:29:46.893216	5204430236027651919	9316
238	\\x70726f64756374696f6e3a6d6f62696c655f6170692f70726f647563742f33666633316366642f313036	\\x00118171805a799688da41ffffffff789cbd56cd6f1b4514774a657b9d0f3b49d3b4a160e37eb7381d7fc5cdccc581d465692b55ad11881cacb177d61ebad9757776ed3a411c7a4542d01b12072e9c38803881b844f03f70e3c28d7f800b077833eb8f4d9a86082164f963debc7df3deeff77be37732be8b708c1bdcc19a4db7999e8d3fa0fd288edeaae394c144cbe55d8f3bb69e9d16acffb8ff384a62759ce8babcc5cc681e2f1a5cb41cdff61aca84f0826096c5ed76b0aec671cae436b5c6cb33930798db62b647db8c47f0c2d8ec0dba106612b7472d5f1a1c97b72791c020680fce110dba2dfdcc28c209e139ad47fcc4bd291c178f7c99b351c8e78b2a67cdb7b9a7676377da6a39dd67bcddf1104e1a7c9bd9026a1408cf775dc7f05b41167a76e6b6ebb4983b504fcc34a9db720c3027ef3fd8cc2184f2684dedcc7684dd905b086b508fd0b311659745752d3a6838aec15c84cf71d1107e730c6a83d9b46931a3865760c769b5a84c4395a8b2a8e1545b7813af45b99ac086f06c8b7aacedb883dd1889f01489ead9c54dcadd41e67e10410474f16de53eadbec556044fbbd403f076637886f6980bd6aa86130a70202305d970bba1d0842a6035624366310f6bcbe907dbb054dfb0a29e0f95cfea76e6a1b4a893932d97418a46837aefe0cc46cbe33df6d0ef761dd7c3b80ec0bfcbbdcefb8ecdb6e2ba8f356999bdf5597aeff75ab31ac5da0eec203d3bbf2138bd71c7b11e518fcab8ba4f5e9f7d3bf0fb3e4a72c0a2df35460791eb321a788c23814775f9f987ce75a8686cfb96c7bb166b3cf62954ef712642cc8d64bb6c30938227c8d1e5e0d7809649e1d9e14a6cc5764f4b0670c2a24d66e9592d9f09844696aa71726aa2bbf9a63f08b5079986e04b63b18fa82673430d9124c2a7c6db81d4c1c24c932930c771d2102729f5316c070dada23c3eabb61bd4f4983b26113c4fd11ee5963c2ba091277152d21c14592797eaaa9e795284520ae352cc6821540b29c9fce549ebeba4bc2f67b28648a57a5966456e56b3641d7e637ee2ee142135088e975c6629ba864a175b89dd1c1c684b09c70d61a83871386af8533363a5324920c02b4766e03dcb23640ec9a35288cc5735b2c0a36451cfce6d6ee895e2466d5d757d38db25444e23b2bcbfabc999703b9795e92c222ba3525e46e45c8dbc5223afd6481a91cc918d465e4324bb1521e7c1eb02a4741172bc5427976be44a9d5c85dcee3afd4973906b13a55641969f143a1f86945a0b4c27a589ac1edff5469d2033512aad96cb24cfe74861a8cd39c5e50b640954e614b4e5baa43139b9640242c1794d120d1c54aa559236a32572d3d4f2ab959bc06d15b88d1232964df2806caa17f71d65c68a25d04d74ed50d1dc93d18b323a5acdcbe8f720ba16e84669a423d1d7769e3cd91989447bb2335c6890a812491c44123f4c2427d6a74632797373ad52ae1c2693514e478805adaf1f5b2cd5d211caa84965ecbb35c3c2b804d4fe75fee18510dbd703d3170785215d7f743ebf72c0154c5f06c2a8110498e4114822a290dc9648c642cd6688218ab9e75aed105184508d494c53d0b77dc3657db7cf46a84ebfe1789ec5863ac81d0bda3c2a1d016d1d2e95dbc7c4f6185df7d3b77fe21062b702d3778775dd51ae0adc5c18dc8a0477bece8497195e72cfdd69ff2cd65f5e92c0260b4561a897f8b76a2da3ff43ad5f7d9cde9bfbe3bda72194be0e4c898380b24fd37bc9cf97ef845c3f084c3fbf40ad6baaef25a06320873ad3cc789e15022ca79e0198f071189a25d5fab1c2a17f0dc741b17454cfd7e5c555fe4f703c0fa07d64ad3c0b81733530ad1cc4f102d8bff975752fe47a2d30bd35c111f00880c4332eeb71d69733e082c12c9820dc01cc7aa6b30ba3f96428b01c982ce548bc0598cf6d585646b70dae662fbc0c0cc02029ffbd4711f4ece962ae9c69fa82db4c888c4107c1e4b9243abcdb95f34eab435d983df56cbae6329619d933b4e9f458e6b7a73f949192e8df3fb75cd0	2026-06-05 04:58:53.531492	6971800042358902075	1635
242	\\x70726f64756374696f6e3a6d6f62696c655f6170692f63617465676f726965732f6637666565613433	\\x001181e8543246c688da41ffffffff789ce555cb721b45144d5294e34785323654b6b7bc6025eb6529b2a462118a38c885e35072ca0416ae56cf1d4dc34cf7a4bbc78ac8c61fc11236142b3ecb05ffc1e919c98f60d8b162a5d1e8deee73cf3de7e883d5efd6df6d0c1eaa487d3458d322e3d1cee32f84b273fa940e84cde8c0b24b56062bcf4e069b113b6955ee95d1a39dfb7f3ef57424ac48158d85f609d768c634b14a4f696e0aca0b8b57310ed98dc3211495e7e6d64485f48e9c29ace488226559fa744eb13519795b388fb7a991222dbbd9ba3a1d1776d16f859e322947d69850a8347a44a4022a7464ec1313b91ab1764589450b5f00257981836b94a86942baf0b6eca891d011fdc8d6903419b065ca31194d6f0a0ce6e7f595e1c393c1872a13533e2b6c8ab97f4bbccfdda0d1c8cae15d397b1ddd0d2b54ea1a427a75ce67ce1b8ba6c6243513d7b05c8dd9e0f9612cb3837cf2e5913ad64e7dfbfca0f97a3c7a7274f2ca8df4e72da9464f46d9a19bb40f6371fab58abf697eb6bbdbebb73ba215b5e36eabdbe9c5729f9bed6e578a7dee772742f67b1d8ef7e249a76195e47aaea725eced25d767d214daabd5c156a45c9e8af999b1115b75efddc6f09eda1cae8c76b6abadbf5c7484fee1eaff6acbc3b5e6705d6d0d3716b47c1c68f9e43996aa1ddc70a4d294af8979d07ef07766302bbddf801bf129038c8a3647de4c819f2d4961392e52b0b2a4c97991a7fc4f63c7c644248b14a3721dd60493981b6aa3b0773a1756b1571c6ea88667ed77f15342d9024caa7e40b198aa1a7d6f66c256ccc4e6ad877641e7395f2f2fd0ef3860079299f2090954cac2dd60ae6c1705a681be64a0f2d1faa3f5f19d4b0f6b761549d38aa4d0bc44062a50c65cd526a80533e48a0928d192abe2426bc6b31315caf008466fc82048127772e0a4640b0c2a9c9e19e7af34121b9bd5e934a996806f41744099b148319cbdc5394e533903378ae764e2182d826689c19a4cc625ac89480346b024e625f79851c10bf3306b2c3062c5cbb5cc76af64b61564f6f8c502da78c6ec59c30d4ba10d2f2f7e7ea517c3e28acb8b5fab645e921c5ebc30f4348af0655c4c85bdbcf885aaab60e0dfffa3b87afd2f7125facd76abd76f757bdd562491575274782fe6de7edcee44b2dddb6bb6b8dd948d738613c404542e430bdcac5d71b31db8593f1e7d35a62bdffd71ffce448ae13233c366e028a5c32ac2f6735b296429162c5178c27d3a72b7b63c532e82ec4a95e761e5c8077e8b8acab89e65a2d59b82172165c05ca9d8ca2a0b7f98c2430ef33bc47b43a1a58c2c673000c99405c2c989986b0b7d8b08f6662be0b95232cf4a4746d6e461b260461732174ebbbcf8e9da2f32e14c214b71d38d97467b882f44c43203cb30c0cd4b2b4cc1920631b04318bdccf16516016dd0019c5d996f9156b78c776b11741a387f692ba11e078e224ea12e7b2b226aef0773f96f105055f15338be11c89b410d7f01ebed0620	2026-06-05 18:34:40.829081	-8169931018800642934	1265
243	\\x70726f64756374696f6e3a6d6f62696c655f6170692f66656174757265642f33666633316366642f6c696d69745f35	\\x0011815dba5347c688da41ffffffff789cbd964b6f1b5514c7edaaf278ec38b69b367d108871692805bb77fc88937b1775503b6848a0556b844416d68de78e73d3c98c3b772626a4121b366c90e01320b1608b58b144ddb066c94760cb16243877c68f499a98a758f871cf9c398ffff99db1cfa7b7334715ac7093bb5875e83e33cae9877498c2a97b1d5c3099e8797ce073d731ca59c1864f864f5244e9e0ccc0e33d66a534bc6072d17303c7ef8626842f0866dbdce947e7b68a0b1677a83d395e99dec0bc1e737cda673c812f4cccfee100c24ce31e503b9006d7e3fd692430087a00794497ee4b3f2b857046f86eef313ff74e12a7c5e340d66cd634ad1ed6ac060ef78db2b2d90f8fd921e3fd5d1fe1bcc9f79923a047817071e0b966d08baa30ca736f796e8f7987e11d733bd4ebb92698f30f1edead208434b41a5ec9ed0aa72b2f21ac423fc2282742bb6c6a60d3c3aeeb99cc4378898bae087626a2769943776c66eaf81a5c717b3d2acb085b0cabd071a12ffca9d7823c4d654338d7a33eebbbdee1914212bc40524679e12ee5de61e941144144e3e2fba17b36fc14db099cf5a80fe21d29788e1e300faced0cce8482c3300a500d77baa19ad0059cc6d3905514e16cbbc3e8321cc34f38513f80ce7386537a242d61e67ccf6350a2d9a5fe7bb8b4d1f3f9017b140c06aee763dc01e1dfe7feee07aec3b6d346805569c9ddfb7cf9fb9ff59d760aab1fc11564948b1b82d3db9baefd98fa54c63502f246eeedc8efbb14a9c0148381394e445e97d1c06312093cda579ebf6969978aee7e60fb7c60b3ee938042f73e672236b931b6974d6651f0041c3d0e7e5d589902ce8d4e625b395a9413c0199bee30db28ab5a29028d5c6aabe4e294bbe24e70185b0f9285e09726b08f474de6470c913cc217279723d4c1c22c8b85624ee22c439cbce463b40e2aaa220d5f0d2f77a9e5336f3244f0bc480f28b765ae688c3c8ff372cc51931db2d209fb29923ab4529bb462a56ab15e4843d62f33adaf93e6b19ac92a22adf64d5915596b5f27ebf01df3735b49427419bc02c11d896bda1466784f1ac28ebeaa96d268920c026d2a640e5e399e20f348862d20526c67c8059e220b4679feee86d1aa6fe8ebe186c72bbb84c82222978f6f30b9125fdd6668ba8ac8b571d92f20b2a4931775f2924e9611298d97aa5d242f2352de4e90eb607a05f2df8082563ae4559ddcec90d7a0902d7738a59edc9a22d806de3eabed3e8d21a847a6f3d244aa7fddf57687202bd368549b4da2f179521b41371f0ee90cde60469550c76647ce273f7d7a449302e755394110bcd5be4396ad5483ac59aa566dadc1d0eec0d052844c78c89fe0a1bd722c95a5d41b00446af5541ab664f4ba8c8eaa9a8cbe05d1d51810fb120825c68329221ea0fc93349cd24a8c0e45d25100b486a6c786de908df9c8bee9fabecd46d557c8e2b8c899a83466a0d201c6f5ff8e9567dffc8a6300dc8b4cdf9ec6ca2cd7db3a41d09e8680924428ae2dc5cd8224a25e7b4e602badb15aa4f11e68bc77dac625a4a66931bae5efed5afddfee9a1eeaa74bfd8af703bfe45a674bf8fbb39fae9dd0054c5f9c26e12cd770dd1478b2697c6eb26b73b377cd52b45aa8e18c6d8357abfd14a8d992abd0acae3760159ec22a247f19ed824c940b13d5a789de3dbed49bb067e91a0c2dca94b1f887cc1c255981242ba405435d5f833c9b9027b3daaad66b9028f90964ba115bba3dc9c5628709f97fa0f4e021977f1b4ada1811d5143148d00892e4a74009bc9d8589f28f28d1fe2f4a6ec19c7ffb71e987d8e85164ba7f92923f739594c0bc3578908d1951673f24e5e8a476670f0ee2c193b2093f9cc92f61647bf297f3c6760c8eb4cc90a94de9b0945afd7892e457f2975903594f4b34c250ae7d1d0881346b56bac93409c8d790eee328d91f89fd3505	2026-06-05 18:34:45.429526	4479992926900853980	1582
257	\\x70726f64756374696f6e3a6d6f62696c655f6170692f63617465676f726965732f3633646537633331	\\x001181d099a646fd88da41ffffffff789ce555cb721b45144d5294e34785323654b6b7bc6025eb6529b2a462118a38c885e35072ca0416ae56cf1d4dc34cf7a4bbc78ac8c61fc11236142b3ecb05ffc1e919c98f60d8b162a5d1e8deee73cf3de7e883d5efd6df6d0c1eaa487d3458d322e3d1cee32f84b273fa940e84cde8c0b24b56062bcf4e069b113b6955ee95d1a39dfb7f3ef57424ac48158d85f609d768c634b14a4f696e0aca0b8b57310ed98dc3211495e7e6d64485f48e9c29ace488226559fa744eb13519795b388fb7a991222dbbd9ba3a1d1776d16f859e322947d69850a8347a44a4022a7464ec1313b91ab1764589450b5f00257981836b94a86942baf0b6eca891d011fdc8d6903419b065ca31194d6f0a0ce6e7f595e1c393c1872a13533e2b6c8ab97f4bbccfdda0d1c8cae15d397b1ddd0d2b54ea1a427a75ce67ce1b8ba6c6243513d7b05c8dd9e0f9612cb3837cf2e5913ad64e7dfbfca0f97a3c7a7274f2ca8df4e72da9464f46d9a19bb40f6371fab58abf697eb6bbdbebb73ba215b5e36eabdbe9c5729f9bed6e578a7dee772742f67b1d8ef7e249a76195e47aaea725eced25d767d214daabd5c156a45c9e8af999b1115b75efddc6f09eda1cae8c76b6abadbf5c7484fee1eaff6acbc3b5e6705d6d0d3716b47c1c68f9e43996aa1ddc70a4d294af8979d07ef07766302bbddf801bf129038c8a3647de4c819f2d4961392e52b0b2a4c97991a7fc4f63c7c644248b14a3721dd60493981b6aa3b0773a1756b1571c6ea88667ed77f15342d9024caa7e40b198aa1a7d6f66c256ccc4e6ad877641e7395f2f2fd0ef3860079299f2090954cac2dd60ae6c1705a681be64a0f2d1faa3f5f19d4b0f6b761549d38aa4d0bc44062a50c65cd526a80533e48a0928d192abe2426bc6b31315caf008466fc82048127772e0a4640b0c2a9c9e19e7af34121b9bd5e934a996806f41744099b148319cbdc5394e533903378ae764e2182d826689c19a4cc625ac89480346b024e625f79851c10bf3306b2c3062c5cbb5cc76af64b61564f6f8c502da78c6ec59c30d4ba10d2f2f7e7ea517c3e28acb8b5fab645e921c5ebc30f4348af0655c4c85bdbcf885aaab60e0dfffa3b87afd2f7125facd76abd76f757bdd562491575274782fe6de7edcee44b2dddb6bb6b8dd948d738613c404542e430bdcac5d71b31db8593f1e7d35a62bdffd71ffce448ae13233c366e028a5c32ac2f6735b296429162c5178c27d3a72b7b63c532e82ec4a95e761e5c8077e8b8acab89e65a2d59b82172165c05ca9d8ca2a0b7f98c2430ef33bc47b43a1a58c2c673000c99405c2c989986b0b7d8b08f6662be0b95232cf4a4746d6e461b260461732174ebbbcf8e9da2f32e14c214b71d38d97467b882f44c43203cb30c0cd4b2b4cc1920631b04318bdccf16516016dd0019c5d996f9156b78c776b11741a387f692ba11e078e224ea12e7b2b226aef0773f96f105055f15338be11c89b410d7f01ebed0620	2026-06-06 10:13:22.645019	1291100530817611350	1265
258	\\x70726f64756374696f6e3a6d6f62696c655f6170692f66656174757265642f33623136376337322f6c696d69745f35	\\x001181b43dfc47fd88da41ffffffff789cbd964b6f1b5514c7edaaf278ec38b69b367d108871692805bb77fc88937b1775503b6848a0556b844416d68de78e73d3c98c3b772626a4121b366c90e01320b1608b58b144ddb066c94760cb16243877c68f499a98a758f871cf9c398ffff99db1cfa7b7334715ac7093bb5875e83e33cae9877498c2a97b1d5c3099e8797ce073d731ca59c1864f864f5244e9e0ccc0e33d66a534bc6072d17303c7ef8626842f0866dbdce947e7b68a0b1677a83d395e99dec0bc1e737cda673c812f4cccfee100c24ce31e503b9006d7e3fd692430087a00794497ee4b3f2b857046f86eef313ff74e12a7c5e340d66cd634ad1ed6ac060ef78db2b2d90f8fd921e3fd5d1fe1bcc9f79923a047817071e0b966d08baa30ca736f796e8f7987e11d733bd4ebb92698f30f1edead208434b41a5ec9ed0aa72b2f21ac423fc2282742bb6c6a60d3c3aeeb99cc4378898bae087626a2769943776c66eaf81a5c717b3d2acb085b0cabd071a12ffca9d7823c4d654338d7a33eebbbdee1914212bc40524679e12ee5de61e941144144e3e2fba17b36fc14db099cf5a80fe21d29788e1e300faced0cce8482c3300a500d77baa19ad0059cc6d3905514e16cbbc3e8321cc34f38513f80ce7386537a242d61e67ccf6350a2d9a5fe7bb8b4d1f3f9017b140c06aee763dc01e1dfe7feee07aec3b6d346805569c9ddfb7cf9fb9ff59d760aab1fc11564948b1b82d3db9baefd98fa54c63502f246eeedc8efbb14a9c0148381394e445e97d1c06312093cda579ebf6969978aee7e60fb7c60b3ee938042f73e672236b931b6974d6651f0041c3d0e7e5d589902ce8d4e625b395a9413c0199bee30db28ab5a29028d5c6aabe4e294bbe24e70185b0f9285e09726b08f474de6470c913cc217279723d4c1c22c8b85624ee22c439cbce463b40e2aaa220d5f0d2f77a9e5336f3244f0bc480f28b765ae688c3c8ff372cc51931db2d209fb29923ab4529bb462a56ab15e4843d62f33adaf93e6b19ac92a22adf64d5915596b5f27ebf01df3735b49427419bc02c11d896bda1466784f1ac28ebeaa96d268920c026d2a640e5e399e20f348862d20526c67c8059e220b4679feee86d1aa6fe8ebe186c72bbb84c82222978f6f30b9125fdd6668ba8ac8b571d92f20b2a4931775f2924e9611298d97aa5d242f2352de4e90eb607a05f2df8082563ae4559ddcec90d7a0902d7738a59edc9a22d806de3eabed3e8d21a847a6f3d244aa7fddf57687202bd368549b4da2f179521b41371f0ee90cde60469550c76647ce273f7d7a449302e755394110bcd5be4396ad5483ac59aa566dadc1d0eec0d052844c78c89fe0a1bd722c95a5d41b00446af5541ab664f4ba8c8eaa9a8cbe05d1d51810fb120825c68329221ea0fc93349cd24a8c0e45d25100b486a6c786de908df9c8bee9fabecd46d557c8e2b8c899a83466a0d201c6f5ff8e9567dffc8a6300dc8b4cdf9ec6ca2cd7db3a41d09e8680924428ae2dc5cd8224a25e7b4e602badb15aa4f11e68bc77dac625a4a66931bae5efed5afddfee9a1eeaa74bfd8af703bfe45a674bf8fbb39fae9dd0054c5f9c26e12cd770dd1478b2697c6eb26b73b377cd52b45aa8e18c6d8357abfd14a8d992abd0acae3760159ec22a247f19ed824c940b13d5a789de3dbed49bb067e91a0c2dca94b1f887cc1c255981242ba405435d5f833c9b9027b3daaad66b9028f90964ba115bba3dc9c5628709f97fa0f4e021977f1b4ada1811d5143148d00892e4a74009bc9d8589f28f28d1fe2f4a6ec19c7ffb71e987d8e85164ba7f92923f739594c0bc3578908d1951673f24e5e8a476670f0ee2c193b2093f9cc92f61647bf297f3c6760c8eb4cc90a94de9b0945afd7892e457f2975903594f4b34c250ae7d1d0881346b56bac93409c8d790eee328d91f89fd3505	2026-06-06 10:13:28.061542	-711756990400549884	1582
259	\\x70726f64756374696f6e3a6d6f62696c655f6170692f70726f647563742f33623136376337322f313036	\\x001181fbeb1e50fd88da41ffffffff789cad574d6c1bc71596dc82222951946ccb4a54b79cd08e132792b2a47e1ccde440c5121dd63662440c5c542e88e1ee909c68b943cfcc8aa6051481919e1a146d928b0103c9c10682e490a2a716055a21391528904b905b00c3b7dc724a0f3d346f66f91725750423d00f356fdebc9fefbdf7cde8a7f13d078f718f0b9c08689395b2f157683b86639b653ce531e54aded25c04a5ecb862edebedeb313256c6c996e42eabc572f898c7952bc24057acc8c14715f37d1ed4a375218ea76a3ca07e7ff9d8e000932e0b34ad333e828ff6c5bad3023303bbbbd40f8d40485e1f580281a2bbe0475568d3e8d5620e4e2a2ddc1d7ee4f2288eab9dd0c4ece573b9251b73220cb82e65c72ed6ed72bccd78bda11d9cf67893050a72540e9e6e49e1856e1445293b71410a97c98e3d3151a5d2151e88d3575ed958701c27e7acda9d54430515b3e5e004e4a34ad9112b3749b57cdaa908e931e9e0935c555458ed835a6101adfacc2be239d811ae4b4d1836451b45114fd5951e681d33ab016c0e4eb954b3ba909dbd3132c2a748ac943db641b9eca02b910515958b37adfab8fd54db23785c520de0ed8de109bacb24480b099cb4804331a6201a1e542c9a9005ac7ad530514cc3da17ed681b96f6135654879079aa14a02d23b19ed3ae6410a257a1fa558cd65dcd77d956d86a09a9312e03f057b96efc5a046c3b5e0a71c248529b7fcaec7f59ac1662387113769c52767a5d71fadc45e1ef504d8ddd5248e653bf8cf4fe1a230b50c5b0e5f51c91678d35d0e85b028dc2ec770f9d6c50556986bee62d9f55ae8714b2d79ca9a1caf5da76d663350a9ad08e92835e0546660aa7ba2bb53db677c25400277d5a657e299bc8a1a8d1c84c214e8e0ffa6eba1a7686c6838c83f1997eb3f74a4d26bb3d44d20e3ededf8e5a1d24ac566316ccbe9d0cd8499bfee88e43c2597472f871bb5da135cd64bf88a0799cee52ee1b5f5119791aa74d99a324cbe44cd9e6334d9620957c3f955a2c3f940b5936f11b4f6b6b64e55b319355879c2b3c65a222cf17b2640dfec6fcc8a551428a601ccf48e6db72753b5d6d27f716c0e1aa69e14499296d0dc5c1579bd93f13b5788ee549d201c416c804fca4f80899748cb329874c1712e4283fb23c4a8ec199bc1df9e150671c72a217deecb7079b3c3698686779cd8a1e77c85c4ffd670e3959243f2f925f9449a6165b21e8a1d3469e7048767b849c02add310d59310e6993279aa489e2e92b30706843c33e8d653bfcfecffd69f7b6ba85bcf46a23923228b03d5d320ffe88bc5fd21d56722d14b56f5b9227100a19c43f2db2316d87326da69032cea42de07587911c0502a8b6e1cd08d7f2fba9fffc4a09bce2f29cf7ea9474579c57908ca459271061817561f19d07b00c9e4d7bfba3584d2879128791050f6c7cc7efaf6ecc521d5d722d1270340e3c380be60009ddbd8dc2aa1f32f5f45175edadc44db4b8e73f9d26f7ac81ef96cf44a2819da608aa30b0dc6d083d7df4697a9c7906e305496d4e3da123eba4a3be8c19df7bf7af7de1ba9642a795e9a89f5504d8aa6d56d727f07891a7cde00f17a1e79c6a62bda6a1e8950a2bab15e95e63e441d11da3330f98d802965ced11024c06e2e2a051e3016aa0be199cd45b4055cbee036421980e5508109a487226b32dd109e425a40e330c5e42e4314c2a2f34853a5d93ca2818782504b7b62d1847f41f81e0b100f20425fc8791b8a59d67cba6bd6e6488bba3be0b10d17000ae0ee90e0acca0256e35a0150ef400e5c21f80e8446af85d0b826c979c4f583d76f2bd40ac161c71865708175906a0911a0afde7df39f26822b4c1a8244352191074cd78148c40ee4368feedffde0febd5bf7efdeb97ff71f5124d4f36cd60daac1195c647e1d80b2086b1142e4907bc7a0dc64d4578b5d3a4a2e2d3edf23a46b3032d7a291812e1fdcd03d36ec8fd09819a0c98df5d28bb9cdb5dc666f7ec65f145afbac7f5f1c6e88561e4e5585e5434e51d94cd1e425d1fefe31127fc8ecffe72c2b0fcd868e44ff3e3846ff7a27b3ffc6e8fa0743aa9f46a2fc608cae0d8f51c312fecd1b376ef6a62671e366777108465a1bed017a7e63f5dccab94725a4b587d1fe8f464867e0f1f1bf535ba787e0793612dd3988a451fdbbb8fdf4015510bdf77f08a96990ec91b9e1754f753b756c7925c271f4770024fc3a6ca34e01c9b73dc9dab27b097fa755c1d861f0cd39cb3f74adfe48cd5a00903efef37ff1106e9b91e82f0721fe21550b312418618c2724dbe5ac6d5ecf473de673c33af04aae893df8a766f09cf205bcc9cd3f13db508ec975df8f18d7befd66e1fa8527b879f7f42c94b22796165650d510afe16a8f76a237fb8c6af056cbbc14dd0695f06a2f653345092cdf93235a15c0c50f6efd6dc5b1d7e9372bdbf146	2026-06-06 10:14:00.603137	-64942441987958008	1931
263	\\x70726f64756374696f6e3a6d6f62696c655f6170692f63617465676f726965732f3732363838346463	\\x0011812bd93932ff88da41ffffffff789ce555cb721b45144d5294e34785323654b6b7bc6025eb6529b2a462118a38c885e35072ca0416ae56cf1d4dc34cf7a4bbc78ac8c61fc11236142b3ecb05ffc1e919c98f60d8b162a5d1e8deee73cf3de7e883d5efd6df6d0c1eaa487d3458d322e3d1cee32f84b273fa940e84cde8c0b24b56062bcf4e069b113b6955ee95d1a39dfb7f3ef57424ac48158d85f609d768c634b14a4f696e0aca0b8b57310ed98dc3211495e7e6d64485f48e9c29ace488226559fa744eb13519795b388fb7a991222dbbd9ba3a1d1776d16f859e322947d69850a8347a44a4022a7464ec1313b91ab1764589450b5f00257981836b94a86942baf0b6eca891d011fdc8d6903419b065ca31194d6f0a0ce6e7f595e1c393c1872a13533e2b6c8ab97f4bbccfdda0d1c8cae15d397b1ddd0d2b54ea1a427a75ce67ce1b8ba6c6243513d7b05c8dd9e0f9612cb3837cf2e5913ad64e7dfbfca0f97a3c7a7274f2ca8df4e72da9464f46d9a19bb40f6371fab58abf697eb6bbdbebb73ba215b5e36eabdbe9c5729f9bed6e578a7dee772742f67b1d8ef7e249a76195e47aaea725eced25d767d214daabd5c156a45c9e8af999b1115b75efddc6f09eda1cae8c76b6abadbf5c7484fee1eaff6acbc3b5e6705d6d0d3716b47c1c68f9e43996aa1ddc70a4d294af8979d07ef07766302bbddf801bf129038c8a3647de4c819f2d4961392e52b0b2a4c97991a7fc4f63c7c644248b14a3721dd60493981b6aa3b0773a1756b1571c6ea88667ed77f15342d9024caa7e40b198aa1a7d6f66c256ccc4e6ad877641e7395f2f2fd0ef3860079299f2090954cac2dd60ae6c1705a681be64a0f2d1faa3f5f19d4b0f6b761549d38aa4d0bc44062a50c65cd526a80533e48a0928d192abe2426bc6b31315caf008466fc82048127772e0a4640b0c2a9c9e19e7af34121b9bd5e934a996806f41744099b148319cbdc5394e533903378ae764e2182d826689c19a4cc625ac89480346b024e625f79851c10bf3306b2c3062c5cbb5cc76af64b61564f6f8c502da78c6ec59c30d4ba10d2f2f7e7ea517c3e28acb8b5fab645e921c5ebc30f4348af0655c4c85bdbcf885aaab60e0dfffa3b87afd2f7125facd76abd76f757bdd562491575274782fe6de7edcee44b2dddb6bb6b8dd948d738613c404542e430bdcac5d71b31db8593f1e7d35a62bdffd71ffce448ae13233c366e028a5c32ac2f6735b296429162c5178c27d3a72b7b63c532e82ec4a95e761e5c8077e8b8acab89e65a2d59b82172165c05ca9d8ca2a0b7f98c2430ef33bc47b43a1a58c2c673000c99405c2c989986b0b7d8b08f6662be0b95232cf4a4746d6e461b260461732174ebbbcf8e9da2f32e14c214b71d38d97467b882f44c43203cb30c0cd4b2b4cc1920631b04318bdccf16516016dd0019c5d996f9156b78c776b11741a387f692ba11e078e224ea12e7b2b226aef0773f96f105055f15338be11c89b410d7f01ebed0620	2026-06-06 10:46:08.94805	-2414958354997585305	1265
264	\\x70726f64756374696f6e3a6d6f62696c655f6170692f66656174757265642f62633938653862612f6c696d69745f35	\\x0011812f533b33ff88da41ffffffff789cbd964b6f1b5514c7edaaf278ec38b69b367d108871692805bb77fc88937b1775503b684844abd608892cac1bcf1de7a6931977ee4c4c4825366cd820c1274062c116b16289ba61cd928fc0b65b90e0dc193f2669629e62e1c73d73e63cfee777c63e9fdece1c55b0c24dee62d5a1fbcc28a71fd2610aa7ee7570c164a2e7f181cf5dc72867051b3e193e4911a58333038ff79895d2f082c945cf0d1cbf1b9a10be20986d73a71f9ddb2a2e58dca1f6e478657a03f37accf1699ff104be3031fb870308338d7b40ed401a5c8ff7a791c020e801e4115dba2ffdac14c219e1bbbdc7fcdc6612a7c5e340d66cd634ad1ed6ac060ef78db2b2d90f8fd921e3fd5d1fe1bcc9f79923a047817071e0b966d08baa30ca73ef786e8f7987e11d733bd4ebb92698f30f1edead208434b41a5ec9ed0aa72b2f21ac423fc2282742bb6c6a60d3c3aeeb99cc4378898bae087626a2769943776c66eaf81a5c717b3d2acb085b0cabd071a12ffca9d7823c4d654338d7a33eebbbdee1914212bc40524679e12ee5de61e941144144e3e2fba17b36fc14db099cf5a80fe21d29788e1e300faced0cce8482c3300a500d77baa19ad0059cc6d3905514e16cbbc3e8321cc34f38513f80ce7386537a242d61e67ccf6350a2d9a5fefbb8b4d1f3f9017b140c06aee763dc01e13fe0feee87aec3b6d346805569c9ddfb62f9875ff49d760aab1fc31564948b1b82d3db9baefd98fa54c63502f256eeddc8effb14a9c0148381394e44de94d1c06312093cda575ebc6969978aee7e60fb7c60b3ee938042f73e672236b931b6974d6651f0041c3d0e7e5d589902ce8d4e625b395a9413c0199bee30db28ab5a29028d5c6aabe4e294bbe24e70185b0f9285e09726b08f474de6470c913cc217279723d4c1c22c8b85624ee22c439cbce463b40e2aaa220d5f0d2f77a9e5336f3244f0bc480f28b765ae688c3c8ff372cc51931db2d209fb29923ab4529bb462a56ab15e4843d62f33adaf93e6b19ac92a22adf64d5915596b5f27ebf01df3735b49427419bc02c11d896bda1466784f1ac28ebeaa96d268920c026d2a640e5e399e20f348862d20526c67c8059e220b4679feee86d1aa6fe8ebe186c72bbb84c82222978f6f30b9125fdd6668ba8ac8b571d92f21b2a4939775f28a4e9611298d97aa5d24af2252de4e90eb607a0df2df8082563ae4759ddcec9037a0902d7738a59edc9a22d806de3eafed3e8d21a847a6f3d244aa7fddf57687202bd368549b4da2f179521b41371f0ee90cde60469550c76647ce273f7d7a449302e755394110bcd5be4396ad5483ac59aa566dadc1d0eec0d052844c78c89fe0a1bd722c95a5d41b00446af5541ab664f4ba8c8eaa9a8cbe05d1d51810fb120825c68329221ea0fc93349cd24a8c0e45d25100b486a6c786de908df9c8beedfabecd46d557c8e2b8c899a83466a0d201c6f5ff8e9567dffe8a6300dc8b4cdf9dc6ca2cd7db3a41d09e8680924428ae2dc5cd8224a25e7b41602badb15aa4f11e68bc77dac625a4a66931bae5efed5afddfee9a1eeaa74bfd8af703bfe45a674bf8fbb39faf9dd0054c5f9e26e12cd770dd1478b2697c6eb26b73b377cd52b45aa8e18c6d8357abfd14a8d992abd0acae3760159ec22a249f8f764126ca8589ead344ef1d5fea4dd8b3740d861665ca58fc23668e92ac409215d282a1aeaf419e4dc893596d55eb354894fc1432dd882ddd9ee462b1c384fc3f507af090cbbf0d256d8c886a8a1824680449f233a004decec244f9479468ff1725b760cebffdb4f4636cf42832dd3f49c99fb94a4a60de1a3cc8c68ca8b31f92727452bbb30707f1e049d9841fcee45730b23df9cb79633b06475a66c8d4a674584aad7e3c49f26bf9cbac81aca7251a6128d7be0e84409a352bdd649a04e41b48f74994ec0f736d3503	2026-06-06 10:46:13.043821	2326321240407554727	1582
265	\\x70726f64756374696f6e3a6d6f62696c655f6170692f70726f647563742f62633938653862612f313036	\\x001181bd219d3aff88da41ffffffff789cad574b6c5bc71595dc82222951946ccb4a54279cd2ae1d2792f2487d1ccd7441c5121dd60e6a442c5c542e88e17b4372a2c737f4cc3cd1b480203092558a20bf8d0103cec2068a74d120ab16055aa15d1528904d905d00c3bbeebc6a175db477e6f11725750423d0879a3b77eee7dc7bcf8c7e18df73f018f7b8c089803659291b7f8db66338b659c6531e53aee42dcd4550ca8e2bd6bedebe1e2363659c6c49eeb25a2c878f795cb9220c74c58a1c7c5431dfe7413d5a17e278aac603eaf7974f0d0e30e9b240d33ae323f8685fac3b2d3033b0bb4bfdd00884e4f581251028ba0b7e5485368d5e2de6e0a4d2c2dde1472e8de2b8da094dcc5e3e975bb23127c280eb5276ec52dd2ec7db8cd71bdac1698f3759a02047e5e0e996145ee8465194b21317a57099ecd81313552a5de181387de5b58d05c77172ceaadd49355450315b0e4e403eaa941db1729354cba79d8a901e930e3ec9554585d53ea81516d0aacfbc229e831de1bad4846153b45114f1545de981d631b31ac0e6e0944b35ab0bd9d91b23237c8ac44ad9631b94cb0eba12595051b978d3aa8fdb4fb53d82c725d500dede189ea0bb4c82b490c0490b3814630aa2e141c5a20959c0aa570d13c534ac7dd18eb661693f6145750899a74a01da3212eb39ed4a06217a15aa7f81d1baabf92edb0a5b2d2135c66500fe2ad78d5f89806dc74b214e18496af3fdccfe3f8bd5420c276ec28e53ca4eaf2b4e5fbc24fc1daaa9b15b0ac97cea6791de1f626401aa18b6bc9e23f282b1061a7d4ba05198fde6a1930daa2acdd0d7bce5b3caf59042f69a333554b95edbce7aac464113da5172d0abc0c84ce15477a5b6c7f64e980ae0a44fabcc2f65133914351a9929c4c9f141df4d57c3ced0789071303ed36ff65ea9c964b78748dac1c7fbdb51ab8384d56acc82d9b793013b69d31fdd7148388b4e0e3f6db72bb4a699ec1711348fd35dca7de32b2a234fe3b429739464999c29db7ca6c912a492efa7528be5877221cb267ee3696d8dac7c2d66b2ea90f385b3262af252214bd6e06fcc8f5c1e25a408c6f18c64be2d57b7d3d576726f011cae9a164e9499d2d6501c7cb599fd33518be7589e241d406c814cc04f8a8f9049c7389b72c87421418ef223cba3e4189cc9db911f0e75c621277ae1cd7e7db0c95383897696d7ace86987ccf5d47fe4909345f24c913c5b26995a6c85a0c74e1bf9b143b2db23e414689d86a87e02619e2993b345f25c919c3b3020e4f941b79e7a27b3ff863ff7c150b79e8b447346441607aaa741fefbaf16f787549f8f44af58d5178bc40184720ec96f8f5860cf9b68a70db0a80b791f60e5450043a92cba714037feade87ef903836e3abfa43cfba59e14e515e731281749c619605c587d6240ef032493fffae5ad21947e178992070165ef65f6d3b7672f0da9be1e89fe3600343e0ce84f0da0731b9b5b2574e1e757d1c5573637d1f692e3bc7af9d73d648f7c317a25940c6d30c5d1c50663e8e19b1fa257a9c7906e305496d4e3da123eba4a3be8e19ddf3eba7bffad543295bc20cdc47aa82645d3ea36b9bf83440d3e6f80783d8f3c63d3156d358f442851dd58af4a731fa28e08ed1998fc46c09432e768081260371795020f180bd585f0cce622da022e5f701ba10cc072a8c004d2439135996e084f212da07198627297210a61d179a4a9d26c1ed1c04341a8a53db168c2bf287c8f05880710a12fe4bc0dc52c6b3edd356b73a445dd1df0d8860b000570774870566501ab71ad00a88f2007ae107c0742a3d743685c93e43ce2fae19bb7156a85e0b0638c32b8c03a48b58408d0a3bbbff98b89e00a938620514d48e401d3752012b103b9cda307f73e7970ffd6837b771edcfb731409f53c9b75836a700617995f07a02cc25a841039e4de31283719f5d562978e924b8b2ff508e91a8cccb56864a0cb0737748f0dfb23346606687263bdf4726e732db7d99b9ff19785d63eebdf17871ba295c7535561f99053543653347959b4bf7d8cc4bb99fd7f9f63e5a1d9d091e81f07c7e8ef1f65f6df1a5dff6448f5f348941f8cd1b5e1316a58c2bf79e3c6cdded4246edcec2e0ec1486ba33d402f6cac9e5f39ffa484b4f638daffde08e90c3c3efe7b6aebf4103c2f44a23b079134aa7f12b79f3ba00aa28fff0f21350d923d3237bceea96ea78e2daf44388ebe0d40c2afc336ea14907cdb93ac2dbb97f0375a158c1d06df9cb3fc5dd7eaf7d4ac0500e9af9ffe070fe1b619893e3b08f177a95a8821c108633c21d92e676df37a3eea319f1bd68157724decc13f3583e7942fe04d6efe99d886724caefb7ec4b8f6ed370bd72f3cc1cdbba767a1943db1b4b082aa86780d577bb413bdd9675483b75ae6a5e836a884577b299b294a60f99e1cd1aa002e7e78eb8f2b8ebd4eff0711eff144	2026-06-06 10:46:42.572179	1720998908784750751	1931
271	\\x70726f64756374696f6e3a6d6f62696c655f6170692f70726f647563742f36626332333161392f313036	\\x0011818d97f4ad0189da41ffffffff789cad574d6c1bc71596dc82222951946ccb4a54b79cd28e132792b2d49fa3991ea858a2c3ca418c88858bca0531dc1d92132d77e89959d1b4802230da538b206d733160c03dd840d11c12e494a0402b24c7f69043905b00c1b71e0ae4d41e7a68dfccf22f4aa22846a11f6adebc793fdf7bef9bd177e37b0e1ee11e173811d0062b66e3afd2560cc7364a78c263ca95bca9b9088ad951c55a375b376364a484934dc95d568de5f0298f2b5784812e5b91834f2ae6fb3ca845eb7c1c4f547940fddef289fe01265d16685a637c089fec8975bb0966fa7677a91f1a8190bcd6b704024577c18f2ad386d1abc61c9c545ab83bfcc4e6308eab9dd0c4ec2de4728b36e64418705dcc8e6cd6ec72b4c578adae1d9cf67883050a72540e9e6c4ae1856e1445313b76450a97c9b63d3156a1d2151e88d3d75e5d9f731c27e7acd89d545d0565b3e5e004e4a38ad9212b3749357dda2e0be931e9e0b35c955558e9815a6601adf8cc2be019d811ae4b4d1836451b45014fd494ee6b9d32ab3e6c0e4eb954b39a90edbd1132c42748ac983db54eb96ca36b910515958b37acfaa8fd54db437854520de0ed8de031bacb2448f3099cb480433126201a1e942d9a9005acbad530514cc2da17ad681b96f6135654879079aa18a02d23b19ed3ae6410a257a6fa2718adb99aefb2adb0d91452635c02e0af735dff9908d876bc18e28491a4367e9bd9ff47a1928fe1c46dd8718ad9c935c5e9f39bc2dfa19a1abbc590cca67e1ce9bd1f237350c5b0e9751d91e78c35d0e859028dfcf4970f9dad53556e84bee64d9f956f8614b2d79ca981ca75db76da63550a9ad08e92835e19466602a73a2bb53db277c65400277d5a617e319bc8a1a8d1c8543e4e4ef7fb6eb212b607c6838c82f1a95eb3774b4dc63b3d44d20e3edddb8e5a1d24ac5a6516cc9e9d0cd8499bfee88c43c2997772f849bb5da655cd64af88a0799aee52ee1b5f5119791aa74d99a3244be442c9e63349162195855e2ad5d8c2402e64c9c46f3cadae92e52fc44c561c7229ffb4898abc90cf9255f81bf3135787092980713c25996fcbd5e974b59ddc9b03872ba6851325a6b43514075f2d66ff4c54e339b640920e203647c6e027c587c8b8639c4d3864329f2027f989a561720ace2cd8911f0c75ca2167bae14d7f71b0c913fd89769656ade84987cc74d5bfe790b305f2fd02f9418964aab165828e9c36f2438764b787c839d03a0f513d05615e2891a70be49902b9786840c8b3fd6e3df7ebccfe2ffc99df0d74ebc54834634464beaf7a1ee4ef7c36bf3fa0fa6c247ac9aa3e5f200e209473c8c2f69005f6928976d2008b3a90f700565e043094caa21b0774e35f89eea7df31e8a617169567bfd4e3a2bcec1c817281649c3ec6f995c706f4214032feaf9fde1940e9ed48943c0c287b33b39fbe3bbd39a0fa5a24faa80f687c10d01f194067d637b68ae8f22bd7d195973636d0f6a2e3bc7cf5e75d644f7c327c2d940cad33c5d1953a63e8d1ebbf472f538f215d67a824a9c7b5257c749db6d1a37b7ffcfcfec35fa692a9e4656926d64355291a56b7c1fd1d24aaf0790bc46b0bc833365dd152b3488412d58cf58a34f7216a8bd09e81c9af074c29738e86200176735131f080b1504d08cf6ccea32de0f239b71eca002c870a4c203d105983e9baf014d2021a8729267719a210169d459a2acd66110d3c14845ada13f326fc2bc2f75880780011fa42ceda50ccb2ead35db336479ad4dd018f2db8005000778704671516b02ad70a807a0b72e00ac17720347a2d84c63549ce22ae1fbd7e57a166080edbc628830bac8d545388007d7eff377f35115c63d21024aa0a893c60ba3644227620b75974f0e04f070fef1c3cb877f0e02f5124d4f36cd675aac1195c647e0d80b2086b1142e4907bdba0dc60d457f31d3a4a2ecebfd025a41b303237a291812eefdfd05d36ec8d50da0cd0f8fa5af1c5dcc66a6ea33b3fa32f0aad7dd6bb2f8e3744cb4753557ee99853543a728ac41b99fd7f5f64a581d1d091e8ef87a7e86f6f65f637ff49eb03aa1f47a283fe14dd189ca2bae5fbdbb76eddee0e4de2d6edcee21884b43adcc5f3f2facaa5e54b8fcb47ab47b1feff8d8f2ec0dbe3bfe7b6ce0fc0f35c24ba771849a3fa6771f79943aa20fac3d7f051c320d9e57243eb9eea34eac8d27284e3f0af0048f8758c3e1d31b84e00c7b73cc95ab273077fa953c1d871f0cd394bdf74ab7eab5e1dbf2a5a5f0d711e40faf0ddffe001dc3622d17b8721fe26550b312418618cc724dbe5ac651ecf273de673433af048ae8a3df89fa6ff9af2053cc9cdff12db508ef135df8f08d73efda6e1f68517b879f6742d14b36716e79651c5f0aea16a8fb6a327fb94aaf366d33c14dd3a95f0682f6633050924df95235a1140c58fee7cb0ecd8dbf47f88f5f2e5	2026-06-06 11:28:31.94028	2292215482984350925	1934
274	\\x70726f64756374696f6e3a6d6f62696c655f6170692f66656174757265642f36626332333161392f6c696d69745f35	\\x00118176a557f93c89da41ffffffff789cbd964b6f1b5514c7edaaf278ec38b69b367d108871692805bb77fc88937b1775503b684844abd608892cac1bcf1de7a6931977ee4c4c4825366cd820c1274062c116b16289ba61cd928fc0b65b90e0dc193f2669629e62e1c73d73e63cfee777c63e9fdece1c55b0c24dee62d5a1fbcc28a71fd2610aa7ee7570c164a2e7f181cf5dc72867051b3e193e4911a58333038ff79895d2f082c945cf0d1cbf1b9a10be20986d73a71f9ddb2a2e58dca1f6e478657a03f37accf1699ff104be3031fb870308338d7b40ed401a5c8ff7a791c020e801e4115dba2ffdac14c219e1bbbdc7fcdc6612a7c5e340d66cd634ad1ed6ac060ef78db2b2d90f8fd921e3fd5d1fe1bcc9f79923a047817071e0b966d08baa30ca73ef786e8f7987e11d733bd4ebb92698f30f1edead208434b41a5ec9ed0aa72b2f21ac423fc2282742bb6c6a60d3c3aeeb99cc4378898bae087626a2769943776c66eaf81a5c717b3d2acb085b0cabd071a12ffca9d7823c4d654338d7a33eebbbdee1914212bc40524679e12ee5de61e941144144e3e2fba17b36fc14db099cf5a80fe21d29788e1e300faced0cce8482c3300a500d77baa19ad0059cc6d3905514e16cbbc3e8321cc34f38513f80ce7386537a242d61e67ccf6350a2d9a5fefbb8b4d1f3f9017b140c06aee763dc01e13fe0feee87aec3b6d346805569c9ddfb62f9875ff49d760aab1fc31564948b1b82d3db9baefd98fa54c63502f256eeddc8effb14a9c0148381394e44de94d1c06312093cda575ebc6969978aee7e60fb7c60b3ee938042f73e672236b931b6974d6651f0041c3d0e7e5d589902ce8d4e625b395a9413c0199bee30db28ab5a29028d5c6aabe4e294bbe24e70185b0f9285e09726b08f474de6470c913cc217279723d4c1c22c8b85624ee22c439cbce463b40e2aaa220d5f0d2f77a9e5336f3244f0bc480f28b765ae688c3c8ff372cc51931db2d209fb29923ab4529bb462a56ab15e4843d62f33adaf93e6b19ac92a22adf64d5915596b5f27ebf01df3735b49427419bc02c11d896bda1466784f1ac28ebeaa96d268920c026d2a640e5e399e20f348862d20526c67c8059e220b4679feee86d1aa6fe8ebe186c72bbb84c82222978f6f30b9125fdd6668ba8ac8b571d92f21b2a4939775f28a4e9611298d97aa5d24af2252de4e90eb607a0df2df8082563ae4759ddcec9037a0902d7738a59edc9a22d806de3eafed3e8d21a847a6f3d244aa7fddf57687202bd368549b4da2f179521b41371f0ee90cde60469550c76647ce273f7d7a449302e755394110bcd5be4396ad5483ac59aa566dadc1d0eec0d052844c78c89fe0a1bd722c95a5d41b00446af5541ab664f4ba8c8eaa9a8cbe05d1d51810fb120825c68329221ea0fc93349cd24a8c0e45d25100b486a6c786de908df9c8beedfabecd46d557c8e2b8c899a83466a0d201c6f5ff8e9567dffe8a6300dc8b4cdf9dc6ca2cd7db3a41d09e8680924428ae2dc5cd8224a25e7b41602badb15aa4f11e68bc77dac625a4a66931bae5efed5afddfee9a1eeaa74bfd8af703bfe45a674bf8fbb39faf9dd0054c5f9e26e12cd770dd1478b2697c6eb26b73b377cd52b45aa8e18c6d8357abfd14a8d992abd0acae3760159ec22a249f8f764126ca8589ead344ef1d5fea4dd8b3740d861665ca58fc23668e92ac409215d282a1aeaf419e4dc893596d55eb354894fc1432dd882ddd9ee462b1c384fc3f507af090cbbf0d256d8c886a8a1824680449f233a004decec244f9479468ff1725b760cebffdb4f4636cf42832dd3f49c99fb94a4a60de1a3cc8c68ca8b31f92727452bbb30707f1e049d9841fcee45730b23df9cb79633b06475a66c8d4a674584aad7e3c49f26bf9cbac81aca7251a6128d7be0e84409a352bdd649a04e41b48f74994ec0f736d3503	2026-06-07 04:20:29.485949	-7109434687832558286	1582
\.


--
-- Data for Name: solid_queue_blocked_executions; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.solid_queue_blocked_executions (id, job_id, queue_name, priority, concurrency_key, expires_at, created_at) FROM stdin;
\.


--
-- Data for Name: solid_queue_claimed_executions; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.solid_queue_claimed_executions (id, job_id, process_id, created_at) FROM stdin;
\.


--
-- Data for Name: solid_queue_failed_executions; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.solid_queue_failed_executions (id, job_id, error, created_at) FROM stdin;
\.


--
-- Data for Name: solid_queue_jobs; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.solid_queue_jobs (id, queue_name, class_name, arguments, priority, active_job_id, scheduled_at, finished_at, concurrency_key, created_at, updated_at) FROM stdin;
1	default	ActiveStorage::PurgeJob	{"job_class":"ActiveStorage::PurgeJob","job_id":"6e23288f-1632-4c68-842a-338ef76d4f1b","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://demo-farm-admin/ActiveStorage::Blob/1"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-02-12T12:07:57.722857051Z","scheduled_at":"2026-02-12T12:07:57.722472853Z"}	0	6e23288f-1632-4c68-842a-338ef76d4f1b	2026-02-12 12:07:57.722472	\N	\N	2026-02-12 12:07:58.597033	2026-02-12 12:07:58.597033
2	default	ActiveStorage::AnalyzeJob	{"job_class":"ActiveStorage::AnalyzeJob","job_id":"60be65de-262d-4dbd-a55d-cbd554f0d94c","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://demo-farm-admin/ActiveStorage::Blob/2"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-02-12T13:21:25.315101323Z","scheduled_at":"2026-02-12T13:21:25.314201655Z"}	0	60be65de-262d-4dbd-a55d-cbd554f0d94c	2026-02-12 13:21:25.314201	\N	\N	2026-02-12 13:21:25.87722	2026-02-12 13:21:25.87722
3	default	ActiveStorage::AnalyzeJob	{"job_class":"ActiveStorage::AnalyzeJob","job_id":"89855de3-34bd-46a3-b6da-e80825359da8","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://demo-farm-admin/ActiveStorage::Blob/3"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-02-12T16:39:33.848379658Z","scheduled_at":"2026-02-12T16:39:33.847795998Z"}	0	89855de3-34bd-46a3-b6da-e80825359da8	2026-02-12 16:39:33.847795	\N	\N	2026-02-12 16:39:36.448794	2026-02-12 16:39:36.448794
4	default	ActiveStorage::PurgeJob	{"job_class":"ActiveStorage::PurgeJob","job_id":"ed7d0e25-8623-461d-8d08-7d0f4fecb369","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://demo-farm-admin/ActiveStorage::Blob/3"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-02-12T16:43:19.465350484Z","scheduled_at":"2026-02-12T16:43:19.465113217Z"}	0	ed7d0e25-8623-461d-8d08-7d0f4fecb369	2026-02-12 16:43:19.465113	\N	\N	2026-02-12 16:43:19.465773	2026-02-12 16:43:19.465773
5	default	ActiveStorage::AnalyzeJob	{"job_class":"ActiveStorage::AnalyzeJob","job_id":"99639898-b8c9-419c-99fa-761214dcc7c8","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://demo-farm-admin/ActiveStorage::Blob/4"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-02-12T16:43:20.443497958Z","scheduled_at":"2026-02-12T16:43:20.443370029Z"}	0	99639898-b8c9-419c-99fa-761214dcc7c8	2026-02-12 16:43:20.44337	\N	\N	2026-02-12 16:43:20.443884	2026-02-12 16:43:20.443884
6	default	ActiveStorage::AnalyzeJob	{"job_class":"ActiveStorage::AnalyzeJob","job_id":"c61ace8a-f368-42e7-8542-a8a4edb93fc8","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://demo-farm-admin/ActiveStorage::Blob/5"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-02-12T16:45:25.189604937Z","scheduled_at":"2026-02-12T16:45:25.189416184Z"}	0	c61ace8a-f368-42e7-8542-a8a4edb93fc8	2026-02-12 16:45:25.189416	\N	\N	2026-02-12 16:45:25.190008	2026-02-12 16:45:25.190008
7	default	ActiveStorage::AnalyzeJob	{"job_class":"ActiveStorage::AnalyzeJob","job_id":"e5ee5f19-af29-4b1f-bd97-d6f3a7a8c352","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://demo-farm-admin/ActiveStorage::Blob/6"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-02-13T05:51:25.110849051Z","scheduled_at":"2026-02-13T05:51:25.110299088Z"}	0	e5ee5f19-af29-4b1f-bd97-d6f3a7a8c352	2026-02-13 05:51:25.110299	\N	\N	2026-02-13 05:51:27.617643	2026-02-13 05:51:27.617643
8	default	ActiveStorage::PurgeJob	{"job_class":"ActiveStorage::PurgeJob","job_id":"92c464be-cfb8-424a-9405-5eb54be20c10","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://demo-farm-admin/ActiveStorage::Blob/5"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-02-13T05:52:07.947848557Z","scheduled_at":"2026-02-13T05:52:07.947462818Z"}	0	92c464be-cfb8-424a-9405-5eb54be20c10	2026-02-13 05:52:07.947462	\N	\N	2026-02-13 05:52:10.513936	2026-02-13 05:52:10.513936
9	default	ActiveStorage::AnalyzeJob	{"job_class":"ActiveStorage::AnalyzeJob","job_id":"b890e8e2-667a-4697-ad5d-f81ef5e2e900","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://demo-farm-admin/ActiveStorage::Blob/7"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-02-13T05:52:11.920236510Z","scheduled_at":"2026-02-13T05:52:11.920077446Z"}	0	b890e8e2-667a-4697-ad5d-f81ef5e2e900	2026-02-13 05:52:11.920077	\N	\N	2026-02-13 05:52:11.920643	2026-02-13 05:52:11.920643
10	default	ActiveStorage::AnalyzeJob	{"job_class":"ActiveStorage::AnalyzeJob","job_id":"f50176f0-d090-4d1c-89a8-b449c18abcac","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://demo-farm-admin/ActiveStorage::Blob/8"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"Asia/Kolkata","enqueued_at":"2026-02-16T11:41:10.013383748Z","scheduled_at":"2026-02-16T11:41:10.012471817Z"}	0	f50176f0-d090-4d1c-89a8-b449c18abcac	2026-02-16 11:41:10.012471	\N	\N	2026-02-16 11:41:10.568931	2026-02-16 11:41:10.568931
11	default	ActiveStorage::AnalyzeJob	{"job_class":"ActiveStorage::AnalyzeJob","job_id":"456ccfd9-642e-4cfe-87a5-b45da6074bb1","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://demo-farm-admin/ActiveStorage::Blob/9"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"Asia/Kolkata","enqueued_at":"2026-02-16T15:33:45.707208019Z","scheduled_at":"2026-02-16T15:33:45.706707231Z"}	0	456ccfd9-642e-4cfe-87a5-b45da6074bb1	2026-02-16 15:33:45.706707	\N	\N	2026-02-16 15:33:48.323511	2026-02-16 15:33:48.323511
12	default	ActiveStorage::PurgeJob	{"job_class":"ActiveStorage::PurgeJob","job_id":"7864fab5-6375-4d22-acd2-efd284bcc525","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://demo-farm-admin/ActiveStorage::Blob/6"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"Asia/Kolkata","enqueued_at":"2026-02-16T15:36:49.657321108Z","scheduled_at":"2026-02-16T15:36:49.656669795Z"}	0	7864fab5-6375-4d22-acd2-efd284bcc525	2026-02-16 15:36:49.656669	\N	\N	2026-02-16 15:36:52.194294	2026-02-16 15:36:52.194294
13	default	ActiveStorage::AnalyzeJob	{"job_class":"ActiveStorage::AnalyzeJob","job_id":"82d1ff4b-ea1f-45f3-928f-bf3cebb9602f","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://demo-farm-admin/ActiveStorage::Blob/10"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"Asia/Kolkata","enqueued_at":"2026-02-16T15:36:53.673805268Z","scheduled_at":"2026-02-16T15:36:53.673583730Z"}	0	82d1ff4b-ea1f-45f3-928f-bf3cebb9602f	2026-02-16 15:36:53.673583	\N	\N	2026-02-16 15:36:53.674247	2026-02-16 15:36:53.674247
14	default	ActiveStorage::AnalyzeJob	{"job_class":"ActiveStorage::AnalyzeJob","job_id":"ff0b07bc-96b4-43b6-a00f-b04d9aff7e6e","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://demo-farm-admin/ActiveStorage::Blob/11"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"Asia/Kolkata","enqueued_at":"2026-02-16T15:40:01.260636627Z","scheduled_at":"2026-02-16T15:40:01.260445581Z"}	0	ff0b07bc-96b4-43b6-a00f-b04d9aff7e6e	2026-02-16 15:40:01.260445	\N	\N	2026-02-16 15:40:01.2613	2026-02-16 15:40:01.2613
15	default	ActiveStorage::AnalyzeJob	{"job_class":"ActiveStorage::AnalyzeJob","job_id":"1427b853-48d9-4ce7-8233-bc4268f428f7","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://demo-farm-admin/ActiveStorage::Blob/12"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"Asia/Kolkata","enqueued_at":"2026-02-16T15:43:43.614356050Z","scheduled_at":"2026-02-16T15:43:43.614114361Z"}	0	1427b853-48d9-4ce7-8233-bc4268f428f7	2026-02-16 15:43:43.614114	\N	\N	2026-02-16 15:43:43.614745	2026-02-16 15:43:43.614745
16	default	ActiveStorage::PurgeJob	{"job_class":"ActiveStorage::PurgeJob","job_id":"0710aca2-2e3a-44db-b281-424efe830868","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://demo-farm-admin/ActiveStorage::Blob/2"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"Asia/Kolkata","enqueued_at":"2026-02-16T15:53:15.246650294Z","scheduled_at":"2026-02-16T15:53:15.246464197Z"}	0	0710aca2-2e3a-44db-b281-424efe830868	2026-02-16 15:53:15.246464	\N	\N	2026-02-16 15:53:15.24743	2026-02-16 15:53:15.24743
17	default	ActiveStorage::PurgeJob	{"job_class":"ActiveStorage::PurgeJob","job_id":"a561657c-fb93-4c3c-9e20-cb0f9d43e5e3","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://demo-farm-admin/ActiveStorage::Blob/7"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"Asia/Kolkata","enqueued_at":"2026-02-16T15:53:43.174932856Z","scheduled_at":"2026-02-16T15:53:43.174717999Z"}	0	a561657c-fb93-4c3c-9e20-cb0f9d43e5e3	2026-02-16 15:53:43.174717	\N	\N	2026-02-16 15:53:43.17539	2026-02-16 15:53:43.17539
18	default	ActiveStorage::AnalyzeJob	{"job_class":"ActiveStorage::AnalyzeJob","job_id":"c56c58a2-39f2-4791-89ed-c7e18bc85049","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://demo-farm-admin/ActiveStorage::Blob/13"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"Asia/Kolkata","enqueued_at":"2026-02-16T15:57:33.581977091Z","scheduled_at":"2026-02-16T15:57:33.581778565Z"}	0	c56c58a2-39f2-4791-89ed-c7e18bc85049	2026-02-16 15:57:33.581778	\N	\N	2026-02-16 15:57:33.582414	2026-02-16 15:57:33.582414
19	default	ActiveStorage::AnalyzeJob	{"job_class":"ActiveStorage::AnalyzeJob","job_id":"37d3121b-a976-487c-ba07-49b2c7050b13","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://demo-farm-admin/ActiveStorage::Blob/14"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"Asia/Kolkata","enqueued_at":"2026-02-17T11:36:35.185074548Z","scheduled_at":"2026-02-17T11:36:35.184661547Z"}	0	37d3121b-a976-487c-ba07-49b2c7050b13	2026-02-17 11:36:35.184661	\N	\N	2026-02-17 11:36:37.932016	2026-02-17 11:36:37.932016
20	default	ActiveStorage::AnalyzeJob	{"job_class":"ActiveStorage::AnalyzeJob","job_id":"d8a483e3-adf1-41d9-81c5-a51f71de5664","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://demo-farm-admin/ActiveStorage::Blob/15"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"Asia/Kolkata","enqueued_at":"2026-02-21T10:11:28.515351286Z","scheduled_at":"2026-02-21T10:11:28.515018278Z"}	0	d8a483e3-adf1-41d9-81c5-a51f71de5664	2026-02-21 10:11:28.515018	\N	\N	2026-02-21 10:11:31.045528	2026-02-21 10:11:31.045528
21	default	ActiveStorage::AnalyzeJob	{"job_class":"ActiveStorage::AnalyzeJob","job_id":"207f1716-cc46-434e-8aa8-ea8898ef2d61","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://demo-farm-admin/ActiveStorage::Blob/16"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"Asia/Kolkata","enqueued_at":"2026-02-21T10:13:49.920534157Z","scheduled_at":"2026-02-21T10:13:49.920203919Z"}	0	207f1716-cc46-434e-8aa8-ea8898ef2d61	2026-02-21 10:13:49.920203	\N	\N	2026-02-21 10:13:52.322138	2026-02-21 10:13:52.322138
22	default	ActiveStorage::AnalyzeJob	{"job_class":"ActiveStorage::AnalyzeJob","job_id":"2830261b-bed7-472c-9dc6-7ea86aa4f2c1","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://demo-farm-admin/ActiveStorage::Blob/17"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"Asia/Kolkata","enqueued_at":"2026-02-21T10:15:08.320345478Z","scheduled_at":"2026-02-21T10:15:08.320170214Z"}	0	2830261b-bed7-472c-9dc6-7ea86aa4f2c1	2026-02-21 10:15:08.32017	\N	\N	2026-02-21 10:15:08.320723	2026-02-21 10:15:08.320723
23	default	ActiveStorage::PurgeJob	{"job_class":"ActiveStorage::PurgeJob","job_id":"d7f06716-edab-4e85-bb5f-d88cee3ff977","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://demo-farm-admin/ActiveStorage::Blob/17"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"Asia/Kolkata","enqueued_at":"2026-02-21T10:15:40.854595805Z","scheduled_at":"2026-02-21T10:15:40.854422160Z"}	0	d7f06716-edab-4e85-bb5f-d88cee3ff977	2026-02-21 10:15:40.854422	\N	\N	2026-02-21 10:15:40.854968	2026-02-21 10:15:40.854968
24	default	ImportMasterSubscriptionJob	{"job_class":"ImportMasterSubscriptionJob","job_id":"f7ad328b-71e3-44f3-8743-1c42d4a2ef98","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[2,2026],"executions":0,"exception_executions":{},"locale":"en","timezone":"Asia/Kolkata","enqueued_at":"2026-02-21T12:06:20.100626588Z","scheduled_at":"2026-02-21T12:06:20.096576234Z"}	0	f7ad328b-71e3-44f3-8743-1c42d4a2ef98	2026-02-21 12:06:20.096576	\N	\N	2026-02-21 12:06:20.717464	2026-02-21 12:06:20.717464
25	default	ImportMasterSubscriptionJob	{"job_class":"ImportMasterSubscriptionJob","job_id":"6b384f9d-b54b-4cea-afed-cd53b1496ad8","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[2,2026],"executions":0,"exception_executions":{},"locale":"en","timezone":"Asia/Kolkata","enqueued_at":"2026-02-21T12:10:52.551623352Z","scheduled_at":"2026-02-21T12:10:52.551484474Z"}	0	6b384f9d-b54b-4cea-afed-cd53b1496ad8	2026-02-21 12:10:52.551484	\N	\N	2026-02-21 12:10:53.090857	2026-02-21 12:10:53.090857
26	default	ActiveStorage::AnalyzeJob	{"job_class":"ActiveStorage::AnalyzeJob","job_id":"60e9eec0-7d07-404a-a755-7e789248e1de","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://demo-farm-admin/ActiveStorage::Blob/18"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"Asia/Kolkata","enqueued_at":"2026-02-21T12:14:16.008162025Z","scheduled_at":"2026-02-21T12:14:16.007946450Z"}	0	60e9eec0-7d07-404a-a755-7e789248e1de	2026-02-21 12:14:16.007946	\N	\N	2026-02-21 12:14:16.53278	2026-02-21 12:14:16.53278
27	default	ImportMasterSubscriptionJob	{"job_class":"ImportMasterSubscriptionJob","job_id":"da4109e5-cdae-4238-81ac-d9fda8f05331","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[2,2026],"executions":0,"exception_executions":{},"locale":"en","timezone":"Asia/Kolkata","enqueued_at":"2026-02-21T15:40:33.513742572Z","scheduled_at":"2026-02-21T15:40:33.513695409Z"}	0	da4109e5-cdae-4238-81ac-d9fda8f05331	2026-02-21 15:40:33.513695	\N	\N	2026-02-21 15:40:34.12814	2026-02-21 15:40:34.12814
28	default	ImportMasterSubscriptionJob	{"job_class":"ImportMasterSubscriptionJob","job_id":"6d5235ed-99d9-49c8-8907-01762b90f4ac","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[2,2026],"executions":0,"exception_executions":{},"locale":"en","timezone":"Asia/Kolkata","enqueued_at":"2026-02-22T10:08:55.666369836Z","scheduled_at":"2026-02-22T10:08:55.665408706Z"}	0	6d5235ed-99d9-49c8-8907-01762b90f4ac	2026-02-22 10:08:55.665408	\N	\N	2026-02-22 10:08:56.209446	2026-02-22 10:08:56.209446
29	default	ActiveStorage::AnalyzeJob	{"job_class":"ActiveStorage::AnalyzeJob","job_id":"9453dffb-868b-4482-aed9-b3223892157d","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://demo-farm-admin/ActiveStorage::Blob/19"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"Asia/Kolkata","enqueued_at":"2026-02-23T12:37:56.820662923Z","scheduled_at":"2026-02-23T12:37:56.820147142Z"}	0	9453dffb-868b-4482-aed9-b3223892157d	2026-02-23 12:37:56.820147	\N	\N	2026-02-23 12:37:59.232192	2026-02-23 12:37:59.232192
30	default	ActiveStorage::AnalyzeJob	{"job_class":"ActiveStorage::AnalyzeJob","job_id":"0d31db1b-b8a4-405f-9a02-50e2d445c468","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://demo-farm-admin/ActiveStorage::Blob/20"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"Asia/Kolkata","enqueued_at":"2026-02-23T12:38:00.616603331Z","scheduled_at":"2026-02-23T12:38:00.616397325Z"}	0	0d31db1b-b8a4-405f-9a02-50e2d445c468	2026-02-23 12:38:00.616397	\N	\N	2026-02-23 12:38:00.617011	2026-02-23 12:38:00.617011
31	default	ActiveStorage::AnalyzeJob	{"job_class":"ActiveStorage::AnalyzeJob","job_id":"2d15cbf0-f9db-4078-afe8-e73d7751115b","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://demo-farm-admin/ActiveStorage::Blob/21"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"Asia/Kolkata","enqueued_at":"2026-02-24T01:34:56.491290297Z","scheduled_at":"2026-02-24T01:34:56.490237963Z"}	0	2d15cbf0-f9db-4078-afe8-e73d7751115b	2026-02-24 01:34:56.490237	\N	\N	2026-02-24 01:34:57.060309	2026-02-24 01:34:57.060309
32	default	ActiveStorage::AnalyzeJob	{"job_class":"ActiveStorage::AnalyzeJob","job_id":"67334cfd-0a5a-4734-88ea-6d86157cebb3","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://demo-farm-admin/ActiveStorage::Blob/22"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"Asia/Kolkata","enqueued_at":"2026-02-24T03:43:14.638157906Z","scheduled_at":"2026-02-24T03:43:14.637799885Z"}	0	67334cfd-0a5a-4734-88ea-6d86157cebb3	2026-02-24 03:43:14.637799	\N	\N	2026-02-24 03:43:17.111964	2026-02-24 03:43:17.111964
33	default	ActiveStorage::AnalyzeJob	{"job_class":"ActiveStorage::AnalyzeJob","job_id":"75c04e6e-1148-40b7-a1ed-075c1661e52e","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://demo-farm-admin/ActiveStorage::Blob/23"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"Asia/Kolkata","enqueued_at":"2026-02-24T03:43:46.275943379Z","scheduled_at":"2026-02-24T03:43:46.275723386Z"}	0	75c04e6e-1148-40b7-a1ed-075c1661e52e	2026-02-24 03:43:46.275723	\N	\N	2026-02-24 03:43:46.276401	2026-02-24 03:43:46.276401
34	default	ActiveStorage::AnalyzeJob	{"job_class":"ActiveStorage::AnalyzeJob","job_id":"aeee57f2-ad1e-4289-8d29-c59a7df7837f","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://demo-farm-admin/ActiveStorage::Blob/24"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"Asia/Kolkata","enqueued_at":"2026-02-24T03:44:11.235329178Z","scheduled_at":"2026-02-24T03:44:11.235143437Z"}	0	aeee57f2-ad1e-4289-8d29-c59a7df7837f	2026-02-24 03:44:11.235143	\N	\N	2026-02-24 03:44:11.235808	2026-02-24 03:44:11.235808
35	default	ActiveStorage::AnalyzeJob	{"job_class":"ActiveStorage::AnalyzeJob","job_id":"e621030c-cf7a-41bc-a3cd-3786791044a3","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://demo-farm-admin/ActiveStorage::Blob/25"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"Asia/Kolkata","enqueued_at":"2026-02-27T00:42:19.326259178Z","scheduled_at":"2026-02-27T00:42:19.323683818Z"}	0	e621030c-cf7a-41bc-a3cd-3786791044a3	2026-02-27 00:42:19.323683	\N	\N	2026-02-27 00:42:19.954412	2026-02-27 00:42:19.954412
36	default	ActiveStorage::AnalyzeJob	{"job_class":"ActiveStorage::AnalyzeJob","job_id":"d3277748-0b43-4b29-b6e0-ea4947b7bb14","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://demo-farm-admin/ActiveStorage::Blob/26"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"Asia/Kolkata","enqueued_at":"2026-03-04T06:38:37.543931263Z","scheduled_at":"2026-03-04T06:38:37.543606849Z"}	0	d3277748-0b43-4b29-b6e0-ea4947b7bb14	2026-03-04 06:38:37.543606	\N	\N	2026-03-04 06:38:37.663663	2026-03-04 06:38:37.663663
37	default	ActiveStorage::PurgeJob	{"job_class":"ActiveStorage::PurgeJob","job_id":"ea4bf03e-29d5-4105-bbc0-8cdbf51db12f","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://demo-farm-admin/ActiveStorage::Blob/22"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"Asia/Kolkata","enqueued_at":"2026-03-18T10:57:27.447716270Z","scheduled_at":"2026-03-18T10:57:27.446225939Z"}	0	ea4bf03e-29d5-4105-bbc0-8cdbf51db12f	2026-03-18 10:57:27.446225	\N	\N	2026-03-18 10:57:28.005584	2026-03-18 10:57:28.005584
\.


--
-- Data for Name: solid_queue_pauses; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.solid_queue_pauses (id, queue_name, created_at) FROM stdin;
\.


--
-- Data for Name: solid_queue_processes; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.solid_queue_processes (id, kind, last_heartbeat_at, supervisor_id, pid, hostname, metadata, created_at, name) FROM stdin;
\.


--
-- Data for Name: solid_queue_ready_executions; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.solid_queue_ready_executions (id, job_id, queue_name, priority, created_at) FROM stdin;
1	1	default	0	2026-02-12 12:08:00.659859
2	2	default	0	2026-02-12 13:21:27.640663
3	3	default	0	2026-02-12 16:39:37.679176
4	4	default	0	2026-02-12 16:43:19.969805
5	5	default	0	2026-02-12 16:43:20.94988
6	6	default	0	2026-02-12 16:45:25.693479
7	7	default	0	2026-02-13 05:51:28.627623
8	8	default	0	2026-02-13 05:52:11.540424
9	9	default	0	2026-02-13 05:52:12.424767
10	10	default	0	2026-02-16 11:41:12.278278
11	11	default	0	2026-02-16 15:33:49.423897
12	12	default	0	2026-02-16 15:36:53.268588
13	13	default	0	2026-02-16 15:36:54.199201
14	14	default	0	2026-02-16 15:40:04.659369
15	15	default	0	2026-02-16 15:43:44.121434
16	16	default	0	2026-02-16 15:53:19.14923
17	17	default	0	2026-02-16 15:53:43.70142
18	18	default	0	2026-02-16 15:57:34.091297
19	19	default	0	2026-02-17 11:36:38.978225
20	20	default	0	2026-02-21 10:11:32.011118
21	21	default	0	2026-02-21 10:13:53.303348
22	22	default	0	2026-02-21 10:15:08.798475
23	23	default	0	2026-02-21 10:15:41.331665
24	24	default	0	2026-02-21 12:06:22.503679
25	25	default	0	2026-02-21 12:10:54.802315
26	26	default	0	2026-02-21 12:14:18.105218
27	27	default	0	2026-02-21 15:40:36.102443
28	28	default	0	2026-02-22 10:08:57.895861
29	29	default	0	2026-02-23 12:38:00.248349
30	30	default	0	2026-02-23 12:38:01.104664
31	31	default	0	2026-02-24 01:34:58.817153
32	32	default	0	2026-02-24 03:43:18.089017
33	33	default	0	2026-02-24 03:43:46.756886
34	34	default	0	2026-02-24 03:44:11.717307
35	35	default	0	2026-02-27 00:42:21.668974
36	36	default	0	2026-03-04 06:38:37.748088
37	37	default	0	2026-03-18 10:57:29.689868
\.


--
-- Data for Name: solid_queue_recurring_executions; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.solid_queue_recurring_executions (id, job_id, task_key, run_at, created_at) FROM stdin;
\.


--
-- Data for Name: solid_queue_recurring_tasks; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.solid_queue_recurring_tasks (id, key, schedule, command, class_name, arguments, queue_name, priority, static, description, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: solid_queue_scheduled_executions; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.solid_queue_scheduled_executions (id, job_id, queue_name, priority, scheduled_at, created_at) FROM stdin;
\.


--
-- Data for Name: solid_queue_semaphores; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.solid_queue_semaphores (id, key, value, expires_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: stock_batches; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.stock_batches (id, product_id, vendor_id, vendor_purchase_id, quantity_purchased, quantity_remaining, purchase_price, selling_price, batch_date, status, created_at, updated_at, store_id) FROM stdin;
43	35	11	\N	10.0	0.0	500.0	750.0	2026-03-19	exhausted	2026-03-19 08:25:49.698752	2026-03-26 03:38:32.405987	\N
48	41	11	\N	5.0	0.0	250.0	350.0	2026-03-19	exhausted	2026-03-19 09:13:09.708624	2026-03-26 04:46:31.021034	\N
50	43	11	\N	5.0	0.0	360.0	490.0	2026-03-19	exhausted	2026-03-19 09:18:09.882759	2026-03-26 05:01:39.712018	\N
46	38	11	\N	5.0	0.0	180.0	270.0	2026-03-19	exhausted	2026-03-19 09:01:53.798047	2026-03-29 10:07:20.080285	\N
55	48	11	\N	5.0	5.0	360.0	600.0	2026-03-19	active	2026-03-19 09:35:13.633483	2026-03-19 09:35:13.633483	\N
57	49	11	\N	2.0	0.0	12.0	100.0	2026-03-25	exhausted	2026-03-25 03:36:41.323722	2026-03-25 04:33:56.826277	\N
91	90	11	\N	4.0	4.0	750.0	1050.0	2026-05-04	active	2026-05-04 15:34:01.906817	2026-05-04 15:34:01.906817	\N
92	91	11	\N	5.0	5.0	1250.0	1750.0	2026-05-04	active	2026-05-04 15:35:33.589985	2026-05-04 15:35:33.589985	\N
93	92	11	\N	4.0	4.0	169.0	240.0	2026-05-04	active	2026-05-04 15:37:35.676007	2026-05-04 15:37:35.676007	\N
94	93	11	\N	5.0	5.0	57.0	130.0	2026-05-06	active	2026-05-06 07:48:37.418719	2026-05-06 07:48:37.418719	\N
62	50	11	\N	23.0	0.0	23.0	1.0	2026-03-29	exhausted	2026-03-29 05:32:39.644243	2026-04-16 14:24:14.149796	\N
98	97	11	\N	5.0	5.0	57.5	135.0	2026-05-06	active	2026-05-06 09:50:25.017234	2026-05-06 09:50:25.017234	\N
95	94	11	\N	5.0	3.0	32.5	65.0	2026-05-06	active	2026-05-06 07:51:48.350844	2026-05-09 06:06:07.327408	\N
60	35	11	\N	10.0	0.0	600.0	750.0	2026-03-26	exhausted	2026-03-26 06:50:33.860032	2026-05-03 01:23:54.860788	\N
47	40	11	\N	5.0	0.0	250.0	345.0	2026-03-19	exhausted	2026-03-19 09:11:09.452743	2026-05-06 15:48:50.483104	\N
45	39	11	\N	5.0	0.0	195.0	380.0	2026-03-19	exhausted	2026-03-19 09:01:28.089076	2026-05-25 04:46:47.314476	\N
96	95	11	\N	5.0	3.0	200.0	270.0	2026-05-06	active	2026-05-06 09:40:58.582982	2026-05-09 06:06:08.061189	\N
68	56	11	\N	2.0	0.0	780.0	1100.0	2026-04-30	exhausted	2026-04-30 15:40:23.861833	2026-05-03 01:55:05.678551	\N
101	104	11	\N	3.0	2.0	23.0	45.0	2026-05-10	active	2026-05-10 00:14:50.6273	2026-05-10 05:09:13.199565	\N
44	37	11	\N	5.0	0.0	480.0	600.0	2026-03-19	exhausted	2026-03-19 08:49:25.992492	2026-05-03 01:58:22.870034	\N
103	105	11	\N	4.0	0.0	34.0	6.0	2026-05-10	exhausted	2026-05-10 00:31:09.50596	2026-06-04 12:18:06.846178	\N
58	49	11	\N	345.0	308.0	12.0	100.0	2026-03-25	active	2026-03-25 04:48:04.520486	2026-05-03 04:12:35.702932	\N
63	51	11	\N	3.0	0.0	112.0	160.0	2026-04-16	exhausted	2026-04-16 07:23:03.984065	2026-05-03 11:03:35.790877	\N
108	42	11	\N	1.0	0.0	4.0	344.0	2026-05-17	exhausted	2026-05-17 10:16:49.796916	2026-06-04 09:39:28.438734	13
70	50	11	\N	1000.0	982.0	23.0	1.0	2026-05-03	active	2026-05-03 05:18:49.960941	2026-05-09 06:02:54.075007	\N
61	42	11	12	3.0	0.0	4.0	344.0	2026-03-26	exhausted	2026-03-26 07:19:50.520941	2026-06-03 12:58:31.405612	\N
102	105	11	\N	2.0	0.0	45.0	45.0	2026-05-10	exhausted	2026-05-10 00:31:08.227538	2026-05-10 05:09:14.071227	\N
84	83	11	\N	5.0	0.0	120.0	180.0	2026-05-04	exhausted	2026-05-04 15:12:51.239431	2026-06-07 04:52:08.238302	\N
73	61	11	\N	5.0	5.0	65.0	110.0	2026-05-04	active	2026-05-04 12:44:45.889188	2026-05-04 12:44:45.889188	\N
49	42	11	\N	5.0	0.0	450.0	650.0	2026-03-19	exhausted	2026-03-19 09:15:33.545935	2026-05-03 06:28:50.559092	\N
86	85	11	\N	9.0	4.0	52.0	125.0	2026-05-04	active	2026-05-04 15:21:35.282742	2026-05-25 04:46:46.076827	\N
78	73	11	\N	5.0	4.0	95.0	160.0	2026-05-04	active	2026-05-04 13:37:28.805098	2026-05-10 08:56:03.525079	\N
74	67	11	\N	5.0	5.0	56.0	90.0	2026-05-04	active	2026-05-04 13:16:49.523415	2026-05-04 13:16:49.523415	\N
66	54	11	\N	5.0	0.0	370.0	600.0	2026-04-19	exhausted	2026-04-19 15:18:46.716787	2026-05-10 07:04:05.53176	\N
69	57	11	\N	2.0	0.0	750.0	1035.0	2026-04-30	exhausted	2026-04-30 15:45:12.391257	2026-05-03 07:28:18.995045	\N
53	46	11	\N	25.0	0.0	83.0	130.0	2026-03-19	exhausted	2026-03-19 09:30:21.49213	2026-05-24 15:17:26.760154	\N
56	36	11	\N	5.0	0.0	250.0	350.0	2026-03-19	exhausted	2026-03-19 09:36:02.599539	2026-05-03 07:47:11.701836	\N
75	68	11	\N	5.0	5.0	56.0	90.0	2026-05-04	active	2026-05-04 13:17:17.722086	2026-05-04 13:17:17.722086	\N
77	72	11	\N	5.0	5.0	47.0	90.0	2026-05-04	active	2026-05-04 13:27:13.467389	2026-05-04 13:27:13.467389	\N
79	77	11	\N	5.0	5.0	60.0	100.0	2026-05-04	active	2026-05-04 14:00:42.128506	2026-05-04 14:00:42.128506	\N
87	86	11	\N	10.0	10.0	26.0	70.0	2026-05-04	active	2026-05-04 15:22:52.088003	2026-05-04 15:22:52.088003	\N
88	87	11	\N	9.0	9.0	45.0	125.0	2026-05-04	active	2026-05-04 15:25:05.539341	2026-05-04 15:25:05.539341	\N
89	88	11	\N	10.0	10.0	23.0	70.0	2026-05-04	active	2026-05-04 15:26:23.574221	2026-05-04 15:26:23.574221	\N
81	80	11	\N	3.0	0.0	36.0	90.0	2026-05-04	exhausted	2026-05-04 14:54:37.855093	2026-05-09 13:09:33.035459	\N
99	98	11	\N	5.0	2.0	120.0	160.0	2026-05-06	active	2026-05-06 09:54:11.245218	2026-05-10 05:11:25.726742	\N
107	59	11	\N	2.0	0.0	150.0	290.0	2026-05-17	exhausted	2026-05-17 10:10:15.436755	2026-05-17 10:11:00.261302	13
100	99	11	\N	323.0	313.0	1.0	1.0	2026-05-09	active	2026-05-09 06:10:12.042072	2026-06-03 11:45:39.187197	\N
71	58	11	\N	5.0	2.0	142.0	280.0	2026-05-04	active	2026-05-04 12:39:07.075462	2026-06-03 03:39:39.702216	\N
83	82	11	\N	5.0	4.0	225.0	408.0	2026-05-04	active	2026-05-04 15:03:39.96716	2026-05-17 10:16:59.876502	\N
80	78	11	\N	5.0	0.0	480.0	600.0	2026-05-04	exhausted	2026-05-04 14:14:45.278327	2026-06-04 14:30:44.273929	\N
106	58	11	\N	1.0	1.0	142.0	280.0	2026-05-17	active	2026-05-17 09:48:44.789216	2026-05-17 09:48:44.789216	13
72	59	11	\N	5.0	0.0	150.0	290.0	2026-05-04	exhausted	2026-05-04 12:41:01.848924	2026-05-17 10:10:13.308826	\N
54	47	11	\N	25.0	15.0	68.0	130.0	2026-03-19	active	2026-03-19 09:33:46.519679	2026-06-03 16:02:09.00106	\N
82	81	11	\N	5.0	3.0	56.0	180.0	2026-05-04	active	2026-05-04 14:56:46.439353	2026-05-17 10:16:54.196069	\N
109	81	11	\N	1.0	1.0	56.0	180.0	2026-05-17	active	2026-05-17 10:16:54.499079	2026-05-17 10:16:54.499079	13
110	82	11	\N	1.0	1.0	225.0	408.0	2026-05-17	active	2026-05-17 10:17:00.180483	2026-05-17 10:17:00.180483	13
90	89	11	\N	5.0	3.0	1250.0	1725.0	2026-05-04	active	2026-05-04 15:31:43.972459	2026-06-04 15:09:27.761447	\N
113	105	11	\N	1.0	1.0	45.0	45.0	2026-05-17	active	2026-05-17 13:38:58.288179	2026-05-17 13:38:58.288179	13
111	78	11	\N	2.0	0.0	480.0	600.0	2026-05-17	exhausted	2026-05-17 10:43:10.138744	2026-06-04 14:51:47.273253	13
67	55	11	\N	8.0	0.0	230.0	350.0	2026-04-19	exhausted	2026-04-19 15:21:06.912153	2026-06-06 09:47:30.127696	\N
64	52	11	\N	10.0	5.0	47.0	80.0	2026-04-16	active	2026-04-16 07:26:39.931749	2026-06-03 16:02:09.777039	\N
59	37	11	11	2.0	0.0	23.0	455.0	2026-03-26	exhausted	2026-03-26 06:45:49.237053	2026-06-04 09:41:39.200517	\N
112	55	11	\N	2.0	0.0	230.0	350.0	2026-05-17	exhausted	2026-05-17 10:43:13.147955	2026-06-06 09:47:30.283557	13
104	106	11	\N	10.0	0.0	1.0	1.0	2026-05-10	exhausted	2026-05-10 05:16:06.792587	2026-06-06 10:16:12.455023	\N
105	106	11	\N	332.0	331.0	1.0	0.99	2026-05-10	active	2026-05-10 05:16:07.11477	2026-06-06 10:16:13.416196	\N
65	53	11	\N	10.0	8.0	85.0	140.0	2026-04-16	active	2026-04-16 07:29:00.005737	2026-06-07 04:52:09.281854	\N
97	96	11	\N	5.0	4.0	76.5	135.0	2026-05-06	active	2026-05-06 09:48:21.202483	2026-06-07 04:52:10.055827	\N
76	70	11	\N	5.0	2.0	37.0	90.0	2026-05-04	active	2026-05-04 13:22:39.282477	2026-05-17 13:38:58.752209	\N
114	70	11	\N	3.0	2.0	37.0	90.0	2026-05-17	active	2026-05-17 13:38:59.060546	2026-05-17 13:41:13.481193	13
115	85	11	\N	3.0	3.0	52.0	125.0	2026-05-25	active	2026-05-25 04:46:46.792853	2026-05-25 04:46:46.792853	13
116	39	11	\N	1.0	0.0	195.0	380.0	2026-05-25	exhausted	2026-05-25 04:46:47.923381	2026-05-25 05:10:27.853836	13
51	44	11	\N	5.0	3.0	275.0	370.0	2026-03-19	active	2026-03-19 09:23:10.747793	2026-06-03 15:48:35.805004	\N
52	45	11	\N	5.0	2.0	395.0	530.0	2026-03-19	active	2026-03-19 09:25:14.473924	2026-06-03 16:02:07.80961	\N
85	84	11	\N	10.0	6.0	275.0	450.0	2026-05-04	active	2026-05-04 15:17:41.394979	2026-06-04 11:08:14.758174	\N
117	55	11	\N	6.0	2.0	250.0	380.0	2026-06-06	active	2026-06-06 09:39:10.32843	2026-06-06 09:47:30.440198	\N
118	55	11	12	8.0	8.0	250.0	380.0	2026-06-06	active	2026-06-06 11:26:06.840706	2026-06-06 11:26:09.792702	\N
\.


--
-- Data for Name: stock_movements; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.stock_movements (id, product_id, reference_type, reference_id, movement_type, quantity, stock_before, stock_after, notes, created_at, updated_at) FROM stdin;
140	35	adjustment	\N	added	10.00	0.00	10.00	Initial stock when product was created	2026-03-19 08:25:49.390745	2026-03-19 08:25:49.390745
141	37	adjustment	\N	added	5.00	0.00	5.00	Initial stock when product was created	2026-03-19 08:49:25.881824	2026-03-19 08:49:25.881824
142	39	adjustment	\N	added	5.00	0.00	5.00	Initial stock when product was created	2026-03-19 09:01:27.983037	2026-03-19 09:01:27.983037
143	40	adjustment	\N	added	5.00	0.00	5.00	Initial stock when product was created	2026-03-19 09:11:09.365051	2026-03-19 09:11:09.365051
144	41	adjustment	\N	added	5.00	0.00	5.00	Initial stock when product was created	2026-03-19 09:13:09.60796	2026-03-19 09:13:09.60796
145	42	adjustment	\N	added	5.00	0.00	5.00	Initial stock when product was created	2026-03-19 09:15:33.489593	2026-03-19 09:15:33.489593
146	43	adjustment	\N	added	5.00	0.00	5.00	Initial stock when product was created	2026-03-19 09:18:09.825117	2026-03-19 09:18:09.825117
147	44	adjustment	\N	added	5.00	0.00	5.00	Initial stock when product was created	2026-03-19 09:23:10.690702	2026-03-19 09:23:10.690702
148	45	adjustment	\N	added	5.00	0.00	5.00	Initial stock when product was created	2026-03-19 09:25:14.410414	2026-03-19 09:25:14.410414
149	46	adjustment	\N	added	25.00	0.00	25.00	Initial stock when product was created	2026-03-19 09:30:21.434377	2026-03-19 09:30:21.434377
150	47	adjustment	\N	added	25.00	0.00	25.00	Initial stock when product was created	2026-03-19 09:33:46.427725	2026-03-19 09:33:46.427725
151	48	adjustment	\N	added	5.00	0.00	5.00	Initial stock when product was created	2026-03-19 09:35:13.571858	2026-03-19 09:35:13.571858
152	41	booking	75	consumed	-2.00	5.00	3.00	Stock consumed for booking item: SUNFLOWER OIL [1LTR] (Qty: 2.0)	2026-03-19 09:39:03.382255	2026-03-19 09:39:03.382255
153	42	booking	76	consumed	-1.00	5.00	4.00	Stock consumed for booking item: COCONUT OIL [1LTR] (Qty: 1.0)	2026-03-21 07:07:02.358702	2026-03-21 07:07:02.358702
154	37	booking	77	consumed	-1.00	5.00	4.00	Stock consumed for booking item: DESI BUTTER [500GM] (Qty: 1.0)	2026-03-21 07:08:58.750817	2026-03-21 07:08:58.750817
155	38	booking	78	consumed	-1.00	5.00	4.00	Stock consumed for booking item: HONEY RAW [300GM] (Qty: 1.0)	2026-03-23 04:42:27.071879	2026-03-23 04:42:27.071879
156	35	booking	79	consumed	-1.00	10.00	9.00	Stock consumed for booking item: DESI COW GHEE [500ML] (Qty: 1.0)	2026-03-24 03:55:33.411498	2026-03-24 03:55:33.411498
157	46	booking	80	consumed	-2.00	25.00	23.00	Stock consumed for booking item: RAJMUDI RICE [1KG] (Qty: 2.0)	2026-03-24 04:29:54.611463	2026-03-24 04:29:54.611463
158	47	booking	80	consumed	-1.00	25.00	24.00	Stock consumed for booking item: SONA MASURI RICE [1KG] (Qty: 1.0)	2026-03-24 04:30:02.814898	2026-03-24 04:30:02.814898
159	35	booking	81	consumed	-2.00	9.00	7.00	Stock consumed for booking item: DESI COW GHEE [500ML] (Qty: 2.0)	2026-03-24 10:58:30.744432	2026-03-24 10:58:30.744432
160	35	booking	82	consumed	-2.00	7.00	5.00	Stock consumed for booking item: DESI COW GHEE [500ML] (Qty: 2.0)	2026-03-24 10:59:27.483768	2026-03-24 10:59:27.483768
161	35	booking	83	consumed	-2.00	5.00	3.00	Stock consumed for booking item: DESI COW GHEE [500ML] (Qty: 2.0)	2026-03-24 11:00:39.036932	2026-03-24 11:00:39.036932
162	35	booking	84	consumed	-2.00	3.00	1.00	Stock consumed for booking item: DESI COW GHEE [500ML] (Qty: 2.0)	2026-03-24 11:01:13.786423	2026-03-24 11:01:13.786423
163	47	booking	85	consumed	-3.00	24.00	21.00	Stock consumed for booking item: SONA MASURI RICE [1KG] (Qty: 3.0)	2026-03-25 03:25:58.453895	2026-03-25 03:25:58.453895
164	49	adjustment	\N	added	2.00	0.00	2.00	Initial stock when product was created	2026-03-25 03:36:37.929045	2026-03-25 03:36:37.929045
165	46	booking	86	consumed	-1.00	23.00	22.00	Stock consumed for booking item: RAJMUDI RICE [1KG] (Qty: 1.0)	2026-03-25 04:23:09.250991	2026-03-25 04:23:09.250991
166	49	booking	87	consumed	-1.00	2.00	1.00	Stock consumed for booking item: Test (Qty: 1.0)	2026-03-25 04:28:03.346643	2026-03-25 04:28:03.346643
167	49	booking	88	consumed	-1.00	1.00	0.00	Stock consumed for booking item: Test (Qty: 1.0)	2026-03-25 04:33:58.366921	2026-03-25 04:33:58.366921
168	49	booking	89	consumed	-1.00	345.00	344.00	Stock consumed for booking item: Test (Qty: 1.0)	2026-03-25 06:48:42.425557	2026-03-25 06:48:42.425557
169	35	booking	90	consumed	-1.00	1.00	0.00	Stock consumed for booking item: DESI COW GHEE [500ML] (Qty: 1.0)	2026-03-25 07:07:18.28248	2026-03-25 07:07:18.28248
170	41	booking	91	consumed	-1.00	3.00	2.00	Stock consumed for booking item: SUNFLOWER OIL [1LTR] (Qty: 1.0)	2026-03-25 07:13:24.454315	2026-03-25 07:13:24.454315
171	49	booking	91	consumed	-3.00	344.00	341.00	Stock consumed for booking item: Test (Qty: 3.0)	2026-03-25 07:13:26.758247	2026-03-25 07:13:26.758247
172	47	booking	91	consumed	-1.00	21.00	20.00	Stock consumed for booking item: SONA MASURI RICE [1KG] (Qty: 1.0)	2026-03-25 07:13:29.163973	2026-03-25 07:13:29.163973
173	35	booking	92	consumed	-1.00	10.00	9.00	Stock consumed for booking item: DESI COW GHEE [500ML] (Qty: 1.0)	2026-03-25 07:50:32.88642	2026-03-25 07:50:32.88642
174	35	booking	93	consumed	-1.00	8.00	7.00	Stock consumed for booking item: DESI COW GHEE [500ML] (Qty: 1.0)	2026-03-25 07:50:51.300155	2026-03-25 07:50:51.300155
175	35	booking	94	consumed	-2.00	6.00	4.00	Stock consumed for booking item: DESI COW GHEE [500ML] (Qty: 2.0)	2026-03-26 03:34:11.594613	2026-03-26 03:34:11.594613
176	49	booking	95	consumed	-1.00	338.00	337.00	Stock consumed for booking item: Test (Qty: 1.0)	2026-03-26 04:41:57.595673	2026-03-26 04:41:57.595673
177	49	booking	96	consumed	-1.00	336.00	335.00	Stock consumed for booking item: Test (Qty: 1.0)	2026-03-26 04:42:01.807732	2026-03-26 04:42:01.807732
178	49	booking	97	consumed	-1.00	336.00	335.00	Stock consumed for booking item: Test (Qty: 1.0)	2026-03-26 04:42:04.400761	2026-03-26 04:42:04.400761
179	49	booking	98	consumed	-1.00	334.00	333.00	Stock consumed for booking item: Test (Qty: 1.0)	2026-03-26 04:42:06.411509	2026-03-26 04:42:06.411509
180	49	booking	99	consumed	-1.00	332.00	331.00	Stock consumed for booking item: Test (Qty: 1.0)	2026-03-26 04:42:39.206216	2026-03-26 04:42:39.206216
181	43	booking	99	consumed	-1.00	5.00	4.00	Stock consumed for booking item: SESAME OIL [1LTR] (Qty: 1.0)	2026-03-26 04:42:39.495944	2026-03-26 04:42:39.495944
182	41	booking	100	consumed	-1.00	1.00	0.00	Stock consumed for booking item: SUNFLOWER OIL [1LTR] (Qty: 1.0)	2026-03-26 04:46:37.574125	2026-03-26 04:46:37.574125
183	49	booking	100	consumed	-4.00	330.00	326.00	Stock consumed for booking item: Test (Qty: 4.0)	2026-03-26 04:46:39.948148	2026-03-26 04:46:39.948148
184	43	booking	100	consumed	-1.00	3.00	2.00	Stock consumed for booking item: SESAME OIL [1LTR] (Qty: 1.0)	2026-03-26 04:46:42.234068	2026-03-26 04:46:42.234068
185	49	booking	101	consumed	-1.00	326.00	325.00	Stock consumed for booking item: Test (Qty: 1.0)	2026-03-26 05:01:29.142303	2026-03-26 05:01:29.142303
186	43	booking	101	consumed	-1.00	2.00	1.00	Stock consumed for booking item: SESAME OIL [1LTR] (Qty: 1.0)	2026-03-26 05:01:31.41463	2026-03-26 05:01:31.41463
187	37	vendor_purchase	11	added	2.00	4.00	6.00	Stock added from vendor purchase: VP000011 - DESI BUTTER [500GM] (Qty: 2.0)	2026-03-26 06:45:52.612587	2026-03-26 06:45:52.612587
188	35	booking	102	consumed	-1.00	10.00	9.00	Stock consumed for booking item: DESI COW GHEE [500ML] (Qty: 1.0)	2026-03-26 06:51:15.737641	2026-03-26 06:51:15.737641
189	35	booking	103	consumed	-1.00	8.00	7.00	Stock consumed for booking item: DESI COW GHEE [500ML] (Qty: 1.0)	2026-03-26 06:52:59.017429	2026-03-26 06:52:59.017429
190	49	booking	104	consumed	-1.00	324.00	323.00	Stock consumed for booking item: Test (Qty: 1.0)	2026-03-26 06:56:50.688144	2026-03-26 06:56:50.688144
191	42	vendor_purchase	12	added	3.00	4.00	7.00	Stock added from vendor purchase: VP000012 - COCONUT OIL [1LTR] (Qty: 3.0)	2026-03-26 07:19:54.738409	2026-03-26 07:19:54.738409
192	49	booking	105	consumed	-1.00	323.00	322.00	Stock consumed for booking item: Test (Qty: 1.0)	2026-03-26 07:25:22.008248	2026-03-26 07:25:22.008248
193	49	booking	106	consumed	-1.00	321.00	320.00	Stock consumed for booking item: Test (Qty: 1.0)	2026-03-26 08:33:08.552565	2026-03-26 08:33:08.552565
194	49	booking	107	consumed	-2.00	319.00	317.00	Stock consumed for booking item: Test (Qty: 2.0)	2026-03-26 08:43:18.666708	2026-03-26 08:43:18.666708
195	49	booking	108	consumed	-1.00	315.00	314.00	Stock consumed for booking item: Test (Qty: 1.0)	2026-03-26 08:47:49.909969	2026-03-26 08:47:49.909969
196	49	booking	109	consumed	-1.00	313.00	312.00	Stock consumed for booking item: Test (Qty: 1.0)	2026-03-26 10:19:55.220671	2026-03-26 10:19:55.220671
197	35	booking	110	consumed	-2.00	7.00	5.00	Stock consumed for booking item: DESI COW GHEE [500ML] (Qty: 2.0)	2026-03-28 12:35:50.774179	2026-03-28 12:35:50.774179
198	35	booking	111	consumed	-2.00	7.00	5.00	Stock consumed for booking item: DESI COW GHEE [500ML] (Qty: 2.0)	2026-03-28 12:36:19.893983	2026-03-28 12:36:19.893983
199	35	booking	112	consumed	-2.00	7.00	5.00	Stock consumed for booking item: DESI COW GHEE [500ML] (Qty: 2.0)	2026-03-28 12:36:39.723851	2026-03-28 12:36:39.723851
200	35	booking	113	consumed	-2.00	3.00	1.00	Stock consumed for booking item: DESI COW GHEE [500ML] (Qty: 2.0)	2026-03-28 12:37:01.269171	2026-03-28 12:37:01.269171
201	35	booking	114	consumed	-2.00	3.00	1.00	Stock consumed for booking item: DESI COW GHEE [500ML] (Qty: 2.0)	2026-03-28 12:37:15.897914	2026-03-28 12:37:15.897914
202	47	booking	115	consumed	-1.00	19.00	18.00	Stock consumed for booking item: SONA MASURI RICE [1KG] (Qty: 1.0)	2026-03-29 01:44:56.284816	2026-03-29 01:44:56.284816
203	49	booking	115	consumed	-1.00	311.00	310.00	Stock consumed for booking item: Test (Qty: 1.0)	2026-03-29 01:45:03.791584	2026-03-29 01:45:03.791584
204	38	booking	116	consumed	-1.00	4.00	3.00	Stock consumed for booking item: HONEY RAW [300GM] (Qty: 1.0)	2026-03-29 04:02:07.509346	2026-03-29 04:02:07.509346
205	47	booking	117	consumed	-1.00	18.00	17.00	Stock consumed for booking item: SONA MASURI RICE [1KG] (Qty: 1.0)	2026-03-29 04:08:25.945635	2026-03-29 04:08:25.945635
206	47	booking	118	consumed	-1.00	17.00	16.00	Stock consumed for booking item: SONA MASURI RICE [1KG] (Qty: 1.0)	2026-03-29 04:13:34.405025	2026-03-29 04:13:34.405025
207	38	booking	119	consumed	-1.00	3.00	2.00	Stock consumed for booking item: HONEY RAW [300GM] (Qty: 1.0)	2026-03-29 05:29:04.548793	2026-03-29 05:29:04.548793
208	50	adjustment	\N	added	23.00	0.00	23.00	Initial stock when product was created	2026-03-29 05:32:38.883842	2026-03-29 05:32:38.883842
209	49	booking	120	consumed	-1.00	310.00	309.00	Stock consumed for booking item: Test (Qty: 1.0)	2026-03-29 05:33:25.719332	2026-03-29 05:33:25.719332
210	50	booking	121	consumed	-1.00	23.00	22.00	Stock consumed for booking item: Test product (Qty: 1.0)	2026-03-29 05:38:51.441626	2026-03-29 05:38:51.441626
211	50	booking	122	consumed	-1.00	22.00	21.00	Stock consumed for booking item: Test product (Qty: 1.0)	2026-03-29 06:03:00.027191	2026-03-29 06:03:00.027191
212	50	booking	123	consumed	-1.00	21.00	20.00	Stock consumed for booking item: Test product (Qty: 1.0)	2026-03-29 06:21:25.625866	2026-03-29 06:21:25.625866
213	50	booking	124	consumed	-1.00	20.00	19.00	Stock consumed for booking item: Test product (Qty: 1.0)	2026-03-29 06:33:34.032778	2026-03-29 06:33:34.032778
214	50	booking	125	consumed	-1.00	19.00	18.00	Stock consumed for booking item: Test product (Qty: 1.0)	2026-03-29 06:53:33.94747	2026-03-29 06:53:33.94747
215	50	booking	126	consumed	-1.00	16.00	15.00	Stock consumed for booking item: Test product (Qty: 1.0)	2026-03-29 07:04:16.484249	2026-03-29 07:04:16.484249
216	50	booking	127	consumed	-1.00	16.00	15.00	Stock consumed for booking item: Test product (Qty: 1.0)	2026-03-29 07:04:18.194344	2026-03-29 07:04:18.194344
217	50	booking	128	consumed	-1.00	14.00	13.00	Stock consumed for booking item: Test product (Qty: 1.0)	2026-03-29 07:13:06.826608	2026-03-29 07:13:06.826608
218	50	booking	129	consumed	-1.00	12.00	11.00	Stock consumed for booking item: Test product (Qty: 1.0)	2026-03-29 10:03:42.301188	2026-03-29 10:03:42.301188
219	50	booking	130	consumed	-1.00	10.00	9.00	Stock consumed for booking item: Test product (Qty: 1.0)	2026-03-29 10:06:25.309136	2026-03-29 10:06:25.309136
220	38	booking	131	consumed	-1.00	2.00	1.00	Stock consumed for booking item: HONEY RAW [300GM] (Qty: 1.0)	2026-03-29 10:06:56.680449	2026-03-29 10:06:56.680449
221	38	booking	132	consumed	-1.00	1.00	0.00	Stock consumed for booking item: HONEY RAW [300GM] (Qty: 1.0)	2026-03-29 10:07:20.200086	2026-03-29 10:07:20.200086
222	40	booking	133	consumed	-1.00	5.00	4.00	Stock consumed for booking item: GROUNDNUT OIL [1LTR] (Qty: 1.0)	2026-03-29 10:08:36.922187	2026-03-29 10:08:36.922187
223	40	booking	134	consumed	-1.00	4.00	3.00	Stock consumed for booking item: GROUNDNUT OIL [1LTR] (Qty: 1.0)	2026-03-29 10:09:02.682615	2026-03-29 10:09:02.682615
224	50	booking	135	consumed	-1.00	9.00	8.00	Stock consumed for booking item: Test product (Qty: 1.0)	2026-03-29 10:17:26.711216	2026-03-29 10:17:26.711216
225	40	booking	135	consumed	-1.00	3.00	2.00	Stock consumed for booking item: GROUNDNUT OIL [1LTR] (Qty: 1.0)	2026-03-29 10:17:33.344083	2026-03-29 10:17:33.344083
226	45	booking	136	consumed	-1.00	5.00	4.00	Stock consumed for booking item: SAFFLOWER OIL [1LTR] (Qty: 1.0)	2026-03-29 10:18:13.064855	2026-03-29 10:18:13.064855
227	50	booking	137	consumed	-1.00	8.00	7.00	Stock consumed for booking item: Test product (Qty: 1.0)	2026-03-29 10:19:12.938566	2026-03-29 10:19:12.938566
228	50	booking	138	consumed	-1.00	7.00	6.00	Stock consumed for booking item: Test product (Qty: 1.0)	2026-03-29 10:23:55.352866	2026-03-29 10:23:55.352866
229	50	booking	139	consumed	-1.00	6.00	5.00	Stock consumed for booking item: Test product (Qty: 1.0)	2026-03-29 10:28:01.120543	2026-03-29 10:28:01.120543
230	50	booking	140	consumed	-1.00	5.00	4.00	Stock consumed for booking item: Test product (Qty: 1.0)	2026-03-29 10:31:14.234431	2026-03-29 10:31:14.234431
231	50	booking	141	consumed	-1.00	4.00	3.00	Stock consumed for booking item: Test product (Qty: 1.0)	2026-03-29 10:41:19.163048	2026-03-29 10:41:19.163048
232	51	adjustment	\N	added	3.00	0.00	3.00	Initial stock when product was created	2026-04-16 07:23:03.665346	2026-04-16 07:23:03.665346
233	52	adjustment	\N	added	10.00	0.00	10.00	Initial stock when product was created	2026-04-16 07:26:39.618179	2026-04-16 07:26:39.618179
234	53	adjustment	\N	added	10.00	0.00	10.00	Initial stock when product was created	2026-04-16 07:28:59.851332	2026-04-16 07:28:59.851332
235	37	booking	142	consumed	-1.00	6.00	5.00	Stock consumed for booking item: DESI BUTTER [500GM] (Qty: 1.0)	2026-04-16 07:38:08.765011	2026-04-16 07:38:08.765011
236	46	booking	142	consumed	-2.00	22.00	20.00	Stock consumed for booking item: RAJMUDI RICE [1KG] (Qty: 2.0)	2026-04-16 07:38:09.467966	2026-04-16 07:38:09.467966
237	51	booking	142	consumed	-2.00	3.00	1.00	Stock consumed for booking item: HANDPOUNDED-RICE-UNPOLISHED-1KG (Qty: 2.0)	2026-04-16 07:38:10.167867	2026-04-16 07:38:10.167867
238	52	booking	142	consumed	-2.00	10.00	8.00	Stock consumed for booking item: WHEAT-FLOUR-1KG (Qty: 2.0)	2026-04-16 07:38:10.867038	2026-04-16 07:38:10.867038
239	53	booking	142	consumed	-1.00	10.00	9.00	Stock consumed for booking item: JAGGERY-POWDER-1KG (Qty: 1.0)	2026-04-16 07:38:11.563909	2026-04-16 07:38:11.563909
240	50	booking	143	consumed	-3.00	3.00	0.00	Stock consumed for booking item: Test product (Qty: 3.0)	2026-04-16 14:24:14.616132	2026-04-16 14:24:14.616132
241	39	booking	143	consumed	-1.00	5.00	4.00	Stock consumed for booking item: HONEY WILD [300GM] (Qty: 1.0)	2026-04-16 14:24:15.297844	2026-04-16 14:24:15.297844
242	54	adjustment	\N	added	5.00	0.00	5.00	Initial stock when product was created	2026-04-19 15:18:46.486828	2026-04-19 15:18:46.486828
243	55	adjustment	\N	added	5.00	0.00	5.00	Initial stock when product was created	2026-04-19 15:21:06.680408	2026-04-19 15:21:06.680408
244	54	booking	144	consumed	-2.00	5.00	3.00	Stock consumed for booking item: DESI COW GHEE [500ML] (Qty: 2.0)	2026-04-19 15:26:25.769478	2026-04-19 15:26:25.769478
245	56	adjustment	\N	added	2.00	0.00	2.00	Initial stock when product was created	2026-04-30 15:40:23.625576	2026-04-30 15:40:23.625576
246	57	adjustment	\N	added	2.00	0.00	2.00	Initial stock when product was created	2026-04-30 15:45:12.136076	2026-04-30 15:45:12.136076
247	37	booking	145	consumed	-1.00	5.00	4.00	Stock consumed for booking item: DESI BUTTER [500GM] (Qty: 1.0)	2026-05-02 05:12:03.534707	2026-05-02 05:12:03.534707
248	36	booking	146	consumed	-1.00	5.00	4.00	Stock consumed for booking item: A2 DESI COW GHEE [225ML] (Qty: 1.0)	2026-05-02 12:46:54.272914	2026-05-02 12:46:54.272914
250	35	booking	148	consumed	-1.00	1.00	0.00	Stock consumed for booking item: A2 DESI COW GHEE [500ML] (Qty: 1.0)	2026-05-03 01:23:55.339374	2026-05-03 01:23:55.339374
251	42	booking	148	consumed	-1.00	7.00	6.00	Stock consumed for booking item: COCONUT OIL [1LTR] (Qty: 1.0)	2026-05-03 01:23:56.112635	2026-05-03 01:23:56.112635
252	42	booking	149	consumed	-1.00	6.00	5.00	Stock consumed for booking item: COCONUT OIL [1LTR] (Qty: 1.0)	2026-05-03 01:40:18.254094	2026-05-03 01:40:18.254094
253	57	booking	149	consumed	-1.00	2.00	1.00	Stock consumed for booking item: GROUND NUT OIL [3LTRs] (Qty: 1.0)	2026-05-03 01:40:18.949373	2026-05-03 01:40:18.949373
254	56	booking	150	consumed	-1.00	2.00	1.00	Stock consumed for booking item: DESI COW GHEE [1LTR] (Qty: 1.0)	2026-05-03 01:48:58.167254	2026-05-03 01:48:58.167254
255	56	booking	151	consumed	-1.00	1.00	0.00	Stock consumed for booking item: DESI COW GHEE [1LTR] (Qty: 1.0)	2026-05-03 01:55:06.160504	2026-05-03 01:55:06.160504
256	37	booking	152	consumed	-1.00	4.00	3.00	Stock consumed for booking item: DESI BUTTER [500GM] (Qty: 1.0)	2026-05-03 01:57:32.257336	2026-05-03 01:57:32.257336
257	37	booking	153	consumed	-1.00	3.00	2.00	Stock consumed for booking item: DESI BUTTER [500GM] (Qty: 1.0)	2026-05-03 01:58:23.342915	2026-05-03 01:58:23.342915
258	37	booking	154	consumed	-1.00	2.00	1.00	Stock consumed for booking item: DESI BUTTER [500GM] (Qty: 1.0)	2026-05-03 04:11:51.352856	2026-05-03 04:11:51.352856
259	49	booking	155	consumed	-1.00	309.00	308.00	Stock consumed for booking item: Test (Qty: 1.0)	2026-05-03 04:12:36.014134	2026-05-03 04:12:36.014134
260	52	booking	156	consumed	-1.00	8.00	7.00	Stock consumed for booking item: WHEAT-FLOUR-1KG (Qty: 1.0)	2026-05-03 04:17:52.879505	2026-05-03 04:17:52.879505
261	52	booking	157	consumed	-1.00	7.00	6.00	Stock consumed for booking item: WHEAT-FLOUR-1KG (Qty: 1.0)	2026-05-03 04:21:00.489856	2026-05-03 04:21:00.489856
262	39	booking	158	consumed	-1.00	4.00	3.00	Stock consumed for booking item: HONEY WILD [300GM] (Qty: 1.0)	2026-05-03 04:29:03.856179	2026-05-03 04:29:03.856179
263	39	booking	159	consumed	-1.00	3.00	2.00	Stock consumed for booking item: HONEY WILD [300GM] (Qty: 1.0)	2026-05-03 04:43:59.254565	2026-05-03 04:43:59.254565
264	42	booking	160	consumed	-1.00	5.00	4.00	Stock consumed for booking item: COCONUT OIL [1LTR] (Qty: 1.0)	2026-05-03 05:12:34.346466	2026-05-03 05:12:34.346466
265	46	booking	160	consumed	-2.00	20.00	18.00	Stock consumed for booking item: RAJMUDI RICE [1KG] (Qty: 2.0)	2026-05-03 05:12:35.055908	2026-05-03 05:12:35.055908
266	54	booking	161	consumed	-1.00	3.00	2.00	Stock consumed for booking item: DESI COW GHEE [500ML] (Qty: 1.0)	2026-05-03 05:12:46.618204	2026-05-03 05:12:46.618204
269	42	booking	164	consumed	-1.00	4.00	3.00	Stock consumed for booking item: COCONUT OIL [1LTR] (Qty: 1.0)	2026-05-03 06:28:51.053331	2026-05-03 06:28:51.053331
270	46	booking	164	consumed	-2.00	18.00	16.00	Stock consumed for booking item: RAJMUDI RICE [1KG] (Qty: 2.0)	2026-05-03 06:28:51.758145	2026-05-03 06:28:51.758145
271	54	booking	165	consumed	-1.00	2.00	1.00	Stock consumed for booking item: DESI COW GHEE [500ML] (Qty: 1.0)	2026-05-03 06:29:13.916921	2026-05-03 06:29:13.916921
272	36	booking	166	consumed	-1.00	3.00	2.00	Stock consumed for booking item: A2 DESI COW GHEE [225ML] (Qty: 1.0)	2026-05-03 07:21:37.790564	2026-05-03 07:21:37.790564
273	36	booking	167	consumed	-1.00	2.00	1.00	Stock consumed for booking item: A2 DESI COW GHEE [225ML] (Qty: 1.0)	2026-05-03 07:23:08.543938	2026-05-03 07:23:08.543938
274	57	booking	168	consumed	-1.00	1.00	0.00	Stock consumed for booking item: GROUND NUT OIL [3LTRs] (Qty: 1.0)	2026-05-03 07:28:19.496469	2026-05-03 07:28:19.496469
275	50	booking	169	consumed	-1.00	1000.00	999.00	Stock consumed for booking item: Test product (Qty: 1.0)	2026-05-03 07:33:24.28995	2026-05-03 07:33:24.28995
276	36	booking	170	consumed	-1.00	1.00	0.00	Stock consumed for booking item: A2 DESI COW GHEE [225ML] (Qty: 1.0)	2026-05-03 07:47:12.030146	2026-05-03 07:47:12.030146
277	50	booking	171	consumed	-1.00	999.00	998.00	Stock consumed for booking item: Test product (Qty: 1.0)	2026-05-03 07:48:48.436098	2026-05-03 07:48:48.436098
278	50	booking	172	consumed	-1.00	998.00	997.00	Stock consumed for booking item: Test product (Qty: 1.0)	2026-05-03 09:03:18.193155	2026-05-03 09:03:18.193155
279	50	booking	173	consumed	-1.00	997.00	996.00	Stock consumed for booking item: Test product (Qty: 1.0)	2026-05-03 09:03:55.192551	2026-05-03 09:03:55.192551
280	50	booking	174	consumed	-1.00	996.00	995.00	Stock consumed for booking item: Test product (Qty: 1.0)	2026-05-03 09:04:54.688044	2026-05-03 09:04:54.688044
281	50	booking	175	consumed	-1.00	995.00	994.00	Stock consumed for booking item: Test product (Qty: 1.0)	2026-05-03 09:05:21.026003	2026-05-03 09:05:21.026003
282	50	booking	176	consumed	-1.00	994.00	993.00	Stock consumed for booking item: Test product (Qty: 1.0)	2026-05-03 09:10:25.986141	2026-05-03 09:10:25.986141
283	50	booking	177	consumed	-1.00	993.00	992.00	Stock consumed for booking item: Test product (Qty: 1.0)	2026-05-03 09:12:36.69816	2026-05-03 09:12:36.69816
284	50	booking	178	consumed	-1.00	992.00	991.00	Stock consumed for booking item: Test product (Qty: 1.0)	2026-05-03 09:15:46.602657	2026-05-03 09:15:46.602657
285	55	booking	179	consumed	-1.00	8.00	7.00	Stock consumed for booking item: DESI COW GHEE [300ML] (Qty: 1.0)	2026-05-03 10:02:45.204871	2026-05-03 10:02:45.204871
286	50	booking	180	consumed	-1.00	991.00	990.00	Stock consumed for booking item: Test product (Qty: 1.0)	2026-05-03 10:03:21.185222	2026-05-03 10:03:21.185222
287	50	booking	181	consumed	-1.00	990.00	989.00	Stock consumed for booking item: Test product (Qty: 1.0)	2026-05-03 10:13:57.289295	2026-05-03 10:13:57.289295
288	50	booking	182	consumed	-1.00	989.00	988.00	Stock consumed for booking item: Test product (Qty: 1.0)	2026-05-03 10:15:26.406647	2026-05-03 10:15:26.406647
289	50	booking	183	consumed	-1.00	988.00	987.00	Stock consumed for booking item: Test product (Qty: 1.0)	2026-05-03 10:18:50.136536	2026-05-03 10:18:50.136536
290	50	booking	184	consumed	-1.00	987.00	986.00	Stock consumed for booking item: Test product (Qty: 1.0)	2026-05-03 10:19:21.207645	2026-05-03 10:19:21.207645
291	51	booking	185	consumed	-1.00	1.00	0.00	Stock consumed for booking item: HANDPOUNDED-RICE-UNPOLISHED-1KG (Qty: 1.0)	2026-05-03 11:03:36.112129	2026-05-03 11:03:36.112129
292	50	booking	186	consumed	-1.00	986.00	985.00	Stock consumed for booking item: Test product (Qty: 1.0)	2026-05-03 11:13:45.346471	2026-05-03 11:13:45.346471
293	50	booking	187	consumed	-1.00	985.00	984.00	Stock consumed for booking item: Test product (Qty: 1.0)	2026-05-03 11:14:11.539838	2026-05-03 11:14:11.539838
294	55	booking	188	consumed	-1.00	7.00	6.00	Stock consumed for booking item: DESI COW GHEE [300ML] (Qty: 1.0)	2026-05-04 11:05:48.137079	2026-05-04 11:05:48.137079
295	58	adjustment	\N	added	5.00	0.00	5.00	Initial stock when product was created	2026-05-04 12:39:06.498828	2026-05-04 12:39:06.498828
296	59	adjustment	\N	added	5.00	0.00	5.00	Initial stock when product was created	2026-05-04 12:41:01.689532	2026-05-04 12:41:01.689532
297	61	adjustment	\N	added	5.00	0.00	5.00	Initial stock when product was created	2026-05-04 12:44:45.73228	2026-05-04 12:44:45.73228
298	67	adjustment	\N	added	5.00	0.00	5.00	Initial stock when product was created	2026-05-04 13:16:49.078976	2026-05-04 13:16:49.078976
299	68	adjustment	\N	added	5.00	0.00	5.00	Initial stock when product was created	2026-05-04 13:17:17.554571	2026-05-04 13:17:17.554571
300	70	adjustment	\N	added	5.00	0.00	5.00	Initial stock when product was created	2026-05-04 13:22:39.045083	2026-05-04 13:22:39.045083
301	72	adjustment	\N	added	5.00	0.00	5.00	Initial stock when product was created	2026-05-04 13:27:13.310173	2026-05-04 13:27:13.310173
302	77	adjustment	\N	added	5.00	0.00	5.00	Initial stock when product was created	2026-05-04 14:00:41.896241	2026-05-04 14:00:41.896241
303	78	adjustment	\N	added	5.00	0.00	5.00	Initial stock when product was created	2026-05-04 14:14:45.021212	2026-05-04 14:14:45.021212
304	80	adjustment	\N	added	3.00	0.00	3.00	Initial stock when product was created	2026-05-04 14:54:37.623865	2026-05-04 14:54:37.623865
305	81	adjustment	\N	added	5.00	0.00	5.00	Initial stock when product was created	2026-05-04 14:56:46.284767	2026-05-04 14:56:46.284767
306	82	adjustment	\N	added	5.00	0.00	5.00	Initial stock when product was created	2026-05-04 15:03:39.812269	2026-05-04 15:03:39.812269
307	83	adjustment	\N	added	5.00	0.00	5.00	Initial stock when product was created	2026-05-04 15:12:50.998869	2026-05-04 15:12:50.998869
308	84	adjustment	\N	added	10.00	0.00	10.00	Initial stock when product was created	2026-05-04 15:17:41.236978	2026-05-04 15:17:41.236978
309	85	adjustment	\N	added	9.00	0.00	9.00	Initial stock when product was created	2026-05-04 15:21:35.054011	2026-05-04 15:21:35.054011
310	86	adjustment	\N	added	10.00	0.00	10.00	Initial stock when product was created	2026-05-04 15:22:51.930143	2026-05-04 15:22:51.930143
311	87	adjustment	\N	added	9.00	0.00	9.00	Initial stock when product was created	2026-05-04 15:25:05.381712	2026-05-04 15:25:05.381712
312	88	adjustment	\N	added	10.00	0.00	10.00	Initial stock when product was created	2026-05-04 15:26:23.414879	2026-05-04 15:26:23.414879
313	89	adjustment	\N	added	5.00	0.00	5.00	Initial stock when product was created	2026-05-04 15:31:43.816398	2026-05-04 15:31:43.816398
314	90	adjustment	\N	added	4.00	0.00	4.00	Initial stock when product was created	2026-05-04 15:34:01.753528	2026-05-04 15:34:01.753528
315	91	adjustment	\N	added	5.00	0.00	5.00	Initial stock when product was created	2026-05-04 15:35:33.432671	2026-05-04 15:35:33.432671
316	92	adjustment	\N	added	4.00	0.00	4.00	Initial stock when product was created	2026-05-04 15:37:35.521664	2026-05-04 15:37:35.521664
317	93	adjustment	\N	added	5.00	0.00	5.00	Initial stock when product was created	2026-05-06 07:48:36.883506	2026-05-06 07:48:36.883506
318	94	adjustment	\N	added	5.00	0.00	5.00	Initial stock when product was created	2026-05-06 07:51:47.793055	2026-05-06 07:51:47.793055
319	95	adjustment	\N	added	5.00	0.00	5.00	Initial stock when product was created	2026-05-06 09:40:57.986263	2026-05-06 09:40:57.986263
320	96	adjustment	\N	added	5.00	0.00	5.00	Initial stock when product was created	2026-05-06 09:48:20.627383	2026-05-06 09:48:20.627383
321	97	adjustment	\N	added	5.00	0.00	5.00	Initial stock when product was created	2026-05-06 09:50:24.779011	2026-05-06 09:50:24.779011
322	98	adjustment	\N	added	5.00	0.00	5.00	Initial stock when product was created	2026-05-06 09:54:11.08845	2026-05-06 09:54:11.08845
323	40	booking	189	consumed	-1.00	2.00	1.00	Stock consumed for booking item: GROUNDNUT OIL [1LTR] (Qty: 1.0)	2026-05-06 15:48:05.908189	2026-05-06 15:48:05.908189
324	85	booking	189	consumed	-1.00	9.00	8.00	Stock consumed for booking item: HIMALAYA CRYSTAL ROCK SALT [1KG] (Qty: 1.0)	2026-05-06 15:48:06.646278	2026-05-06 15:48:06.646278
325	50	booking	190	consumed	-1.00	984.00	983.00	Stock consumed for booking item: Test product (Qty: 1.0)	2026-05-09 04:44:39.060666	2026-05-09 04:44:39.060666
326	98	booking	190	consumed	-1.00	5.00	4.00	Stock consumed for booking item: KHANDSARISUGAR [1 KG] (Qty: 1.0)	2026-05-09 04:44:39.779001	2026-05-09 04:44:39.779001
327	80	booking	191	consumed	-1.00	3.00	2.00	Stock consumed for booking item: BARLEY WHOLE [500GM] (Qty: 1.0)	2026-05-09 05:38:44.152095	2026-05-09 05:38:44.152095
328	50	booking	192	consumed	-1.00	983.00	982.00	Stock consumed for booking item: Test product (Qty: 1.0)	2026-05-09 06:02:54.379485	2026-05-09 06:02:54.379485
329	98	booking	192	consumed	-1.00	4.00	3.00	Stock consumed for booking item: KHANDSARISUGAR [1 KG] (Qty: 1.0)	2026-05-09 06:02:55.06786	2026-05-09 06:02:55.06786
330	94	booking	193	consumed	-1.00	5.00	4.00	Stock consumed for booking item: MEDIUMRAVA [500GM] (Qty: 1.0)	2026-05-09 06:04:11.666982	2026-05-09 06:04:11.666982
331	95	booking	194	consumed	-1.00	5.00	4.00	Stock consumed for booking item: MOONGDAL [1 KG] (Qty: 1.0)	2026-05-09 06:05:24.356357	2026-05-09 06:05:24.356357
332	94	booking	195	consumed	-1.00	4.00	3.00	Stock consumed for booking item: MEDIUMRAVA [500GM] (Qty: 1.0)	2026-05-09 06:06:07.671252	2026-05-09 06:06:07.671252
333	95	booking	195	consumed	-1.00	4.00	3.00	Stock consumed for booking item: MOONGDAL [1 KG] (Qty: 1.0)	2026-05-09 06:06:08.370886	2026-05-09 06:06:08.370886
334	99	booking	196	consumed	-1.00	323.00	322.00	Stock consumed for booking item: zxxz (Qty: 1.0)	2026-05-09 06:11:48.402185	2026-05-09 06:11:48.402185
335	99	booking	197	consumed	-1.00	322.00	321.00	Stock consumed for booking item: zxxz (Qty: 1.0)	2026-05-09 06:14:27.394292	2026-05-09 06:14:27.394292
336	99	booking	198	consumed	-1.00	321.00	320.00	Stock consumed for booking item: zxxz (Qty: 1.0)	2026-05-09 06:19:38.23662	2026-05-09 06:19:38.23662
337	80	booking	199	consumed	-1.00	2.00	1.00	Stock consumed for booking item: BARLEY WHOLE [500GM] (Qty: 1.0)	2026-05-09 06:24:37.316192	2026-05-09 06:24:37.316192
338	99	booking	200	consumed	-1.00	318.00	317.00	Stock consumed for booking item: zxxz (Qty: 1.0)	2026-05-09 06:43:40.573354	2026-05-09 06:43:40.573354
339	80	booking	201	consumed	-1.00	1.00	0.00	Stock consumed for booking item: BARLEY WHOLE [500GM] (Qty: 1.0)	2026-05-09 13:09:33.501635	2026-05-09 13:09:33.501635
340	59	booking	202	consumed	-1.00	5.00	4.00	Stock consumed for booking item: BLACK RICE  [1KG] (Qty: 1.0)	2026-05-09 13:17:18.57544	2026-05-09 13:17:18.57544
341	104	adjustment	\N	added	3.00	0.00	3.00	Initial stock when product was created	2026-05-10 00:14:49.49362	2026-05-10 00:14:49.49362
342	105	adjustment	\N	added	2.00	0.00	2.00	Initial stock for variant 1 Kg when product was created	2026-05-10 00:31:07.589924	2026-05-10 00:31:07.589924
343	105	adjustment	\N	added	4.00	0.00	4.00	Initial stock for variant 2 Kg when product was created	2026-05-10 00:31:08.890444	2026-05-10 00:31:08.890444
344	105	booking	203	consumed	-1.00	6.00	5.00	Stock consumed for booking item: dsd (Qty: 1.0)	2026-05-10 00:32:47.289389	2026-05-10 00:32:47.289389
345	104	booking	204	consumed	-1.00	3.00	2.00	Stock consumed for booking item: sd (Qty: 1.0)	2026-05-10 05:09:13.678381	2026-05-10 05:09:13.678381
346	105	booking	204	consumed	-1.00	5.00	4.00	Stock consumed for booking item: dsd (Qty: 1.0)	2026-05-10 05:09:14.385205	2026-05-10 05:09:14.385205
347	105	booking	205	consumed	-1.00	4.00	3.00	Stock consumed for booking item: dsd (Qty: 1.0)	2026-05-10 05:11:25.33422	2026-05-10 05:11:25.33422
348	98	booking	205	consumed	-1.00	3.00	2.00	Stock consumed for booking item: KHANDSARISUGAR [1 KG] (Qty: 1.0)	2026-05-10 05:11:26.038585	2026-05-10 05:11:26.038585
349	106	adjustment	\N	added	10.00	0.00	10.00	Initial stock for variant 1 Kg when product was created	2026-05-10 05:16:06.389529	2026-05-10 05:16:06.389529
350	106	adjustment	\N	added	332.00	0.00	332.00	Initial stock for variant 2 Kg when product was created	2026-05-10 05:16:06.954858	2026-05-10 05:16:06.954858
351	106	booking	206	consumed	-1.00	342.00	341.00	Stock consumed for booking item: Raw (Qty: 1.0)	2026-05-10 05:26:20.849214	2026-05-10 05:26:20.849214
352	54	booking	207	consumed	-1.00	1.00	0.00	Stock consumed for booking item: DESI COW GHEE [500ML] (Qty: 1.0)	2026-05-10 07:04:06.031548	2026-05-10 07:04:06.031548
353	106	booking	208	consumed	-1.00	341.00	340.00	Stock consumed for booking item: Raw (Qty: 1.0)	2026-05-10 08:55:27.991603	2026-05-10 08:55:27.991603
354	73	booking	209	consumed	-1.00	5.00	4.00	Stock consumed for booking item: LITTLE MILLET - SAAME [1KG] (Qty: 1.0)	2026-05-10 08:56:03.845801	2026-05-10 08:56:03.845801
355	81	booking	210	consumed	-1.00	5.00	4.00	Stock consumed for booking item: BYADAGI CHILLI [100GM] (Qty: 1.0)	2026-05-10 09:39:27.355525	2026-05-10 09:39:27.355525
356	106	booking	210	consumed	-1.00	340.00	339.00	Stock consumed for booking item: Raw (Qty: 1.0)	2026-05-10 09:39:28.059418	2026-05-10 09:39:28.059418
357	59	booking	210	consumed	-1.00	4.00	3.00	Stock consumed for booking item: BLACK RICE  [1KG] (Qty: 1.0)	2026-05-10 09:39:28.75368	2026-05-10 09:39:28.75368
358	105	booking	210	consumed	-1.00	3.00	2.00	Stock consumed for booking item: dsd (Qty: 1.0)	2026-05-10 09:39:29.445318	2026-05-10 09:39:29.445318
359	106	booking	211	consumed	-1.00	339.00	338.00	Stock consumed for booking item: Raw (Qty: 1.0)	2026-05-10 09:40:46.741042	2026-05-10 09:40:46.741042
360	59	booking	212	consumed	-1.00	3.00	2.00	Stock consumed for booking item: BLACK RICE  [1KG] (Qty: 1.0)	2026-05-10 09:58:10.490471	2026-05-10 09:58:10.490471
361	78	booking	212	consumed	-1.00	5.00	4.00	Stock consumed for booking item: COW BUTTER [500GM] (Qty: 1.0)	2026-05-10 09:58:11.202861	2026-05-10 09:58:11.202861
362	106	booking	213	consumed	-1.00	338.00	337.00	Stock consumed for booking item: Raw (Qty: 1.0)	2026-05-14 02:01:05.062719	2026-05-14 02:01:05.062719
363	58	booking	214	consumed	-1.00	5.00	4.00	Stock consumed for booking item: BASUMATHI-RICE [1KG] (Qty: 1.0)	2026-05-17 09:57:04.642066	2026-05-17 09:57:04.642066
364	59	booking	215	consumed	-2.00	2.00	0.00	Stock consumed for booking at dsdsds: BLACK RICE  [1KG] (Qty: 2.0)	2026-05-17 10:11:03.14863	2026-05-17 10:11:03.14863
365	70	booking	216	consumed	-1.00	3.00	2.00	Stock consumed for booking at dsdsds: FOXTAIL MILLET - NAVANE [500GM] (Qty: 1.0)	2026-05-17 13:41:14.104784	2026-05-17 13:41:14.104784
366	39	booking	217	consumed	-1.00	2.00	1.00	Stock consumed for booking: HONEY WILD [300GM] (Qty: 1.0)	2026-05-24 12:36:20.912857	2026-05-24 12:36:20.912857
367	99	booking	218	consumed	-1.00	317.00	316.00	Stock consumed for booking: zxxz (Qty: 1.0)	2026-05-24 12:42:42.867782	2026-05-24 12:42:42.867782
368	46	booking	219	consumed	-16.00	16.00	0.00	Stock consumed for booking: RAJMUDI RICE [1KG] (Qty: 16.0)	2026-05-24 15:17:27.389672	2026-05-24 15:17:27.389672
369	106	booking	220	consumed	-1.00	337.00	336.00	Stock consumed for booking: Raw (Qty: 1.0)	2026-05-25 05:01:27.889085	2026-05-25 05:01:27.889085
370	83	booking	221	consumed	-3.00	5.00	2.00	Stock consumed for booking: HONEY SMALL BHEE [150GM] (Qty: 3.0)	2026-05-25 05:10:26.602348	2026-05-25 05:10:26.602348
371	84	booking	221	consumed	-2.00	10.00	8.00	Stock consumed for booking: HONEY RAW [500ML] (Qty: 2.0)	2026-05-25 05:10:27.495651	2026-05-25 05:10:27.495651
372	39	booking	221	consumed	-1.00	1.00	0.00	Stock consumed for booking: HONEY WILD [300GM] (Qty: 1.0)	2026-05-25 05:10:28.392581	2026-05-25 05:10:28.392581
373	55	booking	222	consumed	-1.00	6.00	5.00	Stock consumed for booking: DESI COW GHEE [300ML] (Qty: 1.0)	2026-06-02 15:46:28.900675	2026-06-02 15:46:28.900675
374	58	booking	223	consumed	-1.00	4.00	3.00	Stock consumed for booking: BASUMATHI-RICE [1KG] (Qty: 1.0)	2026-06-03 03:39:40.574476	2026-06-03 03:39:40.574476
375	83	booking	224	consumed	-1.00	2.00	1.00	Stock consumed for booking: HONEY SMALL BHEE [150GM] (Qty: 1.0)	2026-06-03 03:42:16.094022	2026-06-03 03:42:16.094022
376	84	booking	224	consumed	-1.00	8.00	7.00	Stock consumed for booking: HONEY RAW [500ML] (Qty: 1.0)	2026-06-03 03:42:16.922009	2026-06-03 03:42:16.922009
377	89	booking	224	consumed	-1.00	5.00	4.00	Stock consumed for booking: GROUNDNUT OIL [5LTR] (Qty: 1.0)	2026-06-03 03:42:17.765133	2026-06-03 03:42:17.765133
378	44	booking	224	consumed	-1.00	5.00	4.00	Stock consumed for booking: MUSTARD OIL [1LTR] (Qty: 1.0)	2026-06-03 03:42:18.628572	2026-06-03 03:42:18.628572
379	45	booking	224	consumed	-1.00	4.00	3.00	Stock consumed for booking: SAFFLOWER OIL [1LTR] (Qty: 1.0)	2026-06-03 03:42:19.443228	2026-06-03 03:42:19.443228
380	99	booking	225	consumed	-1.00	314.00	313.00	Stock consumed for booking: zxxz (Qty: 1.0)	2026-06-03 11:45:41.790681	2026-06-03 11:45:41.790681
381	42	booking	225	consumed	-1.00	3.00	2.00	Stock consumed for booking: COCONUT OIL [1LTR] (Qty: 1.0)	2026-06-03 11:45:44.899865	2026-06-03 11:45:44.899865
382	42	booking	226	consumed	-1.00	2.00	1.00	Stock consumed for booking: COCONUT OIL [1LTR] (Qty: 1.0)	2026-06-03 12:58:32.11522	2026-06-03 12:58:32.11522
383	44	booking	227	consumed	-1.00	4.00	3.00	Stock consumed for booking: MUSTARD OIL [1LTR] (Qty: 1.0)	2026-06-03 15:48:36.729269	2026-06-03 15:48:36.729269
384	45	booking	228	consumed	-1.00	3.00	2.00	Stock consumed for booking: SAFFLOWER OIL [1LTR] (Qty: 1.0)	2026-06-03 16:02:08.693179	2026-06-03 16:02:08.693179
385	47	booking	228	consumed	-1.00	16.00	15.00	Stock consumed for booking: SONA MASURI RICE [1KG] (Qty: 1.0)	2026-06-03 16:02:09.468135	2026-06-03 16:02:09.468135
386	52	booking	228	consumed	-1.00	6.00	5.00	Stock consumed for booking: WHEAT-FLOUR-1KG (Qty: 1.0)	2026-06-03 16:02:10.236007	2026-06-03 16:02:10.236007
387	42	booking	229	consumed	-1.00	1.00	0.00	Stock consumed for booking: COCONUT OIL [1LTR] (Qty: 1.0)	2026-06-04 09:39:29.097209	2026-06-04 09:39:29.097209
388	37	booking	230	consumed	-1.00	1.00	0.00	Stock consumed for booking: DESI BUTTER [500GM] (Qty: 1.0)	2026-06-04 09:41:39.6922	2026-06-04 09:41:39.6922
389	84	booking	231	consumed	-1.00	7.00	6.00	Stock consumed for booking: HONEY RAW [500ML] (Qty: 1.0)	2026-06-04 11:08:15.39758	2026-06-04 11:08:15.39758
390	105	booking	232	consumed	-1.00	2.00	1.00	Stock consumed for booking: dsd (Qty: 1.0)	2026-06-04 12:18:07.492115	2026-06-04 12:18:07.492115
391	78	booking	232	consumed	-1.00	4.00	3.00	Stock consumed for booking: COW BUTTER [500GM] (Qty: 1.0)	2026-06-04 12:18:08.289205	2026-06-04 12:18:08.289205
392	55	booking	232	consumed	-1.00	5.00	4.00	Stock consumed for booking: DESI COW GHEE [300ML] (Qty: 1.0)	2026-06-04 12:18:09.088333	2026-06-04 12:18:09.088333
393	106	booking	233	consumed	-1.00	334.00	333.00	Stock consumed for booking: Raw (Qty: 1.0)	2026-06-04 12:46:38.848316	2026-06-04 12:46:38.848316
394	78	booking	234	consumed	-1.00	3.00	2.00	Stock consumed for booking: COW BUTTER [500GM] (Qty: 1.0)	2026-06-04 14:30:44.782348	2026-06-04 14:30:44.782348
395	78	booking	235	consumed	-1.00	2.00	1.00	Stock consumed for booking: COW BUTTER [500GM] (Qty: 1.0)	2026-06-04 14:31:26.21551	2026-06-04 14:31:26.21551
396	78	booking	236	consumed	-1.00	1.00	0.00	Stock consumed for booking: COW BUTTER [500GM] (Qty: 1.0)	2026-06-04 14:51:48.186315	2026-06-04 14:51:48.186315
397	89	booking	237	consumed	-1.00	4.00	3.00	Stock consumed for booking: GROUNDNUT OIL [5LTR] (Qty: 1.0)	2026-06-04 15:09:28.480039	2026-06-04 15:09:28.480039
398	55	booking	238	consumed	-8.00	10.00	2.00	Stock consumed for booking: DESI COW GHEE [300ML] (Qty: 8.0)	2026-06-06 09:47:31.073576	2026-06-06 09:47:31.073576
399	106	booking	239	consumed	-1.00	333.00	332.00	Stock consumed for booking: Raw (Qty: 1.0)	2026-06-06 10:16:13.104917	2026-06-06 10:16:13.104917
400	106	booking	239	consumed	-1.00	332.00	331.00	Stock consumed for booking: Raw (Qty: 1.0)	2026-06-06 10:16:13.875501	2026-06-06 10:16:13.875501
401	83	booking	240	consumed	-1.00	1.00	0.00	Stock consumed for booking: HONEY SMALL BHEE [150GM] (Qty: 1.0)	2026-06-07 04:52:08.957583	2026-06-07 04:52:08.957583
402	53	booking	240	consumed	-1.00	9.00	8.00	Stock consumed for booking: JAGGERY-POWDER-1KG (Qty: 1.0)	2026-06-07 04:52:09.746579	2026-06-07 04:52:09.746579
403	96	booking	240	consumed	-1.00	5.00	4.00	Stock consumed for booking: MOONGDAL [500GM] (Qty: 1.0)	2026-06-07 04:52:10.51742	2026-06-07 04:52:10.51742
\.


--
-- Data for Name: stock_transfers; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.stock_transfers (id, from_store_id, to_store_id, product_id, requested_by_id, approved_by_id, quantity, status, notes, rejection_reason, approved_at, completed_at, created_at, updated_at, product_variant_id, transfer_group_id) FROM stdin;
1	\N	13	58	106	1	1.00	completed	sd	\N	2026-05-17 09:48:45.095078	2026-05-17 09:48:45.095118	2026-05-17 09:45:43.693736	2026-05-17 09:48:45.09791	\N	\N
2	\N	13	59	106	1	2.00	completed		\N	2026-05-17 10:10:15.730228	2026-05-17 10:10:15.730285	2026-05-17 10:09:48.261066	2026-05-17 10:10:15.732097	\N	\N
5	\N	13	42	106	1	1.00	completed		\N	2026-05-17 10:16:49.873186	2026-05-17 10:16:49.873205	2026-05-17 10:15:36.954794	2026-05-17 10:16:49.874042	\N	\N
4	\N	13	81	106	1	1.00	completed		\N	2026-05-17 10:16:54.574714	2026-05-17 10:16:54.574728	2026-05-17 10:15:35.762579	2026-05-17 10:16:54.575371	\N	\N
3	\N	13	82	106	1	1.00	completed		\N	2026-05-17 10:17:00.256216	2026-05-17 10:17:00.256234	2026-05-17 10:15:34.594275	2026-05-17 10:17:00.256904	\N	\N
6	\N	13	78	106	1	2.00	completed		\N	2026-05-17 10:43:10.441547	2026-05-17 10:43:10.441587	2026-05-17 10:41:59.768304	2026-05-17 10:43:10.44388	\N	47a1fbc2-1334-4c7a-8ff6-cb69cd19aaa8
7	\N	13	55	106	1	2.00	completed		\N	2026-05-17 10:43:13.448901	2026-05-17 10:43:13.44893	2026-05-17 10:42:00.981947	2026-05-17 10:43:13.450221	\N	47a1fbc2-1334-4c7a-8ff6-cb69cd19aaa8
8	\N	13	105	106	1	1.00	completed		\N	2026-05-17 13:38:58.366385	2026-05-17 13:38:58.366404	2026-05-17 13:38:37.421376	2026-05-17 13:38:58.367314	9	08a5cac7-b9f6-4921-8b9f-662b14f4d8f4
9	\N	13	70	106	1	3.00	completed		\N	2026-05-17 13:38:59.137388	2026-05-17 13:38:59.137406	2026-05-17 13:38:37.739839	2026-05-17 13:38:59.138152	\N	08a5cac7-b9f6-4921-8b9f-662b14f4d8f4
10	\N	13	85	106	1	3.00	completed		\N	2026-05-25 04:46:46.879095	2026-05-25 04:46:46.879118	2026-05-25 04:46:16.591958	2026-05-25 04:46:46.881085	\N	27417cbc-a7ca-4dff-af01-4192ec55d6a2
11	\N	13	39	106	1	1.00	completed		\N	2026-05-25 04:46:48.012008	2026-05-25 04:46:48.012022	2026-05-25 04:46:16.958284	2026-05-25 04:46:48.01261	\N	27417cbc-a7ca-4dff-af01-4192ec55d6a2
\.


--
-- Data for Name: stores; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.stores (id, name, description, address, city, state, pincode, contact_person, contact_mobile, email, status, gst_no, created_at, updated_at, store_admin_user_id, admin_plain_password, auto_transfer_threshold, is_main_inventory, commission_percentage) FROM stdin;
3	store 1	sd	9898919191	kumra	karnataka	560085	9898919191	9898919191	\N	t	\N	2026-05-10 10:31:51.611605	2026-05-10 10:31:51.611605	\N	\N	10	f	0.00
4	store 1sdd	sd	9898919191	kumra	karnataka	560085	9898919191	9898919191	\N	t	\N	2026-05-10 10:31:59.971464	2026-05-10 10:31:59.971464	\N	\N	10	f	0.00
13	dsdsds	cds	dfd	Bangalore	karnataka	560068	pramod bhat	7817171717	\N	t	\N	2026-05-17 09:41:00.280605	2026-05-17 09:41:02.944391	106	EManSGst	10	f	0.00
\.


--
-- Data for Name: sub_agents; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.sub_agents (id, first_name, last_name, middle_name, email, mobile, password_digest, plain_password, original_password, role_id, gender, birth_date, pan_no, aadhar_no, gst_no, company_name, address, city, state, pincode, country, profile_picture, bank_name, account_no, ifsc_code, account_holder_name, account_type, upi_id, emergency_contact_name, emergency_contact_mobile, joining_date, salary, notes, status, distributor_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: subscription_templates; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.subscription_templates (id, customer_id, product_id, delivery_person_id, quantity, unit, price, delivery_time, is_active, template_name, notes, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: system_settings; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.system_settings (id, key, value, setting_type, description, default_main_agent_commission, default_affiliate_commission, default_ambassador_commission, default_company_expenses, created_at, updated_at, business_name, address, mobile, email, gstin, pan_number, account_holder_name, bank_name, account_number, ifsc_code, upi_id, qr_code_path, terms_and_conditions, collect_from_store_enabled, delivery_only_at_shop, shop_addresses, low_stock_alert_enabled, low_stock_alert_threshold, low_stock_alert_email) FROM stdin;
4	system_config	system configuration	configuration	System configuration settings	\N	\N	\N	\N	2026-03-25 04:49:08.920571	2026-05-10 09:53:30.256798	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	["abc,bcd"]	f	10	\N
3	business_config	business configuration	configuration	Business configuration settings	\N	\N	\N	\N	2026-03-25 04:49:06.327843	2026-06-06 11:31:05.747535	Marali Santhe	dfd	09190939393	9093939393fdfds@gmail.com			SBI	CNRB0003194	3194201000718	SBIN0001234	9632850872@ybl	/qr_codes/upi_qr_3.svg	Terms and condition 	\N	\N	\N	f	10	\N
\.


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.user_roles (id, name, description, active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.users (id, first_name, last_name, email, mobile, created_at, updated_at, middle_name, encrypted_password, user_type, role, role_id, status, is_active, is_verified, birth_date, gender, pan_no, aadhar_no, gst_no, company_name, address, city, state, pincode, country, profile_picture, bank_name, account_no, ifsc_code, account_holder_name, account_type, upi_id, emergency_contact_name, emergency_contact_mobile, department, designation, joining_date, salary, employee_id, reporting_manager_id, permissions, sidebar_permissions, last_login_at, login_count, email_verified_at, mobile_verified_at, two_factor_enabled, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, confirmation_token, confirmed_at, confirmation_sent_at, unlock_token, locked_at, failed_attempts, notes, created_by, updated_by, deleted_at, original_password, authenticatable_type, authenticatable_id, assigned_store_id, store_permissions, last_store_access) FROM stdin;
11	rajesh	ar	raj@gmail.com	9879879879	2026-02-22 02:23:10.503634	2026-02-22 02:23:10.503634		$2a$12$sEdCu6/LX.q3q1DfgKVqUOXOYay1MnQj5.IME1NNERLAi1cdEO3.u	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	123 Main Street, Apartment 4B	Mumbai	Maharashtra	400001	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
13	pramod	bhat	pramsddodbha8@gmail.com	9190939300	2026-02-22 06:28:33.603929	2026-02-22 06:28:33.603929	\N	$2a$12$b52KqulR5.Y1W065fax.le3bVlZShS6vXq0Sgso/J01skDp8w8bOC	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N		Unknown	Unknown	000000	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2	Test	User	test1771316179@example.com	#{Time.current.to_i}	2026-02-17 08:16:27.928046	2026-02-17 08:16:27.928046	\N	$2a$12$lcuFV/t5i17Ijx20z7YD2.vIEewChdDTJw9g8DqWp7EOy7pFjaFmi	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4	Test Franchise Store	Franchise	franchise1@example.com	9876543210	2026-02-18 11:15:49.981965	2026-02-18 11:15:49.981965	\N	$2a$12$gCpRxuZtV8mXWz36cqp9G.4h.f818IwM40xv0wTHfLlMNR5fH7ig6	franchise	super_admin	1	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
3	Test	Flash	testflash@example.com	8888888888	2026-02-17 09:20:32.118752	2026-02-19 07:01:33.8557	\N	$2a$12$W8MTCiUpdLYRKFNNINnDJOWUWkTHKYevDzpNcP3/oTzRfZ/BvhJZG	admin	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	["delivery_people"]	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5	Test	Customer	assasa@gmail.com	9393939393	2026-02-20 13:38:06.84574	2026-02-20 13:38:06.84574	Mobile	$2a$12$3SW.vAWgdHxGNvigekyuVOhY/VH2JNYVrgr./kf1Ru3kzit8oM1hu	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	123 Test Street, Test Area	Mumbai	Maharashtra	400001	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6	Test	Customer	asseasa@gmail.com	9393939313	2026-02-21 02:39:16.334135	2026-02-21 02:39:16.334135	Mobile	$2a$12$dHpp7OPaWd/NCVCFZXzaO.Ldte9h//GsT4t06aOJC81smlQU/BJ1O	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	123 Test Street, Test Area	Mumbai	Maharashtra	400001	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7	TestFixed	Customer	testfixed@example.com	9876543212	2026-02-21 02:43:48.821806	2026-02-21 02:43:48.821806	Web	$2a$12$wmi5NYGLdTJZMuhsAl9OKOX5pl4JfdLW33DtTVhScbfmQu9KizfWG	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	Test Address	Unknown	Unknown	000000	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9	Manjunath	Bhat	sagar_mopagar@gmail.com	9900503118	2026-02-21 09:49:29.65782	2026-02-21 09:49:29.65782	\N	$2a$12$NC31BVw0f9R.2Sq9XDKTme6ElW01vO/a4iKXTgLREgVMGWma3QeZq	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N		Unknown	Unknown	000000	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
78	Ram	Bhat	prdddamodbha8@gmail.com	8292929292	2026-03-08 09:47:35.523284	2026-03-08 09:47:35.523284	\N	$2a$12$ike9pBLPOr37zcFN5xiFe.arSMGe1NevgbMsNIHdmERxDtnS8WY.C	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	dfd	Unknown	Unknown	000000	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
80	Javeed	Patel	maralisanthe@gmail.com	917975918232	2026-03-20 07:59:01.955945	2026-03-20 07:59:01.955945	\N	$2a$12$prc0D8/AfMOuhJDAEwS9NOTmPxT3hX9hTlRryFmbSTf6yijE56vga	delivery_person	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	NR colony Bangalore	Bangalore	Karnataka	560004	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1	Admin	User	admin@maralisanthe.com	9999999999	2026-02-12 11:39:37.772197	2026-03-07 13:35:08.66239	\N	$2a$12$F3y6NUiRv9pvLpslJGXiFuiPkhB5QPVd5j4vpVdPmadgq8rHF0I52	admin	admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	{"dashboard":{"view":true,"create":true,"edit":true,"delete":true},"bookings":{"view":true,"create":true,"edit":true,"delete":true},"stores":{"view":true,"create":true,"edit":true,"delete":true},"customer_formats":{"view":true,"create":true,"edit":true,"delete":true},"subscriptions":{"view":true,"create":true,"edit":true,"delete":true},"invoices":{"view":true,"create":true,"edit":true,"delete":true},"notes":{"view":true,"create":true,"edit":true,"delete":true},"pending_amounts":{"view":true,"create":true,"edit":true,"delete":true},"invoice_check":{"view":true,"create":true,"edit":true,"delete":true},"vendors":{"view":true,"create":true,"edit":true,"delete":true},"vendor_purchases":{"view":true,"create":true,"edit":true,"delete":true},"customers":{"view":true,"create":true,"edit":true,"delete":true},"categories":{"view":true,"create":true,"edit":true,"delete":true},"products":{"view":true,"create":true,"edit":true,"delete":true},"coupons":{"view":true,"create":true,"edit":true,"delete":true},"customer_wallets":{"view":true,"create":true,"edit":true,"delete":true},"franchises":{"view":true,"create":true,"edit":true,"delete":true},"affiliates":{"view":true,"create":true,"edit":true,"delete":true},"subscription_templates":{"view":true,"create":true,"edit":true,"delete":true},"delivery_people":{"view":true,"create":true,"edit":true,"delete":true},"imports":{"view":true,"create":true,"edit":true,"delete":true},"reports":{"view":true,"create":true,"edit":true,"delete":true},"system_settings":{"view":true,"create":true,"edit":true,"delete":true},"user_roles":{"view":true,"create":true,"edit":true,"delete":true},"banners":{"view":true,"create":true,"edit":true,"delete":true},"client_requests":{"view":true,"create":true,"edit":true,"delete":true},"helpdesk":{"view":true,"create":true,"edit":true,"delete":true},"users":{"view":true,"create":true,"edit":true,"delete":true},"leads":{"view":true,"create":true,"edit":true,"delete":true},"life_insurance":{"view":true,"create":true,"edit":true,"delete":true},"health_insurance":{"view":true,"create":true,"edit":true,"delete":true},"motor_insurance":{"view":true,"create":true,"edit":true,"delete":true},"other_insurance":{"view":true,"create":true,"edit":true,"delete":true},"roles":{"view":true,"create":true,"edit":true,"delete":true},"settings":{"view":true,"create":true,"edit":true,"delete":true},"referrals":{"view":true,"create":true,"edit":true,"delete":true}}	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
81	Pramod Test	Bhat	pramodbha8@gmail.com	9632850872	2026-04-17 10:42:04.294342	2026-04-17 10:42:04.294342	\N	$2a$12$UXbKKd5sIkgQqmYeFDkrMuS2gte37dq0ubnaVIqbxdqPf/vs3tQ76	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
83	John	Doe	johdn.doe@example.com	9876543010	2026-05-02 07:19:22.975151	2026-05-02 07:19:22.975151	\N	$2a$12$8mAMndxGG3EltrDpS7ptfOsio11/TEOL/OhHW9ShzRagXMiOy8Ftm	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
84	Rajesh	Raj	raj3@gmail.com	9879879871	2026-05-02 10:26:17.04101	2026-05-02 10:26:17.04101	\N	$2a$12$f.6cQSY/q.rjbaEFmF.y2eR1l/Bv6PUoiRAVdeK86c9jJsqjRfuJC	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
85	Test	Customer	testcustomer@example.com	9876043210	2026-05-03 05:02:28.742608	2026-05-03 05:02:28.742608	\N	$2a$12$gPJN0/Sy0ellJSFTp/518eMo2r3vyeFf6YIjH0dzKq4s00F9WqhSS	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
86	Bdbhd	Nxn	pramodbha87@gmail.com	9632850870	2026-05-03 10:01:26.055139	2026-05-03 10:01:26.055139	\N	$2a$12$WoYEiLtuUgEJn9Iw9U7HsOjJOmfTDeMEORfuFGQD5Q3mGIwLEBs1e	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
87	Ncnf	Ffnn	pramodbha8dh@gmail.com	9632626265	2026-05-03 11:02:05.292635	2026-05-03 11:02:05.292635	\N	$2a$12$Avx4vj7lkFEQmdzqA0.SfOxHRrYMd7w9JzZjoNzjmuMb4R9MbY8bm	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
89	pramod	bhat	9093939393fdfds@gmail.com	09190939393	2026-05-09 11:43:23.478457	2026-05-09 11:43:23.478457	\N	$2a$12$cAjdNCoM8V63Rg/kbwubtuYH3KG53dBasbesJhJsre4iysChEPkC.	affiliate	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	Affiliate	12	\N	\N	\N
92	sdfdd	dsdsfdsd	dfsfdfdsfdsfds9093939393fdfds@gmail.com	09190939001	2026-05-09 12:57:10.144622	2026-05-09 12:57:10.144622	\N	$2a$12$TJ.gYuLWu.XSIDlFjWz5iOkMlMryYn0/dZW8/80cMj93HTUeX8Cu2	franchise	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	dsdsfdsd	sdfa	Bangalore	karnataka	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
93	aadad	aadad	9093939sdsd393fdfds@gmail.com	+91 98099 80101	2026-05-10 05:28:18.494809	2026-05-10 05:28:18.494809	\N	$2a$12$OseAO.l6zD0YMdodU9010eWdEaqJTMvbylGf7VGxCt.OKvzTZGKVG	franchise	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	aadad	sasa	Bangalore	karnataka	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
94	Eeuhhhj	Ggbbvh	hah@gmail.com	9632859632	2026-05-10 07:10:23.913988	2026-05-10 07:10:23.913988	\N	$2a$12$SEsJuUiNretE6Knq89aPte3YOs9MPahOmY3hBNCoAAd070sauNwcS	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
97	abc@gmail.com	aa	abc@gmail.com	+91 98989 89898	2026-05-17 09:13:22.004108	2026-05-17 09:13:22.004108	\N	$2a$12$MxraQnqEXBULcjTTs9OQu.F7GIxCvMAu5Q6cvVuYr8zn6keYWrCde	store_admin	super_admin	\N	t	t	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	{"dashboard":{"view":true},"bookings":{"view":true,"create":true,"update":true},"expenses":{"view":true,"create":true,"update":true,"delete":true},"inventory":{"view":true,"create":true,"update":true},"stock_transfers":{"view":true,"create":true}}	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	4	{"can_manage_inventory":true,"can_create_bookings":true,"can_view_reports":true,"can_request_transfers":true}	\N
79	Javeed	Patel	raghubit040@gmail.com	919663838730	2026-03-08 11:32:15.894369	2026-06-03 12:48:57.258864	\N	$2a$12$GogsiCWsW5dZIbWldnxGWO5UN2g15JdJo7BaauTE3czXSNYdDClwu	delivery_person	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	NR colony 	Bangalore	Karnataka	560004	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
88	Raghu	Kt	raghukt.shetty89@gmail.com	9035408833	2026-05-04 10:46:16.790091	2026-06-03 12:56:27.197023	\N	$2a$12$ms8c6R8uO9Ebh2XBA4xcru/uS7Vib7ppQbArl2yRLr.mG2G/zVwcG	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
98	abc@gmail.com	df	a122bc@gmail.com	+91 98989 09090	2026-05-17 09:13:43.958295	2026-05-17 09:13:43.958295	\N	$2a$12$wiPSPizVk3n6xnlGw03AsOhCGWZdYAq62sTYslHmkvck5E0fnrFg2	store_admin	super_admin	\N	t	t	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	{"dashboard":{"view":true},"bookings":{"view":true,"create":true,"update":true},"expenses":{"view":true,"create":true,"update":true,"delete":true},"inventory":{"view":true,"create":true,"update":true},"stock_transfers":{"view":true,"create":true}}	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	4	{"can_manage_inventory":true,"can_create_bookings":true,"can_view_reports":true,"can_request_transfers":true}	\N
99	assa	sa	9093939393fdasfds@gmail.com	+91 91010 10101	2026-05-17 09:14:09.720863	2026-05-17 09:14:09.720863	\N	$2a$12$Dv4sZ5U9KgzU22bHtAowJeq93.xmVktE3l.VjZIAi1AY4BtGmgnxu	store_admin	super_admin	\N	t	t	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	{"dashboard":{"view":true},"bookings":{"view":true,"create":true,"update":true},"expenses":{"view":true,"create":true,"update":true,"delete":true},"inventory":{"view":true,"create":true,"update":true},"stock_transfers":{"view":true,"create":true}}	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	4	{"can_manage_inventory":true,"can_create_bookings":true,"can_view_reports":true,"can_request_transfers":true}	\N
106	Amit	Nair	admin.dsdsds8698@store.local	7118955214	2026-05-17 09:41:01.612666	2026-05-17 09:41:01.612666	\N	$2a$12$6qw4CZcBB4Xyv90EzTNLAuN/rTiH0.wK2PpULjWowCHjbhz6qTsFa	store_admin	super_admin	\N	t	t	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	{"dashboard":{"view":true},"bookings":{"view":true,"create":true,"update":true},"expenses":{"view":true,"create":true,"update":true,"delete":true},"inventory":{"view":true,"create":true,"update":true},"stock_transfers":{"view":true,"create":true}}	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	13	{"can_manage_inventory":true,"can_create_bookings":true,"can_view_reports":true,"can_request_transfers":true}	\N
107	Ndnd	Jdnd	smarr@gmail.com	9632569686	2026-05-25 05:07:07.947844	2026-05-25 05:07:07.947844	\N	$2a$12$bqX1h9RPcJMblDEnoleC0ufmh7LH5pEehhEQAJRsWHfNKEDjXO8mS	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
108	Hdu	Sjj	test-customer@gmail.com	9632859639	2026-06-02 10:49:33.515758	2026-06-02 10:49:33.515758	\N	$2a$12$qpWKeq2fc9n9/L7XET6A2OknHuN89CsULWhNurIqjFfB/.exIZCSe	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
109	Raghu	Shetty	meghana.siddaraju97@gmail.com	9880393831	2026-06-03 05:38:51.422417	2026-06-03 05:38:51.422417	\N	$2a$12$VCJ6FpoLTmFKLp/VrsZMR.UB91z30jVJG4en4mD29sMFo26dDdKVq	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
110	Egh	Eh	abcabc@gmail.com	9696969696	2026-06-03 07:04:29.29052	2026-06-03 07:04:29.29052	\N	$2a$12$ALZ8zr.PeeaV8K3NfjSkKOUKB8LK/Elyqi.ONCJ22DfVXumzhdSTe	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
111	Venu	Bhat	venubha147@gmail.com	9606889562	2026-06-03 09:44:42.849666	2026-06-03 10:36:28.558228	\N	$2a$12$ZBUdNccOHm8LGJZu.rG/DOvSwwbKrTaHEVVJ6S4WljbDX8yYeYHrO	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
112	Bdhd	Bddjj	venubha1477@gmail.com	9632850875	2026-06-03 10:38:25.073942	2026-06-03 10:38:25.073942	\N	$2a$12$UErPLYrYHa2oU3RTltcdoeGTPaqfzfNY7q.JFlXSUHwT/WytHtV2i	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
113	Lakshmi	K T	kt.laxmi87@gmail.com	9743766433	2026-06-03 15:16:54.375269	2026-06-03 15:16:54.375269	\N	$2a$12$/oGCuwKKfheiA1yvnUp6a.zJeOG5qZv96FZt1K7V2jufH7djCO5eS	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
114	Rajesh	Bit	rajeshkbit@gmail.com	9980325999	2026-06-03 15:44:21.166681	2026-06-03 15:44:21.166681	\N	$2a$12$PNpQHt7QilQVhsUywPbV1.JXjOCCsQREuCj12XgpNAXguRkCSBJhO	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
115	Neethu	Shree	neethushreeneethushree005@gmail.com	9900770296	2026-06-03 15:46:01.178001	2026-06-03 15:46:01.178001	\N	$2a$12$CnYwOyX/EQDXCD66yq2mh.TrQF5wzRiQckcjXkH2l6R9trzw9XGT.	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
116	Raghavendra	RBN	raghavendra.rbn059@gmail.com	9663095152	2026-06-03 17:12:17.682848	2026-06-03 17:12:17.682848	\N	$2a$12$5IP1j2EUjWoP8HMf/EcVBemxPM5FtWY9dx/RBA9sMrKtM5qtFOGze	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
117	Doddabasayya	Am	doddabasayyaa@gmail.com	8884630173	2026-06-04 05:38:23.268295	2026-06-04 05:38:23.268295	\N	$2a$12$DsJTaUtLd/4Z8hqzc5oO0euo3B3eckrMJt9RWc7ERkjmE6Q2DjKv.	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
118	Dhiraj	Raj	racerdhiraj123@gmail.com	7619128988	2026-06-04 10:53:29.624563	2026-06-04 10:53:29.624563	\N	$2a$12$sk45/0/53vH8xnAjrV30wukeo705wL11JATz/Xu3MndEHOTPfWtvm	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
119	NAVEEN	NAVEEN	naveengowdapr@gmail.com	7019218203	2026-06-04 13:01:02.613661	2026-06-04 13:01:02.613661	\N	$2a$12$6zRO9MF5gAShAHJe0S2LSO63PWhUwCqVEZWdH1xRHAEynFwZoPWo2	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
120	Kp	Mdy	raghave32kp@gmail.com	9035109925	2026-06-05 04:24:36.250909	2026-06-05 04:24:36.250909	\N	$2a$12$Or9JUmJ/JdTe8q7IbqY3auKfab29jH3gCEMjGbRusdgnclPYppYkK	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
121	Jayasudha	Raj	jayasudharaj54@gmaii.com	9880753433	2026-06-06 10:45:41.519787	2026-06-06 10:45:41.519787	\N	$2a$12$wJyA69j2.jXlDL15xKOE8e2q..BcqfPEhZ5og/oPMIdcvDCtSR6Ny	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
122	Sreenivasa	Thimmaiah	sreenidsport@gmail.com	9845691412	2026-06-07 04:19:59.101218	2026-06-07 04:19:59.101218	\N	$2a$12$9oJtVolBswt2.MblK5WSLOAJtVdSZIpIn/ivedCFu9HC0putUHUCm	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
123	Yamuna	Patil	yamunapatill@gmail.com	9880898802	2026-06-08 04:52:57.483579	2026-06-08 04:52:57.483579	\N	$2a$12$JKMRV8mlKIo829sK2Lh30umcf/ayyyxW6magC3LEBa7F7od26IM7O	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: vendor_invoices; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.vendor_invoices (id, vendor_purchase_id, invoice_number, total_amount, status, invoice_date, share_token, notes, created_at, updated_at) FROM stdin;
3	11	VI20260326-0001	46.0	1	2026-03-26	AEfT0PcWVJaJtc7PmF6WAzEzLHlsUca3o4Vb7ehBfo0	Invoice generated for vendor purchase #VP000011	2026-03-26 06:47:28.932104	2026-03-26 06:47:28.932104
4	12	VI20260326-0002	12.0	1	2026-03-26	V2XhkXqkVCocLtkav8p5EziUXWHqtA1ak_6tvHcQV-8	Invoice generated for vendor purchase #VP000012	2026-03-26 07:20:44.720248	2026-03-26 07:20:44.720248
\.


--
-- Data for Name: vendor_payments; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.vendor_payments (id, vendor_id, vendor_purchase_id, amount_paid, payment_date, payment_mode, notes, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: vendor_purchase_items; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.vendor_purchase_items (id, vendor_purchase_id, product_id, quantity, purchase_price, selling_price, line_total, created_at, updated_at) FROM stdin;
11	11	37	2.0	23.0	455.0	46.0	2026-03-26 06:45:46.787441	2026-03-26 06:45:46.787441
12	12	42	3.0	4.0	344.0	12.0	2026-03-26 07:19:47.428106	2026-03-26 07:19:47.428106
\.


--
-- Data for Name: vendor_purchases; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.vendor_purchases (id, vendor_id, purchase_date, total_amount, paid_amount, status, notes, created_at, updated_at) FROM stdin;
11	11	2026-03-26	46.0	46.0	completed	sd	2026-03-26 06:45:46.532347	2026-03-26 06:47:52.737148
12	11	2026-03-26	12.0	0.0	completed	sd	2026-03-26 07:19:45.714883	2026-03-26 07:20:11.425749
\.


--
-- Data for Name: vendors; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.vendors (id, name, phone, email, address, payment_type, opening_balance, status, created_at, updated_at) FROM stdin;
11	System Default	0000000000	system@default.com	System Generated	Cash	\N	t	2026-03-19 08:25:49.567116	2026-03-19 08:25:49.567116
\.


--
-- Data for Name: wallet_transactions; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.wallet_transactions (id, customer_wallet_id, transaction_type, amount, balance_after, description, reference_number, metadata, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: wishlists; Type: TABLE DATA; Schema: public; Owner: marlai_santhe_002_user
--

COPY public.wishlists (id, customer_id, product_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.active_storage_attachments_id_seq', 26, true);


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.active_storage_blobs_id_seq', 26, true);


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.active_storage_variant_records_id_seq', 1, false);


--
-- Name: affiliates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.affiliates_id_seq', 12, true);


--
-- Name: banners_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.banners_id_seq', 6, true);


--
-- Name: booking_invoices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.booking_invoices_id_seq', 39, true);


--
-- Name: booking_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.booking_items_id_seq', 301, true);


--
-- Name: booking_schedules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.booking_schedules_id_seq', 1, false);


--
-- Name: bookings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.bookings_id_seq', 240, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.categories_id_seq', 15, true);


--
-- Name: client_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.client_requests_id_seq', 6, true);


--
-- Name: coupons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.coupons_id_seq', 1, false);


--
-- Name: customer_addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.customer_addresses_id_seq', 7, true);


--
-- Name: customer_formats_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.customer_formats_id_seq', 320, true);


--
-- Name: customer_wallets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.customer_wallets_id_seq', 1, false);


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.customers_id_seq', 575, true);


--
-- Name: delivery_charges_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.delivery_charges_id_seq', 8, true);


--
-- Name: delivery_people_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.delivery_people_id_seq', 17, true);


--
-- Name: delivery_rules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.delivery_rules_id_seq', 102, true);


--
-- Name: device_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.device_tokens_id_seq', 1, false);


--
-- Name: expenses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.expenses_id_seq', 1, true);


--
-- Name: franchises_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.franchises_id_seq', 12, true);


--
-- Name: invoice_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.invoice_items_id_seq', 414, true);


--
-- Name: invoices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.invoices_id_seq', 323, true);


--
-- Name: leads_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.leads_id_seq', 1, false);


--
-- Name: milk_delivery_tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.milk_delivery_tasks_id_seq', 9463, true);


--
-- Name: milk_subscriptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.milk_subscriptions_id_seq', 335, true);


--
-- Name: notes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.notes_id_seq', 28, true);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.notifications_id_seq', 1, false);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.order_items_id_seq', 1, false);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.orders_id_seq', 1, false);


--
-- Name: pending_amounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.pending_amounts_id_seq', 32, true);


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.permissions_id_seq', 1, false);


--
-- Name: product_ratings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.product_ratings_id_seq', 1, false);


--
-- Name: product_reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.product_reviews_id_seq', 1, false);


--
-- Name: product_variants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.product_variants_id_seq', 12, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.products_id_seq', 106, true);


--
-- Name: referrals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.referrals_id_seq', 8, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.roles_id_seq', 7, true);


--
-- Name: sale_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.sale_items_id_seq', 37, true);


--
-- Name: solid_cache_entries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.solid_cache_entries_id_seq', 289, true);


--
-- Name: solid_queue_blocked_executions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.solid_queue_blocked_executions_id_seq', 1, false);


--
-- Name: solid_queue_claimed_executions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.solid_queue_claimed_executions_id_seq', 1, false);


--
-- Name: solid_queue_failed_executions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.solid_queue_failed_executions_id_seq', 1, false);


--
-- Name: solid_queue_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.solid_queue_jobs_id_seq', 37, true);


--
-- Name: solid_queue_pauses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.solid_queue_pauses_id_seq', 1, false);


--
-- Name: solid_queue_processes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.solid_queue_processes_id_seq', 1, false);


--
-- Name: solid_queue_ready_executions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.solid_queue_ready_executions_id_seq', 37, true);


--
-- Name: solid_queue_recurring_executions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.solid_queue_recurring_executions_id_seq', 1, false);


--
-- Name: solid_queue_recurring_tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.solid_queue_recurring_tasks_id_seq', 1, false);


--
-- Name: solid_queue_scheduled_executions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.solid_queue_scheduled_executions_id_seq', 1, false);


--
-- Name: solid_queue_semaphores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.solid_queue_semaphores_id_seq', 1, false);


--
-- Name: stock_batches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.stock_batches_id_seq', 118, true);


--
-- Name: stock_movements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.stock_movements_id_seq', 403, true);


--
-- Name: stock_transfers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.stock_transfers_id_seq', 11, true);


--
-- Name: stores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.stores_id_seq', 13, true);


--
-- Name: sub_agents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.sub_agents_id_seq', 1, false);


--
-- Name: subscription_templates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.subscription_templates_id_seq', 1, false);


--
-- Name: system_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.system_settings_id_seq', 4, true);


--
-- Name: user_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.user_roles_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.users_id_seq', 123, true);


--
-- Name: vendor_invoices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.vendor_invoices_id_seq', 4, true);


--
-- Name: vendor_payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.vendor_payments_id_seq', 1, false);


--
-- Name: vendor_purchase_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.vendor_purchase_items_id_seq', 12, true);


--
-- Name: vendor_purchases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.vendor_purchases_id_seq', 12, true);


--
-- Name: vendors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.vendors_id_seq', 11, true);


--
-- Name: wallet_transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.wallet_transactions_id_seq', 1, false);


--
-- Name: wishlists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marlai_santhe_002_user
--

SELECT pg_catalog.setval('public.wishlists_id_seq', 1, false);


--
-- Name: active_storage_attachments active_storage_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT active_storage_attachments_pkey PRIMARY KEY (id);


--
-- Name: active_storage_blobs active_storage_blobs_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.active_storage_blobs
    ADD CONSTRAINT active_storage_blobs_pkey PRIMARY KEY (id);


--
-- Name: active_storage_variant_records active_storage_variant_records_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT active_storage_variant_records_pkey PRIMARY KEY (id);


--
-- Name: affiliates affiliates_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.affiliates
    ADD CONSTRAINT affiliates_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: banners banners_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.banners
    ADD CONSTRAINT banners_pkey PRIMARY KEY (id);


--
-- Name: booking_invoices booking_invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.booking_invoices
    ADD CONSTRAINT booking_invoices_pkey PRIMARY KEY (id);


--
-- Name: booking_items booking_items_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.booking_items
    ADD CONSTRAINT booking_items_pkey PRIMARY KEY (id);


--
-- Name: booking_schedules booking_schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.booking_schedules
    ADD CONSTRAINT booking_schedules_pkey PRIMARY KEY (id);


--
-- Name: bookings bookings_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: client_requests client_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.client_requests
    ADD CONSTRAINT client_requests_pkey PRIMARY KEY (id);


--
-- Name: coupons coupons_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.coupons
    ADD CONSTRAINT coupons_pkey PRIMARY KEY (id);


--
-- Name: customer_addresses customer_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.customer_addresses
    ADD CONSTRAINT customer_addresses_pkey PRIMARY KEY (id);


--
-- Name: customer_formats customer_formats_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.customer_formats
    ADD CONSTRAINT customer_formats_pkey PRIMARY KEY (id);


--
-- Name: customer_wallets customer_wallets_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.customer_wallets
    ADD CONSTRAINT customer_wallets_pkey PRIMARY KEY (id);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: delivery_charges delivery_charges_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.delivery_charges
    ADD CONSTRAINT delivery_charges_pkey PRIMARY KEY (id);


--
-- Name: delivery_people delivery_people_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.delivery_people
    ADD CONSTRAINT delivery_people_pkey PRIMARY KEY (id);


--
-- Name: delivery_rules delivery_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.delivery_rules
    ADD CONSTRAINT delivery_rules_pkey PRIMARY KEY (id);


--
-- Name: device_tokens device_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.device_tokens
    ADD CONSTRAINT device_tokens_pkey PRIMARY KEY (id);


--
-- Name: expenses expenses_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_pkey PRIMARY KEY (id);


--
-- Name: franchises franchises_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.franchises
    ADD CONSTRAINT franchises_pkey PRIMARY KEY (id);


--
-- Name: invoice_items invoice_items_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.invoice_items
    ADD CONSTRAINT invoice_items_pkey PRIMARY KEY (id);


--
-- Name: invoices invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_pkey PRIMARY KEY (id);


--
-- Name: leads leads_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.leads
    ADD CONSTRAINT leads_pkey PRIMARY KEY (id);


--
-- Name: milk_delivery_tasks milk_delivery_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.milk_delivery_tasks
    ADD CONSTRAINT milk_delivery_tasks_pkey PRIMARY KEY (id);


--
-- Name: milk_subscriptions milk_subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.milk_subscriptions
    ADD CONSTRAINT milk_subscriptions_pkey PRIMARY KEY (id);


--
-- Name: notes notes_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: pending_amounts pending_amounts_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.pending_amounts
    ADD CONSTRAINT pending_amounts_pkey PRIMARY KEY (id);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- Name: product_ratings product_ratings_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.product_ratings
    ADD CONSTRAINT product_ratings_pkey PRIMARY KEY (id);


--
-- Name: product_reviews product_reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.product_reviews
    ADD CONSTRAINT product_reviews_pkey PRIMARY KEY (id);


--
-- Name: product_variants product_variants_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.product_variants
    ADD CONSTRAINT product_variants_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: referrals referrals_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.referrals
    ADD CONSTRAINT referrals_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: sale_items sale_items_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.sale_items
    ADD CONSTRAINT sale_items_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: solid_cache_entries solid_cache_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.solid_cache_entries
    ADD CONSTRAINT solid_cache_entries_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_blocked_executions solid_queue_blocked_executions_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.solid_queue_blocked_executions
    ADD CONSTRAINT solid_queue_blocked_executions_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_claimed_executions solid_queue_claimed_executions_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.solid_queue_claimed_executions
    ADD CONSTRAINT solid_queue_claimed_executions_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_failed_executions solid_queue_failed_executions_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.solid_queue_failed_executions
    ADD CONSTRAINT solid_queue_failed_executions_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_jobs solid_queue_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.solid_queue_jobs
    ADD CONSTRAINT solid_queue_jobs_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_pauses solid_queue_pauses_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.solid_queue_pauses
    ADD CONSTRAINT solid_queue_pauses_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_processes solid_queue_processes_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.solid_queue_processes
    ADD CONSTRAINT solid_queue_processes_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_ready_executions solid_queue_ready_executions_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.solid_queue_ready_executions
    ADD CONSTRAINT solid_queue_ready_executions_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_recurring_executions solid_queue_recurring_executions_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.solid_queue_recurring_executions
    ADD CONSTRAINT solid_queue_recurring_executions_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_recurring_tasks solid_queue_recurring_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.solid_queue_recurring_tasks
    ADD CONSTRAINT solid_queue_recurring_tasks_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_scheduled_executions solid_queue_scheduled_executions_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.solid_queue_scheduled_executions
    ADD CONSTRAINT solid_queue_scheduled_executions_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_semaphores solid_queue_semaphores_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.solid_queue_semaphores
    ADD CONSTRAINT solid_queue_semaphores_pkey PRIMARY KEY (id);


--
-- Name: stock_batches stock_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.stock_batches
    ADD CONSTRAINT stock_batches_pkey PRIMARY KEY (id);


--
-- Name: stock_movements stock_movements_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.stock_movements
    ADD CONSTRAINT stock_movements_pkey PRIMARY KEY (id);


--
-- Name: stock_transfers stock_transfers_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.stock_transfers
    ADD CONSTRAINT stock_transfers_pkey PRIMARY KEY (id);


--
-- Name: stores stores_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.stores
    ADD CONSTRAINT stores_pkey PRIMARY KEY (id);


--
-- Name: sub_agents sub_agents_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.sub_agents
    ADD CONSTRAINT sub_agents_pkey PRIMARY KEY (id);


--
-- Name: subscription_templates subscription_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.subscription_templates
    ADD CONSTRAINT subscription_templates_pkey PRIMARY KEY (id);


--
-- Name: system_settings system_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.system_settings
    ADD CONSTRAINT system_settings_pkey PRIMARY KEY (id);


--
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: vendor_invoices vendor_invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.vendor_invoices
    ADD CONSTRAINT vendor_invoices_pkey PRIMARY KEY (id);


--
-- Name: vendor_payments vendor_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.vendor_payments
    ADD CONSTRAINT vendor_payments_pkey PRIMARY KEY (id);


--
-- Name: vendor_purchase_items vendor_purchase_items_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.vendor_purchase_items
    ADD CONSTRAINT vendor_purchase_items_pkey PRIMARY KEY (id);


--
-- Name: vendor_purchases vendor_purchases_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.vendor_purchases
    ADD CONSTRAINT vendor_purchases_pkey PRIMARY KEY (id);


--
-- Name: vendors vendors_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.vendors
    ADD CONSTRAINT vendors_pkey PRIMARY KEY (id);


--
-- Name: wallet_transactions wallet_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.wallet_transactions
    ADD CONSTRAINT wallet_transactions_pkey PRIMARY KEY (id);


--
-- Name: wishlists wishlists_pkey; Type: CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.wishlists
    ADD CONSTRAINT wishlists_pkey PRIMARY KEY (id);


--
-- Name: idx_milk_subscriptions_dates; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX idx_milk_subscriptions_dates ON public.milk_subscriptions USING btree (start_date, end_date);


--
-- Name: idx_milk_subscriptions_status; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX idx_milk_subscriptions_status ON public.milk_subscriptions USING btree (status);


--
-- Name: idx_on_delivery_person_id_delivery_date_8b580f1b82; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX idx_on_delivery_person_id_delivery_date_8b580f1b82 ON public.milk_delivery_tasks USING btree (delivery_person_id, delivery_date);


--
-- Name: idx_stock_movements_created_at; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX idx_stock_movements_created_at ON public.stock_movements USING btree (created_at);


--
-- Name: idx_stock_movements_movement_type; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX idx_stock_movements_movement_type ON public.stock_movements USING btree (movement_type);


--
-- Name: idx_stock_movements_product_created; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX idx_stock_movements_product_created ON public.stock_movements USING btree (product_id, created_at);


--
-- Name: idx_stock_movements_product_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX idx_stock_movements_product_id ON public.stock_movements USING btree (product_id);


--
-- Name: idx_stock_movements_ref_type_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX idx_stock_movements_ref_type_id ON public.stock_movements USING btree (reference_type, reference_id);


--
-- Name: index_active_storage_attachments_on_blob_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_active_storage_attachments_on_blob_id ON public.active_storage_attachments USING btree (blob_id);


--
-- Name: index_active_storage_attachments_uniqueness; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_active_storage_attachments_uniqueness ON public.active_storage_attachments USING btree (record_type, record_id, name, blob_id);


--
-- Name: index_active_storage_blobs_on_key; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_active_storage_blobs_on_key ON public.active_storage_blobs USING btree (key);


--
-- Name: index_active_storage_variant_records_uniqueness; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_active_storage_variant_records_uniqueness ON public.active_storage_variant_records USING btree (blob_id, variation_digest);


--
-- Name: index_affiliates_on_email; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_affiliates_on_email ON public.affiliates USING btree (email);


--
-- Name: index_affiliates_on_mobile; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_affiliates_on_mobile ON public.affiliates USING btree (mobile);


--
-- Name: index_banners_on_display_location; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_banners_on_display_location ON public.banners USING btree (display_location);


--
-- Name: index_banners_on_display_order; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_banners_on_display_order ON public.banners USING btree (display_order);


--
-- Name: index_banners_on_status; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_banners_on_status ON public.banners USING btree (status);


--
-- Name: index_booking_invoices_on_booking_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_booking_invoices_on_booking_id ON public.booking_invoices USING btree (booking_id);


--
-- Name: index_booking_invoices_on_customer_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_booking_invoices_on_customer_id ON public.booking_invoices USING btree (customer_id);


--
-- Name: index_booking_invoices_on_invoice_number; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_booking_invoices_on_invoice_number ON public.booking_invoices USING btree (invoice_number);


--
-- Name: index_booking_invoices_on_share_token; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_booking_invoices_on_share_token ON public.booking_invoices USING btree (share_token);


--
-- Name: index_booking_items_on_product_variant_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_booking_items_on_product_variant_id ON public.booking_items USING btree (product_variant_id);


--
-- Name: index_booking_schedules_on_customer_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_booking_schedules_on_customer_id ON public.booking_schedules USING btree (customer_id);


--
-- Name: index_booking_schedules_on_product_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_booking_schedules_on_product_id ON public.booking_schedules USING btree (product_id);


--
-- Name: index_bookings_on_booked_by; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_bookings_on_booked_by ON public.bookings USING btree (booked_by);


--
-- Name: index_bookings_on_booking_schedule_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_bookings_on_booking_schedule_id ON public.bookings USING btree (booking_schedule_id);


--
-- Name: index_bookings_on_cashfree_order_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_bookings_on_cashfree_order_id ON public.bookings USING btree (cashfree_order_id);


--
-- Name: index_bookings_on_cashfree_payment_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_bookings_on_cashfree_payment_id ON public.bookings USING btree (cashfree_payment_id);


--
-- Name: index_bookings_on_courier_service; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_bookings_on_courier_service ON public.bookings USING btree (courier_service);


--
-- Name: index_bookings_on_delivery_person_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_bookings_on_delivery_person_id ON public.bookings USING btree (delivery_person_id);


--
-- Name: index_bookings_on_delivery_time; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_bookings_on_delivery_time ON public.bookings USING btree (delivery_time);


--
-- Name: index_bookings_on_expected_delivery_date; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_bookings_on_expected_delivery_date ON public.bookings USING btree (expected_delivery_date);


--
-- Name: index_bookings_on_franchise_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_bookings_on_franchise_id ON public.bookings USING btree (franchise_id);


--
-- Name: index_bookings_on_payment_gateway; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_bookings_on_payment_gateway ON public.bookings USING btree (payment_gateway);


--
-- Name: index_bookings_on_stage_updated_at; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_bookings_on_stage_updated_at ON public.bookings USING btree (stage_updated_at);


--
-- Name: index_bookings_on_stage_updated_by; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_bookings_on_stage_updated_by ON public.bookings USING btree (stage_updated_by);


--
-- Name: index_bookings_on_store_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_bookings_on_store_id ON public.bookings USING btree (store_id);


--
-- Name: index_bookings_on_tracking_number; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_bookings_on_tracking_number ON public.bookings USING btree (tracking_number);


--
-- Name: index_categories_on_display_order; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_categories_on_display_order ON public.categories USING btree (display_order);


--
-- Name: index_categories_on_status; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_categories_on_status ON public.categories USING btree (status);


--
-- Name: index_client_requests_on_assignee_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_client_requests_on_assignee_id ON public.client_requests USING btree (assignee_id);


--
-- Name: index_client_requests_on_customer_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_client_requests_on_customer_id ON public.client_requests USING btree (customer_id);


--
-- Name: index_client_requests_on_department; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_client_requests_on_department ON public.client_requests USING btree (department);


--
-- Name: index_client_requests_on_estimated_resolution_time; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_client_requests_on_estimated_resolution_time ON public.client_requests USING btree (estimated_resolution_time);


--
-- Name: index_client_requests_on_stage; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_client_requests_on_stage ON public.client_requests USING btree (stage);


--
-- Name: index_client_requests_on_ticket_number; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_client_requests_on_ticket_number ON public.client_requests USING btree (ticket_number);


--
-- Name: index_coupons_on_code; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_coupons_on_code ON public.coupons USING btree (code);


--
-- Name: index_customer_addresses_on_customer_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_customer_addresses_on_customer_id ON public.customer_addresses USING btree (customer_id);


--
-- Name: index_customer_formats_on_customer_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_customer_formats_on_customer_id ON public.customer_formats USING btree (customer_id);


--
-- Name: index_customer_formats_on_delivery_person_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_customer_formats_on_delivery_person_id ON public.customer_formats USING btree (delivery_person_id);


--
-- Name: index_customer_formats_on_product_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_customer_formats_on_product_id ON public.customer_formats USING btree (product_id);


--
-- Name: index_customer_wallets_on_customer_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_customer_wallets_on_customer_id ON public.customer_wallets USING btree (customer_id);


--
-- Name: index_customers_on_location; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_customers_on_location ON public.customers USING btree (latitude, longitude);


--
-- Name: index_customers_on_whatsapp_number; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_customers_on_whatsapp_number ON public.customers USING btree (whatsapp_number);


--
-- Name: index_delivery_charges_on_is_active; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_delivery_charges_on_is_active ON public.delivery_charges USING btree (is_active);


--
-- Name: index_delivery_charges_on_pincode; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_delivery_charges_on_pincode ON public.delivery_charges USING btree (pincode);


--
-- Name: index_delivery_rules_on_product_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_delivery_rules_on_product_id ON public.delivery_rules USING btree (product_id);


--
-- Name: index_delivery_rules_on_rule_type; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_delivery_rules_on_rule_type ON public.delivery_rules USING btree (rule_type);


--
-- Name: index_device_tokens_on_customer_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_device_tokens_on_customer_id ON public.device_tokens USING btree (customer_id);


--
-- Name: index_device_tokens_on_delivery_person_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_device_tokens_on_delivery_person_id ON public.device_tokens USING btree (delivery_person_id);


--
-- Name: index_expenses_on_category; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_expenses_on_category ON public.expenses USING btree (category);


--
-- Name: index_expenses_on_created_by_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_expenses_on_created_by_id ON public.expenses USING btree (created_by_id);


--
-- Name: index_expenses_on_store_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_expenses_on_store_id ON public.expenses USING btree (store_id);


--
-- Name: index_expenses_on_store_id_and_expense_date; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_expenses_on_store_id_and_expense_date ON public.expenses USING btree (store_id, expense_date);


--
-- Name: index_franchises_on_email; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_franchises_on_email ON public.franchises USING btree (email);


--
-- Name: index_franchises_on_mobile; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_franchises_on_mobile ON public.franchises USING btree (mobile);


--
-- Name: index_franchises_on_pan_no; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_franchises_on_pan_no ON public.franchises USING btree (pan_no);


--
-- Name: index_franchises_on_user_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_franchises_on_user_id ON public.franchises USING btree (user_id);


--
-- Name: index_invoice_items_on_invoice_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_invoice_items_on_invoice_id ON public.invoice_items USING btree (invoice_id);


--
-- Name: index_invoice_items_on_milk_delivery_task_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_invoice_items_on_milk_delivery_task_id ON public.invoice_items USING btree (milk_delivery_task_id);


--
-- Name: index_invoice_items_on_product_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_invoice_items_on_product_id ON public.invoice_items USING btree (product_id);


--
-- Name: index_invoices_on_invoice_number; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_invoices_on_invoice_number ON public.invoices USING btree (invoice_number);


--
-- Name: index_invoices_on_share_token; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_invoices_on_share_token ON public.invoices USING btree (share_token);


--
-- Name: index_milk_delivery_tasks_on_customer_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_milk_delivery_tasks_on_customer_id ON public.milk_delivery_tasks USING btree (customer_id);


--
-- Name: index_milk_delivery_tasks_on_customer_id_and_delivery_date; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_milk_delivery_tasks_on_customer_id_and_delivery_date ON public.milk_delivery_tasks USING btree (customer_id, delivery_date);


--
-- Name: index_milk_delivery_tasks_on_delivery_date; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_milk_delivery_tasks_on_delivery_date ON public.milk_delivery_tasks USING btree (delivery_date);


--
-- Name: index_milk_delivery_tasks_on_delivery_person_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_milk_delivery_tasks_on_delivery_person_id ON public.milk_delivery_tasks USING btree (delivery_person_id);


--
-- Name: index_milk_delivery_tasks_on_product_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_milk_delivery_tasks_on_product_id ON public.milk_delivery_tasks USING btree (product_id);


--
-- Name: index_milk_delivery_tasks_on_status; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_milk_delivery_tasks_on_status ON public.milk_delivery_tasks USING btree (status);


--
-- Name: index_milk_delivery_tasks_on_subscription_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_milk_delivery_tasks_on_subscription_id ON public.milk_delivery_tasks USING btree (subscription_id);


--
-- Name: index_milk_subscriptions_on_customer_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_milk_subscriptions_on_customer_id ON public.milk_subscriptions USING btree (customer_id);


--
-- Name: index_milk_subscriptions_on_product_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_milk_subscriptions_on_product_id ON public.milk_subscriptions USING btree (product_id);


--
-- Name: index_notes_on_created_by_user_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_notes_on_created_by_user_id ON public.notes USING btree (created_by_user_id);


--
-- Name: index_notes_on_note_date; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_notes_on_note_date ON public.notes USING btree (note_date);


--
-- Name: index_notes_on_payment_method; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_notes_on_payment_method ON public.notes USING btree (payment_method);


--
-- Name: index_notes_on_status; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_notes_on_status ON public.notes USING btree (status);


--
-- Name: index_notifications_on_customer_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_notifications_on_customer_id ON public.notifications USING btree (customer_id);


--
-- Name: index_order_items_on_product_variant_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_order_items_on_product_variant_id ON public.order_items USING btree (product_variant_id);


--
-- Name: index_orders_on_booking_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_orders_on_booking_id ON public.orders USING btree (booking_id);


--
-- Name: index_pending_amounts_on_customer_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_pending_amounts_on_customer_id ON public.pending_amounts USING btree (customer_id);


--
-- Name: index_permissions_on_name; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_permissions_on_name ON public.permissions USING btree (name);


--
-- Name: index_permissions_on_resource_and_action; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_permissions_on_resource_and_action ON public.permissions USING btree (resource, action);


--
-- Name: index_product_ratings_on_customer_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_product_ratings_on_customer_id ON public.product_ratings USING btree (customer_id);


--
-- Name: index_product_ratings_on_product_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_product_ratings_on_product_id ON public.product_ratings USING btree (product_id);


--
-- Name: index_product_ratings_on_product_id_and_rating; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_product_ratings_on_product_id_and_rating ON public.product_ratings USING btree (product_id, rating);


--
-- Name: index_product_ratings_on_product_id_and_status; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_product_ratings_on_product_id_and_status ON public.product_ratings USING btree (product_id, status);


--
-- Name: index_product_ratings_on_user_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_product_ratings_on_user_id ON public.product_ratings USING btree (user_id);


--
-- Name: index_product_reviews_on_customer_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_product_reviews_on_customer_id ON public.product_reviews USING btree (customer_id);


--
-- Name: index_product_reviews_on_customer_id_and_product_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_product_reviews_on_customer_id_and_product_id ON public.product_reviews USING btree (customer_id, product_id) WHERE (customer_id IS NOT NULL);


--
-- Name: index_product_reviews_on_product_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_product_reviews_on_product_id ON public.product_reviews USING btree (product_id);


--
-- Name: index_product_reviews_on_product_id_and_created_at; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_product_reviews_on_product_id_and_created_at ON public.product_reviews USING btree (product_id, created_at);


--
-- Name: index_product_reviews_on_product_id_and_rating; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_product_reviews_on_product_id_and_rating ON public.product_reviews USING btree (product_id, rating);


--
-- Name: index_product_reviews_on_product_id_and_status; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_product_reviews_on_product_id_and_status ON public.product_reviews USING btree (product_id, status);


--
-- Name: index_product_reviews_on_user_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_product_reviews_on_user_id ON public.product_reviews USING btree (user_id);


--
-- Name: index_product_variants_on_is_default; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_product_variants_on_is_default ON public.product_variants USING btree (is_default);


--
-- Name: index_product_variants_on_product_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_product_variants_on_product_id ON public.product_variants USING btree (product_id);


--
-- Name: index_product_variants_uniqueness; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_product_variants_uniqueness ON public.product_variants USING btree (product_id, weight, unit);


--
-- Name: index_products_on_barcode; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_products_on_barcode ON public.products USING btree (barcode);


--
-- Name: index_products_on_category_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_products_on_category_id ON public.products USING btree (category_id);


--
-- Name: index_products_on_is_occasional_product; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_products_on_is_occasional_product ON public.products USING btree (is_occasional_product);


--
-- Name: index_products_on_is_subscription_enabled; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_products_on_is_subscription_enabled ON public.products USING btree (is_subscription_enabled);


--
-- Name: index_products_on_last_price_update; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_products_on_last_price_update ON public.products USING btree (last_price_update);


--
-- Name: index_products_on_name; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_products_on_name ON public.products USING btree (name);


--
-- Name: index_products_on_occasional_dates; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_products_on_occasional_dates ON public.products USING btree (is_occasional_product, occasional_start_date, occasional_end_date);


--
-- Name: index_products_on_product_type; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_products_on_product_type ON public.products USING btree (product_type);


--
-- Name: index_products_on_sku; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_products_on_sku ON public.products USING btree (sku);


--
-- Name: index_products_on_status; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_products_on_status ON public.products USING btree (status);


--
-- Name: index_referrals_on_affiliate_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_referrals_on_affiliate_id ON public.referrals USING btree (affiliate_id);


--
-- Name: index_referrals_on_customer_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_referrals_on_customer_id ON public.referrals USING btree (customer_id);


--
-- Name: index_referrals_on_referral_source; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_referrals_on_referral_source ON public.referrals USING btree (referral_source);


--
-- Name: index_referrals_on_referring_customer_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_referrals_on_referring_customer_id ON public.referrals USING btree (referring_customer_id);


--
-- Name: index_roles_on_name; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_roles_on_name ON public.roles USING btree (name);


--
-- Name: index_sale_items_on_booking_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_sale_items_on_booking_id ON public.sale_items USING btree (booking_id);


--
-- Name: index_sale_items_on_product_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_sale_items_on_product_id ON public.sale_items USING btree (product_id);


--
-- Name: index_sale_items_on_stock_batch_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_sale_items_on_stock_batch_id ON public.sale_items USING btree (stock_batch_id);


--
-- Name: index_solid_cache_entries_on_byte_size; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_solid_cache_entries_on_byte_size ON public.solid_cache_entries USING btree (byte_size);


--
-- Name: index_solid_cache_entries_on_key_hash; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_solid_cache_entries_on_key_hash ON public.solid_cache_entries USING btree (key_hash);


--
-- Name: index_solid_cache_entries_on_key_hash_and_byte_size; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_solid_cache_entries_on_key_hash_and_byte_size ON public.solid_cache_entries USING btree (key_hash, byte_size);


--
-- Name: index_solid_queue_blocked_executions_for_maintenance; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_solid_queue_blocked_executions_for_maintenance ON public.solid_queue_blocked_executions USING btree (expires_at, concurrency_key);


--
-- Name: index_solid_queue_blocked_executions_for_release; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_solid_queue_blocked_executions_for_release ON public.solid_queue_blocked_executions USING btree (concurrency_key, priority, job_id);


--
-- Name: index_solid_queue_blocked_executions_on_job_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_solid_queue_blocked_executions_on_job_id ON public.solid_queue_blocked_executions USING btree (job_id);


--
-- Name: index_solid_queue_claimed_executions_on_job_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_solid_queue_claimed_executions_on_job_id ON public.solid_queue_claimed_executions USING btree (job_id);


--
-- Name: index_solid_queue_claimed_executions_on_process_id_and_job_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_solid_queue_claimed_executions_on_process_id_and_job_id ON public.solid_queue_claimed_executions USING btree (process_id, job_id);


--
-- Name: index_solid_queue_dispatch_all; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_solid_queue_dispatch_all ON public.solid_queue_scheduled_executions USING btree (scheduled_at, priority, job_id);


--
-- Name: index_solid_queue_failed_executions_on_job_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_solid_queue_failed_executions_on_job_id ON public.solid_queue_failed_executions USING btree (job_id);


--
-- Name: index_solid_queue_jobs_for_alerting; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_solid_queue_jobs_for_alerting ON public.solid_queue_jobs USING btree (scheduled_at, finished_at);


--
-- Name: index_solid_queue_jobs_for_filtering; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_solid_queue_jobs_for_filtering ON public.solid_queue_jobs USING btree (queue_name, finished_at);


--
-- Name: index_solid_queue_jobs_on_active_job_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_solid_queue_jobs_on_active_job_id ON public.solid_queue_jobs USING btree (active_job_id);


--
-- Name: index_solid_queue_jobs_on_class_name; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_solid_queue_jobs_on_class_name ON public.solid_queue_jobs USING btree (class_name);


--
-- Name: index_solid_queue_jobs_on_finished_at; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_solid_queue_jobs_on_finished_at ON public.solid_queue_jobs USING btree (finished_at);


--
-- Name: index_solid_queue_pauses_on_queue_name; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_solid_queue_pauses_on_queue_name ON public.solid_queue_pauses USING btree (queue_name);


--
-- Name: index_solid_queue_poll_all; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_solid_queue_poll_all ON public.solid_queue_ready_executions USING btree (priority, job_id);


--
-- Name: index_solid_queue_poll_by_queue; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_solid_queue_poll_by_queue ON public.solid_queue_ready_executions USING btree (queue_name, priority, job_id);


--
-- Name: index_solid_queue_processes_on_last_heartbeat_at; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_solid_queue_processes_on_last_heartbeat_at ON public.solid_queue_processes USING btree (last_heartbeat_at);


--
-- Name: index_solid_queue_processes_on_name_and_supervisor_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_solid_queue_processes_on_name_and_supervisor_id ON public.solid_queue_processes USING btree (name, supervisor_id);


--
-- Name: index_solid_queue_processes_on_supervisor_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_solid_queue_processes_on_supervisor_id ON public.solid_queue_processes USING btree (supervisor_id);


--
-- Name: index_solid_queue_ready_executions_on_job_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_solid_queue_ready_executions_on_job_id ON public.solid_queue_ready_executions USING btree (job_id);


--
-- Name: index_solid_queue_recurring_executions_on_job_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_solid_queue_recurring_executions_on_job_id ON public.solid_queue_recurring_executions USING btree (job_id);


--
-- Name: index_solid_queue_recurring_executions_on_task_key_and_run_at; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_solid_queue_recurring_executions_on_task_key_and_run_at ON public.solid_queue_recurring_executions USING btree (task_key, run_at);


--
-- Name: index_solid_queue_recurring_tasks_on_key; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_solid_queue_recurring_tasks_on_key ON public.solid_queue_recurring_tasks USING btree (key);


--
-- Name: index_solid_queue_recurring_tasks_on_static; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_solid_queue_recurring_tasks_on_static ON public.solid_queue_recurring_tasks USING btree (static);


--
-- Name: index_solid_queue_scheduled_executions_on_job_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_solid_queue_scheduled_executions_on_job_id ON public.solid_queue_scheduled_executions USING btree (job_id);


--
-- Name: index_solid_queue_semaphores_on_expires_at; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_solid_queue_semaphores_on_expires_at ON public.solid_queue_semaphores USING btree (expires_at);


--
-- Name: index_solid_queue_semaphores_on_key; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_solid_queue_semaphores_on_key ON public.solid_queue_semaphores USING btree (key);


--
-- Name: index_solid_queue_semaphores_on_key_and_value; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_solid_queue_semaphores_on_key_and_value ON public.solid_queue_semaphores USING btree (key, value);


--
-- Name: index_stock_batches_on_product_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_stock_batches_on_product_id ON public.stock_batches USING btree (product_id);


--
-- Name: index_stock_batches_on_product_id_and_store_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_stock_batches_on_product_id_and_store_id ON public.stock_batches USING btree (product_id, store_id);


--
-- Name: index_stock_batches_on_store_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_stock_batches_on_store_id ON public.stock_batches USING btree (store_id);


--
-- Name: index_stock_batches_on_vendor_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_stock_batches_on_vendor_id ON public.stock_batches USING btree (vendor_id);


--
-- Name: index_stock_batches_on_vendor_purchase_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_stock_batches_on_vendor_purchase_id ON public.stock_batches USING btree (vendor_purchase_id);


--
-- Name: index_stock_movements_on_product_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_stock_movements_on_product_id ON public.stock_movements USING btree (product_id);


--
-- Name: index_stock_transfers_on_approved_by_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_stock_transfers_on_approved_by_id ON public.stock_transfers USING btree (approved_by_id);


--
-- Name: index_stock_transfers_on_from_store_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_stock_transfers_on_from_store_id ON public.stock_transfers USING btree (from_store_id);


--
-- Name: index_stock_transfers_on_product_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_stock_transfers_on_product_id ON public.stock_transfers USING btree (product_id);


--
-- Name: index_stock_transfers_on_requested_by_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_stock_transfers_on_requested_by_id ON public.stock_transfers USING btree (requested_by_id);


--
-- Name: index_stock_transfers_on_status; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_stock_transfers_on_status ON public.stock_transfers USING btree (status);


--
-- Name: index_stock_transfers_on_to_store_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_stock_transfers_on_to_store_id ON public.stock_transfers USING btree (to_store_id);


--
-- Name: index_stock_transfers_on_transfer_group_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_stock_transfers_on_transfer_group_id ON public.stock_transfers USING btree (transfer_group_id);


--
-- Name: index_stores_on_store_admin_user_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_stores_on_store_admin_user_id ON public.stores USING btree (store_admin_user_id);


--
-- Name: index_sub_agents_on_aadhar_no; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_sub_agents_on_aadhar_no ON public.sub_agents USING btree (aadhar_no);


--
-- Name: index_sub_agents_on_email; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_sub_agents_on_email ON public.sub_agents USING btree (email);


--
-- Name: index_sub_agents_on_mobile; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_sub_agents_on_mobile ON public.sub_agents USING btree (mobile);


--
-- Name: index_sub_agents_on_pan_no; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_sub_agents_on_pan_no ON public.sub_agents USING btree (pan_no);


--
-- Name: index_subscription_templates_on_customer_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_subscription_templates_on_customer_id ON public.subscription_templates USING btree (customer_id);


--
-- Name: index_subscription_templates_on_delivery_person_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_subscription_templates_on_delivery_person_id ON public.subscription_templates USING btree (delivery_person_id);


--
-- Name: index_subscription_templates_on_product_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_subscription_templates_on_product_id ON public.subscription_templates USING btree (product_id);


--
-- Name: index_system_settings_on_key; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_system_settings_on_key ON public.system_settings USING btree (key);


--
-- Name: index_user_roles_on_name; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_user_roles_on_name ON public.user_roles USING btree (name);


--
-- Name: index_users_on_aadhar_no; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_users_on_aadhar_no ON public.users USING btree (aadhar_no);


--
-- Name: index_users_on_assigned_store_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_users_on_assigned_store_id ON public.users USING btree (assigned_store_id);


--
-- Name: index_users_on_authenticatable; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_users_on_authenticatable ON public.users USING btree (authenticatable_type, authenticatable_id);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON public.users USING btree (confirmation_token);


--
-- Name: index_users_on_deleted_at; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_users_on_deleted_at ON public.users USING btree (deleted_at);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_employee_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_users_on_employee_id ON public.users USING btree (employee_id);


--
-- Name: index_users_on_is_active; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_users_on_is_active ON public.users USING btree (is_active);


--
-- Name: index_users_on_mobile; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_users_on_mobile ON public.users USING btree (mobile);


--
-- Name: index_users_on_pan_no; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_users_on_pan_no ON public.users USING btree (pan_no);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_users_on_role; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_users_on_role ON public.users USING btree (role);


--
-- Name: index_users_on_status; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_users_on_status ON public.users USING btree (status);


--
-- Name: index_users_on_unlock_token; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_users_on_unlock_token ON public.users USING btree (unlock_token);


--
-- Name: index_users_on_user_type; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_users_on_user_type ON public.users USING btree (user_type);


--
-- Name: index_vendor_invoices_on_invoice_number; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_vendor_invoices_on_invoice_number ON public.vendor_invoices USING btree (invoice_number);


--
-- Name: index_vendor_invoices_on_share_token; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_vendor_invoices_on_share_token ON public.vendor_invoices USING btree (share_token);


--
-- Name: index_vendor_invoices_on_vendor_purchase_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_vendor_invoices_on_vendor_purchase_id ON public.vendor_invoices USING btree (vendor_purchase_id);


--
-- Name: index_vendor_payments_on_vendor_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_vendor_payments_on_vendor_id ON public.vendor_payments USING btree (vendor_id);


--
-- Name: index_vendor_payments_on_vendor_purchase_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_vendor_payments_on_vendor_purchase_id ON public.vendor_payments USING btree (vendor_purchase_id);


--
-- Name: index_vendor_purchase_items_on_product_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_vendor_purchase_items_on_product_id ON public.vendor_purchase_items USING btree (product_id);


--
-- Name: index_vendor_purchase_items_on_vendor_purchase_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_vendor_purchase_items_on_vendor_purchase_id ON public.vendor_purchase_items USING btree (vendor_purchase_id);


--
-- Name: index_vendor_purchases_on_vendor_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_vendor_purchases_on_vendor_id ON public.vendor_purchases USING btree (vendor_id);


--
-- Name: index_wallet_transactions_on_customer_wallet_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_wallet_transactions_on_customer_wallet_id ON public.wallet_transactions USING btree (customer_wallet_id);


--
-- Name: index_wallet_transactions_on_reference_number; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE UNIQUE INDEX index_wallet_transactions_on_reference_number ON public.wallet_transactions USING btree (reference_number);


--
-- Name: index_wallet_transactions_on_transaction_type; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_wallet_transactions_on_transaction_type ON public.wallet_transactions USING btree (transaction_type);


--
-- Name: index_wishlists_on_customer_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_wishlists_on_customer_id ON public.wishlists USING btree (customer_id);


--
-- Name: index_wishlists_on_product_id; Type: INDEX; Schema: public; Owner: marlai_santhe_002_user
--

CREATE INDEX index_wishlists_on_product_id ON public.wishlists USING btree (product_id);


--
-- Name: milk_subscriptions fk_milk_subscriptions_delivery_person; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.milk_subscriptions
    ADD CONSTRAINT fk_milk_subscriptions_delivery_person FOREIGN KEY (delivery_person_id) REFERENCES public.delivery_people(id);


--
-- Name: subscription_templates fk_rails_0427a5a8f5; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.subscription_templates
    ADD CONSTRAINT fk_rails_0427a5a8f5 FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: booking_invoices fk_rails_0588ce0fe5; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.booking_invoices
    ADD CONSTRAINT fk_rails_0588ce0fe5 FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: invoice_items fk_rails_0c6e1fd09e; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.invoice_items
    ADD CONSTRAINT fk_rails_0c6e1fd09e FOREIGN KEY (milk_delivery_task_id) REFERENCES public.milk_delivery_tasks(id);


--
-- Name: stock_batches fk_rails_0fd8722280; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.stock_batches
    ADD CONSTRAINT fk_rails_0fd8722280 FOREIGN KEY (vendor_purchase_id) REFERENCES public.vendor_purchases(id);


--
-- Name: sale_items fk_rails_10aa153cb0; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.sale_items
    ADD CONSTRAINT fk_rails_10aa153cb0 FOREIGN KEY (booking_id) REFERENCES public.bookings(id);


--
-- Name: referrals fk_rails_143e21be26; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.referrals
    ADD CONSTRAINT fk_rails_143e21be26 FOREIGN KEY (affiliate_id) REFERENCES public.affiliates(id);


--
-- Name: wishlists fk_rails_18bd87f3b0; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.wishlists
    ADD CONSTRAINT fk_rails_18bd87f3b0 FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: bookings fk_rails_1a839bd564; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT fk_rails_1a839bd564 FOREIGN KEY (delivery_person_id) REFERENCES public.delivery_people(id);


--
-- Name: vendor_purchase_items fk_rails_1d0b180fcb; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.vendor_purchase_items
    ADD CONSTRAINT fk_rails_1d0b180fcb FOREIGN KEY (vendor_purchase_id) REFERENCES public.vendor_purchases(id);


--
-- Name: booking_schedules fk_rails_1de48ebd18; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.booking_schedules
    ADD CONSTRAINT fk_rails_1de48ebd18 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: invoice_items fk_rails_25bf3d2c5e; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.invoice_items
    ADD CONSTRAINT fk_rails_25bf3d2c5e FOREIGN KEY (invoice_id) REFERENCES public.invoices(id);


--
-- Name: device_tokens fk_rails_287313072c; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.device_tokens
    ADD CONSTRAINT fk_rails_287313072c FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: referrals fk_rails_2a86f7c55b; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.referrals
    ADD CONSTRAINT fk_rails_2a86f7c55b FOREIGN KEY (referring_customer_id) REFERENCES public.customers(id);


--
-- Name: vendor_purchase_items fk_rails_2b2646ec33; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.vendor_purchase_items
    ADD CONSTRAINT fk_rails_2b2646ec33 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: stock_batches fk_rails_30af726acb; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.stock_batches
    ADD CONSTRAINT fk_rails_30af726acb FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: bookings fk_rails_30b4781a51; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT fk_rails_30b4781a51 FOREIGN KEY (franchise_id) REFERENCES public.franchises(id);


--
-- Name: solid_queue_recurring_executions fk_rails_318a5533ed; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.solid_queue_recurring_executions
    ADD CONSTRAINT fk_rails_318a5533ed FOREIGN KEY (job_id) REFERENCES public.solid_queue_jobs(id) ON DELETE CASCADE;


--
-- Name: milk_delivery_tasks fk_rails_3630bcf24a; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.milk_delivery_tasks
    ADD CONSTRAINT fk_rails_3630bcf24a FOREIGN KEY (subscription_id) REFERENCES public.milk_subscriptions(id);


--
-- Name: product_ratings fk_rails_36795236ae; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.product_ratings
    ADD CONSTRAINT fk_rails_36795236ae FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: milk_delivery_tasks fk_rails_390b1646ed; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.milk_delivery_tasks
    ADD CONSTRAINT fk_rails_390b1646ed FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: solid_queue_failed_executions fk_rails_39bbc7a631; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.solid_queue_failed_executions
    ADD CONSTRAINT fk_rails_39bbc7a631 FOREIGN KEY (job_id) REFERENCES public.solid_queue_jobs(id) ON DELETE CASCADE;


--
-- Name: client_requests fk_rails_3d32864cfc; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.client_requests
    ADD CONSTRAINT fk_rails_3d32864cfc FOREIGN KEY (assignee_id) REFERENCES public.users(id);


--
-- Name: vendor_payments fk_rails_3d8456966c; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.vendor_payments
    ADD CONSTRAINT fk_rails_3d8456966c FOREIGN KEY (vendor_id) REFERENCES public.vendors(id);


--
-- Name: franchises fk_rails_41d1977e7e; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.franchises
    ADD CONSTRAINT fk_rails_41d1977e7e FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: wishlists fk_rails_4224d8f53b; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.wishlists
    ADD CONSTRAINT fk_rails_4224d8f53b FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: stock_transfers fk_rails_43353b43cf; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.stock_transfers
    ADD CONSTRAINT fk_rails_43353b43cf FOREIGN KEY (from_store_id) REFERENCES public.stores(id);


--
-- Name: bookings fk_rails_469339cd03; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT fk_rails_469339cd03 FOREIGN KEY (store_id) REFERENCES public.stores(id);


--
-- Name: delivery_rules fk_rails_495c599380; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.delivery_rules
    ADD CONSTRAINT fk_rails_495c599380 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: milk_subscriptions fk_rails_4b4fb0c9b4; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.milk_subscriptions
    ADD CONSTRAINT fk_rails_4b4fb0c9b4 FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: subscription_templates fk_rails_4cd084b669; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.subscription_templates
    ADD CONSTRAINT fk_rails_4cd084b669 FOREIGN KEY (delivery_person_id) REFERENCES public.delivery_people(id);


--
-- Name: solid_queue_blocked_executions fk_rails_4cd34e2228; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.solid_queue_blocked_executions
    ADD CONSTRAINT fk_rails_4cd34e2228 FOREIGN KEY (job_id) REFERENCES public.solid_queue_jobs(id) ON DELETE CASCADE;


--
-- Name: product_reviews fk_rails_4d29a9c00a; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.product_reviews
    ADD CONSTRAINT fk_rails_4d29a9c00a FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: notes fk_rails_65a5c39deb; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT fk_rails_65a5c39deb FOREIGN KEY (created_by_user_id) REFERENCES public.users(id);


--
-- Name: customer_wallets fk_rails_67b1f56e66; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.customer_wallets
    ADD CONSTRAINT fk_rails_67b1f56e66 FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: stock_transfers fk_rails_6cb5ca8048; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.stock_transfers
    ADD CONSTRAINT fk_rails_6cb5ca8048 FOREIGN KEY (approved_by_id) REFERENCES public.users(id);


--
-- Name: expenses fk_rails_707830cb5c; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT fk_rails_707830cb5c FOREIGN KEY (store_id) REFERENCES public.stores(id);


--
-- Name: invoice_items fk_rails_72ed60e62c; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.invoice_items
    ADD CONSTRAINT fk_rails_72ed60e62c FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: referrals fk_rails_77c18d42bf; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.referrals
    ADD CONSTRAINT fk_rails_77c18d42bf FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: customer_addresses fk_rails_79041ef784; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.customer_addresses
    ADD CONSTRAINT fk_rails_79041ef784 FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: stock_transfers fk_rails_7b9441fa63; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.stock_transfers
    ADD CONSTRAINT fk_rails_7b9441fa63 FOREIGN KEY (to_store_id) REFERENCES public.stores(id);


--
-- Name: subscription_templates fk_rails_7cbefbc65a; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.subscription_templates
    ADD CONSTRAINT fk_rails_7cbefbc65a FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: vendor_purchases fk_rails_7dbe9a831a; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.vendor_purchases
    ADD CONSTRAINT fk_rails_7dbe9a831a FOREIGN KEY (vendor_id) REFERENCES public.vendors(id);


--
-- Name: milk_delivery_tasks fk_rails_7f5c180cc8; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.milk_delivery_tasks
    ADD CONSTRAINT fk_rails_7f5c180cc8 FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: solid_queue_ready_executions fk_rails_81fcbd66af; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.solid_queue_ready_executions
    ADD CONSTRAINT fk_rails_81fcbd66af FOREIGN KEY (job_id) REFERENCES public.solid_queue_jobs(id) ON DELETE CASCADE;


--
-- Name: bookings fk_rails_94a0a341bb; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT fk_rails_94a0a341bb FOREIGN KEY (booking_schedule_id) REFERENCES public.booking_schedules(id);


--
-- Name: stock_transfers fk_rails_95796a1793; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.stock_transfers
    ADD CONSTRAINT fk_rails_95796a1793 FOREIGN KEY (requested_by_id) REFERENCES public.users(id);


--
-- Name: active_storage_variant_records fk_rails_993965df05; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT fk_rails_993965df05 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: solid_queue_claimed_executions fk_rails_9cfe4d4944; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.solid_queue_claimed_executions
    ADD CONSTRAINT fk_rails_9cfe4d4944 FOREIGN KEY (job_id) REFERENCES public.solid_queue_jobs(id) ON DELETE CASCADE;


--
-- Name: product_reviews fk_rails_9dcee7d533; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.product_reviews
    ADD CONSTRAINT fk_rails_9dcee7d533 FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: vendor_invoices fk_rails_a2e0d1751f; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.vendor_invoices
    ADD CONSTRAINT fk_rails_a2e0d1751f FOREIGN KEY (vendor_purchase_id) REFERENCES public.vendor_purchases(id);


--
-- Name: product_reviews fk_rails_a6af267e3d; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.product_reviews
    ADD CONSTRAINT fk_rails_a6af267e3d FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: device_tokens fk_rails_a6eff83e14; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.device_tokens
    ADD CONSTRAINT fk_rails_a6eff83e14 FOREIGN KEY (delivery_person_id) REFERENCES public.delivery_people(id);


--
-- Name: milk_delivery_tasks fk_rails_aafb5e9feb; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.milk_delivery_tasks
    ADD CONSTRAINT fk_rails_aafb5e9feb FOREIGN KEY (delivery_person_id) REFERENCES public.delivery_people(id);


--
-- Name: stock_batches fk_rails_affef9f32d; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.stock_batches
    ADD CONSTRAINT fk_rails_affef9f32d FOREIGN KEY (store_id) REFERENCES public.stores(id);


--
-- Name: booking_schedules fk_rails_bf34e93579; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.booking_schedules
    ADD CONSTRAINT fk_rails_bf34e93579 FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: client_requests fk_rails_bf4af15099; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.client_requests
    ADD CONSTRAINT fk_rails_bf4af15099 FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: active_storage_attachments fk_rails_c3b3935057; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT fk_rails_c3b3935057 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: solid_queue_scheduled_executions fk_rails_c4316f352d; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.solid_queue_scheduled_executions
    ADD CONSTRAINT fk_rails_c4316f352d FOREIGN KEY (job_id) REFERENCES public.solid_queue_jobs(id) ON DELETE CASCADE;


--
-- Name: product_ratings fk_rails_cc19464c64; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.product_ratings
    ADD CONSTRAINT fk_rails_cc19464c64 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: customer_formats fk_rails_cec20eb18b; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.customer_formats
    ADD CONSTRAINT fk_rails_cec20eb18b FOREIGN KEY (delivery_person_id) REFERENCES public.delivery_people(id);


--
-- Name: product_ratings fk_rails_d174ea1e32; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.product_ratings
    ADD CONSTRAINT fk_rails_d174ea1e32 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: customer_formats fk_rails_d1c53afd32; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.customer_formats
    ADD CONSTRAINT fk_rails_d1c53afd32 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: stock_transfers fk_rails_d470850111; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.stock_transfers
    ADD CONSTRAINT fk_rails_d470850111 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: sale_items fk_rails_d6e0e81317; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.sale_items
    ADD CONSTRAINT fk_rails_d6e0e81317 FOREIGN KEY (stock_batch_id) REFERENCES public.stock_batches(id);


--
-- Name: customer_formats fk_rails_d8a77fd5fc; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.customer_formats
    ADD CONSTRAINT fk_rails_d8a77fd5fc FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: product_variants fk_rails_dae52f850b; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.product_variants
    ADD CONSTRAINT fk_rails_dae52f850b FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: wallet_transactions fk_rails_dc5903e62b; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.wallet_transactions
    ADD CONSTRAINT fk_rails_dc5903e62b FOREIGN KEY (customer_wallet_id) REFERENCES public.customer_wallets(id);


--
-- Name: stock_movements fk_rails_deb37fa2ee; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.stock_movements
    ADD CONSTRAINT fk_rails_deb37fa2ee FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: milk_subscriptions fk_rails_e110a3862f; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.milk_subscriptions
    ADD CONSTRAINT fk_rails_e110a3862f FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: notifications fk_rails_e82fd73b00; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_rails_e82fd73b00 FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: sale_items fk_rails_ee606308b2; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.sale_items
    ADD CONSTRAINT fk_rails_ee606308b2 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: pending_amounts fk_rails_f63a5d559b; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.pending_amounts
    ADD CONSTRAINT fk_rails_f63a5d559b FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: expenses fk_rails_f7e2e7081b; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT fk_rails_f7e2e7081b FOREIGN KEY (created_by_id) REFERENCES public.users(id);


--
-- Name: vendor_payments fk_rails_fa51839ac6; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.vendor_payments
    ADD CONSTRAINT fk_rails_fa51839ac6 FOREIGN KEY (vendor_purchase_id) REFERENCES public.vendor_purchases(id);


--
-- Name: products fk_rails_fb915499a4; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT fk_rails_fb915499a4 FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: booking_invoices fk_rails_fd3dea094d; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.booking_invoices
    ADD CONSTRAINT fk_rails_fd3dea094d FOREIGN KEY (booking_id) REFERENCES public.bookings(id);


--
-- Name: stock_batches fk_rails_fd8d4dc083; Type: FK CONSTRAINT; Schema: public; Owner: marlai_santhe_002_user
--

ALTER TABLE ONLY public.stock_batches
    ADD CONSTRAINT fk_rails_fd8d4dc083 FOREIGN KEY (vendor_id) REFERENCES public.vendors(id);


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON SEQUENCES TO marlai_santhe_002_user;


--
-- Name: DEFAULT PRIVILEGES FOR TYPES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TYPES TO marlai_santhe_002_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON FUNCTIONS TO marlai_santhe_002_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TABLES TO marlai_santhe_002_user;


--
-- PostgreSQL database dump complete
--

\unrestrict VsnpeZiR1W4hR2nVAenHFUW7FqMvnzKrhtoyp5iAHaAaIemNDWxI2hQLgx3xfgt


--
-- PostgreSQL database dump
--

\restrict wQxPwDjd1bQ7C8ulBv4ttixREb14BaZ9lI3X2jdvK5h6rCHQWQnosHPH1xHI4rd

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

-- *not* creating schema, since initdb creates it


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: active_storage_attachments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_attachments (
    id bigint NOT NULL,
    name character varying NOT NULL,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    blob_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL
);


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_storage_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_storage_attachments_id_seq OWNED BY public.active_storage_attachments.id;


--
-- Name: active_storage_blobs; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_storage_blobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_storage_blobs_id_seq OWNED BY public.active_storage_blobs.id;


--
-- Name: active_storage_variant_records; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_variant_records (
    id bigint NOT NULL,
    blob_id bigint NOT NULL,
    variation_digest character varying NOT NULL
);


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_storage_variant_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNED BY public.active_storage_variant_records.id;


--
-- Name: affiliates; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: affiliates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.affiliates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: affiliates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.affiliates_id_seq OWNED BY public.affiliates.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: banners; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: banners_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.banners_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: banners_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.banners_id_seq OWNED BY public.banners.id;


--
-- Name: booking_invoices; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: booking_invoices_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.booking_invoices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: booking_invoices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.booking_invoices_id_seq OWNED BY public.booking_invoices.id;


--
-- Name: booking_items; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: booking_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.booking_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: booking_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.booking_items_id_seq OWNED BY public.booking_items.id;


--
-- Name: booking_schedules; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: booking_schedules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.booking_schedules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: booking_schedules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.booking_schedules_id_seq OWNED BY public.booking_schedules.id;


--
-- Name: bookings; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: bookings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bookings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bookings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bookings_id_seq OWNED BY public.bookings.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: client_requests; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: client_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.client_requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: client_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.client_requests_id_seq OWNED BY public.client_requests.id;


--
-- Name: coupons; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: coupons_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.coupons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: coupons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.coupons_id_seq OWNED BY public.coupons.id;


--
-- Name: customer_addresses; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: customer_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.customer_addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: customer_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.customer_addresses_id_seq OWNED BY public.customer_addresses.id;


--
-- Name: customer_formats; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: customer_formats_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.customer_formats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: customer_formats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.customer_formats_id_seq OWNED BY public.customer_formats.id;


--
-- Name: customer_wallets; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: customer_wallets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.customer_wallets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: customer_wallets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.customer_wallets_id_seq OWNED BY public.customer_wallets.id;


--
-- Name: customers; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.customers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;


--
-- Name: delivery_charges; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.delivery_charges (
    id bigint NOT NULL,
    pincode character varying NOT NULL,
    area character varying,
    charge_amount numeric(10,2) DEFAULT 0.0,
    is_active boolean DEFAULT true,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: delivery_charges_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.delivery_charges_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delivery_charges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.delivery_charges_id_seq OWNED BY public.delivery_charges.id;


--
-- Name: delivery_people; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: delivery_people_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.delivery_people_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delivery_people_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.delivery_people_id_seq OWNED BY public.delivery_people.id;


--
-- Name: delivery_rules; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: delivery_rules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.delivery_rules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delivery_rules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.delivery_rules_id_seq OWNED BY public.delivery_rules.id;


--
-- Name: device_tokens; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: device_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.device_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: device_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.device_tokens_id_seq OWNED BY public.device_tokens.id;


--
-- Name: expenses; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: expenses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.expenses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: expenses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.expenses_id_seq OWNED BY public.expenses.id;


--
-- Name: franchises; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: franchises_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.franchises_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: franchises_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.franchises_id_seq OWNED BY public.franchises.id;


--
-- Name: invoice_items; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: invoice_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.invoice_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: invoice_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.invoice_items_id_seq OWNED BY public.invoice_items.id;


--
-- Name: invoices; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: invoices_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.invoices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: invoices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.invoices_id_seq OWNED BY public.invoices.id;


--
-- Name: leads; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: leads_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.leads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: leads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.leads_id_seq OWNED BY public.leads.id;


--
-- Name: milk_delivery_tasks; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: milk_delivery_tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.milk_delivery_tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: milk_delivery_tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.milk_delivery_tasks_id_seq OWNED BY public.milk_delivery_tasks.id;


--
-- Name: milk_subscriptions; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: milk_subscriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.milk_subscriptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: milk_subscriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.milk_subscriptions_id_seq OWNED BY public.milk_subscriptions.id;


--
-- Name: notes; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notes_id_seq OWNED BY public.notes.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.order_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: pending_amounts; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: pending_amounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pending_amounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pending_amounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pending_amounts_id_seq OWNED BY public.pending_amounts.id;


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;


--
-- Name: product_ratings; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: product_ratings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_ratings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_ratings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_ratings_id_seq OWNED BY public.product_ratings.id;


--
-- Name: product_reviews; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: product_reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_reviews_id_seq OWNED BY public.product_reviews.id;


--
-- Name: product_variants; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: product_variants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_variants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_variants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_variants_id_seq OWNED BY public.product_variants.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: referrals; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: referrals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.referrals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: referrals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.referrals_id_seq OWNED BY public.referrals.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: sale_items; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: sale_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sale_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sale_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sale_items_id_seq OWNED BY public.sale_items.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: solid_cache_entries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.solid_cache_entries (
    id bigint NOT NULL,
    key bytea NOT NULL,
    value bytea NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    key_hash bigint NOT NULL,
    byte_size integer NOT NULL
);


--
-- Name: solid_cache_entries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.solid_cache_entries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: solid_cache_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.solid_cache_entries_id_seq OWNED BY public.solid_cache_entries.id;


--
-- Name: solid_queue_blocked_executions; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: solid_queue_blocked_executions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.solid_queue_blocked_executions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: solid_queue_blocked_executions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.solid_queue_blocked_executions_id_seq OWNED BY public.solid_queue_blocked_executions.id;


--
-- Name: solid_queue_claimed_executions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.solid_queue_claimed_executions (
    id bigint NOT NULL,
    job_id bigint NOT NULL,
    process_id bigint,
    created_at timestamp(6) without time zone NOT NULL
);


--
-- Name: solid_queue_claimed_executions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.solid_queue_claimed_executions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: solid_queue_claimed_executions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.solid_queue_claimed_executions_id_seq OWNED BY public.solid_queue_claimed_executions.id;


--
-- Name: solid_queue_failed_executions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.solid_queue_failed_executions (
    id bigint NOT NULL,
    job_id bigint NOT NULL,
    error text,
    created_at timestamp(6) without time zone NOT NULL
);


--
-- Name: solid_queue_failed_executions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.solid_queue_failed_executions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: solid_queue_failed_executions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.solid_queue_failed_executions_id_seq OWNED BY public.solid_queue_failed_executions.id;


--
-- Name: solid_queue_jobs; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: solid_queue_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.solid_queue_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: solid_queue_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.solid_queue_jobs_id_seq OWNED BY public.solid_queue_jobs.id;


--
-- Name: solid_queue_pauses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.solid_queue_pauses (
    id bigint NOT NULL,
    queue_name character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL
);


--
-- Name: solid_queue_pauses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.solid_queue_pauses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: solid_queue_pauses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.solid_queue_pauses_id_seq OWNED BY public.solid_queue_pauses.id;


--
-- Name: solid_queue_processes; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: solid_queue_processes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.solid_queue_processes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: solid_queue_processes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.solid_queue_processes_id_seq OWNED BY public.solid_queue_processes.id;


--
-- Name: solid_queue_ready_executions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.solid_queue_ready_executions (
    id bigint NOT NULL,
    job_id bigint NOT NULL,
    queue_name character varying NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    created_at timestamp(6) without time zone NOT NULL
);


--
-- Name: solid_queue_ready_executions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.solid_queue_ready_executions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: solid_queue_ready_executions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.solid_queue_ready_executions_id_seq OWNED BY public.solid_queue_ready_executions.id;


--
-- Name: solid_queue_recurring_executions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.solid_queue_recurring_executions (
    id bigint NOT NULL,
    job_id bigint NOT NULL,
    task_key character varying NOT NULL,
    run_at timestamp(6) without time zone NOT NULL,
    created_at timestamp(6) without time zone NOT NULL
);


--
-- Name: solid_queue_recurring_executions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.solid_queue_recurring_executions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: solid_queue_recurring_executions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.solid_queue_recurring_executions_id_seq OWNED BY public.solid_queue_recurring_executions.id;


--
-- Name: solid_queue_recurring_tasks; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: solid_queue_recurring_tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.solid_queue_recurring_tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: solid_queue_recurring_tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.solid_queue_recurring_tasks_id_seq OWNED BY public.solid_queue_recurring_tasks.id;


--
-- Name: solid_queue_scheduled_executions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.solid_queue_scheduled_executions (
    id bigint NOT NULL,
    job_id bigint NOT NULL,
    queue_name character varying NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    scheduled_at timestamp(6) without time zone NOT NULL,
    created_at timestamp(6) without time zone NOT NULL
);


--
-- Name: solid_queue_scheduled_executions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.solid_queue_scheduled_executions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: solid_queue_scheduled_executions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.solid_queue_scheduled_executions_id_seq OWNED BY public.solid_queue_scheduled_executions.id;


--
-- Name: solid_queue_semaphores; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.solid_queue_semaphores (
    id bigint NOT NULL,
    key character varying NOT NULL,
    value integer DEFAULT 1 NOT NULL,
    expires_at timestamp(6) without time zone NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: solid_queue_semaphores_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.solid_queue_semaphores_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: solid_queue_semaphores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.solid_queue_semaphores_id_seq OWNED BY public.solid_queue_semaphores.id;


--
-- Name: stock_batches; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: stock_batches_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.stock_batches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stock_batches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.stock_batches_id_seq OWNED BY public.stock_batches.id;


--
-- Name: stock_movements; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: stock_movements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.stock_movements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stock_movements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.stock_movements_id_seq OWNED BY public.stock_movements.id;


--
-- Name: stock_transfers; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: stock_transfers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.stock_transfers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stock_transfers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.stock_transfers_id_seq OWNED BY public.stock_transfers.id;


--
-- Name: stores; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: stores_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.stores_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.stores_id_seq OWNED BY public.stores.id;


--
-- Name: sub_agents; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: sub_agents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sub_agents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sub_agents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sub_agents_id_seq OWNED BY public.sub_agents.id;


--
-- Name: subscription_templates; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: subscription_templates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.subscription_templates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: subscription_templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.subscription_templates_id_seq OWNED BY public.subscription_templates.id;


--
-- Name: system_settings; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: system_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.system_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: system_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.system_settings_id_seq OWNED BY public.system_settings.id;


--
-- Name: user_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_roles (
    id bigint NOT NULL,
    name character varying NOT NULL,
    description text,
    active boolean DEFAULT true,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: user_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_roles_id_seq OWNED BY public.user_roles.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: vendor_invoices; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: vendor_invoices_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.vendor_invoices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: vendor_invoices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.vendor_invoices_id_seq OWNED BY public.vendor_invoices.id;


--
-- Name: vendor_payments; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: vendor_payments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.vendor_payments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: vendor_payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.vendor_payments_id_seq OWNED BY public.vendor_payments.id;


--
-- Name: vendor_purchase_items; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: vendor_purchase_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.vendor_purchase_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: vendor_purchase_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.vendor_purchase_items_id_seq OWNED BY public.vendor_purchase_items.id;


--
-- Name: vendor_purchases; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: vendor_purchases_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.vendor_purchases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: vendor_purchases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.vendor_purchases_id_seq OWNED BY public.vendor_purchases.id;


--
-- Name: vendors; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: vendors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.vendors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: vendors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.vendors_id_seq OWNED BY public.vendors.id;


--
-- Name: wallet_transactions; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: wallet_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.wallet_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wallet_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.wallet_transactions_id_seq OWNED BY public.wallet_transactions.id;


--
-- Name: wishlists; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.wishlists (
    id bigint NOT NULL,
    customer_id bigint NOT NULL,
    product_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: wishlists_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.wishlists_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wishlists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.wishlists_id_seq OWNED BY public.wishlists.id;


--
-- Name: active_storage_attachments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments ALTER COLUMN id SET DEFAULT nextval('public.active_storage_attachments_id_seq'::regclass);


--
-- Name: active_storage_blobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_blobs ALTER COLUMN id SET DEFAULT nextval('public.active_storage_blobs_id_seq'::regclass);


--
-- Name: active_storage_variant_records id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_variant_records ALTER COLUMN id SET DEFAULT nextval('public.active_storage_variant_records_id_seq'::regclass);


--
-- Name: affiliates id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.affiliates ALTER COLUMN id SET DEFAULT nextval('public.affiliates_id_seq'::regclass);


--
-- Name: banners id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.banners ALTER COLUMN id SET DEFAULT nextval('public.banners_id_seq'::regclass);


--
-- Name: booking_invoices id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_invoices ALTER COLUMN id SET DEFAULT nextval('public.booking_invoices_id_seq'::regclass);


--
-- Name: booking_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_items ALTER COLUMN id SET DEFAULT nextval('public.booking_items_id_seq'::regclass);


--
-- Name: booking_schedules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_schedules ALTER COLUMN id SET DEFAULT nextval('public.booking_schedules_id_seq'::regclass);


--
-- Name: bookings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookings ALTER COLUMN id SET DEFAULT nextval('public.bookings_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: client_requests id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_requests ALTER COLUMN id SET DEFAULT nextval('public.client_requests_id_seq'::regclass);


--
-- Name: coupons id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupons ALTER COLUMN id SET DEFAULT nextval('public.coupons_id_seq'::regclass);


--
-- Name: customer_addresses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_addresses ALTER COLUMN id SET DEFAULT nextval('public.customer_addresses_id_seq'::regclass);


--
-- Name: customer_formats id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_formats ALTER COLUMN id SET DEFAULT nextval('public.customer_formats_id_seq'::regclass);


--
-- Name: customer_wallets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_wallets ALTER COLUMN id SET DEFAULT nextval('public.customer_wallets_id_seq'::regclass);


--
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);


--
-- Name: delivery_charges id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_charges ALTER COLUMN id SET DEFAULT nextval('public.delivery_charges_id_seq'::regclass);


--
-- Name: delivery_people id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_people ALTER COLUMN id SET DEFAULT nextval('public.delivery_people_id_seq'::regclass);


--
-- Name: delivery_rules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_rules ALTER COLUMN id SET DEFAULT nextval('public.delivery_rules_id_seq'::regclass);


--
-- Name: device_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.device_tokens ALTER COLUMN id SET DEFAULT nextval('public.device_tokens_id_seq'::regclass);


--
-- Name: expenses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.expenses ALTER COLUMN id SET DEFAULT nextval('public.expenses_id_seq'::regclass);


--
-- Name: franchises id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.franchises ALTER COLUMN id SET DEFAULT nextval('public.franchises_id_seq'::regclass);


--
-- Name: invoice_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoice_items ALTER COLUMN id SET DEFAULT nextval('public.invoice_items_id_seq'::regclass);


--
-- Name: invoices id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoices ALTER COLUMN id SET DEFAULT nextval('public.invoices_id_seq'::regclass);


--
-- Name: leads id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.leads ALTER COLUMN id SET DEFAULT nextval('public.leads_id_seq'::regclass);


--
-- Name: milk_delivery_tasks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.milk_delivery_tasks ALTER COLUMN id SET DEFAULT nextval('public.milk_delivery_tasks_id_seq'::regclass);


--
-- Name: milk_subscriptions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.milk_subscriptions ALTER COLUMN id SET DEFAULT nextval('public.milk_subscriptions_id_seq'::regclass);


--
-- Name: notes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notes ALTER COLUMN id SET DEFAULT nextval('public.notes_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: pending_amounts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pending_amounts ALTER COLUMN id SET DEFAULT nextval('public.pending_amounts_id_seq'::regclass);


--
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- Name: product_ratings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_ratings ALTER COLUMN id SET DEFAULT nextval('public.product_ratings_id_seq'::regclass);


--
-- Name: product_reviews id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_reviews ALTER COLUMN id SET DEFAULT nextval('public.product_reviews_id_seq'::regclass);


--
-- Name: product_variants id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variants ALTER COLUMN id SET DEFAULT nextval('public.product_variants_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: referrals id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.referrals ALTER COLUMN id SET DEFAULT nextval('public.referrals_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: sale_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sale_items ALTER COLUMN id SET DEFAULT nextval('public.sale_items_id_seq'::regclass);


--
-- Name: solid_cache_entries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_cache_entries ALTER COLUMN id SET DEFAULT nextval('public.solid_cache_entries_id_seq'::regclass);


--
-- Name: solid_queue_blocked_executions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_blocked_executions ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_blocked_executions_id_seq'::regclass);


--
-- Name: solid_queue_claimed_executions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_claimed_executions ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_claimed_executions_id_seq'::regclass);


--
-- Name: solid_queue_failed_executions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_failed_executions ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_failed_executions_id_seq'::regclass);


--
-- Name: solid_queue_jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_jobs ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_jobs_id_seq'::regclass);


--
-- Name: solid_queue_pauses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_pauses ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_pauses_id_seq'::regclass);


--
-- Name: solid_queue_processes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_processes ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_processes_id_seq'::regclass);


--
-- Name: solid_queue_ready_executions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_ready_executions ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_ready_executions_id_seq'::regclass);


--
-- Name: solid_queue_recurring_executions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_recurring_executions ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_recurring_executions_id_seq'::regclass);


--
-- Name: solid_queue_recurring_tasks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_recurring_tasks ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_recurring_tasks_id_seq'::regclass);


--
-- Name: solid_queue_scheduled_executions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_scheduled_executions ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_scheduled_executions_id_seq'::regclass);


--
-- Name: solid_queue_semaphores id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_semaphores ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_semaphores_id_seq'::regclass);


--
-- Name: stock_batches id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock_batches ALTER COLUMN id SET DEFAULT nextval('public.stock_batches_id_seq'::regclass);


--
-- Name: stock_movements id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock_movements ALTER COLUMN id SET DEFAULT nextval('public.stock_movements_id_seq'::regclass);


--
-- Name: stock_transfers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock_transfers ALTER COLUMN id SET DEFAULT nextval('public.stock_transfers_id_seq'::regclass);


--
-- Name: stores id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stores ALTER COLUMN id SET DEFAULT nextval('public.stores_id_seq'::regclass);


--
-- Name: sub_agents id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sub_agents ALTER COLUMN id SET DEFAULT nextval('public.sub_agents_id_seq'::regclass);


--
-- Name: subscription_templates id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subscription_templates ALTER COLUMN id SET DEFAULT nextval('public.subscription_templates_id_seq'::regclass);


--
-- Name: system_settings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.system_settings ALTER COLUMN id SET DEFAULT nextval('public.system_settings_id_seq'::regclass);


--
-- Name: user_roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_roles ALTER COLUMN id SET DEFAULT nextval('public.user_roles_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: vendor_invoices id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vendor_invoices ALTER COLUMN id SET DEFAULT nextval('public.vendor_invoices_id_seq'::regclass);


--
-- Name: vendor_payments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vendor_payments ALTER COLUMN id SET DEFAULT nextval('public.vendor_payments_id_seq'::regclass);


--
-- Name: vendor_purchase_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vendor_purchase_items ALTER COLUMN id SET DEFAULT nextval('public.vendor_purchase_items_id_seq'::regclass);


--
-- Name: vendor_purchases id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vendor_purchases ALTER COLUMN id SET DEFAULT nextval('public.vendor_purchases_id_seq'::regclass);


--
-- Name: vendors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vendors ALTER COLUMN id SET DEFAULT nextval('public.vendors_id_seq'::regclass);


--
-- Name: wallet_transactions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wallet_transactions ALTER COLUMN id SET DEFAULT nextval('public.wallet_transactions_id_seq'::regclass);


--
-- Name: wishlists id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wishlists ALTER COLUMN id SET DEFAULT nextval('public.wishlists_id_seq'::regclass);


--
-- Data for Name: active_storage_attachments; Type: TABLE DATA; Schema: public; Owner: -
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
-- Data for Name: active_storage_blobs; Type: TABLE DATA; Schema: public; Owner: -
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
-- Data for Name: active_storage_variant_records; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.active_storage_variant_records (id, blob_id, variation_digest) FROM stdin;
\.


--
-- Data for Name: affiliates; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.affiliates (id, first_name, last_name, middle_name, email, mobile, address, city, state, pincode, pan_no, gst_no, commission_percentage, bank_name, account_no, ifsc_code, account_holder_name, account_type, upi_id, status, notes, auto_generated_password, joining_date, created_at, updated_at, company_name, username) FROM stdin;
12	pramod	bhat	fdsfds	9093939393fdfds@gmail.com	09190939393	dfd	Bangalore	karnataka	560068			44.98				pramod			t		PRAM@2026	2026-05-09	2026-05-09 11:43:20.300104	2026-05-09 11:43:20.300104		pramodbhat
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
schema_sha1	9c6777daaa6ce85cc74b26c38000144a7834a947	2026-02-12 02:44:06.897761	2026-02-12 02:44:06.897764
environment	development	2026-02-12 02:44:05.79552	2026-02-22 10:18:57.284237
\.


--
-- Data for Name: banners; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.banners (id, title, description, redirect_link, display_start_date, display_end_date, display_location, status, display_order, image, created_at, updated_at, image_url, r2_image_url) FROM stdin;
5	Test	sd	https://web.whatsapp.com/	2026-05-10	2026-06-10	dashboard	t	1	\N	2026-05-10 08:37:09.737927	2026-05-10 08:37:09.737927	banners/banner-temp-2de1b96bbcaf715c	
6	sds	{{base_url}}/api/v1/mobile/banners	https://maralisanthe.com/customer	2026-05-10	2026-06-10	dashboard	t	2	\N	2026-05-10 08:46:41.755881	2026-05-10 08:46:41.755881	banners/banner-temp-1cff110facc4d366	
\.


--
-- Data for Name: booking_invoices; Type: TABLE DATA; Schema: public; Owner: -
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
\.


--
-- Data for Name: booking_items; Type: TABLE DATA; Schema: public; Owner: -
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
\.


--
-- Data for Name: booking_schedules; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.booking_schedules (id, customer_id, product_id, schedule_type, frequency, start_date, end_date, quantity, delivery_time, delivery_address, pincode, latitude, longitude, status, next_booking_date, total_bookings_generated, notes, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: bookings; Type: TABLE DATA; Schema: public; Owner: -
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
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.categories (id, name, description, image, status, display_order, created_at, updated_at, image_backup_url) FROM stdin;
11	Dairy Products	At Marali Santhe, we bring you pure, farm-fresh dairy products sourced directly from trusted local farmers. Our dairy range is rooted in traditional methods, ensuring natural taste, high nutrition, and zero compromise on quality.	\N	t	0	2026-03-19 08:15:24.703238	2026-03-19 08:15:24.703238	\N
12	Dairy & Farm Fresh	At Marali Santhe, we bring you pure, farm-fresh dairy products sourced directly from trusted local farmers. Our dairy range is rooted in traditional methods, ensuring natural taste, high nutrition, and zero compromise on quality.	\N	t	0	2026-03-19 08:17:09.223285	2026-03-19 08:17:09.223285	/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsiZGF0YSI6MTUsInB1ciI6ImJsb2JfaWQifX0=--7924a1d2f51547fc8e0255ca8e95bac974ef3fb4/rice.png
13	Natural Sweeteners	“Unprocessed • Farm Sourced • No Added Sugar” 	\N	t	0	2026-03-19 08:53:32.125964	2026-03-19 08:53:32.125964	/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsiZGF0YSI6MTYsInB1ciI6ImJsb2JfaWQifX0=--a90217915751dc7fcca4e3fe78f24dc27301e20c/vegetables.png
14	OILS 	At Marali Santhe, we follow a refined wood pressing process that blends traditional wisdom with precise extraction techniques. Our oils are produced without any harmful substances, ensuring they remain clean, safe, and unadulterated.\r\n\r\nEvery drop reflects purity—free from chemicals, free from contamination, and rich in natural goodness. With farm-sourced ingredients and careful processing, Marali Santhe Wood Pressed Oils deliver authenticity, nutrition, and trust in every use.	\N	t	0	2026-03-19 09:09:10.004612	2026-03-19 09:09:10.004612	\N
15	Grains & Millets	At Marali Santhe, our Grains & Millets collection brings together carefully sourced staples rooted in traditional food culture. From native rice varieties to nutrient-rich millets like ragi, jowar, and foxtail, every product is selected with a focus on quality and authenticity.\r\n\r\nSourced directly from farms, our grains and millets are free from harmful substances and unnecessary processing, ensuring you receive food in its most natural form. Whether for daily meals or traditional recipes, they offer a wholesome and balanced way to nourish your family.\r\n\r\n	\N	t	0	2026-03-19 09:28:30.674074	2026-03-19 09:28:30.674074	\N
\.


--
-- Data for Name: client_requests; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_requests (id, title, description, status, priority, customer_id, created_at, updated_at, stage, stage_updated_at, stage_history, assignee_id, department, estimated_resolution_time, actual_resolution_time, name, email, phone_number, ticket_number, admin_response, resolved_by_id, submitted_at, resolved_at) FROM stdin;
\.


--
-- Data for Name: coupons; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.coupons (id, code, description, discount_type, discount_value, minimum_amount, maximum_discount, usage_limit, used_count, valid_from, valid_until, status, applicable_products, applicable_categories, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: customer_addresses; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.customer_addresses (id, customer_id, name, mobile, address_type, address, landmark, city, state, pincode, latitude, longitude, is_default, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: customer_formats; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.customer_formats (id, customer_id, pattern, quantity, product_id, delivery_person_id, status, created_at, updated_at, days) FROM stdin;
\.


--
-- Data for Name: customer_wallets; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.customer_wallets (id, customer_id, balance, status, notes, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.customers (id, first_name, last_name, email, mobile, created_at, updated_at, longitude, latitude, whatsapp_number, auto_generated_password, location_obtained_at, location_accuracy, password_digest, middle_name, address, birth_date, gender, marital_status, pan_no, gst_no, company_name, occupation, annual_income, emergency_contact_name, emergency_contact_number, blood_group, nationality, preferred_language, notes, status, is_registered_by_mobile, password_reset_token, password_reset_sent_at) FROM stdin;
484	Dharani	Kannan	tkdharani@gmail.com	9655761911	2026-03-23 04:41:03.999238	2026-03-25 07:32:04.762238	\N	\N	\N	\N	\N	\N	$2a$12$ibrA9s9fdzW9DGn66zpm7uFsNpBat8WREnXYm/o63GnDeccgsulPm	\N	904, A block, Nester Raga Apartments, Mahadevapura, Bangalore 560048	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	ag50GLF28aW-Aipgp8ejmz89YUt_jLg02WCu2N3m4OI	2026-03-25 07:32:04.760871
487	Ajji	G	mamathanagaraju08@gmail.com	9739001874	2026-03-25 10:14:56.163746	2026-03-25 10:14:56.163746	\N	\N	\N	\N	\N	\N	$2a$12$rUKMyhjNoEYL.X2qZh8M8OYdlGrFPsdOwFlTXQqaf1BOGX9BW7Cca	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
481	raghunandan	kt	drwisedev@gmail.com	9844070041	2026-03-19 08:07:57.31055	2026-03-26 04:32:20.94922	\N	\N	\N	\N	\N	\N	$2a$12$gyqj7jB9ewkbR2pwgUS48erf/AkROt9Z/LOvPNzIYO5o9KF0Rg73m	\N	5 8th cross N.R Layout R.M Nagar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	532cd3806192bd80d241829dc89e74a2574681e930b96d9cd4e4160672934e46	2026-03-26 04:38:33.855333
482	John	Doe	gepeucoubourou-9168@yopmail.com	7349673793	2026-03-21 07:05:43.706315	2026-03-21 07:05:43.706315	\N	\N	\N	\N	\N	\N	$2a$12$b11ijjC00wkGnr6d9vLJeuWTMrEJRZwzanI5zCP91gRvL1uEY9d5i	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
488	raghu	kt	raghubit040@gmail.com	9035378833	2026-03-27 15:04:43.94646	2026-03-27 15:04:43.94646	\N	\N	\N	\N	\N	\N	$2a$12$82om7QXn65cvoQC0HpLYh.kjSvJcom48TYEaqFVhpsgzTkCP0HzCy	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
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
520	Raghu	Kt	raghukt.shetty89@gmail.com	9035408833	2026-05-04 10:46:16.277596	2026-05-04 10:46:16.277596	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N
521	pramod	bhat	pramodbha8899@gmail.com	9898989898	2026-05-06 07:54:21.102936	2026-05-06 07:54:21.102936	\N	\N	\N	\N	\N	\N	$2a$12$PsNgEks5tWjin7q.01/EdOyAez5HsQ1cVaw.vxAX.XUmOvaJTMfN2	\N	ds	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
522	Ashwini	Seetharam	ashwini_74@yahoo.com	9686758463	2026-05-06 11:24:26.973129	2026-05-06 11:24:26.973129	\N	\N	\N	\N	\N	\N	$2a$12$n.P/cmWVEOXX3FJyIIFvQeTLKVYtMKfRBddmnSX6BJ3jre3LH1ax6	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
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
\.


--
-- Data for Name: delivery_charges; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.delivery_charges (id, pincode, area, charge_amount, is_active, created_at, updated_at) FROM stdin;
3	560003	Malleshwaram	60.00	t	2026-04-17 11:26:47.950762	2026-05-04 16:34:52.895851
4	560004	Rajajinagar	55.00	t	2026-04-17 11:26:49.154149	2026-05-04 16:51:40.407046
5	560005	Basavanagudi	45.00	t	2026-04-17 11:26:50.366011	2026-05-04 16:54:12.406144
1	560001	MG Road	50.00	t	2026-04-17 11:26:45.526608	2026-05-04 16:54:23.542827
2	560002	Brigade Road	56.00	t	2026-04-17 11:26:46.740864	2026-05-05 00:30:32.856511
6	560097	sd	344.00	t	2026-05-05 00:32:02.002367	2026-05-05 00:32:13.91043
7	560086	MgRoad	50.00	t	2026-05-09 04:35:26.912701	2026-05-09 04:35:26.912701
\.


--
-- Data for Name: delivery_people; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.delivery_people (id, first_name, last_name, email, mobile, vehicle_type, vehicle_number, license_number, address, city, state, pincode, emergency_contact_name, emergency_contact_mobile, joining_date, salary, status, profile_picture, bank_name, account_no, ifsc_code, account_holder_name, delivery_areas, notes, created_at, updated_at, password_digest, auto_generated_password) FROM stdin;
17	Javeed	Patel	maralisanthe@gmail.com	917975918232	0	KA01HE1711	12345678	NR colony Bangalore	Bangalore	Karnataka	560004	marali santhe 	919035408833	2025-12-03	15000.0	t	\N					bangalore 		2026-03-20 07:59:01.645379	2026-03-20 07:59:01.645379	$2a$12$fQKLXUAsdXmubzS3QXLGv.oyF1LIonmfs8SD0pDCskzzyW2aFz9fi	\N
\.


--
-- Data for Name: delivery_rules; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.delivery_rules (id, product_id, rule_type, location_data, is_excluded, delivery_days, delivery_charge, created_at, updated_at) FROM stdin;
42	45	0	[]	f	7	0.00	2026-03-19 09:25:14.380198	2026-03-19 14:16:08.250853
37	40	0	[]	f	7	0.00	2026-03-19 09:11:09.334159	2026-03-19 14:18:47.724587
39	42	0	[]	f	7	0.00	2026-03-19 09:15:33.460407	2026-03-19 14:20:23.015878
35	38	0	[]	f	7	0.00	2026-03-19 08:58:29.728736	2026-03-19 14:25:37.333121
36	39	0	[]	f	7	0.00	2026-03-19 09:01:27.951028	2026-03-19 14:27:19.51386
43	46	0	[]	f	7	0.00	2026-03-19 09:30:21.404347	2026-03-19 14:30:18.719324
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
52	55	0	[]	f	7	0.00	2026-04-19 15:21:06.419069	2026-05-04 15:27:48.140876
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
\.


--
-- Data for Name: device_tokens; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.device_tokens (id, customer_id, delivery_person_id, token, device_type, active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: expenses; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.expenses (id, store_id, created_by_id, title, description, amount, category, expense_date, created_at, updated_at) FROM stdin;
1	13	106	sdfds	sd	23.00	Staff Salaries	2026-05-17	2026-05-17 13:41:25.503147	2026-05-17 13:41:25.503147
\.


--
-- Data for Name: franchises; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.franchises (id, name, email, mobile, contact_person_name, business_type, address, city, state, pincode, pan_no, gst_no, license_no, establishment_date, territory, franchise_fee, commission_percentage, status, notes, password_digest, auto_generated_password, longitude, latitude, whatsapp_number, profile_image, business_documents, created_at, updated_at, user_id) FROM stdin;
11	dsdsfdsd	dfsfdfdsfdsfds9093939393fdfds@gmail.com	09190939001	sdfdd	\N	sdfa	Bangalore	karnataka	\N	\N	\N	\N	\N	\N	\N	10.0	t	\N	\N	f4S%1F6A#g	\N	\N	\N	\N	\N	2026-05-09 12:57:07.618526	2026-05-09 12:57:07.618526	92
12	aadad	9093939sdsd393fdfds@gmail.com	+91 98099 80101		\N	sasa	Bangalore	karnataka	\N	\N	\N	\N	\N	\N	\N	10.0	t	\N	\N	3mLq@fZ3#m	\N	\N	\N	\N	\N	2026-05-10 05:28:17.895079	2026-05-10 05:28:17.895079	93
\.


--
-- Data for Name: invoice_items; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.invoice_items (id, invoice_id, milk_delivery_task_id, description, quantity, unit_price, total_amount, created_at, updated_at, product_id) FROM stdin;
409	318	\N	zxxz - Booking #BK202605091460 (09 May 2026)	1.0	1.0	1.0	2026-05-09 06:22:52.006426	2026-05-09 06:22:52.006426	99
410	319	\N	BARLEY WHOLE [500GM] - Booking #BK20260509592224 (09 May 2026)	1.0	33.6734693877551057142857142857143979591836734694	33.6734693877551057142857142857143979591836734694	2026-05-09 06:24:45.334384	2026-05-09 06:24:45.334384	80
\.


--
-- Data for Name: invoices; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.invoices (id, invoice_number, payout_type, payout_id, total_amount, status, invoice_date, due_date, paid_at, created_at, updated_at, customer_id, payment_status, share_token, quick_invoice, paid_amount) FROM stdin;
318	INV-05-00001	\N	\N	1.0	sent	2026-05-09	2026-06-08	2026-05-09 06:22:51.294302	2026-05-09 06:22:51.927605	2026-05-09 06:22:51.927605	524	2	E1GjXn2nNoFADNqLXJ7IC5q_6sst4zk8aGA7nm-NJDI	t	0.00
319	INV-05-00002	\N	\N	33.6734693877551057142857142857143979591836734694	sent	2026-05-09	2026-06-08	2026-05-09 06:24:44.857335	2026-05-09 06:24:45.256421	2026-05-09 06:24:45.256421	516	2	vcbIIEZk3in65XnvblFjOoNTTnKlrwHf38WV2C8_Kt0	t	0.00
\.


--
-- Data for Name: leads; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.leads (id, name, contact_number, email, current_stage, lead_source, created_at, updated_at, product_category, product_subcategory, customer_type, affiliate_id, is_direct, first_name, last_name, middle_name, company_name, gender, marital_status, pan_no, gst_no, height, weight, annual_income, business_job) FROM stdin;
\.


--
-- Data for Name: milk_delivery_tasks; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.milk_delivery_tasks (id, subscription_id, customer_id, product_id, quantity, unit, delivery_date, delivery_person_id, status, assigned_at, completed_at, delivery_notes, created_at, updated_at, invoiced, invoiced_at) FROM stdin;
\.


--
-- Data for Name: milk_subscriptions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.milk_subscriptions (id, customer_id, product_id, quantity, unit, start_date, end_date, delivery_time, delivery_pattern, specific_dates, total_amount, status, is_active, created_by, created_at, updated_at, delivery_person_id) FROM stdin;
\.


--
-- Data for Name: notes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.notes (id, title, paid_to, amount, payment_method, reference_number, description, status, note_date, created_by_user_id, created_at, updated_at, paid_from, paid_to_category) FROM stdin;
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.notifications (id, customer_id, title, message, notification_type, data, read, read_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_items (id, order_id, product_id, quantity, price, total, created_at, updated_at, product_variant_id) FROM stdin;
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.orders (id, customer_id, user_id, order_number, order_date, status, payment_method, payment_status, subtotal, tax_amount, discount_amount, shipping_amount, total_amount, notes, order_items, customer_name, customer_email, customer_phone, delivery_address, tracking_number, delivered_at, created_at, updated_at, processing_notes, estimated_processing_time, processing_started_at, packed_by, package_weight, package_dimensions, packing_notes, packed_at, shipping_carrier, estimated_delivery_date, shipping_cost, shipping_notes, shipped_at, delivered_to, delivery_location, delivery_notes, cancelled_at, cancellation_reason, refund_method, refund_amount, cancellation_notes, invoice_generated, invoice_number, cash_received, change_amount, order_stage, booking_date, booking_id) FROM stdin;
\.


--
-- Data for Name: pending_amounts; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.pending_amounts (id, customer_id, amount, description, pending_date, status, notes, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.permissions (id, name, resource, action, description, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: product_ratings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_ratings (id, product_id, customer_id, user_id, rating, comment, status, reviewer_name, reviewer_email, verified_purchase, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: product_reviews; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_reviews (id, product_id, customer_id, user_id, rating, comment, reviewer_name, reviewer_email, status, verified_purchase, helpful_count, pros, cons, title, images_data, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: product_variants; Type: TABLE DATA; Schema: public; Owner: -
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
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.products (id, name, description, category_id, price, discount_price, stock, status, sku, weight, dimensions, meta_title, meta_description, tags, created_at, updated_at, discount_type, discount_value, original_price, discount_amount, is_discounted, gst_enabled, gst_percentage, cgst_percentage, sgst_percentage, igst_percentage, gst_amount, cgst_amount, sgst_amount, igst_amount, final_amount_with_gst, buying_price, yesterday_price, today_price, price_change_percentage, last_price_update, price_history, is_occasional_product, occasional_start_date, occasional_end_date, occasional_description, occasional_auto_hide, product_type, occasional_schedule_type, occasional_recurring_from_day, occasional_recurring_from_time, occasional_recurring_to_day, occasional_recurring_to_time, is_subscription_enabled, unit_type, minimum_stock_alert, default_selling_price, hsn_code, image_url, additional_images_urls, display_order, base_price_excluding_gst, r2_image_url, r2_additional_images, has_multiple_quantities, barcode) FROM stdin;
39	HONEY WILD [300GM]	Experience the true taste of nature with our raw honey, sourced directly from trusted farms and forests. This honey is completely unprocessed, ensuring that all its natural nutrients, enzymes, and rich flavor are preserved just as nature intended.\r\n\r\nFree from any form of adulteration, our honey contains no additives, no preservatives, and absolutely no added sugar. What you get is 100% pure honey, untouched and unfiltered, with its natural aroma, texture, and goodness intact.\r\n\r\nCarefully collected and minimally handled, this honey retains its authentic taste and health benefits, making it a perfect natural sweetener for your daily needs.	13	380.00	\N	2	active	NATE21547	\N					2026-03-19 09:01:27.91591	2026-03-19 14:27:19.483523	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	18.10	\N	\N	\N	380.00	195.00	380.00	380.00	0.00	2026-03-19 09:01:27.915658	[{"date":"2026-03-19","price":"380.0","timestamp":1773910887}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N	products/product-temp-afa91f0185a16277		\N	361.9			f	PRD-000039
44	MUSTARD OIL [1LTR]	Experience the bold character of Marali Santhe Wood Pressed Mustard Oil, produced through a refined traditional process that ensures clean and consistent extraction. Free from chemicals, additives, and harmful contaminants, this oil retains its natural pungency and richness.\r\n\r\nSourced directly from farms and processed with precision, it offers depth of flavor, purity, and reliability—perfect for traditional cooking and everyday use.	14	370.00	\N	5	active	OIL2FB4ED	\N					2026-03-19 09:23:10.632063	2026-03-19 14:11:28.201931	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	17.62	\N	\N	\N	370.00	275.00	370.00	370.00	0.00	2026-03-19 09:23:10.631858	[{"date":"2026-03-19","price":"370.0","timestamp":1773912190}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Liter	\N	\N	\N	products/product-temp-1512885373b596f8		\N	352.38			f	PRD-000044
42	COCONUT OIL [1LTR]	Marali Santhe Wood Pressed Coconut Oil is crafted using traditional extraction methods combined with precise milling to preserve its natural purity and aroma. Made from carefully sourced coconuts, this oil is free from harmful substances, additives, and contamination.\r\n\r\nWith its rich natural fragrance and smooth texture, it is perfect for cooking, sautéing, and traditional recipes. It also serves as a versatile oil for daily use, bringing authenticity, purity, and nourishment into your lifestyle.	14	650.00	\N	3	active	OIL16DE03	\N					2026-03-19 09:15:33.429197	2026-03-19 14:20:22.988153	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	30.95	\N	\N	\N	650.00	450.00	650.00	650.00	0.00	2026-03-19 09:15:33.42893	[{"date":"2026-03-19","price":"650.0","timestamp":1773911733}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Liter	\N	\N	\N	products/product-temp-8f3c981bdf9adb09		\N	619.05			f	PRD-000042
40	GROUNDNUT OIL [1LTR]	Experience the purity of Marali Santhe Wood Pressed Groundnut Oil, produced through a carefully controlled traditional process that ensures clean and consistent extraction. Free from chemicals, additives, and harmful contaminants, this oil retains its authentic taste and natural goodness.\r\n\r\nSourced directly from farms and processed with precision, it delivers rich flavor, nutritional value, and unmatched quality—making it a trusted choice for daily cooking.	14	345.00	\N	0	active	OIL058162	\N					2026-03-19 09:11:09.303212	2026-03-19 14:18:47.698323	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	345.00	250.00	345.00	345.00	0.00	2026-03-19 09:11:09.302943	[{"date":"2026-03-19","price":"345.0","timestamp":1773911469}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Liter	\N	\N	\N	products/product-temp-83daca59c366f761		\N	\N			f	PRD-000040
43	SESAME OIL [1LTR]	Marali Santhe Wood Pressed Sesame Oil is crafted using traditional extraction methods combined with precise milling to preserve its natural richness and purity. Made from farm-sourced sesame seeds, this oil is free from harmful substances, additives, and contamination.\r\n\r\nKnown for its distinct aroma and deep flavor, it enhances traditional dishes and everyday cooking. Carefully processed to retain its natural qualities, it brings authenticity, taste, and nourishment to your kitchen.	14	490.00	\N	0	active	OIL345526	\N					2026-03-19 09:18:09.767699	2026-03-19 14:13:29.644354	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	23.33	\N	\N	\N	490.00	360.00	490.00	490.00	0.00	2026-03-19 09:18:09.767433	[{"date":"2026-03-19","price":"490.0","timestamp":1773911889}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Liter	\N	\N	\N	products/product-temp-4d39ebc75ee49e62		\N	466.67			f	PRD-000043
45	SAFFLOWER OIL [1LTR]	Marali Santhe Wood Pressed Safflower Oil is produced through a refined traditional process that ensures clean and consistent extraction. Free from chemicals, additives, and harmful contaminants, this oil maintains its naturally light character and purity.\r\n\r\nSourced directly from farms and processed with precision, it delivers a smooth and clean cooking experience—making it an ideal choice for everyday use	14	530.00	\N	4	active	OILC25966	\N					2026-03-19 09:25:14.348315	2026-03-19 14:16:08.222553	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	25.24	\N	\N	\N	530.00	395.00	530.00	530.00	0.00	2026-03-19 09:25:14.348038	[{"date":"2026-03-19","price":"530.0","timestamp":1773912314}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Liter	\N	\N	\N	products/product-temp-202d1204e5679f80		\N	504.76			f	PRD-000045
60	DOSA RICE [1KG]	“Perfect dosa starts with the right rice 🌾✨\r\nSingle polished dosa rice for that soft idli & crispy golden dosa 😍\r\n\r\nLess processed, more authentic taste!	15	110.00	\N	0	active	GRA927EDD	\N					2026-05-04 12:42:51.031957	2026-05-04 12:42:51.031957	\N	\N	\N	\N	f	t	4.99	\N	\N	\N	5.00	\N	\N	\N	110.00	49.00	110.00	110.00	0.00	2026-05-04 12:42:51.031366	[{"date":"2026-05-04","price":"110.0","timestamp":1777898571}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	105.0	\N	\N	f	PRD-000060
61	IDLI RICE [1KG]	✨ Single polished – retains more natural nutrients\r\n✨ Perfect for soft, fluffy idlis\r\n✨ Ferments well for better rise & texture\r\n✨ Clean, quality grains for everyday use\r\n\r\n🌱 Traditional taste with a healthier touch	15	110.00	\N	5	active	GRA59049E	1.000					2026-05-04 12:44:45.574035	2026-05-04 12:44:45.574035	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	5.00	\N	\N	\N	110.00	65.00	110.00	110.00	0.00	2026-05-04 12:44:45.573807	[{"date":"2026-05-04","price":"110.0","timestamp":1777898685}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	105.0	\N	\N	f	PRD-000061
62	MAPILLAI SAMBA RICE [1KG]	✨ Ancient Tamil Nadu variety 🌾\r\n✨ Naturally rich in iron & minerals\r\n✨ High fiber – keeps you full longer\r\n✨ Known for boosting strength & stamina 💪\r\n\r\n🌱 Unpolished • Traditional • Nutrient-rich	15	180.00	\N	0	active	GRA7096FF	\N					2026-05-04 12:46:47.936456	2026-05-04 12:46:47.936456	percentage	\N	\N	\N	f	t	5.00	\N	\N	\N	9.00	\N	\N	\N	180.00	120.00	180.00	180.00	0.00	2026-05-04 12:46:47.936208	[{"date":"2026-05-04","price":"180.0","timestamp":1777898807}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	171.0	\N	\N	f	PRD-000062
35	A2 DESI COW GHEE [500ML]	Experience purity the traditional way with Marali Santhe A2 Desi Cow Ghee, crafted using the time-honored Bilona method. This authentic process preserves the natural nutrients, aroma, and richness that modern methods often lose.\r\n\r\nOur ghee is made from fresh, cultured butter sourced from high-quality milk of indigenous cows. The butter is slowly churned and gently simmered in small batches to bring out the golden texture, grainy consistency, and rich aroma that define true desi ghee.\r\n\r\nEvery jar reflects our commitment to tradition, quality, and purity — delivering not just taste, but nourishment rooted in heritage.	12	750.00	\N	0	active	DAI6D3E30	\N					2026-03-19 08:25:49.262541	2026-05-10 07:25:02.820005	percentage	\N	\N	\N	f	f	5.00	\N	\N	\N	\N	\N	\N	\N	750.00	500.00	750.00	750.00	0.00	2026-03-19 08:25:49.262216	[{"date":"2026-03-19","price":"750.0","timestamp":1773908749}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Liter	\N	\N	\N	products/product-temp-66ccfd5c98557d3e		\N	714.0			f	PRD-000035
38	HONEY RAW [300GM]	Experience the true taste of nature with our raw honey, sourced directly from trusted farms and forests. This honey is completely unprocessed, ensuring that all its natural nutrients, enzymes, and rich flavor are preserved just as nature intended.\r\n\r\nFree from any form of adulteration, our honey contains no additives, no preservatives, and absolutely no added sugar. What you get is 100% pure honey, untouched and unfiltered, with its natural aroma, texture, and goodness intact.\r\n\r\nCarefully collected and minimally handled, this honey retains its authentic taste and health benefits, making it a perfect natural sweetener for your daily needs.	13	270.00	\N	0	active	NATB11DA3	\N					2026-03-19 08:58:29.700127	2026-03-19 14:25:37.304229	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	12.86	\N	\N	\N	270.00	180.00	270.00	270.00	0.00	2026-03-19 08:58:29.699889	[{"date":"2026-03-19","price":"270.0","timestamp":1773910709}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N	products/product-temp-b03032958a2f40c3		\N	257.14			f	PRD-000038
37	DESI BUTTER [500GM]	Indulge in the richness of Marali Santhe A2 Fresh Butter, crafted from high-quality milk sourced from indigenous cows. Made in small batches, our butter is fresh, natural, and full of authentic flavor, bringing you the taste of traditional homemade makkhan.\r\n\r\nPrepared with care and without any additives, this butter retains its natural aroma, soft texture, and wholesome goodness — perfect for everyday use and traditional recipes.\r\n\r\nPacked in eco-friendly, biodegradable packaging, we ensure not just purity in what you eat, but responsibility in how it’s delivered.	12	600.00	\N	1	active	DAIEF43F7	\N					2026-03-19 08:49:25.758241	2026-03-19 13:53:14.187043	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	28.57	\N	\N	\N	600.00	480.00	600.00	600.00	0.00	2026-03-19 08:49:25.757978	[{"date":"2026-03-19","price":"600.0","timestamp":1773910165}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N	products/product-temp-d3529647965d4da3		\N	571.43			f	PRD-000037
41	SUNFLOWER OIL [1LTR]	Marali Santhe Wood Pressed Sunflower Oil is produced through a refined traditional process that ensures clean and consistent extraction. Free from chemicals, additives, and harmful contaminants, this oil maintains its natural lightness and purity.\r\n\r\nSourced directly from farms and processed with precision, it delivers a smooth cooking experience with a clean finish—making it an ideal choice for modern and everyday cooking needs	14	350.00	\N	0	active	OIL642EB9	\N					2026-03-19 09:13:09.545141	2026-03-19 14:09:41.833902	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	16.67	\N	\N	\N	350.00	250.00	350.00	350.00	0.00	2026-03-19 09:13:09.544919	[{"date":"2026-03-19","price":"350.0","timestamp":1773911589}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Liter	\N	\N	\N	products/product-temp-0e5d0690afd68444		\N	333.33			f	PRD-000041
47	SONA MASURI RICE [1KG]	Marali Santhe Sona Masuri Rice is a popular everyday rice variety known for its light texture, subtle aroma, and versatility. Sourced directly from farms and carefully processed, it retains its natural qualities without exposure to harmful substances or unnecessary refinement.\r\n\r\nPerfect for daily cooking, this rice cooks soft and fluffy, making it ideal for a variety of dishes. With its balanced taste and purity, it brings consistency, quality, and comfort to your everyday meals.	15	130.00	\N	16	active	GRA9F3769	\N					2026-03-19 09:33:46.36704	2026-03-19 14:32:00.757379	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	6.19	\N	\N	\N	130.00	68.00	130.00	130.00	0.00	2026-03-19 09:33:46.366803	[{"date":"2026-03-19","price":"130.0","timestamp":1773912826}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N	products/product-temp-d185cec48ee0c9f7		\N	123.81			f	PRD-000047
48	SONA MASURI RICE [5KG]	Marali Santhe Sona Masuri Rice is a popular everyday rice variety known for its light texture, subtle aroma, and versatility. Sourced directly from farms and carefully processed, it retains its natural qualities without exposure to harmful substances or unnecessary refinement.\r\n\r\nPerfect for daily cooking, this rice cooks soft and fluffy, making it ideal for a variety of dishes. With its balanced taste and purity, it brings consistency, quality, and comfort to your everyday meals.	15	600.00	570.00	5	active	GRA1E5641	\N					2026-03-19 09:35:13.505614	2026-03-19 14:33:31.155797	percentage	\N	\N	\N	t	t	5.00	\N	\N	\N	27.14	\N	\N	\N	570.00	360.00	600.00	600.00	0.00	2026-03-19 09:35:13.50536	[{"date":"2026-03-19","price":"600.0","timestamp":1773912913}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N	products/product-temp-a72d95ec8a8e061d		\N	542.86			f	PRD-000048
49	Test	we	11	100.00	\N	308	active	23	\N					2026-03-25 03:36:33.683134	2026-03-25 04:48:02.974255	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	5.00	\N	\N	\N	100.00	12.00	100.00	100.00	0.00	2026-03-25 03:36:33.682656	[{"date":"2026-03-25","price":"100.0","timestamp":1774409793}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	95.0	\N	\N	f	PRD-000049
50	Test product	sd	11	1.00	\N	982	active	23sdsdsdss	\N					2026-03-29 05:32:37.587278	2026-05-03 05:18:49.497935	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	1.00	23.00	1.00	1.00	0.00	2026-03-29 05:32:37.587002	[{"date":"2026-03-29","price":"1.0","timestamp":1774762357}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	\N	\N	\N	f	PRD-000050
51	HANDPOUNDED-RICE-UNPOLISHED-1KG	Back to roots. Back to real food 🌾✨\r\n\r\nExperience the goodness of Handpounded Unpolished Rice at Marali Santhe – traditionally processed to retain its natural fiber, nutrients, and authentic taste. Unlike polished rice, every grain carries the richness of nature just the way it should be.\r\n\r\n🌿 Rich in fiber & nutrients\r\n💛 Naturally wholesome & healthy\r\n🍚 Perfect for everyday traditional meals\r\n\r\nEat clean. Eat real.	15	160.00	\N	0	active	GRABD59D6	1.000					2026-04-16 07:23:03.334696	2026-04-16 07:23:03.334696	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	8.00	\N	\N	\N	160.00	112.00	160.00	160.00	0.00	2026-04-16 07:23:03.334331	[{"date":"2026-04-16","price":"160.0","timestamp":1776324183}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	152.0	\N	\N	f	PRD-000051
56	DESI COW GHEE [1LTR]	Liquid Gold from Our Roots ✨🐄\r\n\r\nCrafted the traditional way using Bilona method, our Desi Cow Ghee is a celebration of purity, nourishment, and heritage.\r\n\r\nMade from A2 milk of indigenous cows, this ghee carries the rich aroma of authenticity and the goodness your body truly deserves.\r\n\r\n✔️ Hand-churned from curd\r\n✔️ Slow-cooked for rich texture & aroma\r\n✔️ No additives. No shortcuts.\r\n✔️ Pure, sattvic, and wholesome\r\n\r\nFrom boosting digestion to enhancing immunity, every spoon is a step towards healthier living 💛	11	1100.00	\N	0	active	DAI0562CB	1.000					2026-04-30 15:40:23.465432	2026-04-30 15:40:23.465432	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	52.00	\N	\N	\N	1100.00	780.00	1100.00	1100.00	0.00	2026-04-30 15:40:23.465184	[{"date":"2026-04-30","price":"1100.0","timestamp":1777563623}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Liter	\N	\N	\N			\N	1048.0	\N	\N	f	PRD-000056
53	JAGGERY-POWDER-1KG	Sweetness the natural way 🌿✨\r\n\r\nSwitch to healthier living with Organic Jaggery Powder from Marali Santhe – unrefined, chemical-free, and packed with natural goodness. Made using traditional methods, it retains essential minerals and gives you that rich, authentic taste in every spoon.\r\n\r\n🌾 No chemicals | No refining\r\n💛 Rich in iron & nutrients\r\n🍯 Perfect natural sweetener for daily use\r\n\r\nDitch refined sugar. Choose purity.	15	140.00	\N	9	active	GRA09A69C	1.000					2026-04-16 07:28:59.693081	2026-04-16 07:28:59.693081	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	7.00	\N	\N	\N	140.00	85.00	140.00	140.00	0.00	2026-04-16 07:28:59.692822	[{"date":"2026-04-16","price":"140.0","timestamp":1776324539}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	133.0	\N	\N	f	PRD-000053
54	DESI COW GHEE [500ML]	Pure Desi Ghee – Made the Traditional Way ✨🥄\r\n\r\nCrafted from the milk of mixed A2 desi cows, our ghee brings you the richness of authentic Indian goodness. Slow-churned using traditional methods to preserve aroma, taste, and nutrition.\r\n\r\nGolden in color, rich in flavor, and packed with natural benefits — this is not just ghee, it’s purity in every spoon 🌿\r\n\r\nPerfect for daily cooking, पूजा, and adding that nostalgic desi touch to your meals.	11	600.00	\N	0	active	DAI7A15C2	1.000					2026-04-19 15:18:46.333291	2026-04-19 15:19:07.002706	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	29.00	\N	\N	\N	600.00	370.00	600.00	600.00	0.00	2026-04-19 15:18:46.332991	[{"date":"2026-04-19","price":"600.0","timestamp":1776611926}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Liter	\N	\N	\N			\N	571.0	\N	\N	f	PRD-000054
58	BASUMATHI-RICE [1KG]	“Perfect balance of taste and health 🌾✨\r\nSingle polished basmati rice – not too processed, not too raw.\r\n\r\nLong, aromatic grains that cook fluffy every time 🍽️	15	280.00	\N	4	active	GRAA53C15	1.000					2026-05-04 12:39:06.166803	2026-05-04 12:39:06.166803	\N	\N	\N	\N	f	t	4.99	\N	\N	\N	13.00	\N	\N	\N	280.00	142.00	280.00	280.00	0.00	2026-05-04 12:39:06.165978	[{"date":"2026-05-04","price":"280.0","timestamp":1777898346}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	267.0	\N	\N	f	PRD-000058
52	WHEAT-FLOUR-1KG	Pure grains. Honest nourishment 🌾✨\r\n\r\nBring home the goodness of Organic Wheat Flour from Marali Santhe – stone-ground and naturally processed to preserve its nutrition, aroma, and authentic taste. Made from carefully sourced grains, it’s the perfect choice for soft rotis and healthy meals every day.\r\n\r\n🌿 100% Organic & chemical-free\r\n💛 Rich in fiber & nutrients\r\n🔥 Freshly milled for better taste & quality\r\n\r\nWholesome food begins with the right flour.	15	80.00	\N	6	active	GRACBFF4A	1.000					2026-04-16 07:26:39.295637	2026-04-16 07:30:01.407274	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	4.00	\N	\N	\N	80.00	47.00	80.00	80.00	0.00	2026-04-16 07:26:39.295274	[{"date":"2026-04-16","price":"80.0","timestamp":1776324399}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	76.0	\N	\N	f	PRD-000052
46	RAJMUDI RICE [1KG]	Experience the legacy of traditional grains with Marali Santhe Rajamudi Rice—a heritage variety known for its rich character and cultural significance. Farm sourced and carefully handled to preserve its natural integrity, this rice remains free from harmful substances and excessive processing.\r\n\r\nWith its unique color, texture, and depth of flavor, Rajamudi Rice reflects purity, tradition, and mindful eating—bringing back the essence of authentic, wholesome food.	15	130.00	\N	16	active	GRAFA358B	\N					2026-03-19 09:30:21.373073	2026-03-19 14:30:18.673026	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	6.19	\N	\N	\N	130.00	83.00	130.00	130.00	0.00	2026-03-19 09:30:21.37285	[{"date":"2026-03-19","price":"130.0","timestamp":1773912621}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N	products/product-temp-447efd9a2e6afc90		\N	123.81			f	PRD-000046
57	GROUND NUT OIL [3LTRs]	Purity You Can Taste. Tradition You Can Trust. 🌿✨\r\n\r\nExtracted using the age-old wood-pressed (Lakdi Ghani) method, our Groundnut Oil retains its natural nutrients, aroma, and authentic flavor.\r\n\r\nSlow extraction ensures the oil stays chemical-free, unrefined, and full of life—just the way nature intended.\r\n\r\n✔️ Cold pressed in wooden churner\r\n✔️ No chemicals. No refining.\r\n✔️ Rich in natural antioxidants & healthy fats\r\n✔️ Perfect for everyday cooking\r\n\r\nFrom crispy dosas to soulful curries, elevate your cooking with the richness of tradition 🥜💛\r\n\r\nBecause real food deserves real oil.	14	1035.00	\N	0	active	OILC70C7B	\N					2026-04-30 15:45:11.971201	2026-04-30 15:45:11.971201	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	49.00	\N	\N	\N	1035.00	750.00	1035.00	1035.00	0.00	2026-04-30 15:45:11.970945	[{"date":"2026-04-30","price":"1035.0","timestamp":1777563911}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Liter	\N	\N	\N			\N	986.0	\N	\N	f	PRD-000057
63	BARNYARD - OODHLU [1KG]	Barnyard millet is one of the lightest and healthiest millets—perfect for everyday eating 👇\r\n\r\n💪 Key Benefits\r\n\r\n1. Diabetic-Friendly 🩺\r\nLow glycemic index\r\nHelps control blood sugar levels\r\n\r\n2. High in Fiber 🌿\r\nImproves digestion\r\nKeeps you full for longer (good for weight loss)\r\n\r\n3. Rich in Iron & Minerals\r\nSupports energy levels\r\nHelps prevent anemia\r\n\r\n4. Gluten-Free 🌱\r\nIdeal for people with gluten intolerance\r\nLight on the stomach\r\n\r\n5. Supports Heart Health ❤️\r\nHelps reduce cholesterol\r\nGood for overall cardiovascular health\r\n\r\n6. Detox & Gut Health ✨\r\nEasy to digest\r\nHelps cleanse the system\r\n\r\n🍽️ How to Use\r\nUpma / Pongal\r\nMillet rice replacement\r\nKhichdi\r\nDosa / Idli mix	15	175.00	\N	0	active	GRA303082	\N					2026-05-04 12:52:47.188238	2026-05-04 12:52:47.188238	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	8.00	\N	\N	\N	175.00	115.00	175.00	175.00	0.00	2026-05-04 12:52:47.188025	[{"date":"2026-05-04","price":"175.0","timestamp":1777899167}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	167.0	\N	\N	f	PRD-000063
64	BARNYARD - OODHLU [500GM]	Barnyard millet is one of the lightest and healthiest millets—perfect for everyday eating 👇\r\n\r\n💪 Key Benefits\r\n\r\n1. Diabetic-Friendly 🩺\r\nLow glycemic index\r\nHelps control blood sugar levels\r\n\r\n2. High in Fiber 🌿\r\nImproves digestion\r\nKeeps you full for longer (good for weight loss)\r\n\r\n3. Rich in Iron & Minerals\r\nSupports energy levels\r\nHelps prevent anemia\r\n\r\n4. Gluten-Free 🌱\r\nIdeal for people with gluten intolerance\r\nLight on the stomach\r\n\r\n5. Supports Heart Health ❤️\r\nHelps reduce cholesterol\r\nGood for overall cardiovascular health\r\n\r\n6. Detox & Gut Health ✨\r\nEasy to digest\r\nHelps cleanse the system\r\n\r\n🍽️ How to Use\r\nUpma / Pongal\r\nMillet rice replacement\r\nKhichdi\r\nDosa / Idli mix	15	90.00	\N	0	active	GRAB544B8	\N					2026-05-04 12:54:28.899474	2026-05-04 12:54:28.899474	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	4.00	\N	\N	\N	90.00	57.00	90.00	90.00	0.00	2026-05-04 12:54:28.899269	[{"date":"2026-05-04","price":"90.0","timestamp":1777899268}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	86.0	\N	\N	f	PRD-000064
65	BROWNTOP - KORLE [1KG]	Browntop millet is one of the most powerful traditional millets, especially for detox and weight control 👇\r\n\r\n💪 Key Benefits\r\n\r\n1. Excellent for Weight Loss ⚖️\r\nVery high fiber\r\nKeeps you full for longer, reduces cravings\r\n\r\n2. Supports Detox & Liver Health ✨\r\nHelps cleanse the body naturally\r\nGood for gut and liver function\r\n\r\n3. Diabetic-Friendly 🩺\r\nLow glycemic index\r\nHelps regulate blood sugar levels\r\n\r\n4. Rich in Fiber & Minerals 🌿\r\nImproves digestion\r\nSupports overall gut health\r\n\r\n5. Good for Heart Health ❤️\r\nHelps reduce cholesterol\r\nSupports better circulation\r\n\r\n6. Naturally Gluten-Free 🌱\r\nEasy to digest\r\nGreat alternative to rice/wheat\r\n\r\n🍽️ How to Use\r\nMillet rice (instead of white rice)\r\nUpma / Pongal\r\nDosa / Idli batter\r\nKhichdi	15	320.00	\N	0	active	GRA77D4EC	\N					2026-05-04 12:58:26.1765	2026-05-04 12:58:26.1765	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	15.00	\N	\N	\N	320.00	135.00	320.00	320.00	0.00	2026-05-04 12:58:26.176238	[{"date":"2026-05-04","price":"320.0","timestamp":1777899506}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	305.0	\N	\N	f	PRD-000065
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
78	COW BUTTER [500GM]	✨ Made from A2 desi cow milk\r\n✨ Traditionally hand-churned (Bilona method)\r\n✨ Pure, chemical-free & farm-fresh\r\n✨ Rich, creamy texture with natural aroma\r\n\r\n🌱 No preservatives • No additives • 100% natural\r\n\r\n💪 Key Benefits\r\n\r\n1. Rich in Healthy Fats 🧈\r\nSupports energy and nourishment\r\nGood for overall strength\r\n\r\n2. Boosts Immunity 💪\r\nContains fat-soluble vitamins (A, D, E, K)\r\nSupports body’s natural defense\r\n\r\n3. Good for Digestion 🌿\r\nTraditionally known to improve gut health\r\nEasy to digest when consumed in moderation\r\n\r\n4. Supports Skin & Glow ✨\r\nNatural healthy fats help nourish skin\r\n\r\n🍽️ How to Use\r\nWith hot rice or roti\r\nSpread on dosa / chapati\r\nAdd to dal for rich taste\r\nUse as a base for making ghee	15	600.00	\N	4	active	GRAA34D1F	\N					2026-05-04 14:14:44.837073	2026-05-04 14:14:44.837073	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	29.00	\N	\N	\N	600.00	480.00	600.00	600.00	0.00	2026-05-04 14:14:44.836817	[{"date":"2026-05-04","price":"600.0","timestamp":1777904084}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	571.0	\N	\N	f	PRD-000078
79	BUFFALO BUTTER [500GM]	✨ Made from fresh buffalo milk\r\n✨ Extra creamy, thick & rich texture\r\n✨ Naturally high in fat for better taste\r\n✨ Perfect for cooking & indulgence\r\n\r\n🌱 No preservatives • Pure & farm-fresh\r\n\r\n💪 Key Benefits\r\n\r\n1. High Energy Food 🔥\r\nRich in fats – gives instant energy\r\nIdeal for active lifestyle\r\n\r\n2. Enhances Taste 🍽️\r\nMakes dishes richer & more flavorful\r\nPerfect for curries, rotis & sweets\r\n\r\n3. Good for Weight Gain ⚖️\r\nHelps in healthy weight gain when needed\r\n\r\n4. Rich in Nutrients 💪\r\nContains essential vitamins (A, D, E, K)\r\n\r\n🍽️ How to Use\r\nOn roti / paratha\r\nIn curries & gravies\r\nFor sweets & desserts\r\nAs a base for ghee	11	600.00	\N	0	active	DAI899BE2	\N					2026-05-04 14:40:50.135813	2026-05-04 14:40:50.135813	\N	\N	\N	\N	f	t	4.99	\N	\N	\N	29.00	\N	\N	\N	600.00	480.00	600.00	600.00	0.00	2026-05-04 14:40:50.13553	[{"date":"2026-05-04","price":"600.0","timestamp":1777905650}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	571.0	\N	\N	f	PRD-000079
81	BYADAGI CHILLI [100GM]	✨ Famous Karnataka variety 🌶️\r\n✨ Deep red colour – enhances dish appearance\r\n✨ Low spice, high flavour & aroma\r\n✨ Perfect for authentic South Indian cooking\r\n\r\n🌱 Naturally sun-dried • No artificial colour\r\n\r\n💪 Why Choose Byadagi Chilli?\r\n\r\n1. Natural Colour Booster 🔴\r\nGives rich red colour to curries & chutneys\r\nNo need for artificial colour\r\n\r\n2. Mild Spice Level 🌶️\r\nLess pungent, more flavour\r\nPerfect for family cooking\r\n\r\n3. Rich Aroma 🍲\r\nEnhances taste of sambar, rasam & gravies\r\n\r\n4. High Quality Traditional Variety 🌾\r\nSourced from Byadagi region (Karnataka)\r\n\r\n🍽️ Best Used For\r\nSambar & rasam\r\nChutney & podi\r\nCurry masalas\r\nHomemade chilli powder	15	180.00	\N	4	active	GRA5990AA	\N					2026-05-04 14:56:46.120922	2026-05-04 14:56:46.120922	\N	\N	\N	\N	f	t	5.01	\N	\N	\N	9.00	\N	\N	\N	180.00	56.00	180.00	180.00	0.00	2026-05-04 14:56:46.120712	[{"date":"2026-05-04","price":"180.0","timestamp":1777906606}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	171.0	\N	\N	f	PRD-000081
82	BYADAGI CHILLI [200GM]	✨ Famous Karnataka variety 🌶️\r\n✨ Deep red colour – enhances dish appearance\r\n✨ Low spice, high flavour & aroma\r\n✨ Perfect for authentic South Indian cooking\r\n\r\n🌱 Naturally sun-dried • No artificial colour\r\n\r\n💪 Why Choose Byadagi Chilli?\r\n\r\n1. Natural Colour Booster 🔴\r\nGives rich red colour to curries & chutneys\r\nNo need for artificial colour\r\n\r\n2. Mild Spice Level 🌶️\r\nLess pungent, more flavour\r\nPerfect for family cooking\r\n\r\n3. Rich Aroma 🍲\r\nEnhances taste of sambar, rasam & gravies\r\n\r\n4. High Quality Traditional Variety 🌾\r\nSourced from Byadagi region (Karnataka)\r\n\r\n🍽️ Best Used For\r\nSambar & rasam\r\nChutney & podi\r\nCurry masalas\r\nHomemade chilli powder	15	408.00	387.64	5	active	GRA76156F	\N					2026-05-04 15:03:39.656816	2026-05-04 15:03:39.656816	percentage	\N	\N	\N	t	t	5.00	\N	\N	\N	18.64	\N	\N	\N	387.64	225.00	408.00	408.00	0.00	2026-05-04 15:03:39.656535	[{"date":"2026-05-04","price":"408.0","timestamp":1777907019}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	369.0	\N	\N	f	PRD-000082
55	DESI COW GHEE [300ML]	Pure Desi Ghee – Made the Traditional Way ✨🥄\r\n\r\nCrafted from the milk of mixed A2 desi cows, our ghee brings you the richness of authentic Indian goodness. Slow-churned using traditional methods to preserve aroma, taste, and nutrition.\r\n\r\nGolden in color, rich in flavor, and packed with natural benefits — this is not just ghee, it’s purity in every spoon 🌿\r\n\r\nPerfect for daily cooking, पूजा, and adding that nostalgic desi touch to your meals.	11	380.00	\N	6	active	DAIB1E91E	1.000					2026-04-19 15:21:06.338423	2026-05-04 15:27:48.062346	percentage	\N	\N	\N	f	t	5.00	\N	\N	\N	18.00	\N	\N	\N	380.00	250.00	350.00	380.00	8.57	2026-05-04 15:27:48.062052	[{"date":"2026-04-19","price":"350.0","timestamp":1776612066},{"date":"2026-05-04","price":"380.0","timestamp":1777908468}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Liter	\N	\N	\N			\N	362.0	\N	\N	f	PRD-000055
80	BARLEY WHOLE [500GM]	✨ Whole grain – minimally processed\r\n✨ Rich in fiber & essential nutrients\r\n✨ Light, wholesome & versatile\r\n\r\n🌱 No chemicals • No polishing • Pure grain goodness\r\n\r\n💪 Key Benefits\r\n\r\n1. Supports Heart Health ❤️\r\nHelps reduce bad cholesterol (LDL)\r\nGood for overall cardiovascular health\r\n\r\n2. Excellent for Digestion 🌿\r\nHigh in soluble fiber (beta-glucan)\r\nImproves gut health & regularity\r\n\r\n3. Helps in Weight Management ⚖️\r\nKeeps you full for longer\r\nReduces frequent hunger\r\n\r\n4. Diabetic-Friendly 🩺\r\nHelps control blood sugar levels\r\nSlow digestion prevents spikes\r\n\r\n5. Detox & Cooling Effect ✨\r\nBarley water helps cool the body\r\nSupports natural detox\r\n\r\n🍽️ How to Use\r\nBarley water (very popular in summer)\r\nSoups & stews\r\nReplace rice in meals\r\nSalads & porridge	15	90.00	\N	0	active	GRA0BDB08	\N					2026-05-04 14:54:37.469236	2026-05-04 14:54:37.469236	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	4.00	\N	\N	\N	90.00	36.00	90.00	90.00	0.00	2026-05-04 14:54:37.469034	[{"date":"2026-05-04","price":"90.0","timestamp":1777906477}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	86.0	\N	\N	f	PRD-000080
83	HONEY SMALL BHEE [150GM]	✨ Collected from small (stingless) bees 🐝\r\n✨ Thick, dark & highly potent\r\n✨ Strong medicinal value\r\n✨ Raw & unprocessed\r\n\r\n🌱 No additives • No sugar mixing • Pure forest honey\r\n\r\n💪 Key Benefits\r\n\r\n1. Powerful Immunity Booster 💪\r\nRich in antioxidants\r\nHelps fight infections naturally\r\n\r\n2. Good for Cold & Cough 🤧\r\nTraditionally used in home remedies\r\nSoothes throat and improves recovery\r\n\r\n3. Supports Eye & Skin Health ✨\r\nUsed in Ayurveda for eye care\r\nHelps improve skin glow\r\n\r\n4. Aids Digestion 🌿\r\nImproves gut health\r\nNatural detox support\r\n\r\n5. Natural Energy Source ⚡\r\nInstant energy without chemicals\r\n\r\n🍽️ How to Use\r\n1 spoon daily on empty stomach\r\nMix with warm water or milk\r\nWith herbal drinks or home remedies	13	180.00	\N	5	active	NAT160720	1.000					2026-05-04 15:12:50.83273	2026-05-04 15:12:50.83273	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	9.00	\N	\N	\N	180.00	120.00	180.00	180.00	0.00	2026-05-04 15:12:50.83245	[{"date":"2026-05-04","price":"180.0","timestamp":1777907570}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	171.0	\N	\N	f	PRD-000083
84	HONEY RAW [500ML]	✨ 100% raw & unfiltered\r\n✨ No heating, no processing\r\n✨ Retains natural enzymes & nutrients\r\n✨ Thick, aromatic & naturally sweet\r\n\r\n🌱 No sugar mixing • No additives • Pure honey\r\n\r\n💪 Key Benefits\r\n\r\n1. Boosts Immunity 💪\r\nRich in antioxidants\r\nHelps protect against infections\r\n\r\n2. Natural Energy Source ⚡\r\nQuick and clean energy boost\r\nBetter alternative to refined sugar\r\n\r\n3. Good for Cold & Cough 🤧\r\nSoothes throat\r\nCommonly used in home remedies\r\n\r\n4. Supports Digestion 🌿\r\nHelps improve gut health\r\nAids metabolism\r\n\r\n5. Skin & Wellness ✨\r\nUsed for glowing skin\r\nNatural healing properties\r\n\r\n🍽️ How to Use\r\n1 spoon daily (empty stomach)\r\nMix with warm water & lemon\r\nAdd to tea, milk or herbal drinks\r\nUse as natural sweetener	13	450.00	\N	10	active	NAT3244F0	\N					2026-05-04 15:17:41.078826	2026-05-04 15:17:41.078826	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	21.00	\N	\N	\N	450.00	275.00	450.00	450.00	0.00	2026-05-04 15:17:41.078535	[{"date":"2026-05-04","price":"450.0","timestamp":1777907861}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	429.0	\N	\N	f	PRD-000084
87	HIMALAYA ROCK SALT POWDER [1KG]	✨ Natural rock salt from Himalayan ranges\r\n✨ Unrefined & chemical-free\r\n✨ Rich in trace minerals\r\n✨ Mild, natural salty taste\r\n\r\n🌱 No bleaching • No additives • Pure crystals\r\n\r\n💪 Key Benefits\r\n\r\n1. Rich in Minerals 🌿\r\nContains trace minerals like potassium, magnesium\r\nSupports overall wellness\r\n\r\n2. Better Alternative to Regular Salt 🧂\r\nLess processed than refined table salt\r\nMore natural choice for daily use\r\n\r\n3. Supports Hydration 💧\r\nHelps maintain electrolyte balance\r\n\r\n4. Aids Digestion 🌱\r\nTraditionally used to improve digestion\r\n\r\n🍽️ How to Use\r\nDaily cooking (replace regular salt)\r\nIn salads & seasoning\r\nDetox drinks (with warm water & lemon)\r\nUse in grinders or crush as needed	15	125.00	118.76	9	active	GRAB55334	\N					2026-05-04 15:25:05.223519	2026-05-04 15:25:05.223519	percentage	\N	\N	\N	t	t	5.00	\N	\N	\N	5.76	\N	\N	\N	118.76	45.00	125.00	125.00	0.00	2026-05-04 15:25:05.223251	[{"date":"2026-05-04","price":"125.0","timestamp":1777908305}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	113.0	\N	\N	f	PRD-000087
88	HIMALAYA ROCK SALT POWDER [500GM]	✨ Natural rock salt from Himalayan ranges\r\n✨ Unrefined & chemical-free\r\n✨ Rich in trace minerals\r\n✨ Mild, natural salty taste\r\n\r\n🌱 No bleaching • No additives • Pure crystals\r\n\r\n💪 Key Benefits\r\n\r\n1. Rich in Minerals 🌿\r\nContains trace minerals like potassium, magnesium\r\nSupports overall wellness\r\n\r\n2. Better Alternative to Regular Salt 🧂\r\nLess processed than refined table salt\r\nMore natural choice for daily use\r\n\r\n3. Supports Hydration 💧\r\nHelps maintain electrolyte balance\r\n\r\n4. Aids Digestion 🌱\r\nTraditionally used to improve digestion\r\n\r\n🍽️ How to Use\r\nDaily cooking (replace regular salt)\r\nIn salads & seasoning\r\nDetox drinks (with warm water & lemon)\r\nUse in grinders or crush as needed	15	70.00	66.51	10	active	GRA16ABD5	\N					2026-05-04 15:26:23.255535	2026-05-04 15:26:23.255535	percentage	\N	\N	\N	t	t	4.99	\N	\N	\N	3.51	\N	\N	\N	66.51	23.00	70.00	70.00	0.00	2026-05-04 15:26:23.255337	[{"date":"2026-05-04","price":"70.0","timestamp":1777908383}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	63.0	\N	\N	f	PRD-000088
89	GROUNDNUT OIL [5LTR]	✨ Wood pressed  extraction\r\n✨ Slow-processed – retains nutrients & aroma\r\n✨ Natural golden colour & rich flavour\r\n✨ No chemicals, no refining\r\n\r\n🌱 Unrefined • Pure • Traditional method\r\n\r\n💪 Key Benefits\r\n\r\n1. Heart Healthy ❤️\r\nRich in good fats (MUFA)\r\nHelps manage cholesterol levels\r\n\r\n2. Retains Nutrients 🌿\r\nCold/wood pressed method preserves vitamins\r\nBetter than refined oils\r\n\r\n3. High Smoke Point 🔥\r\nIdeal for Indian cooking & frying\r\n\r\n4. Improves Taste 🍽️\r\nEnhances flavour of curries, chutneys & snacks\r\n\r\n🍽️ Best Used For\r\nDaily cooking & frying\r\nSouth Indian dishes\r\nChutneys & podis\r\nTraditional recipes	14	1725.00	1675.00	5	active	OILE68872	\N					2026-05-04 15:31:43.658925	2026-05-04 15:31:43.658925	fixed	50.00	\N	50.00	t	t	5.00	\N	\N	\N	80.00	\N	\N	\N	1675.00	1250.00	1725.00	1725.00	0.00	2026-05-04 15:31:43.658679	[{"date":"2026-05-04","price":"1725.0","timestamp":1777908703}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Liter	\N	\N	\N			\N	1595.0	\N	\N	f	PRD-000089
90	SUNFLOWER OIL [3LTR]	✨ Wood pressed  extraction\r\n✨ Unfiltered – retains natural nutrients\r\n✨ Light, aromatic & natural golden colour\r\n✨ No chemicals, no refining\r\n\r\n🌱 Pure • Traditional • Nutrient-rich\r\n\r\n💪 Key Benefits\r\n\r\n1. Heart Friendly ❤️\r\nRich in healthy fats\r\nSupports better cholesterol balance\r\n\r\n2. Retains Natural Nutrients 🌿\r\nUnfiltered oil keeps vitamins intact\r\nBetter than refined oils\r\n\r\n3. Light & Easy to Digest 🍽️\r\nPerfect for everyday cooking\r\nDoesn’t feel heavy\r\n\r\n4. Good for Skin & Wellness ✨\r\nContains Vitamin E\r\nSupports skin health\r\n\r\n🍽️ Best Used For\r\nDaily cooking\r\nLight frying & sautéing\r\nSouth Indian dishes\r\nHealthy meal preparation	14	1050.00	1020.00	4	active	OIL3E5F2C	\N					2026-05-04 15:34:01.59837	2026-05-04 15:34:01.59837	fixed	30.00	\N	30.00	t	t	4.99	\N	\N	\N	48.00	\N	\N	\N	1020.00	750.00	1050.00	1050.00	0.00	2026-05-04 15:34:01.598135	[{"date":"2026-05-04","price":"1050.0","timestamp":1777908841}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Liter	\N	\N	\N			\N	972.0	\N	\N	f	PRD-000090
92	GINGELLY - SESAME OIL [500ML]	✨ Wood pressed (chekku) extraction\r\n✨ Rich aroma & deep traditional flavour\r\n✨ Unrefined – retains natural nutrients\r\n✨ Pure, chemical-free\r\n\r\n🌱 No additives • No refining • Authentic oil\r\n\r\n💪 Key Benefits\r\n\r\n1. Heart Healthy ❤️\r\nRich in good fats & antioxidants\r\nSupports cholesterol balance\r\n\r\n2. Great for Skin & Hair ✨\r\nDeep nourishment\r\nTraditionally used for massage & hair care\r\n\r\n3. Improves Digestion 🌿\r\nKnown to support gut health\r\nWidely used in Ayurvedic cooking\r\n\r\n4. Anti-Inflammatory Properties 💪\r\nHelps reduce internal inflammation\r\n\r\n🍽️ Best Used For\r\nSouth Indian cooking (especially traditional dishes)\r\nPickles & chutneys\r\nTempering (tadka)\r\nAyurvedic use & oil pulling	14	240.00	\N	4	active	OIL747F8E	\N					2026-05-04 15:37:35.360455	2026-05-04 15:37:35.360455	\N	\N	\N	\N	f	t	4.99	\N	\N	\N	11.00	\N	\N	\N	240.00	169.00	240.00	240.00	0.00	2026-05-04 15:37:35.360261	[{"date":"2026-05-04","price":"240.0","timestamp":1777909055}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Liter	\N	\N	\N			\N	229.0	\N	\N	f	PRD-000092
91	SUNFLOWER OIL [5LTR]	✨ Wood pressed (chekku) extraction\r\n✨ Unfiltered – retains natural nutrients\r\n✨ Light, aromatic & natural golden colour\r\n✨ No chemicals, no refining\r\n\r\n🌱 Pure • Traditional • Nutrient-rich\r\n\r\n💪 Key Benefits\r\n\r\n1. Heart Friendly ❤️\r\nRich in healthy fats\r\nSupports better cholesterol balance\r\n\r\n2. Retains Natural Nutrients 🌿\r\nUnfiltered oil keeps vitamins intact\r\nBetter than refined oils\r\n\r\n3. Light & Easy to Digest 🍽️\r\nPerfect for everyday cooking\r\nDoesn’t feel heavy\r\n\r\n4. Good for Skin & Wellness ✨\r\nContains Vitamin E\r\nSupports skin health\r\n\r\n🍽️ Best Used For\r\nDaily cooking\r\nLight frying & sautéing\r\nSouth Indian dishes\r\nHealthy meal preparation	14	1750.00	1700.00	5	active	OIL1E7F2C	\N					2026-05-04 15:35:33.274343	2026-05-04 15:35:33.274343	fixed	50.00	\N	50.00	t	t	5.00	\N	\N	\N	81.00	\N	\N	\N	1700.00	1250.00	1750.00	1750.00	0.00	2026-05-04 15:35:33.274103	[{"date":"2026-05-04","price":"1750.0","timestamp":1777908933}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Liter	\N	\N	\N			\N	1619.0	\N	\N	f	PRD-000091
106	Raw	sewqwq	11	1.00	\N	337	active	sd2113	\N	\N				2026-05-10 05:16:06.149225	2026-05-10 05:16:06.149225	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.00	1.00	0.00	2026-05-10 05:16:06.148895	[{"date":"2026-05-10","price":"1.0","timestamp":1778390166}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	\N	\N	\N	t	PRD-000106
101	Testing PRiduct 1	dsds	11	102.00	\N	0	active	ds	\N	\N				2026-05-09 10:49:49.840188	2026-05-09 10:49:49.840188	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	102.00	102.00	0.00	2026-05-09 10:49:49.839726	[{"date":"2026-05-09","price":"102.0","timestamp":1778323789}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	\N	\N	\N	t	PRD-000101
97	MOTHMATKI [500 KG]		15	135.00	\N	5	active	GRA0F2C1D	\N					2026-05-06 09:50:24.619754	2026-05-06 09:50:24.619754	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	6.00	\N	\N	\N	135.00	57.50	135.00	135.00	0.00	2026-05-06 09:50:24.61945	[{"date":"2026-05-06","price":"135.0","timestamp":1778061024}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	129.0	\N	\N	f	PRD-000097
98	KHANDSARISUGAR [1 KG]		15	160.00	\N	2	active	GRA9C7798	\N					2026-05-06 09:54:10.873433	2026-05-06 09:54:10.873433	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	8.00	\N	\N	\N	160.00	120.00	160.00	160.00	0.00	2026-05-06 09:54:10.873207	[{"date":"2026-05-06","price":"160.0","timestamp":1778061250}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	152.0	\N	\N	f	PRD-000098
85	HIMALAYA CRYSTAL ROCK SALT [1KG]	✨ Natural rock salt from Himalayan ranges\r\n✨ Unrefined & chemical-free\r\n✨ Rich in trace minerals\r\n✨ Mild, natural salty taste\r\n\r\n🌱 No bleaching • No additives • Pure crystals\r\n\r\n💪 Key Benefits\r\n\r\n1. Rich in Minerals 🌿\r\nContains trace minerals like potassium, magnesium\r\nSupports overall wellness\r\n\r\n2. Better Alternative to Regular Salt 🧂\r\nLess processed than refined table salt\r\nMore natural choice for daily use\r\n\r\n3. Supports Hydration 💧\r\nHelps maintain electrolyte balance\r\n\r\n4. Aids Digestion 🌱\r\nTraditionally used to improve digestion\r\n\r\n🍽️ How to Use\r\nDaily cooking (replace regular salt)\r\nIn salads & seasoning\r\nDetox drinks (with warm water & lemon)\r\nUse in grinders or crush as needed	15	125.00	118.75	7	active	GRA878BB1	\N					2026-05-04 15:21:34.89825	2026-05-04 15:21:34.89825	percentage	\N	\N	\N	t	t	5.00	\N	\N	\N	5.75	\N	\N	\N	118.75	52.00	125.00	125.00	0.00	2026-05-04 15:21:34.898039	[{"date":"2026-05-04","price":"125.0","timestamp":1777908094}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	113.0	\N	\N	f	PRD-000085
93	MASOOR DAL [500GM]		15	130.00	\N	5	active	GRA7FB0E0	\N					2026-05-06 07:48:36.539034	2026-05-06 07:48:36.539034	percentage	\N	\N	\N	f	t	5.00	\N	\N	\N	6.00	\N	\N	\N	130.00	57.00	130.00	130.00	0.00	2026-05-06 07:48:36.538768	[{"date":"2026-05-06","price":"130.0","timestamp":1778053716}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	124.0	\N	\N	f	PRD-000093
103	dsds32	ds	11	100.00	\N	0	active	sds	\N	\N				2026-05-10 00:06:45.639743	2026-05-10 00:06:45.639743	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	100.00	100.00	0.00	2026-05-10 00:06:45.639229	[{"date":"2026-05-10","price":"100.0","timestamp":1778371605}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	\N	\N	\N	t	PRD-000103
73	LITTLE MILLET - SAAME [1KG]	Little millet is a light, everyday-friendly grain—perfect for those starting their millet journey 👇\r\n\r\n💪 Key Benefits\r\n\r\n1. Supports Weight Loss ⚖️\r\nHigh fiber keeps you full longer\r\nHelps reduce overeating\r\n\r\n2. Diabetic-Friendly 🩺\r\nLow glycemic index\r\nHelps control blood sugar levels\r\n\r\n3. Improves Digestion 🌿\r\nEasy to digest\r\nGood for gut health\r\n\r\n4. Boosts Heart Health ❤️\r\nHelps reduce cholesterol\r\nSupports overall heart function\r\n\r\n5. Rich in Nutrients & Minerals 💪\r\nProvides energy\r\nSupports overall wellness\r\n\r\n6. Naturally Gluten-Free 🌱\r\nSafe for gluten intolerance\r\nGreat rice alternative\r\n\r\n🍽️ How to Use\r\nDaily rice replacement\r\nUpma / Pongal\r\nKhichdi\r\nDosa / Idli batter	15	160.00	\N	4	active	GRA092B76	\N					2026-05-04 13:31:06.082673	2026-05-04 13:37:28.342679	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	8.00	\N	\N	\N	160.00	95.00	160.00	160.00	0.00	2026-05-04 13:31:06.082395	[{"date":"2026-05-04","price":"160.0","timestamp":1777901466}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	152.0	\N	\N	f	PRD-000073
94	MEDIUMRAVA [500GM]		15	65.00	\N	3	active	GRAD237C7	\N					2026-05-06 07:51:47.469284	2026-05-06 07:51:47.469284	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	3.00	\N	\N	\N	65.00	32.50	65.00	65.00	0.00	2026-05-06 07:51:47.468756	[{"date":"2026-05-06","price":"65.0","timestamp":1778053907}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	62.0	\N	\N	f	PRD-000094
95	MOONGDAL [1 KG]		15	270.00	\N	3	active	GRAA64988	\N					2026-05-06 09:40:57.639708	2026-05-06 09:40:57.639708	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	13.00	\N	\N	\N	270.00	200.00	270.00	270.00	0.00	2026-05-06 09:40:57.638513	[{"date":"2026-05-06","price":"270.0","timestamp":1778060457}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	257.0	\N	\N	f	PRD-000095
96	MOONGDAL [500GM]		15	135.00	\N	5	active	GRAB5FA4A	\N					2026-05-06 09:48:20.283121	2026-05-06 09:48:20.283121	percentage	\N	\N	\N	f	t	5.00	\N	\N	\N	6.00	\N	\N	\N	135.00	76.50	135.00	135.00	0.00	2026-05-06 09:48:20.282628	[{"date":"2026-05-06","price":"135.0","timestamp":1778060900}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	129.0	\N	\N	f	PRD-000096
99	zxxz	xzxz	11	1.00	\N	317	active	DAICD6757	\N					2026-05-09 06:09:05.205823	2026-05-09 06:10:09.618427	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	1.00	1.00	1.00	1.00	0.00	2026-05-09 06:09:05.205177	[{"date":"2026-05-09","price":"1.0","timestamp":1778306945}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	\N	\N	\N	f	PRD-000099
100	sddsds		11	501.00	\N	0	active	sddss	\N	\N				2026-05-09 10:39:27.610426	2026-05-09 10:39:27.610426	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	501.00	501.00	0.00	2026-05-09 10:39:27.609819	[{"date":"2026-05-09","price":"501.0","timestamp":1778323167}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	\N	\N	\N	t	PRD-000100
104	sd	ds	11	45.00	\N	2	active	dsdwdrewrwe	45.000					2026-05-10 00:14:47.766146	2026-05-10 00:14:47.766146	percentage	\N	\N	\N	f	t	4.00	\N	\N	\N	2.00	\N	\N	\N	45.00	23.00	45.00	45.00	0.00	2026-05-10 00:14:47.764309	[{"date":"2026-05-10","price":"45.0","timestamp":1778372087}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Bottle	\N	\N	\N			\N	43.0	\N	\N	f	PRD-000104
105	dsd	sd	11	45.00	\N	2	active	DAI73AF93	\N	\N				2026-05-10 00:31:06.53723	2026-05-10 00:31:06.53723	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	45.00	45.00	0.00	2026-05-10 00:31:06.536433	[{"date":"2026-05-10","price":"45.0","timestamp":1778373066}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	\N	\N	\N	t	PRD-000105
36	A2 DESI COW GHEE [225ML]	Experience purity the traditional way with Marali Santhe A2 Desi Cow Ghee, crafted using the time-honored Bilona method. This authentic process preserves the natural nutrients, aroma, and richness that modern methods often lose.\r\n\r\nOur ghee is made from fresh, cultured butter sourced from high-quality milk of indigenous cows. The butter is slowly churned and gently simmered in small batches to bring out the golden texture, grainy consistency, and rich aroma that define true desi ghee.\r\n\r\nEvery jar reflects our commitment to tradition, quality, and purity — delivering not just taste, but nourishment rooted in heritage.	12	350.00	\N	0	active	DAIE90911	\N					2026-03-19 08:34:02.625067	2026-05-02 12:46:54.662762	\N	\N	\N	\N	f	f	5.00	\N	\N	\N	\N	\N	\N	\N	350.00	250.00	350.00	350.00	0.00	2026-03-19 08:34:02.624833	[{"date":"2026-03-19","price":"350.0","timestamp":1773909242}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Liter	\N	\N	\N	products/product-temp-4a27681675e12237		\N	333.0			f	PRD-000036
59	BLACK RICE  [1KG]	Black rice isn’t just different in color—it’s one of the most nutrient-dense grains you can offer 👇\r\n\r\n💪 Key Benefits\r\n\r\n1. Rich in Antioxidants (Anthocyanins)\r\nGives the dark purple/black color\r\nHelps fight inflammation & supports overall health\r\n\r\n2. Supports Heart Health ❤️\r\nMay help reduce bad cholesterol (LDL)\r\nImproves blood circulation\r\n\r\n3. High in Fiber 🌿\r\nAids digestion\r\nKeeps you full longer (great for weight management)\r\n\r\n4. Good for Diabetics 🩺\r\nLower glycemic impact compared to white rice\r\nHelps in better blood sugar control\r\n\r\n5. Natural Detox Support ✨\r\nSupports liver function\r\nHelps remove toxins from the body\r\n\r\n6. Rich in Iron & Nutrients\r\nHelps boost energy levels\r\nGood for people with low hemoglobin\r\n\r\n🍽️ How to Use\r\nRice meals (like regular rice)\r\nSalads & bowls\r\nKheer / desserts\r\nMix with normal rice for beginners	15	290.00	\N	0	active	GRA5ECBF6	1.000					2026-05-04 12:41:01.529394	2026-05-04 12:41:01.529394	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	14.00	\N	\N	\N	290.00	150.00	290.00	290.00	0.00	2026-05-04 12:41:01.529199	[{"date":"2026-05-04","price":"290.0","timestamp":1777898461}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	276.0	\N	\N	f	PRD-000059
70	FOXTAIL MILLET - NAVANE [500GM]	Foxtail millet is one of the best everyday millet alternatives to rice—light, nutritious, and versatile 👇\r\n\r\n💪 Key Benefits\r\n\r\n1. Diabetic-Friendly 🩺\r\nLow glycemic index\r\nHelps control blood sugar levels\r\n\r\n2. Supports Weight Loss ⚖️\r\nHigh fiber keeps you full longer\r\nReduces unnecessary cravings\r\n\r\n3. Good for Heart Health ❤️\r\nHelps reduce bad cholesterol\r\nSupports overall cardiovascular health\r\n\r\n4. Improves Digestion 🌿\r\nRich in dietary fiber\r\nPromotes healthy gut function\r\n\r\n5. Boosts Energy & Immunity 💪\r\nPacked with protein, iron & minerals\r\nKeeps you active throughout the day\r\n\r\n6. Gluten-Free 🌱\r\nSafe for gluten intolerance\r\nHealthy alternative to rice & wheat\r\n\r\n🍽️ How to Use\r\nMillet rice (replace white rice)\r\nUpma / Pongal\r\nDosa / Idli batter\r\nKhichdi	15	90.00	\N	4	active	GRA115444	1.000					2026-05-04 13:22:38.878487	2026-05-04 13:22:38.878487	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	4.00	\N	\N	\N	90.00	37.00	90.00	90.00	0.00	2026-05-04 13:22:38.878225	[{"date":"2026-05-04","price":"90.0","timestamp":1777900958}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	86.0	\N	\N	f	PRD-000070
75	PEARL MILLET SAJJE [1KG]	✨ Traditional powerhouse grain\r\n✨ Rich in iron, fiber & essential minerals\r\n✨ Keeps body warm & energetic\r\n✨ Ideal for daily strength and stamina 💪\r\n\r\n🌱 Naturally gluten-free • Unprocessed • Nutrient-rich\r\n\r\n💪 Key Benefits\r\n\r\n1. Boosts Energy & Strength 💪\r\nHigh in iron and nutrients\r\nGreat for daily stamina\r\n\r\n2. Good for Digestion 🌿\r\nRich in fiber\r\nSupports gut health\r\n\r\n3. Diabetic-Friendly 🩺\r\nHelps manage blood sugar levels\r\nSlow digestion keeps energy stable\r\n\r\n4. Supports Heart Health ❤️\r\nHelps reduce cholesterol\r\nGood for overall cardiovascular health\r\n\r\n5. Keeps Body Warm 🔥\r\nIdeal for all seasons, especially beneficial in cooler weather\r\n\r\n🍽️ How to Use\r\nSajje rotti / Bajra roti\r\nPorridge / malt\r\nUpma / khichdi\r\nMix with other flours	15	70.00	\N	0	active	GRAFF9457	\N					2026-05-04 13:57:22.891334	2026-05-04 13:57:22.891334	\N	\N	\N	\N	f	t	5.00	\N	\N	\N	3.00	\N	\N	\N	70.00	22.00	70.00	70.00	0.00	2026-05-04 13:57:22.891104	[{"date":"2026-05-04","price":"70.0","timestamp":1777903042}]	f	\N	\N	\N	t	Grocery			\N		\N	f	Kg	\N	\N	\N			\N	67.0	\N	\N	f	PRD-000075
\.


--
-- Data for Name: referrals; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.referrals (id, affiliate_id, referred_name, referred_mobile, referred_email, referral_date, status, notes, converted_at, customer_id, created_at, updated_at, referring_customer_id, referral_source) FROM stdin;
8	12	Ramu	0919093939	9093939393fdfds@gmail.com	2026-05-09	converted	ds | Marked as registered on 2026-05-09 | Converted on 2026-05-09	2026-05-09 11:59:42.982911	\N	2026-05-09 11:56:48.709226	2026-05-09 11:59:43.589579	\N	affiliate
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.roles (id, name, description, status, permissions, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sale_items; Type: TABLE DATA; Schema: public; Owner: -
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
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: -
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
\.


--
-- Data for Name: solid_cache_entries; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.solid_cache_entries (id, key, value, created_at, key_hash, byte_size) FROM stdin;
1	\\x70726f64756374696f6e3a6d6f62696c655f6170692f762f62616e6e6572732f686f6d65	\\x001104000000000000f0bfffffffff3637326466346131	2026-05-10 08:31:53.393104	-6313271967087885740	199
2	\\x70726f64756374696f6e3a6d6f62696c655f6170692f62616e6e6572732f36373264663461312f686f6d65	\\x001101dcfe74601280da41ffffffff04085b00	2026-05-10 08:31:53.867544	8024045382703396259	202
9	\\x70726f64756374696f6e3a6d6f62696c655f6170692f70726f647563742f32323963393439632f3538	\\x001181e9ac866b1180da41ffffffff789ced98db6f1b591dc79315cac58993de2fbb851e4cb72cc571c6499cc633421b278d53f7b22db96cb544c89ccc9c199fcd788e33e74c5c531eaa221082ee82b6cbc38a4a3c21f182104f5c044bff09b4128f91f6051e40fc05fc7e673cb6e3a65b8456a802a436c99cebeffc7ebfefe75c3e3372cf3087b9c35f3747035a6795ccd9a5d2fae6cdd2c6d5cad45a6579856ce5afaf7e7dc81c5ad9308f384cda216f282e824a66f017fbf71fdf66a1cb6c45b6a94f039b11e11245a56284060ea931eaab1af9fb4f1f7eb8fff8e7e9d43a0f3c9f9186f0b9ac31073ac93a559c841c7aeedf7f4402a188128234426133299993ed1485b4994ba7d2a91b22f0b28486027bdac40b290f245135aa882dc40e71fdc8755b84edb1b04514af3398fe9d3ffced373f1cb28637cc5403e7725333b90536631e77b8b44514a8aa2e36cc6392f93e18197f2f8e98475c1e50bff379a6db8185360b14f5181f308f758a55ab01c374c7dda37e840522e45e77242890740fe691555ac776ee9061a6a412f60e4f99237227aa642656d74aa5c2ec72bea00d1f8d02ae2a99e1eb9efe1c6b32eed5a05fde9c746091818490c84a6640d71e05ff39911d9b53c98cafa23bc396ae1bdfa6a12d1cb0215d934135fe731416d2e98dab69f8b45515a1c342c33cc7655546db9dc8575940b77de694cd97a146d836c5c9f5daf4ac65f3882755d26ac33c8e5f5d7fb9a373b962d14cdb54314f84ad7bc3d6003f610d55322757e3605e2437b9ef3325e390f13af432cc31fd5b6e0d986321843ef0ee0d9be314c20ca58ba3664a3b1c8271048ce241557b1316035f4934d0e4a3f0ed8b66527d54ff862faa2270c0c40dd124eb58a4a79eb44306563a55aa364d52b215df63eb51a32142659a1be0f63b5cd5be2602b6355289cc512c493ffcd1f9278f7eb0fd78c81cfd26d41895ccd192e474fabaf077a8a2386e25b2b2e9f7e2761786ac29c39c8c1a4e3291f5651c0d5a744682168b679fee74ae4665b51ef98a377c56dd8d282c5f7126cbdd0826797bda612e8596908f21877655ee40fcdb1fe8d29321f3b501ed18caadd4bd2988cb2cc6e5f45ae9dacdcd2b15d2c30358863552c9bcf4d1e0ca5d882d67287e5563c4671eb55b9a032175b8d2a991c8b409fe223769487d4ed6616a68bf46dfa6f5c8e1640d4cddbfff3e056a841c1385a07d4cb5c84e209a01714548b892088b1ab16b3088ad58a83963c3d222189448ee05dce536a22847ca34ac132922c83c276e4743e646bedf2235f884e404b2006b9864e11ed38307341e8843b67860462b0b8be2322654c8ea7a156ec818fc10751826acc38004e5a17052a9e76177915e902c09c8205b35bc305ff43ca0e6dd8801b17c11c214ec2e4ccbb2bab3c31ad008fce7fa740f6b0f78088c707d00ae248da86d5fe2e6b87b9d070e9ac4b446c0a1db21fc867f405b7b478708c9da66358da000f2c6ce92664df84c0a00a62b8493d3111e7553f9dc2c9bb1528635b678c11a87ff693e604d18d6a4611d31aca38ba3d6317ed23a1e03ab5c9a2d2c2ce9ae273ab0b24e1ad6a9365cacd30771649d31acb386f57252fd8a619d2b5b9f2d5b9fdbb0cebb43058b3c070fd6e76123fa5e4da98634a7a7219439db17e0ac8086ad9c2dead38ebbed15765b79635af3633a6af8823ad376d58541b26e153c20b2b5eabc616477e38f6675c130a6f7f2d38916923fa614ab37a6e6e62e33d729d219364f5dbb68bc5ea55f592a2d5f9b5dbf72435b94d91a7ae16cfa02b8f102c4ea5508dec50deb8b65ebb5b2f5a54a265d09babcb32e75e1c3bf7ffec9577fb5d9ea818f888b06b1c8ca759b0650fed2caa5dea62a2e8a9b4e972d03f2266f58335b039a2a7318ce57d66fbd512237e1b0b17628593e1e3c088a750009b04342dac74a005952384b34229f86f17eefd056acd4c3c9e1e396d9151b8856c169441f2562edc0181264e383ae72305f0c0e8787a037608656bc0b8a977d30e939ad700502553a4d7b710270f6359b350145a400110d014b6148a0432802164741c07058481a143d0f186cf34a63243974e1c21ccac1043cfa703c187569854512f0e72a6d6e7c2eca923ac586682877e078a6c7a01d8701121c3c9bc91ce9b0aa7db4737a0e76097b60148d1709b3c11104aa031b8ae3e5b662a742c2c31c7888232d7069375275985eb63903f9f12f22a6589ebd3c5ffcb410b378a94b98c5ec7f1e264e7ea160337b6e8131c32eba975f04983cd7a67f0b264f3ef8f8bb7d3081a289c360f2ed77c7eef7c1048a469e0193c2336052f83f4cfe4761e28ecce391c54d157297e18fb1c537812a6f5ae9c89c5ce2de15668350fcf1a269e40a2c6f4d543293dddb891ea10d1e776416ea8ff154c29efc4a617e2effdfc21e7a79c6291698bd401798319f775e04f63cd7a67ef66c58af6d207b0ededcfae133f1eb8f1ef6c1078a4e1c069f1f7fe31fdfe9830f14a5bbf0d9ec854f11e173e2ced595d2c654f9c6adcdb52938c374a8f3e7c1dba8caf8f2932357e13e2815092071411628c0eed3483ab584b94f6a7800474279700887e61255742bf468c06d72a706a77a52f631f335400e420d5f50e03e1bb0292f84fb6e7ce76953a3972c4fdf7a22152657882ec03a778358ab3998cd69df7bbab84aae57f11a51c4fbf73f907a058d3658ec9a4084201b344042a1b8ec791f6a8bb7fd640362d65802cffc91e40de3d5ceea2fc248ac0e973b7f0a6f60d8e4bd9f20bd812cc065be0db7c18bf15ac06c89f5efff8c9461a13530b48e7706475bb1cd14de1c63025d4c00a3ef6707ee40d0d0ebdc5a7145a166be8bfeefa0660110a18f2ebb0099ddc38e2e63093e9697cae5b9d253f8581cff74f8618060070edb9c373e71731e7ef7fc933f3d506ff724fd785cb4dfaf0f6cfa97f953777b9aa6e3a281ae3e767bf561eaf7836ba5d5d595b5b7a66edfba7365e5a0447e3fb8de644ce94c4717279b5c13988e29d016c73ac400e28cfb9bce190ef1f3393ea1c5d14972e41af53ccca2dba2e9b0678a240ae23d10f6d8032915e77d03eec990297adcc49c448d6d114478a33ff0c05167b0153bf2c0a6adefd98a632d4c16628ee3f81edf834d19b6aff8d512df33b2fd62c38c8ef5201b420489223e246f888ec9927c0b3ff552c09c3e3df05004fd7278e79724d9ed938549f43e0bd0579dfd3f920ce7bba25ddef6149c273c1ae6c8724d08c9da7b76cf23c15cf24830f80074003f0e11c2442204a3589a2f2ebf884278ebd1ef649f10a0e8af8709e1939a6a218013622598e321dbe3ac890f6dc71c06790babaaf2c015f746cc33740f9c8e4fa5555fd814d349e2be3b51f27d52091cae9f0ccdd3b073c01e8b4f74c90895cca9d9a902d9c66444f90039e317d393b2c61b0d7cc6c667328fc94ae67c19dfac927242b705a07fffc16f0b86815dfe09c6cfb85a	2026-05-10 08:35:34.685265	1684362976217642386	2666
12	\\x70726f64756374696f6e3a6d6f62696c655f6170692f62616e6e6572732f37353130343337322f616c6c	\\x001101f406fb331380da41ffffffff04085b067b103a076964690a3a0a7469746c6549220954657374063a0645543a106465736372697074696f6e4922077364063b07543a1272656469726563745f6c696e6b49221e68747470733a2f2f7765622e77686174736170702e636f6d2f063b07543a15646973706c61795f6c6f636174696f6e49220e64617368626f617264063b07463a12646973706c61795f6f7264657269063a0e696d6167655f75726c4922018668747470733a2f2f7265732e636c6f7564696e6172792e636f6d2f6466626735717931302f696d6167652f75706c6f61642f635f66696c6c2c665f6175746f2c685f3430302c715f6175746f2c775f3830302f76312f62616e6e6572732f62616e6e65722d74656d702d326465316239366262636166373135633f5f613d4241434a3353444c063b07543a17646973706c61795f73746172745f6461746549220f323032362d30352d3130063b07543a15646973706c61795f656e645f6461746549220f323032362d30362d3130063b07543a0e69735f616374697665543a0f637265617465645f6174492218323032362d30352d31302031343a30373a3039063b0754	2026-05-10 08:46:00.039024	5138298613582033729	623
10	\\x70726f64756374696f6e3a6d6f62696c655f6170692f762f62616e6e6572732f64617368626f617264	\\x001104000000000000f0bfffffffff3562643632393232	2026-05-10 08:37:10.086778	151131104919973098	204
11	\\x70726f64756374696f6e3a6d6f62696c655f6170692f762f62616e6e6572732f616c6c	\\x001104000000000000f0bfffffffff6132346566393736	2026-05-10 08:45:57.731775	-8836894317673552056	198
16	\\x70726f64756374696f6e3a6d6f62696c655f6170692f63617465676f726965732f6465323938396232	\\x00118160a14f181280da41ffffffff789ce555cb721b45144d5294e34785323654b6b7bc6025eb6529b2a462118a38c885e35072ca0416ae56cf1d4dc34cf7a4bbc78ac8c61fc11236142b3ecb05ffc1e919c98f60d8b162a5d1e8deee73cf3de7e883d5efd6df6d0c1eaa487d3458d322e3d1cee32f84b273fa940e84cde8c0b24b56062bcf4e069b113b6955ee95d1a39dfb7f3ef57424ac48158d85f609d768c634b14a4f696e0aca0b8b57310ed98dc3211495e7e6d64485f48e9c29ace488226559fa744eb13519795b388fb7a991222dbbd9ba3a1d1776d16f859e322947d69850a8347a44a4022a7464ec1313b91ab1764589450b5f00257981836b94a86942baf0b6eca891d011fdc8d6903419b065ca31194d6f0a0ce6e7f595e1c393c1872a13533e2b6c8ab97f4bbccfdda0d1c8cae15d397b1ddd0d2b54ea1a427a75ce67ce1b8ba6c6243513d7b05c8dd9e0f9612cb3837cf2e5913ad64e7dfbfca0f97a3c7a7274f2ca8df4e72da9464f46d9a19bb40f6371fab58abf697eb6bbdbebb73ba215b5e36eabdbe9c5729f9bed6e578a7dee772742f67b1d8ef7e249a76195e47aaea725eced25d767d214daabd5c156a45c9e8af999b1115b75efddc6f09eda1cae8c76b6abadbf5c7484fee1eaff6acbc3b5e6705d6d0d3716b47c1c68f9e43996aa1ddc70a4d294af8979d07ef07766302bbddf801bf129038c8a3647de4c819f2d4961392e52b0b2a4c97991a7fc4f63c7c644248b14a3721dd60493981b6aa3b0773a1756b1571c6ea88667ed77f15342d9024caa7e40b198aa1a7d6f66c256ccc4e6ad877641e7395f2f2fd0ef3860079299f2090954cac2dd60ae6c1705a681be64a0f2d1faa3f5f19d4b0f6b761549d38aa4d0bc44062a50c65cd526a80533e48a0928d192abe2426bc6b31315caf008466fc82048127772e0a4640b0c2a9c9e19e7af34121b9bd5e934a996806f41744099b148319cbdc5394e533903378ae764e2182d826689c19a4cc625ac89480346b024e625f79851c10bf3306b2c3062c5cbb5cc76af64b61564f6f8c502da78c6ec59c30d4ba10d2f2f7e7ea517c3e28acb8b5fab645e921c5ebc30f4348af0655c4c85bdbcf885aaab60e0dfffa3b87afd2f7125facd76abd76f757bdd562491575274782fe6de7edcee44b2dddb6bb6b8dd948d738613c404542e430bdcac5d71b31db8593f1e7d35a62bdffd71ffce448ae13233c366e028a5c32ac2f6735b296429162c5178c27d3a72b7b63c532e82ec4a95e761e5c8077e8b8acab89e65a2d59b82172165c05ca9d8ca2a0b7f98c2430ef33bc47b43a1a58c2c673000c99405c2c989986b0b7d8b08f6662be0b95232cf4a4746d6e461b260461732174ebbbcf8e9da2f32e14c214b71d38d97467b882f44c43203cb30c0cd4b2b4cc1920631b04318bdccf16516016dd0019c5d996f9156b78c776b11741a387f692ba11e078e224ea12e7b2b226aef0773f96f105055f15338be11c89b410d7f01ebed0620	2026-05-10 08:47:05.284387	-6760253980846125556	1265
5	\\x70726f64756374696f6e3a6d6f62696c655f6170692f762f70726f6475637473	\\x001104000000000000f0bfffffffff6635626333316333	2026-05-10 08:31:58.007998	-1347409204918588129	195
3	\\x70726f64756374696f6e3a6d6f62696c655f6170692f762f63617465676f72696573	\\x001104000000000000f0bfffffffff3833366239616637	2026-05-10 08:31:55.116467	-411474056052991194	197
17	\\x70726f64756374696f6e3a6d6f62696c655f6170692f66656174757265642f32323963393439632f6c696d69745f35	\\x001181581299191280da41ffffffff789ccd564b6f1b5514b6abcae3b1e3d86edaf44120c690164aeadef1238f7b54c941add1a4915ab5ae90c8c2baf1dc712e9dccb87367e28620c1862d126c9158f00b102b96a81bd62cf9096cd98204e7cef89534095d80c4c2b1ef9933e73be7fbbe3393f3e9edcce12daa094b785477d91e37cbe9476c90a2a97b6d5ab0b8ecfaa21f08cf35cb59c907cf06cf52a0b569a6ef8b2eb753069db384ec7aa11b74a210a11724771ce1f6e27353a7055bb8cc191faf4c6ee07e97bb01eb7191a017c6e1e0a08f652675f79913aa80e78bdea4120624db471cd9617b2acf4e119a9181d77d2ace3d49d2b47c1aaa9eadaa61d4a29ef5d0158159d6eef7a26376c0456f3720346f893dee4a9c51125aecfb9e1576e32eccf2cc07bed7e5fe4174c7cc0ef3bb9e85d0b95de976e29f3af62fcd7222ca5043f41d76d0f17c8bfb842e08d991e1ce98c40e77d98ec3ad16bd8657bc6e9729d868a408b5450b3d194cb2e6d4694213027759c07b9e7f70a8414214206596e7ee32e11f941ec615642c8fd88bd2b3d1b7dc4ed0accf0224eb50a3336c9ffb186d6668262218c92f6037c2ed44ece114781ab1afba28e2d9f106f1653c46df7862418893e74cb7f4584522e47cd7e7d8a2d561c1135adae806629f3f0efb7dcf0f286d23d11f8a60f723cfe5db6933a4ba8ae4ee7db5f8d36fad9d668aea9fe01562968b1b52b0dbf73de7290b98aa6b86b09cdb8cf37e4cc12d542dec5b2320784f55c38c7125cc685e7ef9a6855d263b7ba11388bec33bcf4286d30782cb29e54636bd6c719b6126dacf1798d7c11529d0dcf024b7b5c379a500cd386c873b6659374ab1b1e05253878b139f1577c283a975802c16bf3436f7486a981d7a08f2845e1c5f8ead8d116edb3c22735c6711ebe4953f86f6d7498518f46a74b9c3ec80fb631131f322db67c25158b18c224ff34ae678c8365c6f47f314a186a354c7a3d8a9ead42c5057fd2ba4f575681ce9195608ac366fa8ae60ad598675fc4dc5b9ad24404b15bf85c55d65d7b425ade89e34961dfed46dadde800c416e9661063f39918059a2ca1608149b19b820d230679667ef6e98abb58dd67ab4d1d39d5d22304fe0f2d18d852b04ae12b8366af335020b2d78bd056fb460914069b444cd02bc49a0bc9d80b730f436e22d6103d7db70a305efb4e15d04def2061397c3cd89e59ae8af2fabbb9f4e59ae1587ceab10545e3df5761b889da9d72b8d06186216aa4393cd46a29ce22fd46439e2add1567ae4274f8b58194c5e518a21c1abcd3bb068a7eab066eb4665750d45ba8322690063fdf3c7f46f2e1d81b2b55a1d0d905a3951fd4d55bda6aa938aa1aa6f62757dca007bca00da94fe968cf5c7f68fab7fc228536ed0941b0a68a581e5f3813fe0233f64dff782c0e1c3ee97617ed4e42b5ba38d1ebefbef79e3c5f77fd029c1efc5a11f4ef2c659a9b75b40701c83a02b1211998e22338b14c85af52542edb4c1ab31a73de4b477d2462514876939bce53fdea556c4574bf1557c100625cf3e9db2bf5efc7aed180f18fafa24cace4a8dd649c327952166c6bb3473f62ed99a518d383b639bf0b3da7c8e2ed954566f54d6eb68f5e768f5e4ef43af2ba05c04549b006d1d5d5a13f7285d459162a48c2d9e736b08b284204bb08a22aeaf218e89389995d54aad8a40c9cf1169696aa93e563e986f73a9deefa5878f84fa37a0648c2ca15b72ca1464688ae417e80afc739a2db4ff972b6ea2ae7ffeb2f0f394d4240e3d38ee8a7f4a55ae407d0d7c308d3ca19ffdd0535229ae4e170aebe193af812fbee43728514fbdf996b6a7cc90560899eac40db656ad1d05497eabdeac0621c6494043dba9b5aea1231066cd4e37b8a10cf11dc27d1683fd0d4cfa250a	2026-05-10 08:47:10.507567	-1204570371708609202	1552
18	\\x70726f64756374696f6e3a6d6f62696c655f6170692f70726f64756374732f32323963393439632f6331376664353266653063333661643866643361393931656266366633363232	\\x00118198c0e72e1280da41ffffffff789ced9c7b8c24477dc76fcfe4ee76f6f69eb6b18dc3158bbdd9837dccecccec63dac43bfb98bdc9ee3dd89df3c53e60d5d35d33d36c3fc6fdb8bdc15174a02841c486f811a260275688890352444016898870ac4408254291481082287f980b9028128a4522a1fc43f2fd5575f7f4ccceee9d8f23587092bd375353d355f5abfa7dea57bfdfafe64d071edb5f38d6741d3dd07c6f43577df5e2dd8f8d15f61bbaf160a1df562d5e1eba7bbeb87efe74b172aa3cb6565e586217332bcbefdd57d8b754291cd1b9a7b946d3371cbb3cd4f76757af3c778ebb35aef9acaa9aaaad71e6d498af7a3e67aaadb306574dbfc15e7bfef197af3ef7a783a975c3ae9b9c351dd3f01a5cc7973c4bf50de61af8e6d52b4f33dbf199ef380c5dd4b8e7717d342e72d5adf1c1d4606ad5b1eba34c751dfaa6c6eaae6ad81ef31baacf34c7d9643533a8d55a8c5fe26e8bf986c5d1fc135ffacfbffcd83ee540a5906a525bb5d4e4f80c9f2c1cd70d4f7302dbdf10c5e9c2318f9b263a29dfcfa50a476a86ad9af1dbbbda5fe0aec66d5fad73634fe1585cecb79a784cfbb9975433a002c735eaed27a1c0532fa11d6f43b5a85e6d5fba90f27c47db34528503de66501e3ab4bc562ce6b30b99bce8787f601b7e7968ff4a5dbc1dd8e246bd81ef650a87750cd2f630255e79688ff8f46838c5a23be5a183cb244eb7253e3b58555dcdd1d187c186676fc897fd1848fc6d1a4dd3545b1b8eab73375db8d7f036bca01acffc06b7d5aac9f552e11e7ce2689a4a8d8bb189564b852375cf8f6a550ac7e95d5b5eb5fedcf8ec6c6150537d5e77dcd663fb957dc6edcafef2d01dcb723287d969c334b9efc929332c7c2b5d1810ff7a17f714065c4cbd5dc75a3ea8629a513a375048098163328ea05386bd21a489c1e05d341bd4e5a3786f3a5bd1c747c5bf78a7fa01047068d5d962eb54249a3eacb91cbdd43754ff7c811535dfb8c4d78366d371fd42a102b15f30fcc6238ecd2f1e2807857e2a197cfc774ebcf2f46f579fdb57e8ff003e4997878e163d439d5871cc4de81b3db71c2863834fc97af7ed53c6d385c341538f1a5246e969a8113f0935e6deb2fd4bf736546fc30a4cdf689a7ce3d140c5f07d837ba5f60c46ebf6cd3aafa9a889f5e81aa8b761e898fff00d44fad818e6608ee6e0cef9d5e2c20a139a1faa3e7aacf49787f6dab7cd9baab629b5d5f0ecab577edf67ef0f3c9fe946adc65d4c2f336c68a1e9b857af3c63f8a8e031c84040a1c199e5a0ae1df8ae81aa633a162d8ff4b7e5044c536dd4c483a0b14ffe16e9fa6bcf3ff519b6c25b6c9edbbc66f81e1566c6d99aa135a8a92246ec5c36741a041bc1bb86a3b5541b0f3c39985ac66479a25d5d753759337021a689aa1882e8e360ea14379b1eab9126e1713553b5082a8e8d15e8c96946ff69859966c832eac0e4385b8f3e3dc555d7a7bfc4b9ab7ff0023833983aadb650dd6c3297431f3830a733ade1981c5c741d938dac2eaea283650b0a437dac9a8e831a86ab05a6689f5ac98eb353e8180db3645485501effebc154d1d03dc81b8a202bae70de94e2ab05e8a5093aa2ee489d162eab392e93a060966a434f000aff243d3d37ce96a951aab168a8550e967a68e2d35f24c26ee11175b3a5710b8435aca6aa115cf12f060418b3ad8601c2d33a8864885ee219185e38182fa8ab2ebe63fb183035981f6767a06310255be4be73391221931b43244f1393e66228b62687279fee720b8242cb9769add4c07e31af55476fd1b3a7da2ba2ec8ad93b132e322f7a42d5a1b58755e4d65bccc4e660e2a358024dee606db02d683324b885c9b39cbae9540d5bae42b17fb053f804833fef61d46ba40316a61debce3436210c5ec7e4b9422890f03ab6439d485675b6a8a99506c7b826984ebb9a4bfd3a6d5c960dda8e6b412a42aba833558e9d021d15f45352b457cdf2496520ad1c9cbb5f19c4ff878c3dcae1b47224ad1c4d2bc7e60694e346bf72bbdc32f24b0bf3a529f1d53be2ed42b973ee90f2e690efca5d9d3b8272775ab927adbc25faf8deb4f28b25e5ad25e5444561b57d79e56d11a1e76e5786d2cadb2fee51ee43d1fd6878183df9a58a3252524e56947774f353796727cc7e70fcae17ba6086a2512a5226aebf6abaa4642085c9b4920dc9f51091eb2df30f17178bcb65b670aabcba5a06bcd2e9e5d36d7cbdbc174b8d9568c3f5d88aeadaa0f1a6ca0882dc6f917a7d41682fd55a845691f60a5004aeb04db8dd200b87b4cf6b30b5d984ea5381fc060ddc6b620e475983d41630b944df1c96a68aac14194b34cd6a80256c9309b3eee0252bdb3a602c6c18ec6d72dd3dfeb94869cc1654ca1ed3d1571dbdf9243be3e0c1be513334038b47763346e685468b2d34b0e4399b6fa9ba5a37f0165baaf16008d0481517e4f0e6493b04629e792902a74b1a95100156be16b8689f56b5d6087c9bb7b08cd10f9b73a9463d3b045a6237d7d93a0987ad92eab565bd0a750099c12cdb1fc5fee0f2487083a9a4b06aaa65400409e164439d2f9274c9c4fbfc606a299a21698162d7f1540be6ce288c47bc42bfb1db5cc20842020abebe3b504d03f35f7155ddf08521c31e6aaf8997a1cbe88e464324ee44f284bed34631122fa4934954cc03cf040a9d95689f5917dd40fba21f83a905293e14341dddc07b08b605447ba00621cbb1b8a5ea1c62a64943a52d1862110e3264ba4a1c3c001c3cd00b07a91807b3b3e962711b0ed2374883fefc783a737380f051a8f423dffcf6d584963f238bdedf0d846b551540782009840b3d8130790b08b780f033078403b9f48c32501bc8ce4c8f4fe540850aa850510e0585c3f3467d916b38379987333385f4786e76966794c3e5a1c3ede398784ac80ed81ae9f1ec541220d35399fc54e9660164ee9dd7038fca35e1f131a8ff9fffc2070e75110145bfd90d8f6b5515f0584fc26382e0f1e685b30b67cf9cafb0b3e5559812ab95b536387ed8771a9a8e7958c7c10376e805b223cfb9c261010d82d51bf8ecac61e290c43457ade160c7020feb94f98935c52fe39d30736148e2e402731136366c4ed4168661d3c5dc41632d43f82448e15004f311a630ce42cc0e7516271b5aafe4701168817ed15a11ab5383c94e0703d0225cb49aec9f370a131afd7364376b2e0fbfd1505d0bdf6074e2f785f68c3255a75e5f122f6d5d98f5d03f5b9c55845386cec1a24f021251c76a389a0b228a6f7996e3a0968f71072ea868f8d47033a1d4a1368f424b03ff6f3f2d5ed2379352239934b937ceca3e83f5ed30210f8fa9f88fe1ece0a15330e56958f4485d254c041edaabba7820c931062da4361a4a4f3664434660b9254fb290778b40671a35686fcbe4e3d1163c359e8fb6600bca66f5da820f080dc2eac94c2d2ea5b39106a5567174726f8e121da7859a4213eb4cd41a2a0ff57db8e1fb4daf3031819532ae81b93ae6c96d8d63694de8b56a3dff682b939e10ae9489a0693aaa3ea16dd4b0c2466b1b108c33dad8984aa7471f956fb63666d2e9894b9989c86718bd18f3b9d51c9ba965b5d9994c55afcdaa7a353dfbe086faaef9e2c2af64d71757458fde7e71df1bae4fafdf54313e72e295271ebff3971308b165d117ba6943e5ff73dc7977a2aa278bfeae4d1b2b499bf5903617d8fcf94a65698d5dcc779a29ff2dcc94b64a1727e91469405bb6080d9bd29248ec5658f0d8f6f431ecc92ec16464de30511e52e6646879081dd41a74c457cd31a1ffc3d8565d8b5e7b0d598b7654d472b96ab522cd0d4fada18e87c64c649cc48852052f62cb24028828c0c1ecfee801d7e3e691ee95164c359f7c142f7e38e130088ff45dda9b38db47fe1bcf77b95d8f3d38c2c2f158d9b2c8b14a3bfb539fc1be4b64133e06d51ff31c33a88225970c413bf2308db2c551b634ca564e26ba406e08e1ea8a64a2f31af9b642ab24e16709bd36a12ba773ca366d67cb26c61bd22dc4ead84422a7d392eab5e833e9f8615be01751d80b2ccc2f246439b00762d7512ee1a05a075131b1cbe4d610ae96c8d26b8442ad915085b72a941ff33677f67b08d0371c5fba2b3028d7f161afac63d6559d6168bae3a96c020b4b6daaf44951171e235d953c16fb83b0c6065378a0c47655f5a4ebc35289ffacdee03c326ea622d0f67d10a4c59fdd4e3bc56c6e31f3ff6cac5cdf49e76b5ffe6a21c184a765d1e77b9d7476ab2af0012124f8f10ee2c75d8b4bebe59d00f2e05e1c2502b3ce69a590bd42936093a10d83b8d392015b4aa4fd6c3e2067de686cbe48d300e6f1d8a3a1794ce8898d0af1b161d3f2b4e934053679a11982363d8b14b0aafac00d4c08da53abe2f9a1e5e18131a1eec87d58b832d1b9f691481c02dcc4264e1e4fea716cd9278d8446642f63416d8285c2468181261d98825f641889b6e81dce5b78dd4ada39c2380a7be9720985a4d125b8074bc5a9f96d93463c4f387ad1015687e20b315fbdf24c879d236253ba2aec921d0d1cd16555db940ace35075c36b8ad9bb055aa06f41da6954e1116d6442db52eaca52d0e207a04690a9b09df7c681de2195b142323b97115672b8c0d6d794d50c4a81a6658a781451c3aee752e9cb15c0fcd1e5a77d7d2c47d4213178be5a5522e5b9abee99a78546c968baae1d259a984dd4aaed79f8ef9a367f393b353b9e9d9a9bc9ed3d5ec1bc1fcb9669f5e3fbf1a3060befde4b35fee327f5074ba9b5f16cafff89faf7ebdcbfc41d17b76e2d70334a5f7087e9111b47c6a69895dcca6d3a757db04fb7a1f992b6c91cc9e656c0ec2fd22e84208481ed42f40abb0cdbdf6fca77e83146821892f1182226a8116967119c509532ae4126d3d12325e8c98242edb440add33919263cbc5161bdb5cdb8f7bd1192f798a0b212218169e402870111fab961d53c74e1f05d546e5f689b7110ee92b4d09890eabac1a1a52023d0265f82f46020d723452f3361f64c81c44882d944e9f8b3c4bc587b4575ff8ccab9ffad0ab2f3cf7ea0b2fcb9e103e69d4c4191be6956ad621282161df0968e30f4f542270129fa6b26d8766df67092d9f9568d9d14d21503310a1663eb3349b59ea75bebad1a0478c9b23b4368f4bdc9c0bd54da266775b60b06cf75625e7a3275ef9e1495e49e8872f8bbedacb6ff191ffdae374f92d50f46f0955fa6c52956ceaee01ddd323c5d91fbe4cd5f6e7f2a184bf4212fecace275648743a5b2ccd667bc13b7dfd722c292cdd16e35cdf5fdcb80135f7e489573e3ad9f8b584284ab2e84ddd52bb56d57445c9d452b9dc783eaf4c1a8720bafd8fdd892e1e2aa44cb5cacdf2507f86258266edf1178e5683563b350422246116ee88533da27c879e0b77ee50e1f6b86698f3d19f1ecfe50bb7f31a6918b6dae8c9dfa4b05bae7098d226a2aa99f1e999c2dda2c20621cd8d931a50bf70bb7a09ba49cdcbbc06637fe130e53dc8a07f056216833cace431bec9787cb57d93c9099eaaedcfe69483b57d53ca748946b12752ba99b4323bd7f73dea57562950c733338a42250f18fdcabb4ad4002d409316e00016a0979d8cd7a01e05320f646235ff3e2dc2eff75a847b68111ef0c22ffda4975f492cbf122dbfa367611081f03baec0fffd9b6fdd9358564bb2e8a95e2b70b7aa6205ee9f9dc5f23b182fbf8362667658793431994929b6e99d96973283ff31493f02be302f050ad5cce668927e8449eafb41384bd4d8a0682cdb6eacefdf3b5a9bebfb2e56c18149cc966c2e55a3dd326ca9ef5fd114fecc623e6767a8b5efa2b5d4d4f4787612cded1de8437bf72716c5295a14274ae533cb389b9c2eafae2e55d8185ba3c04c677ec95db7ad9123ddd89e33d2a48c04724a4a831d96a9b09d75e11ae5be483f48044db0e935b7ed5bf1ce7addd9250baaa9198185fa7ff2d260ea6cbb4f553a83374d1c99c6e8e8aae330216bcae3106516c4e917558c05b6c5a621b20138f673d76c853e88a5cb1a47ff6d59f3824cd45875e8c4f0898f8b70880848d444fac766af448fc1d49a483191692a5ca445856e8728ab63ac141e1bdad91d89dc0e5be797a31c89305ba32383234a95104e85d067b2245d2ec35015e952099d2791dc0c998361b773303a3d1d75b0ce1643f6a41b39cc0fd9d1511227ca5ccb25d28c8f78906b9819d28e972d9b81cf6dc883534ee0e39fa3304c4d3a1eeae223e1f3357918c4937388c63805740c917f42cda8fe8e4921b47cad40875d3a9230fd4e869f84ae11e93139e7b8aea1e34c3e42ed87cb43c531ddf7a2fa3835fb4c872dba190194a23702a07b8ff481a0f4775777c8f4fc4266e1a6e582cc1dbb39fe902760c6f07b0716baf23b50f457dd30bd565561049118125650f9166f6ef1e6166f7e7cde08c57a1db8c92f66679766df90b839ffda1d4b5d0c41d1977ae166b7aabd70b342b8b9af74f6572bc5f26a9b37678a0f15cf2c6df3c5beedb69273d90720429474d147687aec1e0cab249684701fd02100c831497d4763ce046170b61d03bd16776eb6c626f3627f3cb804b6cd29ff5fc5b95b7365a67c7734a567e66d942eda2bed3611b18962429aeaea867349f53491bbd94ef1057c620874d321c28e6e709f3a284644ee65c7727ceec5811582473b915510a71b685dd1a773094f0e1af7b9618f467403b7a8cf5e32e357d524261aae13d485135b663b4749b1af13405198ad0b4122d233bc3b8964bebeac3a02289a2a5eb4b3844198f34d8b60740e334d41bf45c9a6b26e1a1418f049822b0d4856376e0c3e994c3e97cbdd3cf8dca4d80f11e5f7ead6235d4441d13ff682cf6e557bc14725f80c2d93adb3bafa30b0b3beb45e3cbd249356f29d4ed46f8838b2c8556986b92a235a836f6e062713b928edb8aff44e62e675ca7d4bba32e38c2caa7ade7601155b64a13d1d874a2247646253de21ea9c8c1d77868951201e4d3e457a5f8c7daf8eb16bdc38898656cc86486feb822014f5c40698b84090e04332593fbcd81402ae6d688581d553aae1cac0aa4811ec8841779a21c28094514e90ad4e3ad5a02f53242a84db8ecc598982c3e1b5840ecbe442c240a54b11adc0bdc4758829911d07a0d16589b17274cbc1912e4dd8ad7465240450073ec106c280d9713362b79cb61e598b6c847b4d4e0980e860720951ca2427cbe39ca16d9a5d2984156ea15fe2ebbeaa8b4cbaf6a02866362cf27b9a81c88b6aa7c9e722ffd2de730219e77a22a33f4acc99ce4d97667a3a8e6f344c75ac9d9833e7df3834c8f5bbff4afee30912fcae2c7a6b2f2ff16e552534ce7540e37d048dbb97d7ce9e3fb31867b8e53b32dc9edcce8a6d8c10f18ef8a25ea7f6475adf99ed1aa51ed4655823cc231d96518d0ea840f523487874053006414c8b24763e29b8225e54b6455c6e0628464e9f2f154f46fa21afd27440a2c3085a0ba5105f4209957801c39ed84aca54f6308e077971aac9606a5edea6f11b50a668a458f49119246ca975cbd9e4d852a1a994a9fb299c5c741e265a74e9e130abb9ad360b62d05444f83cd4e844c26c94ad0cbb344cf21d8d15946e47d93055bc5d60b0988c15255aef808484409cfdea85e9af9d07b828201eaa797f667a32af0ce0dfa9e93ca97a5da83afe1e0a94dc2191e63a1966b926fd96b50379140a08ec7d7f5f6c3960ed2f4dcdcc4c4ffe84f2f376c6c0f525b97e7ff08bbfdea5db28dad70b03bb559518a87560e011c2c0fda7caa78babc5878b6c61ede1f54a7195ad9d5d5861ebc5d54a97b7e45b7b932a0c516c328f0e8c22b47a8a728cd516ad5515a6bcd76d1a0c77eff9b1914129292e598b6d0357a4bb19a61e278588865a51da50db5ca89a5cd51a9179b0cd7e1050d0dc160522bdeb71c09c0ebb10eb6b980cd6d94126ee7b351d74c733026b143ca8db9c5ef63861906380c2c351d699d4ea62a785bd16de1d5b2779bef6fc8b1f8af2e063b87660c017591f241318de94211f8909448a2e91c579af212fda17165bba4c14a32dffc536d20c3156c64daed111afe5f3a4e543e603b90c3aec92cff5b47012196c896b8abd8f0d9d94880f0ed15d3a1a22dd93b4e995bc4ee771d573e44620af110a7f05082d0e4d5b9410b2a5928887c164cbb14fca3433a2b94b4759d7a3a435cd0de8c686276e2af028467a2023c83290c9cc8c4bb67c50b0e583922d07678196fceef9f3fd53e378c671e360742c99999e999fcffc74d2e7778c42132dfefea5b187ba42cb28fa875e60d9adaa04cb950eb05c24b00cc760114059581370915ce9f289dc22cb2db2fc8c93659a0237b5d4d4d4783e4360795680e5590996ebbc9bd39f451db0e570c496c952365d9c7f03b225f89a72b10b1828faa75e6cc9bfb3fcbeaeaa28fa46822d9fe860cb7b84b7b5932d022ae7ce5e58a4dcd75b36cb2db2fcfc90456cbd91c9324564794990e5a5d74716582d3990e5504496f97c3e9bddee4cfde993e584b1ae77e10245ffd28b2cbb55ed65b5bcb787d5d241965b56cb2db6fc7cb1055bef80b0526ecc6299dbfb877d497b2533559c5fccdf34aa5c5778f8baa832f13dcfe842058abedd8b2abb55ed65af3c2c7e53e9d4d9334b0fb3b5e2856d4199bedb48bbc5853857ddc22c0576cd206de07aec096dc83c0be1070d55404cb8604657bc85db1f6859c29dde1579a9340c6d33f1bb69c3d157e86af016e77e122432b26b1997776749c3b1796b3790f4be6417e1a533f822154f843d359fa9751a96f855262e7cce113122e086315479159f5dfdc41f0da6de1d6088f282324068475703c54fffc40ed5eee066c81031e2ee1033396c21a8058aaea2ef2fbc48fe4bc76f889f95721d0a872e3816b42a117da1ab47f47b455c6fffac400c9beeb04ef8db493d2efc09ba5898dc2afd569e15c68fc398d38510a232ee743e8a2bd54d678b264cdedf4bdef3a3d2661cecd9893e9930f75fb272845b4d4c99e763c1688d93891f2cda4e95f89a9fcfd5d1f08e0585d3dd2a857a0491e2eb7ef11e468b8ea6288adfe4da97aaf77e47d0e63b3de3379227678a95ec642e574adf742be598b86314896f3deae68f97f84fecf88fec93a52e76a0e8e55e98d9adaac4cc7722cc148ef8d87acd0df9f377f9ff0343aef9eb	2026-05-10 08:48:35.195872	6870391201396182532	6724
27	\\x70726f64756374696f6e3a6d6f62696c655f6170692f63617465676f726965732f6433333835613563	\\x001181737e2ecb1280da41ffffffff789ce555cb721b45144d5294e34785323654b6b7bc6025eb6529b2a462118a38c885e35072ca0416ae56cf1d4dc34cf7a4bbc78ac8c61fc11236142b3ecb05ffc1e919c98f60d8b162a5d1e8deee73cf3de7e883d5efd6df6d0c1eaa487d3458d322e3d1cee32f84b273fa940e84cde8c0b24b56062bcf4e069b113b6955ee95d1a39dfb7f3ef57424ac48158d85f609d768c634b14a4f696e0aca0b8b57310ed98dc3211495e7e6d64485f48e9c29ace488226559fa744eb13519795b388fb7a991222dbbd9ba3a1d1776d16f859e322947d69850a8347a44a4022a7464ec1313b91ab1764589450b5f00257981836b94a86942baf0b6eca891d011fdc8d6903419b065ca31194d6f0a0ce6e7f595e1c393c1872a13533e2b6c8ab97f4bbccfdda0d1c8cae15d397b1ddd0d2b54ea1a427a75ce67ce1b8ba6c6243513d7b05c8dd9e0f9612cb3837cf2e5913ad64e7dfbfca0f97a3c7a7274f2ca8df4e72da9464f46d9a19bb40f6371fab58abf697eb6bbdbebb73ba215b5e36eabdbe9c5729f9bed6e578a7dee772742f67b1d8ef7e249a76195e47aaea725eced25d767d214daabd5c156a45c9e8af999b1115b75efddc6f09eda1cae8c76b6abadbf5c7484fee1eaff6acbc3b5e6705d6d0d3716b47c1c68f9e43996aa1ddc70a4d294af8979d07ef07766302bbddf801bf129038c8a3647de4c819f2d4961392e52b0b2a4c97991a7fc4f63c7c644248b14a3721dd60493981b6aa3b0773a1756b1571c6ea88667ed77f15342d9024caa7e40b198aa1a7d6f66c256ccc4e6ad877641e7395f2f2fd0ef3860079299f2090954cac2dd60ae6c1705a681be64a0f2d1faa3f5f19d4b0f6b761549d38aa4d0bc44062a50c65cd526a80533e48a0928d192abe2426bc6b31315caf008466fc82048127772e0a4640b0c2a9c9e19e7af34121b9bd5e934a996806f41744099b148319cbdc5394e533903378ae764e2182d826689c19a4cc625ac89480346b024e625f79851c10bf3306b2c3062c5cbb5cc76af64b61564f6f8c502da78c6ec59c30d4ba10d2f2f7e7ea517c3e28acb8b5fab645e921c5ebc30f4348af0655c4c85bdbcf885aaab60e0dfffa3b87afd2f7125facd76abd76f757bdd562491575274782fe6de7edcee44b2dddb6bb6b8dd948d738613c404542e430bdcac5d71b31db8593f1e7d35a62bdffd71ffce448ae13233c366e028a5c32ac2f6735b296429162c5178c27d3a72b7b63c532e82ec4a95e761e5c8077e8b8acab89e65a2d59b82172165c05ca9d8ca2a0b7f98c2430ef33bc47b43a1a58c2c673000c99405c2c989986b0b7d8b08f6662be0b95232cf4a4746d6e461b260461732174ebbbcf8e9da2f32e14c214b71d38d97467b882f44c43203cb30c0cd4b2b4cc1920631b04318bdccf16516016dd0019c5d996f9156b78c776b11741a387f692ba11e078e224ea12e7b2b226aef0773f96f105055f15338be11c89b410d7f01ebed0620	2026-05-10 08:59:01.267993	1914060560158801311	1265
28	\\x70726f64756374696f6e3a6d6f62696c655f6170692f66656174757265642f63346532656238622f6c696d69745f35	\\x00118154ec8ccc1280da41ffffffff789ccd564d6f1b5514b5abcae3b1e3d86edaf483408c212d94d47de38f387957951cd41a4d5aa9553142220bebc5f3c6797432e3ce9b891b82041bb648b04562c12f40ac58a26e58b3e427b0650b12dc37e3afa449e80224168efdeedcb9e7de73ce9dc9f9f476e6f016d584253caabb6c8f9be5f463364cd1d4bd0e2d585cf67c310884e79ae5ace4c3a7c3a729d03a3433f0458fdb29832e5842f6bcd00dba5188d00b923b8e70fbf1b9a5d3822d5ce64c8e57a63770bfc7dd80f5b948d00b93707030c032d3bafbcc0955c0f3457f5a090392ed238eecb23d9567a708cdc8c0eb3d11e73a499a964f42d5b355358c5ad4b31eba2230cbdafd7e74cc0eb9e8ef0684e62db1c75d89334a428b03dfb3c25edc85599e7bcff77adc3f88ee98db617ecfb3103ab72bdd6efc53c7fea5594e44196a8881c30eba9e6f719fd02521bb32dc9990d8e52edb71b8d5a6d7f08ad7eb31051b8d14a1b669a12f8369d6823a4d6942e01e0b78dff30f0e35488802a4ccf2c25d26fc83d2a3b8828ce5117b517a36fa96db099af55980641d6a748eed731fa3ad0ccd440423f905ec46b8dd883d9c024f63f65517453c3bde30be8cc7e81b4f2c0871f29ce996de57910839dff339b6687559f0012d6df602b1cfdf0f0703cf0f28ed20d11f8a60f723cfe5db6933a4ba8ae4ee7db5fcd36fed9d568aea9fe01562968b9b52b0dbf73de7090b98aa6b86b09adb8af37e4cc12d542d1c586320784755c38c4925cc685d7ef1a6a55d26bb7ba1138881c3bb4f4386d30782cb19e5c636bd6c719b6126dacf1798d7c51529d0dce824b7b5c345a500cd386c873b6659374ab1b1e0524b878b539f1577c2839975802c16bf3431f7586a981f7908f2845e9c5c8ead8d116edb3c2273526719ebe4953f46f6d7498518f46a74b9cbec80fb131131f322db67c25158b18c224ff34ae678c80e5cef44f314a186a35427a3d8a9eacc2c5057fd2ba48d0d681ce919d608345b375457b0de2ac306fea6e2dc8324405b15bf85c55d65d7b425ade89e34961dfdd46dadde800c416e56610e3f39918079a2ca1608145b19b820d2b06096e7ef6e9acdda667b23dae8d9ce2e11582470f9e8c6c2150257095c1bb7f90a81a536bcda86d7dab04ca0345ea256015e2750de4ec01b187a13f156b081eb1db8d186b73af036023ff0865397c3cda9e55ae8af2fabbb9fce58ae1d87ceab10545e3ef57607889da9d72b8d0618621eaa2393cd47a29ce22fd46435e2add1517ae4a74f8b58194c5e538a21c1cdd61d58b6537558b775a3d25c4791eea0481ac044fffc31fd5b2b47a06cad564703a4d64e547f4b55afa9eaa462a8ea5b585d9f31c09e328036a3bf2563fdb1fde3ea9f30ca8c1b34e586025a6968f97ce80ff9d80fd977bd2070f8a8fb55581c37f9d2d6e8a087effe7bde78fefd1f7446f07b71e88793bc7156eaed36101cc720e88a4444a6a3c8cc2205b2567d81503b6df06acc691f39ed9fb45109c5615a8e6ef98f77a91df1d5567c151f8641c9b34fa7ecafe7bf5e3bc60386be3e89b2b352a375d2f0496588b9c92ecd9dbd4bb6665423ceced826fc345bcfd0255bcaea8dca461dadfe0cad9efc7de47505948b806a53a0074797d6c43d4a5751a41829638b67dc1a81ac20c80a3451c48d75c4311127b3d6acd4aa0894fc1c91566696ea63e583c50e97eafd5e7af458a87f034ac6d812ba25674c4146a6487e81aec03fa7d942fb7fb9e226eafae72f4b3fcf484de2d0c3e3aef8a754e50ad4d7c007d3d813fad90f3d2595e2ea74a1b01e3ef91af8e24b7e8312f5d59b6f657bc60c698590a94edd606bd5da5190e4b7eacd6a10629c0434b29d5aeb1a3a0261d6ed74831bca10df21dc6731d8df42022509	2026-05-10 08:59:06.32878	-9194016383048298815	1551
32	\\x70726f64756374696f6e3a6d6f62696c655f6170692f63617465676f726965732f3035636639313033	\\x001181506d8d341580da41ffffffff789ce555cb721b45144d5294e34785323654b6b7bc6025eb6529b2a462118a38c885e35072ca0416ae56cf1d4dc34cf7a4bbc78ac8c61fc11236142b3ecb05ffc1e919c98f60d8b162a5d1e8deee73cf3de7e883d5efd6df6d0c1eaa487d3458d322e3d1cee32f84b273fa940e84cde8c0b24b56062bcf4e069b113b6955ee95d1a39dfb7f3ef57424ac48158d85f609d768c634b14a4f696e0aca0b8b57310ed98dc3211495e7e6d64485f48e9c29ace488226559fa744eb13519795b388fb7a991222dbbd9ba3a1d1776d16f859e322947d69850a8347a44a4022a7464ec1313b91ab1764589450b5f00257981836b94a86942baf0b6eca891d011fdc8d6903419b065ca31194d6f0a0ce6e7f595e1c393c1872a13533e2b6c8ab97f4bbccfdda0d1c8cae15d397b1ddd0d2b54ea1a427a75ce67ce1b8ba6c6243513d7b05c8dd9e0f9612cb3837cf2e5913ad64e7dfbfca0f97a3c7a7274f2ca8df4e72da9464f46d9a19bb40f6371fab58abf697eb6bbdbebb73ba215b5e36eabdbe9c5729f9bed6e578a7dee772742f67b1d8ef7e249a76195e47aaea725eced25d767d214daabd5c156a45c9e8af999b1115b75efddc6f09eda1cae8c76b6abadbf5c7484fee1eaff6acbc3b5e6705d6d0d3716b47c1c68f9e43996aa1ddc70a4d294af8979d07ef07766302bbddf801bf129038c8a3647de4c819f2d4961392e52b0b2a4c97991a7fc4f63c7c644248b14a3721dd60493981b6aa3b0773a1756b1571c6ea88667ed77f15342d9024caa7e40b198aa1a7d6f66c256ccc4e6ad877641e7395f2f2fd0ef3860079299f2090954cac2dd60ae6c1705a681be64a0f2d1faa3f5f19d4b0f6b761549d38aa4d0bc44062a50c65cd526a80533e48a0928d192abe2426bc6b31315caf008466fc82048127772e0a4640b0c2a9c9e19e7af34121b9bd5e934a996806f41744099b148319cbdc5394e533903378ae764e2182d826689c19a4cc625ac89480346b024e625f79851c10bf3306b2c3062c5cbb5cc76af64b61564f6f8c502da78c6ec59c30d4ba10d2f2f7e7ea517c3e28acb8b5fab645e921c5ebc30f4348af0655c4c85bdbcf885aaab60e0dfffa3b87afd2f7125facd76abd76f757bdd562491575274782fe6de7edcee44b2dddb6bb6b8dd948d738613c404542e430bdcac5d71b31db8593f1e7d35a62bdffd71ffce448ae13233c366e028a5c32ac2f6735b296429162c5178c27d3a72b7b63c532e82ec4a95e761e5c8077e8b8acab89e65a2d59b82172165c05ca9d8ca2a0b7f98c2430ef33bc47b43a1a58c2c673000c99405c2c989986b0b7d8b08f6662be0b95232cf4a4746d6e461b260461732174ebbbcf8e9da2f32e14c214b71d38d97467b882f44c43203cb30c0cd4b2b4cc1920631b04318bdccf16516016dd0019c5d996f9156b78c776b11741a387f692ba11e078e224ea12e7b2b226aef0773f96f105055f15338be11c89b410d7f01ebed0620	2026-05-10 09:40:10.250331	-7495597929110645182	1265
33	\\x70726f64756374696f6e3a6d6f62696c655f6170692f66656174757265642f30313065383032342f6c696d69745f35	\\x0011812928fb351580da41ffffffff789ccd564d6f1b5514b551e5f1d8716c376dfa4120c690164aeabef1479cbcab4a0e6a8d26add4aa3542220bebc5f3c6797432e3ce9b891b82041bb648b04562c12f40ac58a26e58b3e427b0650b12dc37e3afa449e80224168efdeedcb9e7de73ce9dc9b9f476e6f026d584253caabb6c8f9be5f423364cd1d4dd0e2d585cf67c310884e79ae5ace4c3a7c3a729d03a3433f0458fdb29832e5842f6bcd00dba5188d0f3923b8e70fbf1b9a5d3822d5ce64c8e97a73770bfc7dd80f5b948d0f393707030c032d3bafbcc0955c0f3457f5a090392ed238eecb23d9567a708cdc8c0eb3d11af3c4ed2b47c12aa9eadaa61d4a29ef5d0158159d6eef5a36376c8457f3720346f893dee4a9c51125a1cf89e15f6e22eccf2dcfbbed7e3fe4174c7dc0ef37b9e85d0b95de976e39f3af62fcd7222ca50430c1c76d0f57c8bfb842e09d995e1ce84c42e77d98ec3ad36bd8a57bc5e8f29d868a408b54d0b7d194cb316d4694a1302f758c0fb9e7f70a841421420659617ee30e11f941ec615642c8fd88bd2b3d1b7dc4ed0accf0224eb50a3736c9ffb186d6568262218c92f6037c2ed46ece114781ab3afba28e2d9f186f1653c46df7862418893e74cb7f4584522e47ccfe7d8a2d565c107b4b4d90bc43e7f1c0e069e1f50da41a23f14c1ee479ecbb7d366487515c9ddfd6af9a7dfda3bad14d53fc12bc42c1737a560b7ee79ce13163055d70c6135b715e7fd98829ba85a38b0c640f0aeaa8619934a98d1baf4e24d4bbb4c76f74227100387779f860ca70f049733ca8d6d7ac9e236c34cb49f2f30af8b2b52a0b9d1496e6b878b4a019a71d80e77ccb26e946263c1c5960e17a63e2bee840733eb00592c7e7162eeb1d4303ff210e409bd30b91c5b1b23dcb67944e6a4ce32d6c92b7f8cecaf930a31e895e87297d901f7272262e605b6cf84a3b06219459ee695ccf1901db8d689e629420d47a94e46b153d59959a0aefa57481b1bd038d233ac1168b6aeabae60bd55860dfc4dc52bf793006d55fc261677955dd396b4a27bd25876f453b7b57a033204b9598539fce44402e6892a5b20506c65e0bcd060c12ccfdfd9349bb5cdf646b4d1b39d5d24b048e0d2d18d85cb04ae10b83a6ef355024b6d78ad0dafb761994069bc44ad02bc41a0bc9d803731f416e2ad6003d73a70bd0d6f77e01d04beef0da72e871b53cbb5d05f5f56773f9db15c3b0e9d5321a8bc7ceaad0e103b53af571a0d30c43c5447269b8f4439c55fa8c96ac45ba3a3f4c84f9f16b13298bca61443829baddbb06ca7eab06eeb46a5b98e22dd4691348089fef963fab7568e40d95aad8e0648ad9da8fe96aa5e53d549c550d5b7b0ba3e63803d65006d467f4bc6fa63fbc7d53f6194e36e28a0958696cf87fe908ffd907dcf0b02878fba5f85c571932f6d8d0e7af8cebfe78de7dfff416704bf1b877e38c91b67a5de6a03c1710c82ae4844643a8acc2c52206bd51708b5d306afc69cf691d3fe491b95501ca6e5e896ff7897da115f6dc557f14118943cfb74cafe7afeebd5633c60e8eb93283b2b355a270d9f5486989becd2dcd9bb646b4635e2ec8c6dc24fb3f50c5db2a5acdea86cd4d1eacfd0eac9df475e5740b908a83605ba7f74694ddca37415458a9132b678c6ad11c80a82ac401345dc58471c1371326bcd4aad8a40c9cf11696566a93e563e58ec70a9deefa5878f84fa37a0648c2da15b72c61464648ae417e80afc739a2db4ff972b6ea0ae7ffeb2f4f38cd4240e3d38ee8a7f4a55ae407d0d7c308d3da19ffdd0535229ae4e170aebe193af812fbee43728515fbdf956b667cc90560899ead40db656ad1d05497eabdeac0621c6494023dba9b5aea1231066dd4e37b8a10cf11dc27d1683fd0d2fe52507	2026-05-10 09:40:16.542689	-3994585073774747684	1549
26	\\x5f5f736f6c69645f63616368655f656e7472795f73697a655f6d6f76696e675f617665726167655f657374696d61746573	\\x3336353638	2026-05-10 08:56:05.925143	6706543775222517821	194
45	\\x70726f64756374696f6e3a6d6f62696c655f6170692f70726f647563742f64616133316138362f313035	\\x0011815a2158414981da41ffffffff789cc5575d6c5b491576caca8e9d1f276dd3ee864006b794769bbad776d2343320393471f7d2aeb6da181511216b7cef5c7b36d777dc997be3ba416855f10468f9db974a95761f5a09c1c3be2e428248bcf2887843aafa82785b09091ee1cc5cff5cb261a916104a22e79c39737ebe397f7e69f2c0c219eef2006703da617661d2556e1aa7b7eb78ce65ca91bc1b7211d8850cb049a68e735dc91de66556d7f029972b474441d8303c0b9f54ccf779d08ae9ea249ef37840fd11f9f2f802930e0b42da623c854f8ed861bf0b6ac67af7a91f698690bc35d6040c45f7c18e6ad08e96f3d216cea950387b3c8327d55e641766b736edf5ca666da362bcce46010f21885b2d434ef5186fb5430be75dde618182089585e7bb52b89113bb6117a66f4ae130d93737a69b543ac205db336d1534e27fb31080b20b2923a1a3e8fab4df10d265d2c24b5c3554d41c41d860016dfaccade14538118e43b5591393b15ac3732d158ea54e696a8c13187668c85a42f60f3224c5e748da2e9cdaa25cf6d19d58838a1f88778cf894f954bb293c256908681d64f034dd6712b8d52cce198401fd39f086070d031f4401d4107eedc53cd0bee80d8fe7cd2750348c20f2d9dba2877634cb98ce3b92818f6e83865fc768d309f93edb89ba5d21438ceb80f45d1eb6bf2902b63b694738ab3933d51f2f1fbe536e7f3b8db30fe0c4b20bf39b8ad3abb784bf4743aaf5da115999a9c5722fa5c91578b6a8eb0e0d91cb5a1b488c348144f5ccc72f2db5a96a74223fe45d9f35ee4514c20f395389a78b733bb7ba5a5c5bc3675de65110872c941c841b5026b3786640a9ddccc1197887599cf36993f976215b42717a91052f5d22a7c7e936df8cfa89b22053500b0ba3241fbc789dccda85fcf8c18da67c15e1d323c941b667ad2254df69e679cc403cd0bb4496bdf42aceebbc194a968aebd7f12be6bc41bd90c9d1e35697f069ba4fb9af8d3786c593d7cf1f875d2717ea26c23ca94070e54470e5447064d5cb5456c99497be46d66a3a8654ecb945ae5964bd7a597b5521d7b5d7a5eb640318986709a9817abc20996fde7150036a377770054caeebe49eaf3315a2c189d139396a43245b4524670192884cc3df0c4f91594b1b9db3c87c354b4ef2137ff80c390588962bca353fa63c929e2f58e4ccd0ddb3ff5cefe4658bbc6291c5e1f1672db254239fab91cfd7c8b245d0279620f982450abb29720ea4ce832f5f04e72ed4c9976ae4628d5cb20b3376302e1af2ea38839f7e7ff970f6afdf7898c8e05fc4ac9c6691e25894fd68f930ffe8ecad84e85b31ebb746f46a8d58804bc922e5dd94c1f49af636ab311d61d98b932ceb4d96583986d30638ed63e15c9dd07066ca95ff0a8c759d166b6320ab1b9f1ab57300d177fcc59f24a0b814b3168fa2761ef81ffcb17898107d3566bd3646cd4ea2d636a83db87fffc110b5ecfd0703e20572f02b06343d8c6e6c5d5b5f5bff1fa4e07f80dc05688f7f3fb7733e01c7e598f5f828725af457e2d1c523a2c07aff5fe4db9735728b5bdb3b36baf1c65d74f3b5ed6db45bb1acd76f7f6b08e589df4fdc8924435b4c7174b3cd187afef64fd1ebd465286c335497d4e5a11992e82eeda3e78f7ff6d17b4fbf3b939bc9dd90ba9bb9c893a263643bdcdf43c283cffbc0de2c2357eb74444fad201149d4d2da9b522f0da82f227307ba623b604ae97b34020e0c0407d9810bfd1db58470f56111edc0fcbbe2b4231980e648810a14263cebb0b02d5c854201bd8a2926f719a2e0165d412155215b413470511085d2dc286af76f0adf6501e20178e80bb9625cd1a4e7d37d4deb2b5deaec81c51ecc4c14c0bc9560acc902e6f1500150ef420c5c21f80d4488de8aa057ea2057100f9fbffd48a16e0406fb5a2983a1df47aa2b44803e7aef07bfd11edc61524f0fe409895c98027df044ec416c2be8d9939f3f7bfaf0d993c7cf9efc3af684baae89ba4d433006c3df6f015006e15044e039c4ded7287718f55571d0547295e2f5615b89a042a2b8428e1972898a991ad6cb574bdb1ba5ed61bde46e73185e71c9409a7daa7e537de3058ba6fe894523de593efcdb25564f544218b37e77b4687e081df97b7f498984e8bb31eb4fe3a28992452374d14cbe497bc3129952ac77af77ef45fbcd9ba6df4c29b75c2a1ddba8adff439bd98646f1e75ab39a80e16b31ebc3a388fd3bd1abf5b8cd8047e5c1023667d693f1ee05c7c9ed04480dd871ab09829c40f1666295603341b099e409192d3ef347169feac58f69d67737368ed53ef17eacbe3af118740385f989db1383c5675ab27dce7a7a3b3fe9329feb0a852ddc1307f02d69bc96f902767efde56417d26276d3f7e3ee6496cab330c961c5d7dbd350835d3853b9b2869aba49e9bee6d27efc9d6041b579b7ab5750a74d257c2bb00bcb35091d71c847b429a06f3d7ff8cb35cbd257fe01d034fbf8	2026-05-14 01:17:33.980475	-4635201860301457638	1961
60	\\x70726f64756374696f6e3a6d6f62696c655f6170692f66656174757265642f64616133316138362f6c696d69745f35	\\x00118144146e634b81da41ffffffff789ccd564d6f1b5514b5abcae3b1e3d86edaf483408c212d94d47de38f387957951cd41a4d5aa9553142220bebc5f3c6797432e3ce9b891b82041bb648b04562c12f40ac58a26e58b3e427b0650b12dc37e3afa449e80224168efdeedcb9e7de73ce9dc9f9f476e6f016d584253caabb6c8f9be5f463364cd1d4bd0e2d585cf67c310884e79ae5ace4c3a7c3a729d03a3433f0458fdb29832e5842f6bcd00dba5188d00b923b8e70fbf1b9a5d3822d5ce64c8e57a63770bfc7dd80f5b948d00b93707030c032d3bafbcc0955c0f3457f5a090392ed238eecb23d9567a708cdc8c0eb3d11e71e27695a3e0955cf56d5306a51cf7ae88ac02c6bf7fbd1313be4a2bf1b109ab7c41e7725ce28092d0e7ccf0a7b71176679ee3ddfeb71ff20ba636e87f93dcf42e8dcae74bbf14f1dfb9766391165a821060e3be87abec57d429784ecca7067426297bb6cc7e1569b5ec32b5eafc7146c345284daa685be0ca6590bea34a509817b2ce07dcf3f38d420210a9032cb0b7799f00f4a8fe20a329647ec45e9d9e85b6e2768d667019275a8d139b6cf7d8cb6323413118ce417b01be17623f6700a3c8dd9575d14f1ec78c3f8321ea36f3cb120c4c973a65b7a5f4522e47ccfe7d8a2d565c107b4b4d90bc43e7f3f1c0c3c3fa0b483447f2882dd8f3c976fa7cd90ea2a92bbf7d5f24fbfb5775a29aa7f825788592e6e4ac16edff79c272c60aaae19c26a6e2bcefb3105b750b570608d81e01d550d33269530a375f9c59b967699ecee854e20060eef3e0d194e1f082e67941bdbf4b2c56d8699683f5f605e1757a44073a393dcd60e17950234e3b01dee9865dd28c5c6824b2d1d2e4e7d56dc090f66d601b258fcd2c4dc63a9617ee421c8137a717239b63646b86df388cc499d65ac9357fe18d95f271562d0abd1e52eb303ee4f44c4cc8b6c9f094761c5328a3ccd2b99e3213b70bd13cd53841a8e529d8c62a7aa33b3405df5af903636a071a4675823d06cdd505dc17aab0c1bf89b8a730f92006d55fc161677955dd396b4a27bd25876f453b7b57a033204b9598539fce44402e6892a5b20506c65e082d060c12ccfdfdd349bb5cdf646b4d1b39d5d22b048e0f2d18d852b04ae12b8366ef315024b6d78b50dafb561994069bc44ad02bc4ea0bc9d803730f426e2ad6003d73b70a30d6f75e06d047ee00da72e879b53cbb5d05f5f56773f9db15c3b0e9d5721a8bc7ceaed0e103b53af571a0d30c43c5447269b8f4439c55fa8c96ac45ba3a3f4c84f9f16b13298bca61443829bad3bb06ca7eab06eeb46a5b98e22dd4191348089fef963fab7568e40d95aad8e0648ad9da8fe96aa5e53d549c550d5b7b0ba3e63803d65006d467f4bc6fa63fbc7d53f6194e36e28a0958696cf87fe908ffd907dd70b02878fba5f85c571932f6d8d0e7af8eebfe78de7dfff416704bf17877e38c91b67a5de6e03c1710c82ae4844643a8acc2c52206bd51708b5d306afc69cf691d3fe491b95501ca6e5e896ff7897da115f6dc557f16118943cfb74cafe7afeebb5633c60e8eb93283b2b355a270d9f5486989becd2dcd9bb646b4635e2ec8c6dc24fb3f50c5db2a5acdea86cd4d1eacfd0eac9df475e5740b908a836057a7074694ddca37415458a9132b678c6ad11c80a82ac401345dc58471c1371326bcd4aad8a40c9cf11696566a93e563e58ec70a9deefa5478f85fa37a0648c2da15b72c61464648ae417e80afc739a2db4ff972b6ea2ae7ffeb2f4f38cd4240e3d3cee8a7f4a55ae407d0d7c308d3da19ffdd0535229ae4e170aebe193af812fbee43728515fbdf956b667cc90560899ead40db656ad1d05497eabdeac0621c6494023dba9b5aea1231066dd4e37b8a10cf11dc27d1683fd0d24ed2506	2026-05-14 01:53:57.842155	6020781277318182322	1549
61	\\x70726f64756374696f6e3a6d6f62696c655f6170692f70726f64756374732f64616133316138362f3635663232323764373636373966313561633831393965646565346235623033	\\x0011814b8852c84b81da41ffffffff789ced7d0b741cd7791e012a040912202951b224cbe19896185202c07d02d85d3ac602d8055700080a0fd13265d3839dd9dd1166675633b304574a53d54923d79195e8e1f4c8928e1b5b8a6ae7f8287e3476fd9069f9b8aadb34ad53d7af931edb4ce4baeef189e2f65427a73976ffffbf7367eecc0e162009c93c368f2d70f7eedd9d3bfffdffeffeefb96afbfd3dd9ab1b96a934cb8e7d5a911df954fafec16c8fa6686fcbee30e4ba5a3a70c3787e616936bf78ac34385f9a2848a7e2d353efdc96dd5658ccee5154bb6c690d47338dd281ae8f9f7fe0a913aa5551cb8eb42cebb2515625b32239b2eda8926c28524d9575a726bdf2a1875e38ffd4bfeeeb5dd08caaae4a0d53d7ec9aaac097ecbaec6892a5c137cf3ff09864988ee498a6044b2cabb6ad2a03de9025af0ef5f5f6f5ce98467540922d13bf5996aa96ac19b6e4d464472a9be68a54d19b954a4b52cfa8564b72b4ba0a977fff17ffeeb37fb02db77d31dbdbc06b557a1343a36a227b8da2d965b36938a7693896bdda56751d16c9de8ff566f7543443d6bdb7d7fb5f50adb26a387255d5b664aff6869d56037ec6ffdd33b2dec401d3d2aafe2fc1802d9f81ebd8a7e53aceab6c8b657b6dc72caf68bdd9edf64ab374a07f6a3e9f4f2727e2695af88ea6a139a5033dd3557abb7355d5aa35f85e3cbb5b819b346cd812bb74600b7dbad7dd625a4ee9c0ae2924a7d5a2cf762dcb56d954600d7d35db38cd5eee801bf1be8d77d3d0e5d669d352542b96bd49b34fdbcd656fe74fab86bcacab4a317b237c6296cb325e9cee8dae5acceea9da0e9fb598bd06dff9f4aaec480d6532d9beb2eca855d36adddf93dba6edcbf5940e5c3bc536f3a034abe9baead86ccbb43a7c2b96dd49ffdaa7b664775ab0f546157879970cdb0ca3633bb3bd4470d88c3db028cd384dd4849b81777c3770c97be1bd6eaef28ff7d2bff04e769a4080fe1973555ac021baf4eeb2a5c22a95d3b2b39495f265473ba32e341b0dd372b2d94520fb49cda9bdc334d453db4bcdec0e1ce97be80ff79f7becf7979fda96dd711f7c122b1dd89bb735f9c8b4a9af80bce1ef969ab9c1be47d9bc9bb7e58662d9ddcd86c22f941bc05f8319de2fc18cb137b67fe9a69a6c9fae3775476be8eae97b9b32dcbea3a976d1df41ceb76f50d48a0c33811f2d0de69dd614d87ff70d90f4fe41d88331dc83ebc667f213d31249be2bfab0e2dc8ed2816e63ebb82e975798b46ab671fe81271ce99ea6ed488a56a9a8166cafa4192085ba699d7fe071cd8109b604342050a8a952dd84b946d3b134983aa800d3aa5c7e5b66532acb06cc841f02897de44194f5573ef4e8c7a469b5258dab865ad11c1b07e343d2bc56aee1a5f270c7e6594dc19b900ec1bb9a596ec906fce0e1bede29d82c9baeabc8d68ad4685a40a623cb740bb4c6bede63aadeb0a50a4a12fc5c4597eb082aa6011c68b36d86f52387e9ba8b65b880c490b4c03f3da6ca96837f11e7ce3ffd0ce04c5fefacdc82e97a43b254900715604e91ca35535701172d53970ecd4ccec0024b7510185ce3b26e9a3043b3ca4d9dae8f57490e49c76061789b456d9988f2d097fa7af39a6203bd4110d8c469556d30f2559ab04a1dd011e61eaa22e34a15d39218504875d9003901a0700ee3afa786a429bc28ce98d4e46515b0d4864b7cf47388b0abf01355bd5556eb80b05abd2197115ce15fb821006369b5a601c2231f701ac22ae137e0f6dc9bb19b55d982ef180edc305e303d241d071903524a93aa639ee52494d8c1c0e9a9c3a659702b4699dd1efb754bad03a1e0ca6791572a80fdb4afcba6d2c2df1ef639a264d1ee1d7799cce6bfb06c22ef011759d596a4c3e1a0c3471e051aaa09bc21ad823403055761f3ea66553797358371219d1fd231f8046e7ec986bb9e4719a8c3b603dfe9da0a1043adc2e6594414a0f0021c870a22d9b2b98a979aaea9705f4724054f350bd735ab9d6517344cab0e5421a9c2c52cab7052c04209fd72bd785665d4446e672cb76bec965c1ffcd7af6dc9ed8ee5f6c4727b63b9abc776e6aed17a72fbd891912e4c8c1787e9abd77ac745eebab1fedc1b5c7ccf5d1f3c117237c47237c6726fe41fdf14cbbda998fbf5626eff624eaa6c4be7decc117a6c5fee402cf796535b7237c3d02d70e183b092df58cc1d2ae60e2fe66e0de367eeb62098fdf49aeb9f0981190c0de050eec8c6a7c68ab938502111cb255de4ba1391eb8de377e527f3532569e2586966a604e0158b4dcdfaf0f54237b09a54c403d796a665cb00345e91250441d569a178fd39492fce9a04a942e925a0685aa49ba8460d351c943ebb26c98d06883e0eb06fe08ddb0dd8c301a986620b607206bf7990a92a6c125796709be526b0b0812acc82092fa592a10018930e03671be3bb873ec185466f814819830aac5581d57c583a6ec20f3b5a452b6bc03c6c991e649eacb5a4891ab0bc2a8db76445ae6af0168e54ed6d2e8072519c60b7378ed24110f3f8a739705a2851020980f3cb4d0bae8f5c5dae351d436d011bc33a0c55656214b920404b38cd1569018923cda0e8f9b49e0171006406cc329c01381f2c9513aeaf57245645ae6b400281384957e6f3485d54f13ed9d75be03bc4345038756cb90eeace00288ff00ad60da7cd19b8031701095fef68caba06fbbf68c98ae6902223dde9f3c40b20cbb09c32de22e20ea727c83b1e14873c463a2c42c538c03302852215f19c59a065c0f5691d7dbd138c7c30d030150dde03615b00d136a00642965957ebb2a2029971d360d22a28621c0ee2a8ba3238380a7070340a0e76787090c9c4f2f93638885d241aec480fc5e29b03080f8348bfe3db3f382f48f9e36ce89e3020ac379500e1a8080827230121710510ae00c22f1d206c4fc546733b2b3b93a32343c3294085454085c55c7f33bb7b5cab4eaa65b09bf4ddf1d16c6c2895c9a8f1dceed281ddbe3946bfe26207e81ab1a1e43000482f079091e1787ab8b859003276db46c063715df0f80310ff3ffbb5fbfa43880043bf17068ff5a612782c88e07104c1e30d13731373c79716a5b9d20ca812338bf33e70bcda350b920efbb0008607e8a127518f3c6191c3022408b4dea623cd693a184952d9922b60d8494d1bf85472049e52cfc23b5273419104cb05d445d0b141e784d9a418362cd83b90d8ba463e0914381802f5115461b08524c39559b06c905fd1e142d002f285bc42dc5906951d0d03400b9769cb6c7df600a8d0b03e932db362a9ee376ab255876f4868f13b243d0392ace0aacfd04b4321b51ee4cf205b859c326807d39a0824f8c22a609a1322d2b7ecba69c22c07eebb69012a6a0e5eb82108b52bcd0320a54de72b1fa597f84d916a4893866a0f49254702eddb94881eb624c3ff25b01d6c5814a8f2785bf8938a8c30d1b4e17acb16fc20d2d1035aa0da804b3d7621036804585e67962cd0bb8540a76b1590de96ae0ef123787828cd8fe03a085b3dea08de4e1204dc131f9e2cc4925c827a67c074b2364788ae4146ed854b2c4834eb40e940d77b6b8ed3b0b3478e00a70c95017315d827ab3504ac7544a92c57d3f7b6e2b123e44a39d26ce8a6ac1c299fae00870d544e0361cc81dae9e1586ce05ef666f5f4682c76e44cfc08f719f217838e5a6f0c8e5692e5cc687c59a9646465399679db69f9ade3f989db930b9333b4a2b79cda76d9ade9c25515ed7dfbcfbdffa1eb7e538010830dfd79186d70fc1fae31ef10a6da6ce86b3edad445b45970d1e6a434beb4b85898974ea5836acaff2135c517e97c02ad480da46515a161856912c269050c0fc79e320867b2856072685cd361dc4599c3aee6413258aea1892feb8324ff07e158b5eaf8daaeb15978a2c22c4b95eb2d2eb9aed5eacab8abcc70e5c4832899f0c2d34c3880d0001866b7f01fd8889b87b9575aa0aa39e8a378eebd82c3c035e943d22bd8f6dc7f633b966a543d0f0e6938b654aad7d1b18a27fba31f837317918d7c0cb233689b7a7319b0e48c4668871ea6016972402a0c48d3878525a01b825c5d9c268a5a41df96ab95087e16d76be3ba72825bb66298ab0662bcc6dc4252150e11ee742ac8760b3f638e1f6915f00b51d86ed6617f81427513f401cf7594121c540b80a8b0b153e8d620570bd7f46a2e512b4854f256b9f493ec95b5fd1e04f435d361ee0ab829cb74405f59805d9715096e4d316d593a028c253764fc24af90c74891191ed3f940da585f2ffc2083ed65d966ae8fba8cf82f556baaca959b610eb45dff0c9016fe74b276f2c9d464fc7556563666e97cfdab7f911530e13136f4c9284ba7d354820f2082801fb7227e5c3f595828ad05206feb0653a2a95755e414d45770130c54b441210e6a32802d45947e69bc89cebc014f7d61aa01a8c783f7baea31428fa754d0c79a81ec69a03505d864bb6a085cd3aea3002ecb0ec00da81078a62ed3efbb9a870d18e3ca0e3b87c995098bf34d2232022ce110478f27aed8d3ec4525a1c6f56560a815c042d2514041630e4cc22f548ce85af80eec2d78dd12f51c528edc555a2a030551e922dc034dc5ac38be4a43bf478e5e58805405c127329f7fe0f1809e43b1294526bd644d0587962c97579880ab65137059530d45075d6559037907d54ac1088bd480597295b4a5551500d14690c6b019f9e65ded107e6315636448375506db0aee0dae65370045b4654d77e7d480895dc7bda2923356555cb507f96e3d49dc469238992f158aa9647164d325712f1d9693b266a1ad5484d38af1eb2f46fd5192e94466383592194e2b29454e5e0eeacfba6bba70fcaa8102f383479efc6a48fd81a1d9307ed561fc23df3dff8d90fa034377af855f47714b6f24fc422568ea58a1209d4ac662b3333e827da30bd5156912d59e29381cc8fd42e88210201aea2741aae0987be543cffe2e0ad084085f148242d402b4a86b67615850a55c5cc2a387818ced418c08973e22b9ee192ee470e4c211ebe95cede61eb7f1442bce0511c230d702c1c08567564d99ba02273d0faa0db0e313de7238c4af34184804b4b265579122e8212883ff7b90803739c0c5dcc70716320744f03494a0cf85d9529e91f6fd673ef6fd67dff3fd679efafe332fb095207ce25d23ce18a05ec97a1508451476cc261efcae45458113cf9a4afa0ecdaee7115a9e67d0b2a69b82a06627879af17821132f44d957171bf4f0e0660ff2e6350c6e4eb8e2c6a0a6b32ed05732a245c97c78ffb9570fab8b827c386ce82fa2fc16effbdf5bcc90df0286fe87204acf8ba264e072b72bb6c205a7c77dd95be949a55d0abf84147e69ed1812507424992f669251e01ddb381d8b3929e69371aceb3317af408d3db2ffdcc389da6f09a428b2a1abc2545b6f6a6c3117aff4a65243e9742ea1f503e97aeebf0e96d89fedd5e565552f1dd8119784a0997fffd9bdcbcd969f1a0224446266aff5523d78be4324e38ef567f77933dd9c8f1db1a1543abb4fada084c151cb7ff9db18764b657763da049f1a1f1a19cdde40134e23a4595e5203cccfee93cf806ce2e5595e83d693dd8d790f2ce8bf0864a69bdc9d4bc3fd25bcfbab6c4b881b3c5ce949a672bb2adb86732345bc8b2d5ce84663b9cc58d70f715dc95c16171e1fcde570e42828df6f2de20590014bc880fb8ba5e353a086ce9666660a8bd2a0348f3ef8602ac1f55be7d167aab5a7073430f88cfe27a69b8112426a92425e30d5a148b3e01f077c6bb4419407a21b4e249890f5b2d6acc3fc3ff9745fef9cbfa66534b71a3a68c78368a528a037b2994cf3c520b217695f867b81636445a3c0af0ad06de92dd7dc2c9c2dabb07e83cd3cc962f233262a871ffc23f27c93efb94291fe95a8987e5fef3c6513b08c049532605c0b9307f0078bae86e807f28530bea1a8677938dc0dcc0782f53c2a4ef6a36b1e1798757d10e49259cfae9dcce9a6b170bbe187db83466d15d8daa05bb699c7d04d0558d326f67222d6b37e1b9e360f74759300fcd0c894de745403e8a162fad7439f408f7b85d99855fa88dc7bbaeac66bd81ec2c554f4dd6b946a8097919d35e3ffc8bef5a6022ac821e1943fec7ee25ac1cc383e615a96a680f97508afefb2870c169963f3f960203992026ac70ab77bd151cf00fb2708d83f89026ccf499f9e4c660a994d0bfa8f5dbd3986effbe1bc5a7ae5da4228900f435f0ce3f67a53d969f713f1b43b76056cae80cd15b0b974b041b9da30d4e447c627e2139725d4a837ed9c08e1070c7d3e0a6a3a4d8d809a69849a9b8b736f5fcc97667cac399ebf337fbcd0e66f7bf3d6a279d60170706124843c24e59e0bc89d22b0039988a8e801dce828ba031ec634dd009c1fe75a0f73365b5ac5dcc74b0396a661a898e32d836d55b6583674d8631e995dc95302a3522b05af3cf7fb97654bd1cc33b25da6fc3c3f8d1380c70380303270c85134d5c105d21da10bd1ac9b8e6a7bce73040e3f5991d0260c66a108c309c15a878b3baa660c706403ccc235db6256a75c661051b3cc66951c952ca395273e5e20f8f0504a087ec89b7fb0330ab19c6c36f51000a22ec30b3f1314d065a95147203a013b8d819d49864b2545d7d0f9eb2005a76b405945bb08e089c7d3a9546af38067939cfb8826ffb25a7f47084d60e8afa280a7d3d408e09111780e4ca18e3333731740ce4261213f5b604909e9a093ec9b1427a45c84869b8b70a85c5357569a87855c033faec7bc4fb0eb0ae63689ae2a2fe306a72e1916008a4159468f79ae70ee68120ee335a28a626c3018068401fa69f419e1fbbce75b33b58e714111165a1e2e7099ad127a60540b0e3e21415cc0063119db2d5c71c1cd57b0dcc0d93159b358e08c52c00231c6a0fa418a238b6201aa55519e6af8658c34b8c0b626de4cf3e09f9b761ed0484e0a8a2926bdb79ad61955013209d94f0066980c3f58e259ec26735981be8a25012ef804a013700121400f64be77ca598ac84a930ea97643c5042f58a0c8429812a7a2c671422bafe8a114b145b50eeba2af3bb2429952fe4d614ce420e56f349a94f7e2a741a7b89bb07bb00b0003ffae190d040919498d1447231d83171b86b8da4fbc18732e1e33d0b5d7f340fa8f0420f8001bfaf5282f60a7a9841948080134de85a071c3d4fcdcd2f1492f83291dc8607aa41d2bda3082fcd95e215650fab9d407b3197968b9cadcd66e9ee041e6b50e800a883e07091b4bbc3c20f0d042849d0f13aed08bc5368ffa6600c5a1d9a562fe30970f562a110089800234ef52c12b32708578026efbc8aa4853b642cfdf6f7ba9047dbde3ac5ac2a98130f13b05a6e72a10e9510b75734585e314241533319f058b4551dd407a480e0f4a15abe5638107348b141e75255a4888e4d9a8a093ba499c039e8062f58b016a8add010c26c5588070f500483010f0b21b6d37bd3168b8f180a72be63be22389746e27fc3b3c9246519f245187bffdcd5caa9fd218136e16636f05a338cc4959d99e86410281eea92e4f7100de2f0c8f8e8e245ea3fcabb5616063498c3fe9fbdc6f87641b86b645c140a7a90c06260230f00e84815b8e9566f333f9bbf2d2c4fc5d0b8bf919697e6e625a5ac8cf2c86bc24dfe916451848b122d9682852e8ec18e690ca2de45519d4783bac1a1c0c9ff99e92812907166a8abe724be94c9aae78417fba508ba785f8eac2b2aecae51a570fdaf4070285b2d5c24093bd11c7cbacbb044f5edd649fe00225aae76998b01c5b6bd607000faa868a2f23ac0b740860f88f671531a9ce07b5eb79b7366801e9f9ca879e7b0fcf73f6c03500030e45f59126a074630634271320122f12f2f21a5dbcf00bd25a0a4b04c223ff391fd234ba5749d5d5329a772d4715351f541fd05510d04b3e11a9e108194a42195ab4c9104409cf68e0b552788b580767e02b562e65abb26db283809589919f02109a0ca6550cf8afca48e28380c975d338ccd28810cd2d34632d1b9392ca561333f26dca4457790c6c7b9c9065673c3e3ac4b0e55d842def62d8b22b03d092ee9c1fbd6378087ee31a6d17b74a464746c7c7e3bf98f4e835a38c8816ffe1d3837786428730f49751c0d2692a0396770680e51402cb410f58085026e6095c18ae84fc215790e50ab2fc9223cb08466b2abdc3c343e93802cb590296b30c5836587bb1230973005b76736c491493b1fcf865882dcdafe74e85000386fe6b14b6a46f2bbd2b341586be2960cb6a005bee264f6b105b08544ecc9d9cc4dcc62b3acb1564f9d541163a7ab9ca328cc8f20821cb2317862ca0b5a40059fa39b28ca7d3c964bb2ff5178f2cfbb50525041730f4d751c8d2696a94d6f2ce08ad25802c57b4962bd8f2ab852d70f4ee242de5e23496b1eefbbb447d253e9c1f9f4c6f1aaa6c2832bc215439f2435b0b41050cfd200a553a4d8dd257eea29e39c7e68e17ee92e6f327db82325d5b51baa9e0c9925761979a464543695015cf135a63f915e407754580369c3023146f518dfb5a7572a787222f8b35adbc22f4c53ac8bf82a59fabaaea8840c2a2ba75ed6c672ca99986daea0424d145541c5e82c117267814f22c3b925cc5dba2ae3b2af99c396270c075e3a7acd45a3affc13feeebbda309b7c80a5001080d5efa45ad5d3c876a38b0e96208dd7138bc8c0e5b20d404465661edcf3c87fe4bd3a951db20cbc450e8845907a912a22f585a82fd6854c52f1bf7c0261cd6717be344147411bad4617397b1175add8d1dbb31a7932e88b2b8d3128f2b55757315378cd56789755c38daf0823d6ba14fdccded66587948ad3760cb6c0718a65c3b2c34a4694715af8ccb51e50137871e43e9d632867a0891bc722eef0c43a6c32de2f19b945f34dbfd65429b2f47c66f189e1ccf2f2613a95431b6e95acad55443c2c9b7c097796989dd881d3f4e3e520c61070cbd1005339da63298f9720066de8e6b7e13839905d06066a471aa9388a7033acb3f92ce026c8da71a2f7b60d557876c879aefd9f6616959a588e01f3e1d800eea9275908abc803de0bca718274582e084040e439e2f63133b89badab900e5a29a7776778cf7b6010fe10c30374617d6859b133c5dcf031cbf4fc57ac0e335f972e1c687471ef9ed800a11c77e3b1404a183704ae361184b2da386d40a6b278516063b49ec79968b27f27ea8576655633097c59283b0827040d8b0a6e2b256aadb71af5e15350b37f41c6ad61581c325031b0378ddb478019d17d0db18fec08b000245031086d3a9c699159e8a884310246e81abd61c5da7374e2fc797f8706c24d18e2f979c51020033d6fdefbb2e2d3efcdd4f0f24430801437f1a05269da6b6b7c61920f8635072b2343349c55622883cd85d388be179151b375089a5d514ea2c496edc22708c20a25a43923be055832a1af0bb037bcccaae40f92430825db5597927c9bb3d84c863b32f53ab0cb3ded0018c51c47c3c1960158d5e611182995888e9e941035c396239727ed019fbd0a85e1056613550fca4627910a0292b547155f4fa60603d282cb44e555f983fe91658b33a31b6e832b7980c53ac1d354255f06e75d4321694d3edb1e95c2d19924ef2cacc2acb16247db1e1a96003400f2aa0826fe02ff93ae400db8788c2d4404daa57898a564fd9a13b9df03a8394bdf302e782d987c6addb4440c76b38fe3689a5b07e2d5c5bc7575e7f36c04bba35a0b85703dba62210be5165989b530d668aed959d3e1f511b1655b904225d48c4d3a9cd2f3bf524faf5aee6942b72265e89c547d3727c38313272395498aebba68b6bb0f1effee18bbf16aa3085a17f12d560e32bef1ea9872a4c61e8e5b5cae2c611f1f69526674a92d0d0d885bbaebf250d27d498584c76a98b2e8770be9b500e80a5e003bcfdb0a6e89a3ba7a85a75ca1241df88dbe19195956b94eae44a2a9b3c8196cd80c48becddeea8e1a2714fc712f3289810121ec8ae1c6a986182c0c175f0f850dcd3c1afea461d1cfe76ac2cc9c45299c2e69f919bd04d72e1c56f7f32944a0943d9a86e929da632751bc820704c96cec8dbf3535385f9bb0699837010b8c63b23bfd0457603612a1e919c3d5665ea11f625d2e2402584dd6065affe7ee81aa63ab37d9ab3aab201f879bb5cad62eded09eaebc5ce9f60630664c826772f86322cd72e03f68b93a9587acda2646ac6c4f91d4f5d4075fc947b00e90c213d9ed544cb94065c1b683b028255c4432e9fbe10c8f7927e4bccfc246dff4969ed1a0fd0249ff7e42cfae40838ff2689e401bb7f88f7be63b5ce43be34f81985379234dc18290d9edf3c96c90f6736b1f8e182a4614ddbb3e7e1fde7ee7aec73b6c0e1bbd8d0ff0a0bc37a539930dc1810862a15e84f1fcb1f9f5cc8cf971696a6f21887930410dde253d4ebd7d21d238ac62229eab5abcd4c8c8c64465fdf48c4faf0f2350088ef2c7cfcdb0299fe331b7a7798a2eb4d65148d05283a8b1495a6e726e7fc5a9263f9f9e97c5b10e2efbaa74dc5e44522878e81892e1f460d5196dcd210b2ddbcd62001e1a6c3e3fc038ffbbda0b9a399972f30c7e3ba45245e8be74babf8e0551e98de1ba82a4b5c4c9d8a9ba5195da682756a64d41e94a69a4ec0b6a613d656bd26da6841b700bbc468867b4087ab3b521b2b4dd1a97f7674550aa77c64cbefb41f9a612dbf0fb6e5987a76bc106bf0aa52a282309752a93643bb8de0af068ae236522122f861db0a43dc2290a80a918ba9482bc426c7272fcb8ab46f2dfc951ed23b60e86fa30a433a4d8d280c394e1032535a5c9c29f820b290c7e290608ec47fe99ed11c47578562340f3cb84ee9e307c70cb1ce155404383b6d07bbb99215ae6a16ffb57b4cec77d25a17422eb1682c50b8b009e0d1b9c8ad53a5462124091e20888e35b1aa75fd1ab6cef56b35fa7ea8c88cc3c47121115f88e652a119ac5f5354de216f9d58eda517b4b64b7da71828cd76e39fac98e68231020fd5f5358d1dbeee96181f696f8cff0bd63450f4ff7e5c16fb953cc686da5a9b50f958f6ab1f084d85a137ada9692c9321339b5f989b9b9726f33361054350dc929ee2d6207236ba37d285c7ef135c1c8f15363f587389e47d0908f4c1ccb117059afd2736747b98bceb4d65e46d04c85b66e42d4c969666e7f377b6e96f9cbc3dc36ef79dee0789b60f46b2ea764ecbc944726462f3bd589b40cb9b0fbffa972102c1d09d51b4ec3495d1f2c1002d15f2d2cccecd1d9f22468d36301243231e9f3e4db47cba332df3c3a9cce8656960fcf58b4f7c246435c0d06d510646a7a98c964f0768a9d2d3947c5a4673e5f67892b3e5a788949fba30911f4f17f3a94d7bb6c06692f6efef98fc72885e30548a226da7a98cb49f0a90b6c2447e6ef1d86c7e71ba44b48de054fa5a146dd7506263c5c444bc5d89bd0c68f963e75f7c2d442018ba238a969da646d132ce68b9b4b0989f9f8c6ab4fe99ae50286a1963b3e59a8c858aaad5debf34d0897db6893aab829dd80724e6c2a6d432aaa40725d8cb2f136c6637ecc47c5cac95a6eda69bb89dcf6dcdc6c8b8502e3924f95123a1aa31d4349df755f79aa71b811eec513d46d97310ca2d2f9e45be3c722c4646dafc089b9f49277492a7e095e6b0676c617fcf0686f02a5e3341b113baa5eaa054535bd0b03520508b67b2918928f8a785d67e3e5c7f8fe4e07b1de4003820511c4f153c39780d8af55eef68493c1d4f8c8ea69323c9e57466b8327a394470d65dd3c545707efecc47ef0e457060e81b51119cffb8ef2b83a1080e0c3d2b20c5f70248314f7d104ecccf2d082eb3f1fc7c7e6aa9cd67f6836e307d6c33cade751b6e0c526c987d1ef08f3147b2d052dc4d09552ea0cb137f68db09762dd71af38caf7ad32e6336abd78ddc6ff541d7d5eef3312ad4ed23b1699eb88aa5dedb4410ab35d90717d9d9a9a30f2eb5de63f2d63682db9ab7afd9c4257d01a6bab79aa0a97e29a6ef25b45399bf640b1814380f5c5f25707db5b392319a2e8c4fb4b789bb0cdaa3ff46fec9ee905d0b43f745b547ef349541c7ab01e8489292319fbf7d7669322a00dcfdadb092a1ab55190edd504f7137144be76950e99897ef91eb00d8e895c1a64d187d05b040c9e0cf9262cdfd918bbc87a4f85a0c29164ddd8d6c6955039f9984fc35c43a5cf3b41a9ae7656db8d9196b3e1506d35aaaec402725c3f5b8d45940b9c3e35ed8697e96d290cfa8424672f0492f4d43030ce18d8903e9266d9a458042a87761be89ed291c1e990778068a824b623e3e20a8d7f47d199fdd8924a718257bdab017821c105aaf57004078fe08daec518e8da0905ccb85a4984fa6475fb3aabbd7fba84fa546d48a929113eab05c2967629783fab1ee9a2230a4d831028adac71d9f586a09b860b2a1ae28eda3bb70ab38d561435d6bba794ceaab3c2faf72ccd869ababf7aedeeb32583f63af7e60aefe28d6ea9eef42e6da692b8978fcf56cabdc99688547f69ffb9fc5e5318112b7b3a1cf8689b6de54ecaa0cf79e8025f186ca7ba8d7f01abd9473c3f0162916d567b81fa4a69f75198ec57339787d54db9d7babd7c5786fa88bf158d7dfb4fd347e399389fcf9eeb76e651718ebce6c859fc7f747b5ee992ea18f71823ae82ce48bc599b99385f928d3f4c94ecf00039da1c2a280ee53c02e77eb93d74305ec4f3864486f0e1d556e12c5259ba1eef325503d771f0de6977670c352f54e66380684544250c3a8138e500126da9fdcfc4c0b5eedf1ad08fef0b753cba8890418445e90e097c0fc4cc4124a3c114ba9e9e1914c65f4b2c0ff75d77471e6e793275e5642e6270cb5d58ee2f85deaef8c85cc4f18faac7000009f0807401df1a047e8abaff064f3ae9722daea77f69f52eecb1ec55656154b5db55655ce6e3bc74d0cd472547be92239aeeb7b9bd876ffc53ffb7fe2c3880a6ca8edb945eb4d6511ec97449aa6e811ad0b73c7f3d26c7e61693e52377f3984b20bf81cb35919f3c1992e49d67dc36c9059e84100e9bad1ba3743344f5d05b51763e36ed2b4d85b15314e5a0fe07c755cc8571772e944859ce57462333e5e3101e866d2c37a3041b05d0f87158b4d52d98181a6e2d03a4fe6f0f57d1cb2d9438a28f19e9253c5a46ccd6b28e63ff816946ad6b96b48f2b47dcf11e2a77a73ed1d7ec57d608a773e955b5e0a2b7f6264bd826d0df90340fcf6b7c293402e5453cf149323c3af9939fbba3fb8273e9a2eabe5d4a8aac6ca99ca6591eabdee9a2e4a533ff7c4cbbf17d2d461a83f0aa87fe7e19d0f84347518dabea6a69e5e0354d25740e5571554f0a965a80962200203f0a406c2df8db6fcda9e84cfc53ec485f470ea35ebf8f5ba17738c24944c5a2d8fcaa36a6c38ae5c0ea8b3ee9a2ebcd522c24eff67bef550087660685f14ec7ce0dd3ffde721d881a1beb51e61769a998b4bc74573311930173fbe8186ab4b5e59d7465a2dcfb090467bc17fb0fdea46fbad467658a5aa5df7b2143459bfd9aa173b08775b159f37da9e6abb764766afdbaa7b77e18c58816a68c9b2c887f7c85656f0b66ebb5596e97a50e22103164af0fba69e887a7aa3d77e79d2546de3fc034fc0e7aa4a197b675ae17ce1c8d27eafe3ca9d6cbd5241a00cd5f5fa618a8d3462e529bbac1b2bb60fe10fd25ea3332b8f5f2062ba4fb9a06c64d780de191f8aa5d52475201a8a25e01520e84708413fb255e81492181d6eefc83ad6fdbead6e9f10782118d9c942ba98f0aa285eb7becc1b6bc8bafce61bde1beab20a437ba2ea6e3b4d65cac9870356e4bba36022d897f9df5c400ff72b7071052e2e3bb8186170011b3cc2d0e20b84165fd8005a4c7545b66f8e174636192d36b17df37347f63d1c820018ba2e0a2d3a4d6568f1f9005a0c235aec5884edf3bc4eaeaba897429cebc77dbb531477e84944c61c2ef5c19897127a78cbefef3ff7dbfa8d8f0af438cc866e0c93ee66187ffebf0f9d13a6deca868ead19f21d41d2ed5da4a76931c5d223217f20e6fa419b6f6e45e2ed4e246d85fe676f0a11372f7cf32c50a1ffffbefd3d0261fe940df58669a802afed7ee20dd3c2d47bd8d0577c1af68b14cc5032eec96385fce2209c564bc1ead7efb2c7f1b2883820393e8acc111f8d8158fb825b033b4ead1ba851071adb5e2b02300879f9eb49cc93908af4b480356a5f6d072e3258b5cca6c102e17e8c42e81a170e85f3a49d01d1160fd5acbab5b12c7ee259de3ce6ceeed17b582e2e8727c309b107b285f1f95bb6d004c1b543dd825838017839ec97587f077ef76dbd020305b115b7102c5011fbf8b3ecb1d7bafbfc28452c2b67c6f4416e2b53d03e10188789552f95813de0984e01a43fcfdcdb3eca9f3fd8fd3342f09f45064e7672ab7862bc588cc805be0c2a63ffdb7b9c7b42e5ae30743eaa32f6c7c3d79d15a6f6b1a12d02cefc2c00d13582e8fbce9ebd8f8bc68eb3f7b96f3680306fede20fdc9d981c1e496f4ec2ffe601ccc147f69ffbf95b166e1628721b1b7a2a4c3c9cfa79f38943a1a930f4afd600181d49b713713599688faa6cec7cdb82e4db6e2b91c8bce921f5a24fb2bd734dcca25d3b6af2f317bf7363281402438f46454d3a4da58715f76432b984b6cb0bacefea1c58aff4c4132ee146d67a14716e14fecb8c7567aec270d10f31d69e1ecaa430180e4347b5ae9fbab170bc5e1f5d2f2984db7f140cb777bd9cdb55d99e5013ee05035a5dd7dfc0c5e04fa6b23d9e19c5cbbd0c97eb1d1e194a26f07a45bcde2d42e85d23c6b01585efab58b0908e71509abe0af902feaec517bdf813971767dc0a7b7bdf897ffbb4b0dd3136744b9833d69b4a9cb11dfbe925b41e8f357ad6c9b9e8fecdab5cda45ec94c715775f45f89badf424d2b84577e3166902476cc3cbf42653024bbc1ce4c1ed29383d8029e2b1642453fc0899e24778316053ba18fc97a37747b5ee379e12f8e11e6ab089ba1caa1127e63554e7a4b807b81e9f603a648c07fb75620f7d6df6e8b9cc500337fc1fbf7ed34ba10d87a1b928dee8349592714823d67678acb163bda4199462a25827218edeaf5b4e09ccb19d9823e1e305b05132c486bf7b1566e8801214efc08898dd9a742f8626215ceebdc889ff945d2cbbc7311d593f4dcf40d7d2ff1f3d347fb5	2026-05-14 02:00:38.709845	4552331538137680312	10997
57	\\x70726f64756374696f6e3a6d6f62696c655f6170692f70726f647563742f64616133316138362f3738	\\x001181c33d660f4b81da41ffffffff789ced99cb6f244719c0ed0879edb1c7fbc8be4816b69810b309e3718fedf1dadd4278fc18efecc6bb8b67ac55b0a2a1a6bbbabbe2eeaed9ae6e7b87e5b00a02452809880d8708a4484808c405850b0f41b2176e5c38a0481c2de5020722c41fc0f7554fcf8c679d04211e2be09078faabd757dfe35755df7e6cf4aea61fe316afe96301f55935776ef5c62db2b25dafaf6f919d92a66d6cbe30a28facd7f513169366c85b11174135f7d85f1f3bf8de8fc826b518b143e193f22c810e9c98629ff8dcdbcd66b0bd1e528be308ea796de2d2c09a36dd380c98452ead700fe4c467912bac6792fe37e390e589e9329f9bd49bb643c6c814b169e8e36fe926bdb6b8e942af9051bf4d2276278251649f472e0928fca61ea1a012cd66b299f7df7ce52d725d90168c66e11e8df81e93e4e0def751482d542e151435ede9748264e8b77f4caeb136596101b3792451582ca8d5090fc81546bdc86d930a8d2479ffcd1fbe9ccdd4e2564b84f0092342a74d60bf241071c8a5ebb320ca663684b0882d4222f6182ce31119852c702217e79e2d901521240caffa7e1cf0a84d50876c66550411e581044344d3527871d363648f47d447e1a5729eace5c97a9e5c7ba64f85a6b0da07f7de905d9b58cc668164b8d25c81743559e30e93e82258ec9577b299c32edb0dc47e402241b8df0a4169e2c41171d5ceb399752adbd866a929c8becb02f07f20631ffc0b16f28505bbc4b970d1f902e92a57db85e629b2e141b48047b399eb1d25dd8e516d34aacbbc566a3f226148e296577ffde79f7f935c81a1b0f636eee816fade151109b9c9086c2a1411075b80d7a945606b969094cc4060d116c596b26529c56145b441882e8da88c602e98905049286952f885ad3e85a51de2b88c8d18c7ea7aa685cbd8a30b6c567fdce2d2147110359450d34f49e679d03df95e1ed54fd81c4cd9fd3cdf1bc0421382823a8c0fe9a7bae2a8dd82697af3ee512f468108b9d39b090492eec13ab2417dec678f687a4646c2dce563faa8dc8dabb9c98dad72796e7ead58516a8f61485573c7ae39ea737c9f71c78d34fdb8c52138257849567343aaed24f8da8acd44996a6e622314260bdbaa6da24943131cabe95957068de4e7186ca33b1af7d2f268bb2142f0bfa65fe0b221e366971e0d16508860aba23f012dc234a954e1d6e8ac5ad14f38324a7bd5f5c7f1ab672d7ba4a4674d1a314784edbbc78c217eda18a9e6ce6c842a47a6c826f73c16c9c457dc87219a3eaefeca9d217d1c233270ee1ed3272826a1c396c7f48cb235f8e10468c483863224ec04be5247a0be27e11b42366d3ea9fec217042fec7ef23908c91a8ad4d2c7115030ac41a36d9d944d244d270174bd0e36c7a8fda208d8ce6835d6c750927ded5b171ffcee37bfd547f4b12f438b56cd9d2c4b4e67ae096f974614e7adc6463e7b3fe9f7d311631a1c18b7ac7421e3b3381bf4e8ce043d96cf3f3ce8824b65c38fbd88b73cd6b81d53d87ec499acf4dc9786ec392007859e108a21877e0d6e81f33b1f68d23321f394021d07ca9dccdd69f0cb1cfae5dc56f9eae6f65a956c5557d7c94ef1dac60bb80d63140e917787d7ef8063390b206d2397118f39d46c136193a88721e2249e5584dfa480094e6ab034f4dfa22f523fb63842991ddc7b9d0233428e5142503f16a504c33c068427990e1808a919b15001da84ad29f648ee04dc868307b42900d6439f48808f093053fd68c8ec383dc7203291209d7385a9c953d272881607d468e761535c26540a999f301ccf34756482163e4c483037225c54aa75d81df82521586072a17e064e01c9a72887eb4022df8e19a0d613613e3d00f36ab0c55ad009ec677b740f5b0f590894b03d060e22adb8a35f6ae664381c2816aac4548e80419b21fc45fa35a9b9ab5c040a2977c11a340601c48d9907f60b8f49e123318555501e1eb3e1b89c63b3464633c6979f3226e0bf2c1f322635e3b8669cd08c93cb63c6297ec6783c6155a53c575a5c51434f7739659cd18cb31db218e70eb3c838af191fd78c27d2e62735e342c5f844c5f864ddb8b87cdc201f4107e353d5dcf0cb6e14b5a43e33039e2c989e005b05346c174ce1cf5876d329dd6e17b519858f99b8e5096acd980d1b26c9db0d3080c8bb8d054dcbdf4e3ef61b8b9a36b3579c495321fd311d31bf353d3f7f99d9d6129d650bd43697b4cf37e8e756caab57e76a6bcf298d723b238f9c4e4f81193f0dae7a1a7c3755373e53312e558c67aab96c35e8e1ce78b6c71efe8d8b0fbef0d676bb8f3d22110da3c828f4ba06207f6cfdd9feae51224abace540c0dc2a6a819b33b430a2af3e8ce276b37ae97c966b9b6bd752458de1b3ecc891ade3437a984a84f1281e309df12add8a32161700eb42dda4e12f56870787858f6720d7236824b98ba6726a9037348c81a0fd20a2e3a1d6e583c84740364a884c77bac1c604927c799958765203f938b5e3f4d80cd9e42b302a080fb17bbd31212efbc00a02320021ac741c0705a081acc791e30bc7f2a8adc64a10d3aa98d5994830aa61078c1e987158a24d0cf8e94bab617db36d0a273130245b9c53a7727da351810018e0e1742967451d5a41e2a6525b72b35598a1e9845d145aa3b2387e6c00471b2dd76625408785823c28db6c1a43d4ff9b0bcec6006e2e3ef24cc5265eef2c2d2bf8230cbcffefb616215174b2633e71719d3cc25fbf2a300938fd4e91f82c98337defbfa004c403479144cbefadaf8bd01988068f4036052fa009894fe0f93ff55988c1a193b532a5c867bcbf8720d905233b2b17e7c853b6bcc842cf1269674ad50624563b29a3bde7b96a8e11dead8a373d07e8a6752f014d74b0bf3c5ff16f0d0cbb3d65289998b7491690b45eb5100cf47ea34089eba71a98ee039fc6a1b24cfe4cfde7d65803c203a7d1479bef3a5bf7c6d803c20caf6c833da4f9e2524cfe95b57d6cbf5e9ca7337b6b7a6e102d345ce1f86b112d679f814c815780bcaa8bf9484c59ab755e5249b59c1c0272e5ebe114f0e5cc0a1bbc414ba113a34e026b9e5c28d9e543c0c7b458fc3443bb8779fc05b3660d34e086fdde4bdd341463f561e7ef1c451983e1f7af4eabe0b92442df495097bac4a9f56c91e318355b50ad56975a862ba02f9816050f4c0aa4e82bcb44ca432374964e04fbbd029f9bd9314f3d2dd4f1dae28aad2de77bb753c9b37e1253895ec05d496d8fefa0f48050b8ea0a88f0f86a456d66411be1a13fc4ca574516fb343ef1fe8e8745facb8a35001df46fba76fa3d1454084bab7040099e0a87bcb788a8fd5954a65befc103eec91e23f07201a64ecd0514773fd438fe663af5d7cf0fb97a217fba27e22111d0c260876fde3c2d93b7d5db38968a89720417f82e8aa7870b5bcb1b1bef5fcf4cd1bb7d6d60fe7c8af866bfb8c452ad4d1c6e911b74fdbaa94d9c98e1a3801ab7ba213341c1ce8712c9d25ee4983e42a751c0ca39b62df621f982571909c80d640953a09fc163c9221540e95a2d374ec64418ccff943d58da4002e0f1dd9ea911d716c85c5420c729cdf51c56a38bc60c354553bddfc60b661482709215b4204694abc8d05ef546549be829f6a2ba0ce4042f0500483f9f0ea4f487ad6a71b93687d2c74f79dfe71525f5e5326ef580a6e130e0d0b64d51542b2ce89dd5721984f2b04c3f72011e07f4764c2649a09da52796169f5a14c58befd1f4f84e7efff520e240288fe7454227c5857950860842413f48990ed71b68f55b6531683b8855d3578608bbba3fa79ba0746c72269c313a6aab34b3c7827cb9e47aa81c555bd503f87e57d5fd5e7d219aab9b373d325d2c460c4f4017426e5d233d2e5ad1696afb146e63059cd5dac60c12a9513dac47f053878e917254dc3217f039e208414	2026-05-14 01:48:21.718089	304574412779624607	2980
58	\\x70726f64756374696f6e3a6d6f62696c655f6170692f62616e6e6572732f61323465663937362f616c6c	\\x00110190f8c78d4c81da41ffffffff04085b077b103a076964690a3a0a7469746c6549220954657374063a0645543a106465736372697074696f6e4922077364063b07543a1272656469726563745f6c696e6b49221e68747470733a2f2f7765622e77686174736170702e636f6d2f063b07543a15646973706c61795f6c6f636174696f6e49220e64617368626f617264063b07463a12646973706c61795f6f7264657269063a0e696d6167655f75726c4922018668747470733a2f2f7265732e636c6f7564696e6172792e636f6d2f6466626735717931302f696d6167652f75706c6f61642f635f66696c6c2c665f6175746f2c685f3430302c715f6175746f2c775f3830302f76312f62616e6e6572732f62616e6e65722d74656d702d326465316239366262636166373135633f5f613d4241434a3353444c063b07543a17646973706c61795f73746172745f6461746549220f323032362d30352d3130063b07543a15646973706c61795f656e645f6461746549220f323032362d30362d3130063b07543a0e69735f616374697665543a0f637265617465645f6174492218323032362d30352d31302031343a30373a3039063b07547b103b00690b3b06492208736473063b07543b084922277b7b626173655f75726c7d7d2f6170692f76312f6d6f62696c652f62616e6e657273063b07543b0949222668747470733a2f2f6d6172616c6973616e7468652e636f6d2f637573746f6d6572063b07543b0a400a3b0b69073b0c4922018668747470733a2f2f7265732e636c6f7564696e6172792e636f6d2f6466626735717931302f696d6167652f75706c6f61642f635f66696c6c2c665f6175746f2c685f3430302c715f6175746f2c775f3830302f76312f62616e6e6572732f62616e6e65722d74656d702d316366663131306661636334643336363f5f613d4241434a3353444c063b07543b0d49220f323032362d30352d3130063b07543b0e49220f323032362d30362d3130063b07543b0f543b10492218323032362d30352d31302031343a31363a3431063b0754	2026-05-14 01:53:51.168891	-2878576828447152086	947
59	\\x70726f64756374696f6e3a6d6f62696c655f6170692f63617465676f726965732f3566346165386135	\\x00118176a43c624b81da41ffffffff789ce555cb721b45144d5294e34785323654b6b7bc6025eb6529b2a462118a38c885e35072ca0416ae56cf1d4dc34cf7a4bbc78ac8c61fc11236142b3ecb05ffc1e919c98f60d8b162a5d1e8deee73cf3de7e883d5efd6df6d0c1eaa487d3458d322e3d1cee32f84b273fa940e84cde8c0b24b56062bcf4e069b113b6955ee95d1a39dfb7f3ef57424ac48158d85f609d768c634b14a4f696e0aca0b8b57310ed98dc3211495e7e6d64485f48e9c29ace488226559fa744eb13519795b388fb7a991222dbbd9ba3a1d1776d16f859e322947d69850a8347a44a4022a7464ec1313b91ab1764589450b5f00257981836b94a86942baf0b6eca891d011fdc8d6903419b065ca31194d6f0a0ce6e7f595e1c393c1872a13533e2b6c8ab97f4bbccfdda0d1c8cae15d397b1ddd0d2b54ea1a427a75ce67ce1b8ba6c6243513d7b05c8dd9e0f9612cb3837cf2e5913ad64e7dfbfca0f97a3c7a7274f2ca8df4e72da9464f46d9a19bb40f6371fab58abf697eb6bbdbebb73ba215b5e36eabdbe9c5729f9bed6e578a7dee772742f67b1d8ef7e249a76195e47aaea725eced25d767d214daabd5c156a45c9e8af999b1115b75efddc6f09eda1cae8c76b6abadbf5c7484fee1eaff6acbc3b5e6705d6d0d3716b47c1c68f9e43996aa1ddc70a4d294af8979d07ef07766302bbddf801bf129038c8a3647de4c819f2d4961392e52b0b2a4c97991a7fc4f63c7c644248b14a3721dd60493981b6aa3b0773a1756b1571c6ea88667ed77f15342d9024caa7e40b198aa1a7d6f66c256ccc4e6ad877641e7395f2f2fd0ef3860079299f2090954cac2dd60ae6c1705a681be64a0f2d1faa3f5f19d4b0f6b761549d38aa4d0bc44062a50c65cd526a80533e48a0928d192abe2426bc6b31315caf008466fc82048127772e0a4640b0c2a9c9e19e7af34121b9bd5e934a996806f41744099b148319cbdc5394e533903378ae764e2182d826689c19a4cc625ac89480346b024e625f79851c10bf3306b2c3062c5cbb5cc76af64b61564f6f8c502da78c6ec59c30d4ba10d2f2f7e7ea517c3e28acb8b5fab645e921c5ebc30f4348af0655c4c85bdbcf885aaab60e0dfffa3b87afd2f7125facd76abd76f757bdd562491575274782fe6de7edcee44b2dddb6bb6b8dd948d738613c404542e430bdcac5d71b31db8593f1e7d35a62bdffd71ffce448ae13233c366e028a5c32ac2f6735b296429162c5178c27d3a72b7b63c532e82ec4a95e761e5c8077e8b8acab89e65a2d59b82172165c05ca9d8ca2a0b7f98c2430ef33bc47b43a1a58c2c673000c99405c2c989986b0b7d8b08f6662be0b95232cf4a4746d6e461b260461732174ebbbcf8e9da2f32e14c214b71d38d97467b882f44c43203cb30c0cd4b2b4cc1920631b04318bdccf16516016dd0019c5d996f9156b78c776b11741a387f692ba11e078e224ea12e7b2b226aef0773f96f105055f15338be11c89b410d7f01ebed0620	2026-05-14 01:53:52.989886	2690612247643338611	1265
65	\\x70726f64756374696f6e3a6d6f62696c655f6170692f70726f64756374732f38383863393866662f3635663232323764373636373966313561633831393965646565346235623033	\\x0011814f0b47f54b81da41ffffffff789ced7d0b741cd7791e012a040912202951b224cbe19896185202c07d02d85d3ac602d8055700080a0fd13265d3839dd9dd1166675633b304574a53d54923d79195e8e1f4c8928e1b5b8a6ae7f8287e3476fd9069f9b8aadb34ad53d7af931edb4ce4baeef189e2f65427a73976ffffbf7367eecc0e162009c93c368f2d70f7eedd9d3bfffdffeffeefb96afbfd3dd9ab1b96a934cb8e7d5a911df954fafec16c8fa6686fcbee30e4ba5a3a70c3787e616936bf78ac34385f9a2848a7e2d353efdc96dd5658ccee5154bb6c690d47338dd281ae8f9f7fe0a913aa5551cb8eb42cebb2515625b32239b2eda8926c28524d9575a726bdf2a1875e38ffd4bfeeeb5dd08caaae4a0d53d7ec9aaac097ecbaec6892a5c137cf3ff09864988ee498a6044b2cabb6ad2a03de9025af0ef5f5f6f5ce98467540922d13bf5996aa96ac19b6e4d464472a9be68a54d19b954a4b52cfa8564b72b4ba0a977fff17ffeeb37fb02db77d31dbdbc06b557a1343a36a227b8da2d965b36938a7693896bdda56751d16c9de8ff566f7543443d6bdb7d7fb5f50adb26a387255d5b664aff6869d56037ec6ffdd33b2dec401d3d2aafe2fc1802d9f81ebd8a7e53aceab6c8b657b6dc72caf68bdd9edf64ab374a07f6a3e9f4f2727e2695af88ea6a139a5033dd3557abb7355d5aa35f85e3cbb5b819b346cd812bb74600b7dbad7dd625a4ee9c0ae2924a7d5a2cf762dcb56d954600d7d35db38cd5eee801bf1be8d77d3d0e5d669d352542b96bd49b34fdbcd656fe74fab86bcacab4a317b237c6296cb325e9cee8dae5acceea9da0e9fb598bd06dff9f4aaec480d6532d9beb2eca855d36adddf93dba6edcbf5940e5c3bc536f3a034abe9baead86ccbb43a7c2b96dd49ffdaa7b664775ab0f546157879970cdb0ca3633bb3bd4470d88c3db028cd384dd4849b81777c3770c97be1bd6eaef28ff7d2bff04e769a4080fe1973555ac021baf4eeb2a5c22a95d3b2b39495f265473ba32e341b0dd372b2d94520fb49cda9bdc334d453db4bcdec0e1ce97be80ff79f7becf7979fda96dd711f7c122b1dd89bb735f9c8b4a9af80bce1ef969ab9c1be47d9bc9bb7e58662d9ddcd86c22f941bc05f8319de2fc18cb137b67fe9a69a6c9fae3775476be8eae97b9b32dcbea3a976d1df41ceb76f50d48a0c33811f2d0de69dd614d87ff70d90f4fe41d88331dc83ebc667f213d31249be2bfab0e2dc8ed2816e63ebb82e975798b46ab671fe81271ce99ea6ed488a56a9a8166cafa4192085ba699d7fe071cd8109b604342050a8a952dd84b946d3b134983aa800d3aa5c7e5b66532acb06cc841f02897de44194f5573ef4e8c7a469b5258dab865ad11c1b07e343d2bc56aee1a5f270c7e6594dc19b900ec1bb9a596ec906fce0e1bede29d82c9baeabc8d68ad4685a40a623cb740bb4c6bede63aadeb0a50a4a12fc5c4597eb082aa6011c68b36d86f52387e9ba8b65b880c490b4c03f3da6ca96837f11e7ce3ffd0ce04c5fefacdc82e97a43b254900715604e91ca35535701172d53970ecd4ccec0024b7510185ce3b26e9a3043b3ca4d9dae8f57490e49c76061789b456d9988f2d097fa7af39a6203bd4110d8c469556d30f2559ab04a1dd011e61eaa22e34a15d39218504875d9003901a0700ee3afa786a429bc28ce98d4e46515b0d4864b7cf47388b0abf01355bd5556eb80b05abd2197115ce15fb821006369b5a601c2231f701ac22ae137e0f6dc9bb19b55d982ef180edc305e303d241d071903524a93aa639ee52494d8c1c0e9a9c3a659702b4699dd1efb754bad03a1e0ca6791572a80fdb4afcba6d2c2df1ef639a264d1ee1d7799cce6bfb06c22ef011759d596a4c3e1a0c3471e051aaa09bc21ad823403055761f3ea66553797358371219d1fd231f8046e7ec986bb9e4719a8c3b603dfe9da0a1043adc2e6594414a0f0021c870a22d9b2b98a979aaea9705f4724054f350bd735ab9d6517344cab0e5421a9c2c52cab7052c04209fd72bd785665d4446e672cb76bec965c1ffcd7af6dc9ed8ee5f6c4727b63b9abc776e6aed17a72fbd891912e4c8c1787e9abd77ac745eebab1fedc1b5c7ccf5d1f3c117237c47237c6726fe41fdf14cbbda998fbf5626eff624eaa6c4be7decc117a6c5fee402cf796535b7237c3d02d70e183b092df58cc1d2ae60e2fe66e0de367eeb62098fdf49aeb9f0981190c0de050eec8c6a7c68ab938502111cb255de4ba1391eb8de377e527f3532569e2586966a604e0158b4dcdfaf0f54237b09a54c403d796a665cb00345e91250441d569a178fd39492fce9a04a942e925a0685aa49ba8460d351c943ebb26c98d06883e0eb06fe08ddb0dd8c301a986620b607206bf7990a92a6c125796709be526b0b0812acc82092fa592a10018930e03671be3bb873ec185466f814819830aac5581d57c583a6ec20f3b5a452b6bc03c6c991e649eacb5a4891ab0bc2a8db76445ae6af0168e54ed6d2e8072519c60b7378ed24110f3f8a739705a2851020980f3cb4d0bae8f5c5dae351d436d011bc33a0c55656214b920404b38cd1569018923cda0e8f9b49e0171006406cc329c01381f2c9513aeaf57245645ae6b400281384957e6f3485d54f13ed9d75be03bc4345038756cb90eeace00288ff00ad60da7cd19b8031701095fef68caba06fbbf68c98ae6902223dde9f3c40b20cbb09c32de22e20ea727c83b1e14873c463a2c42c538c03302852215f19c59a065c0f5691d7dbd138c7c30d030150dde03615b00d136a00642965957ebb2a2029971d360d22a28621c0ee2a8ba3238380a7070340a0e76787090c9c4f2f93638885d241aec480fc5e29b03080f8348bfe3db3f382f48f9e36ce89e3020ac379500e1a8080827230121710510ae00c22f1d206c4fc546733b2b3b93a32343c3294085454085c55c7f33bb7b5cab4eaa65b09bf4ddf1d16c6c2895c9a8f1dceed281ddbe3946bfe26207e81ab1a1e43000482f079091e1787ab8b859003276db46c063715df0f80310ff3ffbb5fbfa43880043bf17068ff5a612782c88e07104c1e30d13731373c79716a5b9d20ca812338bf33e70bcda350b920efbb0008607e8a127518f3c6191c3022408b4dea623cd693a184952d9922b60d8494d1bf85472049e52cfc23b5273419104cb05d445d0b141e784d9a418362cd83b90d8ba463e0914381802f5115461b08524c39559b06c905fd1e142d002f285bc42dc5906951d0d03400b9769cb6c7df600a8d0b03e932db362a9ee376ab255876f4868f13b243d0392ace0aacfd04b4321b51ee4cf205b859c326807d39a0824f8c22a609a1322d2b7ecba69c22c07eebb69012a6a0e5eb82108b52bcd0320a54de72b1fa597f84d916a4893866a0f49254702eddb94881eb624c3ff25b01d6c5814a8f2785bf8938a8c30d1b4e17acb16fc20d2d1035aa0da804b3d7621036804585e67962cd0bb8540a76b1590de96ae0ef123787828cd8fe03a085b3dea08de4e1204dc131f9e2cc4925c827a67c074b2364788ae4146ed854b2c4834eb40e940d77b6b8ed3b0b3478e00a70c95017315d827ab3504ac7544a92c57d3f7b6e2b123e44a39d26ce8a6ac1c299fae00870d544e0361cc81dae9e1586ce05ef666f5f4682c76e44cfc08f719f217838e5a6f0c8e5692e5cc687c59a9646465399679db69f9ade3f989db930b9333b4a2b79cda76d9ade9c25515ed7dfbcfbdffa1eb7e538010830dfd79186d70fc1fae31ef10a6da6ce86b3edad445b45970d1e6a434beb4b85898974ea5836acaff2135c517e97c02ad480da46515a161856912c269050c0fc79e320867b2856072685cd361dc4599c3aee6413258aea1892feb8324ff07e158b5eaf8daaeb15978a2c22c4b95eb2d2eb9aed5eacab8abcc70e5c4832899f0c2d34c3880d0001866b7f01fd8889b87b9575aa0aa39e8a378eebd82c3c035e943d22bd8f6dc7f633b966a543d0f0e6938b654aad7d1b18a27fba31f837317918d7c0cb233689b7a7319b0e48c4668871ea6016972402a0c48d3878525a01b825c5d9c268a5a41df96ab95087e16d76be3ba72825bb66298ab0662bcc6dc4252150e11ee742ac8760b3f638e1f6915f00b51d86ed6617f81427513f401cf7594121c540b80a8b0b153e8d620570bd7f46a2e512b4854f256b9f493ec95b5fd1e04f435d361ee0ab829cb74405f59805d9715096e4d316d593a028c253764fc24af90c74891191ed3f940da585f2ffc2083ed65d966ae8fba8cf82f556baaca959b610eb45dff0c9016fe74b276f2c9d464fc7556563666e97cfdab7f911530e13136f4c9284ba7d354820f2082801fb7227e5c3f595828ad05206feb0653a2a95755e414d45770130c54b441210e6a32802d45947e69bc89cebc014f7d61aa01a8c783f7baea31428fa754d0c79a81ec69a03505d864bb6a085cd3aea3002ecb0ec00da81078a62ed3efbb9a870d18e3ca0e3b87c995098bf34d2232022ce110478f27aed8d3ec4525a1c6f56560a815c042d2514041630e4cc22f548ce85af80eec2d78dd12f51c528edc555a2a030551e922dc034dc5ac38be4a43bf478e5e58805405c127329f7fe0f1809e43b1294526bd644d0587962c97579880ab65137059530d45075d6559037907d54ac1088bd480597295b4a5551500d14690c6b019f9e65ded107e6315636448375506db0aee0dae65370045b4654d77e7d480895dc7bda2923356555cb507f96e3d49dc469238992f158aa9647164d325712f1d9693b266a1ad5484d38af1eb2f46fd5192e94466383592194e2b29454e5e0eeacfba6bba70fcaa8102f383479efc6a48fd81a1d9307ed561fc23df3dff8d90fa034377af855f47714b6f24fc422568ea58a1209d4ac662b3333e827da30bd5156912d59e29381cc8fd42e88210201aea2741aae0987be543cffe2e0ad084085f148242d402b4a86b67615850a55c5cc2a387818ced418c08973e22b9ee192ee470e4c211ebe95cede61eb7f1442bce0511c230d702c1c08567564d99ba02273d0faa0db0e313de7238c4af34184804b4b265579122e8212883ff7b90803739c0c5dcc70716320744f03494a0cf85d9529e91f6fd673ef6fd67dff3fd679efafe332fb095207ce25d23ce18a05ec97a1508451476cc261efcae45458113cf9a4afa0ecdaee7115a9e67d0b2a69b82a06627879af17821132f44d957171bf4f0e0660ff2e6350c6e4eb8e2c6a0a6b32ed05732a245c97c78ffb9570fab8b827c386ce82fa2fc16effbdf5bcc90df0286fe87204acf8ba264e072b72bb6c205a7c77dd95be949a55d0abf84147e69ed1812507424992f669251e01ddb381d8b3929e69371aceb3317af408d3db2ffdcc389da6f09a428b2a1abc2545b6f6a6c3117aff4a65243e9742ea1f503e97aeebf0e96d89fedd5e565552f1dd8119784a0997fffd9bdcbcd969f1a0224446266aff5523d78be4324e38ef567f77933dd9c8f1db1a1543abb4fada084c151cb7ff9db18764b657763da049f1a1f1a19cdde40134e23a4595e5203cccfee93cf806ce2e5595e83d693dd8d790f2ce8bf0864a69bdc9d4bc3fd25bcfbab6c4b881b3c5ce949a672bb2adb86732345bc8b2d5ce84663b9cc58d70f715dc95c16171e1fcde570e42828df6f2de20590014bc880fb8ba5e353a086ce9666660a8bd2a0348f3ef8602ac1f55be7d167aab5a7073430f88cfe27a69b8112426a92425e30d5a148b3e01f077c6bb4419407a21b4e249890f5b2d6acc3fc3ff9745fef9cbfa66534b71a3a68c78368a528a037b2994cf3c520b217695f867b81636445a3c0af0ad06de92dd7dc2c9c2dabb07e83cd3cc962f233262a871ffc23f27c93efb94291fe95a8987e5fef3c6513b08c049532605c0b9307f0078bae86e807f28530bea1a8677938dc0dcc0782f53c2a4ef6a36b1e1798757d10e49259cfae9dcce9a6b170bbe187db83466d15d8daa05bb699c7d04d0558d326f67222d6b37e1b9e360f74759300fcd0c894de745403e8a162fad7439f408f7b85d99855fa88dc7bbaeac66bd81ec2c554f4dd6b946a8097919d35e3ffc8bef5a6022ac821e1943fec7ee25ac1cc383e615a96a680f97508afefb2870c169963f3f960203992026ac70ab77bd151cf00fb2708d83f89026ccf499f9e4c660a994d0bfa8f5dbd3986effbe1bc5a7ae5da4228900f435f0ce3f67a53d969f713f1b43b76056cae80cd15b0b974b041b9da30d4e447c627e2139725d4a837ed9c08e1070c7d3e0a6a3a4d8d809a69849a9b8b736f5fcc97667cac399ebf337fbcd0e66f7bf3d6a279d60170706124843c24e59e0bc89d22b0039988a8e801dce828ba031ec634dd009c1fe75a0f73365b5ac5dcc74b0396a661a898e32d836d55b6583674d8631e995dc95302a3522b05af3cf7fb97654bd1cc33b25da6fc3c3f8d1380c70380303270c85134d5c105d21da10bd1ac9b8e6a7bce73040e3f5991d0260c66a108c309c15a878b3baa660c706403ccc235db6256a75c661051b3cc66951c952ca395273e5e20f8f0504a087ec89b7fb0330ab19c6c36f51000a22ec30b3f1314d065a95147203a013b8d819d49864b2545d7d0f9eb2005a76b405945bb08e089c7d3a9546af38067939cfb8826ffb25a7f47084d60e8afa280a7d3d408e09111780e4ca18e3333731740ce4261213f5b604909e9a093ec9b1427a45c84869b8b70a85c5357569a87855c033faec7bc4fb0eb0ae63689ae2a2fe306a72e1916008a4159468f79ae70ee68120ee335a28a626c3018068401fa69f419e1fbbce75b33b58e714111165a1e2e7099ad127a60540b0e3e21415cc0063119db2d5c71c1cd57b0dcc0d93159b358e08c52c00231c6a0fa418a238b6201aa55519e6af8658c34b8c0b626de4cf3e09f9b761ed0484e0a8a2926bdb79ad61955013209d94f0066980c3f58e259ec26735981be8a25012ef804a013700121400f64be77ca598ac84a930ea97643c5042f58a0c8429812a7a2c671422bafe8a114b145b50eeba2af3bb2429952fe4d614ce420e56f349a94f7e2a741a7b89bb07bb00b0003ffae190d040919498d1447231d83171b86b8da4fbc18732e1e33d0b5d7f340fa8f0420f8001bfaf5282f60a7a9841948080134de85a071c3d4fcdcd2f1492f83291dc8607aa41d2bda3082fcd95e215650fab9d407b3197968b9cadcd66e9ee041e6b50e800a883e07091b4bbc3c20f0d042849d0f13aed08bc5368ffa6600c5a1d9a562fe30970f562a110089800234ef52c12b32708578026efbc8aa4853b642cfdf6f7ba9047dbde3ac5ac2a98130f13b05a6e72a10e9510b75734585e314241533319f058b4551dd407a480e0f4a15abe5638107348b141e75255a4888e4d9a8a093ba499c039e8062f58b016a8add010c26c5588070f500483010f0b21b6d37bd3168b8f180a72be63be22389746e27fc3b3c9246519f245187bffdcd5caa9fd218136e16636f05a338cc4959d99e86410281eea92e4f7100de2f0c8f8e8e245ea3fcabb5616063498c3fe9fbdc6f87641b86b645c140a7a90c06260230f00e84815b8e9566f333f9bbf2d2c4fc5d0b8bf919697e6e625a5ac8cf2c86bc24dfe916451848b122d9682852e8ec18e690ca2de45519d4783bac1a1c0c9ff99e92812907166a8abe724be94c9aae78417fba508ba785f8eac2b2aecae51a570fdaf4070285b2d5c24093bd11c7cbacbb044f5edd649fe00225aae76998b01c5b6bd607000faa868a2f23ac0b740860f88f671531a9ce07b5eb79b7366801e9f9ca879e7b0fcf73f6c03500030e45f59126a074630634271320122f12f2f21a5dbcf00bd25a0a4b04c223ff391fd234ba5749d5d5329a772d4715351f541fd05510d04b3e11a9e108194a42195ab4c9104409cf68e0b552788b580767e02b562e65abb26db283809589919f02109a0ca6550cf8afca48e28380c975d338ccd28810cd2d34632d1b9392ca561333f26dca4457790c6c7b9c9065673c3e3ac4b0e55d842def62d8b22b03d092ee9c1fbd6378087ee31a6d17b74a464746c7c7e3bf98f4e835a38c8816ffe1d3837786428730f49751c0d2692a0396770680e51402cb410f58085026e6095c18ae84fc215790e50ab2fc9223cb08466b2abdc3c343e93802cb590296b30c5836587bb1230973005b76736c491493b1fcf865882dcdafe74e85000386fe6b14b6a46f2bbd2b341586be2960cb6a005bee264f6b105b08544ecc9d9cc4dcc62b3acb1564f9d541163a7ab9ca328cc8f20821cb2317862ca0b5a40059fa39b28ca7d3c964bb2ff5178f2cfbb50525041730f4d751c8d2696a94d6f2ce08ad25802c57b4962bd8f2ab852d70f4ee242de5e23496b1eefbbb447d253e9c1f9f4c6f1aaa6c2832bc215439f2435b0b41050cfd200a553a4d8dd257eea29e39c7e68e17ee92e6f327db82325d5b51baa9e0c9925761979a464543695015cf135a63f915e407754580369c3023146f518dfb5a7572a787222f8b35adbc22f4c53ac8bf82a59fabaaea8840c2a2ba75ed6c672ca99986daea0424d145541c5e82c117267814f22c3b925cc5dba2ae3b2af99c396270c075e3a7acd45a3affc13feeebbda309b7c80a5001080d5efa45ad5d3c876a38b0e96208dd7138bc8c0e5b20d404465661edcf3c87fe4bd3a951db20cbc450e8845907a912a22f585a82fd6854c52f1bf7c0261cd6717be344147411bad4617397b1175add8d1dbb31a7932e88b2b8d3128f2b55757315378cd56789755c38daf0823d6ba14fdccded66587948ad3760cb6c0718a65c3b2c34a4694715af8ccb51e50137871e43e9d632867a0891bc722eef0c43a6c32de2f19b945f34dbfd65429b2f47c66f189e1ccf2f2613a95431b6e95acad55443c2c9b7c097796989dd881d3f4e3e520c61070cbd1005339da63298f9720066de8e6b7e13839905d06066a471aa9388a7033acb3f92ce026c8da71a2f7b60d557876c879aefd9f6616959a588e01f3e1d800eea9275908abc803de0bca718274582e084040e439e2f63133b89badab900e5a29a7776778cf7b6010fe10c30374617d6859b133c5dcf031cbf4fc57ac0e335f972e1c687471ef9ed800a11c77e3b1404a183704ae361184b2da386d40a6b278516063b49ec79968b27f27ea8576655633097c59283b0827040d8b0a6e2b256aadb71af5e15350b37f41c6ad61581c325031b0378ddb478019d17d0db18fec08b000245031086d3a9c699159e8a884310246e81abd61c5da7374e2fc797f8706c24d18e2f979c51020033d6fdefbb2e2d3efcdd4f0f24430801437f1a05269da6b6b7c61920f8635072b2343349c55622883cd85d388be179151b375089a5d514ea2c496edc22708c20a25a43923be055832a1af0bb037bcccaae40f92430825db5597927c9bb3d84c863b32f53ab0cb3ded0018c51c47c3c1960158d5e611182995888e9e941035c396239727ed019fbd0a85e1056613550fca4627910a0292b547155f4fa60603d282cb44e555f983fe91658b33a31b6e832b7980c53ac1d354255f06e75d4321694d3edb1e95c2d19924ef2cacc2acb16247db1e1a96003400f2aa0826fe02ff93ae400db8788c2d4404daa57898a564fd9a13b9df03a8394bdf302e782d987c6addb4440c76b38fe3689a5b07e2d5c5bc7575e7f36c04bba35a0b85703dba62210be5165989b530d668aed959d3e1f511b1655b904225d48c4d3a9cd2f3bf524faf5aee6942b72265e89c547d3727c38313272395498aebba68b6bb0f1effee18bbf16aa3085a17f12d560e32bef1ea9872a4c61e8e5b5cae2c611f1f69526674a92d0d0d885bbaebf250d27d498584c76a98b2e8770be9b500e80a5e003bcfdb0a6e89a3ba7a85a75ca1241df88dbe19195956b94eae44a2a9b3c8196cd80c48becddeea8e1a2714fc712f3289810121ec8ae1c6a986182c0c175f0f850dcd3c1afea461d1cfe76ac2cc9c45299c2e69f919bd04d72e1c56f7f32944a0943d9a86e929da632751bc820704c96cec8dbf3535385f9bb0699837010b8c63b23bfd0457603612a1e919c3d5665ea11f625d2e2402584dd6065affe7ee81aa63ab37d9ab3aab201f879bb5cad62eded09eaebc5ce9f60630664c826772f86322cd72e03f68b93a9587acda2646ac6c4f91d4f5d4075fc947b00e90c213d9ed544cb94065c1b683b028255c4432e9fbe10c8f7927e4bccfc246dff4969ed1a0fd0249ff7e42cfae40838ff2689e401bb7f88f7be63b5ce43be34f81985379234dc18290d9edf3c96c90f6736b1f8e182a4614ddbb3e7e1fde7ee7aec73b6c0e1bbd8d0ff0a0bc37a539930dc1810862a15e84f1fcb1f9f5cc8cf971696a6f21887930410dde253d4ebd7d21d238ac62229eab5abcd4c8c8c64465fdf48c4faf0f2350088ef2c7cfcdb0299fe331b7a7798a2eb4d65148d05283a8b1495a6e726e7fc5a9263f9f9e97c5b10e2efbaa74dc5e44522878e81892e1f460d5196dcd210b2ddbcd62001e1a6c3e3fc038ffbbda0b9a399972f30c7e3ba45245e8be74babf8e0551e98de1ba82a4b5c4c9d8a9ba5195da682756a64d41e94a69a4ec0b6a613d656bd26da6841b700bbc468867b4087ab3b521b2b4dd1a97f7674550aa77c64cbefb41f9a612dbf0fb6e5987a76bc106bf0aa52a282309752a93643bb8de0af068ae236522122f861db0a43dc2290a80a918ba9482bc426c7272fcb8ab46f2dfc951ed23b60e86fa30a433a4d8d280c394e1032535a5c9c29f820b290c7e290608ec47fe99ed11c47578562340f3cb84ee9e307c70cb1ce155404383b6d07bbb99215ae6a16ffb57b4cec77d25a17422eb1682c50b8b009e0d1b9c8ad53a5462124091e20888e35b1aa75fd1ab6cef56b35fa7ea8c88cc3c47121115f88e652a119ac5f5354de216f9d58eda517b4b64b7da71828cd76e39fac98e68231020fd5f5358d1dbeee96181f696f8cff0bd63450f4ff7e5c16fb953cc686da5a9b50f958f6ab1f084d85a137ada9692c9321339b5f989b9b9726f33361054350dc929ee2d6207236ba37d285c7ef135c1c8f15363f587389e47d0908f4c1ccb117059afd2736747b98bceb4d65e46d04c85b66e42d4c969666e7f377b6e96f9cbc3dc36ef79dee0789b60f46b2ea764ecbc944726462f3bd589b40cb9b0fbffa972102c1d09d51b4ec3495d1f2c1002d15f2d2cccecd1d9f22468d36301243231e9f3e4db47cba332df3c3a9cce8656960fcf58b4f7c246435c0d06d510646a7a98c964f0768a9d2d3947c5a4673e5f67892b3e5a788949fba30911f4f17f3a94d7bb6c06692f6efef98fc72885e30548a226da7a98cb49f0a90b6c2447e6ef1d86c7e71ba44b48de054fa5a146dd7506263c5c444bc5d89bd0c68f963e75f7c2d442018ba238a969da646d132ce68b9b4b0989f9f8c6ab4fe99ae50286a1963b3e59a8c858aaad5debf34d0897db6893aab829dd80724e6c2a6d432aaa40725d8cb2f136c6637ecc47c5cac95a6eda69bb89dcf6dcdc6c8b8502e3924f95123a1aa31d4349df755f79aa71b811eec513d46d97310ca2d2f9e45be3c722c4646dafc089b9f49277492a7e095e6b0676c617fcf0686f02a5e3341b113baa5eaa054535bd0b03520508b67b2918928f8a785d67e3e5c7f8fe4e07b1de4003820511c4f153c39780d8af55eef68493c1d4f8c8ea69323c9e57466b8327a394470d65dd3c545707efecc47ef0e457060e81b51119cffb8ef2b83a1080e0c3d2b20c5f70248314f7d104ecccf2d082eb3f1fc7c7e6aa9cd67f6836e307d6c33cade751b6e0c526c987d1ef08f3147b2d052dc4d09552ea0cb137f68db09762dd71af38caf7ad32e6336abd78ddc6ff541d7d5eef3312ad4ed23b1699eb88aa5dedb4410ab35d90717d9d9a9a30f2eb5de63f2d63682db9ab7afd9c4257d01a6bab79aa0a97e29a6ef25b45399bf640b1814380f5c5f25707db5b392319a2e8c4fb4b789bb0cdaa3ff46fec9ee905d0b43f745b547ef349541c7ab01e8489292319fbf7d7669322a00dcfdadb092a1ab55190edd504f7137144be76950e99897ef91eb00d8e895c1a64d187d05b040c9e0cf9262cdfd918bbc87a4f85a0c29164ddd8d6c6955039f9984fc35c43a5cf3b41a9ae7656db8d9196b3e1506d35aaaec402725c3f5b8d45940b9c3e35ed8697e96d290cfa8424672f0492f4d43030ce18d8903e9266d9a458042a87761be89ed291c1e990778068a824b623e3e20a8d7f47d199fdd8924a718257bdab017821c105aaf57004078fe08daec518e8da0905ccb85a4984fa6475fb3aabbd7fba84fa546d48a929113eab05c2967629783fab1ee9a2230a4d831028adac71d9f586a09b860b2a1ae28eda3bb70ab38d561435d6bba794ceaab3c2faf72ccd869ababf7aedeeb32583f63af7e60aefe28d6eabea30b996ba7ad24e2f1d7b3ad7267a2151ed97fee7f1697c7044adcce863e1b26da7a53b1ab32dc7b0296c41b2aefa15ec36bf452ce0dc35ba458549fe17e909a7ed6653816cfe5e0f5516d77eead5e17e3bda12ec6635d7fd3f6d3f8e54c26f2e7bbdfba955d60ac3bb3157e1edf1fd5ba67ba843ec609eaa0b3902f1667e64e16e6a34cd3273b3d030c74860a8b02ba4f01bbdcad4f5e0f15b03fe19021bd397454b94914976c86bacf9740f5dc7d34985fdac10d4bd53b99e118105209410da34e38420598687f72f3332d78b5c7b722f8c3df4e2da3261260107941825f02f333114b28f1442ca5a687473295d1cb02ffd75dd3c5999f4f9e785909999f30d4563b8ae377a9bf3316323f61e8b3c201007c221c0075c4831ea1afbec293cdbb5e8a68abdfd97f4ab92f7b145b59552c75d55a5539bbed1c373150cb51eda58be4b8aeef6d62dbfd17ffecff890f232ab0a1b6e716ad379545b05f12699aa247b42ecc1dcf4bb3f985a5f948ddfce510ca2ee073cc6665cc0767ba2459f70db34166a10701a4eb46ebde0cd13c7515d45e8c8dbb49d3626f55c438693d80f3d571215f5dc8a513157296d389cdf878c504a09b490febc104c1763d1c562c36496507069a8a43eb3c99c3d7f771c8660f29a2c47b4a4e1593b235afa198ffe05b50aa59e7ae21c9d3f63d47889feacdb577f815f78129def9546e7929acfc8991f50ab635e40f00f1dbdf0a4f02b9504d3d534c8e0cbf66e6ecebfee09ef868baac9653a3aa1a2b672a9745aaf7ba6bba284dfddc132fff5e485387a1fe28a0fe9d87773e10d2d46168fb9a9a7a7a0d50495f01955f5550c1a796a1268881080cc0931a087f37daf26b7b123e17fb1017d2c3a9d7ace3d7eb5ecc3192503269b53c2a8faab1e1b87239a0ceba6bbaf0568b083bfd9ff9d64321d881a17d51b0f38177fff49f87600786fad67a84d969662e2e1d17cdc564c05cfcf8061aae2e79655d1b69b53cc3421aed05ffc1f6ab1bedb71ad96195aa76ddcb52d064fd66ab5eec20dc6d557cde687baaedda1d99bd6eabeedd85336205aaa125cb221fde235b59c1dbbaed5659a6eb4189870c5828c1ef9b7a22eae98d5efbe54953b58df30f3c019fab2a65ec9d6985f385234bfbbd8e2b77b2f54a05813254d7eb872936d28895a7ecb26eacd83e843f487b8dceac3c7e8188e93ee582b2915d037a677c28965693d481682896805780a01f2104fdc856a153486274b8bd23eb58f7fbb6ba7d42e0856064270be962c2aba278ddfa326fac21ebf29b6f786fa8cb2a0ced89aabbed349529271f0e5891ef8e8289605fe67f73013ddcafc0c515b8b8ece06284c1056cf008438b2f105a7c61036831d515d9be395e18d964b4d8c4f6cdcf1dd9f770080260e8ba28b4e83495a1c5e70368318c68b16311b6cff33ab9aea25e0a71ae1ff7ed4e51dca127111973b8d407635e4ae8e12dbfbfffdc6feb373e2ad0e3301bba314cba9b61fcf9ff3e744e987a2b1b3ab666c8770449b777919ea6c5144b8f84fc8198eb076dbeb91589b73b91b415fa9fbd2944dcbcf0cdb34085fefffbf6f70884f95336d41ba6a10abcb6fb89374c0b53ef61435ff169d82f523043c9b8278f15f28b83705a2d05ab5fbfcb1ec7cb22e280e4f82832477c340662ed0b6e0dec38b56ea0461d686c7bad08c020e4e5af27314f422ad2d302d6a87db51db8c860d5329b060b84fb310aa16b5c3814ce937606445b3c54b3ead6c6b2f8896779f3983bbb47ef61b9b81c9e0c27c41ec816c6e76fd9421304d70e750b62e104e0e5b05f62fd1df8ddb7f50a0c14c456dc42b04045ece3cfb2c75eebeef3a314b1ac9c19d307b9ad4c41fb40601c2656bd5406f680633a0590fe3c736ffb287ffe60f7cf08c17f161938d9c9ade289f162312217f832a88cfd6fef71ee0995bbc2d0f9a8cad81f0f5f775698dac786b60838f3b30044d708a2ef3b7bf63e2e1a3bcedee7bed900c2bcb58b3f707762727824bd3909ff9b0730071fd97feee76f59b859a0c86d6ce8a930f170eae7cd270e85a6c2d0bf5a03607424dd4ec4d564a23daab2b1f36d0b926fbbad4422f3a687d48b3ec9f6ce35318b76eda8c9cf5ffcce8da150080c3d1a1535e934951e56dc93c9e412da2e2fb0beab7360bdd2134fb8841b59eb51c4b951f82f33d69db90ac3453fc4587b7a2893c260380c1dd5ba7eeac6c2f17a7d74bda4106eff5130dcdef5726e57657b424db8170c68755d7f0317833f99caf67866142ff7325cae7778642899c0eb15f17ab708a1778d18c35614beaf62c1423ac64169fa2ae40bf8bb165ff4e24f5c5e9c712beced7d27feedd3c276c7d8d02d61ce586f2a71c676eca797d07a3cd6e85927e7a2fb37af726917b1531e57dc7d15e16fb6d29348e316dd8d5ba4091cb10d2fd39b4c092cf1729007b7a7e0f400a688c792914cf123648a1fe1c5804de962f05f8ede1dd5badf784ae0877ba8c126ea72a8469c98d7509d93e21ee07a7c82e990311eecd7893df4b5d9a3e732430ddcf07ffcfa4d2f85361c86e6a278a3d3544ac6218d58dbe1b1c68ef59266508a89629d84387abf6e392530c776628e848f17c046c9101bfeee5598a1034a50bc032362766bd2bd189a8470b9f72227fe5376b1ec1ec77464fd343d035d4bff7f17d17fb4	2026-05-14 02:03:41.315557	3906405037196095983	10997
66	\\x70726f64756374696f6e3a6d6f62696c655f6170692f63617465676f726965732f3365393965326564	\\x001181c494d0f64b81da41ffffffff789ce555cb721b45144d5294e34785323654b6b7bc6025eb6529b2a462118a38c885e35072ca0416ae56cf1d4dc34cf7a4bbc78ac8c61fc11236142b3ecb05ffc1e919c98f60d8b162a5d1e8deee73cf3de7e883d5efd6df6d0c1eaa487d3458d322e3d1cee32f84b273fa940e84cde8c0b24b56062bcf4e069b113b6955ee95d1a39dfb7f3ef57424ac48158d85f609d768c634b14a4f696e0aca0b8b57310ed98dc3211495e7e6d64485f48e9c29ace488226559fa744eb13519795b388fb7a991222dbbd9ba3a1d1776d16f859e322947d69850a8347a44a4022a7464ec1313b91ab1764589450b5f00257981836b94a86942baf0b6eca891d011fdc8d6903419b065ca31194d6f0a0ce6e7f595e1c393c1872a13533e2b6c8ab97f4bbccfdda0d1c8cae15d397b1ddd0d2b54ea1a427a75ce67ce1b8ba6c6243513d7b05c8dd9e0f9612cb3837cf2e5913ad64e7dfbfca0f97a3c7a7274f2ca8df4e72da9464f46d9a19bb40f6371fab58abf697eb6bbdbebb73ba215b5e36eabdbe9c5729f9bed6e578a7dee772742f67b1d8ef7e249a76195e47aaea725eced25d767d214daabd5c156a45c9e8af999b1115b75efddc6f09eda1cae8c76b6abadbf5c7484fee1eaff6acbc3b5e6705d6d0d3716b47c1c68f9e43996aa1ddc70a4d294af8979d07ef07766302bbddf801bf129038c8a3647de4c819f2d4961392e52b0b2a4c97991a7fc4f63c7c644248b14a3721dd60493981b6aa3b0773a1756b1571c6ea88667ed77f15342d9024caa7e40b198aa1a7d6f66c256ccc4e6ad877641e7395f2f2fd0ef3860079299f2090954cac2dd60ae6c1705a681be64a0f2d1faa3f5f19d4b0f6b761549d38aa4d0bc44062a50c65cd526a80533e48a0928d192abe2426bc6b31315caf008466fc82048127772e0a4640b0c2a9c9e19e7af34121b9bd5e934a996806f41744099b148319cbdc5394e533903378ae764e2182d826689c19a4cc625ac89480346b024e625f79851c10bf3306b2c3062c5cbb5cc76af64b61564f6f8c502da78c6ec59c30d4ba10d2f2f7e7ea517c3e28acb8b5fab645e921c5ebc30f4348af0655c4c85bdbcf885aaab60e0dfffa3b87afd2f7125facd76abd76f757bdd562491575274782fe6de7edcee44b2dddb6bb6b8dd948d738613c404542e430bdcac5d71b31db8593f1e7d35a62bdffd71ffce448ae13233c366e028a5c32ac2f6735b296429162c5178c27d3a72b7b63c532e82ec4a95e761e5c8077e8b8acab89e65a2d59b82172165c05ca9d8ca2a0b7f98c2430ef33bc47b43a1a58c2c673000c99405c2c989986b0b7d8b08f6662be0b95232cf4a4746d6e461b260461732174ebbbcf8e9da2f32e14c214b71d38d97467b882f44c43203cb30c0cd4b2b4cc1920631b04318bdccf16516016dd0019c5d996f9156b78c776b11741a387f692ba11e078e224ea12e7b2b226aef0773f96f105055f15338be11c89b410d7f01ebed0620	2026-05-14 02:03:47.305601	3167629127605405168	1265
67	\\x70726f64756374696f6e3a6d6f62696c655f6170692f66656174757265642f38383863393866662f6c696d69745f35	\\x00118135d3edf74b81da41ffffffff789ccd564d6f1b5514b5abcae3b1e3d86edaf483408c212d94d47d63c771f2ae2a39a8359a34524b6b844416d68be78df3e864c69d3713370409366c91608bc4825f8058b144ddb066c94f60cb1624b86fc65f4993d005482c1cfbddb973cfbde79c3b93f3e9edcce12daa094b785477d91e37cbe9476c90a2a97b6d5ab0b8ecfaa21f08cf35cb59c9074f074f53a0b569a6ef8b2eb753069db384ec7aa11b74a210a11724771ce1f6e27353a7055bb8cc191faf4c6ee07e97bb01eb7191a017c6e1e0a08f652675f79913aa80e78bdea4120624db471cd9617b2acf4e119a9181d77d22cebd9fa469f924543d5b55c3a8453deba12b02b3acddef45c7ec808bde6e4068de127bdc9538a324b4d8f73d2becc65d98e599f77cafcbfd83e88e991de6773d0ba173bbd2edc43f75ec5f9ae54494a186e83beca0e3f916f7095d10b223c39d31891deeb21d875b2d7a0daf78dd2e53b0d148116a8b167a329864cda9d3842604eeb280f73cffe05083842840ca2ccfdd65c23f283d8c2bc8581eb117a567a36fb99da0599f0548d6a14667d83ef731daccd04c4430925fc06e84db89d8c329f034625f7551c4b3e30de2cb788cbef1c4821027cf996ee9b18a44c8f9aecfb145abc3820f6869a31b887dfe38ecf73d3fa0b48d447f2882dd8f3c976fa7cd90ea2a92bbf7d5e24fbfb5769a29aa7f825788592e6e48c16edff79c272c60aaae19c2726e33cefb3105b750b5b06f8d80e01d550d33c69530a379f9c59b167699ecec854e20fa0eef3c0d194e1f082ea7941bd9f4b2c56d8699683f5f605e0757a44073c393dcd60ee7950234e3b01dee9865dd28c5c6824b4d1d2e4e7c56dc090fa6d601b258fcd2d8dc23a96176e821c8137a717c39b63646b86df388cc719d45ac9357fe18da5f271562d0abd1e50eb303ee8f45c4cc8b6c9f094761c5328a3ccd2b99e321db70bd1dcd53841a8e521d8f62a7aa53b3c08aea5f21adaf43fd48cfb04aa0d1bca1ba82b56619d6f13715e7b692002d55fc161677955dd396b4a27bd25876f853b7b5953a640872b30c33f8c98904cc1255b640a0d8ccc005a1c19c599ebdbb61366a1badf568a3a73bbb44609ec0e5a31b0b57085c25706dd4e62b04165af06a0b5e6bc12281d268899a05789d40793b016f60e84dc45bc206aeb7e1460bde6ac3db08bce50d262e879b13cb35d15f5f56773f9db25c2b0e9d5721a8bc7ceaed36103bb3b252a9d7c110b3501d9a6c3612e5147fa126cb116ff5b6d2233f795ac4ca60f2aa520c096e34efc0a29d5a81355b372a8d3514e90e8aa4018cf5cf1fd3bfb97404cad66a2b6880d4ea89ea6faaea35559d540c557d13abeb5306d85306d0a6f4b764ac3fb67f5cfd134639ee86025a6960f97ce00ff8c80fd977bd2070f8b0fb65981f35f9d2d668a387effe7bde78fefd1f744af07b71e88793bc7156eaed16101cc720e88a4444a6a3c8cc2205b2567d81503b6df06acc690f39ed9db45109c5615a0e6ff98f77a915f1d5527c151f8441c9b34fa7ecafe7bf5e3bc60386be3e89b2b352a375d2f049658899f12ecd9cbd4bb6665423ceced826fc349acfd0259bcaeaf5cafa0a5afd195a3df9fbd0eb0a281701d526405b4797d6c43d4a5751a41829638b67dc1a822c21c8123450c4f535c4311127b3daa8d4aa0894fc1c9196a696ea63e583f93697eafd5e7af848a87f034ac6c812ba25a74c4186a6487e81aec03fa7d942fb7fb9e226eafae72f0b3f4f494de2d083e3aef8a754e50ad4d7c007d3c813fad90f3d2595e2ea74a1b01e3ef9eaf8e24b7e8312f5d49b6f697bca0c698590a94edc606bd5da5190e4b7eacd6a10629c0434b49d5aeb1a3a0261d6ec749d1bca10df21dc6731d8df19f52505	2026-05-14 02:03:51.841375	-6119516050922335696	1549
\.


--
-- Data for Name: solid_queue_blocked_executions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.solid_queue_blocked_executions (id, job_id, queue_name, priority, concurrency_key, expires_at, created_at) FROM stdin;
\.


--
-- Data for Name: solid_queue_claimed_executions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.solid_queue_claimed_executions (id, job_id, process_id, created_at) FROM stdin;
\.


--
-- Data for Name: solid_queue_failed_executions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.solid_queue_failed_executions (id, job_id, error, created_at) FROM stdin;
\.


--
-- Data for Name: solid_queue_jobs; Type: TABLE DATA; Schema: public; Owner: -
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
-- Data for Name: solid_queue_pauses; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.solid_queue_pauses (id, queue_name, created_at) FROM stdin;
\.


--
-- Data for Name: solid_queue_processes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.solid_queue_processes (id, kind, last_heartbeat_at, supervisor_id, pid, hostname, metadata, created_at, name) FROM stdin;
\.


--
-- Data for Name: solid_queue_ready_executions; Type: TABLE DATA; Schema: public; Owner: -
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
-- Data for Name: solid_queue_recurring_executions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.solid_queue_recurring_executions (id, job_id, task_key, run_at, created_at) FROM stdin;
\.


--
-- Data for Name: solid_queue_recurring_tasks; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.solid_queue_recurring_tasks (id, key, schedule, command, class_name, arguments, queue_name, priority, static, description, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: solid_queue_scheduled_executions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.solid_queue_scheduled_executions (id, job_id, queue_name, priority, scheduled_at, created_at) FROM stdin;
\.


--
-- Data for Name: solid_queue_semaphores; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.solid_queue_semaphores (id, key, value, expires_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: stock_batches; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.stock_batches (id, product_id, vendor_id, vendor_purchase_id, quantity_purchased, quantity_remaining, purchase_price, selling_price, batch_date, status, created_at, updated_at, store_id) FROM stdin;
54	47	11	\N	25.0	16.0	68.0	130.0	2026-03-19	active	2026-03-19 09:33:46.519679	2026-03-29 04:13:25.553437	\N
43	35	11	\N	10.0	0.0	500.0	750.0	2026-03-19	exhausted	2026-03-19 08:25:49.698752	2026-03-26 03:38:32.405987	\N
48	41	11	\N	5.0	0.0	250.0	350.0	2026-03-19	exhausted	2026-03-19 09:13:09.708624	2026-03-26 04:46:31.021034	\N
50	43	11	\N	5.0	0.0	360.0	490.0	2026-03-19	exhausted	2026-03-19 09:18:09.882759	2026-03-26 05:01:39.712018	\N
46	38	11	\N	5.0	0.0	180.0	270.0	2026-03-19	exhausted	2026-03-19 09:01:53.798047	2026-03-29 10:07:20.080285	\N
52	45	11	\N	5.0	4.0	395.0	530.0	2026-03-19	active	2026-03-19 09:25:14.473924	2026-03-29 10:18:10.072283	\N
51	44	11	\N	5.0	5.0	275.0	370.0	2026-03-19	active	2026-03-19 09:23:10.747793	2026-03-19 09:23:10.747793	\N
55	48	11	\N	5.0	5.0	360.0	600.0	2026-03-19	active	2026-03-19 09:35:13.633483	2026-03-19 09:35:13.633483	\N
57	49	11	\N	2.0	0.0	12.0	100.0	2026-03-25	exhausted	2026-03-25 03:36:41.323722	2026-03-25 04:33:56.826277	\N
91	90	11	\N	4.0	4.0	750.0	1050.0	2026-05-04	active	2026-05-04 15:34:01.906817	2026-05-04 15:34:01.906817	\N
92	91	11	\N	5.0	5.0	1250.0	1750.0	2026-05-04	active	2026-05-04 15:35:33.589985	2026-05-04 15:35:33.589985	\N
93	92	11	\N	4.0	4.0	169.0	240.0	2026-05-04	active	2026-05-04 15:37:35.676007	2026-05-04 15:37:35.676007	\N
94	93	11	\N	5.0	5.0	57.0	130.0	2026-05-06	active	2026-05-06 07:48:37.418719	2026-05-06 07:48:37.418719	\N
65	53	11	\N	10.0	9.0	85.0	140.0	2026-04-16	active	2026-04-16 07:29:00.005737	2026-04-16 07:38:11.254699	\N
62	50	11	\N	23.0	0.0	23.0	1.0	2026-03-29	exhausted	2026-03-29 05:32:39.644243	2026-04-16 14:24:14.149796	\N
97	96	11	\N	5.0	5.0	76.5	135.0	2026-05-06	active	2026-05-06 09:48:21.202483	2026-05-06 09:48:21.202483	\N
98	97	11	\N	5.0	5.0	57.5	135.0	2026-05-06	active	2026-05-06 09:50:25.017234	2026-05-06 09:50:25.017234	\N
95	94	11	\N	5.0	3.0	32.5	65.0	2026-05-06	active	2026-05-06 07:51:48.350844	2026-05-09 06:06:07.327408	\N
60	35	11	\N	10.0	0.0	600.0	750.0	2026-03-26	exhausted	2026-03-26 06:50:33.860032	2026-05-03 01:23:54.860788	\N
47	40	11	\N	5.0	0.0	250.0	345.0	2026-03-19	exhausted	2026-03-19 09:11:09.452743	2026-05-06 15:48:50.483104	\N
86	85	11	\N	9.0	7.0	52.0	125.0	2026-05-04	active	2026-05-04 15:21:35.282742	2026-05-06 15:48:51.12574	\N
96	95	11	\N	5.0	3.0	200.0	270.0	2026-05-06	active	2026-05-06 09:40:58.582982	2026-05-09 06:06:08.061189	\N
68	56	11	\N	2.0	0.0	780.0	1100.0	2026-04-30	exhausted	2026-04-30 15:40:23.861833	2026-05-03 01:55:05.678551	\N
101	104	11	\N	3.0	2.0	23.0	45.0	2026-05-10	active	2026-05-10 00:14:50.6273	2026-05-10 05:09:13.199565	\N
44	37	11	\N	5.0	0.0	480.0	600.0	2026-03-19	exhausted	2026-03-19 08:49:25.992492	2026-05-03 01:58:22.870034	\N
59	37	11	11	2.0	1.0	23.0	455.0	2026-03-26	active	2026-03-26 06:45:49.237053	2026-05-03 04:11:50.883981	\N
58	49	11	\N	345.0	308.0	12.0	100.0	2026-03-25	active	2026-03-25 04:48:04.520486	2026-05-03 04:12:35.702932	\N
63	51	11	\N	3.0	0.0	112.0	160.0	2026-04-16	exhausted	2026-04-16 07:23:03.984065	2026-05-03 11:03:35.790877	\N
64	52	11	\N	10.0	6.0	47.0	80.0	2026-04-16	active	2026-04-16 07:26:39.931749	2026-05-03 04:21:00.019249	\N
70	50	11	\N	1000.0	982.0	23.0	1.0	2026-05-03	active	2026-05-03 05:18:49.960941	2026-05-09 06:02:54.075007	\N
45	39	11	\N	5.0	2.0	195.0	380.0	2026-03-19	active	2026-03-19 09:01:28.089076	2026-05-03 04:43:58.788783	\N
102	105	11	\N	2.0	0.0	45.0	45.0	2026-05-10	exhausted	2026-05-10 00:31:08.227538	2026-05-10 05:09:14.071227	\N
103	105	11	\N	4.0	1.0	34.0	6.0	2026-05-10	active	2026-05-10 00:31:09.50596	2026-05-17 13:38:57.668993	\N
73	61	11	\N	5.0	5.0	65.0	110.0	2026-05-04	active	2026-05-04 12:44:45.889188	2026-05-04 12:44:45.889188	\N
49	42	11	\N	5.0	0.0	450.0	650.0	2026-03-19	exhausted	2026-03-19 09:15:33.545935	2026-05-03 06:28:50.559092	\N
53	46	11	\N	25.0	16.0	83.0	130.0	2026-03-19	active	2026-03-19 09:30:21.49213	2026-05-03 06:28:51.437557	\N
78	73	11	\N	5.0	4.0	95.0	160.0	2026-05-04	active	2026-05-04 13:37:28.805098	2026-05-10 08:56:03.525079	\N
74	67	11	\N	5.0	5.0	56.0	90.0	2026-05-04	active	2026-05-04 13:16:49.523415	2026-05-04 13:16:49.523415	\N
66	54	11	\N	5.0	0.0	370.0	600.0	2026-04-19	exhausted	2026-04-19 15:18:46.716787	2026-05-10 07:04:05.53176	\N
69	57	11	\N	2.0	0.0	750.0	1035.0	2026-04-30	exhausted	2026-04-30 15:45:12.391257	2026-05-03 07:28:18.995045	\N
100	99	11	\N	323.0	317.0	1.0	1.0	2026-05-09	active	2026-05-09 06:10:12.042072	2026-05-09 06:43:40.092397	\N
56	36	11	\N	5.0	0.0	250.0	350.0	2026-03-19	exhausted	2026-03-19 09:36:02.599539	2026-05-03 07:47:11.701836	\N
75	68	11	\N	5.0	5.0	56.0	90.0	2026-05-04	active	2026-05-04 13:17:17.722086	2026-05-04 13:17:17.722086	\N
77	72	11	\N	5.0	5.0	47.0	90.0	2026-05-04	active	2026-05-04 13:27:13.467389	2026-05-04 13:27:13.467389	\N
79	77	11	\N	5.0	5.0	60.0	100.0	2026-05-04	active	2026-05-04 14:00:42.128506	2026-05-04 14:00:42.128506	\N
84	83	11	\N	5.0	5.0	120.0	180.0	2026-05-04	active	2026-05-04 15:12:51.239431	2026-05-04 15:12:51.239431	\N
85	84	11	\N	10.0	10.0	275.0	450.0	2026-05-04	active	2026-05-04 15:17:41.394979	2026-05-04 15:17:41.394979	\N
87	86	11	\N	10.0	10.0	26.0	70.0	2026-05-04	active	2026-05-04 15:22:52.088003	2026-05-04 15:22:52.088003	\N
88	87	11	\N	9.0	9.0	45.0	125.0	2026-05-04	active	2026-05-04 15:25:05.539341	2026-05-04 15:25:05.539341	\N
89	88	11	\N	10.0	10.0	23.0	70.0	2026-05-04	active	2026-05-04 15:26:23.574221	2026-05-04 15:26:23.574221	\N
90	89	11	\N	5.0	5.0	1250.0	1725.0	2026-05-04	active	2026-05-04 15:31:43.972459	2026-05-04 15:31:43.972459	\N
81	80	11	\N	3.0	0.0	36.0	90.0	2026-05-04	exhausted	2026-05-04 14:54:37.855093	2026-05-09 13:09:33.035459	\N
71	58	11	\N	5.0	3.0	142.0	280.0	2026-05-04	active	2026-05-04 12:39:07.075462	2026-05-17 09:57:02.76873	\N
99	98	11	\N	5.0	2.0	120.0	160.0	2026-05-06	active	2026-05-06 09:54:11.245218	2026-05-10 05:11:25.726742	\N
107	59	11	\N	2.0	0.0	150.0	290.0	2026-05-17	exhausted	2026-05-17 10:10:15.436755	2026-05-17 10:11:00.261302	13
105	106	11	\N	332.0	332.0	1.0	0.99	2026-05-10	active	2026-05-10 05:16:07.11477	2026-05-10 05:16:07.11477	\N
104	106	11	\N	10.0	5.0	1.0	1.0	2026-05-10	active	2026-05-10 05:16:06.792587	2026-05-14 02:01:04.551599	\N
67	55	11	\N	8.0	4.0	230.0	350.0	2026-04-19	active	2026-04-19 15:21:06.912153	2026-05-17 10:43:11.947777	\N
83	82	11	\N	5.0	4.0	225.0	408.0	2026-05-04	active	2026-05-04 15:03:39.96716	2026-05-17 10:16:59.876502	\N
106	58	11	\N	1.0	1.0	142.0	280.0	2026-05-17	active	2026-05-17 09:48:44.789216	2026-05-17 09:48:44.789216	13
72	59	11	\N	5.0	0.0	150.0	290.0	2026-05-04	exhausted	2026-05-04 12:41:01.848924	2026-05-17 10:10:13.308826	\N
61	42	11	12	3.0	2.0	4.0	344.0	2026-03-26	active	2026-03-26 07:19:50.520941	2026-05-17 10:16:49.183814	\N
108	42	11	\N	1.0	1.0	4.0	344.0	2026-05-17	active	2026-05-17 10:16:49.796916	2026-05-17 10:16:49.796916	13
82	81	11	\N	5.0	3.0	56.0	180.0	2026-05-04	active	2026-05-04 14:56:46.439353	2026-05-17 10:16:54.196069	\N
109	81	11	\N	1.0	1.0	56.0	180.0	2026-05-17	active	2026-05-17 10:16:54.499079	2026-05-17 10:16:54.499079	13
110	82	11	\N	1.0	1.0	225.0	408.0	2026-05-17	active	2026-05-17 10:17:00.180483	2026-05-17 10:17:00.180483	13
80	78	11	\N	5.0	2.0	480.0	600.0	2026-05-04	active	2026-05-04 14:14:45.278327	2026-05-17 10:43:08.231809	\N
111	78	11	\N	2.0	2.0	480.0	600.0	2026-05-17	active	2026-05-17 10:43:10.138744	2026-05-17 10:43:10.138744	13
112	55	11	\N	2.0	2.0	230.0	350.0	2026-05-17	active	2026-05-17 10:43:13.147955	2026-05-17 10:43:13.147955	13
113	105	11	\N	1.0	1.0	45.0	45.0	2026-05-17	active	2026-05-17 13:38:58.288179	2026-05-17 13:38:58.288179	13
76	70	11	\N	5.0	2.0	37.0	90.0	2026-05-04	active	2026-05-04 13:22:39.282477	2026-05-17 13:38:58.752209	\N
114	70	11	\N	3.0	2.0	37.0	90.0	2026-05-17	active	2026-05-17 13:38:59.060546	2026-05-17 13:41:13.481193	13
\.


--
-- Data for Name: stock_movements; Type: TABLE DATA; Schema: public; Owner: -
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
\.


--
-- Data for Name: stock_transfers; Type: TABLE DATA; Schema: public; Owner: -
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
\.


--
-- Data for Name: stores; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.stores (id, name, description, address, city, state, pincode, contact_person, contact_mobile, email, status, gst_no, created_at, updated_at, store_admin_user_id, admin_plain_password, auto_transfer_threshold, is_main_inventory, commission_percentage) FROM stdin;
3	store 1	sd	9898919191	kumra	karnataka	560085	9898919191	9898919191	\N	t	\N	2026-05-10 10:31:51.611605	2026-05-10 10:31:51.611605	\N	\N	10	f	0.00
4	store 1sdd	sd	9898919191	kumra	karnataka	560085	9898919191	9898919191	\N	t	\N	2026-05-10 10:31:59.971464	2026-05-10 10:31:59.971464	\N	\N	10	f	0.00
13	dsdsds	cds	dfd	Bangalore	karnataka	560068	pramod bhat	7817171717	\N	t	\N	2026-05-17 09:41:00.280605	2026-05-17 09:41:02.944391	106	EManSGst	10	f	0.00
\.


--
-- Data for Name: sub_agents; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sub_agents (id, first_name, last_name, middle_name, email, mobile, password_digest, plain_password, original_password, role_id, gender, birth_date, pan_no, aadhar_no, gst_no, company_name, address, city, state, pincode, country, profile_picture, bank_name, account_no, ifsc_code, account_holder_name, account_type, upi_id, emergency_contact_name, emergency_contact_mobile, joining_date, salary, notes, status, distributor_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: subscription_templates; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.subscription_templates (id, customer_id, product_id, delivery_person_id, quantity, unit, price, delivery_time, is_active, template_name, notes, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: system_settings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.system_settings (id, key, value, setting_type, description, default_main_agent_commission, default_affiliate_commission, default_ambassador_commission, default_company_expenses, created_at, updated_at, business_name, address, mobile, email, gstin, pan_number, account_holder_name, bank_name, account_number, ifsc_code, upi_id, qr_code_path, terms_and_conditions, collect_from_store_enabled, delivery_only_at_shop, shop_addresses, low_stock_alert_enabled, low_stock_alert_threshold, low_stock_alert_email) FROM stdin;
3	business_config	business configuration	configuration	Business configuration settings	\N	\N	\N	\N	2026-03-25 04:49:06.327843	2026-03-25 04:49:07.616501	Marali Santhe	dfd	09190939393	9093939393fdfds@gmail.com			Ecommerce Store Pvt Ltd	CNRB0003194	3194201000718	SBIN0001234		\N		\N	\N	\N	f	10	\N
4	system_config	system configuration	configuration	System configuration settings	\N	\N	\N	\N	2026-03-25 04:49:08.920571	2026-05-10 09:53:30.256798	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	["abc,bcd"]	f	10	\N
\.


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_roles (id, name, description, active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
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
79	Javeed	Patel	raghubit040@gmail.com	919663838730	2026-03-08 11:32:15.894369	2026-03-08 11:32:15.894369	\N	$2a$12$YMubTE/vIda84KGhn7lIyObErAFpge9aehhUea3BUHlu.lPceuaaa	delivery_person	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	NR colony 	Bangalore	Karnataka	560004	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
80	Javeed	Patel	maralisanthe@gmail.com	917975918232	2026-03-20 07:59:01.955945	2026-03-20 07:59:01.955945	\N	$2a$12$prc0D8/AfMOuhJDAEwS9NOTmPxT3hX9hTlRryFmbSTf6yijE56vga	delivery_person	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	NR colony Bangalore	Bangalore	Karnataka	560004	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1	Admin	User	admin@maralisanthe.com	9999999999	2026-02-12 11:39:37.772197	2026-03-07 13:35:08.66239	\N	$2a$12$F3y6NUiRv9pvLpslJGXiFuiPkhB5QPVd5j4vpVdPmadgq8rHF0I52	admin	admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	{"dashboard":{"view":true,"create":true,"edit":true,"delete":true},"bookings":{"view":true,"create":true,"edit":true,"delete":true},"stores":{"view":true,"create":true,"edit":true,"delete":true},"customer_formats":{"view":true,"create":true,"edit":true,"delete":true},"subscriptions":{"view":true,"create":true,"edit":true,"delete":true},"invoices":{"view":true,"create":true,"edit":true,"delete":true},"notes":{"view":true,"create":true,"edit":true,"delete":true},"pending_amounts":{"view":true,"create":true,"edit":true,"delete":true},"invoice_check":{"view":true,"create":true,"edit":true,"delete":true},"vendors":{"view":true,"create":true,"edit":true,"delete":true},"vendor_purchases":{"view":true,"create":true,"edit":true,"delete":true},"customers":{"view":true,"create":true,"edit":true,"delete":true},"categories":{"view":true,"create":true,"edit":true,"delete":true},"products":{"view":true,"create":true,"edit":true,"delete":true},"coupons":{"view":true,"create":true,"edit":true,"delete":true},"customer_wallets":{"view":true,"create":true,"edit":true,"delete":true},"franchises":{"view":true,"create":true,"edit":true,"delete":true},"affiliates":{"view":true,"create":true,"edit":true,"delete":true},"subscription_templates":{"view":true,"create":true,"edit":true,"delete":true},"delivery_people":{"view":true,"create":true,"edit":true,"delete":true},"imports":{"view":true,"create":true,"edit":true,"delete":true},"reports":{"view":true,"create":true,"edit":true,"delete":true},"system_settings":{"view":true,"create":true,"edit":true,"delete":true},"user_roles":{"view":true,"create":true,"edit":true,"delete":true},"banners":{"view":true,"create":true,"edit":true,"delete":true},"client_requests":{"view":true,"create":true,"edit":true,"delete":true},"helpdesk":{"view":true,"create":true,"edit":true,"delete":true},"users":{"view":true,"create":true,"edit":true,"delete":true},"leads":{"view":true,"create":true,"edit":true,"delete":true},"life_insurance":{"view":true,"create":true,"edit":true,"delete":true},"health_insurance":{"view":true,"create":true,"edit":true,"delete":true},"motor_insurance":{"view":true,"create":true,"edit":true,"delete":true},"other_insurance":{"view":true,"create":true,"edit":true,"delete":true},"roles":{"view":true,"create":true,"edit":true,"delete":true},"settings":{"view":true,"create":true,"edit":true,"delete":true},"referrals":{"view":true,"create":true,"edit":true,"delete":true}}	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
81	Pramod Test	Bhat	pramodbha8@gmail.com	9632850872	2026-04-17 10:42:04.294342	2026-04-17 10:42:04.294342	\N	$2a$12$UXbKKd5sIkgQqmYeFDkrMuS2gte37dq0ubnaVIqbxdqPf/vs3tQ76	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
83	John	Doe	johdn.doe@example.com	9876543010	2026-05-02 07:19:22.975151	2026-05-02 07:19:22.975151	\N	$2a$12$8mAMndxGG3EltrDpS7ptfOsio11/TEOL/OhHW9ShzRagXMiOy8Ftm	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
84	Rajesh	Raj	raj3@gmail.com	9879879871	2026-05-02 10:26:17.04101	2026-05-02 10:26:17.04101	\N	$2a$12$f.6cQSY/q.rjbaEFmF.y2eR1l/Bv6PUoiRAVdeK86c9jJsqjRfuJC	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
85	Test	Customer	testcustomer@example.com	9876043210	2026-05-03 05:02:28.742608	2026-05-03 05:02:28.742608	\N	$2a$12$gPJN0/Sy0ellJSFTp/518eMo2r3vyeFf6YIjH0dzKq4s00F9WqhSS	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
86	Bdbhd	Nxn	pramodbha87@gmail.com	9632850870	2026-05-03 10:01:26.055139	2026-05-03 10:01:26.055139	\N	$2a$12$WoYEiLtuUgEJn9Iw9U7HsOjJOmfTDeMEORfuFGQD5Q3mGIwLEBs1e	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
87	Ncnf	Ffnn	pramodbha8dh@gmail.com	9632626265	2026-05-03 11:02:05.292635	2026-05-03 11:02:05.292635	\N	$2a$12$Avx4vj7lkFEQmdzqA0.SfOxHRrYMd7w9JzZjoNzjmuMb4R9MbY8bm	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
88	Raghu	Kt	raghukt.shetty89@gmail.com	9035408833	2026-05-04 10:46:16.790091	2026-05-04 10:46:16.790091	\N	$2a$12$hJ4JgeWDlPMMQ7ACPtFkfOWC4F6yih.pJ/PGtMwEbaP.zPpL0v8f6	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
89	pramod	bhat	9093939393fdfds@gmail.com	09190939393	2026-05-09 11:43:23.478457	2026-05-09 11:43:23.478457	\N	$2a$12$cAjdNCoM8V63Rg/kbwubtuYH3KG53dBasbesJhJsre4iysChEPkC.	affiliate	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	Affiliate	12	\N	\N	\N
92	sdfdd	dsdsfdsd	dfsfdfdsfdsfds9093939393fdfds@gmail.com	09190939001	2026-05-09 12:57:10.144622	2026-05-09 12:57:10.144622	\N	$2a$12$TJ.gYuLWu.XSIDlFjWz5iOkMlMryYn0/dZW8/80cMj93HTUeX8Cu2	franchise	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	dsdsfdsd	sdfa	Bangalore	karnataka	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
93	aadad	aadad	9093939sdsd393fdfds@gmail.com	+91 98099 80101	2026-05-10 05:28:18.494809	2026-05-10 05:28:18.494809	\N	$2a$12$OseAO.l6zD0YMdodU9010eWdEaqJTMvbylGf7VGxCt.OKvzTZGKVG	franchise	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	aadad	sasa	Bangalore	karnataka	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
94	Eeuhhhj	Ggbbvh	hah@gmail.com	9632859632	2026-05-10 07:10:23.913988	2026-05-10 07:10:23.913988	\N	$2a$12$SEsJuUiNretE6Knq89aPte3YOs9MPahOmY3hBNCoAAd070sauNwcS	customer	super_admin	\N	t	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
97	abc@gmail.com	aa	abc@gmail.com	+91 98989 89898	2026-05-17 09:13:22.004108	2026-05-17 09:13:22.004108	\N	$2a$12$MxraQnqEXBULcjTTs9OQu.F7GIxCvMAu5Q6cvVuYr8zn6keYWrCde	store_admin	super_admin	\N	t	t	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	{"dashboard":{"view":true},"bookings":{"view":true,"create":true,"update":true},"expenses":{"view":true,"create":true,"update":true,"delete":true},"inventory":{"view":true,"create":true,"update":true},"stock_transfers":{"view":true,"create":true}}	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	4	{"can_manage_inventory":true,"can_create_bookings":true,"can_view_reports":true,"can_request_transfers":true}	\N
98	abc@gmail.com	df	a122bc@gmail.com	+91 98989 09090	2026-05-17 09:13:43.958295	2026-05-17 09:13:43.958295	\N	$2a$12$wiPSPizVk3n6xnlGw03AsOhCGWZdYAq62sTYslHmkvck5E0fnrFg2	store_admin	super_admin	\N	t	t	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	{"dashboard":{"view":true},"bookings":{"view":true,"create":true,"update":true},"expenses":{"view":true,"create":true,"update":true,"delete":true},"inventory":{"view":true,"create":true,"update":true},"stock_transfers":{"view":true,"create":true}}	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	4	{"can_manage_inventory":true,"can_create_bookings":true,"can_view_reports":true,"can_request_transfers":true}	\N
99	assa	sa	9093939393fdasfds@gmail.com	+91 91010 10101	2026-05-17 09:14:09.720863	2026-05-17 09:14:09.720863	\N	$2a$12$Dv4sZ5U9KgzU22bHtAowJeq93.xmVktE3l.VjZIAi1AY4BtGmgnxu	store_admin	super_admin	\N	t	t	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	{"dashboard":{"view":true},"bookings":{"view":true,"create":true,"update":true},"expenses":{"view":true,"create":true,"update":true,"delete":true},"inventory":{"view":true,"create":true,"update":true},"stock_transfers":{"view":true,"create":true}}	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	4	{"can_manage_inventory":true,"can_create_bookings":true,"can_view_reports":true,"can_request_transfers":true}	\N
106	Amit	Nair	admin.dsdsds8698@store.local	7118955214	2026-05-17 09:41:01.612666	2026-05-17 09:41:01.612666	\N	$2a$12$6qw4CZcBB4Xyv90EzTNLAuN/rTiH0.wK2PpULjWowCHjbhz6qTsFa	store_admin	super_admin	\N	t	t	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	{"dashboard":{"view":true},"bookings":{"view":true,"create":true,"update":true},"expenses":{"view":true,"create":true,"update":true,"delete":true},"inventory":{"view":true,"create":true,"update":true},"stock_transfers":{"view":true,"create":true}}	\N	0	\N	\N	f	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	13	{"can_manage_inventory":true,"can_create_bookings":true,"can_view_reports":true,"can_request_transfers":true}	\N
\.


--
-- Data for Name: vendor_invoices; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.vendor_invoices (id, vendor_purchase_id, invoice_number, total_amount, status, invoice_date, share_token, notes, created_at, updated_at) FROM stdin;
3	11	VI20260326-0001	46.0	1	2026-03-26	AEfT0PcWVJaJtc7PmF6WAzEzLHlsUca3o4Vb7ehBfo0	Invoice generated for vendor purchase #VP000011	2026-03-26 06:47:28.932104	2026-03-26 06:47:28.932104
4	12	VI20260326-0002	12.0	1	2026-03-26	V2XhkXqkVCocLtkav8p5EziUXWHqtA1ak_6tvHcQV-8	Invoice generated for vendor purchase #VP000012	2026-03-26 07:20:44.720248	2026-03-26 07:20:44.720248
\.


--
-- Data for Name: vendor_payments; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.vendor_payments (id, vendor_id, vendor_purchase_id, amount_paid, payment_date, payment_mode, notes, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: vendor_purchase_items; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.vendor_purchase_items (id, vendor_purchase_id, product_id, quantity, purchase_price, selling_price, line_total, created_at, updated_at) FROM stdin;
11	11	37	2.0	23.0	455.0	46.0	2026-03-26 06:45:46.787441	2026-03-26 06:45:46.787441
12	12	42	3.0	4.0	344.0	12.0	2026-03-26 07:19:47.428106	2026-03-26 07:19:47.428106
\.


--
-- Data for Name: vendor_purchases; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.vendor_purchases (id, vendor_id, purchase_date, total_amount, paid_amount, status, notes, created_at, updated_at) FROM stdin;
11	11	2026-03-26	46.0	46.0	completed	sd	2026-03-26 06:45:46.532347	2026-03-26 06:47:52.737148
12	11	2026-03-26	12.0	0.0	completed	sd	2026-03-26 07:19:45.714883	2026-03-26 07:20:11.425749
\.


--
-- Data for Name: vendors; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.vendors (id, name, phone, email, address, payment_type, opening_balance, status, created_at, updated_at) FROM stdin;
11	System Default	0000000000	system@default.com	System Generated	Cash	\N	t	2026-03-19 08:25:49.567116	2026-03-19 08:25:49.567116
\.


--
-- Data for Name: wallet_transactions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.wallet_transactions (id, customer_wallet_id, transaction_type, amount, balance_after, description, reference_number, metadata, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: wishlists; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.wishlists (id, customer_id, product_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.active_storage_attachments_id_seq', 26, true);


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.active_storage_blobs_id_seq', 26, true);


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.active_storage_variant_records_id_seq', 1, false);


--
-- Name: affiliates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.affiliates_id_seq', 12, true);


--
-- Name: banners_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.banners_id_seq', 6, true);


--
-- Name: booking_invoices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.booking_invoices_id_seq', 37, true);


--
-- Name: booking_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.booking_items_id_seq', 263, true);


--
-- Name: booking_schedules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.booking_schedules_id_seq', 1, false);


--
-- Name: bookings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.bookings_id_seq', 216, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.categories_id_seq', 15, true);


--
-- Name: client_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.client_requests_id_seq', 6, true);


--
-- Name: coupons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.coupons_id_seq', 1, false);


--
-- Name: customer_addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.customer_addresses_id_seq', 2, true);


--
-- Name: customer_formats_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.customer_formats_id_seq', 320, true);


--
-- Name: customer_wallets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.customer_wallets_id_seq', 1, false);


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.customers_id_seq', 536, true);


--
-- Name: delivery_charges_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.delivery_charges_id_seq', 7, true);


--
-- Name: delivery_people_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.delivery_people_id_seq', 17, true);


--
-- Name: delivery_rules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.delivery_rules_id_seq', 102, true);


--
-- Name: device_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.device_tokens_id_seq', 1, false);


--
-- Name: expenses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.expenses_id_seq', 1, true);


--
-- Name: franchises_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.franchises_id_seq', 12, true);


--
-- Name: invoice_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.invoice_items_id_seq', 410, true);


--
-- Name: invoices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.invoices_id_seq', 319, true);


--
-- Name: leads_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.leads_id_seq', 1, false);


--
-- Name: milk_delivery_tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.milk_delivery_tasks_id_seq', 9463, true);


--
-- Name: milk_subscriptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.milk_subscriptions_id_seq', 335, true);


--
-- Name: notes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.notes_id_seq', 28, true);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.notifications_id_seq', 1, false);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.order_items_id_seq', 1, false);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.orders_id_seq', 1, false);


--
-- Name: pending_amounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.pending_amounts_id_seq', 32, true);


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.permissions_id_seq', 1, false);


--
-- Name: product_ratings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_ratings_id_seq', 1, false);


--
-- Name: product_reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_reviews_id_seq', 1, false);


--
-- Name: product_variants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_variants_id_seq', 12, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.products_id_seq', 106, true);


--
-- Name: referrals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.referrals_id_seq', 8, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.roles_id_seq', 7, true);


--
-- Name: sale_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.sale_items_id_seq', 33, true);


--
-- Name: solid_cache_entries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.solid_cache_entries_id_seq', 69, true);


--
-- Name: solid_queue_blocked_executions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.solid_queue_blocked_executions_id_seq', 1, false);


--
-- Name: solid_queue_claimed_executions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.solid_queue_claimed_executions_id_seq', 1, false);


--
-- Name: solid_queue_failed_executions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.solid_queue_failed_executions_id_seq', 1, false);


--
-- Name: solid_queue_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.solid_queue_jobs_id_seq', 37, true);


--
-- Name: solid_queue_pauses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.solid_queue_pauses_id_seq', 1, false);


--
-- Name: solid_queue_processes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.solid_queue_processes_id_seq', 1, false);


--
-- Name: solid_queue_ready_executions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.solid_queue_ready_executions_id_seq', 37, true);


--
-- Name: solid_queue_recurring_executions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.solid_queue_recurring_executions_id_seq', 1, false);


--
-- Name: solid_queue_recurring_tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.solid_queue_recurring_tasks_id_seq', 1, false);


--
-- Name: solid_queue_scheduled_executions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.solid_queue_scheduled_executions_id_seq', 1, false);


--
-- Name: solid_queue_semaphores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.solid_queue_semaphores_id_seq', 1, false);


--
-- Name: stock_batches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.stock_batches_id_seq', 114, true);


--
-- Name: stock_movements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.stock_movements_id_seq', 365, true);


--
-- Name: stock_transfers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.stock_transfers_id_seq', 9, true);


--
-- Name: stores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.stores_id_seq', 13, true);


--
-- Name: sub_agents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.sub_agents_id_seq', 1, false);


--
-- Name: subscription_templates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.subscription_templates_id_seq', 1, false);


--
-- Name: system_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.system_settings_id_seq', 4, true);


--
-- Name: user_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_roles_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 106, true);


--
-- Name: vendor_invoices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.vendor_invoices_id_seq', 4, true);


--
-- Name: vendor_payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.vendor_payments_id_seq', 1, false);


--
-- Name: vendor_purchase_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.vendor_purchase_items_id_seq', 12, true);


--
-- Name: vendor_purchases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.vendor_purchases_id_seq', 12, true);


--
-- Name: vendors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.vendors_id_seq', 11, true);


--
-- Name: wallet_transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.wallet_transactions_id_seq', 1, false);


--
-- Name: wishlists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.wishlists_id_seq', 1, false);


--
-- Name: active_storage_attachments active_storage_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT active_storage_attachments_pkey PRIMARY KEY (id);


--
-- Name: active_storage_blobs active_storage_blobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_blobs
    ADD CONSTRAINT active_storage_blobs_pkey PRIMARY KEY (id);


--
-- Name: active_storage_variant_records active_storage_variant_records_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT active_storage_variant_records_pkey PRIMARY KEY (id);


--
-- Name: affiliates affiliates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.affiliates
    ADD CONSTRAINT affiliates_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: banners banners_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.banners
    ADD CONSTRAINT banners_pkey PRIMARY KEY (id);


--
-- Name: booking_invoices booking_invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_invoices
    ADD CONSTRAINT booking_invoices_pkey PRIMARY KEY (id);


--
-- Name: booking_items booking_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_items
    ADD CONSTRAINT booking_items_pkey PRIMARY KEY (id);


--
-- Name: booking_schedules booking_schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_schedules
    ADD CONSTRAINT booking_schedules_pkey PRIMARY KEY (id);


--
-- Name: bookings bookings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: client_requests client_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_requests
    ADD CONSTRAINT client_requests_pkey PRIMARY KEY (id);


--
-- Name: coupons coupons_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupons
    ADD CONSTRAINT coupons_pkey PRIMARY KEY (id);


--
-- Name: customer_addresses customer_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_addresses
    ADD CONSTRAINT customer_addresses_pkey PRIMARY KEY (id);


--
-- Name: customer_formats customer_formats_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_formats
    ADD CONSTRAINT customer_formats_pkey PRIMARY KEY (id);


--
-- Name: customer_wallets customer_wallets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_wallets
    ADD CONSTRAINT customer_wallets_pkey PRIMARY KEY (id);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: delivery_charges delivery_charges_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_charges
    ADD CONSTRAINT delivery_charges_pkey PRIMARY KEY (id);


--
-- Name: delivery_people delivery_people_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_people
    ADD CONSTRAINT delivery_people_pkey PRIMARY KEY (id);


--
-- Name: delivery_rules delivery_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_rules
    ADD CONSTRAINT delivery_rules_pkey PRIMARY KEY (id);


--
-- Name: device_tokens device_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.device_tokens
    ADD CONSTRAINT device_tokens_pkey PRIMARY KEY (id);


--
-- Name: expenses expenses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_pkey PRIMARY KEY (id);


--
-- Name: franchises franchises_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.franchises
    ADD CONSTRAINT franchises_pkey PRIMARY KEY (id);


--
-- Name: invoice_items invoice_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoice_items
    ADD CONSTRAINT invoice_items_pkey PRIMARY KEY (id);


--
-- Name: invoices invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_pkey PRIMARY KEY (id);


--
-- Name: leads leads_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.leads
    ADD CONSTRAINT leads_pkey PRIMARY KEY (id);


--
-- Name: milk_delivery_tasks milk_delivery_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.milk_delivery_tasks
    ADD CONSTRAINT milk_delivery_tasks_pkey PRIMARY KEY (id);


--
-- Name: milk_subscriptions milk_subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.milk_subscriptions
    ADD CONSTRAINT milk_subscriptions_pkey PRIMARY KEY (id);


--
-- Name: notes notes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: pending_amounts pending_amounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pending_amounts
    ADD CONSTRAINT pending_amounts_pkey PRIMARY KEY (id);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- Name: product_ratings product_ratings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_ratings
    ADD CONSTRAINT product_ratings_pkey PRIMARY KEY (id);


--
-- Name: product_reviews product_reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_reviews
    ADD CONSTRAINT product_reviews_pkey PRIMARY KEY (id);


--
-- Name: product_variants product_variants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variants
    ADD CONSTRAINT product_variants_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: referrals referrals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.referrals
    ADD CONSTRAINT referrals_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: sale_items sale_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sale_items
    ADD CONSTRAINT sale_items_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: solid_cache_entries solid_cache_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_cache_entries
    ADD CONSTRAINT solid_cache_entries_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_blocked_executions solid_queue_blocked_executions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_blocked_executions
    ADD CONSTRAINT solid_queue_blocked_executions_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_claimed_executions solid_queue_claimed_executions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_claimed_executions
    ADD CONSTRAINT solid_queue_claimed_executions_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_failed_executions solid_queue_failed_executions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_failed_executions
    ADD CONSTRAINT solid_queue_failed_executions_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_jobs solid_queue_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_jobs
    ADD CONSTRAINT solid_queue_jobs_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_pauses solid_queue_pauses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_pauses
    ADD CONSTRAINT solid_queue_pauses_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_processes solid_queue_processes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_processes
    ADD CONSTRAINT solid_queue_processes_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_ready_executions solid_queue_ready_executions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_ready_executions
    ADD CONSTRAINT solid_queue_ready_executions_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_recurring_executions solid_queue_recurring_executions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_recurring_executions
    ADD CONSTRAINT solid_queue_recurring_executions_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_recurring_tasks solid_queue_recurring_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_recurring_tasks
    ADD CONSTRAINT solid_queue_recurring_tasks_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_scheduled_executions solid_queue_scheduled_executions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_scheduled_executions
    ADD CONSTRAINT solid_queue_scheduled_executions_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_semaphores solid_queue_semaphores_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_semaphores
    ADD CONSTRAINT solid_queue_semaphores_pkey PRIMARY KEY (id);


--
-- Name: stock_batches stock_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock_batches
    ADD CONSTRAINT stock_batches_pkey PRIMARY KEY (id);


--
-- Name: stock_movements stock_movements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock_movements
    ADD CONSTRAINT stock_movements_pkey PRIMARY KEY (id);


--
-- Name: stock_transfers stock_transfers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock_transfers
    ADD CONSTRAINT stock_transfers_pkey PRIMARY KEY (id);


--
-- Name: stores stores_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stores
    ADD CONSTRAINT stores_pkey PRIMARY KEY (id);


--
-- Name: sub_agents sub_agents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sub_agents
    ADD CONSTRAINT sub_agents_pkey PRIMARY KEY (id);


--
-- Name: subscription_templates subscription_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subscription_templates
    ADD CONSTRAINT subscription_templates_pkey PRIMARY KEY (id);


--
-- Name: system_settings system_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.system_settings
    ADD CONSTRAINT system_settings_pkey PRIMARY KEY (id);


--
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: vendor_invoices vendor_invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vendor_invoices
    ADD CONSTRAINT vendor_invoices_pkey PRIMARY KEY (id);


--
-- Name: vendor_payments vendor_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vendor_payments
    ADD CONSTRAINT vendor_payments_pkey PRIMARY KEY (id);


--
-- Name: vendor_purchase_items vendor_purchase_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vendor_purchase_items
    ADD CONSTRAINT vendor_purchase_items_pkey PRIMARY KEY (id);


--
-- Name: vendor_purchases vendor_purchases_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vendor_purchases
    ADD CONSTRAINT vendor_purchases_pkey PRIMARY KEY (id);


--
-- Name: vendors vendors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vendors
    ADD CONSTRAINT vendors_pkey PRIMARY KEY (id);


--
-- Name: wallet_transactions wallet_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wallet_transactions
    ADD CONSTRAINT wallet_transactions_pkey PRIMARY KEY (id);


--
-- Name: wishlists wishlists_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wishlists
    ADD CONSTRAINT wishlists_pkey PRIMARY KEY (id);


--
-- Name: idx_milk_subscriptions_dates; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_milk_subscriptions_dates ON public.milk_subscriptions USING btree (start_date, end_date);


--
-- Name: idx_milk_subscriptions_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_milk_subscriptions_status ON public.milk_subscriptions USING btree (status);


--
-- Name: idx_on_delivery_person_id_delivery_date_8b580f1b82; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_on_delivery_person_id_delivery_date_8b580f1b82 ON public.milk_delivery_tasks USING btree (delivery_person_id, delivery_date);


--
-- Name: idx_stock_movements_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_stock_movements_created_at ON public.stock_movements USING btree (created_at);


--
-- Name: idx_stock_movements_movement_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_stock_movements_movement_type ON public.stock_movements USING btree (movement_type);


--
-- Name: idx_stock_movements_product_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_stock_movements_product_created ON public.stock_movements USING btree (product_id, created_at);


--
-- Name: idx_stock_movements_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_stock_movements_product_id ON public.stock_movements USING btree (product_id);


--
-- Name: idx_stock_movements_ref_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_stock_movements_ref_type_id ON public.stock_movements USING btree (reference_type, reference_id);


--
-- Name: index_active_storage_attachments_on_blob_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_storage_attachments_on_blob_id ON public.active_storage_attachments USING btree (blob_id);


--
-- Name: index_active_storage_attachments_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_attachments_uniqueness ON public.active_storage_attachments USING btree (record_type, record_id, name, blob_id);


--
-- Name: index_active_storage_blobs_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_blobs_on_key ON public.active_storage_blobs USING btree (key);


--
-- Name: index_active_storage_variant_records_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_variant_records_uniqueness ON public.active_storage_variant_records USING btree (blob_id, variation_digest);


--
-- Name: index_affiliates_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_affiliates_on_email ON public.affiliates USING btree (email);


--
-- Name: index_affiliates_on_mobile; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_affiliates_on_mobile ON public.affiliates USING btree (mobile);


--
-- Name: index_banners_on_display_location; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_banners_on_display_location ON public.banners USING btree (display_location);


--
-- Name: index_banners_on_display_order; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_banners_on_display_order ON public.banners USING btree (display_order);


--
-- Name: index_banners_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_banners_on_status ON public.banners USING btree (status);


--
-- Name: index_booking_invoices_on_booking_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_booking_invoices_on_booking_id ON public.booking_invoices USING btree (booking_id);


--
-- Name: index_booking_invoices_on_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_booking_invoices_on_customer_id ON public.booking_invoices USING btree (customer_id);


--
-- Name: index_booking_invoices_on_invoice_number; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_booking_invoices_on_invoice_number ON public.booking_invoices USING btree (invoice_number);


--
-- Name: index_booking_invoices_on_share_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_booking_invoices_on_share_token ON public.booking_invoices USING btree (share_token);


--
-- Name: index_booking_items_on_product_variant_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_booking_items_on_product_variant_id ON public.booking_items USING btree (product_variant_id);


--
-- Name: index_booking_schedules_on_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_booking_schedules_on_customer_id ON public.booking_schedules USING btree (customer_id);


--
-- Name: index_booking_schedules_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_booking_schedules_on_product_id ON public.booking_schedules USING btree (product_id);


--
-- Name: index_bookings_on_booked_by; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bookings_on_booked_by ON public.bookings USING btree (booked_by);


--
-- Name: index_bookings_on_booking_schedule_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bookings_on_booking_schedule_id ON public.bookings USING btree (booking_schedule_id);


--
-- Name: index_bookings_on_cashfree_order_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bookings_on_cashfree_order_id ON public.bookings USING btree (cashfree_order_id);


--
-- Name: index_bookings_on_cashfree_payment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bookings_on_cashfree_payment_id ON public.bookings USING btree (cashfree_payment_id);


--
-- Name: index_bookings_on_courier_service; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bookings_on_courier_service ON public.bookings USING btree (courier_service);


--
-- Name: index_bookings_on_delivery_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bookings_on_delivery_person_id ON public.bookings USING btree (delivery_person_id);


--
-- Name: index_bookings_on_delivery_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bookings_on_delivery_time ON public.bookings USING btree (delivery_time);


--
-- Name: index_bookings_on_expected_delivery_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bookings_on_expected_delivery_date ON public.bookings USING btree (expected_delivery_date);


--
-- Name: index_bookings_on_franchise_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bookings_on_franchise_id ON public.bookings USING btree (franchise_id);


--
-- Name: index_bookings_on_payment_gateway; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bookings_on_payment_gateway ON public.bookings USING btree (payment_gateway);


--
-- Name: index_bookings_on_stage_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bookings_on_stage_updated_at ON public.bookings USING btree (stage_updated_at);


--
-- Name: index_bookings_on_stage_updated_by; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bookings_on_stage_updated_by ON public.bookings USING btree (stage_updated_by);


--
-- Name: index_bookings_on_store_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bookings_on_store_id ON public.bookings USING btree (store_id);


--
-- Name: index_bookings_on_tracking_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bookings_on_tracking_number ON public.bookings USING btree (tracking_number);


--
-- Name: index_categories_on_display_order; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_categories_on_display_order ON public.categories USING btree (display_order);


--
-- Name: index_categories_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_categories_on_status ON public.categories USING btree (status);


--
-- Name: index_client_requests_on_assignee_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_client_requests_on_assignee_id ON public.client_requests USING btree (assignee_id);


--
-- Name: index_client_requests_on_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_client_requests_on_customer_id ON public.client_requests USING btree (customer_id);


--
-- Name: index_client_requests_on_department; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_client_requests_on_department ON public.client_requests USING btree (department);


--
-- Name: index_client_requests_on_estimated_resolution_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_client_requests_on_estimated_resolution_time ON public.client_requests USING btree (estimated_resolution_time);


--
-- Name: index_client_requests_on_stage; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_client_requests_on_stage ON public.client_requests USING btree (stage);


--
-- Name: index_client_requests_on_ticket_number; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_client_requests_on_ticket_number ON public.client_requests USING btree (ticket_number);


--
-- Name: index_coupons_on_code; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_coupons_on_code ON public.coupons USING btree (code);


--
-- Name: index_customer_addresses_on_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_customer_addresses_on_customer_id ON public.customer_addresses USING btree (customer_id);


--
-- Name: index_customer_formats_on_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_customer_formats_on_customer_id ON public.customer_formats USING btree (customer_id);


--
-- Name: index_customer_formats_on_delivery_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_customer_formats_on_delivery_person_id ON public.customer_formats USING btree (delivery_person_id);


--
-- Name: index_customer_formats_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_customer_formats_on_product_id ON public.customer_formats USING btree (product_id);


--
-- Name: index_customer_wallets_on_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_customer_wallets_on_customer_id ON public.customer_wallets USING btree (customer_id);


--
-- Name: index_customers_on_location; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_customers_on_location ON public.customers USING btree (latitude, longitude);


--
-- Name: index_customers_on_whatsapp_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_customers_on_whatsapp_number ON public.customers USING btree (whatsapp_number);


--
-- Name: index_delivery_charges_on_is_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_delivery_charges_on_is_active ON public.delivery_charges USING btree (is_active);


--
-- Name: index_delivery_charges_on_pincode; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_delivery_charges_on_pincode ON public.delivery_charges USING btree (pincode);


--
-- Name: index_delivery_rules_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_delivery_rules_on_product_id ON public.delivery_rules USING btree (product_id);


--
-- Name: index_delivery_rules_on_rule_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_delivery_rules_on_rule_type ON public.delivery_rules USING btree (rule_type);


--
-- Name: index_device_tokens_on_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_device_tokens_on_customer_id ON public.device_tokens USING btree (customer_id);


--
-- Name: index_device_tokens_on_delivery_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_device_tokens_on_delivery_person_id ON public.device_tokens USING btree (delivery_person_id);


--
-- Name: index_expenses_on_category; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_expenses_on_category ON public.expenses USING btree (category);


--
-- Name: index_expenses_on_created_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_expenses_on_created_by_id ON public.expenses USING btree (created_by_id);


--
-- Name: index_expenses_on_store_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_expenses_on_store_id ON public.expenses USING btree (store_id);


--
-- Name: index_expenses_on_store_id_and_expense_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_expenses_on_store_id_and_expense_date ON public.expenses USING btree (store_id, expense_date);


--
-- Name: index_franchises_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_franchises_on_email ON public.franchises USING btree (email);


--
-- Name: index_franchises_on_mobile; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_franchises_on_mobile ON public.franchises USING btree (mobile);


--
-- Name: index_franchises_on_pan_no; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_franchises_on_pan_no ON public.franchises USING btree (pan_no);


--
-- Name: index_franchises_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_franchises_on_user_id ON public.franchises USING btree (user_id);


--
-- Name: index_invoice_items_on_invoice_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_invoice_items_on_invoice_id ON public.invoice_items USING btree (invoice_id);


--
-- Name: index_invoice_items_on_milk_delivery_task_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_invoice_items_on_milk_delivery_task_id ON public.invoice_items USING btree (milk_delivery_task_id);


--
-- Name: index_invoice_items_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_invoice_items_on_product_id ON public.invoice_items USING btree (product_id);


--
-- Name: index_invoices_on_invoice_number; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_invoices_on_invoice_number ON public.invoices USING btree (invoice_number);


--
-- Name: index_invoices_on_share_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_invoices_on_share_token ON public.invoices USING btree (share_token);


--
-- Name: index_milk_delivery_tasks_on_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_milk_delivery_tasks_on_customer_id ON public.milk_delivery_tasks USING btree (customer_id);


--
-- Name: index_milk_delivery_tasks_on_customer_id_and_delivery_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_milk_delivery_tasks_on_customer_id_and_delivery_date ON public.milk_delivery_tasks USING btree (customer_id, delivery_date);


--
-- Name: index_milk_delivery_tasks_on_delivery_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_milk_delivery_tasks_on_delivery_date ON public.milk_delivery_tasks USING btree (delivery_date);


--
-- Name: index_milk_delivery_tasks_on_delivery_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_milk_delivery_tasks_on_delivery_person_id ON public.milk_delivery_tasks USING btree (delivery_person_id);


--
-- Name: index_milk_delivery_tasks_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_milk_delivery_tasks_on_product_id ON public.milk_delivery_tasks USING btree (product_id);


--
-- Name: index_milk_delivery_tasks_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_milk_delivery_tasks_on_status ON public.milk_delivery_tasks USING btree (status);


--
-- Name: index_milk_delivery_tasks_on_subscription_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_milk_delivery_tasks_on_subscription_id ON public.milk_delivery_tasks USING btree (subscription_id);


--
-- Name: index_milk_subscriptions_on_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_milk_subscriptions_on_customer_id ON public.milk_subscriptions USING btree (customer_id);


--
-- Name: index_milk_subscriptions_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_milk_subscriptions_on_product_id ON public.milk_subscriptions USING btree (product_id);


--
-- Name: index_notes_on_created_by_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notes_on_created_by_user_id ON public.notes USING btree (created_by_user_id);


--
-- Name: index_notes_on_note_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notes_on_note_date ON public.notes USING btree (note_date);


--
-- Name: index_notes_on_payment_method; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notes_on_payment_method ON public.notes USING btree (payment_method);


--
-- Name: index_notes_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notes_on_status ON public.notes USING btree (status);


--
-- Name: index_notifications_on_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notifications_on_customer_id ON public.notifications USING btree (customer_id);


--
-- Name: index_order_items_on_product_variant_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_order_items_on_product_variant_id ON public.order_items USING btree (product_variant_id);


--
-- Name: index_orders_on_booking_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_orders_on_booking_id ON public.orders USING btree (booking_id);


--
-- Name: index_pending_amounts_on_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pending_amounts_on_customer_id ON public.pending_amounts USING btree (customer_id);


--
-- Name: index_permissions_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_permissions_on_name ON public.permissions USING btree (name);


--
-- Name: index_permissions_on_resource_and_action; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_permissions_on_resource_and_action ON public.permissions USING btree (resource, action);


--
-- Name: index_product_ratings_on_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_ratings_on_customer_id ON public.product_ratings USING btree (customer_id);


--
-- Name: index_product_ratings_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_ratings_on_product_id ON public.product_ratings USING btree (product_id);


--
-- Name: index_product_ratings_on_product_id_and_rating; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_ratings_on_product_id_and_rating ON public.product_ratings USING btree (product_id, rating);


--
-- Name: index_product_ratings_on_product_id_and_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_ratings_on_product_id_and_status ON public.product_ratings USING btree (product_id, status);


--
-- Name: index_product_ratings_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_ratings_on_user_id ON public.product_ratings USING btree (user_id);


--
-- Name: index_product_reviews_on_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_reviews_on_customer_id ON public.product_reviews USING btree (customer_id);


--
-- Name: index_product_reviews_on_customer_id_and_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_product_reviews_on_customer_id_and_product_id ON public.product_reviews USING btree (customer_id, product_id) WHERE (customer_id IS NOT NULL);


--
-- Name: index_product_reviews_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_reviews_on_product_id ON public.product_reviews USING btree (product_id);


--
-- Name: index_product_reviews_on_product_id_and_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_reviews_on_product_id_and_created_at ON public.product_reviews USING btree (product_id, created_at);


--
-- Name: index_product_reviews_on_product_id_and_rating; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_reviews_on_product_id_and_rating ON public.product_reviews USING btree (product_id, rating);


--
-- Name: index_product_reviews_on_product_id_and_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_reviews_on_product_id_and_status ON public.product_reviews USING btree (product_id, status);


--
-- Name: index_product_reviews_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_reviews_on_user_id ON public.product_reviews USING btree (user_id);


--
-- Name: index_product_variants_on_is_default; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_variants_on_is_default ON public.product_variants USING btree (is_default);


--
-- Name: index_product_variants_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_variants_on_product_id ON public.product_variants USING btree (product_id);


--
-- Name: index_product_variants_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_product_variants_uniqueness ON public.product_variants USING btree (product_id, weight, unit);


--
-- Name: index_products_on_barcode; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_products_on_barcode ON public.products USING btree (barcode);


--
-- Name: index_products_on_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_products_on_category_id ON public.products USING btree (category_id);


--
-- Name: index_products_on_is_occasional_product; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_products_on_is_occasional_product ON public.products USING btree (is_occasional_product);


--
-- Name: index_products_on_is_subscription_enabled; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_products_on_is_subscription_enabled ON public.products USING btree (is_subscription_enabled);


--
-- Name: index_products_on_last_price_update; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_products_on_last_price_update ON public.products USING btree (last_price_update);


--
-- Name: index_products_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_products_on_name ON public.products USING btree (name);


--
-- Name: index_products_on_occasional_dates; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_products_on_occasional_dates ON public.products USING btree (is_occasional_product, occasional_start_date, occasional_end_date);


--
-- Name: index_products_on_product_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_products_on_product_type ON public.products USING btree (product_type);


--
-- Name: index_products_on_sku; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_products_on_sku ON public.products USING btree (sku);


--
-- Name: index_products_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_products_on_status ON public.products USING btree (status);


--
-- Name: index_referrals_on_affiliate_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_referrals_on_affiliate_id ON public.referrals USING btree (affiliate_id);


--
-- Name: index_referrals_on_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_referrals_on_customer_id ON public.referrals USING btree (customer_id);


--
-- Name: index_referrals_on_referral_source; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_referrals_on_referral_source ON public.referrals USING btree (referral_source);


--
-- Name: index_referrals_on_referring_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_referrals_on_referring_customer_id ON public.referrals USING btree (referring_customer_id);


--
-- Name: index_roles_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_roles_on_name ON public.roles USING btree (name);


--
-- Name: index_sale_items_on_booking_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_sale_items_on_booking_id ON public.sale_items USING btree (booking_id);


--
-- Name: index_sale_items_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_sale_items_on_product_id ON public.sale_items USING btree (product_id);


--
-- Name: index_sale_items_on_stock_batch_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_sale_items_on_stock_batch_id ON public.sale_items USING btree (stock_batch_id);


--
-- Name: index_solid_cache_entries_on_byte_size; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_cache_entries_on_byte_size ON public.solid_cache_entries USING btree (byte_size);


--
-- Name: index_solid_cache_entries_on_key_hash; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_solid_cache_entries_on_key_hash ON public.solid_cache_entries USING btree (key_hash);


--
-- Name: index_solid_cache_entries_on_key_hash_and_byte_size; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_cache_entries_on_key_hash_and_byte_size ON public.solid_cache_entries USING btree (key_hash, byte_size);


--
-- Name: index_solid_queue_blocked_executions_for_maintenance; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_queue_blocked_executions_for_maintenance ON public.solid_queue_blocked_executions USING btree (expires_at, concurrency_key);


--
-- Name: index_solid_queue_blocked_executions_for_release; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_queue_blocked_executions_for_release ON public.solid_queue_blocked_executions USING btree (concurrency_key, priority, job_id);


--
-- Name: index_solid_queue_blocked_executions_on_job_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_solid_queue_blocked_executions_on_job_id ON public.solid_queue_blocked_executions USING btree (job_id);


--
-- Name: index_solid_queue_claimed_executions_on_job_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_solid_queue_claimed_executions_on_job_id ON public.solid_queue_claimed_executions USING btree (job_id);


--
-- Name: index_solid_queue_claimed_executions_on_process_id_and_job_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_queue_claimed_executions_on_process_id_and_job_id ON public.solid_queue_claimed_executions USING btree (process_id, job_id);


--
-- Name: index_solid_queue_dispatch_all; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_queue_dispatch_all ON public.solid_queue_scheduled_executions USING btree (scheduled_at, priority, job_id);


--
-- Name: index_solid_queue_failed_executions_on_job_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_solid_queue_failed_executions_on_job_id ON public.solid_queue_failed_executions USING btree (job_id);


--
-- Name: index_solid_queue_jobs_for_alerting; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_queue_jobs_for_alerting ON public.solid_queue_jobs USING btree (scheduled_at, finished_at);


--
-- Name: index_solid_queue_jobs_for_filtering; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_queue_jobs_for_filtering ON public.solid_queue_jobs USING btree (queue_name, finished_at);


--
-- Name: index_solid_queue_jobs_on_active_job_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_queue_jobs_on_active_job_id ON public.solid_queue_jobs USING btree (active_job_id);


--
-- Name: index_solid_queue_jobs_on_class_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_queue_jobs_on_class_name ON public.solid_queue_jobs USING btree (class_name);


--
-- Name: index_solid_queue_jobs_on_finished_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_queue_jobs_on_finished_at ON public.solid_queue_jobs USING btree (finished_at);


--
-- Name: index_solid_queue_pauses_on_queue_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_solid_queue_pauses_on_queue_name ON public.solid_queue_pauses USING btree (queue_name);


--
-- Name: index_solid_queue_poll_all; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_queue_poll_all ON public.solid_queue_ready_executions USING btree (priority, job_id);


--
-- Name: index_solid_queue_poll_by_queue; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_queue_poll_by_queue ON public.solid_queue_ready_executions USING btree (queue_name, priority, job_id);


--
-- Name: index_solid_queue_processes_on_last_heartbeat_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_queue_processes_on_last_heartbeat_at ON public.solid_queue_processes USING btree (last_heartbeat_at);


--
-- Name: index_solid_queue_processes_on_name_and_supervisor_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_solid_queue_processes_on_name_and_supervisor_id ON public.solid_queue_processes USING btree (name, supervisor_id);


--
-- Name: index_solid_queue_processes_on_supervisor_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_queue_processes_on_supervisor_id ON public.solid_queue_processes USING btree (supervisor_id);


--
-- Name: index_solid_queue_ready_executions_on_job_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_solid_queue_ready_executions_on_job_id ON public.solid_queue_ready_executions USING btree (job_id);


--
-- Name: index_solid_queue_recurring_executions_on_job_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_solid_queue_recurring_executions_on_job_id ON public.solid_queue_recurring_executions USING btree (job_id);


--
-- Name: index_solid_queue_recurring_executions_on_task_key_and_run_at; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_solid_queue_recurring_executions_on_task_key_and_run_at ON public.solid_queue_recurring_executions USING btree (task_key, run_at);


--
-- Name: index_solid_queue_recurring_tasks_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_solid_queue_recurring_tasks_on_key ON public.solid_queue_recurring_tasks USING btree (key);


--
-- Name: index_solid_queue_recurring_tasks_on_static; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_queue_recurring_tasks_on_static ON public.solid_queue_recurring_tasks USING btree (static);


--
-- Name: index_solid_queue_scheduled_executions_on_job_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_solid_queue_scheduled_executions_on_job_id ON public.solid_queue_scheduled_executions USING btree (job_id);


--
-- Name: index_solid_queue_semaphores_on_expires_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_queue_semaphores_on_expires_at ON public.solid_queue_semaphores USING btree (expires_at);


--
-- Name: index_solid_queue_semaphores_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_solid_queue_semaphores_on_key ON public.solid_queue_semaphores USING btree (key);


--
-- Name: index_solid_queue_semaphores_on_key_and_value; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_queue_semaphores_on_key_and_value ON public.solid_queue_semaphores USING btree (key, value);


--
-- Name: index_stock_batches_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stock_batches_on_product_id ON public.stock_batches USING btree (product_id);


--
-- Name: index_stock_batches_on_product_id_and_store_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stock_batches_on_product_id_and_store_id ON public.stock_batches USING btree (product_id, store_id);


--
-- Name: index_stock_batches_on_store_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stock_batches_on_store_id ON public.stock_batches USING btree (store_id);


--
-- Name: index_stock_batches_on_vendor_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stock_batches_on_vendor_id ON public.stock_batches USING btree (vendor_id);


--
-- Name: index_stock_batches_on_vendor_purchase_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stock_batches_on_vendor_purchase_id ON public.stock_batches USING btree (vendor_purchase_id);


--
-- Name: index_stock_movements_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stock_movements_on_product_id ON public.stock_movements USING btree (product_id);


--
-- Name: index_stock_transfers_on_approved_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stock_transfers_on_approved_by_id ON public.stock_transfers USING btree (approved_by_id);


--
-- Name: index_stock_transfers_on_from_store_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stock_transfers_on_from_store_id ON public.stock_transfers USING btree (from_store_id);


--
-- Name: index_stock_transfers_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stock_transfers_on_product_id ON public.stock_transfers USING btree (product_id);


--
-- Name: index_stock_transfers_on_requested_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stock_transfers_on_requested_by_id ON public.stock_transfers USING btree (requested_by_id);


--
-- Name: index_stock_transfers_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stock_transfers_on_status ON public.stock_transfers USING btree (status);


--
-- Name: index_stock_transfers_on_to_store_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stock_transfers_on_to_store_id ON public.stock_transfers USING btree (to_store_id);


--
-- Name: index_stock_transfers_on_transfer_group_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stock_transfers_on_transfer_group_id ON public.stock_transfers USING btree (transfer_group_id);


--
-- Name: index_stores_on_store_admin_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stores_on_store_admin_user_id ON public.stores USING btree (store_admin_user_id);


--
-- Name: index_sub_agents_on_aadhar_no; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_sub_agents_on_aadhar_no ON public.sub_agents USING btree (aadhar_no);


--
-- Name: index_sub_agents_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_sub_agents_on_email ON public.sub_agents USING btree (email);


--
-- Name: index_sub_agents_on_mobile; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_sub_agents_on_mobile ON public.sub_agents USING btree (mobile);


--
-- Name: index_sub_agents_on_pan_no; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_sub_agents_on_pan_no ON public.sub_agents USING btree (pan_no);


--
-- Name: index_subscription_templates_on_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_subscription_templates_on_customer_id ON public.subscription_templates USING btree (customer_id);


--
-- Name: index_subscription_templates_on_delivery_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_subscription_templates_on_delivery_person_id ON public.subscription_templates USING btree (delivery_person_id);


--
-- Name: index_subscription_templates_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_subscription_templates_on_product_id ON public.subscription_templates USING btree (product_id);


--
-- Name: index_system_settings_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_system_settings_on_key ON public.system_settings USING btree (key);


--
-- Name: index_user_roles_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_user_roles_on_name ON public.user_roles USING btree (name);


--
-- Name: index_users_on_aadhar_no; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_aadhar_no ON public.users USING btree (aadhar_no);


--
-- Name: index_users_on_assigned_store_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_assigned_store_id ON public.users USING btree (assigned_store_id);


--
-- Name: index_users_on_authenticatable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_authenticatable ON public.users USING btree (authenticatable_type, authenticatable_id);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON public.users USING btree (confirmation_token);


--
-- Name: index_users_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_deleted_at ON public.users USING btree (deleted_at);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_employee_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_employee_id ON public.users USING btree (employee_id);


--
-- Name: index_users_on_is_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_is_active ON public.users USING btree (is_active);


--
-- Name: index_users_on_mobile; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_mobile ON public.users USING btree (mobile);


--
-- Name: index_users_on_pan_no; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_pan_no ON public.users USING btree (pan_no);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_users_on_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_role ON public.users USING btree (role);


--
-- Name: index_users_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_status ON public.users USING btree (status);


--
-- Name: index_users_on_unlock_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_unlock_token ON public.users USING btree (unlock_token);


--
-- Name: index_users_on_user_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_user_type ON public.users USING btree (user_type);


--
-- Name: index_vendor_invoices_on_invoice_number; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_vendor_invoices_on_invoice_number ON public.vendor_invoices USING btree (invoice_number);


--
-- Name: index_vendor_invoices_on_share_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_vendor_invoices_on_share_token ON public.vendor_invoices USING btree (share_token);


--
-- Name: index_vendor_invoices_on_vendor_purchase_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_vendor_invoices_on_vendor_purchase_id ON public.vendor_invoices USING btree (vendor_purchase_id);


--
-- Name: index_vendor_payments_on_vendor_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_vendor_payments_on_vendor_id ON public.vendor_payments USING btree (vendor_id);


--
-- Name: index_vendor_payments_on_vendor_purchase_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_vendor_payments_on_vendor_purchase_id ON public.vendor_payments USING btree (vendor_purchase_id);


--
-- Name: index_vendor_purchase_items_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_vendor_purchase_items_on_product_id ON public.vendor_purchase_items USING btree (product_id);


--
-- Name: index_vendor_purchase_items_on_vendor_purchase_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_vendor_purchase_items_on_vendor_purchase_id ON public.vendor_purchase_items USING btree (vendor_purchase_id);


--
-- Name: index_vendor_purchases_on_vendor_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_vendor_purchases_on_vendor_id ON public.vendor_purchases USING btree (vendor_id);


--
-- Name: index_wallet_transactions_on_customer_wallet_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_wallet_transactions_on_customer_wallet_id ON public.wallet_transactions USING btree (customer_wallet_id);


--
-- Name: index_wallet_transactions_on_reference_number; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_wallet_transactions_on_reference_number ON public.wallet_transactions USING btree (reference_number);


--
-- Name: index_wallet_transactions_on_transaction_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_wallet_transactions_on_transaction_type ON public.wallet_transactions USING btree (transaction_type);


--
-- Name: index_wishlists_on_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_wishlists_on_customer_id ON public.wishlists USING btree (customer_id);


--
-- Name: index_wishlists_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_wishlists_on_product_id ON public.wishlists USING btree (product_id);


--
-- Name: milk_subscriptions fk_milk_subscriptions_delivery_person; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.milk_subscriptions
    ADD CONSTRAINT fk_milk_subscriptions_delivery_person FOREIGN KEY (delivery_person_id) REFERENCES public.delivery_people(id);


--
-- Name: subscription_templates fk_rails_0427a5a8f5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subscription_templates
    ADD CONSTRAINT fk_rails_0427a5a8f5 FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: booking_invoices fk_rails_0588ce0fe5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_invoices
    ADD CONSTRAINT fk_rails_0588ce0fe5 FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: invoice_items fk_rails_0c6e1fd09e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoice_items
    ADD CONSTRAINT fk_rails_0c6e1fd09e FOREIGN KEY (milk_delivery_task_id) REFERENCES public.milk_delivery_tasks(id);


--
-- Name: stock_batches fk_rails_0fd8722280; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock_batches
    ADD CONSTRAINT fk_rails_0fd8722280 FOREIGN KEY (vendor_purchase_id) REFERENCES public.vendor_purchases(id);


--
-- Name: sale_items fk_rails_10aa153cb0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sale_items
    ADD CONSTRAINT fk_rails_10aa153cb0 FOREIGN KEY (booking_id) REFERENCES public.bookings(id);


--
-- Name: referrals fk_rails_143e21be26; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.referrals
    ADD CONSTRAINT fk_rails_143e21be26 FOREIGN KEY (affiliate_id) REFERENCES public.affiliates(id);


--
-- Name: wishlists fk_rails_18bd87f3b0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wishlists
    ADD CONSTRAINT fk_rails_18bd87f3b0 FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: bookings fk_rails_1a839bd564; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT fk_rails_1a839bd564 FOREIGN KEY (delivery_person_id) REFERENCES public.delivery_people(id);


--
-- Name: vendor_purchase_items fk_rails_1d0b180fcb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vendor_purchase_items
    ADD CONSTRAINT fk_rails_1d0b180fcb FOREIGN KEY (vendor_purchase_id) REFERENCES public.vendor_purchases(id);


--
-- Name: booking_schedules fk_rails_1de48ebd18; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_schedules
    ADD CONSTRAINT fk_rails_1de48ebd18 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: invoice_items fk_rails_25bf3d2c5e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoice_items
    ADD CONSTRAINT fk_rails_25bf3d2c5e FOREIGN KEY (invoice_id) REFERENCES public.invoices(id);


--
-- Name: device_tokens fk_rails_287313072c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.device_tokens
    ADD CONSTRAINT fk_rails_287313072c FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: referrals fk_rails_2a86f7c55b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.referrals
    ADD CONSTRAINT fk_rails_2a86f7c55b FOREIGN KEY (referring_customer_id) REFERENCES public.customers(id);


--
-- Name: vendor_purchase_items fk_rails_2b2646ec33; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vendor_purchase_items
    ADD CONSTRAINT fk_rails_2b2646ec33 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: stock_batches fk_rails_30af726acb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock_batches
    ADD CONSTRAINT fk_rails_30af726acb FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: bookings fk_rails_30b4781a51; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT fk_rails_30b4781a51 FOREIGN KEY (franchise_id) REFERENCES public.franchises(id);


--
-- Name: solid_queue_recurring_executions fk_rails_318a5533ed; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_recurring_executions
    ADD CONSTRAINT fk_rails_318a5533ed FOREIGN KEY (job_id) REFERENCES public.solid_queue_jobs(id) ON DELETE CASCADE;


--
-- Name: milk_delivery_tasks fk_rails_3630bcf24a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.milk_delivery_tasks
    ADD CONSTRAINT fk_rails_3630bcf24a FOREIGN KEY (subscription_id) REFERENCES public.milk_subscriptions(id);


--
-- Name: product_ratings fk_rails_36795236ae; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_ratings
    ADD CONSTRAINT fk_rails_36795236ae FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: milk_delivery_tasks fk_rails_390b1646ed; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.milk_delivery_tasks
    ADD CONSTRAINT fk_rails_390b1646ed FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: solid_queue_failed_executions fk_rails_39bbc7a631; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_failed_executions
    ADD CONSTRAINT fk_rails_39bbc7a631 FOREIGN KEY (job_id) REFERENCES public.solid_queue_jobs(id) ON DELETE CASCADE;


--
-- Name: client_requests fk_rails_3d32864cfc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_requests
    ADD CONSTRAINT fk_rails_3d32864cfc FOREIGN KEY (assignee_id) REFERENCES public.users(id);


--
-- Name: vendor_payments fk_rails_3d8456966c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vendor_payments
    ADD CONSTRAINT fk_rails_3d8456966c FOREIGN KEY (vendor_id) REFERENCES public.vendors(id);


--
-- Name: franchises fk_rails_41d1977e7e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.franchises
    ADD CONSTRAINT fk_rails_41d1977e7e FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: wishlists fk_rails_4224d8f53b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wishlists
    ADD CONSTRAINT fk_rails_4224d8f53b FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: stock_transfers fk_rails_43353b43cf; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock_transfers
    ADD CONSTRAINT fk_rails_43353b43cf FOREIGN KEY (from_store_id) REFERENCES public.stores(id);


--
-- Name: bookings fk_rails_469339cd03; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT fk_rails_469339cd03 FOREIGN KEY (store_id) REFERENCES public.stores(id);


--
-- Name: delivery_rules fk_rails_495c599380; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_rules
    ADD CONSTRAINT fk_rails_495c599380 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: milk_subscriptions fk_rails_4b4fb0c9b4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.milk_subscriptions
    ADD CONSTRAINT fk_rails_4b4fb0c9b4 FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: subscription_templates fk_rails_4cd084b669; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subscription_templates
    ADD CONSTRAINT fk_rails_4cd084b669 FOREIGN KEY (delivery_person_id) REFERENCES public.delivery_people(id);


--
-- Name: solid_queue_blocked_executions fk_rails_4cd34e2228; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_blocked_executions
    ADD CONSTRAINT fk_rails_4cd34e2228 FOREIGN KEY (job_id) REFERENCES public.solid_queue_jobs(id) ON DELETE CASCADE;


--
-- Name: product_reviews fk_rails_4d29a9c00a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_reviews
    ADD CONSTRAINT fk_rails_4d29a9c00a FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: notes fk_rails_65a5c39deb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT fk_rails_65a5c39deb FOREIGN KEY (created_by_user_id) REFERENCES public.users(id);


--
-- Name: customer_wallets fk_rails_67b1f56e66; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_wallets
    ADD CONSTRAINT fk_rails_67b1f56e66 FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: stock_transfers fk_rails_6cb5ca8048; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock_transfers
    ADD CONSTRAINT fk_rails_6cb5ca8048 FOREIGN KEY (approved_by_id) REFERENCES public.users(id);


--
-- Name: expenses fk_rails_707830cb5c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT fk_rails_707830cb5c FOREIGN KEY (store_id) REFERENCES public.stores(id);


--
-- Name: invoice_items fk_rails_72ed60e62c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoice_items
    ADD CONSTRAINT fk_rails_72ed60e62c FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: referrals fk_rails_77c18d42bf; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.referrals
    ADD CONSTRAINT fk_rails_77c18d42bf FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: customer_addresses fk_rails_79041ef784; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_addresses
    ADD CONSTRAINT fk_rails_79041ef784 FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: stock_transfers fk_rails_7b9441fa63; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock_transfers
    ADD CONSTRAINT fk_rails_7b9441fa63 FOREIGN KEY (to_store_id) REFERENCES public.stores(id);


--
-- Name: subscription_templates fk_rails_7cbefbc65a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subscription_templates
    ADD CONSTRAINT fk_rails_7cbefbc65a FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: vendor_purchases fk_rails_7dbe9a831a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vendor_purchases
    ADD CONSTRAINT fk_rails_7dbe9a831a FOREIGN KEY (vendor_id) REFERENCES public.vendors(id);


--
-- Name: milk_delivery_tasks fk_rails_7f5c180cc8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.milk_delivery_tasks
    ADD CONSTRAINT fk_rails_7f5c180cc8 FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: solid_queue_ready_executions fk_rails_81fcbd66af; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_ready_executions
    ADD CONSTRAINT fk_rails_81fcbd66af FOREIGN KEY (job_id) REFERENCES public.solid_queue_jobs(id) ON DELETE CASCADE;


--
-- Name: bookings fk_rails_94a0a341bb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT fk_rails_94a0a341bb FOREIGN KEY (booking_schedule_id) REFERENCES public.booking_schedules(id);


--
-- Name: stock_transfers fk_rails_95796a1793; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock_transfers
    ADD CONSTRAINT fk_rails_95796a1793 FOREIGN KEY (requested_by_id) REFERENCES public.users(id);


--
-- Name: active_storage_variant_records fk_rails_993965df05; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT fk_rails_993965df05 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: solid_queue_claimed_executions fk_rails_9cfe4d4944; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_claimed_executions
    ADD CONSTRAINT fk_rails_9cfe4d4944 FOREIGN KEY (job_id) REFERENCES public.solid_queue_jobs(id) ON DELETE CASCADE;


--
-- Name: product_reviews fk_rails_9dcee7d533; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_reviews
    ADD CONSTRAINT fk_rails_9dcee7d533 FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: vendor_invoices fk_rails_a2e0d1751f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vendor_invoices
    ADD CONSTRAINT fk_rails_a2e0d1751f FOREIGN KEY (vendor_purchase_id) REFERENCES public.vendor_purchases(id);


--
-- Name: product_reviews fk_rails_a6af267e3d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_reviews
    ADD CONSTRAINT fk_rails_a6af267e3d FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: device_tokens fk_rails_a6eff83e14; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.device_tokens
    ADD CONSTRAINT fk_rails_a6eff83e14 FOREIGN KEY (delivery_person_id) REFERENCES public.delivery_people(id);


--
-- Name: milk_delivery_tasks fk_rails_aafb5e9feb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.milk_delivery_tasks
    ADD CONSTRAINT fk_rails_aafb5e9feb FOREIGN KEY (delivery_person_id) REFERENCES public.delivery_people(id);


--
-- Name: stock_batches fk_rails_affef9f32d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock_batches
    ADD CONSTRAINT fk_rails_affef9f32d FOREIGN KEY (store_id) REFERENCES public.stores(id);


--
-- Name: booking_schedules fk_rails_bf34e93579; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_schedules
    ADD CONSTRAINT fk_rails_bf34e93579 FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: client_requests fk_rails_bf4af15099; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_requests
    ADD CONSTRAINT fk_rails_bf4af15099 FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: active_storage_attachments fk_rails_c3b3935057; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT fk_rails_c3b3935057 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: solid_queue_scheduled_executions fk_rails_c4316f352d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_scheduled_executions
    ADD CONSTRAINT fk_rails_c4316f352d FOREIGN KEY (job_id) REFERENCES public.solid_queue_jobs(id) ON DELETE CASCADE;


--
-- Name: product_ratings fk_rails_cc19464c64; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_ratings
    ADD CONSTRAINT fk_rails_cc19464c64 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: customer_formats fk_rails_cec20eb18b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_formats
    ADD CONSTRAINT fk_rails_cec20eb18b FOREIGN KEY (delivery_person_id) REFERENCES public.delivery_people(id);


--
-- Name: product_ratings fk_rails_d174ea1e32; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_ratings
    ADD CONSTRAINT fk_rails_d174ea1e32 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: customer_formats fk_rails_d1c53afd32; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_formats
    ADD CONSTRAINT fk_rails_d1c53afd32 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: stock_transfers fk_rails_d470850111; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock_transfers
    ADD CONSTRAINT fk_rails_d470850111 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: sale_items fk_rails_d6e0e81317; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sale_items
    ADD CONSTRAINT fk_rails_d6e0e81317 FOREIGN KEY (stock_batch_id) REFERENCES public.stock_batches(id);


--
-- Name: customer_formats fk_rails_d8a77fd5fc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_formats
    ADD CONSTRAINT fk_rails_d8a77fd5fc FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: product_variants fk_rails_dae52f850b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variants
    ADD CONSTRAINT fk_rails_dae52f850b FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: wallet_transactions fk_rails_dc5903e62b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wallet_transactions
    ADD CONSTRAINT fk_rails_dc5903e62b FOREIGN KEY (customer_wallet_id) REFERENCES public.customer_wallets(id);


--
-- Name: stock_movements fk_rails_deb37fa2ee; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock_movements
    ADD CONSTRAINT fk_rails_deb37fa2ee FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: milk_subscriptions fk_rails_e110a3862f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.milk_subscriptions
    ADD CONSTRAINT fk_rails_e110a3862f FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: notifications fk_rails_e82fd73b00; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_rails_e82fd73b00 FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: sale_items fk_rails_ee606308b2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sale_items
    ADD CONSTRAINT fk_rails_ee606308b2 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: pending_amounts fk_rails_f63a5d559b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pending_amounts
    ADD CONSTRAINT fk_rails_f63a5d559b FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: expenses fk_rails_f7e2e7081b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT fk_rails_f7e2e7081b FOREIGN KEY (created_by_id) REFERENCES public.users(id);


--
-- Name: vendor_payments fk_rails_fa51839ac6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vendor_payments
    ADD CONSTRAINT fk_rails_fa51839ac6 FOREIGN KEY (vendor_purchase_id) REFERENCES public.vendor_purchases(id);


--
-- Name: products fk_rails_fb915499a4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT fk_rails_fb915499a4 FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: booking_invoices fk_rails_fd3dea094d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_invoices
    ADD CONSTRAINT fk_rails_fd3dea094d FOREIGN KEY (booking_id) REFERENCES public.bookings(id);


--
-- Name: stock_batches fk_rails_fd8d4dc083; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock_batches
    ADD CONSTRAINT fk_rails_fd8d4dc083 FOREIGN KEY (vendor_id) REFERENCES public.vendors(id);


--
-- PostgreSQL database dump complete
--

\unrestrict wQxPwDjd1bQ7C8ulBv4ttixREb14BaZ9lI3X2jdvK5h6rCHQWQnosHPH1xHI4rd


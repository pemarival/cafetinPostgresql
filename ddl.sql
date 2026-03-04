-- ============================================================
-- BASE DE DATOS - SQL SERVER
-- IDs: UNIQUEIDENTIFIER (UUID) con NEWSEQUENTIALID()
-- Fechas: DATETIMEOFFSET (equivalente a TIMESTAMPTZ)
-- ============================================================

USE master;
GO

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'MiBaseDeDatos')
    CREATE DATABASE MiBaseDeDatos;
GO

USE MiBaseDeDatos;
GO

-- ============================================================
-- SCHEMA: PARAMETER
-- ============================================================

CREATE TABLE type_document (
    id           UNIQUEIDENTIFIER  NOT NULL DEFAULT NEWSEQUENTIALID() PRIMARY KEY,
    name         VARCHAR(100)      NOT NULL,
    abbreviation VARCHAR(20)       NOT NULL
);

CREATE TABLE person (
    id               UNIQUEIDENTIFIER NOT NULL DEFAULT NEWSEQUENTIALID() PRIMARY KEY,
    type_document_id UNIQUEIDENTIFIER NOT NULL,
    document_number  VARCHAR(50)      NOT NULL,
    first_name       VARCHAR(100)     NOT NULL,
    last_name        VARCHAR(100)     NOT NULL,
    email            VARCHAR(150)     NULL,
    CONSTRAINT FK_person_type_document FOREIGN KEY (type_document_id)
        REFERENCES type_document(id)
);

CREATE TABLE file (
    id   UNIQUEIDENTIFIER NOT NULL DEFAULT NEWSEQUENTIALID() PRIMARY KEY,
    name VARCHAR(200)     NOT NULL,
    path VARCHAR(500)     NOT NULL,
);

-- ============================================================
-- SCHEMA: SECURITY
-- ============================================================

CREATE TABLE [user] (
    id            UNIQUEIDENTIFIER NOT NULL DEFAULT NEWSEQUENTIALID() PRIMARY KEY,
    person_id     UNIQUEIDENTIFIER NOT NULL,
    username      VARCHAR(100)     NOT NULL UNIQUE,
    password_hash VARCHAR(255)     NOT NULL,
    status        BIT              NOT NULL DEFAULT 1,
    CONSTRAINT FK_user_person FOREIGN KEY (person_id)
        REFERENCES person(id)
);

CREATE TABLE role (
    id          UNIQUEIDENTIFIER NOT NULL DEFAULT NEWSEQUENTIALID() PRIMARY KEY,
    name        VARCHAR(100)     NOT NULL,
    description TEXT             NULL
);

CREATE TABLE user_role (
    user_id     UNIQUEIDENTIFIER NOT NULL,
    role_id     UNIQUEIDENTIFIER NOT NULL,
    assigned_at DATETIMEOFFSET   NOT NULL DEFAULT SYSDATETIMEOFFSET(),
    CONSTRAINT PK_user_role PRIMARY KEY (user_id, role_id),
    CONSTRAINT FK_user_role_user FOREIGN KEY (user_id) REFERENCES [user](id),
    CONSTRAINT FK_user_role_role FOREIGN KEY (role_id) REFERENCES role(id)
);

CREATE TABLE module (
    id    UNIQUEIDENTIFIER NOT NULL DEFAULT NEWSEQUENTIALID() PRIMARY KEY,
    name  VARCHAR(100)     NOT NULL,
    route VARCHAR(200)     NULL
);

CREATE TABLE [view] (
    id    UNIQUEIDENTIFIER NOT NULL DEFAULT NEWSEQUENTIALID() PRIMARY KEY,
    name  VARCHAR(100)     NOT NULL,
    route VARCHAR(200)     NOT NULL
);

CREATE TABLE role_module (
    role_id   UNIQUEIDENTIFIER NOT NULL,
    module_id UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT PK_role_module PRIMARY KEY (role_id, module_id),
    CONSTRAINT FK_role_module_role   FOREIGN KEY (role_id)   REFERENCES role(id),
    CONSTRAINT FK_role_module_module FOREIGN KEY (module_id) REFERENCES module(id)
);

CREATE TABLE module_view (
    module_id UNIQUEIDENTIFIER NOT NULL,
    view_id   UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT PK_module_view PRIMARY KEY (module_id, view_id),
    CONSTRAINT FK_module_view_module FOREIGN KEY (module_id) REFERENCES module(id),
    CONSTRAINT FK_module_view_view   FOREIGN KEY (view_id)   REFERENCES [view](id)
);

-- ============================================================
-- SCHEMA: INVENTORY
-- ============================================================

CREATE TABLE category (
    id          UNIQUEIDENTIFIER NOT NULL DEFAULT NEWSEQUENTIALID() PRIMARY KEY,
    name        VARCHAR(100)     NOT NULL,
    description TEXT             NULL
);

CREATE TABLE supplier (
    id           UNIQUEIDENTIFIER NOT NULL DEFAULT NEWSEQUENTIALID() PRIMARY KEY,
    person_id    UNIQUEIDENTIFIER NOT NULL,
    company_name VARCHAR(150)     NOT NULL,
    phone        VARCHAR(30)      NULL,
    CONSTRAINT FK_supplier_person FOREIGN KEY (person_id)
        REFERENCES person(id)
);

CREATE TABLE product (
    id          UNIQUEIDENTIFIER NOT NULL DEFAULT NEWSEQUENTIALID() PRIMARY KEY,
    category_id UNIQUEIDENTIFIER NOT NULL,
    supplier_id UNIQUEIDENTIFIER NOT NULL,
    name        VARCHAR(150)     NOT NULL,
    price       DECIMAL(18, 2)   NOT NULL,
    CONSTRAINT FK_product_category FOREIGN KEY (category_id) REFERENCES category(id),
    CONSTRAINT FK_product_supplier FOREIGN KEY (supplier_id) REFERENCES supplier(id)
);

CREATE TABLE inventory (
    id         UNIQUEIDENTIFIER NOT NULL DEFAULT NEWSEQUENTIALID() PRIMARY KEY,
    product_id UNIQUEIDENTIFIER NOT NULL,
    quantity   INT              NOT NULL DEFAULT 0,
    min_stock  INT              NOT NULL DEFAULT 0,
    CONSTRAINT FK_inventory_product FOREIGN KEY (product_id)
        REFERENCES product(id)
);

-- ============================================================
-- SCHEMA: SALES
-- ============================================================

CREATE TABLE customer (
    id            UNIQUEIDENTIFIER NOT NULL DEFAULT NEWSEQUENTIALID() PRIMARY KEY,
    person_id     UNIQUEIDENTIFIER NOT NULL,
    address       VARCHAR(250)     NULL,
    customer_type VARCHAR(50)      NULL,
    CONSTRAINT FK_customer_person FOREIGN KEY (person_id)
        REFERENCES person(id)
);

CREATE TABLE [order] (
    id          UNIQUEIDENTIFIER NOT NULL DEFAULT NEWSEQUENTIALID() PRIMARY KEY,
    customer_id UNIQUEIDENTIFIER NOT NULL,
    user_id     UNIQUEIDENTIFIER NOT NULL,
    order_date  DATETIMEOFFSET   NOT NULL DEFAULT SYSDATETIMEOFFSET(),
    status      VARCHAR(30)      NOT NULL,  -- PENDING | COMPLETED | CANCELLED
    total       DECIMAL(18, 2)   NOT NULL DEFAULT 0,
    CONSTRAINT FK_order_customer FOREIGN KEY (customer_id) REFERENCES customer(id),
    CONSTRAINT FK_order_user     FOREIGN KEY (user_id)     REFERENCES [user](id)
);

CREATE TABLE order_item (
    id         UNIQUEIDENTIFIER NOT NULL DEFAULT NEWSEQUENTIALID() PRIMARY KEY,
    order_id   UNIQUEIDENTIFIER NOT NULL,
    product_id UNIQUEIDENTIFIER NOT NULL,
    unit_price DECIMAL(18, 2)   NOT NULL,
    CONSTRAINT FK_order_item_order   FOREIGN KEY (order_id)   REFERENCES [order](id),
    CONSTRAINT FK_order_item_product FOREIGN KEY (product_id) REFERENCES product(id)
);

-- ============================================================
-- SCHEMA: PAYMENT
-- ============================================================

CREATE TABLE method_payment (
    id          UNIQUEIDENTIFIER NOT NULL DEFAULT NEWSEQUENTIALID() PRIMARY KEY,
    name        VARCHAR(100)     NOT NULL,
    description TEXT             NULL
);

-- ============================================================
-- SCHEMA: BILLING
-- ============================================================

CREATE TABLE invoice (
    id             UNIQUEIDENTIFIER NOT NULL DEFAULT NEWSEQUENTIALID() PRIMARY KEY,
    order_id       UNIQUEIDENTIFIER NOT NULL,
    customer_id    UNIQUEIDENTIFIER NOT NULL,
    invoice_number VARCHAR(50)      NOT NULL UNIQUE,
    issue_date     DATETIMEOFFSET   NOT NULL DEFAULT SYSDATETIMEOFFSET(),
    total          DECIMAL(18, 2)   NOT NULL DEFAULT 0,
    CONSTRAINT FK_invoice_order    FOREIGN KEY (order_id)    REFERENCES [order](id),
    CONSTRAINT FK_invoice_customer FOREIGN KEY (customer_id) REFERENCES customer(id)
);

CREATE TABLE invoice_item (
    id         UNIQUEIDENTIFIER NOT NULL DEFAULT NEWSEQUENTIALID() PRIMARY KEY,
    invoice_id UNIQUEIDENTIFIER NOT NULL,
    product_id UNIQUEIDENTIFIER NOT NULL,
    quantity   INT              NOT NULL,
    unit_price DECIMAL(18, 2)   NOT NULL,
    CONSTRAINT FK_invoice_item_invoice FOREIGN KEY (invoice_id) REFERENCES invoice(id),
    CONSTRAINT FK_invoice_item_product FOREIGN KEY (product_id) REFERENCES product(id)
);

CREATE TABLE payment (
    id                UNIQUEIDENTIFIER NOT NULL DEFAULT NEWSEQUENTIALID() PRIMARY KEY,
    invoice_id        UNIQUEIDENTIFIER NOT NULL,
    method_payment_id UNIQUEIDENTIFIER NOT NULL,
    amount            DECIMAL(18, 2)   NOT NULL,
    payment_date      DATETIMEOFFSET   NOT NULL DEFAULT SYSDATETIMEOFFSET(),
    status            VARCHAR(30)      NOT NULL,  -- PENDING | PAID | REFUNDED
    CONSTRAINT FK_payment_invoice        FOREIGN KEY (invoice_id)        REFERENCES invoice(id),
    CONSTRAINT FK_payment_method_payment FOREIGN KEY (method_payment_id) REFERENCES method_payment(id)
);

-- ============================================================
-- FIN DEL SCRIPT
-- ============================================================

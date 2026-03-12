CREATE EXTENSION IF NOT EXISTS "pgcrypto";

CREATE TABLE type_document (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255),
    abbreviation VARCHAR(255)
);

CREATE TABLE file (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255),
    path VARCHAR(255)
);

CREATE TABLE person (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    type_document_id UUID,
    document VARCHAR(255),
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email VARCHAR(255),

    CONSTRAINT fk_type_document_person
        FOREIGN KEY (type_document_id)
        REFERENCES type_document(id)
);

CREATE TABLE role (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255),
    description TEXT
);

CREATE TABLE module (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255),
    icon VARCHAR(255)
);

CREATE TABLE view (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255),
    route VARCHAR(255)
);

CREATE TABLE module_view (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    module_id UUID,
    view_id UUID,

    CONSTRAINT fk_module_view_module
        FOREIGN KEY (module_id)
        REFERENCES module(id),

    CONSTRAINT fk_module_view_view
        FOREIGN KEY (view_id)
        REFERENCES view(id)
);

CREATE TABLE role_module (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    role_id UUID,
    module_id UUID,

    CONSTRAINT fk_role_module_role
        FOREIGN KEY (role_id)
        REFERENCES role(id),

    CONSTRAINT fk_role_module_module
        FOREIGN KEY (module_id)
        REFERENCES module(id)
);

CREATE TABLE "user" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    person_id UUID,
    username VARCHAR(255),
    password VARCHAR(255),
    status VARCHAR(255),

    CONSTRAINT fk_user_person
        FOREIGN KEY (person_id)
        REFERENCES person(id)
);

CREATE TABLE user_role (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    role_id UUID,
    user_id UUID,
    assigned_at TIMESTAMP,

    CONSTRAINT fk_user_role_role
        FOREIGN KEY (role_id)
        REFERENCES role(id),

    CONSTRAINT fk_user_role_user
        FOREIGN KEY (user_id)
        REFERENCES "user"(id)
);

CREATE TABLE supplier (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    person_id UUID,
    company_name VARCHAR(255),
    phone VARCHAR(255),

    CONSTRAINT fk_supplier_person
        FOREIGN KEY (person_id)
        REFERENCES person(id)
);

CREATE TABLE category (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255),
    description TEXT
);

CREATE TABLE product (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    supplier_id UUID,
    category_id UUID,
    name VARCHAR(255),
    price DECIMAL,

    CONSTRAINT fk_product_supplier
        FOREIGN KEY (supplier_id)
        REFERENCES supplier(id),

    CONSTRAINT fk_product_category
        FOREIGN KEY (category_id)
        REFERENCES category(id)
);

CREATE TABLE inventory (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID,
    quantity INTEGER,
    min_stock INTEGER,

    CONSTRAINT fk_inventory_product
        FOREIGN KEY (product_id)
        REFERENCES product(id)
);

CREATE TABLE customer (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    person_id UUID,
    address VARCHAR(255),
    customer_type VARCHAR(255),

    CONSTRAINT fk_customer_person
        FOREIGN KEY (person_id)
        REFERENCES person(id)
);

CREATE TABLE "order" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID,
    customer_id UUID,
    order_date TIMESTAMP,
    status VARCHAR(255),
    total DECIMAL,

    CONSTRAINT fk_order_user
        FOREIGN KEY (user_id)
        REFERENCES "user"(id),

    CONSTRAINT fk_order_customer
        FOREIGN KEY (customer_id)
        REFERENCES customer(id)
);

CREATE TABLE order_item (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id UUID,
    product_id UUID,
    unit_price DECIMAL,

    CONSTRAINT fk_order_item_order
        FOREIGN KEY (order_id)
        REFERENCES "order"(id),

    CONSTRAINT fk_order_item_product
        FOREIGN KEY (product_id)
        REFERENCES product(id)
);

CREATE TABLE invoice (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id UUID,
    customer_id UUID,
    invoice_number VARCHAR(255),
    issue_date TIMESTAMP,
    total DECIMAL,

    CONSTRAINT fk_invoice_order
        FOREIGN KEY (order_id)
        REFERENCES "order"(id),

    CONSTRAINT fk_invoice_customer
        FOREIGN KEY (customer_id)
        REFERENCES customer(id)
);

CREATE TABLE invoice_item (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    invoice_id UUID,
    product_id UUID,
    quantity INTEGER,
    unit_price DECIMAL,

    CONSTRAINT fk_invoice_item_invoice
        FOREIGN KEY (invoice_id)
        REFERENCES invoice(id),

    CONSTRAINT fk_invoice_item_product
        FOREIGN KEY (product_id)
        REFERENCES product(id)
);

CREATE TABLE method_payment (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255),
    description TEXT
);

CREATE TABLE payment (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    invoice_id UUID,
    method_payment_id UUID,
    amount DECIMAL,
    payment_date TIMESTAMP,
    status VARCHAR(255),

    CONSTRAINT fk_payment_invoice
        FOREIGN KEY (invoice_id)
        REFERENCES invoice(id),

    CONSTRAINT fk_payment_method
        FOREIGN KEY (method_payment_id)
        REFERENCES method_payment(id)
);
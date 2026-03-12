INSERT INTO type_document (id,name,abbreviation) VALUES
(gen_random_uuid(),'Cédula de Ciudadanía','CC'),
(gen_random_uuid(),'Tarjeta de Identidad','TI'),
(gen_random_uuid(),'Cédula de Extranjería','CE'),
(gen_random_uuid(),'Pasaporte','PA'),
(gen_random_uuid(),'NIT','NIT'),
(gen_random_uuid(),'Registro Civil','RC'),
(gen_random_uuid(),'Documento Nacional','DN'),
(gen_random_uuid(),'Licencia de Conducción','LC'),
(gen_random_uuid(),'Documento Militar','DM'),
(gen_random_uuid(),'Permiso Especial','PE');

INSERT INTO file (id,name,path) VALUES
(gen_random_uuid(),'foto1','/files/foto1.png'),
(gen_random_uuid(),'foto2','/files/foto2.png'),
(gen_random_uuid(),'foto3','/files/foto3.png'),
(gen_random_uuid(),'foto4','/files/foto4.png'),
(gen_random_uuid(),'foto5','/files/foto5.png'),
(gen_random_uuid(),'doc1','/files/doc1.pdf'),
(gen_random_uuid(),'doc2','/files/doc2.pdf'),
(gen_random_uuid(),'doc3','/files/doc3.pdf'),
(gen_random_uuid(),'doc4','/files/doc4.pdf'),
(gen_random_uuid(),'doc5','/files/doc5.pdf');

INSERT INTO person (id,type_document_id,document,first_name,last_name,email)
SELECT gen_random_uuid(), id, '100'||row_number() over(), 
'Nombre'||row_number() over(), 'Apellido'||row_number() over(),
'correo'||row_number() over()||'@mail.com'
FROM type_document
LIMIT 10;

INSERT INTO role (id,name,description) VALUES
(gen_random_uuid(),'Admin','Administrador del sistema'),
(gen_random_uuid(),'Manager','Gerente'),
(gen_random_uuid(),'Seller','Vendedor'),
(gen_random_uuid(),'Inventory','Encargado inventario'),
(gen_random_uuid(),'Support','Soporte'),
(gen_random_uuid(),'Billing','Facturación'),
(gen_random_uuid(),'Finance','Finanzas'),
(gen_random_uuid(),'Auditor','Auditor del sistema'),
(gen_random_uuid(),'Supervisor','Supervisor'),
(gen_random_uuid(),'Guest','Usuario invitado');

INSERT INTO module (id,name,icon) VALUES
(gen_random_uuid(),'Usuarios','user'),
(gen_random_uuid(),'Inventario','box'),
(gen_random_uuid(),'Ventas','cart'),
(gen_random_uuid(),'Facturación','file'),
(gen_random_uuid(),'Pagos','credit-card'),
(gen_random_uuid(),'Reportes','chart'),
(gen_random_uuid(),'Configuración','settings'),
(gen_random_uuid(),'Clientes','users'),
(gen_random_uuid(),'Proveedores','truck'),
(gen_random_uuid(),'Productos','tag');

INSERT INTO view (id,name,route) VALUES
(gen_random_uuid(),'Dashboard','/dashboard'),
(gen_random_uuid(),'Usuarios','/users'),
(gen_random_uuid(),'Productos','/products'),
(gen_random_uuid(),'Clientes','/customers'),
(gen_random_uuid(),'Proveedores','/suppliers'),
(gen_random_uuid(),'Inventario','/inventory'),
(gen_random_uuid(),'Ventas','/orders'),
(gen_random_uuid(),'Facturas','/invoices'),
(gen_random_uuid(),'Pagos','/payments'),
(gen_random_uuid(),'Reportes','/reports');

INSERT INTO module_view (id,module_id,view_id)
SELECT gen_random_uuid(), m.id, v.id
FROM module m
JOIN view v ON true
LIMIT 10;

INSERT INTO role_module (id,role_id,module_id)
SELECT gen_random_uuid(), r.id, m.id
FROM role r
JOIN module m ON true
LIMIT 10;

INSERT INTO "user" (id,person_id,username,password,status)
SELECT gen_random_uuid(), id,
'user'||row_number() over(),
'123456',
'ACTIVE'
FROM person
LIMIT 10;

INSERT INTO user_role (id,role_id,user_id,assigned_at)
SELECT gen_random_uuid(), r.id, u.id, NOW()
FROM role r
JOIN "user" u ON true
LIMIT 10;

INSERT INTO supplier (id,person_id,company_name,phone)
SELECT gen_random_uuid(), id,
'Empresa'||row_number() over(),
'30000000'||row_number() over()
FROM person
LIMIT 10;

INSERT INTO category (id,name,description) VALUES
(gen_random_uuid(),'Electrónica','Equipos electrónicos'),
(gen_random_uuid(),'Hogar','Artículos del hogar'),
(gen_random_uuid(),'Tecnología','Dispositivos tecnológicos'),
(gen_random_uuid(),'Ropa','Vestimenta'),
(gen_random_uuid(),'Deportes','Artículos deportivos'),
(gen_random_uuid(),'Oficina','Útiles de oficina'),
(gen_random_uuid(),'Automotriz','Accesorios autos'),
(gen_random_uuid(),'Salud','Productos salud'),
(gen_random_uuid(),'Belleza','Cosméticos'),
(gen_random_uuid(),'Juguetes','Juguetes infantiles');

INSERT INTO product (id,supplier_id,category_id,name,price)
SELECT gen_random_uuid(), s.id, c.id,
'Producto'||row_number() over(),
(random()*100+10)::decimal
FROM supplier s
JOIN category c ON true
LIMIT 10;

INSERT INTO inventory (id,product_id,quantity,min_stock)
SELECT gen_random_uuid(), id,
(10 + random()*100)::int,
5
FROM product
LIMIT 10;

INSERT INTO customer (id,person_id,address,customer_type)
SELECT gen_random_uuid(), id,
'Calle '||row_number() over(),
'regular'
FROM person
LIMIT 10;

INSERT INTO "order" (id,user_id,customer_id,order_date,status,total)
SELECT gen_random_uuid(), u.id, c.id,
NOW(),
'CREATED',
(random()*500)::decimal
FROM "user" u
JOIN customer c ON true
LIMIT 10;

INSERT INTO order_item (id,order_id,product_id,unit_price)
SELECT gen_random_uuid(), o.id, p.id,
p.price
FROM "order" o
JOIN product p ON true
LIMIT 10;

INSERT INTO invoice (id,order_id,customer_id,invoice_number,issue_date,total)
SELECT gen_random_uuid(), o.id, c.id,
'INV'||row_number() over(),
NOW(),
(random()*500)::decimal
FROM "order" o
JOIN customer c ON true
LIMIT 10;

INSERT INTO invoice_item (id,invoice_id,product_id,quantity,unit_price)
SELECT gen_random_uuid(), i.id, p.id,
(1 + random()*5)::int,
p.price
FROM invoice i
JOIN product p ON true
LIMIT 10;

INSERT INTO method_payment (id,name,description) VALUES
(gen_random_uuid(),'Efectivo','Pago en efectivo'),
(gen_random_uuid(),'Tarjeta Crédito','Pago con crédito'),
(gen_random_uuid(),'Tarjeta Débito','Pago con débito'),
(gen_random_uuid(),'Transferencia','Transferencia bancaria'),
(gen_random_uuid(),'Nequi','Pago con Nequi'),
(gen_random_uuid(),'Daviplata','Pago con Daviplata'),
(gen_random_uuid(),'PayPal','Pago con PayPal'),
(gen_random_uuid(),'Cheque','Pago con cheque'),
(gen_random_uuid(),'Cripto','Pago con criptomoneda'),
(gen_random_uuid(),'QR','Pago con código QR');

INSERT INTO payment (id,invoice_id,method_payment_id,amount,payment_date,status)
SELECT gen_random_uuid(), i.id, m.id,
(random()*500)::decimal,
NOW(),
'PAID'
FROM invoice i
JOIN method_payment m ON true
LIMIT 10;
-- ============================================================
-- INSERTS - 10 registros por entidad
-- ============================================================

USE MiBaseDeDatos;
GO

-- ============================================================
-- SCHEMA: PARAMETER
-- ============================================================

INSERT INTO type_document (id, name, abbreviation) VALUES
(NEWID(), 'Cédula de Ciudadanía',      'CC'),
(NEWID(), 'Tarjeta de Identidad',      'TI'),
(NEWID(), 'Cédula de Extranjería',     'CE'),
(NEWID(), 'Pasaporte',                 'PA'),
(NEWID(), 'NIT',                       'NIT'),
(NEWID(), 'Registro Civil',            'RC'),
(NEWID(), 'CURP',                      'CURP'),
(NEWID(), 'DNI',                       'DNI'),
(NEWID(), 'RUC',                       'RUC'),
(NEWID(), 'RUT',                       'RUT');
GO

-- Guardamos IDs de type_document para usarlos en person
DECLARE @td1 UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM type_document WHERE abbreviation = 'CC');
DECLARE @td2 UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM type_document WHERE abbreviation = 'TI');
DECLARE @td3 UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM type_document WHERE abbreviation = 'PA');

INSERT INTO person (id, type_document_id, document_number, first_name, last_name, email, phone) VALUES
(NEWID(), @td1, '1020304050', 'Carlos',    'Ramírez',   'carlos.ramirez@email.com',   '3001234567'),
(NEWID(), @td1, '1030405060', 'Ana',       'Gómez',     'ana.gomez@email.com',        '3009876543'),
(NEWID(), @td1, '1040506070', 'Luis',      'Martínez',  'luis.martinez@email.com',    '3101112233'),
(NEWID(), @td1, '1050607080', 'María',     'López',     'maria.lopez@email.com',      '3154455667'),
(NEWID(), @td2, '1060708090', 'Jorge',     'Herrera',   'jorge.herrera@email.com',    '3162233445'),
(NEWID(), @td1, '1070809100', 'Laura',     'Torres',    'laura.torres@email.com',     '3173344556'),
(NEWID(), @td3, 'P123456789', 'John',      'Smith',     'john.smith@email.com',       '3184455668'),
(NEWID(), @td1, '1090001020', 'Valentina', 'Ríos',      'valentina.rios@email.com',   '3195566779'),
(NEWID(), @td1, '1100102030', 'Diego',     'Vargas',    'diego.vargas@email.com',     '3206677880'),
(NEWID(), @td1, '1110203040', 'Sofía',     'Castillo',  'sofia.castillo@email.com',   '3217788991');
GO

INSERT INTO file (id, name, path, type) VALUES
(NEWID(), 'logo_empresa.png',      '/uploads/images/logo_empresa.png',      'image/png'),
(NEWID(), 'contrato_001.pdf',      '/uploads/docs/contrato_001.pdf',        'application/pdf'),
(NEWID(), 'factura_2024.pdf',      '/uploads/docs/factura_2024.pdf',        'application/pdf'),
(NEWID(), 'foto_perfil_ana.jpg',   '/uploads/images/foto_perfil_ana.jpg',   'image/jpeg'),
(NEWID(), 'reporte_ventas.xlsx',   '/uploads/reports/reporte_ventas.xlsx',  'application/xlsx'),
(NEWID(), 'manual_usuario.pdf',    '/uploads/docs/manual_usuario.pdf',      'application/pdf'),
(NEWID(), 'banner_promo.png',      '/uploads/images/banner_promo.png',      'image/png'),
(NEWID(), 'inventario_oct.csv',    '/uploads/reports/inventario_oct.csv',   'text/csv'),
(NEWID(), 'foto_producto_01.jpg',  '/uploads/images/foto_producto_01.jpg',  'image/jpeg'),
(NEWID(), 'politicas_datos.pdf',   '/uploads/docs/politicas_datos.pdf',     'application/pdf');
GO

-- ============================================================
-- SCHEMA: SECURITY
-- ============================================================

-- Tomamos los primeros 10 person ids
DECLARE @p1  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM person ORDER BY first_name ASC);
DECLARE @p2  UNIQUEIDENTIFIER = (SELECT id FROM person WHERE first_name = 'Ana');
DECLARE @p3  UNIQUEIDENTIFIER = (SELECT id FROM person WHERE first_name = 'Carlos');
DECLARE @p4  UNIQUEIDENTIFIER = (SELECT id FROM person WHERE first_name = 'Diego');
DECLARE @p5  UNIQUEIDENTIFIER = (SELECT id FROM person WHERE first_name = 'John');
DECLARE @p6  UNIQUEIDENTIFIER = (SELECT id FROM person WHERE first_name = 'Jorge');
DECLARE @p7  UNIQUEIDENTIFIER = (SELECT id FROM person WHERE first_name = 'Laura');
DECLARE @p8  UNIQUEIDENTIFIER = (SELECT id FROM person WHERE first_name = 'Luis');
DECLARE @p9  UNIQUEIDENTIFIER = (SELECT id FROM person WHERE first_name = 'María');
DECLARE @p10 UNIQUEIDENTIFIER = (SELECT id FROM person WHERE first_name = 'Sofía');

INSERT INTO [user] (id, person_id, username, password_hash, status) VALUES
(NEWID(), @p3,  'carlos.r',    '5f4dcc3b5aa765d61d8327deb882cf99', 1),
(NEWID(), @p2,  'ana.g',       'e10adc3949ba59abbe56e057f20f883e', 1),
(NEWID(), @p8,  'luis.m',      '25f9e794323b453885f5181f1b624d0b', 1),
(NEWID(), @p9,  'maria.l',     '5f4dcc3b5aa765d61d8327deb882cf99', 1),
(NEWID(), @p6,  'jorge.h',     'e10adc3949ba59abbe56e057f20f883e', 0),
(NEWID(), @p7,  'laura.t',     '25f9e794323b453885f5181f1b624d0b', 1),
(NEWID(), @p5,  'john.s',      '5f4dcc3b5aa765d61d8327deb882cf99', 1),
(NEWID(), @p1,  'valentina.r', 'e10adc3949ba59abbe56e057f20f883e', 1),
(NEWID(), @p4,  'diego.v',     '25f9e794323b453885f5181f1b624d0b', 1),
(NEWID(), @p10, 'sofia.c',     '5f4dcc3b5aa765d61d8327deb882cf99', 1);
GO

INSERT INTO role (id, name, description) VALUES
(NEWID(), 'Administrador',  'Acceso total al sistema'),
(NEWID(), 'Vendedor',       'Gestión de ventas y clientes'),
(NEWID(), 'Bodeguero',      'Gestión de inventario y productos'),
(NEWID(), 'Contador',       'Gestión de facturación y pagos'),
(NEWID(), 'Soporte',        'Atención al cliente y soporte técnico'),
(NEWID(), 'Gerente',        'Supervisión general de operaciones'),
(NEWID(), 'Auditor',        'Revisión y control de registros'),
(NEWID(), 'Compras',        'Gestión de proveedores y órdenes de compra'),
(NEWID(), 'Marketing',      'Gestión de promociones y campañas'),
(NEWID(), 'RRHH',           'Gestión de personal y usuarios');
GO

-- user_role: asignamos roles a usuarios
DECLARE @u1  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [user] WHERE username = 'carlos.r');
DECLARE @u2  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [user] WHERE username = 'ana.g');
DECLARE @u3  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [user] WHERE username = 'luis.m');
DECLARE @u4  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [user] WHERE username = 'maria.l');
DECLARE @u5  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [user] WHERE username = 'jorge.h');
DECLARE @u6  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [user] WHERE username = 'laura.t');
DECLARE @u7  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [user] WHERE username = 'john.s');
DECLARE @u8  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [user] WHERE username = 'valentina.r');
DECLARE @u9  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [user] WHERE username = 'diego.v');
DECLARE @u10 UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [user] WHERE username = 'sofia.c');

DECLARE @r1  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM role WHERE name = 'Administrador');
DECLARE @r2  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM role WHERE name = 'Vendedor');
DECLARE @r3  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM role WHERE name = 'Bodeguero');
DECLARE @r4  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM role WHERE name = 'Contador');
DECLARE @r5  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM role WHERE name = 'Soporte');
DECLARE @r6  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM role WHERE name = 'Gerente');
DECLARE @r7  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM role WHERE name = 'Auditor');
DECLARE @r8  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM role WHERE name = 'Compras');
DECLARE @r9  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM role WHERE name = 'Marketing');
DECLARE @r10 UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM role WHERE name = 'RRHH');

INSERT INTO user_role (user_id, role_id, assigned_at) VALUES
(@u1,  @r1,  SYSDATETIMEOFFSET()),
(@u2,  @r2,  SYSDATETIMEOFFSET()),
(@u3,  @r3,  SYSDATETIMEOFFSET()),
(@u4,  @r4,  SYSDATETIMEOFFSET()),
(@u5,  @r5,  SYSDATETIMEOFFSET()),
(@u6,  @r6,  SYSDATETIMEOFFSET()),
(@u7,  @r7,  SYSDATETIMEOFFSET()),
(@u8,  @r8,  SYSDATETIMEOFFSET()),
(@u9,  @r9,  SYSDATETIMEOFFSET()),
(@u10, @r10, SYSDATETIMEOFFSET());
GO

INSERT INTO module (id, name, icon, route) VALUES
(NEWID(), 'Dashboard',    'dashboard',  '/dashboard'),
(NEWID(), 'Usuarios',     'people',     '/usuarios'),
(NEWID(), 'Roles',        'lock',       '/roles'),
(NEWID(), 'Productos',    'inventory',  '/productos'),
(NEWID(), 'Categorías',   'category',   '/categorias'),
(NEWID(), 'Proveedores',  'local_shipping', '/proveedores'),
(NEWID(), 'Clientes',     'person',     '/clientes'),
(NEWID(), 'Ventas',       'point_of_sale', '/ventas'),
(NEWID(), 'Facturación',  'receipt',    '/facturacion'),
(NEWID(), 'Reportes',     'bar_chart',  '/reportes');
GO

INSERT INTO [view] (id, name, route) VALUES
(NEWID(), 'Lista Usuarios',       '/usuarios/lista'),
(NEWID(), 'Crear Usuario',        '/usuarios/crear'),
(NEWID(), 'Lista Productos',      '/productos/lista'),
(NEWID(), 'Crear Producto',       '/productos/crear'),
(NEWID(), 'Lista Clientes',       '/clientes/lista'),
(NEWID(), 'Lista Órdenes',        '/ventas/ordenes'),
(NEWID(), 'Nueva Orden',          '/ventas/nueva'),
(NEWID(), 'Lista Facturas',       '/facturacion/facturas'),
(NEWID(), 'Detalle Factura',      '/facturacion/detalle'),
(NEWID(), 'Reporte Inventario',   '/reportes/inventario');
GO

-- role_module
DECLARE @m1  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM module WHERE name = 'Dashboard');
DECLARE @m2  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM module WHERE name = 'Usuarios');
DECLARE @m3  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM module WHERE name = 'Roles');
DECLARE @m4  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM module WHERE name = 'Productos');
DECLARE @m5  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM module WHERE name = 'Categorías');
DECLARE @m6  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM module WHERE name = 'Proveedores');
DECLARE @m7  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM module WHERE name = 'Clientes');
DECLARE @m8  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM module WHERE name = 'Ventas');
DECLARE @m9  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM module WHERE name = 'Facturación');
DECLARE @m10 UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM module WHERE name = 'Reportes');

INSERT INTO role_module (role_id, module_id) VALUES
(@r1, @m1), (@r1, @m2),
(@r2, @m7), (@r2, @m8),
(@r3, @m4), (@r3, @m5),
(@r4, @m9), (@r4, @m10),
(@r5, @m1), (@r6, @m1);
GO

-- module_view
DECLARE @v1  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [view] WHERE name = 'Lista Usuarios');
DECLARE @v2  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [view] WHERE name = 'Crear Usuario');
DECLARE @v3  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [view] WHERE name = 'Lista Productos');
DECLARE @v4  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [view] WHERE name = 'Crear Producto');
DECLARE @v5  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [view] WHERE name = 'Lista Clientes');
DECLARE @v6  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [view] WHERE name = 'Lista Órdenes');
DECLARE @v7  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [view] WHERE name = 'Nueva Orden');
DECLARE @v8  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [view] WHERE name = 'Lista Facturas');
DECLARE @v9  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [view] WHERE name = 'Detalle Factura');
DECLARE @v10 UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [view] WHERE name = 'Reporte Inventario');

DECLARE @mod2 UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM module WHERE name = 'Usuarios');
DECLARE @mod4 UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM module WHERE name = 'Productos');
DECLARE @mod7 UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM module WHERE name = 'Clientes');
DECLARE @mod8 UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM module WHERE name = 'Ventas');
DECLARE @mod9 UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM module WHERE name = 'Facturación');

INSERT INTO module_view (module_id, view_id) VALUES
(@mod2, @v1), (@mod2, @v2),
(@mod4, @v3), (@mod4, @v4),
(@mod7, @v5),
(@mod8, @v6), (@mod8, @v7),
(@mod9, @v8), (@mod9, @v9),
(@mod4, @v10);
GO

-- ============================================================
-- SCHEMA: INVENTORY
-- ============================================================

INSERT INTO category (id, name, description) VALUES
(NEWID(), 'Electrónica',       'Dispositivos y equipos electrónicos'),
(NEWID(), 'Ropa',              'Prendas de vestir para adultos y niños'),
(NEWID(), 'Alimentos',         'Productos alimenticios y bebidas'),
(NEWID(), 'Hogar',             'Artículos para el hogar y decoración'),
(NEWID(), 'Deportes',          'Equipos y ropa deportiva'),
(NEWID(), 'Juguetes',          'Juguetes y juegos para niños'),
(NEWID(), 'Libros',            'Libros, revistas y material educativo'),
(NEWID(), 'Herramientas',      'Herramientas manuales y eléctricas'),
(NEWID(), 'Belleza',           'Productos de cuidado personal y cosmética'),
(NEWID(), 'Automotriz',        'Accesorios y repuestos para vehículos');
GO

-- Necesitamos person_ids para suppliers (reutilizamos los mismos)
DECLARE @sp1  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM person WHERE first_name = 'Carlos');
DECLARE @sp2  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM person WHERE first_name = 'Ana');
DECLARE @sp3  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM person WHERE first_name = 'Luis');
DECLARE @sp4  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM person WHERE first_name = 'María');
DECLARE @sp5  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM person WHERE first_name = 'Jorge');
DECLARE @sp6  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM person WHERE first_name = 'Laura');
DECLARE @sp7  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM person WHERE first_name = 'John');
DECLARE @sp8  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM person WHERE first_name = 'Valentina');
DECLARE @sp9  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM person WHERE first_name = 'Diego');
DECLARE @sp10 UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM person WHERE first_name = 'Sofía');

INSERT INTO supplier (id, person_id, company_name, phone) VALUES
(NEWID(), @sp1,  'TechDistrib S.A.S',     '6011234567'),
(NEWID(), @sp2,  'Moda Express Ltda',     '6027654321'),
(NEWID(), @sp3,  'AgroFresh Colombia',    '6043456789'),
(NEWID(), @sp4,  'HogarPlus S.A',         '6054567890'),
(NEWID(), @sp5,  'SportZone Ltda',        '6065678901'),
(NEWID(), @sp6,  'JuguetesKids S.A.S',   '6076789012'),
(NEWID(), @sp7,  'EditorialLibros Co.',   '6087890123'),
(NEWID(), @sp8,  'HerramientasPro Ltda', '6098901234'),
(NEWID(), @sp9,  'BeautyWorld S.A.S',    '6019012345'),
(NEWID(), @sp10, 'AutoPartes Colombia',  '6020123456');
GO

DECLARE @cat1  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM category WHERE name = 'Electrónica');
DECLARE @cat2  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM category WHERE name = 'Ropa');
DECLARE @cat3  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM category WHERE name = 'Alimentos');
DECLARE @cat4  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM category WHERE name = 'Hogar');
DECLARE @cat5  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM category WHERE name = 'Deportes');
DECLARE @cat6  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM category WHERE name = 'Juguetes');
DECLARE @cat7  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM category WHERE name = 'Libros');
DECLARE @cat8  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM category WHERE name = 'Herramientas');
DECLARE @cat9  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM category WHERE name = 'Belleza');
DECLARE @cat10 UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM category WHERE name = 'Automotriz');

DECLARE @sup1  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM supplier WHERE company_name = 'TechDistrib S.A.S');
DECLARE @sup2  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM supplier WHERE company_name = 'Moda Express Ltda');
DECLARE @sup3  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM supplier WHERE company_name = 'AgroFresh Colombia');
DECLARE @sup4  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM supplier WHERE company_name = 'HogarPlus S.A');
DECLARE @sup5  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM supplier WHERE company_name = 'SportZone Ltda');
DECLARE @sup6  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM supplier WHERE company_name = 'JuguetesKids S.A.S');
DECLARE @sup7  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM supplier WHERE company_name = 'EditorialLibros Co.');
DECLARE @sup8  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM supplier WHERE company_name = 'HerramientasPro Ltda');
DECLARE @sup9  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM supplier WHERE company_name = 'BeautyWorld S.A.S');
DECLARE @sup10 UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM supplier WHERE company_name = 'AutoPartes Colombia');

INSERT INTO product (id, category_id, supplier_id, name, price, cost) VALUES
(NEWID(), @cat1,  @sup1,  'Laptop HP 15"',           2500000.00, 1800000.00),
(NEWID(), @cat2,  @sup2,  'Camiseta Polo Classic',     85000.00,   40000.00),
(NEWID(), @cat3,  @sup3,  'Aceite de Oliva 500ml',     28000.00,   15000.00),
(NEWID(), @cat4,  @sup4,  'Lámpara LED de Escritorio', 65000.00,   30000.00),
(NEWID(), @cat5,  @sup5,  'Balón de Fútbol Pro',       95000.00,   50000.00),
(NEWID(), @cat6,  @sup6,  'Set de Lego 500 piezas',   185000.00,   90000.00),
(NEWID(), @cat7,  @sup7,  'Libro "Clean Code"',        75000.00,   35000.00),
(NEWID(), @cat8,  @sup8,  'Taladro Eléctrico 600W',   320000.00,  180000.00),
(NEWID(), @cat9,  @sup9,  'Crema Hidratante 200ml',    42000.00,   18000.00),
(NEWID(), @cat10, @sup10, 'Filtro de Aceite Universal', 35000.00,  15000.00);
GO

DECLARE @prod1  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM product WHERE name = 'Laptop HP 15"');
DECLARE @prod2  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM product WHERE name = 'Camiseta Polo Classic');
DECLARE @prod3  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM product WHERE name = 'Aceite de Oliva 500ml');
DECLARE @prod4  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM product WHERE name = 'Lámpara LED de Escritorio');
DECLARE @prod5  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM product WHERE name = 'Balón de Fútbol Pro');
DECLARE @prod6  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM product WHERE name = 'Set de Lego 500 piezas');
DECLARE @prod7  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM product WHERE name = 'Libro "Clean Code"');
DECLARE @prod8  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM product WHERE name = 'Taladro Eléctrico 600W');
DECLARE @prod9  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM product WHERE name = 'Crema Hidratante 200ml');
DECLARE @prod10 UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM product WHERE name = 'Filtro de Aceite Universal');

INSERT INTO inventory (id, product_id, quantity, min_stock) VALUES
(NEWID(), @prod1,   15,  5),
(NEWID(), @prod2,  100, 20),
(NEWID(), @prod3,  200, 30),
(NEWID(), @prod4,   50, 10),
(NEWID(), @prod5,   80, 15),
(NEWID(), @prod6,   40, 10),
(NEWID(), @prod7,  150, 25),
(NEWID(), @prod8,   25,  5),
(NEWID(), @prod9,  300, 50),
(NEWID(), @prod10, 120, 20);
GO

-- ============================================================
-- SCHEMA: SALES
-- ============================================================

DECLARE @cp1  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM person WHERE first_name = 'Carlos');
DECLARE @cp2  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM person WHERE first_name = 'Ana');
DECLARE @cp3  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM person WHERE first_name = 'Luis');
DECLARE @cp4  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM person WHERE first_name = 'María');
DECLARE @cp5  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM person WHERE first_name = 'Jorge');
DECLARE @cp6  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM person WHERE first_name = 'Laura');
DECLARE @cp7  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM person WHERE first_name = 'John');
DECLARE @cp8  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM person WHERE first_name = 'Valentina');
DECLARE @cp9  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM person WHERE first_name = 'Diego');
DECLARE @cp10 UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM person WHERE first_name = 'Sofía');

INSERT INTO customer (id, person_id, address, customer_type) VALUES
(NEWID(), @cp1,  'Calle 10 # 20-30, Bogotá',        'REGULAR'),
(NEWID(), @cp2,  'Carrera 15 # 85-40, Bogotá',      'VIP'),
(NEWID(), @cp3,  'Av. El Dorado # 68-50, Bogotá',   'REGULAR'),
(NEWID(), @cp4,  'Calle 100 # 14-55, Bogotá',       'VIP'),
(NEWID(), @cp5,  'Carrera 7 # 45-10, Medellín',     'MAYORISTA'),
(NEWID(), @cp6,  'Calle 5 # 3-20, Cali',            'REGULAR'),
(NEWID(), @cp7,  'Av. Américas # 30-15, Bogotá',    'VIP'),
(NEWID(), @cp8,  'Carrera 50 # 22-80, Barranquilla','REGULAR'),
(NEWID(), @cp9,  'Calle 72 # 10-35, Bogotá',        'MAYORISTA'),
(NEWID(), @cp10, 'Carrera 43A # 1-50, Medellín',    'REGULAR');
GO

DECLARE @cust1  UNIQUEIDENTIFIER = (SELECT TOP 1 c.id FROM customer c JOIN person p ON c.person_id = p.id WHERE p.first_name = 'Carlos');
DECLARE @cust2  UNIQUEIDENTIFIER = (SELECT TOP 1 c.id FROM customer c JOIN person p ON c.person_id = p.id WHERE p.first_name = 'Ana');
DECLARE @cust3  UNIQUEIDENTIFIER = (SELECT TOP 1 c.id FROM customer c JOIN person p ON c.person_id = p.id WHERE p.first_name = 'Luis');
DECLARE @cust4  UNIQUEIDENTIFIER = (SELECT TOP 1 c.id FROM customer c JOIN person p ON c.person_id = p.id WHERE p.first_name = 'María');
DECLARE @cust5  UNIQUEIDENTIFIER = (SELECT TOP 1 c.id FROM customer c JOIN person p ON c.person_id = p.id WHERE p.first_name = 'Jorge');
DECLARE @cust6  UNIQUEIDENTIFIER = (SELECT TOP 1 c.id FROM customer c JOIN person p ON c.person_id = p.id WHERE p.first_name = 'Laura');
DECLARE @cust7  UNIQUEIDENTIFIER = (SELECT TOP 1 c.id FROM customer c JOIN person p ON c.person_id = p.id WHERE p.first_name = 'John');
DECLARE @cust8  UNIQUEIDENTIFIER = (SELECT TOP 1 c.id FROM customer c JOIN person p ON c.person_id = p.id WHERE p.first_name = 'Valentina');
DECLARE @cust9  UNIQUEIDENTIFIER = (SELECT TOP 1 c.id FROM customer c JOIN person p ON c.person_id = p.id WHERE p.first_name = 'Diego');
DECLARE @cust10 UNIQUEIDENTIFIER = (SELECT TOP 1 c.id FROM customer c JOIN person p ON c.person_id = p.id WHERE p.first_name = 'Sofía');

DECLARE @usr1  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [user] WHERE username = 'carlos.r');
DECLARE @usr2  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [user] WHERE username = 'ana.g');
DECLARE @usr3  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [user] WHERE username = 'luis.m');
DECLARE @usr4  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [user] WHERE username = 'maria.l');
DECLARE @usr5  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [user] WHERE username = 'jorge.h');

-- Declaramos IDs de órdenes para referenciarlos después
DECLARE @o1  UNIQUEIDENTIFIER = NEWID();
DECLARE @o2  UNIQUEIDENTIFIER = NEWID();
DECLARE @o3  UNIQUEIDENTIFIER = NEWID();
DECLARE @o4  UNIQUEIDENTIFIER = NEWID();
DECLARE @o5  UNIQUEIDENTIFIER = NEWID();
DECLARE @o6  UNIQUEIDENTIFIER = NEWID();
DECLARE @o7  UNIQUEIDENTIFIER = NEWID();
DECLARE @o8  UNIQUEIDENTIFIER = NEWID();
DECLARE @o9  UNIQUEIDENTIFIER = NEWID();
DECLARE @o10 UNIQUEIDENTIFIER = NEWID();

INSERT INTO [order] (id, customer_id, user_id, order_date, status, total) VALUES
(@o1,  @cust1,  @usr1, SYSDATETIMEOFFSET(), 'COMPLETED', 2500000.00),
(@o2,  @cust2,  @usr2, SYSDATETIMEOFFSET(), 'COMPLETED',   85000.00),
(@o3,  @cust3,  @usr1, SYSDATETIMEOFFSET(), 'PENDING',    185000.00),
(@o4,  @cust4,  @usr3, SYSDATETIMEOFFSET(), 'COMPLETED',  320000.00),
(@o5,  @cust5,  @usr2, SYSDATETIMEOFFSET(), 'CANCELLED',   95000.00),
(@o6,  @cust6,  @usr4, SYSDATETIMEOFFSET(), 'COMPLETED',   65000.00),
(@o7,  @cust7,  @usr1, SYSDATETIMEOFFSET(), 'PENDING',     75000.00),
(@o8,  @cust8,  @usr5, SYSDATETIMEOFFSET(), 'COMPLETED',   42000.00),
(@o9,  @cust9,  @usr3, SYSDATETIMEOFFSET(), 'COMPLETED',  285000.00),
(@o10, @cust10, @usr2, SYSDATETIMEOFFSET(), 'PENDING',     35000.00);
GO

DECLARE @oo1  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [order] ORDER BY order_date ASC OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY);
DECLARE @oo2  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [order] ORDER BY order_date ASC OFFSET 1 ROWS FETCH NEXT 1 ROWS ONLY);
DECLARE @oo3  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [order] ORDER BY order_date ASC OFFSET 2 ROWS FETCH NEXT 1 ROWS ONLY);
DECLARE @oo4  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [order] ORDER BY order_date ASC OFFSET 3 ROWS FETCH NEXT 1 ROWS ONLY);
DECLARE @oo5  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [order] ORDER BY order_date ASC OFFSET 4 ROWS FETCH NEXT 1 ROWS ONLY);
DECLARE @oo6  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [order] ORDER BY order_date ASC OFFSET 5 ROWS FETCH NEXT 1 ROWS ONLY);
DECLARE @oo7  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [order] ORDER BY order_date ASC OFFSET 6 ROWS FETCH NEXT 1 ROWS ONLY);
DECLARE @oo8  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [order] ORDER BY order_date ASC OFFSET 7 ROWS FETCH NEXT 1 ROWS ONLY);
DECLARE @oo9  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [order] ORDER BY order_date ASC OFFSET 8 ROWS FETCH NEXT 1 ROWS ONLY);
DECLARE @oo10 UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [order] ORDER BY order_date ASC OFFSET 9 ROWS FETCH NEXT 1 ROWS ONLY);

DECLARE @pr1  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM product WHERE name = 'Laptop HP 15"');
DECLARE @pr2  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM product WHERE name = 'Camiseta Polo Classic');
DECLARE @pr3  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM product WHERE name = 'Aceite de Oliva 500ml');
DECLARE @pr4  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM product WHERE name = 'Lámpara LED de Escritorio');
DECLARE @pr5  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM product WHERE name = 'Balón de Fútbol Pro');
DECLARE @pr6  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM product WHERE name = 'Set de Lego 500 piezas');
DECLARE @pr7  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM product WHERE name = 'Libro "Clean Code"');
DECLARE @pr8  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM product WHERE name = 'Taladro Eléctrico 600W');
DECLARE @pr9  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM product WHERE name = 'Crema Hidratante 200ml');
DECLARE @pr10 UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM product WHERE name = 'Filtro de Aceite Universal');

INSERT INTO order_item (id, order_id, product_id, qty, unit_price) VALUES
(NEWID(), @oo1,  @pr1,  1, 2500000.00),
(NEWID(), @oo2,  @pr2,  1,   85000.00),
(NEWID(), @oo3,  @pr6,  1,  185000.00),
(NEWID(), @oo4,  @pr8,  1,  320000.00),
(NEWID(), @oo5,  @pr5,  1,   95000.00),
(NEWID(), @oo6,  @pr4,  1,   65000.00),
(NEWID(), @oo7,  @pr7,  1,   75000.00),
(NEWID(), @oo8,  @pr9,  1,   42000.00),
(NEWID(), @oo9,  @pr3,  10,  28000.00),
(NEWID(), @oo10, @pr10, 1,   35000.00);
GO

-- ============================================================
-- SCHEMA: PAYMENT
-- ============================================================

INSERT INTO method_payment (id, name, description) VALUES
(NEWID(), 'Efectivo',            'Pago en efectivo en punto de venta'),
(NEWID(), 'Tarjeta de Crédito',  'Visa, Mastercard, Amex'),
(NEWID(), 'Tarjeta de Débito',   'Débito directo a cuenta bancaria'),
(NEWID(), 'Transferencia PSE',   'Pago en línea PSE'),
(NEWID(), 'Nequi',               'Pago por billetera digital Nequi'),
(NEWID(), 'Daviplata',           'Pago por billetera digital Daviplata'),
(NEWID(), 'Cheque',              'Pago mediante cheque bancario'),
(NEWID(), 'Criptomoneda',        'Pago en Bitcoin o USDT'),
(NEWID(), 'Contraentrega',       'Pago al recibir el pedido'),
(NEWID(), 'Crédito Empresarial', 'Crédito a 30/60/90 días');
GO

-- ============================================================
-- SCHEMA: BILLING
-- ============================================================

DECLARE @inv1  UNIQUEIDENTIFIER = NEWID();
DECLARE @inv2  UNIQUEIDENTIFIER = NEWID();
DECLARE @inv3  UNIQUEIDENTIFIER = NEWID();
DECLARE @inv4  UNIQUEIDENTIFIER = NEWID();
DECLARE @inv5  UNIQUEIDENTIFIER = NEWID();
DECLARE @inv6  UNIQUEIDENTIFIER = NEWID();
DECLARE @inv7  UNIQUEIDENTIFIER = NEWID();
DECLARE @inv8  UNIQUEIDENTIFIER = NEWID();
DECLARE @inv9  UNIQUEIDENTIFIER = NEWID();
DECLARE @inv10 UNIQUEIDENTIFIER = NEWID();

DECLARE @ic1   UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM customer ORDER BY id OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY);
DECLARE @ic2   UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM customer ORDER BY id OFFSET 1 ROWS FETCH NEXT 1 ROWS ONLY);
DECLARE @ic3   UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM customer ORDER BY id OFFSET 2 ROWS FETCH NEXT 1 ROWS ONLY);
DECLARE @ic4   UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM customer ORDER BY id OFFSET 3 ROWS FETCH NEXT 1 ROWS ONLY);
DECLARE @ic5   UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM customer ORDER BY id OFFSET 4 ROWS FETCH NEXT 1 ROWS ONLY);
DECLARE @ic6   UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM customer ORDER BY id OFFSET 5 ROWS FETCH NEXT 1 ROWS ONLY);
DECLARE @ic7   UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM customer ORDER BY id OFFSET 6 ROWS FETCH NEXT 1 ROWS ONLY);
DECLARE @ic8   UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM customer ORDER BY id OFFSET 7 ROWS FETCH NEXT 1 ROWS ONLY);
DECLARE @ic9   UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM customer ORDER BY id OFFSET 8 ROWS FETCH NEXT 1 ROWS ONLY);
DECLARE @ic10  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM customer ORDER BY id OFFSET 9 ROWS FETCH NEXT 1 ROWS ONLY);

DECLARE @ioo1  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [order] ORDER BY order_date OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY);
DECLARE @ioo2  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [order] ORDER BY order_date OFFSET 1 ROWS FETCH NEXT 1 ROWS ONLY);
DECLARE @ioo3  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [order] ORDER BY order_date OFFSET 2 ROWS FETCH NEXT 1 ROWS ONLY);
DECLARE @ioo4  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [order] ORDER BY order_date OFFSET 3 ROWS FETCH NEXT 1 ROWS ONLY);
DECLARE @ioo5  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [order] ORDER BY order_date OFFSET 4 ROWS FETCH NEXT 1 ROWS ONLY);
DECLARE @ioo6  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [order] ORDER BY order_date OFFSET 5 ROWS FETCH NEXT 1 ROWS ONLY);
DECLARE @ioo7  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [order] ORDER BY order_date OFFSET 6 ROWS FETCH NEXT 1 ROWS ONLY);
DECLARE @ioo8  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [order] ORDER BY order_date OFFSET 7 ROWS FETCH NEXT 1 ROWS ONLY);
DECLARE @ioo9  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [order] ORDER BY order_date OFFSET 8 ROWS FETCH NEXT 1 ROWS ONLY);
DECLARE @ioo10 UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM [order] ORDER BY order_date OFFSET 9 ROWS FETCH NEXT 1 ROWS ONLY);

INSERT INTO invoice (id, order_id, customer_id, invoice_number, issue_date, total, tax) VALUES
(@inv1,  @ioo1,  @ic1,  'FAC-2024-0001', SYSDATETIMEOFFSET(), 2500000.00, 475000.00),
(@inv2,  @ioo2,  @ic2,  'FAC-2024-0002', SYSDATETIMEOFFSET(),   85000.00,  16150.00),
(@inv3,  @ioo3,  @ic3,  'FAC-2024-0003', SYSDATETIMEOFFSET(),  185000.00,  35150.00),
(@inv4,  @ioo4,  @ic4,  'FAC-2024-0004', SYSDATETIMEOFFSET(),  320000.00,  60800.00),
(@inv5,  @ioo5,  @ic5,  'FAC-2024-0005', SYSDATETIMEOFFSET(),   95000.00,  18050.00),
(@inv6,  @ioo6,  @ic6,  'FAC-2024-0006', SYSDATETIMEOFFSET(),   65000.00,  12350.00),
(@inv7,  @ioo7,  @ic7,  'FAC-2024-0007', SYSDATETIMEOFFSET(),   75000.00,  14250.00),
(@inv8,  @ioo8,  @ic8,  'FAC-2024-0008', SYSDATETIMEOFFSET(),   42000.00,   7980.00),
(@inv9,  @ioo9,  @ic9,  'FAC-2024-0009', SYSDATETIMEOFFSET(),  280000.00,  53200.00),
(@inv10, @ioo10, @ic10, 'FAC-2024-0010', SYSDATETIMEOFFSET(),   35000.00,   6650.00);
GO

DECLARE @fi1  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM invoice WHERE invoice_number = 'FAC-2024-0001');
DECLARE @fi2  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM invoice WHERE invoice_number = 'FAC-2024-0002');
DECLARE @fi3  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM invoice WHERE invoice_number = 'FAC-2024-0003');
DECLARE @fi4  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM invoice WHERE invoice_number = 'FAC-2024-0004');
DECLARE @fi5  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM invoice WHERE invoice_number = 'FAC-2024-0005');
DECLARE @fi6  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM invoice WHERE invoice_number = 'FAC-2024-0006');
DECLARE @fi7  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM invoice WHERE invoice_number = 'FAC-2024-0007');
DECLARE @fi8  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM invoice WHERE invoice_number = 'FAC-2024-0008');
DECLARE @fi9  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM invoice WHERE invoice_number = 'FAC-2024-0009');
DECLARE @fi10 UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM invoice WHERE invoice_number = 'FAC-2024-0010');

DECLARE @fpr1  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM product WHERE name = 'Laptop HP 15"');
DECLARE @fpr2  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM product WHERE name = 'Camiseta Polo Classic');
DECLARE @fpr3  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM product WHERE name = 'Aceite de Oliva 500ml');
DECLARE @fpr4  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM product WHERE name = 'Lámpara LED de Escritorio');
DECLARE @fpr5  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM product WHERE name = 'Balón de Fútbol Pro');
DECLARE @fpr6  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM product WHERE name = 'Set de Lego 500 piezas');
DECLARE @fpr7  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM product WHERE name = 'Libro "Clean Code"');
DECLARE @fpr8  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM product WHERE name = 'Taladro Eléctrico 600W');
DECLARE @fpr9  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM product WHERE name = 'Crema Hidratante 200ml');
DECLARE @fpr10 UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM product WHERE name = 'Filtro de Aceite Universal');

INSERT INTO invoice_item (id, invoice_id, product_id, quantity, unit_price, total) VALUES
(NEWID(), @fi1,  @fpr1,  1,  2500000.00, 2500000.00),
(NEWID(), @fi2,  @fpr2,  1,    85000.00,   85000.00),
(NEWID(), @fi3,  @fpr6,  1,   185000.00,  185000.00),
(NEWID(), @fi4,  @fpr8,  1,   320000.00,  320000.00),
(NEWID(), @fi5,  @fpr5,  1,    95000.00,   95000.00),
(NEWID(), @fi6,  @fpr4,  1,    65000.00,   65000.00),
(NEWID(), @fi7,  @fpr7,  1,    75000.00,   75000.00),
(NEWID(), @fi8,  @fpr9,  1,    42000.00,   42000.00),
(NEWID(), @fi9,  @fpr3,  10,   28000.00,  280000.00),
(NEWID(), @fi10, @fpr10, 1,    35000.00,   35000.00);
GO

DECLARE @mp1 UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM method_payment WHERE name = 'Efectivo');
DECLARE @mp2 UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM method_payment WHERE name = 'Tarjeta de Crédito');
DECLARE @mp3 UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM method_payment WHERE name = 'Tarjeta de Débito');
DECLARE @mp4 UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM method_payment WHERE name = 'Transferencia PSE');
DECLARE @mp5 UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM method_payment WHERE name = 'Nequi');

DECLARE @pfi1  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM invoice WHERE invoice_number = 'FAC-2024-0001');
DECLARE @pfi2  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM invoice WHERE invoice_number = 'FAC-2024-0002');
DECLARE @pfi3  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM invoice WHERE invoice_number = 'FAC-2024-0003');
DECLARE @pfi4  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM invoice WHERE invoice_number = 'FAC-2024-0004');
DECLARE @pfi5  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM invoice WHERE invoice_number = 'FAC-2024-0005');
DECLARE @pfi6  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM invoice WHERE invoice_number = 'FAC-2024-0006');
DECLARE @pfi7  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM invoice WHERE invoice_number = 'FAC-2024-0007');
DECLARE @pfi8  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM invoice WHERE invoice_number = 'FAC-2024-0008');
DECLARE @pfi9  UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM invoice WHERE invoice_number = 'FAC-2024-0009');
DECLARE @pfi10 UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM invoice WHERE invoice_number = 'FAC-2024-0010');

INSERT INTO payment (id, invoice_id, method_payment_id, amount, payment_date, status) VALUES
(NEWID(), @pfi1,  @mp2, 2500000.00, SYSDATETIMEOFFSET(), 'PAID'),
(NEWID(), @pfi2,  @mp1,   85000.00, SYSDATETIMEOFFSET(), 'PAID'),
(NEWID(), @pfi3,  @mp4,  185000.00, SYSDATETIMEOFFSET(), 'PENDING'),
(NEWID(), @pfi4,  @mp3,  320000.00, SYSDATETIMEOFFSET(), 'PAID'),
(NEWID(), @pfi5,  @mp1,   95000.00, SYSDATETIMEOFFSET(), 'REFUNDED'),
(NEWID(), @pfi6,  @mp5,   65000.00, SYSDATETIMEOFFSET(), 'PAID'),
(NEWID(), @pfi7,  @mp2,   75000.00, SYSDATETIMEOFFSET(), 'PENDING'),
(NEWID(), @pfi8,  @mp1,   42000.00, SYSDATETIMEOFFSET(), 'PAID'),
(NEWID(), @pfi9,  @mp4,  280000.00, SYSDATETIMEOFFSET(), 'PAID'),
(NEWID(), @pfi10, @mp3,   35000.00, SYSDATETIMEOFFSET(), 'PENDING');
GO

-- ============================================================
-- FIN DE INSERTS
-- ============================================================

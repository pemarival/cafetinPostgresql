CREATE TABLE person (
    idPerson SERIAL PRIMARY KEY,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    email VARCHAR(100)
);

CREATE TABLE "user" (
    idUser SERIAL PRIMARY KEY,
    idPerson INT NOT NULL,
    userName VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(50) NOT NULL,
    
    FOREIGN KEY (idPerson) REFERENCES person(idPerson)
);

CREATE TABLE "role" (
    idRole SERIAL PRIMARY KEY,
    roleName VARCHAR(50) NOT NULL
);

CREATE TABLE userRole (
    idUserRole SERIAL PRIMARY KEY,
    idUser INT NOT NULL,
    idRole INT NOT NULL,
    
    FOREIGN KEY (idUser) REFERENCES "user"(idUser),
    FOREIGN KEY (idRole) REFERENCES "role"(idRole)
);

CREATE TABLE category (
    idCategory SERIAL PRIMARY KEY,
    categoryName VARCHAR(50) NOT NULL
);

CREATE TABLE product (
    idProduct SERIAL PRIMARY KEY,
    productName VARCHAR(100) NOT NULL,
    price NUMERIC(10,2) NOT NULL,
    idCategory INT NOT NULL,
    
    FOREIGN KEY (idCategory) REFERENCES category(idCategory)
);

CREATE TABLE bill (
    idBill SERIAL PRIMARY KEY,
    idUser INT NOT NULL,
    billDate TIMESTAMP DEFAULT NOW(),
    
    FOREIGN KEY (idUser) REFERENCES "user"(idUser)
);

CREATE TABLE billDetail (
    idBillDetail SERIAL PRIMARY KEY,
    idBill INT NOT NULL,
    idProduct INT NOT NULL,
    quantity INT NOT NULL,
    subtotal NUMERIC(10,2) NOT NULL,
    
    FOREIGN KEY (idBill) REFERENCES bill(idBill),
    FOREIGN KEY (idProduct) REFERENCES product(idProduct)
);
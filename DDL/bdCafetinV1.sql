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

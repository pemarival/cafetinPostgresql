INSERT INTO person (firstName, lastName, email)
VALUES 
('Mariana', 'Valenzuela', 'mariana@email.com'),
('Carlos', 'Ramirez', 'carlos@email.com'),
('Laura', 'Gomez', 'laura@email.com');

INSERT INTO "user" (idPerson, userName, password)
VALUES 
(1, 'mvalenzuela', '123456'),
(2, 'cramirez', '123456'),
(3, 'lgomez', '123456');

INSERT INTO "role" (roleName)
VALUES 
('ADMIN'),
('USER'),
('SUPPORT');

INSERT INTO userRole (idUserRole, idUser, idRole)
VALUES 
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `punctuations`, `cities`, `images`, `policies`, `products_policies`, `characteristics`, `products_characteristics`,`products`,`categories`, `bookings`, `favourites`;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE IF NOT EXISTS categories (
	cat_id INT NOT NULL AUTO_INCREMENT,
    cat_title VARCHAR(100) NOT NULL,
    cat_description VARCHAR(500),
    cat_url_img VARCHAR(500) NOT NULL,
    PRIMARY KEY(cat_id)
);

CREATE TABLE IF NOT EXISTS cities (
	city_id INT NOT NULL AUTO_INCREMENT,
    city_name VARCHAR(100) NOT NULL,
    city_country VARCHAR(100) NOT NULL,
    PRIMARY KEY(city_id)
);

CREATE TABLE IF NOT EXISTS products (
	prod_id INT NOT NULL AUTO_INCREMENT,
    cat_id INT NOT NULL,
    city_id INT NOT NULL,
    prod_address VARCHAR(300) NOT NULL,
    prod_name VARCHAR(100) NOT NULL,
    prod_punctuation SMALLINT,
    prod_stars DECIMAL(2,1),
    prod_desc_title VARCHAR(100),
    prod_desc VARCHAR(500),
    prod_x NUMERIC (18,10),
	prod_y NUMERIC (18,10),
    prod_score VARCHAR(50),
    PRIMARY KEY(prod_id),
    FOREIGN KEY(cat_id) REFERENCES categories(cat_id),
    FOREIGN KEY(city_id) REFERENCES cities(city_id)
);

CREATE TABLE IF NOT EXISTS images (
	img_id INT NOT NULL AUTO_INCREMENT,
    prod_id INT NOT NULL,
    img_url VARCHAR(8000) NOT NULL,
    PRIMARY KEY(img_id),
    FOREIGN KEY(prod_id) REFERENCES products(prod_id)
);

CREATE TABLE IF NOT EXISTS characteristics (
	charact_id INT NOT NULL AUTO_INCREMENT,
    charact_title VARCHAR(100) NOT NULL,
    charact_class VARCHAR(100) NOT NULL,
    PRIMARY KEY(charact_id)
);

CREATE TABLE IF NOT EXISTS products_characteristics (
	prod_charact_id INT NOT NULL AUTO_INCREMENT,
    prod_id INT NOT NULL,
    charact_id INT NOT NULL,
    PRIMARY KEY(prod_charact_id),
    FOREIGN KEY(prod_id) REFERENCES products(prod_id),
    FOREIGN KEY(charact_id) REFERENCES characteristics(charact_id)
);

CREATE TABLE IF NOT EXISTS policies (
	policies_id INT NOT NULL AUTO_INCREMENT,
    policies_title VARCHAR(100) NOT NULL,
    policies_desc VARCHAR(500) NOT NULL,
    PRIMARY KEY(policies_id)
);

CREATE TABLE IF NOT EXISTS products_policies (
	prod_policies_id INT NOT NULL AUTO_INCREMENT,
    prod_id INT NOT NULL,
    policies_id INT NOT NULL,
    PRIMARY KEY(prod_policies_id),
    FOREIGN KEY(prod_id) REFERENCES products(prod_id),
    FOREIGN KEY(policies_id) REFERENCES policies(policies_id)
);

CREATE TABLE IF NOT EXISTS roles(
role_id INT NOT NULL AUTO_INCREMENT,
role_name VARCHAR(100) NOT NULL,
PRIMARY KEY(role_id)
);

CREATE TABLE IF NOT EXISTS users (
user_id INT NOT NULL AUTO_INCREMENT,
role_id INT NOT NULL,
user_name VARCHAR(100) NOT NULL,
user_surname VARCHAR(100) NOT NULL,
user_email VARCHAR(100) NOT NULL,
user_password CHAR(60) NOT NULL,
user_city VARCHAR(100) NOT NULL,
PRIMARY KEY(user_id),
FOREIGN KEY (role_id) REFERENCES roles(role_id)
);

CREATE TABLE IF NOT EXISTS punctuations (
	punct_id INT NOT NULL AUTO_INCREMENT,
    prod_id INT NOT NULL,
    user_id INT NOT NULL,
    punct_value DECIMAL(2,1) NOT NULL,
    PRIMARY KEY(punct_id),
    FOREIGN KEY(prod_id) REFERENCES products(prod_id),
    FOREIGN KEY(user_id) REFERENCES users(user_id)
);

CREATE TABLE IF NOT EXISTS bookings (
booking_id INT NOT NULL AUTO_INCREMENT,
prod_id INT NOT NULL,
user_id INT NOT NULL,
booking_start_time TIME,
booking_start_date DATE,
booking_finish_date DATE,
booking_vaccine_covid BIT,
booking_userinfo_covid VARCHAR(500),
PRIMARY KEY(booking_id),
FOREIGN KEY (prod_id) REFERENCES products(prod_id),
FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE IF NOT EXISTS favourites (
fav_id INT NOT NULL AUTO_INCREMENT,
prod_id INT NOT NULL,
user_id INT NOT NULL,
PRIMARY KEY(fav_id),
FOREIGN KEY (prod_id) REFERENCES products(prod_id),
FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO roles (role_name) VALUES("ADMIN"),("USER");

INSERT INTO users (role_id, user_name, user_surname, user_email, user_password, user_city)
VALUES
(2, "Maria", "Acosta", "maria@email.com", "password1", 1),
(2, "Juan", "Corral", "juan@email.com", "password2", 2),
(2, "Valeria", "Lopez", "valeria@email.com", "password3", 3),
(2, "Franco", "Elias", "franco@email.com", "password4", 4);

INSERT INTO categories (cat_title,cat_description,cat_url_img)
VALUES ("Hotel","821.458 hoteles","https://images.unsplash.com/photo-1629140727571-9b5c6f6267b4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1527&q=80"),
("Hostels","821.458 Hostels","https://images.unsplash.com/photo-1555854877-bab0e564b8d5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1469&q=80"),
("Departamentos","821.458 Departamentos","https://images.unsplash.com/photo-1581404569456-a2e7007c3979?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1469&q=80"),
("Bed and Breakfast","821.458 Bed and Breakfast","https://images.unsplash.com/photo-1584602755303-759bf3645954?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1287&q=80");

INSERT INTO cities(city_name,city_country)
VALUES
("Buenos Aires","Argentina"),
("Rosario","Argentina"),
("Entre Rios","Argentina"),
("Cordoba","Argentina"),
("Mar del Plata","Argentina"),
("Salta","Argentina"),
("Santa Fe","Argentina"),
("San Salvador de Jujuy","Argentina"),
("San Luis","Argentina"),
("San Carlos de Bariloche","Argentina"),
("Comodoro Rivadavia","Argentina"),
("Mendoza","Argentina");

INSERT INTO products (cat_id,city_id,prod_address,prod_name,prod_stars,prod_desc_title,prod_desc,prod_x,prod_y,prod_score,prod_punctuation)
VALUES
(1, 1, "San Martin 231", "Hotel el Pacífico", 5,"Hotel el Pacífico", "Hotel el Pacífico, ubicado a tan solo 940 metros del centro, ofrece una grandiosa calidad en sus alojamientos junto con varios servicios para garantizar la comodidad del turista.", "-59.1235862000", "-34.5641632000", "MUY BUENO",8),
(2, 2, "Lavalle 345", "Hostel Argentina", 3, "Hostel Argentina", "Hostel Argentina, ubicado a tan solo 940 metros del centro, le garantiza a los turistas experiencia agradable durante toda su estadía, con habitaciones tanto compartidas como privadas, y servicios pensados en lo mejor para el turista", "-59.1235862000", "-34.5641632000", "BUENO",7),
(3, 3, "Cordoba 999", "Dpto La Ventana", 4, "Depto La Ventana", "El Departamento La Ventana, ubicado a tan solo 940 metros del centro, es un departamento confortable y moderno, para que el turista siempre se sienta como en casa. Ofrecemos una serie de servicios para garantizarle la comodidad.", "-59.1235862000", "-34.5641632000", "MUY BUENO",9),
(4, 4, "Mendoza 1020", "Bed and Breakfast Paraíso", 2, "Bed and Breakfast Paraíso", "Podrá relajarse en las cómodas habitaciones de Bed and Breakfast Paraíso. Ubicado a tan solo 940 metros del centro, ofrecemos calidad en todos nuestros servicios, pensando en lo mejor para el turista.", "-59.1235862000", "-34.5641632000", "MALO",3),
(1, 5, "Alsina 45", "Hotel El Mar", 3, "Hotel El Mar", "Hotel el Mar, ubicado a tan solo 940 m del centro, ofrece una grandiosa calidad en sus alojamientos junto con varios servicios para garantizar la comodidad del turista.", "-59.1235862000", "-34.5641632000", "BUENO",6),
(2, 6, "San Martin 5300", "Hostel Los Árboles", 4,"Hostel Los Árboles", "Hostel Los Árboles, ubicado a tan solo 940 metros del centro, le garantiza a los turistas experiencia agradable durante toda su estadía, con habitaciones tanto compartidas como privadas, y servicios pensados en lo mejor para el turista", "-59.1235862000", "-34.5641632000", "EXCELENTE",10),
(3, 7, "9 de Julio 33", "Dpto Santa Fe", 3, "Dpto Santa Fe", "El Departamento Santa Fe, ubicado a tan solo 940 metros del centro, es un departamento confortable y moderno, para que el turista siempre se sienta como en casa. Ofrecemos una serie de servicios para garantizarle la comodidad.", "-59.1235862000", "-34.5641632000", "BUENO",7),
(4, 8, "Francia 102", "Bed and Breakfast Oasis", 5, "Bed and Breakfast Oasis", "Podrá relajarse en las cómodas habitaciones de Bed and Breakfast Oasis. Ubicado a tan solo 940 metros del centro, ofrecemos calidad en todos nuestros servicios, pensando en lo mejor para el turista.", "-59.1235862000", "-34.5641632000", "MUY BUENO",8),
(1, 9, "Mitre 78", "Hotel Los Sueños", 4, "Hotel Los Sueños", "Hotel Los Sueños, ubicado a tan solo 940 m del centro, ofrece una grandiosa calidad en sus alojamientos junto con varios servicios para garantizar la comodidad del turista.", "-59.1235862000", "-34.5641632000", "MUY BUENO",7),
(2, 10, "Corrientes 582", "Hostel Cristal", 1, "Hotel Cristal", "Hostel Cristal, ubicado a tan solo 940 metros del centro, le garantiza a los turistas experiencia agradable durante toda su estadía, con habitaciones tanto compartidas como privadas, y servicios pensados en lo mejor para el turista", "-59.1235862000", "-34.5641632000", "MALO",2),
(3, 11, "La Paz 10","Dpto Las Estrellas", 3, "Dpto Las Estrellas", "El Departamento Las Estrellas, ubicado a tan solo 940 metros del centro, es un departamento confortable y moderno, para que el turista siempre se sienta como en casa. Ofrecemos una serie de servicios para garantizarle la comodidad.", "-59.1235862000", "-34.5641632000", "BUENO",5),
(4, 12, "Pasco 2404", "Bed and Breakfast Palace", 3, "Bed and Breakfast Palace", "Podrá relajarse en las cómodas habitaciones de Bed and Breakfast Palace. Ubicado a tan solo 940 metros del centro, ofrecemos calidad en todos nuestros servicios, pensando en lo mejor para el turista.", "-59.1235862000", "-34.5641632000", "BUENO",5);

INSERT INTO images (prod_id, img_url)
VALUES
(1, "https://images.unsplash.com/photo-1496417263034-38ec4f0b665a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=871&q=80"),
(1, "https://images.unsplash.com/photo-1523699289804-55347c09047d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
(1, "https://images.unsplash.com/photo-1533759413974-9e15f3b745ac?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80"),
(1, "https://images.unsplash.com/flagged/photo-1556438758-1d61c8c65409?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=874&q=80"),
(1, "https://images.unsplash.com/photo-1577784424946-e12c7b211249?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80"),
(2, "https://images.unsplash.com/photo-1551133988-dfabc2928c5f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
(2, "https://images.unsplash.com/photo-1549416878-30862a3e49e7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
(2, "https://images.unsplash.com/photo-1551133988-1ca0f12a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
(2, "https://images.unsplash.com/photo-1551133989-6a6512ad3915?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=381&q=80"),
(2, "https://images.unsplash.com/photo-1507038772120-7fff76f79d79?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1374&q=80"),
(3, "https://images.unsplash.com/photo-1631049035634-c04c637651b1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"),
(3, "https://images.unsplash.com/photo-1530334607928-b6c79a013fa4?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=869"),
(3, "https://images.unsplash.com/photo-1629140727571-9b5c6f6267b4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=327&q=80"),
(3, "https://images.unsplash.com/photo-1524292691042-82ed9c62673b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
(3, "https://images.unsplash.com/photo-1532372576444-dda954194ad0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
(4, "https://images.unsplash.com/photo-1618773928121-c32242e63f39?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"),
(4, "https://images.unsplash.com/photo-1596701062351-8c2c14d1fdd0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
(4, "https://images.unsplash.com/photo-1605651531144-51381895e23d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
(4, "https://images.unsplash.com/photo-1445991842772-097fea258e7b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"),
(4, "https://images.unsplash.com/photo-1470290378698-263fa7ca60ab?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80"),
(5, "https://images.unsplash.com/photo-1455587734955-081b22074882?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"),
(5, "https://images.unsplash.com/photo-1603428760740-c0089e3760f2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"),
(5, "https://images.unsplash.com/photo-1586105251261-72a756497a11?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=658&q=80"),
(5, "https://images.unsplash.com/photo-1484101403633-562f891dc89a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=874&q=80"),
(5, "https://images.unsplash.com/photo-1551632436-cbf8dd35adfa?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=871&q=80"),
(6, "https://images.unsplash.com/photo-1555854877-bab0e564b8d5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=869&q=80"),
(6, "https://images.unsplash.com/photo-1566978068475-22a47268a416?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80"),
(6, "https://images.unsplash.com/photo-1599615381612-7bcc78cfd851?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80"),
(6, "https://images.unsplash.com/photo-1574294606536-39c40360078a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80"),
(6, "https://images.unsplash.com/photo-1626265774643-f1943311a86b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"),
(7, "https://images.unsplash.com/photo-1591088398332-8a7791972843?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1374&q=80"),
(7, "https://images.unsplash.com/photo-1583847268964-b28dc8f51f92?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
(7, "https://images.unsplash.com/photo-1610527003928-47afd5f470c6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=872&q=80"),
(7, "https://images.unsplash.com/photo-1565031491910-e57fac031c41?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80"),
(7, "https://images.unsplash.com/photo-1529316738131-4d0e0761a38e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
(8, "https://images.unsplash.com/photo-1618111415065-c20b4e1afd41?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
(8, "https://images.unsplash.com/photo-1616627686733-122fec9d87b2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"),
(8, "https://images.unsplash.com/photo-1530610476181-d83430b64dcd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80"),
(8, "https://images.unsplash.com/photo-1606246481699-f16245882373?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=466&q=80"),
(8, "https://images.unsplash.com/photo-1572786258684-9b3d5671e7d8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"),
(9, "https://images.unsplash.com/photo-1496417263034-38ec4f0b665a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=871&q=80"),
(9, "https://images.unsplash.com/photo-1523699289804-55347c09047d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
(9, "https://images.unsplash.com/photo-1533759413974-9e15f3b745ac?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80"),
(9, "https://images.unsplash.com/flagged/photo-1556438758-1d61c8c65409?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=874&q=80"),
(9, "https://images.unsplash.com/photo-1577784424946-e12c7b211249?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80"),
(10, "https://images.unsplash.com/photo-1551133988-dfabc2928c5f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
(10, "https://images.unsplash.com/photo-1549416878-30862a3e49e7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
(10, "https://images.unsplash.com/photo-1551133988-1ca0f12a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
(10, "https://images.unsplash.com/photo-1551133989-6a6512ad3915?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=381&q=80"),
(10, "https://images.unsplash.com/photo-1507038772120-7fff76f79d79?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1374&q=80"),
(11, "https://images.unsplash.com/photo-1631049035634-c04c637651b1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"),
(11, "https://images.unsplash.com/photo-1530334607928-b6c79a013fa4?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=869"),
(11, "https://images.unsplash.com/photo-1629140727571-9b5c6f6267b4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=327&q=80"),
(11, "https://images.unsplash.com/photo-1524292691042-82ed9c62673b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
(11, "https://images.unsplash.com/photo-1532372576444-dda954194ad0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
(12, "https://images.unsplash.com/photo-1618773928121-c32242e63f39?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"),
(12, "https://images.unsplash.com/photo-1596701062351-8c2c14d1fdd0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
(12, "https://images.unsplash.com/photo-1605651531144-51381895e23d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
(12, "https://images.unsplash.com/photo-1445991842772-097fea258e7b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"),
(12, "https://images.unsplash.com/photo-1470290378698-263fa7ca60ab?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80");

INSERT INTO characteristics (charact_title, charact_class)
VALUES
("Cocina", "li__cocina"),
("Estacionamiento Gratuito", "li__estacionamiento-gratuito"),
("Televisor", "li__televisor"),
("Pileta", "li__pileta"),
("Aire Acondicionado", "li__aire-acondicionado"),
("Wifi", "li__wifi"),
("Apto Mascotas", "li__apto-mascotas");

INSERT INTO policies (policies_title, policies_desc)
VALUES
("Normas de la casa", "['Check-out: 10:00', 'No se permiten fiestas', 'No fumar']"),
("Salud y seguridad", "['Se aplican las pautas de distanciamiento social y otras normas relacionadas con el coronavirus', 'Detector de humo', 'Depósito de seguridad']"),
("Politica de Cancelación", "['Agregá las fechas de tu viaje para obtener los detalles de cancelación de esta estadía.']");

INSERT INTO products_characteristics (prod_id, charact_id)
VALUES
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7),
(2, 1), (2, 3), (2, 6),
(3, 1), (3, 2), (3, 3), (3, 5), (3, 6),
(4, 2), (4, 3), (4, 5), (4, 6),
(5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (5, 7),
(6, 1), (6, 3), (6, 6),
(7, 1), (7, 2), (7, 3), (7, 5), (7, 6),
(8, 2), (8, 3), (8, 5), (8, 6),
(9, 1), (9, 2), (9, 3), (9, 4), (9, 5), (9, 6), (9, 7),
(10, 1), (10, 3), (10, 6),
(11, 1), (11, 2), (11, 3), (11, 5), (11, 6),
(12, 2), (12, 3), (12, 5), (12, 6);

INSERT INTO products_policies (prod_id, policies_id)
VALUES
(1, 1), (1, 2), (1, 3),
(2, 1), (2, 2), (2, 3),
(3, 1), (3, 2), (3, 3),
(4, 1), (4, 2), (4, 3),
(5, 1), (5, 2), (5, 3),
(6, 1), (6, 2), (6, 3),
(7, 1), (7, 2), (7, 3),
(8, 1), (8, 2), (8, 3),
(9, 1), (9, 2), (9, 3),
(10, 1), (10, 2), (10, 3),
(11, 1), (11, 2), (11, 3),
(12, 1), (12, 2), (12, 3);

INSERT into punctuations (prod_id, user_id, punct_value)
VALUES
(1, 1, 4),
(2, 2, 3.5),
(3, 3, 4.5),
(4, 4, 1.5),
(5, 1, 3),
(6, 2, 5),
(7, 3, 3.5),
(8, 4, 4),
(9, 1, 3.5),
(10, 2, 1),
(11, 3, 2.5),
(12, 4, 2.5);
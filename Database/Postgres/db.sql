DROP DATABASE IF EXISTS overview;

CREATE DATABASE overview;

\c overview;

DROP TABLE IF EXISTS product, features, styles, photos, skus;

CREATE TABLE product (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  slogan VARCHAR(1000) NOT NULL,
  description VARCHAR(1000) NOT NULL,
  category VARCHAR(100) NOT NULL,
  default_price VARCHAR(20)
);

CREATE TABLE features (
  id SERIAL PRIMARY KEY,
  product_id INT NOT NULL,
  feature varChar(100) NOT NULL,
  value varChar(50) NOT NULL,

  FOREIGN KEY (product_id)
    REFERENCES product(id)
);

CREATE TABLE styles (
  id SERIAL PRIMARY KEY,
  productId INT NOT NULL,
  name VARCHAR(50) NOT NULL,
  sale_price VARCHAR(10),
  original_price VARCHAR(100) NOT NULL,
  default_style BOOLEAN NOT NULL,

  FOREIGN KEY (productId)
    REFERENCES product(id)
);

CREATE TABLE photos (
  id SERIAL PRIMARY KEY,
  styleId INT NOT NULL,
  url VARCHAR(500),
  thumbnail_url TEXT,

  FOREIGN KEY (styleId)
    REFERENCES styles(id)
);

CREATE TABLE skus (
  id SERIAL PRIMARY KEY,
  styleId INT NOT NULL,
  size VARCHAR(20) NOT NULL,
  quantity INT,

  FOREIGN KEY (styleId)
    REFERENCES styles(id)
);



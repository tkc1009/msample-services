set -e
psql -U postgres library << EOSQL
CREATE TABLE IF NOT EXISTS library(
    id SERIAL NOT NULL PRIMARY KEY,
    name varchar(256),
    address varchar(1000)
);

CREATE TABLE IF NOT EXISTS book_category(
    id SERIAL NOT NULL PRIMARY KEY,
    name varchar(256)
);

CREATE TABLE IF NOT EXISTS book(
    id SERIAL NOT NULL PRIMARY KEY,
    title varchar(256),
    category_id integer REFERENCES book_category (id),
    author_name varchar(256),
    isbn varchar(256),
    release_date timestamp,
    synopsis varchar(256)
);

CREATE TABLE IF NOT EXISTS book_stock(
    id SERIAL NOT NULL PRIMARY KEY,
	book_id integer REFERENCES book (id),
	library_id integer REFERENCES library (id),
    total integer
);

CREATE TABLE IF NOT EXISTS customer(
    id SERIAL NOT NULL,
    name varchar(256),
    password varchar(100),
    gender integer,
    age integer,
    favorite_book varchar(256),
    favorite_book_category integer,
    favorite_author varchar(256),
    FOREIGN KEY (favorite_book_category) REFERENCES book_category(id),
    PRIMARY KEY(id)
);
CREATE INDEX ON customer(id);
CREATE TABLE IF NOT EXISTS review(
    id  SERIAL NOT NULL PRIMARY KEY,
	book_id integer,
    customer_id integer,
    comment varchar(1000),
    rating integer,
	FOREIGN KEY (book_id) REFERENCES book(id),
    FOREIGN KEY (customer_id) REFERENCES customer(id)
);
CREATE INDEX ON review(id);

INSERT INTO book_category (name) VALUES
    ('mystery'), 
    ('suspense'), 
    ('human'), 
    ('animation');

INSERT INTO library (name, address) VALUES
    ('Toyosu Library','Toyosu'),
    ('Shinagawa Library','Shinagawa'),
    ('Komaba Library','Komaba');

INSERT INTO book (title, category_id, author_name, isbn, release_date, synopsis) VALUES
    ('title001', 1, 'author001', 'xxxxxx', cast('2017-01-01 00:00:00' as TIMESTAMP), 'Summary001'),
    ('title002', 2, 'author002', 'xxxxxx', cast('2017-02-01 00:00:00' as TIMESTAMP), 'Summary002'),
    ('title003', 3, 'author003', 'xxxxxx', cast('2017-03-01 00:00:00' as TIMESTAMP), 'Summary003'),
    ('title004', 4, 'author004', 'xxxxxx', cast('2017-04-01 00:00:00' as TIMESTAMP), 'Summary004'),
    ('title005', 4, 'author005', 'xxxxxx', cast('2017-05-01 00:00:00' as TIMESTAMP), 'Summary005');

INSERT INTO book_stock (book_id, library_id, total) VALUES
    (1, 1, 1),
    (2, 1, 2),
    (3, 1, 3),
    (4, 1, 4),
    (5, 1, 5),
    (4, 1, 6),
    (3, 1, 7),
    (2, 1, 8),
    (1, 1, 8),
    (1, 2, 1),
    (2, 2, 2),
    (3, 2, 3),
    (4, 2, 4),
    (5, 2, 5),
    (4, 2, 6),
    (3, 2, 7),
    (2, 2, 8),
    (1, 2, 8),
    (1, 3, 1),
    (2, 3, 2),
    (3, 3, 3),
    (4, 3, 4),
    (5, 3, 5),
    (4, 3, 6),
    (3, 3, 7),
    (2, 3, 8),
    (1, 3, 8);

INSERT INTO customer (name, password, gender, age, favorite_book, favorite_book_category, favorite_author) VALUES
    ('user001', 'pass001', 1, 35, 'book001', 1, 'author001'),
    ('user002', 'pass002', 2, 22, 'book001', 2, 'author002'),
    ('user003', 'pass003', 1, 18, 'book001', 3, 'author003'),
    ('user004', 'pass004', 2, 25, 'book001', 2, 'author004'),
    ('user005', 'pass005', 1, 31, 'book001', 4, 'author002');
    
INSERT INTO review (book_id, customer_id, comment, rating) VALUES
    (1,1,'Good', 5),
    (2,2,'Bad', 1),
    (3,3,'So-so', 3),
    (4,4,'Not Good', 2),
    (5,5,'well-done', 4),
    (2,4,'Great', 5),
    (3,1,'Fantastic', 5);

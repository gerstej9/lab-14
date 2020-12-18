CREATE DATABASE lab14;
-- This step is taken to create a template as a backup for our table we are normalizing

CREATE DATABASE lab14_normal WITH TEMPLATE lab14;
-- This step is creating a copy of our template for us to normalize

CREATE TABLE AUTHORS(id SERIAL PRIMARY KEY, name VARCHAR(255));
-- This step creates a second table in our new database lab14_normal

INSERT INTO authors(name) SELECT DISTINCT author FROM books;
-- This command will insert author values from our books table into the name column in our authors table while preventing any duplicate entries

ALTER TABLE books ADD COLUMN author_id INT 
-- This command adds another column to our books table titled author_id

UPDATE books SET author_id=author.id FROM (SELECT* FROM authors) AS author WHERE books.author = author.name;
-- This command provides a connection between the table books and authors

ALTER TABLE books DROP COLUMN author
-- This command will remove the author column from the table books which is now no longer needed

ALTER TABLE books ADD CONSTRAINT fk_authors FOREIGN KEY (author_id) REFERENCES authors(id);
-- This command changes the data type of author_id in the books table to indicate to psql the connection between the two tables

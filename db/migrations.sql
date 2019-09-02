DROP DATABASE IF EXISTS discuss;
CREATE DATABASE discuss;

-- connect to db
\c discuss 

CREATE TABLE students (
	id SERIAL PRIMARY KEY,
	username VARCHAR(30),
	password VARCHAR(30)
);

CREATE TABLE teachers (
	id SERIAL PRIMARY KEY,
	username VARCHAR(30),
	password VARCHAR(30)
);

CREATE TABLE challenges (
	id SERIAL PRIMARY KEY,
	teacher_id INT,
	title VARCHAR(255),
	description VARCHAR(1024),
	FOREIGN KEY (teacher_id) REFERENCES teachers(id)
);

CREATE TABLE keywords (
	id SERIAL PRIMARY KEY,
	challenge_id INT,
	keyword VARCHAR(30),
	FOREIGN KEY (challenge_id) REFERENCES challenges(id)
);

CREATE TABLE languages (
	id SERIAL PRIMARY KEY,
	challenge_id INT,
	language VARCHAR(30),
	FOREIGN KEY (challenge_id) REFERENCES challenges(id)
);

CREATE TABLE keyword_choices (
	id SERIAL PRIMARY KEY,
	keyword VARCHAR(30)
);

CREATE TABLE language_choices (
	id SERIAL PRIMARY KEY,
	language VARCHAR(30)
);




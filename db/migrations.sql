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
	keyword VARCHAR(30)
);

CREATE TABLE challenge_keywords (
	id SERIAL PRIMARY KEY,
	challenge_id INT,
	keyword_id INT,
	FOREIGN KEY (challenge_id) REFERENCES challenges(id),
	FOREIGN KEY (keyword_id) REFERENCES keywords(id)
);

CREATE TABLE languages (
	id SERIAL PRIMARY KEY,
	language VARCHAR(30)
);

CREATE TABLE challenge_languages (
	id SERIAL PRIMARY KEY,
	challenge_id INT,
	language_id INT,
	FOREIGN KEY (challenge_id) REFERENCES challenges(id),
	FOREIGN KEY (language_id) REFERENCES languages(id)
);




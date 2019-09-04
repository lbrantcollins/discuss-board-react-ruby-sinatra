DROP DATABASE IF EXISTS discuss;
CREATE DATABASE discuss;

-- connect to db
\c discuss 

CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	username VARCHAR(30),
	password VARCHAR(30),
	teacher BOOLEAN
);

CREATE TABLE teachers (
	id SERIAL PRIMARY KEY,
	teacher_id INT,
	FOREIGN KEY (teacher_id) REFERENCES users(id)
);

CREATE TABLE students (
	id SERIAL PRIMARY KEY,
	student_id INT,
	FOREIGN KEY (student_id) REFERENCES users(id)
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

CREATE TABLE questions (
	id SERIAL PRIMARY KEY,
	challenge_id INT,
	student_id INT,
	question VARCHAR(1024),
	substantial BOOLEAN,
	FOREIGN KEY (challenge_id) REFERENCES challenges(id),
	FOREIGN KEY (student_id) REFERENCES students(id)
);

CREATE TABLE answers (
	id SERIAL PRIMARY KEY,
	question_id INT,
	teacher_id INT,
	answer VARCHAR(1024),
	FOREIGN KEY (question_id) REFERENCES questions(id),
	FOREIGN KEY (teacher_id) REFERENCES teachers(id)
);

CREATE TABLE snippets (
	id SERIAL PRIMARY KEY,
	challenge_id INT,
	language_id INT,
	student_id INT,
	snippet VARCHAR(8192),
	substantial BOOLEAN,
	FOREIGN KEY (challenge_id) REFERENCES challenges(id),
	FOREIGN KEY (language_id) REFERENCES languages(id),
	FOREIGN KEY (student_id) REFERENCES students(id)
);

CREATE TABLE questions (
	id SERIAL PRIMARY KEY,
	snippet_id INT,
	student_id INT,
	comment VARCHAR(1024),
	substantial BOOLEAN,
	FOREIGN KEY (snippet_id) REFERENCES snippets(id),
	FOREIGN KEY (student_id) REFERENCES students(id)
);

CREATE TABLE observations (
	id SERIAL PRIMARY KEY,
	comment_id INT,
	teacher_id INT,
	observation VARCHAR(1024),
	FOREIGN KEY (comment_id) REFERENCES comments(id),
	FOREIGN KEY (teacher_id) REFERENCES teachers(id)
);








DROP DATABASE IF EXISTS discuss;
CREATE DATABASE discuss;

-- connect to db
\c discuss 

CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	username VARCHAR(32),
	password_digest VARCHAR(60),
	is_teacher BOOLEAN
);

CREATE TABLE teachers (
	id SERIAL PRIMARY KEY,
	user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
	UNIQUE (user_id)
);

CREATE TABLE students (
	id SERIAL PRIMARY KEY,
	user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
	UNIQUE (user_id)
);

CREATE TABLE challenges (
	id SERIAL PRIMARY KEY,
	title VARCHAR(255),
	description VARCHAR(1024),
	teacher_id INTEGER REFERENCES teachers(user_id) ON DELETE CASCADE,
	date_posted TIMESTAMP DEFAULT NOW()
);

CREATE TABLE keywords (
	id SERIAL PRIMARY KEY,
	keyword VARCHAR(30)
);

CREATE TABLE challenge_keywords (
	id SERIAL PRIMARY KEY,
	challenge_id INTEGER REFERENCES challenges(id) ON DELETE CASCADE,
	keyword_id INTEGER REFERENCES keywords(id) ON DELETE CASCADE
);

CREATE TABLE languages (
	id SERIAL PRIMARY KEY,
	language VARCHAR(30)
);

CREATE TABLE challenge_languages (
	id SERIAL PRIMARY KEY,
	challenge_id INTEGER REFERENCES challenges(id) ON DELETE CASCADE,
	language_id INTEGER REFERENCES languages(id) ON DELETE CASCADE
);

CREATE TABLE questions (
	id SERIAL PRIMARY KEY,
	question VARCHAR(1024),
	substantial BOOLEAN,
	challenge_id INTEGER REFERENCES challenges(id) ON DELETE CASCADE,
	student_id INTEGER REFERENCES students(user_id) ON DELETE CASCADE,
	date_posted TIMESTAMP DEFAULT NOW()
);

CREATE TABLE responses (
	id SERIAL PRIMARY KEY,
	response VARCHAR(1024),
	question_id INTEGER REFERENCES questions(id) ON DELETE CASCADE,
	teacher_id INTEGER REFERENCES teachers(user_id) ON DELETE CASCADE,
	date_posted TIMESTAMP DEFAULT NOW()
);

CREATE TABLE snippets (
	id SERIAL PRIMARY KEY,
	snippet VARCHAR(8192),
	substantial BOOLEAN,
	challenge_id INTEGER REFERENCES challenges(id) ON DELETE CASCADE,
	language_id INTEGER REFERENCES languages(id) ON DELETE CASCADE,
	student_id INTEGER REFERENCES students(user_id) ON DELETE CASCADE,
	date_posted TIMESTAMP DEFAULT NOW()
);

CREATE TABLE comments (
	id SERIAL PRIMARY KEY,
	comment VARCHAR(1024),
	substantial BOOLEAN,
	snippet_id INTEGER REFERENCES snippets(id) ON DELETE CASCADE,
	student_id INTEGER REFERENCES students(user_id) ON DELETE CASCADE,
	date_posted TIMESTAMP DEFAULT NOW()
);

CREATE TABLE observations (
	id SERIAL PRIMARY KEY,
	observation VARCHAR(1024),
	comment_id INTEGER REFERENCES comments(id) ON DELETE CASCADE,
	teacher_id INTEGER REFERENCES teachers(user_id) ON DELETE CASCADE,
	date_posted TIMESTAMP DEFAULT NOW()
);







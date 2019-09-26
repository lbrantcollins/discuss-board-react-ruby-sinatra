
COPY users(username, password, is_teacher)
FROM '/Users/linda/Documents/Learning/GeneralAssembly/SEI/capstone/discuss-board-react-ruby-sinatra/db/users.csv' DELIMITER ',' CSV HEADER;

############## DO NOT SEED USERS ABOVE (use registration route, hashed passwords)
############## 3 teachers, 3 students (brant, t1, t2, s1, s2, s3, s4): password=username

COPY teachers(user_id)
FROM '/Users/linda/Documents/Learning/GeneralAssembly/SEI/capstone/discuss-board-react-ruby-sinatra/db/teachers.csv' DELIMITER ',' CSV HEADER;

COPY students(user_id)
FROM '/Users/linda/Documents/Learning/GeneralAssembly/SEI/capstone/discuss-board-react-ruby-sinatra/db/students.csv' DELIMITER ',' CSV HEADER;

COPY challenges(teacher_id, title, description)
FROM '/Users/linda/Documents/Learning/GeneralAssembly/SEI/capstone/discuss-board-react-ruby-sinatra/db/challenges.csv' DELIMITER ',' CSV HEADER;

COPY keywords(keyword)
FROM '/Users/linda/Documents/Learning/GeneralAssembly/SEI/capstone/discuss-board-react-ruby-sinatra/db/keywords.csv' DELIMITER ',' CSV HEADER;

COPY challenge_keywords(challenge_id, keyword_id)
FROM '/Users/linda/Documents/Learning/GeneralAssembly/SEI/capstone/discuss-board-react-ruby-sinatra/db/challenge_keywords.csv' DELIMITER ',' CSV HEADER;

COPY languages(language)
FROM '/Users/linda/Documents/Learning/GeneralAssembly/SEI/capstone/discuss-board-react-ruby-sinatra/db/languages.csv' DELIMITER ',' CSV HEADER;

COPY challenge_languages(challenge_id, language_id)
FROM '/Users/linda/Documents/Learning/GeneralAssembly/SEI/capstone/discuss-board-react-ruby-sinatra/db/challenge_languages.csv' DELIMITER ',' CSV HEADER;

COPY snippets(challenge_id, language_id, student_id, snippet, substantial)
FROM '/Users/linda/Documents/Learning/GeneralAssembly/SEI/capstone/discuss-board-react-ruby-sinatra/db/snippets.csv' DELIMITER ',' CSV HEADER;

COPY comments(snippet_id, student_id, comment, substantial)
FROM '/Users/linda/Documents/Learning/GeneralAssembly/SEI/capstone/discuss-board-react-ruby-sinatra/db/comments.csv' DELIMITER ',' CSV HEADER;

COPY observations(comment_id, teacher_id, observation)FROM '/Users/linda/Documents/Learning/GeneralAssembly/SEI/capstone/discuss-board-react-ruby-sinatra/db/observations.csv' DELIMITER ',' CSV HEADER;

##############################################################
############## THERE ARE NO CSV FILES FOR BELOW  ...YET
##############################################################

COPY questions(challenge_id, student_id, question, substantial)
FROM '/Users/linda/Documents/Learning/GeneralAssembly/SEI/capstone/discuss-board-react-ruby-sinatra/db/questions.csv' DELIMITER ',' CSV HEADER;

COPY responses(question_id, teacher_id, answer)
FROM '/Users/linda/Documents/Learning/GeneralAssembly/SEI/capstone/discuss-board-react-ruby-sinatra/db/responses.csv' DELIMITER ',' CSV HEADER;


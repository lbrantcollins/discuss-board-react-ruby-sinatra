
COPY users(username, password)
FROM '/Users/linda/Documents/Learning/GeneralAssembly/SEI/capstone/discuss-board-react-ruby-sinatra/db/users.csv' DELIMITER ',' CSV HEADER;

COPY teachers(teacher_id)
FROM '/Users/linda/Documents/Learning/GeneralAssembly/SEI/capstone/discuss-board-react-ruby-sinatra/db/teachers.csv' DELIMITER ',' CSV HEADER;

COPY students(student_id)
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



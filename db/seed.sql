

COPY teachers(username, password)
FROM '/Users/linda/Documents/Learning/GeneralAssembly/SEI/capstone/discuss-board-react-ruby-sinatra/db/teachers.csv' DELIMITER ',' CSV HEADER;

COPY challenges(teacher_id, title, description)
FROM '/Users/linda/Documents/Learning/GeneralAssembly/SEI/capstone/discuss-board-react-ruby-sinatra/db/challenges.csv' DELIMITER ',' CSV HEADER;

COPY keywords(challenge_id, keyword)
FROM '/Users/linda/Documents/Learning/GeneralAssembly/SEI/capstone/discuss-board-react-ruby-sinatra/db/keywords.csv' DELIMITER ',' CSV HEADER;

COPY languages(challenge_id, language)
FROM '/Users/linda/Documents/Learning/GeneralAssembly/SEI/capstone/discuss-board-react-ruby-sinatra/db/languages.csv' DELIMITER ',' CSV HEADER;


DROP TABLE if EXISTS users;
DROP TABLE if EXISTS questions;
DROP TABLE if EXISTS replies;
DROP TABLE if EXISTS question_follows;
DROP TABLE if EXISTS question_likes;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL, --who is the author of the question

  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL, --who follow which question

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body TEXT NOT NULL,
  parent_id INTEGER,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);


CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
  users(fname, lname)
VALUES
  ('Kevin', 'Truong'),
  ('Trung', 'Vu');

INSERT INTO
  questions(title, body, user_id)
VALUES
  ('what',
    'what the heck is this?',
    (SELECT id FROM users WHERE fname = 'Kevin')),
  ('why',
    'why are we doing this?',
    (SELECT id FROM users WHERE fname = 'Trung'));


INSERT INTO
  replies(body, parent_id, question_id, user_id)
VALUES
  ('how do I know',
    null,
    (SELECT id FROM questions WHERE title = 'what'),
    (SELECT id FROM users WHERE fname = 'Trung')),
  ('I agree',
    (SELECT id FROM replies WHERE body = 'how do I know'),
    (SELECT id FROM questions WHERE title = 'what'),
    (SELECT id FROM users WHERE fname = 'Kevin'));


INSERT INTO
  question_likes(question_id, user_id)
VALUES
  ((SELECT id FROM questions WHERE title = 'what'),
  (SELECT id FROM users WHERE fname = 'Trung'));

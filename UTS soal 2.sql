CREATE TABLE author (
  email      VARCHAR(50) PRIMARY KEY,
  first_name VARCHAR(50),
  last_name  VARCHAR(50)
);

CREATE TABLE paper (
  paper_id  INT PRIMARY KEY,
  title     VARCHAR(50),
  abstract  TEXT,
  file_name VARCHAR(50)
);

CREATE TABLE reviewer (
  email       VARCHAR(50) PRIMARY KEY,
  first_name  VARCHAR(50),
  last_name   VARCHAR(50),
  phone       VARCHAR(50),
  affiliation VARCHAR(50)
);

CREATE TABLE paper_author (
  paper_id     INT,
  author_email VARCHAR(50),
  is_contact   BOOLEAN NOT NULL DEFAULT FALSE,
  PRIMARY KEY (paper_id, author_email),
  CONSTRAINT fk_pa_paper  FOREIGN KEY (paper_id)     REFERENCES paper(paper_id),
  CONSTRAINT fk_pa_author FOREIGN KEY (author_email) REFERENCES author(email)
);

CREATE TABLE reviewer_topic (
  reviewer_email VARCHAR(100),
  topic          VARCHAR(100),
  PRIMARY KEY (reviewer_email, topic),
  CONSTRAINT fk_rt_reviewer FOREIGN KEY (reviewer_email) REFERENCES reviewer(email)
);

CREATE TABLE review (
  paper_id          INT,
  reviewer_email    VARCHAR(100),
  technical_merit   INT CHECK (technical_merit BETWEEN 1 AND 10),
  readability       INT CHECK (readability BETWEEN 1 AND 10),
  originality       INT CHECK (originality BETWEEN 1 AND 10),
  relevance         INT CHECK (relevance BETWEEN 1 AND 10),
  recommendation    VARCHAR(10) CHECK (recommendation IN ('Accept','Reject')),
  committee_comment TEXT,
  author_comment    TEXT,
  PRIMARY KEY (paper_id, reviewer_email),
  CONSTRAINT fk_r_paper    FOREIGN KEY (paper_id)       REFERENCES paper(paper_id),
  CONSTRAINT fk_r_reviewer FOREIGN KEY (reviewer_email) REFERENCES reviewer(email)
);
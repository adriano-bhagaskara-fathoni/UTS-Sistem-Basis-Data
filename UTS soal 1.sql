CREATE TABLE state (
  state_name VARCHAR(20) PRIMARY KEY,
  region     VARCHAR(20)
    CHECK (region IN ('jawa','sumatra','kalimantan','sulawesi','bali'))
);

CREATE TABLE congress_person (
  person_id  INT PRIMARY KEY,
  name       VARCHAR(20),
  district   INT,
  start_date DATE,
  party      VARCHAR(20)
    CHECK (party IN ('demokrat','pdip','pkb','pan')),
  state_name VARCHAR(20),
  CONSTRAINT fk_cp_state FOREIGN KEY (state_name) REFERENCES state(state_name)
);

CREATE TABLE bill (
  bill_id          INT PRIMARY KEY,
  bill_name        VARCHAR(20),
  date_of_vote     DATE,
  passed_or_failed VARCHAR(20) CHECK (passed_or_failed IN ('Yes','No'))
);

CREATE TABLE sponsor (
  person_id INT,
  bill_id   INT,
  PRIMARY KEY (person_id, bill_id),
  CONSTRAINT fk_sp_person FOREIGN KEY (person_id) REFERENCES congress_person(person_id),
  CONSTRAINT fk_sp_bill   FOREIGN KEY (bill_id)   REFERENCES bill(bill_id)
);

CREATE TABLE vote (
  person_id INT,
  bill_id   INT,
  vote_type VARCHAR(7) NOT NULL
    CHECK (vote_type IN ('Yes','No','Abstain','Absent')),
  PRIMARY KEY (person_id, bill_id),
  CONSTRAINT fk_v_person FOREIGN KEY (person_id) REFERENCES congress_person(person_id),
  CONSTRAINT fk_v_bill   FOREIGN KEY (bill_id)   REFERENCES bill(bill_id)
);
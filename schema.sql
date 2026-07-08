-- Reconstructed schema for Patient_Scheduler (edoc database)
-- Inferred from the SQL queries in the PHP source, since no .sql dump
-- was committed to the repo. Review before importing on a fresh host.
--
-- Import via phpMyAdmin -> select database "if0_42365265_e_doc" -> Import tab.
-- No CREATE DATABASE/USE here since InfinityFree already provisions the DB.

-- Maps every login email to its role; login.php checks this first
-- then looks up the matching admin/doctor/patient row.
CREATE TABLE webuser (
  email VARCHAR(100) NOT NULL PRIMARY KEY,
  usertype CHAR(1) NOT NULL -- 'a' = admin, 'd' = doctor, 'p' = patient
);

CREATE TABLE admin (
  aid INT AUTO_INCREMENT PRIMARY KEY,
  aemail VARCHAR(100) NOT NULL,
  apassword VARCHAR(100) NOT NULL
);

CREATE TABLE specialties (
  id INT AUTO_INCREMENT PRIMARY KEY,
  sname VARCHAR(100) NOT NULL
);

CREATE TABLE doctor (
  docid INT AUTO_INCREMENT PRIMARY KEY,
  docemail VARCHAR(100) NOT NULL,
  docname VARCHAR(100) NOT NULL,
  docpassword VARCHAR(100) NOT NULL,
  docnic VARCHAR(30),
  doctel VARCHAR(20),
  specialties INT,
  FOREIGN KEY (specialties) REFERENCES specialties(id)
);

CREATE TABLE patient (
  pid INT AUTO_INCREMENT PRIMARY KEY,
  pemail VARCHAR(100) NOT NULL,
  pname VARCHAR(100) NOT NULL,
  ppassword VARCHAR(100) NOT NULL,
  paddress VARCHAR(255),
  pnic VARCHAR(30),
  pdob DATE,
  ptel VARCHAR(20)
);

CREATE TABLE schedule (
  scheduleid INT AUTO_INCREMENT PRIMARY KEY,
  docid INT NOT NULL,
  title VARCHAR(100),
  scheduledate DATE NOT NULL,
  scheduletime TIME NOT NULL,
  nop INT, -- number of patient slots for the session
  FOREIGN KEY (docid) REFERENCES doctor(docid)
);

CREATE TABLE appointment (
  appoid INT AUTO_INCREMENT PRIMARY KEY,
  pid INT NOT NULL,
  apponum INT NOT NULL, -- patient's queue number within the session
  scheduleid INT NOT NULL,
  appodate DATE NOT NULL,
  FOREIGN KEY (pid) REFERENCES patient(pid),
  FOREIGN KEY (scheduleid) REFERENCES schedule(scheduleid)
);

-- Seed specialties so the "Add Doctor" dropdown has options
-- (edit/add rows to match what the real site actually offered).
INSERT INTO specialties (sname) VALUES
  ('General Physician'), ('Cardiologist'), ('Dermatologist'),
  ('Pediatrician'), ('Orthopedic'), ('Neurologist'),
  ('Dentist'), ('ENT Specialist'), ('Gynecologist'), ('Psychiatrist');

-- Seed data matching the demo accounts in password.txt, so a reviewer
-- can log in to each role without registering first.
INSERT INTO webuser (email, usertype) VALUES
  ('admin@edoc.com', 'a'),
  ('doctor@edoc.com', 'd'),
  ('patient@edoc.com', 'p');

INSERT INTO admin (aemail, apassword) VALUES
  ('admin@edoc.com', '123');

INSERT INTO doctor (docemail, docname, docpassword, docnic, doctel, specialties) VALUES
  ('doctor@edoc.com', 'Demo Doctor', '123', '000000000V', '0700000000', 1);

INSERT INTO patient (pemail, pname, ppassword, paddress, pnic, pdob, ptel) VALUES
  ('patient@edoc.com', 'Demo Patient', '123', 'Dallas, TX', '000000000V', '2000-01-01', '0700000001');

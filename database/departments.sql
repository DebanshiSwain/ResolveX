CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);

INSERT INTO departments (name) VALUES
('IT Support'),
('Hostel Management'),
('Academic Office'),
('Library'),
('Examination Cell'),
('Accounts / Fees'),
('Transport'),
('Maintenance'),
('Placement Cell'),
('Administration'),
('Security');

INSERT INTO departments (name) VALUES ('Mental Health');
INSERT INTO departments (name) VALUES ('Physical Health');

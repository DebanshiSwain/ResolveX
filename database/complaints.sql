CREATE TABLE complaints (
    id SERIAL PRIMARY KEY,
    sic VARCHAR(20),
    name VARCHAR(50),
    category VARCHAR(50),
    title VARCHAR(100),
    description TEXT,
    status VARCHAR(20) DEFAULT 'Pending',
    slot_date DATE,
    slot_time TIME,
    created_at DATE DEFAULT CURRENT_DATE
);

ALTER TABLE complaints ADD COLUMN slot VARCHAR(50);

ALTER TABLE complaints
ADD COLUMN department_id INT REFERENCES departments(id);

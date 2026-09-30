-- Create database
CREATE DATABASE CircusPerformances;

USE CircusPerformances;

-- Performers table
CREATE TABLE Performers (
    performer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    specialty VARCHAR(100) NOT NULL,
    experience_years INT DEFAULT 0
);

-- Shows table
CREATE TABLE Shows (
    show_id INT PRIMARY KEY AUTO_INCREMENT,
    show_name VARCHAR(150) NOT NULL,
    location VARCHAR(150)
);

-- Schedule table
CREATE TABLE Schedule (
    schedule_id INT PRIMARY KEY AUTO_INCREMENT,
    show_id INT NOT NULL,
    performance_date DATE NOT NULL,
    performance_time TIME NOT NULL,
    FOREIGN KEY (show_id) REFERENCES Shows(show_id)
);

-- Performance records
CREATE TABLE PerformanceRecords (
    record_id INT PRIMARY KEY AUTO_INCREMENT,
    schedule_id INT NOT NULL,
    performer_id INT,
    FOREIGN KEY (schedule_id) REFERENCES Schedule(schedule_id),
    FOREIGN KEY (performer_id) REFERENCES Performers(performer_id)
);

-- Add performers
INSERT INTO Performers (name, specialty, experience_years)
VALUES
('Keyona', 'Aerialist', 1),
('Jane Smith', 'Aerialist', 5),
('Maya Johnson', 'Aerialist', 3);

-- Add the show
INSERT INTO Shows (show_name, location)
VALUES
('Midnight Flying Stars', 'Starlight Cirrus');

-- Add the schedule
INSERT INTO Schedule (show_id, performance_date, performance_time)
VALUES
(1, '2026-09-01', '20:00:00');

-- Assign Keyona to the performance
INSERT INTO PerformanceRecords (schedule_id, performer_id)
VALUES
(1, 1);

-- Find all aerialists
SELECT *
FROM Performers
WHERE specialty = 'Aerialist';

-- Find who is performing tonight
SELECT
    p.name,
    p.specialty,
    s.show_name,
    sc.performance_date,
    sc.performance_time
FROM PerformanceRecords pr
JOIN Performers p
    ON pr.performer_id = p.performer_id
JOIN Schedule sc
    ON pr.schedule_id = sc.schedule_id
JOIN Shows s
    ON sc.show_id = s.show_id
WHERE sc.performance_date = '2026-09-01'
  AND sc.performance_time = '20:00:00';

-- Find the most experienced aerialist
SELECT *
FROM Performers
WHERE specialty = 'Aerialist'
ORDER BY experience_years DESC
LIMIT 1;

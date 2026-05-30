-- Clinic Management System - MySQL schema and seed data
-- Usage: mysql -u root -p < scripts/cms_mysql_seed.sql

CREATE DATABASE IF NOT EXISTS cms
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE cms;

DROP TABLE IF EXISTS appointment;
DROP TABLE IF EXISTS doctor_available_times;
DROP TABLE IF EXISTS patient;
DROP TABLE IF EXISTS doctor;
DROP TABLE IF EXISTS admin;

-- =========================
-- admin
-- =========================
CREATE TABLE admin (
    id       BIGINT       NOT NULL AUTO_INCREMENT,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

-- =========================
-- doctor
-- =========================
CREATE TABLE doctor (
    id        BIGINT       NOT NULL AUTO_INCREMENT,
    name      VARCHAR(100) NOT NULL,
    specialty VARCHAR(50)  NOT NULL,
    email     VARCHAR(255) NOT NULL,
    password  VARCHAR(255) NOT NULL,
    phone     VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

-- @ElementCollection: availableTimes
CREATE TABLE doctor_available_times (
    doctor_id       BIGINT       NOT NULL,
    available_times VARCHAR(255) NULL,
    CONSTRAINT fk_doctor_available_times_doctor
        FOREIGN KEY (doctor_id) REFERENCES doctor (id)
);

-- =========================
-- patient
-- =========================
CREATE TABLE patient (
    id       BIGINT       NOT NULL AUTO_INCREMENT,
    name     VARCHAR(100) NOT NULL,
    email    VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone    VARCHAR(255) NOT NULL,
    address  VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

-- =========================
-- appointment
-- =========================
CREATE TABLE appointment (
    id               BIGINT      NOT NULL AUTO_INCREMENT,
    appointment_time DATETIME(6) NOT NULL,
    status           INT         NOT NULL,
    doctor_id        BIGINT      NOT NULL,
    patient_id       BIGINT      NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_appointment_doctor
        FOREIGN KEY (doctor_id) REFERENCES doctor (id),
    CONSTRAINT fk_appointment_patient
        FOREIGN KEY (patient_id) REFERENCES patient (id)
);

-- =========================
-- seed data
-- =========================

INSERT INTO admin (username, password)
VALUES ('admin1', 'admin123');

INSERT INTO doctor (email, name, password, phone, specialty)
VALUES ('doctor@clinic.com', 'Dr. Jane Smith', 'pass123', '5551234567', 'Cardiology');

INSERT INTO doctor_available_times (doctor_id, available_times)
VALUES
    (1, '09:00-10:00'),
    (1, '10:00-11:00');

INSERT INTO patient (address, email, name, password, phone)
VALUES ('123 Main St', 'john@example.com', 'John Doe', 'pass123', '5559876543');

INSERT INTO appointment (appointment_time, status, doctor_id, patient_id)
VALUES ('2026-06-15 10:00:00', 0, 1, 1);

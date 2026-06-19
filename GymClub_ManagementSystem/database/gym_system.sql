CREATE DATABASE IF NOT EXISTS gym_system;
USE gym_system;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS bills;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS schedules;
DROP TABLE IF EXISTS memberships;
DROP TABLE IF EXISTS users;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE users (
    userID INT AUTO_INCREMENT PRIMARY KEY,
    fullName VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    role ENUM('STUDENT','TRAINER','MANAGER') NOT NULL
) ENGINE=InnoDB;

CREATE TABLE memberships (
    membershipID INT AUTO_INCREMENT PRIMARY KEY,
    studentID INT NOT NULL,
    membershipType ENUM('Monthly','Yearly') NOT NULL,
    startDate DATE NOT NULL,
    expiryDate DATE NOT NULL,
    status ENUM('Active','Expired','Suspended') NOT NULL DEFAULT 'Active',
    CONSTRAINT chk_membership_dates CHECK (expiryDate > startDate),
    CONSTRAINT fk_membership_student FOREIGN KEY (studentID) REFERENCES users(userID)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE schedules (
    scheduleID INT AUTO_INCREMENT PRIMARY KEY,
    className VARCHAR(100) NOT NULL,
    trainerID INT NOT NULL,
    classDate DATE NOT NULL,
    startTime TIME NOT NULL,
    endTime TIME NOT NULL,
    capacity INT NOT NULL,
    CONSTRAINT chk_schedule_time CHECK (endTime > startTime),
    CONSTRAINT chk_schedule_capacity CHECK (capacity >= 0),
    CONSTRAINT fk_schedule_trainer FOREIGN KEY (trainerID) REFERENCES users(userID)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE bookings (
    bookingID INT AUTO_INCREMENT PRIMARY KEY,
    scheduleID INT NOT NULL,
    studentID INT NOT NULL,
    bookingDate DATE NOT NULL,
    bookingStatus ENUM('Confirmed','Cancelled') NOT NULL DEFAULT 'Confirmed',
    CONSTRAINT fk_booking_schedule FOREIGN KEY (scheduleID) REFERENCES schedules(scheduleID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_booking_student FOREIGN KEY (studentID) REFERENCES users(userID)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE attendance (
    attendanceID INT AUTO_INCREMENT PRIMARY KEY,
    studentID INT NOT NULL,
    scheduleID INT NULL,
    checkInTime DATETIME NOT NULL,
    checkOutTime DATETIME NULL,
    attendanceStatus ENUM('Present','Absent') NOT NULL DEFAULT 'Present',
    CONSTRAINT fk_attendance_student FOREIGN KEY (studentID) REFERENCES users(userID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_attendance_schedule FOREIGN KEY (scheduleID) REFERENCES schedules(scheduleID)
        ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE bills (
    billID INT AUTO_INCREMENT PRIMARY KEY,
    studentID INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    dueDate DATE NOT NULL,
    status ENUM('Pending','Paid','Overdue') NOT NULL DEFAULT 'Pending',
    CONSTRAINT chk_bill_amount CHECK (amount > 0),
    CONSTRAINT fk_bill_student FOREIGN KEY (studentID) REFERENCES users(userID)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE payments (
    paymentID INT AUTO_INCREMENT PRIMARY KEY,
    billID INT NOT NULL,
    paymentDate DATE NOT NULL,
    paymentMethod VARCHAR(50) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    status ENUM('Pending','Paid','Overdue') NOT NULL DEFAULT 'Paid',
    CONSTRAINT chk_payment_amount CHECK (amount > 0),
    CONSTRAINT fk_payment_bill FOREIGN KEY (billID) REFERENCES bills(billID)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

INSERT INTO users (fullName, email, password, phone, role) VALUES
('Alya Student', 'student@unigym.edu', 'student123', '010-1111111', 'STUDENT'),
('Ravi Trainer', 'trainer@unigym.edu', 'trainer123', '010-2222222', 'TRAINER'),
('Mina Manager', 'manager@unigym.edu', 'manager123', '010-3333333', 'MANAGER');

INSERT INTO memberships (studentID, membershipType, startDate, expiryDate, status)
VALUES (1, 'Monthly', CURDATE(), DATE_ADD(CURDATE(), INTERVAL 1 MONTH), 'Active');

INSERT INTO schedules (className, trainerID, classDate, startTime, endTime, capacity)
VALUES ('Strength Training', 2, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '10:00:00', '11:00:00', 20);

INSERT INTO bills (studentID, amount, dueDate, status)
VALUES (1, 39.00, DATE_ADD(CURDATE(), INTERVAL 7 DAY), 'Pending');

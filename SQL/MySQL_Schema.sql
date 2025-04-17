DROP DATABASE IF EXISTS `project_db`;


CREATE SCHEMA `project_db` ;

USE project_db;

CREATE TABLE Company (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name TEXT NOT NULL,
    Country TEXT NOT NULL,
    Region TEXT NOT NULL,
    Industry TEXT NOT NULL,
    Specialization TEXT
);

CREATE TABLE Risk_Register (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Company_ID INT NOT NULL,
    FOREIGN KEY (Company_ID) REFERENCES Company(ID) ON DELETE CASCADE
);

CREATE TABLE Category (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name TEXT NOT NULL,
    Description TEXT
);

CREATE TABLE Parent_Risk (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name TEXT NOT NULL,
    Description TEXT,
    Category_ID INT NOT NULL,
    Register_ID INT NOT NULL,
    FOREIGN KEY (Category_ID) REFERENCES Category(ID) ON DELETE CASCADE,
    FOREIGN KEY (Register_ID) REFERENCES Risk_Register(ID) ON DELETE CASCADE
);

CREATE TABLE Sub_Risk (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name TEXT NOT NULL,
    Description TEXT,
    Parent_Risk_ID INT NOT NULL,
    Register_ID INT NOT NULL,
    FOREIGN KEY (Parent_Risk_ID) REFERENCES Parent_Risk(ID) ON DELETE NO ACTION,
    FOREIGN KEY (Register_ID) REFERENCES Risk_Register(ID) ON DELETE NO ACTION
);

CREATE TABLE Appetite (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name TEXT,
    Tolerance_Val FLOAT NOT NULL,
    Acceptance_Value FLOAT NOT NULL,
    Register_ID INT NOT NULL,
    FOREIGN KEY (Register_ID) REFERENCES Risk_Register(ID) ON DELETE NO ACTION
);

CREATE TABLE Risk (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name TEXT NOT NULL,
    Description TEXT,
    Sub_Risk_ID INT NOT NULL,
    Appetite_ID INT NOT NULL,
    Register_ID INT NOT NULL,
    FOREIGN KEY (Sub_Risk_ID) REFERENCES Sub_Risk(ID) ON DELETE NO ACTION,
    FOREIGN KEY (Appetite_ID) REFERENCES Appetite(ID) ON DELETE NO ACTION,
    FOREIGN KEY (Register_ID) REFERENCES Risk_Register(ID) ON DELETE NO ACTION
);

CREATE TABLE Controls (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Description TEXT NOT NULL,
    Effectiveness_Score FLOAT NOT NULL,
    Register_ID INT NOT NULL,
    FOREIGN KEY (Register_ID) REFERENCES Risk_Register(ID) ON DELETE CASCADE
);

CREATE TABLE User_Account (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name TEXT NOT NULL,
    Email TEXT NOT NULL,
    Region TEXT NOT NULL,
    Country TEXT NOT NULL
);

CREATE TABLE Client_Employee (
    User_ID INT NOT NULL,
    Company_ID INT NOT NULL,
    PRIMARY KEY (User_ID, Company_ID),
    FOREIGN KEY (User_ID) REFERENCES User_Account(ID) ON DELETE CASCADE,
    FOREIGN KEY (Company_ID) REFERENCES Company(ID) ON DELETE CASCADE
);

CREATE TABLE Assessments (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    User_ID INT NOT NULL,
    Description TEXT NOT NULL,
    Region TEXT NOT NULL,
    Industry TEXT NOT NULL,
    FOREIGN KEY (User_ID) REFERENCES User_Account(ID) ON DELETE CASCADE
);

CREATE TABLE Control_Parent_Reach (
    Control_ID INT NOT NULL,
    Parent_ID INT NOT NULL,
    PRIMARY KEY (Control_ID, Parent_ID),
    FOREIGN KEY (Control_ID) REFERENCES Controls(ID) ON DELETE NO ACTION,
    FOREIGN KEY (Parent_ID) REFERENCES Parent_Risk(ID) ON DELETE NO ACTION
);

CREATE TABLE Control_Sub_Risk_Reach (
    Control_ID INT NOT NULL,
    Sub_Risk_ID INT NOT NULL,
    PRIMARY KEY (Control_ID, Sub_Risk_ID),
    FOREIGN KEY (Control_ID) REFERENCES Controls(ID) ON DELETE NO ACTION,
    FOREIGN KEY (Sub_Risk_ID) REFERENCES Sub_Risk(ID) ON DELETE NO ACTION
);

CREATE TABLE Control_Risk_Reach (
    Control_ID INT NOT NULL,
    Risk_ID INT NOT NULL,
    PRIMARY KEY (Control_ID, Risk_ID),
    FOREIGN KEY (Control_ID) REFERENCES Controls(ID) ON DELETE NO ACTION,
    FOREIGN KEY (Risk_ID) REFERENCES Risk(ID) ON DELETE NO ACTION
);

CREATE TABLE Assessment_Parent_Impact (
    Assessment_ID INT NOT NULL,
    Parent_Risk_ID INT NOT NULL,
    PRIMARY KEY (Assessment_ID, Parent_Risk_ID),
    FOREIGN KEY (Assessment_ID) REFERENCES Assessments(ID) ON DELETE NO ACTION,
    FOREIGN KEY (Parent_Risk_ID) REFERENCES Parent_Risk(ID) ON DELETE NO ACTION
);

CREATE TABLE Assessment_Sub_Risk_Impact (
    Assessment_ID INT NOT NULL,
    Sub_Risk_ID INT NOT NULL,
    PRIMARY KEY (Assessment_ID, Sub_Risk_ID),
    FOREIGN KEY (Assessment_ID) REFERENCES Assessments(ID) ON DELETE NO ACTION,
    FOREIGN KEY (Sub_Risk_ID) REFERENCES Sub_Risk(ID) ON DELETE NO ACTION
);

CREATE TABLE Assessment_Risk_Impact (
    Assessment_ID INT NOT NULL,
    Risk_ID INT NOT NULL,
    PRIMARY KEY (Assessment_ID, Risk_ID),
    FOREIGN KEY (Assessment_ID) REFERENCES Assessments(ID) ON DELETE NO ACTION,
    FOREIGN KEY (Risk_ID) REFERENCES Risk(ID) ON DELETE NO ACTION
);

CREATE TABLE Assessment_Control_Impact (
    Assessment_ID INT NOT NULL,
    Control_ID INT NOT NULL,
    PRIMARY KEY (Assessment_ID, Control_ID),
    FOREIGN KEY (Assessment_ID) REFERENCES Assessments(ID) ON DELETE NO ACTION,
    FOREIGN KEY (Control_ID) REFERENCES Controls(ID) ON DELETE NO ACTION
);

CREATE TABLE Assessment_Company_Impact (
    Assessment_ID INT NOT NULL,
    Company_ID INT NOT NULL,
    PRIMARY KEY (Assessment_ID, Company_ID),
    FOREIGN KEY (Assessment_ID) REFERENCES Assessments(ID) ON DELETE NO ACTION,
    FOREIGN KEY (Company_ID) REFERENCES Company(ID) ON DELETE NO ACTION
);


-- Insert into Company
INSERT INTO Company (Name, Country, Region, Industry, Specialization) VALUES
('TechCorp', 'USA', 'North America', 'Technology', 'Software Development'),
('MediCare', 'UK', 'Europe', 'Healthcare', 'Pharmaceuticals'),
('EcoEnergy', 'Germany', 'Europe', 'Energy', 'Renewable Sources'),
('FinTrust', 'Canada', 'North America', 'Finance', 'Investment Banking'),
('AutoDrive', 'Japan', 'Asia', 'Automobile', 'Electric Vehicles');

-- Insert into Risk_Register
INSERT INTO Risk_Register (Company_ID) VALUES
(1), (2), (3), (4), (5);

-- Insert into Category
INSERT INTO Category (Name, Description) VALUES
('Operational', 'Risks related to operational failures'),
('Financial', 'Risks affecting financial stability'),
('Reputational', 'Risks impacting public perception'),
('Compliance', 'Regulatory and legal risks'),
('Strategic', 'Risks affecting long-term business goals');

-- Insert into Parent_Risk
INSERT INTO Parent_Risk (Name, Description, Category_ID, Register_ID) VALUES
('Data Breach', 'Risk of sensitive data exposure', 1, 1),
('Market Volatility', 'Unstable market conditions', 2, 2),
('Brand Damage', 'Negative publicity or scandal', 3, 3),
('Regulatory Non-compliance', 'Failure to comply with laws', 4, 4),
('Business Disruption', 'Unexpected disruptions in operations', 5, 5);

-- Insert into Sub_Risk
INSERT INTO Sub_Risk (Name, Description, Parent_Risk_ID, Register_ID) VALUES
('Hacking Attempt', 'Unauthorized access to systems', 1, 1),
('Stock Crash', 'Sudden drop in stock prices', 2, 2),
('Social Media Backlash', 'Negative social media coverage', 3, 3),
('Missed Reporting Deadlines', 'Failure to report on time', 4, 4),
('Natural Disasters', 'Floods, earthquakes impacting business', 5, 5);

-- Insert into Appetite
INSERT INTO Appetite (Name, Tolerance_Val, Acceptance_Value, Register_ID) VALUES
('Low', 10.0, 5.0, 1),
('Medium', 20.0, 10.0, 2),
('High', 30.0, 15.0, 3),
('Very High', 40.0, 20.0, 4),
('Extreme', 50.0, 25.0, 5);

-- Insert into Risk
INSERT INTO Risk (Name, Description, Sub_Risk_ID, Appetite_ID, Register_ID) VALUES
('Phishing Attack', 'Email-based hacking attempt', 1, 1, 1),
('Economic Downturn', 'Long-term economic slowdown', 2, 2, 2),
('Fake News', 'Misinformation damaging reputation', 3, 3, 3),
('Tax Evasion', 'Failure to pay necessary taxes', 4, 4, 4),
('Factory Shutdown', 'Temporary closure of operations', 5, 5, 5);

-- Insert into Controls
INSERT INTO Controls (Description, Effectiveness_Score, Register_ID) VALUES
('Firewall Protection', 85.5, 1),
('Diversified Investments', 75.0, 2),
('Public Relations Strategy', 80.0, 3),
('Legal Compliance Training', 90.0, 4),
('Backup Power Generators', 88.5, 5);

-- Insert into User_Account
INSERT INTO User_Account (Name, Email, Region, Country) VALUES
('Alice Johnson', 'alice@example.com', 'North America', 'USA'),
('Bob Smith', 'bob@example.com', 'Europe', 'UK'),
('Charlie Tan', 'charlie@example.com', 'Asia', 'Singapore'),
('Diana Lopez', 'diana@example.com', 'South America', 'Brazil'),
('Ethan Wang', 'ethan@example.com', 'Australia', 'Australia');

-- Insert into Client_Employee
INSERT INTO Client_Employee (User_ID, Company_ID) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5);

-- Insert into Assessments
INSERT INTO Assessments (User_ID, Description, Region, Industry) VALUES
(1, 'Security Audit for TechCorp', 'North America', 'Technology'),
(2, 'Financial Risk Review for MediCare', 'Europe', 'Healthcare'),
(3, 'Reputation Analysis for EcoEnergy', 'Europe', 'Energy'),
(4, 'Compliance Check for FinTrust', 'North America', 'Finance'),
(5, 'Operational Risk Evaluation for AutoDrive', 'Asia', 'Automobile');

-- Insert into Control_Parent_Reach
INSERT INTO Control_Parent_Reach (Control_ID, Parent_ID) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5);

-- Insert into Control_Sub_Risk_Reach
INSERT INTO Control_Sub_Risk_Reach (Control_ID, Sub_Risk_ID) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5);

-- Insert into Control_Risk_Reach
INSERT INTO Control_Risk_Reach (Control_ID, Risk_ID) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5);

-- Insert into Assessment_Parent_Impact
INSERT INTO Assessment_Parent_Impact (Assessment_ID, Parent_Risk_ID) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5);

-- Insert into Assessment_Sub_Risk_Impact
INSERT INTO Assessment_Sub_Risk_Impact (Assessment_ID, Sub_Risk_ID) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5);

-- Insert into Assessment_Risk_Impact
INSERT INTO Assessment_Risk_Impact (Assessment_ID, Risk_ID) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5);

-- Insert into Assessment_Control_Impact
INSERT INTO Assessment_Control_Impact (Assessment_ID, Control_ID) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5);

-- Insert into Assessment_Company_Impact
INSERT INTO Assessment_Company_Impact (Assessment_ID, Company_ID) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5);
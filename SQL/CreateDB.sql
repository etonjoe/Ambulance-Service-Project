'''sql
-- Create the Database
CREATE DATABASE AmbulanceServiceDB;
GO

-- Use the newly created database
USE AmbulanceServiceDB;
GO

-- Ambulances table
CREATE TABLE Ambulances (
    AmbulanceID INT PRIMARY KEY IDENTITY(1,1),
    LicensePlate VARCHAR(50) NOT NULL,
    Model VARCHAR(100),
    Capacity INT,
    Status VARCHAR(50)
);
GO

-- Patients table
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    DateOfBirth DATE,
    Address VARCHAR(255),
    PhoneNumber VARCHAR(15),
    EmergencyContactName VARCHAR(100),
    EmergencyContactPhone VARCHAR(15),
    MedicalHistory TEXT
);
GO

-- Staff table
CREATE TABLE Staff (
    StaffID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Role VARCHAR(50),
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100),
    LicenseNumber VARCHAR(100),
    Qualifications TEXT
);
GO

-- Emergency Calls table
CREATE TABLE EmergencyCalls (
    CallID INT PRIMARY KEY IDENTITY(1,1),
    CallTime DATETIME DEFAULT GETDATE(),
    Location VARCHAR(255),
    Severity VARCHAR(50),
    CallType VARCHAR(100),
    IncidentID INT,
    PatientID INT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);
GO

-- Incidents table
CREATE TABLE Incidents (
    IncidentID INT PRIMARY KEY IDENTITY(1,1),
    Description TEXT,
    IncidentTime DATETIME DEFAULT GETDATE(),
    ReportedBy VARCHAR(100),
    Location VARCHAR(255),
    Status VARCHAR(50)
);
GO

-- Dispatches table
CREATE TABLE Dispatches (
    DispatchID INT PRIMARY KEY IDENTITY(1,1),
    AmbulanceID INT,
    CallID INT,
    DispatchTime DATETIME DEFAULT GETDATE(),
    ArrivalTime DATETIME,
    DepartureTime DATETIME,
    StaffID INT,
    FOREIGN KEY (AmbulanceID) REFERENCES Ambulances(AmbulanceID),
    FOREIGN KEY (CallID) REFERENCES EmergencyCalls(CallID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);
GO

-- Insert 1000 dummy data into Ambulances
DECLARE @i INT = 1;
WHILE @i <= 1000
BEGIN
    INSERT INTO Ambulances (LicensePlate, Model, Capacity, Status)
    VALUES ('AB' + CAST(1000 + @i AS VARCHAR), 'Model ' + CAST(1000 + @i AS VARCHAR), 2, 
            CASE WHEN @i % 2 = 0 THEN 'Available' ELSE 'In Service' END);
    SET @i = @i + 1;
END;
GO

-- Insert 1000 dummy data into Patients
DECLARE @j INT = 1;
WHILE @j <= 1000
BEGIN
    INSERT INTO Patients (FirstName, LastName, DateOfBirth, Address, PhoneNumber, EmergencyContactName, EmergencyContactPhone, MedicalHistory)
    VALUES ('First' + CAST(@j AS VARCHAR), 'Last' + CAST(@j AS VARCHAR), '1985-01-01', 
            'Address ' + CAST(@j AS VARCHAR), '555-' + CAST(1000 + @j AS VARCHAR), 
            'EContact ' + CAST(@j AS VARCHAR), '555-' + CAST(2000 + @j AS VARCHAR), 'Medical history details...');
    SET @j = @j + 1;
END;
GO

-- Insert 1000 dummy data into Staff
DECLARE @k INT = 1;
WHILE @k <= 1000
BEGIN
    INSERT INTO Staff (FirstName, LastName, Role, PhoneNumber, Email, LicenseNumber, Qualifications)
    VALUES ('StaffFirst' + CAST(@k AS VARCHAR), 'StaffLast' + CAST(@k AS VARCHAR), 
            CASE WHEN @k % 2 = 0 THEN 'Driver' ELSE 'Paramedic' END, 
            '555-' + CAST(3000 + @k AS VARCHAR), 
            'staff' + CAST(@k AS VARCHAR) + '@ambulance.com', 'L' + CAST(1000 + @k AS VARCHAR), 
            'Certified in CPR');
    SET @k = @k + 1;
END;
GO

-- Insert 1000 dummy data into Incidents
DECLARE @l INT = 1;
WHILE @l <= 1000
BEGIN
    INSERT INTO Incidents (Description, IncidentTime, ReportedBy, Location, Status)
    VALUES ('Incident description for ' + CAST(@l AS VARCHAR), 
            DATEADD(HOUR, -@l, GETDATE()), 'System', 'Location ' + CAST(@l AS VARCHAR), 
            CASE WHEN @l % 2 = 0 THEN 'Active' ELSE 'Resolved' END);
    SET @l = @l + 1;
END;
GO

-- Insert 1000 dummy data into EmergencyCalls
DECLARE @m INT = 1;
WHILE @m <= 1000
BEGIN
    INSERT INTO EmergencyCalls (Location, Severity, CallType, IncidentID, PatientID)
    VALUES ('Location ' + CAST(@m AS VARCHAR), 
            CASE WHEN @m % 2 = 0 THEN 'Critical' ELSE 'Urgent' END, 
            CASE WHEN @m % 2 = 0 THEN 'Accident' ELSE 'Cardiac Arrest' END, 
            @m, @m);
    SET @m = @m + 1;
END;
GO

-- Insert 1000 dummy data into Dispatches
DECLARE @n INT = 1;
WHILE @n <= 1000
BEGIN
    INSERT INTO Dispatches (AmbulanceID, CallID, DispatchTime, ArrivalTime, DepartureTime, StaffID)
    VALUES (@n, @n, DATEADD(MINUTE, @n, GETDATE()), DATEADD(MINUTE, @n + 5, GETDATE()), 
            DATEADD(MINUTE, @n + 10, GETDATE()), @n);
    SET @n = @n + 1;
END;
GO
'''

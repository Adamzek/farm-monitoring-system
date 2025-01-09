@C:\Users\PC\Documents\GitHub\farm-monitoring-system\FarmMonitoring_Script.txt;

select * from Farm;
select * from Farmland;  
select * from Sensor;
select * from SensorReading;
select * from WeatherData;
select * from SoilData;

--Get all farms and their respective Farmlands,dimensions n soiltypes
SELECT f.FarmName, fld.FarmlandName, fld.Dimensions, fld.SoilType
FROM Farm f
JOIN Farmland fld ON f.FarmID = fld.FarmID;

--Find all active sensors and the associated fields
SELECT s.SensorID, s.Types, s.InstallationDate, fld.FarmlandName
FROM Sensor s
JOIN Farmland fld ON s.FieldID = fld.FieldID
WHERE s.SensorStatus = 'Active';

-- Get recent sensor readings for a specific field
SELECT sr.ReadingID, sr.Readings, sr.Datetime
FROM SensorReading sr
JOIN Sensor s ON sr.SensorID = s.SensorID
WHERE s.FieldID = 101 -- Desired FieldID tht u want to check
ORDER BY sr.Datetime DESC;

-- Insert a new farm
INSERT INTO Farm (FarmID, FarmName, Owner, Locations, Dimensions)
VALUES (16, 'Green Pastures', 'Elaine', 'Seremban', 85);

-- Add a new sensor to a specific field
INSERT INTO Sensor (SensorID, FieldID, Types, InstallationDate, SensorStatus)
VALUES (216, 103, 'Temperature', TO_DATE('2025-01-01', 'YYYY-MM-DD'), 'Active');

-- Update the status of a sensor
UPDATE Sensor
SET SensorStatus = 'Inactive'
WHERE SensorID = 202; --Desired SensorID to be updated

-- Change the owner of a farm
UPDATE Farm
SET Owner = 'Lina'
WHERE FarmID = 1; -- Desired FarmID

-- Delete a specific sensor
DELETE FROM Sensor
WHERE SensorID = 215; -- Desired SensorID

-- REMOVE a farm and its associated farmlands, sensors, sensor readings, weather data, and soil data
DELETE FROM WeatherData
WHERE FieldID IN (
    SELECT FieldID
    FROM Farmland
    WHERE FarmID = 1
);
DELETE FROM SoilData
WHERE FieldID IN (
    SELECT FieldID
    FROM Farmland
    WHERE FarmID = 1
);
DELETE FROM SensorReading
WHERE SensorID IN (
    SELECT SensorID
    FROM Sensor
    WHERE FieldID IN (
        SELECT FieldID
        FROM Farmland
        WHERE FarmID = 1
    )
);
DELETE FROM Sensor
WHERE FieldID IN (
    SELECT FieldID
    FROM Farmland
    WHERE FarmID = 1
);
DELETE FROM Farmland
WHERE FarmID = 1;



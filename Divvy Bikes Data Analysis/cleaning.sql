-- looking for duplicate records
SELECT  ride_id, rideable_type, COUNT(*)
FROM [BikeTrip_CaseStudy].[dbo].Trip_Data
GROUP BY ride_id, rideable_type
HAVING  COUNT(*) > 1
   

-- looking for null values 
SELECT ride_id
FROM BikeTrip_CaseStudy..Trip_Data
WHERE ride_id IS NOT NULL
	

-- Making sure theres only two types of members
SELECT DISTINCT member_casual
FROM BikeTrip_CaseStudy..Trip_Data
	 

-- Looking for any errors/mispelling/inconsistencies in rideable types
SELECT DISTINCT rideable_type
FROM BikeTrip_CaseStudy..Trip_Data
	 
	
-- count all total rows = 5860776
SELECT COUNT(*)
FROM  BikeTrip_CaseStudy..Trip_Data
	

-- count all rows with empty strings. total rows with missing values = 1193477
SELECT *
FROM BikeTrip_CaseStudy..TripData_21_22
WHERE (start_station_name = '')
	OR (start_station_id = '')
	OR (end_station_name = '')
	OR (end_station_id = '')
	OR (start_lat = '')
	OR (start_lng = '')
	OR (end_lat = '')
	OR (end_lng = '')


-- delete all rows with empty strings
-- total rows after removing empty strings = 4667299 
DELETE
FROM BikeTrip_CaseStudy..Trip_Data
WHERE (start_station_name = '')
	OR (start_station_id = '')
	OR (end_station_name = '')
	OR (end_station_id = '')
	OR (start_lat = '')
	OR (start_lng = '')
	OR (end_lat = '')
	OR (end_lng = '')

-- Add new column for day of the week, ride length 
ALTER TABLE [BikeTrip_CaseStudy].[dbo].Trip_Data
ADD day_of_week2 varchar(20), duration_seconds2 int


-- convert date time to weekday
UPDATE [BikeTrip_CaseStudy].[dbo].Trip_Data
SET day_of_week = DATENAME(WEEKDAY, started_at)


-- set duration of each trip in seconds
UPDATE [BikeTrip_CaseStudy].[dbo].Trip_Data
SET duration_seconds = DATEDIFF(second,started_at,ended_at) 


-- check for duration with negative values 
SELECT member_casual, duration_seconds, started_at, ended_at
FROM BikeTrip_CaseStudy..Trip_Data
WHERE duration_seconds < 60
ORDER BY duration_seconds ASC


-- count rows with less than 60 seconds = 64220 rows
SELECT COUNT(duration_seconds)
FROM BikeTrip_CaseStudy..Trip_Data
WHERE duration_seconds < 60


-- delete rows with less than 60 seconds
DELETE
FROM BikeTrip_CaseStudy..Trip_Data
WHERE duration_seconds < 60


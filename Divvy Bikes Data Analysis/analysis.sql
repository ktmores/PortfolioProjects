-- total count per customer type and count percentage
SELECT member_casual, COUNT(member_casual) AS type_count, COUNT(member_casual) * 100 / (select COUNT(*) FROM BikeTrip_CaseStudy..TripData_21_22) AS type_percentage
FROM [BikeTrip_CaseStudy].[dbo].Trip_Data
GROUP BY member_casual


-- number of trips per day of the week for all customers
SELECT COUNT(day_of_week) AS day_count, day_of_week
FROM [BikeTrip_CaseStudy].[dbo].Trip_Data
GROUP BY day_of_week
ORDER BY day_count DESC


-- avg/min/max trips per day of the week for all customers
SELECT AVG(day_total.num_rides) AS avg_count, MIN(day_total.num_rides) AS min_count, MAX(day_total.num_rides) AS max_count, day_of_week
FROM
	(
	SELECT CONVERT(DATE, started_at) AS trip_date, COUNT(ride_id) AS num_rides, day_of_week
	FROM [BikeTrip_CaseStudy].[dbo].Trip_Data
	GROUP BY CONVERT(DATE, started_at), day_of_week
	) day_total
GROUP BY day_of_week
ORDER BY avg_count DESC


-- avg/min/max trips per day of the week for casual
SELECT AVG(day_total.num_rides) AS avg_count, MIN(day_total.num_rides) AS min_count, MAX(day_total.num_rides) AS max_count, day_of_week
FROM
	(
	SELECT CONVERT(DATE, started_at) AS day_week, COUNT(ride_id) AS num_rides, day_of_week
	FROM [BikeTrip_CaseStudy].[dbo].Trip_Data
	WHERE member_casual = 'casual'
	GROUP BY CONVERT(DATE, started_at), day_of_week
	) day_total
GROUP BY day_of_week
ORDER BY avg_count DESC


-- avg/min/max trips per day of the week for members
SELECT AVG(day_total.num_rides) AS avg_count, MIN(day_total.num_rides) AS min_count, MAX(day_total.num_rides) AS max_count, day_of_week
FROM
	(
	SELECT CONVERT(DATE, started_at) AS day_week, COUNT(ride_id) as num_rides, day_of_week
	FROM [BikeTrip_CaseStudy].[dbo].Trip_Data
	WHERE member_casual = 'member'
	GROUP BY CONVERT(DATE, started_at), day_of_week
	) day_total
GROUP BY day_of_week
ORDER BY avg_count DESC


-- Dates with the highest count of trips by casuals
SELECT TOP (5) CONVERT(DATE, started_at) AS trip_date, COUNT(ride_id) as num_rides, day_of_week
FROM [BikeTrip_CaseStudy].[dbo].Trip_Data
WHERE member_casual = 'casual'
GROUP BY CONVERT(DATE, started_at), day_of_week
ORDER BY num_rides DESC


-- total rides per month for all customers
SELECT DATENAME(MONTH,started_at) AS month_name, COUNT(ride_id) AS ride_count
FROM [BikeTrip_CaseStudy].[dbo].Trip_Data
GROUP BY DATENAME(MONTH,started_at)
ORDER BY ride_count DESC


--total rides per month for casuals 
SELECT DATENAME(MONTH,started_at) AS month_name, COUNT(ride_id) AS ride_count
FROM [BikeTrip_CaseStudy].[dbo].Trip_Data
WHERE member_casual = 'casual'
GROUP BY DATENAME(MONTH,started_at)
ORDER BY ride_count DESC


--total rides per month for members
SELECT DATENAME(MONTH,started_at) AS month_name, COUNT(ride_id) AS ride_count
FROM [BikeTrip_CaseStudy].[dbo].Trip_Data
WHERE member_casual = 'member'
GROUP BY DATENAME(MONTH,started_at)
ORDER BY ride_count DESC


-- number of trips per day of the week for members
SELECT COUNT(day_of_week) AS day_count, day_of_week
FROM [BikeTrip_CaseStudy].[dbo].Trip_Data
WHERE member_casual = 'member'
GROUP BY day_of_week, member_casual
ORDER BY day_count DESC


-- number of trips per day of the week for casuals
SELECT COUNT(day_of_week) AS day_count, day_of_week
FROM [BikeTrip_CaseStudy].[dbo].Trip_Data
WHERE member_casual = 'casual'
GROUP BY day_of_week, member_casual
ORDER BY day_count DESC


-- ridetype total count for members
SELECT  member_casual, rideable_type, COUNT(rideable_type) AS ridetype_count
FROM [BikeTrip_CaseStudy].[dbo].Trip_Data
WHERE member_casual = 'member'
GROUP BY rideable_type, member_casual
ORDER BY ridetype_count DESC


-- ridetype total count for casuals
SELECT  member_casual, rideable_type, COUNT(rideable_type) AS ridetype_count
FROM [BikeTrip_CaseStudy].[dbo].Trip_Data
WHERE member_casual = 'casual'
GROUP BY rideable_type, member_casual
ORDER BY ridetype_count DESC


-- stations with the highest count of starting trips for all customers
SELECT TOP (10) start_station_name, COUNT(start_station_name) AS station_trips
FROM [BikeTrip_CaseStudy].[dbo].Trip_Data
GROUP BY start_station_name
ORDER BY station_trips DESC


-- stations with the highest count of ending trips for all customers
SELECT TOP (10) end_station_name, COUNT(end_station_name) AS station_trips
FROM [BikeTrip_CaseStudy].[dbo].Trip_Data
GROUP BY end_station_name
ORDER BY station_trips DESC


-- stations with the highest count of starting trips for casuals
SELECT TOP (10) start_station_name, COUNT(start_station_name) AS station_trips
FROM [BikeTrip_CaseStudy].[dbo].Trip_Data
WHERE member_casual = 'casual'
GROUP BY start_station_name
ORDER BY station_trips DESC


-- stations with the highest count of ending trips for casuals
SELECT TOP (10) end_station_name, COUNT(end_station_name) AS station_trips
FROM [BikeTrip_CaseStudy].[dbo].Trip_Data
WHERE member_casual = 'casual'
GROUP BY end_station_name
ORDER BY station_trips DESC


-- average duration in minutes for all customers
SELECT  AVG(CAST(duration_seconds AS bigint)) AS average_duration
FROM [BikeTrip_CaseStudy].[dbo].Trip_Data


-- average duration in minutes for each type of member
SELECT member_casual, AVG(CAST(duration_seconds AS bigint)) AS avg_duration
FROM [BikeTrip_CaseStudy].[dbo].Trip_Data
GROUP BY member_casual


-- hours with the day with the most trips for all customers
SELECT TOP (5) DATEPART(HOUR, started_at) as day_hour, COUNT(ride_id) as ride_count
FROM [BikeTrip_CaseStudy].[dbo].Trip_Data
GROUP BY DATEPART(HOUR, started_at)
ORDER BY ride_count DESC


-- hours with the day with the most trips for casuals
SELECT TOP (5) DATEPART(HOUR, started_at) as day_hour, COUNT(ride_id) as ride_count
FROM [BikeTrip_CaseStudy].[dbo].Trip_Data
WHERE member_casual = 'casual'
GROUP BY DATEPART(HOUR, started_at)
ORDER BY ride_count DESC


-- hours with the day with the most trips for members
SELECT TOP (5) DATEPART(HOUR, started_at) as day_hour, COUNT(ride_id) as ride_count
FROM [BikeTrip_CaseStudy].[dbo].Trip_Data
WHERE member_casual = 'member'
GROUP BY DATEPART(HOUR, started_at)
ORDER BY ride_count DESC

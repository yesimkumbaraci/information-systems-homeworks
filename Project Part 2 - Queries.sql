-- yesim,zeynep,baturalp
USE project_database;
-- Query 1
SELECT RouteID, AVG(x.Scheduleperroute) AS 'Average Number of Passengers'  FROM 
	(SELECT COUNT(sold_ticket.ScheduleID) AS Scheduleperroute, RouteID FROM
	sold_ticket, bus_route_schedule WHERE bus_route_schedule.ScheduleID = sold_ticket.ScheduleID
    GROUP BY sold_ticket.ScheduleID) AS x
GROUP BY x.RouteID
ORDER BY x.RouteID ASC;
 
-- Query 2
SELECT bus_route_passenger_trip.RouteID, 
SUM(IF(bus_route_passenger_trip.PassengerTripID=bus_route_passenger_trip.RouteID, 1, 0))*100/COUNT(sold_ticket.TicketID) AS 'Percentage of Direct Passengers'
FROM sold_ticket LEFT JOIN bus_route_passenger_trip ON sold_ticket.PassengerTripID=bus_route_passenger_trip.PassengerTripID
GROUP BY bus_route_passenger_trip.RouteID
ORDER BY bus_route_passenger_trip.RouteID ASC;

 -- Query 3
 SELECT TicketID,sold_ticket.PassengerTripID, SUM(segment.SegmentPrice) AS 'Ticket Price'
 FROM sold_ticket,segment,passenger_trip_segment
 WHERE sold_ticket.PassengerTripID=passenger_trip_segment.PassengerTripID
 AND passenger_trip_segment.SegmentID=segment.SegmentID
 GROUP BY TicketID
 ORDER BY TicketID ASC;
 
-- Query 4
SELECT driver_schedule.EmployeeID,SUM(segment.Duration) AS 'Total Working Hours' FROM  driver_schedule,
bus_segment,segment,bus_route_schedule
WHERE driver_schedule.ScheduleID=bus_route_schedule.ScheduleID
AND bus_route_schedule.RouteID=bus_segment.RouteID
AND bus_segment.SegmentID=segment.SegmentID
GROUP BY driver_schedule.EmployeeID
ORDER BY SUM(segment.Duration) DESC;

-- Query 5
SELECT 	x.CustomerID, (x.TotalDuration / x.TotalSoldTicketPerCustomer) as 'Average Trip Duration',
x.TotalSoldTicketPerCustomer AS 'Total Number of Trips' FROM 
	(SELECT customers.CustomerID,SUM(segment.Duration) AS TotalDuration,COUNT(DISTINCT sold_ticket.TicketID) AS TotalSoldTicketPerCustomer
	FROM customers INNER JOIN sold_ticket USING(CustomerID)
	INNER JOIN passenger_trip_segment USING(PassengerTripID) 
	INNER JOIN segment USING(SegmentID)
	GROUP BY customers.CustomerID) AS x
ORDER BY x.CustomerID ASC;


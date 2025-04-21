
# Ambulance Service Dashboard

## Project Overview

This project is aimed at providing insights into the performance of an ambulance service through a set of Key Performance Indicators (KPIs) visualized in Power BI. The dashboard tracks key metrics such as ambulance availability, response time, call severity, dispatch performance, and more. This helps ambulance service managers and staff make informed decisions to improve operational efficiency.

## Features

- **Ambulance Availability**: Monitor the status of each ambulance (Available, In Service, Out of Service).
- **Response Time**: Track the average response time between dispatch and arrival.
- **Emergency Call Analysis**: Visualize emergency calls by type and severity.
- **Incident Tracking**: Monitor active incidents, their resolution times, and dispatch effectiveness.
- **Staff Performance**: Evaluate the staff’s performance by analyzing the number of calls responded to and their performance metrics.

## Technologies Used

- **SQL Server**: For storing ambulance service data (ambulance details, emergency calls, incidents, staff, etc.).
- **Power BI**: For creating and displaying the dashboard.
- **DAX**: For calculations and creating KPIs in Power BI.
- **T-SQL**: For querying and aggregating data from the SQL Server database.

## Database Schema

The database includes the following tables:

- **Ambulances**: Information about ambulances (ID, LicensePlate, Model, Status).
- **Patients**: Patient details including medical history.
- **Staff**: Information about the staff (drivers, paramedics, etc.).
- **EmergencyCalls**: Data on emergency calls, severity, and response.
- **Incidents**: Detailed incident information including description and status.
- **Dispatches**: Ambulance dispatch information linked to calls and staff.

## Power BI Dashboard Implementation: Step-by-Step Guide

### Step 1: Prepare the Database

Ensure that the database is set up correctly, with all relevant tables populated with real-time or historical data. The database schema should look similar to the following:

- **Ambulances**: Stores ambulance availability and status.
- **EmergencyCalls**: Contains details of each emergency call, such as severity and type.
- **Dispatches**: Links ambulances to emergency calls, including dispatch, arrival, and departure times.

Use SQL queries to aggregate and clean the data before importing it into Power BI.

### Step 2: Connect Power BI to SQL Server

1. Open **Power BI Desktop**.
2. Click on **Get Data** > **SQL Server**.
3. Enter the server name and database name to connect to the SQL Server instance.
4. Choose the appropriate table or view for your KPIs (e.g., `Ambulances`, `EmergencyCalls`, `Dispatches`).
5. Load the data into Power BI.

### Step 3: Transform Data Using Power Query Editor

1. Once the data is loaded into Power BI, click on **Transform Data** to open the Power Query Editor.
2. Clean and format the data:
   - Remove unnecessary columns.
   - Format columns to the correct data type (e.g., date, time, number).
   - Create calculated columns, if necessary (e.g., **ResponseTime = ArrivalTime - DispatchTime**).
   
   Example of creating a new calculated column for **Response Time**:
   ```DAX
   ResponseTime = DATEDIFF(Dispatches[DispatchTime], Dispatches[ArrivalTime], MINUTE)
   ```

3. Close and apply the transformations to load the cleaned data into Power BI.

### Step 4: Create Calculated Measures Using DAX

To generate KPIs, create calculated measures in Power BI using **DAX (Data Analysis Expressions)**. These measures will calculate key metrics based on your data.

1. **Ambulance Availability**:
   - Create a measure to count the number of available ambulances:
     ```DAX
     AvailableAmbulances = COUNTROWS(FILTER(Ambulances, Ambulances[Status] = "Available"))
     ```

2. **Average Response Time**:
   - Create a measure to calculate the average response time:
     ```DAX
     AverageResponseTime = AVERAGEX(Dispatches, DATEDIFF(Dispatches[DispatchTime], Dispatches[ArrivalTime], MINUTE))
     ```

3. **Call Severity Distribution**:
   - Create a measure to track the number of calls by severity:
     ```DAX
     CallsBySeverity = COUNTROWS(EmergencyCalls)
     ```

4. **Incident Resolution Time**:
   - Create a measure for the average time to resolve an incident:
     ```DAX
     IncidentResolutionTime = AVERAGEX(Incidents, DATEDIFF(Incidents[IncidentTime], Incidents[ResolvedTime], HOUR))
     ```

### Step 5: Design the Dashboard

Now that the data is ready, you can start designing your Power BI dashboard with the following steps:

1. **Create Visuals for Each KPI**:
   - Use **Card Visuals** for displaying individual KPIs like the number of available ambulances, average response time, etc.
   - Use **Bar/Column Charts** for displaying emergency call distribution by severity, response time by ambulance, etc.
   - Use **Line Charts** to track trends over time, such as response times or ambulance availability.
   
2. **Create a Date Filter**:
   - Use a **Slicer** for selecting specific time periods (e.g., last 30 days, last 6 months) to filter the dashboard.

3. **Design Layout**:
   - Arrange the visuals in a clean, easy-to-read format with KPIs at the top, followed by charts and graphs.
   - Ensure the dashboard is interactive with slicers to filter data by different attributes (e.g., time, ambulance type, staff).

4. **Set Conditional Formatting**:
   - Use conditional formatting on metrics like response time or incident status to highlight anomalies (e.g., high response times in red).

### Step 6: Publish the Dashboard

Once the dashboard is created:

1. Save the Power BI report file.
2. Publish the report to **Power BI Service** for sharing with stakeholders.
3. Set up **automatic data refresh** to keep the dashboard updated with real-time data from the SQL Server.

### Step 7: Monitor and Improve

- Regularly monitor the dashboard to identify trends and outliers.
- Use the insights from the dashboard to make data-driven decisions, improve operational efficiency, and optimize resource allocation.

## Conclusion

By following these steps, you will have a comprehensive Power BI dashboard for your ambulance service, which will allow you to monitor KPIs in real-time. The dashboard will provide key insights into ambulance availability, response times, call severity, and other critical metrics, which are essential for improving service quality and efficiency.

For further enhancements, you can add additional data sources, incorporate more complex KPIs, or integrate with real-time systems for live data tracking.

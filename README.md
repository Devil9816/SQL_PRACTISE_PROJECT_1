# COVID-19 Data Analysis SQL Script
**Overview**
This repository contains an SQL script that performs data analysis on COVID-19 data, focusing on cases, deaths, and vaccinations. The script is designed to work with a SQL Server database and uses the dbo.CovidDeaths and dbo.CovidVaccinations tables from the PROJECT1 database.

**Prerequisites**
Before running the script, ensure you have the following:

Microsoft SQL Server installed.
Access to the PROJECT1 database containing the necessary CovidDeaths and CovidVaccinations tables.
Script Files
covid_data_analysis.sql: This is the main SQL script file that contains all the queries for data analysis.
Data Used
The script uses data from two tables:

CovidDeaths: This table contains information about COVID-19 deaths, including location, date, total cases, new cases, total deaths, and population.

CovidVaccinations: This table contains information about COVID-19 vaccinations, including location, date, and new vaccinations.

**Queries and Analysis**
The SQL script performs the following analyses:

Various SELECT queries are used to retrieve and display data related to total cases, total deaths, infection percentages, and vaccination statistics.

The script calculates the percentage of the population affected by COVID-19 in different countries and continents.

It identifies countries with the highest infection rates compared to their populations.

The script also shows countries with the highest death counts.

Data is broken down by continents for further analysis.

The script provides global numbers for total cases, total deaths, and the death percentage.

A Common Table Expression (CTE) is used to calculate rolling vaccinated people percentages.

**How to Use**
Make sure you have the required access and connection to the PROJECT1 database with the CovidDeaths and CovidVaccinations tables.

Open the covid_data_analysis.sql file in Microsoft SQL Server Management Studio (SSMS) or any SQL client that supports SQL Server.

Execute the SQL script by running the queries one by one or all at once.

The script will produce various results based on the analyses performed.

**Contact**
For any questions or feedback, please contact me.

Feel free to modify and extend the script according to your specific requirements. Happy coding!





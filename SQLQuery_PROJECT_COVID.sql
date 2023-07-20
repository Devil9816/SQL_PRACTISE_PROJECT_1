SELECT *
FROM PROJECT1.dbo.CovidDeaths
ORDER BY 3,4

--SELECT *
--FROM PROJECT1.DBO.CovidVaccinations
--ORDER BY 3,4

-- select data that we are going to be using
Select location, date, total_cases, new_cases, total_deaths, population
from PROJECT1.dbo.CovidDeaths
order by 1,2

-- looking for total cases vs total deaths
Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from PROJECT1.dbo.CovidDeaths
where location  like 'india'
order by 1,2

-- looking for total cases vs population

Select location, date, total_cases, Population, (total_cases/Population)*100 as PercentagePopulationAffected
from PROJECT1.dbo.CovidDeaths
where location  like 'india'
order by 1,2


-- looking at  countries with highest infsction rare compared to population
Select location, max(total_cases) as HighestInfectionCount , Population, max(total_cases/Population)*100 as PercentagePopulationAffected
from PROJECT1.dbo.CovidDeaths
where continent is not null
group by location, population
order by PercentagePopulationAffected desc

-- Showing countries with highest death count
Select location, max(cast(total_deaths as int)) as TotalDeathCount
from PROJECT1.dbo.CovidDeaths
where continent is not null
group by location
order by  TotalDeathCount desc


-- LET'S BREAK THINGS DOWN BY CONTINENT
Select location, max(cast(total_deaths as int)) as TotalDeathCount
from PROJECT1.dbo.CovidDeaths
where continent is null
group by location
order by  TotalDeathCount desc


-- GLOBAL NUMBERS

Select sum(new_cases) as total_cases,sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases) * 100 as DeathPercentage--total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from PROJECT1.dbo.CovidDeaths
--where location  like 'india'
WHERE continent is not null
--group by date
order by 1,2


SELECT DEA.continent, DEA.location, DEA.date, DEA.population, VAC.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
FROM PROJECT1.DBO.CovidDeaths DEA
JOIN PROJECT1.dbo.CovidVaccinations VAC
	ON DEA.location =  VAC.location
	AND DEA.DATE = VAC.date
WHERE DEA.continent IS NOT NULL AND DEA.location= 'INDIA'
ORDER BY 2,3

-- USE CTE

WITH POPVSVAC (CONTINENT, LOCATION, DATE, POPULATION, NEW_VACCINATIONS, RollingPeopleVaccinated)
AS
(
SELECT DEA.continent, DEA.location, DEA.date, DEA.population, VAC.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
FROM PROJECT1.DBO.CovidDeaths DEA
JOIN PROJECT1.dbo.CovidVaccinations VAC
	ON DEA.location =  VAC.location
	AND DEA.DATE = VAC.date
WHERE DEA.continent IS NOT NULL )

SELECT *, (RollingPeopleVaccinated/POPULATION)*100
FROM POPVSVAC

-- USE TEMP TABLE


DROP TABLE IF EXISTS #PERCENTAGEPOPULATIONVACCINATED
CREATE TABLE #PERCENTAGEPOPULATIONVACCINATED
(
CONTINENT NVARCHAR(255),
LOCATION NVARCHAR(255),
DATE DATETIME,
NEW_VACCINAES NUMERIC,
ROLLINGPEOPLEVACCINATED NUMERIC
)

INSERT INTO #PERCENTAGEPOPULATIONVACCINATED
SELECT DEA.continent, DEA.location, DEA.date,  VAC.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
FROM PROJECT1.DBO.CovidDeaths DEA
JOIN PROJECT1.dbo.CovidVaccinations VAC
	ON DEA.location =  VAC.location
	AND DEA.DATE = VAC.date
WHERE DEA.continent IS NOT NULL

SELECT *
FROM #PERCENTAGEPOPULATIONVACCINATED


CREATE VIEW PERCENTAGEPOPULATIONVACCINATED AS
SELECT DEA.continent, DEA.location, DEA.date,  VAC.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
FROM PROJECT1.DBO.CovidDeaths DEA
JOIN PROJECT1.dbo.CovidVaccinations VAC
	ON DEA.location =  VAC.location
	AND DEA.DATE = VAC.date
WHERE DEA.continent IS NOT NULL

DROP VIEW IF EXISTS  PERCENTAGEPOPULATIONVACCINATED
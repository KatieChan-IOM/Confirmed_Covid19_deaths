/*
Covid 19 Data Exploration with SQL
Data last updated 4/10/2022
*/

USE PortfolioProject;

-- inspect some of the data that been imported 

SELECT
	CD.location
	,CD.date
	,CD.total_cases
	,CD.new_cases
	,CD.total_deaths
	,CV.population
FROM CovidDeaths AS CD
JOIN CovidVaccination AS CV On CD.location = CV.location AND CD.date = CV.date
WHERE CD.continent IS NOT NULL 
ORDER BY CD.location, CD.date

-- Percentage of death if you contract covid

SELECT
	location
	,date
	,total_cases
	,total_deaths
	,CAST((total_deaths / total_cases * 100) as numeric(10,6)) AS death_percentage
FROM CovidDeaths
WHERE continent IS NOT NULL AND location in ('Isle of Man', 'Hong Kong')
ORDER BY location, date

-- Percentage of population infected with Covid

SELECT
	CD.location
	,CD.date
	,CD.total_cases
	,CV.population
	,CAST((CD.total_cases / CV.population * 100) as numeric(10,6)) AS infected_rate
FROM CovidDeaths AS CD
JOIN CovidVaccination AS CV On CD.location = CV.location AND CD.date = CV.date
WHERE CD.continent IS NOT NULL AND CD.location in ('Isle of Man', 'Hong Kong')
ORDER BY CD.location, CD.date

-- 30 countries with most infection rate by population

SELECT TOP 30
	CD.location
	,MAX(CD.total_cases) AS infection_count
	,CV.population
	,CAST((MAX(CD.total_cases) / CV.population * 100) as numeric(10,6)) AS infected_rate
FROM CovidDeaths AS CD
JOIN CovidVaccination AS CV On CD.location = CV.location AND CD.date = CV.date
WHERE CD.continent IS NOT NULL 
GROUP BY CD.location, CV.population
ORDER BY infected_rate DESC

-- 30 countries with least infection rate by population

SELECT TOP 30
	CD.location
	,MAX(CD.total_cases) AS infection_count
	,CV.population
	,CAST((MAX(CD.total_cases) / CV.population * 100) as numeric(10,6)) AS infected_rate
FROM CovidDeaths AS CD
JOIN CovidVaccination AS CV On CD.location = CV.location AND CD.date = CV.date
WHERE CD.continent IS NOT NULL AND CV.population IS NOT NULL
GROUP BY CD.location, CV.population
ORDER BY infected_rate

-- 30 countries with most death count per population

SELECT TOP 30
	location
	,CAST(MAX(total_deaths) as int) AS death_count
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY death_count DESC

-- 30 countries with least death count per population

SELECT TOP 30
	location
	,CAST(MAX(total_deaths) as int) AS death_count
FROM CovidDeaths
WHERE continent IS NOT NULL AND total_deaths >= 1
GROUP BY location
ORDER BY death_count 

-- By continent


-- Top 30 contintents with the most death count per population


-- Globally


-- Percentage of population that has recieved at least one Covid Vaccine


-- Using CTE to perform calculation on partition by 


-- Using temp table to perform calculation on partition by


-- Creating view to store data for visualizations later on


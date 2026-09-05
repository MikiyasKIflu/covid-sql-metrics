Select*
From portfoliproject.coviddeaths
Where continent is null
order by 3,4;

Select*
From portfoliproject.covidvaccinations
order by 3,4;

Select location, date, total_cases, new_cases,total_deaths, population
From portfoliproject.coviddeaths
Order by 3,4;

-- Looking at Total Cases vs Total Deaths
-- Shows Likelihood of dying if you contact covid in your country
Select location, date, total_cases, new_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From portfoliproject.coviddeaths
Where location like '%state%'
Order by 1,2;

-- Looking at Total Cases Vs Population
-- Shows What percentage of population got Covid
Select location, date, total_cases, new_cases, population, (total_cases/population)*100 as PercentPopulationInfected
From portfoliproject.coviddeaths
-- Where location like '%state%'
Order by 1,2;

-- Looking at Countries with Highest Infection Rate compared to population
Select location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
From portfoliproject.coviddeaths
-- Where location like '%state%'
group by location, population
Order by PercentPopulationInfected desc;

-- Showing Countries With Highest Death Count per Population
Select location, MAX(cast(total_deaths as SIGNED)) as TotalDeathCount
From portfoliproject.coviddeaths
-- Where location like '%state%'
Where continent is not null
group by location
Order by TotalDeathCount desc;

-- LET'S BREAK THINGS DOWN BY CONTINENT
Select continent, MAX(cast(total_deaths as SIGNED)) as TotalDeathCount
From portfoliproject.coviddeaths
-- Where location like '%state%'
Where continent is not null
group by continent
Order by TotalDeathCount desc;

-- Showing continets with the highest death count per population
Select continent, MAX(cast(total_deaths as SIGNED)) as TotalDeathCount
From portfoliproject.coviddeaths
-- Where location like '%state%'
Where continent is not null
group by continent
Order by TotalDeathCount desc;

-- GLOBAL NUMBERS
SELECT date, SUM(new_cases) as total_cases, SUM(CAST(new_deaths AS SIGNED)) as toal_deaths, SUM(CAST(new_deaths AS SIGNED))/SUM(new_cases)*100 AS DeathPercentage
FROM portfoliproject.coviddeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1, 2;

-- LOOKING at Total Populaton vs Vaccinations
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(cast(vac.new_vaccinations AS SIGNED)) over ( partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated 
-- (RollingPeopleVaccinated/population)*100
From portfoliproject.coviddeaths dea
Join portfoliproject.covidvaccinations vac
on dea.location = vac.location
and dea.date = vac.date
WHERE dea.continent IS NOT NULL
order by 2,3;

-- USE CTE
WITH popvsVac (continent, Location, Date, Population, new_vaccinations, RollingPeopleVaccinated) AS (
    SELECT 
        dea.continent, 
        dea.location, 
        dea.date, 
        dea.population, 
        vac.new_vaccinations, 
        SUM(CAST(vac.new_vaccinations AS SIGNED)) OVER (
            PARTITION BY dea.location 
            ORDER BY dea.date
        ) AS RollingPeopleVaccinated
    FROM portfoliproject.coviddeaths dea
    JOIN portfoliproject.covidvaccinations vac
        ON dea.location = vac.location
        AND dea.date = vac.date
    WHERE dea.continent IS NOT NULL
)
SELECT *, (RollingPeopleVaccinated/population)*100
FROM popvsVac
ORDER BY Location, Date;





-- TEMP TABLE


DROP TEMPORARY TABLE IF EXISTS PercentPopulationVaccinated;

CREATE TEMPORARY TABLE PercentPopulationVaccinated AS
SELECT 
    dea.continent, 
    dea.location, 
    dea.date, 
    dea.population, 
    vac.new_vaccinations, 
    SUM(CAST(NULLIF(vac.new_vaccinations, '') AS SIGNED)) OVER (
        PARTITION BY dea.location 
        ORDER BY dea.date
    ) AS RollingPeopleVaccinated
FROM portfoliproject.coviddeaths dea
JOIN portfoliproject.covidvaccinations vac
    ON dea.location = vac.location
    AND dea.date = vac.date
WHERE dea.continent IS NOT NULL;

-- Final query to view the results
SELECT *, (RollingPeopleVaccinated / population) * 100 AS PercentPeopleVaccinated
FROM PercentPopulationVaccinated
ORDER BY Location, Date;

-- Creating View to store data for later visualizations

Create View PercentPeopleVaccinated as 
SELECT 
    dea.continent, 
    dea.location, 
    dea.date, 
    dea.population, 
    vac.new_vaccinations, 
    SUM(CAST(NULLIF(vac.new_vaccinations, '') AS SIGNED)) OVER (
        PARTITION BY dea.location 
        ORDER BY dea.date
    ) AS RollingPeopleVaccinated
FROM portfoliproject.coviddeaths dea
JOIN portfoliproject.covidvaccinations vac
    ON dea.location = vac.location
    AND dea.date = vac.date
WHERE dea.continent IS NOT NULL;
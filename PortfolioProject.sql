SELECT * FROM PortfolioProject.coviddeaths
where continent is not null
order by 3,4;


-- To get Highest Infection Count and group by Location, population and date
SELECT LOCATION, POPULATION,date, MAX(TOTAL_CASES) AS HIGHESTINFECTIONCOUNT, MAX(total_cases/population)*100 AS 
PERCENTPOPULATIONINFECTED
FROM PortfolioProject.coviddeaths
group by LOCATION, POPULATION,date
ORDER BY PERCENTPOPULATIONINFECTED DESC;



-- To get Total Deaths World-Wide 
SELECT LOCATION, MAX(total_deaths) AS TOTAL_DEATH_COUNT
FROM PortfolioProject.coviddeaths
where continent is null
group by LOCATION
ORDER BY TOTAL_DEATH_COUNT DESC;

SELECT continent, MAX(total_deaths) AS TOTAL_DEATH_COUNT
FROM PortfolioProject.coviddeaths
where continent is not null
group by continent
ORDER BY TOTAL_DEATH_COUNT DESC;


-- To get Total Deaths for a sepcific location in the case 'Africa'
select location, MAX(total_deaths) AS TOTAL_DEATH_COUNT
from PortfolioProject.coviddeaths
where continent like '%africa%'
group by location
order by TOTAL_DEATH_COUNT;

-- To get Total Covid Cases World-Wide 
select sum(new_cases) as total_cases, sum(new_deaths) as total_deaths, sum(new_deaths)/sum(new_cases)*100 as DeathPercentage-- , total_deaths, (total_deaths/total_cases)*100 AS TOTAL_DEATH_PERCENTAGE
from PortfolioProject.coviddeaths
where continent is not null
-- group by date
order by 1,2;


-- Looking at Total Population vs. Vaccination
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(int,vac.new_vaccinations)) OVER (PARTITION BY dea.location,
dea.date) as Rolling_people_vaccinated
from PortfolioProject.coviddeaths dea
join PortfolioProject.covidvaccinations vac
	on dea.location = vac.location
    and dea.date = vac.date
where dea.continent is not null
order by 2,3;









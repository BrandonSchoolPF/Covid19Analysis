data <- read.csv("owid-covid-data.csv")

#percentage of covid cases vs population
covid_percentage <- sqldf("SELECT location, date, population, total_cases, (total_cases/population)*100 AS covid_percentage
                           FROM data")
write.csv(covid_percentage, "covid_percentage.csv")

#Each Countries highest covid rate from covid_percentage 

max_covid_percentage <- sqldf("SELECT location, date, population, total_cases, MAX(covid_percentage)
                               FROM Covid_percentage
                               GROUP BY location, population")
write.csv(max_covid_percentage, "max_covid_percentage.csv")

#Percentage of cases vs deaths 
deaths_percentage <- sqldf("SELECT location, date, population, total_cases, total_deaths, (total_deaths/ total_cases)*100 as Death_percentage
                            FROM data")
write.csv(deaths_percentage, "deaths_percentage.csv")

#What countries had the highest covid related deaths
most_covid_deaths <- sqldf("SELECT location, date, population, total_cases, MAX(total_deaths), Death_percentage
                            FROM deaths_percentage
                            GROUP BY location, population")
write.csv(most_covid_deaths, "most_covid_deaths.csv")

#What are the most total cases in each major continents
continent_cases <- sqldf("SELECT continent, SUM(new_cases)
                          FROM data
                          WHERE continent != '' AND new_cases != ''
                          GROUP BY continent")
write.csv(continent_cases, "continent_cases.csv")

#Most deaths by continent
most_deaths_continent <- sqldf("SELECT continent, SUM(new_deaths)
                          FROM data
                          WHERE continent != '' AND new_deaths != ''
                          GROUP BY continent")
write.csv(most_deaths_continent, "most_deaths_continent.csv")
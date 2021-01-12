library(tidyverse)

gapminder_data <- read_csv("data/gapminder_data.csv")
View(gapminder_data)
summarize(gapminder_data, mean(lifeExp))
summarize(gapminder_data, averageLifeExp = mean(lifeExp))

#piping function: %>%
gapminder_data %>% summarize(averageLifeExp = mean(lifeExp))
  
summarize(gapminder_data, mean(pop))
gapminder_data %>% summarize(averagePopulation = mean(pop))

#filter only most recent year
gapminder_data %>% summarize(averagePopulation = mean(pop),
                             recent_year = max(year))
#filter rows to 2007
gapminder_data %>% filter(year = 2007)
gapminder_data %>% filter(year == 2007)
gapminder_data %>% filter(year == 2007) %>% summarize(averagePopulation = mean(pop))
gapminder_data %>% filter(year == 2007) %>% summarize(averageLifeExp = mean(lifeExp))

#average GFP per capita for first year in dataset
gapminder_data %>% summarize(oldest_year = min(year))
gapminder_data %>% filter(year == 1952) %>% summarize(average_GDPperCap = mean(gdpPercap))

#group_by
gapminder_data %>% 
  group_by(year) %>% 
  summarize(averageLifeExp = mean(lifeExp))

#Exercise find mean life Exp for each continent
gapminder_data %>% 
  group_by(continent) %>% 
  summarize(averageLifeExp = mean(lifeExp))

#mutate - add more columns to your dataset
gapminder_data %>% 
  mutate(gdp = gdpPercap * pop)

#Exercise make new column for pop in millions
gapminder_data %>% 
  mutate(popmil = pop/1000000)

#select() - specify which columns we want to keep
gapminder_data %>% 
  select(year, pop)

gapminder_data %>% 
  select(-continent)

#Exercise: select dataset with country, continent, year, and lifeExp
gapminder_data %>% 
  select(country, continent, year, lifeExp)

gapLim <- gapminder_data %>% 
  select(country, continent, year, lifeExp)

gapminder_data <- read_csv("data/gapminder_data.csv")

#long vs wide
#pivot_longer and pivot_wider

gapLim %>% 
  pivot_wider(names_from = year , values_from = lifeExp)

> #Create a new dataset with only data from the Americas and 2007
  #drop continent and year columns
  
TheLimited <- gapminder_data %>% 
  select(continent == Americas, year == 2007)
gapminder_data <- read_csv("data/gapminder_data.csv")

TheLimited <- gapminder_data %>% 
  filter(continent == "Americas", year == 2007)

TheLimited %>% 
  select(-continent, -year)

TheLimited

gapminder_data <- read_csv("data/gapminder_data.csv") %>%
  filter(continent == "Americas", year == 2007) %>% 
  select(-continent, -year)

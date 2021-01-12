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

View(gapminder_data)

read_csv("data/co2-un-data.csv", skip = 2,
         col_names = c("region", "country", "year", "series", "value", 
                       "footnotes", "source"))

co2_data <- read_csv("data/co2-un-data.csv", skip = 2,
                     col_names = c("region", "country", "year", "series", "value", 
                                   "footnotes", "source"))
View(co2_data)

#Goals: data from a year that is close to 2007
#A column for each country and type of CO2 emission

#exercise select only country year series value
co2_data %>% 
  select(country, year, series, value)

co2_emissions <- co2_data %>% 
  select(country, year, series, value) %>% 
  mutate(series = recode(series, "Emissions (thousand metric tons of carbon dioxide)" = "total_emissions", 
                         "Emissions per capita (metric tons of carbon dioxide)" = "per_capita_emissions")) %>% 
  pivot_wider(names_from = series, values_from = value) %>% 
  filter(year == 2005) %>% 
  select(-year)

View(co2_emissions)

#joining the datasets
inner_join(gapminder_data, co2_emissions, by = "country")
anti_join(gapminder_data, co2_emissions)

co2_emissions <- co2_emissions %>% 
  mutate(country = recode(country, "Bolivia (Plurin. State of)" = "Bolivia", "United States of America" = "United States", "Venezuela (Boliv. Rep. of)" = "Venezuela"))

anti_join(gapminder_data, co2_emissions)

View(co2_emissions)

#change PR to be part of US
gapminder_data <- gapminder_data %>% 
  mutate(country = recode(country, "Puerto Rico" = "United States")) %>% 
  group_by(country) %>% 
  summarize(lifeExp = sum((lifeExp * pop)/sum(pop)), 
            gdpPercap = sum((gdpPercap * pop)/ sum(pop), pop = sum(pop)))

anti_join(gapminder_data, co2_emissions)
gapminder_co2 <- inner_join(gapminder_data, co2_emissions, by = "country")

#mutate and the if_else
#create region variable
gap_co2_region <- gapminder_co2 %>% 
  mutate(region = if_else(country == "Canada" | country == "United States" | country == "Mexico",
                          "north", "south"))

#How much co2 does "north" emit
gap_co2_region %>% 
  group_by(region) %>% 
  summarize(sum(total_emissions))
gap_co2_region %>% 
  group_by(region) %>% 
  summarize(sum(per_capita_emissions))

#exercise: create scatter plot of gdp vs Co2 emissions, colored by region
ggplot(data=gap_co2_region)+
  aes(x = gdpPercap, y= per_capita_emissions, color = region)+
  geom_point()+
  labs(x = "GDP Per Capita", y = "Per Capita Emissions")

co2plot <- ggplot(data=gap_co2_region)+
  aes(x = gdpPercap, y= per_capita_emissions, color = region)+
  geom_point()+
  labs(x = "GDP Per Capita", y = "Per Capita Emissions")

ggsave("co2_emissions_plot.jpg", plot = co2plot, width = 6, height = 4) 

write_csv(gap_co2_region, "data/gapminder_co2.csv")

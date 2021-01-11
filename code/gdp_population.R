#load tidyverse packages
library(tidyverse)

#read in data
gapminder_1997 <- read_csv("data/gapminder_1997.csv")
#assigning values to objects
name <- "Ben"
name
age <- 26
age
name <- "Harry Potter"
name
#learn more about a function
?read_csv

read_csv(file = "data/gapminder_1997.csv")

#Learning more about functions
?round
round(3.1415)
round(3.1415,3)

#Position of the arguments in functions
round(x = 3.1415)
round(x = 3.1415, digits = 2)
round(digits = 2, x = 3.1415)
round(2, 3.1415)
round (2,3.6)

#make a plot
ggplot(data = gapminder_1997) +
  aes(x = gdpPercap)+
  labs(x = "GDP Per Capita")+
  aes(y = lifeExp)+
  labs(y = "Life Expectancy")

#exercise add life expectancy to y axis

ggplot(data = gapminder_1997) +
  aes(x = gdpPercap)+
  labs(x = "GDP Per Capita")+
  aes(y = lifeExp)+
  labs(y = "Life Expectancy") +
  labs(title = "Do people in wealthy countries live longer?") +
  geom_point()+
  aes(color=continent)+
  scale_color_brewer(palette = "Set1")+
  aes(size = pop/1000000)+
  labs(size = "Population (in Millions")+
  aes(shape = continent)

#different color palettes
RColorBrewer::display.brewer.all()

#exercise Changing shapes
geom_point(shape=23)

#collapse commands
ggplot(data = gapminder_1997, aes(x = gdpPercap, y = lifeExp, color=continent, size = pop/1000000)) +
  labs(x = "GDP Per Capita", y = "Life Expectancy", 
       size = "Population (in Millions", title = "Do people in wealthy countries live longer?")+
  geom_point()+
  scale_color_brewer(palette = "Set1")
 
#exercise read in own data
gapminder_data <- read_csv("data/gapminder_data.csv")

?scale_color_brewer

gapminder_data <- read_csv("data/gapminder_data.csv")
gapminder_data <- read_csv("data/gapminder_data.csv")

ggplot(data = gapminder_data, aes(x = year, y = lifeExp, group = country, color = continent))+
  geom_line()

#use gapminder_1997 to make boxplot where continent is x axis and life expectancy is y axis
ggplot(data = gapminder_1997) +
  aes(x = continent, y = lifeExp) +
  geom_boxplot()+
  labs(x = "Continent", y = "Life Expectancy (yrs)")

read_csv(file = "data/gapminder_data.csv")
View(gapminder_data)

ggplot(data = gapminder_1997) +
  aes(x = continent, y = lifeExp) +
  geom_violin()+
  labs(x = "Continent", y = "Life Expectancy (yrs)")+
  geom_point()

ggplot(data = gapminder_1997) +
  aes(x = continent, y = lifeExp) +
  labs(x = "Continent", y = "Life Expectancy (yrs)")+
  geom_jitter(aes(size = pop))+
  geom_violin(alpha=0.5, fill = 'darkolivegreen')
sample(colors(), size = 10)  

ggplot(data = gapminder_1997, aes(fill = continent)) +
  aes(x = continent, y = lifeExp) +
  labs(x = "Continent", y = "Life Expectancy (yrs)")+
  geom_jitter(aes(size = pop))+
  geom_violin(alpha = 0.5)

ggplot(gapminder_1997)+
  geom_histogram(bins=15)+
  aes(x=lifeExp)+
  theme_bw()+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))

violin_plot ggplot(data = gapminder_1997, aes(fill = continent)) +
  aes(x = continent, y = lifeExp) +
  labs(x = "Continent", y = "Life Expectancy (yrs)")+
  geom_jitter(aes(size = pop))+
  geom_violin(alpha = 0.5)


ggsave('figures/awesome_plot.jpg'), width = 6, height = 4)

violin_plot + theme_bw()
violin_plot
 
violin_plot <- ggplot(data = gapminder_1997, aes(fill = continent)) +
  aes(x = continent, y = lifeExp) +
  labs(x = "Continent", y = "Life Expectancy (yrs)")+
  geom_jitter(aes(size = pop))+
  geom_violin(alpha = 0.5)

violin_plot
ggsave('figures/awesome_violin_plot.jpg', plot = violin_plot, width = 6, height = 4)

ggplot(data = gapminder_1997)+
  aes(x = gdpPercap, y = lifeExp)+
  geom_point() +
  facet_wrap(vars(continent))

histogram <- ggplot(gapminder_1997)+
  geom_histogram(bins=15)+
  aes(x=lifeExp)+
  theme_bw()+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))
histogram
ggsave('figures/awesome_plot.jpg', plot = histogram, width = 6, height = 4)

ggplot(data = gapminder_1997)+
  aes(x = gdpPercap, y = lifeExp)+
  geom_point() +
  facet_wrap(vars(continent))

ggplot(data = gapminder_1997) +
  aes(x = continent, y = lifeExp) +
  labs(x = "Continent", y = "Life Expectancy (yrs)")+
  geom_violin(fill = 'mediumpurple3')

sample(colors(), size = 10) 

ggsave('figures/my_awesome_plot.jpg', width = 6, height = 4)

facet_plot <- ggplot(data = gapminder_1997) +
  aes(x = continent, y = lifeExp) +
  labs(x = "Continent", y = "Life Expectancy (yrs)")+
  geom_violin(fill = 'mediumpurple3')

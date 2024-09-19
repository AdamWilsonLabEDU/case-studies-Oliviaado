#installing_packages
#install.packages("gapminder")
#install.packages("dplyr")
#install.packages("ggplot2")
#loading)packages
library(ggplot2)
library(gapminder)
library(dplyr)
#filter kuwait from gapminder
filter(gapminder, country != "Kuwait")
filter_gapminder <- filter(gapminder, country!="Kuwait")
#create the plot using ggplot with theme_bw
ggplot(data=filter_gapminder, aes(x = lifeExp, y = gdpPercap, color = continent, size = pop/100000)) +
  geom_point(data=filter_gapminder, aes(x = lifeExp, y = gdpPercap, color = continent, size = pop/100000)) + 
  facet_wrap(~year,nrow=1) + 
  scale_y_continuous(trans = "sqrt") + 
  theme_bw() +
  labs(x = "gdpPercap", y = "lifeExp", 
       color = "continent", size = "population (in hundreds of thousands)")
print(gapminder_continent)
#data for second plot
gapminder_continent <- filter_gapminder %>% 
  group_by(continent, year)%>% 
  summarise(gdpPercapweighted = weighted.mean(x = gdpPercap, w = pop),
            pop = sum(as.numeric(pop)))
ggplot() + 
  geom_line(data = filter_gapminder, mapping = aes(x = year, y = gdpPercap,
                                                   color = continent, 
                                                   group = country)) +
  geom_point(data = filter_gapminder, mapping = aes(x = year, y = gdpPercap,
                                                    color = continent, 
                                                    group = country)) +
  geom_line(data = gapminder_continent, mapping = aes(x = year, y = gdpPercapweighted)) +
  geom_point(data = gapminder_continent, mapping = aes(x = year, y = gdpPercapweighted, size = pop/100000)) +
  facet_wrap(~continent,nrow=1) + 
  scale_y_continuous(trans = "sqrt") +
  theme_bw() + 
  labs(x = "Years", y = "GDP Per capital", 
       color = "continent", size = "population (in hundreds of thousands)")
#save graph
ggsave("Case_3_Results.png")


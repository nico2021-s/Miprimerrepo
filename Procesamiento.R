# install.packages("dslabs")
# install.packages("tidyverse")
library(dslabs)
library(tidyverse)
s = dslabs::gapminder

library(ggplot2)
ggplot(s, aes(x=continent, y=fertility))+geom_col()
unique(s$year)
length(unique(s$year))
# Agrupar por año la cantidad de observaciones que aparecen para Colombia
length(unique(s$country)) 
muestra = s %>% filter(country == "Colombia") %>% group_by(year) %>% summarise(conteo=n())
# Calcule el promedio para los países de suramérica en fertilidad y esperanza de vida
unique(s$region[s$continent=="Americas"])
unique(s$continent)
## Sudamérica
muestra = s %>% filter(region == "South America") %>% group_by(year,continent) %>% summarise(promedio_f=round(mean(fertility,na.rm=TRUE),0),
                                                                                   promedio_ev=round(mean(life_expectancy,na.rm=TRUE),0))
ggplot(muestra, aes(x=year))+geom_line(aes(y=promedio_f,colour="fertilidad"))+geom_line(aes(y=promedio_ev,colour="esperanza_de_vida"))
ggplot(muestra, aes(x=promedio_f, y=promedio_ev))+geom_point()
## Europa
muestra = s %>% group_by(year,continent) %>% summarise(promedio_ev=round(mean(life_expectancy,na.rm=TRUE),0))
muestra = spread(muestra,continent,promedio_ev)
## Gráfica
ggplot(muestra,aes(x=year))+geom_line(aes(y=Africa,colour="Africa"))+geom_line(aes(y=Americas,colour="Americas"))+geom_line(aes(y=Oceania,colour="Oceania"))+geom_line(aes(y=Europe,colour="Europe"))+geom_line(aes(y=Asia,colour="Asia"))

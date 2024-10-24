#load data

data("iris")

#calculate mean of petal length

petal_length_mean<-mean(iris$Petal.Length)

petal_length_mean

hist(iris$Petal.Length)``
#install ggplot2

#find ggplot in library
library(ggplot2)
#calculate hist using ggplot2 and save as "p"

plot <- ggplot(data=iris, aes(x=Petal.Length)) + geom_histogram( color = "black", fill = "red" )

print(plot)
ggsave(plot, filename = "myplot.png")  

#summary of each column

#summary of sepal.length

summary(iris$Sepal.Length)

#summary of sepal.width

summary(iris$Sepal.Width)

#summary of petal.length

summary(iris$Petal.Length)

#summary of petal.width

summary(iris$Petal.Width)

#show data as scattered plot

plot(iris$Petal.Length)
#how do i view my iris data in a spread sheet?

View(iris)

#save plot

save(hist(iris$Petal.Length)

     
     


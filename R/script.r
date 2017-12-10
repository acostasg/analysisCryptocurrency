###############
# PRACTICA 2  #
###############

#instal·lem la libreria arules i importem llibreries necesaries
install.packages("devtools", type = "source",  dep = T)
install.packages("arulesViz",  dep = T)
install.packages("arules", dep = T)
library(arulesViz)
library(arules)
library(xlsx)

#importem les dades en una variablepaste(home,"/../csv/dataset/dataset.csv")
home <- dirname(rstudioapi::getActiveDocumentContext()$path)
path_dataset <- paste(home,"/../csv/dataset/dataset.csv", sep="")
dataset <- read.csv(path_dataset, header = TRUE, sep = ',')
View(dataset)

#resum per veure el domini de les dades
summary(dataset)

#cerquem els valors extrems
boxplot( x= dataset$Preu..Euros., main = "Preus" )
d <- density(dataset$Preu..Euros.)
plot(x= d, main = "Preus")
polygon(d, col="blue", border="black") 

#observem bitcoin
bitcoin = subset(x = dataset, 
       subset = dataset$Simbol == "BTC" )

d <- density(bitcoin$Preu..Euros.)
plot(x= d, main = "Bitcoin")
polygon(d, col="blue", border="black") 

#observem IOTA molt experts la anomen com la moneda que reemplaçara al bitcoin
miota = subset(x = dataset, 
                 subset = dataset$Simbol == "MIOTA" )

d <- density(miota$Preu..Euros.)
plot(x= d, main = "MIOTA")
polygon(d, col="blue", border="black") 

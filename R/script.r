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

##############################
# Cerquem els valors extrems #
##############################

#cryptomoneda densitat
criptomoneda_menor_1 = subset(x = dataset, 
               subset = dataset$Tipus == "crypto_moneda" &  dataset$Preu..Euros. <= 1)
boxplot( x= criptomoneda$Preu..Euros., main = "Preu CryptoMonedes menors 1 euro" )
d <- density(criptomoneda$Preu..Euros.)
plot(x= d, main = "Preus Cryptomonedes cotització inferior a 1 euro")
polygon(d, col="blue", border="black") 

criptomoneda_mayor_1_inferior_100 = subset(x = dataset, 
                              subset = dataset$Tipus == "crypto_moneda" &  dataset$Preu..Euros. >= 1 & dataset$Preu..Euros. <= 100)
boxplot( x= criptomoneda_mayor_1$Preu..Euros., main = "Preu CryptoMonedes mayors a 1 euro" )
d <- density(criptomoneda_mayor_1$Preu..Euros.)
plot(x= d, main = "Preus Cryptomonedes cotització superior a 1 euro e inferior a 100")
polygon(d, col="blue", border="black") 

criptomoneda_mayor_100 = subset(x = dataset, 
                                           subset = dataset$Tipus == "crypto_moneda" & dataset$Preu..Euros. >= 100)
boxplot( x= criptomoneda_mayor_1$Preu..Euros., main = "Preu CryptoMonedes mayors a 100 euro" )
d <- density(criptomoneda_mayor_1$Preu..Euros.)
plot(x= d, main = "Preus Cryptomonedes cotització superior a 1 euro")
polygon(d, col="blue", border="black") 

#stock index densitat
stock_index = subset(x = dataset, 
                      subset = dataset$Tipus == "index_borsatil" )
boxplot( x= stock_index$Preu..Euros., main = "Preu Stock index" )
d <- density(stock_index$Preu..Euros.)
plot(x= d, main = "Preu Stock Index")

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

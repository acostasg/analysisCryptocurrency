###############
# PRACTICA 2  #
###############

#instal·lem la libreria arules i importem llibreries necesaries
install.packages("devtools", type = "source",  dep = T)
install.packages("arulesViz",  dep = T)
install.packages("gdtools",  dep = T)
install.packages("dplyr",  dep = T)
install.packages("ggplot2",  dep = T)
install.packages("arules", dep = T)
install.packages("NbClust", dep = T)
install.packages("factoextra", dep = T)
install.packages("ggExtra", dep = T)
library(ggExtra)
library(factoextra)
library(NbClust)
library(ggplot2)
library(dplyr)
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

summary(dataset$Tipus_cotitzacio)

##############################
# CERQUEM ELS VALORS EXTREMS #
##############################

##############################
#        Densitat            #
##############################


cotitizacio_baixa = subset(x = dataset, 
               subset = dataset$Tipus_cotitzacio == "baixa")
boxplot( x= cotitizacio_baixa$Preu..Euros., main = "Preu cotització baixa" )
d <- density(cotitizacio_baixa$Preu..Euros.)
plot(x= d, main = "Preu cotització baixa")
polygon(d, col="blue", border="black") 

cotitizacio_normal = subset(x = dataset, 
                           subset = dataset$Tipus_cotitzacio == "normal")
boxplot( x= cotitizacio_normal$Preu..Euros., main = "Preu cotització normal" )
d <- density(cotitizacio_normal$Preu..Euros.)
plot(x= d, main = "Preu cotització normal")
polygon(d, col="blue", border="black") 


cotitizacio_alta = subset(x = dataset, 
                           subset = dataset$Tipus_cotitzacio == "alta")
boxplot( x= cotitizacio_alta$Preu..Euros., main = "Preu cotització alta" )
d <- density(cotitizacio_alta$Preu..Euros.)
plot(x= d, main = "Preu cotització alta")
polygon(d, col="blue", border="black") 


cotitizacio_molt_alta = subset(x = dataset, 
                           subset = dataset$Tipus_cotitzacio == "molt_alta")
boxplot( x= cotitizacio_molt_alta$Preu..Euros., main = "Preu cotització molt alta" )
d <- density(cotitizacio_molt_alta$Preu..Euros.)
plot(x= d, main = "Preu cotització molt alta")
polygon(d, col="blue", border="black") 


##############################
#   Altres observacions      #
##############################

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


########################################
#   Test de Levene #   Homogeneitat    #
########################################

with(dataset, tapply(Preu..Euros., list(Tipus), var, na.rm=TRUE))
leveneTest(Preu..Euros. ~ Tipus, data=dataset, center="mean")

with(dataset, tapply(Preu..Euros., list(Tipus, Tipus_cotitzacio), var, na.rm=TRUE))
leveneTest(Preu..Euros. ~ Tipus*Tipus_cotitzacio, data=dataset, center="mean")

###############################################
#  Kmeans creació cluster #   Homogeneitat    #
###############################################

#normalitzem els preus, no ens intersa donar mes pes a les monedes amb preu elevat sin a les tendencies
price_norm = scale(dataset$Preu..Euros.)

#per obtenir la partició mes optima
nb <- NbClust(price_norm, distance = "euclidean", min.nc = 2,
              max.nc = 4, method = "kmeans")

#The result of NbClust using the function fviz_nbclust() [in factoextra], as follow:

fviz_nbclust(nb)

#k-means amb 2 particions segons la major distancia dels centroides
clusters_2 <- kmeans(price_norm,2, 15)
print(clusters_2)

#k-means amb 4 particions segons la major distancia dels centroides
clusters_4 <- kmeans(price_norm,4, 15)
print(clusters_4)

###############################################
#         Grafics/Representació               #
###############################################

#graficament
plot(price_norm, col =(clusters_2$cluster) , main="K-Means result with 2 clusters", pch=20, cex=2)

#graficament
plot(price_norm, col =(clusters_4$cluster) , main="K-Means result with 4 clusters", pch=20, cex=2)

#comparació tipus de preus o rangs amb cryptomonedes/stock índex
plot(dataset$Tipus_cotitzacio, dataset$Tipus, xlab = "Tipus de cotització", ylab = "Cryptomoneda/stock index")

#inversa de la anterior comparació de cryptomondes i sotck index amb el tipus de preus
plot(dataset$Tipus, dataset$Tipus_cotitzacio, xlab = "Cryptomoneda/stock index", ylab = "Tipus de cotització")



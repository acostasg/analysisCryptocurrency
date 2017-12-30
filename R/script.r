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
install.packages("agricolae", dep = T)
install.packages("dplyr", dep = T)
install.packages("corrplot", dep = T)
library(agricolae)
library(ggExtra)
library(factoextra)
library(NbClust)
library(ggplot2)
library(dplyr)
library(arulesViz)
library(arules)
library(xlsx)
library(dplyr)
library(corrplot)

#importem les dades en una variablepaste(home,"/../csv/dataset/dataset.csv")
home <- dirname(rstudioapi::getActiveDocumentContext()$path)
path_dataset <- paste(home,"/../csv/dataset/dataset.csv", sep="")
dataset <- read.csv(path_dataset, header = TRUE, sep = ',')
dataset$Data <- as.Date( as.character(dataset$Data), "%Y-%m-%d")
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

#tendencia del bitcoin durant l'estudi
bitcoin= bitcoin[order(bitcoin$Data),]
plot(bitcoin$Preu..Euros.,type="l")

#observem IOTA molt experts la anomen com la moneda que reemplaçara al bitcoin
miota = subset(x = dataset, 
                 subset = dataset$Simbol == "MIOTA" )
bitcoin= miota[order(bitcoin$Data),]
plot(miota$Preu..Euros.,type="l")

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
#        Frecuencies                          #
###############################################

F_baixa=table.freq(hist(cotitizacio_baixa$Preu..Euros.,plot=FALSE))
F_baixa
plot(F_baixa$Frequency,type="l")

F_normal=table.freq(hist(cotitizacio_normal$Preu..Euros.,plot=FALSE))
F_normal
plot(F_normal$Frequency ,type="l")

F_alta=table.freq(hist(cotitizacio_alta$Preu..Euros.,plot=FALSE))
F_alta
plot(F_alta$Frequency,type="l")

F_molt_alta=table.freq(hist(cotitizacio_molt_alta$Preu..Euros.,plot=FALSE))
F_molt_alta
plot(F_molt_alta$Frequency,type="l")


#########################################################################################
#         test de contrast d’hipòtesis de variables dependents (Wilcoxon)               #
#########################################################################################

dataset$Data <- as.Date( as.character(dataset$Data), "%Y-%m-%d")

#BTCBitcon
bitcoin_october = subset(x = dataset, 
                  subset = dataset$Simbol == "BTC" 
                  & dataset$Data < as.Date("2017-11-01")
                  )

bitcoin_novembre = subset(x = dataset, 
                   subset = dataset$Simbol == "BTC" 
                   & dataset$Data > as.Date("2017-11-012")
                   )
x1 = rnorm(bitcoin_october$Preu..Euros.)
x2 = rnorm(bitcoin_novembre$Preu..Euros.)
test <- wilcox.test(x1,x2)
print(test)ç
# W = 112, p-value = 0.767
boxplot(x1,x2, names=c("X1","X2"))

#MIOTA
miota_octuber = subset(x = dataset, 
                subset = dataset$Simbol == "MIOTA" 
                & dataset$Data < as.Date("2017-11-01") )

miota_novembre = subset(x = dataset, 
                 subset = dataset$Simbol == "MIOTA" 
                 & dataset$Data > as.Date("2017-11-01")
                 )

x1 = rnorm(miota_octuber$Preu..Euros.)
x2 = rnorm(miota_novembre$Preu..Euros.)
test <- wilcox.test(x1,x2)
print(test)
#W = 91, p-value = 0.5816
boxplot(x1,x2, names=c("X1","X2"))

monedes <- distinct(dataset,Simbol)
p_value <- 1
moneda_mes_diferencia <- "cap"
for ( moneda in monedes$Simbol ) {
  
  octuber = subset(x = dataset, 
                         subset = dataset$Simbol == moneda 
                         & dataset$Data < as.Date("2017-11-01") )
  
  novembre = subset(x = dataset, 
                          subset = dataset$Simbol == moneda
                          & dataset$Data > as.Date("2017-11-01")
                    )
  
  x1 = rnorm(octuber$Preu..Euros.)
  x2 = rnorm(novembre$Preu..Euros.)

    if (length(x1)>0 && length(x2)>0 ) {
      test <- wilcox.test(x1,x2)
      if(p_value > test$p.value){
        test_final = test
        x1_final = x1
        x2_final = x2
        p_value = paste(test$p.value)
        moneda_mes_diferencia = paste(moneda)
      }
      #la tendencia central de las muestras no es la misma.
      if (test$p.value < 0.05) {
        print(paste("Moneda:", moneda,", p-valor:",test$p.value))
      }
    }
 
}

print(paste("Moneda més diferencia:",moneda_mes_diferencia," ' p-valor:",p_value))
#[1] "Moneda més diferencia: HBT  ' p-valor: 0.00221343873517787"
print(test_final)
#Wilcoxon rank sum test

#data:  x1 and x2
#W = 16, p-value = 0.002213
#alternative hypothesis: true location shift is not equal to 0

#boxplot(x1_final,x2_final, names=c("X1","X2"))


###############################################
#        Correlació índex borsatils           #
###############################################

index_borsatils = subset(x = dataset, 
                           subset = dataset$Tipus == "index_borsatil")

nom_indexs_borsatils <- distinct(index_borsatils,Nom)

index_table <- data.frame(Id=1:128)

for ( nom_index_borsatil in nom_indexs_borsatils$Nom ) {
  subset_index = subset(x = dataset, 
         subset = dataset$Nom == nom_index_borsatil)
  index_table[,nom_index_borsatil] <- as.vector(subset_index$Preu..Euros.)[1:128]
}

index_table$Id <- NULL
res = cor(index_table, use="complete.obs", method="kendall")

#veure en taula la matriu de correlació, a partir de .7 podem donar una correlació alta
View(res)

library(xlsx)
write.xlsx(res, "matriuCorrelacio.xlsx")

#representació grafica matriu correlació
corrplot(res, diag = FALSE,
         tl.pos = "td", tl.cex = 0.5, method = "color", type = "upper")

#Creem grup dataset sense els index borsatils correlacionats (1 de cada grup correlacionat) per tenir dataset mes petit

exclude_index = c("ACCIONA", "FERROVIAL", "BBVA", "SABADALL", "GAMESA", "ACERINOX",
                  "AENA", "AMADEUS", "ZARDOYA OTIS", "GRIFOLS", "BANKINTER",
                  "CELLNEX TELECOM", "MAFRE", "ENCE", "FCC", "GAS NATURAL", "IAG (IBERIA)",
                  "INM. COLONIAL", "MERLIN PROP.", "REPSOL", "SANTANDER", "ALANTRA", "APPLUS SERVICES", "EUROPAC",
                  "INYPSA", "NATRA", "AMPER", "GAM", "ALANTRA", "APPLUS SERVICES", "SOLARIA ENERGIA", "TUBACEX", 
                  "BIOSEARCH", "COEMAC", "EUROPAC","INYPSA", "PARQUES REUNIDOS", "SACYR", "VIDRALA", "SNIACE", "REALIA BUSINESS", 
                  "LIBERBANK", "PROSEGUR", "INYPSA", "NATRA", "QUABIT INMOBIL.", "SNIACE", "OHL", "MAPFRE", "ENCE", "GRUPO CATALANA OCC", 
                  "SACYR", "SNIACE", "INMO DEL SUR", "NATURHOUSE HEALTH", "CELLNEX TELECOM", "FCC", "AMPER", "GAM.", 
                  "MIQUEL i COSTAS","ELECNOR", "GLOBAL DOMINION")

clear_index_data = subset(x = index_borsatils,
                         subset = !index_borsatils$Nom %in% exclude_index)

View(clear_index_data)


###################################################
#         Regresion lineal i model              #
###################################################

octuber_HBT = subset(x = dataset, 
                 subset = dataset$Simbol == "HBT" 
                 & dataset$Data < as.Date("2017-11-01") )

novembre_HBT = subset(x = dataset, 
                  subset = dataset$Simbol == "HBT"
                  & dataset$Data > as.Date("2017-11-01") )

octuber_clear_index_data = subset(x = clear_index_data, 
                     dataset$Data < as.Date("2017-11-01") )

novembre_clear_index_data = subset(x = clear_index_data, 
                      dataset$Data > as.Date("2017-11-01")
                      )

octrubre_norm_HBT = rnorm(octuber_HBT$Preu..Euros.)

lmp <- function (modelobject) {
  if (class(modelobject) != "lm") stop("Not an object of class 'lm' ")
  f <- summary(modelobject)$fstatistic
  p <- pf(f[1],f[2],f[3],lower.tail=F)
  attributes(p) <- NULL
  return(p)
}

nom_indexs_borsatils <- distinct(index_borsatils,Nom)
millor_model <- NA
millor_p_value <- 1
for ( octuber_inedx_data_name in nom_indexs_borsatils$Nom) {
  
  index_data_octuber = subset(octuber_clear_index_data, subset = octuber_clear_index_data$Nom == octuber_inedx_data_name )
  index_octuber_norma = rnorm(index_data_octuber$Preu..Euros.)
  
  if (length(index_octuber_norma)>0) {
  regresio = lm(octrubre_norm_HBT[1:16] ~ index_octuber_norma[1:16])
  p_value = lmp(regresio)
  
  if (p_value < 0.05) {
    
    if(p_value < millor_p_value){
      millor_p_value = p_value
      millor_model = regresio
      millor_index = octuber_inedx_data_name
    }
    
    print(paste("Hi ha relació en la moneda HBT amb index borsatil:", octuber_inedx_data_name,", p-valor:",p_value))
  }
  }
  
}

#[1] "Hi ha relació en la moneda HBT amb index borsatil: FUNESPANA , p-valor: 0.0380989010567089"
#[1] "Hi ha relació en la moneda HBT amb index borsatil: GRUPO PRISA , p-valor: 0.00627180926584772"
#[1] "Hi ha relació en la moneda HBT amb index borsatil: ORYZON GENOMICS , p-valor: 0.0269072098667691"
#[1] "Hi ha relació en la moneda HBT amb index borsatil: Reig Jofre , p-valor: 0.00217669767591883"
#[1] "Hi ha relació en la moneda HBT amb index borsatil: URBAS , p-valor: 0.0122987380270188"
#[1] "Hi ha relació en la moneda HBT amb index borsatil: MONTEBALITO , p-valor: 0.0423629291066837"

#La respota a la nostra pregunta, es que si hi ha relació entre les monedes i els index borsatils del IBEX-35, en aquest entre la cryptomoneda
#HBT i diferents index borsatils.

###############################################
#        Validació del model                 #
###############################################

novembre_clear_index_data = subset(octuber_clear_index_data, subset = octuber_clear_index_data$Nom == millor_index )
novembre_clear_index_data

data_test = data.frame( HBT =  novembre_clear_index_data$Preu..Euros.[1:16])

prediccio <- predict(regresio, newdata = data_test, interval="prediction")

#         fit       lwr      upr
#1  -0.056610475 -2.438385 2.325164
#2  -0.027458649 -2.413075 2.358158
#3  -0.447689998 -3.006591 2.111211
#4  -0.156187511 -2.543174 2.230799
#5   0.122796600 -2.320443 2.566036
#6  -0.279109435 -2.711171 2.152952
#7   0.310715368 -2.287521 2.908952
#8  -0.339669498 -2.809026 2.129687
#9  -0.339905643 -2.809426 2.129615
#10  0.031059963 -2.369549 2.431669
#11 -0.238265027 -2.650708 2.174178
#12  0.004896566 -2.387814 2.397608
#13 -0.002840945 -2.393586 2.387904
#14  0.344900013 -2.290392 2.980192
#15 -0.059348490 -2.440887 2.322190
#16 -0.276839383 -2.707692 2.154013


plot(data_test$HBT,col="green",type="l")
par(new=TRUE)
plot(prediccio[,1], col="red", type="l")

#No disposem de dades suficients per poder tenir un model de qualitat, tot aixo, podem veure que hi ha una aproximació


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

#matriu de correlació dels index borsatils, els de color blau tenen molt correlacionats
corrplot(res, diag = FALSE,
         tl.pos = "td", tl.cex = 0.5, method = "color", type = "upper")

#representació del test del model on poden veure les dades de cotització de la moneda HTB  en novembre i la previció del model
plot(data_test$HBT,col="green",type="l")
par(new=TRUE)
plot(prediccio[,1], col="red", type="l")


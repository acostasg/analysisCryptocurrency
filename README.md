# Scraping

## UOC practica 2. Tipologia i cicle de vida.

Datasets per la comparació de moviments i patrons entre els principals indexs borsatils espanyols i les crypto-monedes

# Context

En aquest cas el context és detectar o preveure els diferents moviments que es produeixen per una serie factors, tant de moviment interns (compra-venda), com externs (moviments polítics, econòmics, etc...), en els principals índexs borsatils espanyols i de les crypto-monedes.

Hem seleccionat diferents fonts de dades per generar fitxers «csv», guardar diferents valors en el mateix període de temps. És important destacar que ens interessa més les tendències alcistes o baixes, que podem calcular o recuperar en aquests períodes de temps.

# Fitxers

    • Document PDF amb les respostes de les preguntes i els noms dels components del grup.
    • Fitxer amb el codi Pyhton per obtenir les dades
    • Fitxer R amb correlació d’atributs
    • Carpeta CSV amb les dades

# Estructura

```
scraping
├── pdf
│   ├── acostasg-PRACTICA_1.pdf  # Document pdf de la practica 1, components grup
│   └── acostasg-PRACTICA_2.pdf  # Document pdf de la practica 2, components grup
│
├── csv  # datasets
│   ├── cypto_currencies
│   │      └── ... # fitxers csv 
│   ├── stock_index
│   │         └── ... # directoris per data amb els csv
│   └── dataset
│        └── dataset.csv ### dataset preparat per al script R unifica els anteriors
│   
├── projects
│   ├── scraping_crypto_currencies.py # scraping url criptomoneda
│   ├── scraping_stock_indexs.py # scraping url el economista
│   └── cleanAndTransform.py # script para limpiar i unificar en un dataset
├── R
│     ├── matriu_de_correlacio_index_borsatils.xlsx #matriu de correlació dels index borsatils
│     └── script.r ### script R  i amb correlació d’atributs i model
│ 
├── README.md
├── scraping.py # fitxer python incial
├── cleanData.py ### fitxer neteja i transformació
└── setup.py 

```

# Links

Repositori github: https://github.com/acostasg/scraping

Repositori kaggle Open data: 
* https://www.kaggle.com/acostasg/cryptocurrenciesvsstockindex
* https://www.kaggle.com/acostasg/stock-index/
* https://www.kaggle.com/acostasg/crypto-currencies

# Grafics

Kernel en kaggle Open data: 
* https://www.kaggle.com/acostasg/grafic-distribucion-and-kmeans-algorim-group/output

# Autors

Albert Costas Gutierrez acostasg@uoc.edu

# Llicència

Database released under Open Database License, individual contents under Database Contents License.

## Fonts de dades
* http://www.eleconomista.es
* https://coinmarketcap.com

Les dades de borsa i crypto-moneda estan en última instància sota llicència de les webs respectivament.

## Inspiració

Hi ha un estudi anterior el qual s'insipra aquest project:

* https://arxiv.org/pdf/1410.1231v1.pdf

Tot i aixo, en aquest cas el «trading» en cryptomoneda és relativament nou, força popular per la seva formulació com a mitja digital d’intercanvi, utilitzant un protocol que garanteix la seguretat, integritat i equilibri del seu estat de compte per mitjà d’un entramat d’agents.


# Descripció

En aquest hi ha 2 datasets (els qual netejarem i transformarem en un únic dataset), però l’objectiu és poder comparar en el mateix període de temps si hi ha relació o es podreixen patrons comuns entre els moviments borsatils dels principals indexes espanyols i els moviments de les crypto-monedes.

En aquest cas el context és detectar o preveure els diferents moviments que es produeixen per una serie factors, tant de moviment interns (compra-venda), com externs (moviments polítics, econòmics, etc...), en els principals índexs borsatils espanyols i de les crypto-monedes.

Hem seleccionat diferents fonts de dades per generar fitxers «csv», guardar diferents valors en el mateix període de temps. És important destacar que ens interessa més les tendències alcistes o baixes, que podem calcular o recuperar en aquests períodes de temps, en el nou dataset un cop netejades les dades pasarem totes les monedes a Euros, ja que en la cryptomendes està en dolors, ho farem el script de neteja de python.

En aquest cas el «trading» en cryptomoneda és relativament nou, força popular per la seva formulació com a mitja digital d’intercanvi, utilitzant un protocol que garanteix la seguretat, integritat i equilibri del seu estat de compte per mitjà d’un entramat d’agents.

La comunitat podrà respondre, entre altres preguntes, a:
* Està afectant o hi ha **patrons comuns en les cotitzacions de cryptomonedes i el mercat de valors** principals del país d'Espanya?
* Els efectes o agents externs **afecten per igual** a les accions o cryptomonedes 
* Hi ha **relacions** cause efecte entre les acciones i cryptomonedes?

# Camps

* **Data**: Data de l’observació
* **Nom**: Nom de l’empresa o cryptomoneda, per identificar de quina moneda o index estem representant.
* **Símbol**: Símbol de la moneda o del index borsatil, per realitzar gràfic posteriorment d’una forma més senzilla que el nom.
* **Preu**: Valor en euros d’una acció o una cryptomoneda (transformarem la moneda a euros en el cas que estigui en dòlars amb l'última cotització (un dollar a 0,8501 euro)
* **Tipus_cotitzacio**: Valor nou que agregarem per discretitzar entre la cotització: baix (0 i 1), normal (1 i 100), alt (100 i 1000), molt_alt (>1000)
* **Tipus**: Tipus de valor: «stock» índex o cryptomoneda.

Tenim 2 grups cyptomoneda i «stock index», a més de 4 grups per tipus de preu en la cotització, posteriorment utilitzarem algorismes d’agrupació per veure similitud amb aquests tipus de valor.

# Conclucions 

   Finalment els resultats han permès de respondre al problema, les diferents regressions lineals dels index borsatils, hem eliminat alguns dels més correlacionats, envers una de les criptomoneda HBT amb més diferencia entre els mesos d’octubre i nombres, ha permès primer veure que la hipòtesi que la tendència d’algunes index borsatils ha sigut igual que la moneda en qüestió, i que posterior ens ha permès predir la tendència, amb les poques dades de la distribució normal.
   
   Per tant hem pogut veure que si els canvis produïts en algunes cryptomonedes també s’ha replicat alguns index borsatils del Ibex35 en el mes de novembre i octubre, tot i que en pesos diferents, hem vist que els models que ni tots els index borsatils ni en el mateix pes.
   
   I finalment, la tendència de creixement o decreixement tenen el mateixos valors o pesos, clarament també afecten molts altres factors, no es possible predir el valor.

# Referencies

* https://stackoverflow.com/questions/6159900/correct-way-to-write-line-to-file-in-python
* Llibre manual: Richard Lawson. Web Scraping with Python. Packt Publishing Ltd, October 2015. 174 p. ISBN 9781782164371
* https://docs.python.org/2/tutorial/inputoutput.html

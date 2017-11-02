# Scraping

## UOC practica 1. Tipologia i cicle de vida.

Datasets per la comparació de moviments i patrons entre els principals indexs borsatils espanyols i les crypto-monedes

# Context

En aquest cas el context és detectar o preveure els diferents moviments que es produeixen per una serie factors, tant de moviment interns (compra-venda), com externs (moviments polítics, econòmics, etc...), en els principals índexs borsatils espanyols i de les crypto-monedes.

Hem seleccionat diferents fonts de dades per generar fitxers «csv», guardar diferents valors en el mateix període de temps. És important destacar que ens interessa més les tendències alcistes o baixes, que podem calcular o recuperar en aquests períodes de temps.

# Fitxers

* Document PDF amb les respostes de les preguntes i els noms dels components del grup.
* Fitxer amb el codi Pyhton per obtenir les dades
* Carpeta CSV amb les dades

# Estructura

```
scraping
├── pdf
│   └── acostasg-PRACTICA_1.pdf  # Document pdf amb les respostes a les preguntes i els noms del components del grup
│ 
├── csv  # datasets
│   ├── cypto_currencies
│   │   └── ... # fitxers csv 
│   └── stock_index
│       └── ... # directoris per data amb els csv
│   
├── projects
│   ├── scraping_crypto_currencies.py # scraping url criptomoneda
│   └── scraping_stock_indexs.py # scraping url el economista
│   
├── README.md
├── scraping.py # fitxer python incial
└── setup.py 

```

# Links

Repositori github: https://github.com/acostasg/scraping

Repositori kaggle Open data: 
* https://www.kaggle.com/acostasg/stock-index/
* https://www.kaggle.com/acostasg/crypto-currencies

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

La comunitat podrà respondre, entre altres preguntes, a:

Està afectant o hi ha patrons comuns en les cotitzacions de cryptomonedes i el mercat de valors principals del país d'Espanya?
Els efectes o agents externs afecten per igual a les accions o cryptomonedes?
Hi ha relacions cause efecte entre les acciones i cryptomonedes?

# Referencies

* https://stackoverflow.com/questions/6159900/correct-way-to-write-line-to-file-in-python
* Llibre manual: Richard Lawson. Web Scraping with Python. Packt Publishing Ltd, October 2015. 174 p. ISBN 9781782164371
* https://docs.python.org/2/tutorial/inputoutput.html

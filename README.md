# Scraping

UOC practica 1. Tipologia i cicle de vida.

# Descripció

Datasets per la comparació de moviments i patrons entre els principals indexs borsatils espanyols i les crypto-monedes

# Fitxers

* Document PDF amb les respostes de les preguntes i els noms dels components del grup.
* Carpeta amb el codi Pyhton per obtenir les dades
* Fixer CSV amb les dades

# Estructura

```
scraping
├── csv
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

# Referencies

* https://stackoverflow.com/questions/6159900/correct-way-to-write-line-to-file-in-python
* Llibre manual: Richard Lawson. Web Scraping with Python. Packt Publishing Ltd, October 2015. 174 p. ISBN 9781782164371
* https://docs.python.org/2/tutorial/inputoutput.html

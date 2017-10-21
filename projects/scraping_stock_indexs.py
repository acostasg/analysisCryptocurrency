import csv
import datetime
import os

import BeautifulSoup as ScrapingModule
import urllib3 as urllib

# output paths
OUTPUT_INDEX_CSV = './csv/stock_index/'

# literals to print
LITERAL_FINISH_URL = 'Finish url '
LITERAL_INIT_SCRAPING_IN_URL = 'Init scraping in url '
LITERAL_ERROR_EMPTY_HTML = "Error empty html for "
LITERAL_INVALID_LINK = "Invalid url "
LITERAL_DOWN = 'baixada'
LITERAL_UP = 'pujada'

# verbs
GET = 'GET'

# html elements
UNDERLINE = '_'
SEPARATOR = '/'
CSV = '.csv'
IMG = 'img'
SRC = 'src'
TD = 'td'
CLASS = 'class'
TR = 'tr'
TABLE = 'table'
TBODY = 'tbody'
TABLALISTA = 'tablalista'
UP_NAME_GIF = '/imag3/fsube2.gif'

# standards
UTF8 = 'utf-8'

# urls to scraping
URLS = [
    ['IBEX-35', 'ibex_35'],
    ['mercado-continuo', 'mercat_continuo'],
    ['IGBM', 'igbm'],
    ['ECO10', 'eco10'],
    ['IBEX-DIVIDENDO', 'ibex_divident'],
]
BASE_URL = 'http://www.eleconomista.es/indice/'


class StockIndex:

    def __init__(self):
        pass

    def start_scraping(self):
        for url in URLS:
            self.scraping_url(BASE_URL + url[0], url[1])

        print('Success stock index\'s!!!')

    def scraping_url(self, url, name):
        rows = []

        http = urllib.PoolManager()

        response = http.request(GET, url)

        if response.status != 200:
            print(LITERAL_INVALID_LINK + url)
            return

        html = response.data.decode(UTF8)

        if html == "":
            print(LITERAL_ERROR_EMPTY_HTML + url)
            return

        soup = ScrapingModule.BeautifulSoup(html)

        table_list = soup.find(TABLE, attrs={CLASS: TABLALISTA}).find(TBODY)
        trs = table_list.findAll(TR)

        # first trs is titles
        trs.pop(0)

        # last trs is invalid
        trs.pop(len(trs) - 1)

        self.append_title_row(rows)

        print(LITERAL_INIT_SCRAPING_IN_URL + url)

        for tr in trs:
            row = []

            for td in tr.findAll(TD):
                self.append_text(row, td)

            rows.append(
                row
            )

        now = datetime.datetime.now()

        with open(self.get_file_name(name, now), 'w') as f_output:
            csv_output = csv.writer(f_output)
            csv_output.writerows(rows)

        print(LITERAL_FINISH_URL + url)

    def append_text(self, row, td):
        text = td.text.encode(UTF8)
        if text:
            row.append(text)
        else:
            self.get_status_name(row, td)

    def get_status_name(self, row, td):
        if td.find(IMG, attrs={SRC: UP_NAME_GIF}):
            row.append(LITERAL_UP)
        else:
            row.append(LITERAL_DOWN)

    def append_title_row(self, rows):
        rows.append(
            [
                "Nom",
                "Preu",
                "Estat",
                "Var. per cent",
                "Var. en euros",
                "Volum en euros",
                "Capitalizacio (milions euros)",
                "Per",
                "Rent./Div",
                "Hora"
            ]
        )

    def get_file_name(self, name, now):
        folder = OUTPUT_INDEX_CSV + now.day.__str__() + UNDERLINE + now.month.__str__() + UNDERLINE + now.year.__str__()
        if not os.path.exists(folder):
            os.makedirs(folder)
        return folder + SEPARATOR + name + CSV
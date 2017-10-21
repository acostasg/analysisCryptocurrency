import csv
import datetime
import os

import BeautifulSoup as bs
import urllib3 as urllib

# verbs
GET = 'GET'

# path
CSV = '.csv'
UNDERLINE = '_'
SEPARATOR = '/'
CSV_PATH = './csv/'

# standards
UTF8 = 'utf-8'

# literals to print
LITERAL_DOWN = 'baixada'
LITERAL_UP = 'pujada'
LITERAL_ERROR_URL = "Error empty html for "
LITERAL_INVALID_URL = "Invalid url "
LITERAL_FINISH_URL = 'Finish url '
LITERAL_INIT_SCRAPING_IN_URL = 'Init scraping in url '
LITERAL_CRYPTO_CURRENCIES = 'Success crypto currencies!!!'

# html elements
UP_NAME_GIF = '/imag3/fsube2.gif'
TR = 'tr'
ID = 'id'
TD = 'td'
TBODY = 'tbody'
CURRENCIES_ALL = 'currencies-all'
TABLE = 'table'

# urls to scraping
URLS = [
    ['/all/views/all/', 'crypto_currencies'],
]
BASE_URL = 'https://coinmarketcap.com'


class CryptoCurrencies:

    def __init__(self):
        pass

    def start_scraping(self):
        urllib.disable_warnings()

        for url in URLS:
            self.scraping_url(BASE_URL + url[0], url[1])

        print(LITERAL_CRYPTO_CURRENCIES)

    def scraping_url(self, url, name):
        rows = []

        http = urllib.PoolManager()

        response = http.request(GET, url)

        if response.status != 200:
            print(LITERAL_INVALID_URL + url)
            return

        html = response.data.decode(UTF8)

        if html == "":
            print(LITERAL_ERROR_URL + url)
            return

        soup = bs.BeautifulSoup(html)

        table_list = soup.find(TABLE, attrs={ID: CURRENCIES_ALL}).find(TBODY)
        trs = table_list.findAll(TR)

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
        row.append(td.text.encode(UTF8))

    def append_title_row(self, rows):
        rows.append(
            [
                "Numero",
                "Nom",
                "Simbol",
                "Cap de mercat",
                "Preu",
                "Oferta circulant",
                "Volum 24 hores",
                "% 1h",
                "% 2h",
                "% 7d"
            ]
        )

    def get_file_name(self, name, now):
        folder = CSV_PATH + name
        if not os.path.exists(folder):
            os.makedirs(folder)
        return folder + SEPARATOR + now.day.__str__() + UNDERLINE + now.month.__str__() + UNDERLINE + now.year.__str__() + UNDERLINE + name + CSV

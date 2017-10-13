import csv
import datetime
import os

import BeautifulSoup as bs
import urllib3 as urllib

UTF8 = 'utf-8'
DOWN = 'baixada'
UP = 'pujada'
UP_NAME_GIF = '/imag3/fsube2.gif'

URLS = [
    ['/all/views/all/', 'crypto_currencies'],
]
BASE_URL = 'https://coinmarketcap.com'


def start_scraping():
    urllib.disable_warnings()

    for url in URLS:
        scraping_url(BASE_URL + url[0], url[1])

    print('Success crypto currencies!!!')


def scraping_url(url, name):
    rows = []

    http = urllib.PoolManager()

    response = http.request('GET', url)

    if response.status != 200:
        print("Invalid url " + url)
        return

    html = response.data.decode(UTF8)

    if html == "":
        print("Error empty html for " + url)
        return

    soup = bs.BeautifulSoup(html)

    table_list = soup.find('table', attrs={'id': 'currencies-all'}).find('tbody')
    trs = table_list.findAll('tr')

    append_title_row(rows)

    print('Init scraping in url ' + url)

    for tr in trs:
        row = []

        for td in tr.findAll('td'):
            append_text(row, td)

        rows.append(
            row
        )

    now = datetime.datetime.now()

    with open(get_file_name(name, now), 'w') as f_output:
        csv_output = csv.writer(f_output)
        csv_output.writerows(rows)

    print('Finish url' + url)


def append_text(row, td):
    row.append(td.text.encode(UTF8))


def append_title_row(rows):
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


def get_file_name(name, now):
    dir = './output/'+ name
    if not os.path.exists(dir):
        os.makedirs(dir)
    return dir + '/' +  now.day.__str__() + '_' + now.month.__str__() + '_' + now.year.__str__() + '_' + name + '.csv'

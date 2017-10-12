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
    ['IBEX-35', 'ibex_35'],
    ['mercado-continuo', 'mercat_continuo'],
    ['IGBM', 'igbm'],
    ['ECO10', 'eco10'],
    ['IBEX-DIVIDENDO', 'ibex_divident'],
]
BASE_URL = 'http://www.eleconomista.es/indice/'


def start_scraping():
    for url in URLS:
        scraping_url(BASE_URL + url[0], url[1])


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

    table_list = soup.find('table', attrs={'class': 'tablalista'}).find('tbody')
    trs = table_list.findAll('tr')

    # first trs is titles
    trs.pop(0)

    # last trs is invalid
    trs.pop(len(trs) - 1)

    append_title_row(rows)

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


def append_text(row, td):
    text = td.text.encode(UTF8)
    if text:
        row.append(td.text.encode(UTF8))
    else:
        get_status_name(row, td)


def get_status_name(row, td):
    if td.find('img', attrs={'src': UP_NAME_GIF}):
        row.append(UP)
    else:
        row.append(DOWN)


def append_title_row(rows):
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


def get_file_name(name, now):
    dir = './output/' + now.day.__str__() + '_' + now.month.__str__() + '_' + now.year.__str__()
    if not os.path.exists(dir):
        os.makedirs(dir)
    return dir + '/' + name + '.csv'


if __name__ == "__main__":
    start_scraping()

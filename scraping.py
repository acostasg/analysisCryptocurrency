import BeautifulSoup
import requests
import re
import csv


def start_scraping():
    urls = [
        'IBEX-35',
        'mercado-continuo',
        'IGBM',
        'ECO10',
        'IBEX-DIVIDENDO',
    ]
    base = 'http://www.eleconomista.es/indice/'

    for url in urls:
        scraping_url(base + url)


def scraping_url(url):
    rows = []
    for i in range(1, 56):
        print(i)
        r = requests.get(url.format(i))
        data = r.text
        cat = BeautifulSoup(data, "html.parser")
        links = []

        for link in cat.find_all('a', href=re.compile('selectedid=')):
            links.append("http://www.elections.ca" + link.get('href'))

        for link in links:
            r = requests.get(link)
            data = r.text
            cat = BeautifulSoup(data, "html.parser")
            lspans = cat.find_all('span')
            cs = cat.find_all("table")[0].find_all("td", headers="name/1")
            elected = []

            for c in cs:
                elected.append(c.contents[0].strip())

            rows.append([
                lspans[2].contents[0],
                lspans[3].contents[0],
                lspans[5].contents[0],
                re.sub("[\n\r/]", "", cat.find("legend").contents[2]).strip(),
                re.sub("[\n\r/]", "", cat.find_all('div', class_="group")[2].contents[2]).strip().encode('latin-1'),
                len(elected),
                cs[0].contents[0].strip().encode('latin-1')
            ])

    with open('./output/bytcon.csv', 'w', newline='') as f_output:
        csv_output = csv.writer(f_output)
        csv_output.writerows(rows)


if __name__ == "__main__":
    start_scraping()

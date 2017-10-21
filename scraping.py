import projects.scraping_crypto_currencies as crypto_currencies
import projects.scraping_stock_indexs as stock_indexes


def start_scraping():

    projects_list = list()

    projects_list.append(stock_indexes.StockIndex())
    projects_list.append(crypto_currencies.CryptoCurrencies())

    for project in projects_list:
        project.start_scraping()

    print('Finish all!!!')


if __name__ == "__main__":
    start_scraping()

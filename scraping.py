import projects.scraping_crypto_currencies as crypto_currencies
import projects.scraping_stock_indexs as stock_indexes


def start_scraping():
    for project in get_projects_list():
        project.start_scraping()

    print('Finish all!!!')


def get_projects_list():
    projects_list = list()
    projects_list.append(stock_indexes.StockIndex())
    projects_list.append(crypto_currencies.CryptoCurrencies())
    return projects_list


if __name__ == "__main__":
    start_scraping()

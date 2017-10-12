import projects.scraping_crypto_currencies as cryoto_currencies
import projects.scraping_stock_indexs as stock_indexs


def start_scraping():
    stock_indexs.start_scraping()
    cryoto_currencies.start_scraping()

    print('Finish all!!!')


if __name__ == "__main__":
    start_scraping()

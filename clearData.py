import csv
import re
from datetime import datetime
from os import scandir, getcwd

OUTPUT_CSV_PATH = "./csv/dataset/dataset.csv"
FORMAT_DATA = '%d_%m_%Y'
HEADERS = ['Data', 'Tipus', 'Nom', 'Simbol', 'Preu (Euros)', 'Tipus_cotitzacio']
CRYPTO_MONEDA = 'crypto_moneda'
STOCK_INDEX = 'index_borsatil'
EURO_VALUE_FROM_DOLAR = 0.849747625
data_set = []
count_shopping = 0
crypto_csv_path = getcwd() + '/csv/crypto_currencies/'
stock_index_path = getcwd() + '/csv/stock_index/'
suffix = '.csv'
PREC = '.9f'


def get_date_from_row(csv):
    return re.search(r'\d{1,2}_\d{2}_\d{4}', csv)


def get_date_value(match):
    return datetime.strptime(match.group(), FORMAT_DATA).date()


def add_value_to_array(date, type_attribute, name, simbol, price, type_price):
    data_set.append([date, type_attribute.strip(), name.strip(), simbol.strip(), price, type_price])


def get_csv_paths(ruta):
    return [arch.name for arch in scandir(ruta) if arch.is_file() and arch.name.endswith(suffix)]


def get_dirs_name(ruta):
    return [arch.name for arch in scandir(ruta) if not arch.is_file()]


def add_header_data_set():
    data_set.append(HEADERS)


def save_data_set():
    with open(OUTPUT_CSV_PATH, "w+") as f:
        writer = csv.writer(f)
        writer.writerows(data_set)


def get_value_euros(row):
    value = clear_currency_data(row)
    if value:
        return float(value) * EURO_VALUE_FROM_DOLAR
    else:
        return 0


def clear_currency_data(row):
    return row.replace(',', '.').strip()


def process_files_crypto_currency():
    for csv_name in get_csv_paths(crypto_csv_path):
        process_file_csv(crypto_csv_path, csv_name, csv_name, add_value_to_array_crypto_currency)


def process_files_stock_index():
    for dir_name in get_dirs_name(stock_index_path):
        for csv_name in get_csv_paths(stock_index_path + dir_name):
            process_file_csv(stock_index_path + dir_name + '/', csv_name, dir_name, add_value_to_array_stock_index)


def process_file_csv(path, csv_name, data, callback):
    with open(path + csv_name, newline='') as f:
        print('Process file: ' + csv_name)
        reader = csv.reader(f)
        next(reader)
        for row in reader:
            process_row(data, row, callback)


def process_row(data, row, callback):
    match = get_date_from_row(data)
    if match:
        callback(match, row)


def add_value_to_array_crypto_currency(match, row):
    price = format(get_value_euros(row[4][1:]), PREC)
    add_value_to_array(get_date_value(match), CRYPTO_MONEDA, row[1], row[2], price, get_type_value(price))


def get_type_value(value):
    value = float(value)
    if value <= 1:
        return 'baixa'
    if 1 < value <= 100:
        return 'normal'
    if 100 < value <= 1000:
        return 'alta'
    else:
        return 'molt_alta'


def add_value_to_array_stock_index(match, row):
    price = format(float(clear_currency_data(row[1])), PREC)
    add_value_to_array(get_date_value(match), STOCK_INDEX, row[0], row[0][:3], price,  get_type_value(price))


add_header_data_set()
process_files_crypto_currency()
process_files_stock_index()
save_data_set()

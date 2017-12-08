import csv
import re
from datetime import datetime
from os import scandir, getcwd

OUPUT_CSV_PATH = "./csv/dataset/dataset.csv"
FORMAT_DATA = '%d_%m_%Y'
HEADERS = ['Data', 'Tipus', 'Nom', 'Simbol', 'Preu (Euros)']
CRYPTO_MONEDA = 'crypto_moneda'
EURO_VALUE_FROM_DOLAR = 0.849747625
data_set = []
count_shopping = 0
crypto_csv_path = getcwd() + '/csv/crypto_currencies/'


def set_date_from_row(csv):
    global data_raw, match
    match = re.search(r'\d{1,2}_\d{2}_\d{4}', csv)


def set_date_value():
    global date
    date = datetime.strptime(match.group(), FORMAT_DATA).date()


def add_value_to_array(type_attribute, name, simbol, preu):
    data_set.append([date, type_attribute.strip(), name.strip(), simbol.strip(), preu])


def ls(ruta):
    return [arch.name for arch in scandir(ruta) if arch.is_file()]


def add_header_dataset():
    data_set.append(HEADERS)


def get_value_euros():
    value = row[4][1:].replace(',', '.').strip()
    if value:
        return float(value) * EURO_VALUE_FROM_DOLAR
    else:
        return 0


def process_files():
    global f, row
    for csv_name in ls(crypto_csv_path):
        process_file_csv(csv_name)


def process_file_csv(csv_name):
    global f, row
    with open(crypto_csv_path + csv_name, newline='') as f:
        print('Process file: ' + csv_name)
        reader = csv.reader(f)
        next(reader)
        for row in reader:
            process_row(csv_name, row)


def process_row(csv_name, row):
    set_date_from_row(csv_name)
    if match:
        set_date_value()
        add_value_to_array(CRYPTO_MONEDA, row[1], row[2], get_value_euros())


def save_data_set():
    global f
    # Any results you write to the current directory are saved as output.
    with open(OUPUT_CSV_PATH, "w+") as f:
        writer = csv.writer(f)
        writer.writerows(data_set)


add_header_dataset()
process_files()
save_data_set()

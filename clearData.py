from subprocess import check_output
import csv
import re
from datetime import datetime
from os import scandir, getcwd

CRYPTO_MONEDA = 'crypto_moneda'
data_set = []
count_shopping = 0
crypto_csv_path = getcwd() + '/csv/crypto_currencies/'


def set_date_from_row(csv):
    global data_raw, match
    match = re.search(r'\d{1,2}_\d{2}_\d{4}', csv)


def set_date_value():
    global date
    date = datetime.strptime(match.group(), '%d_%m_%Y').date()


def add_value_to_array(type_attribute, name, preu):
    data_set.append([date, type_attribute.strip(), name.strip(), preu])


def ls(ruta):
    return [arch.name for arch in scandir(ruta) if arch.is_file()]


def add_header_dataset():
    data_set.append(['Data', 'Tipus', 'Nom', 'Preu (Euros)'])


add_header_dataset()

for csv_name in ls(crypto_csv_path):
    with open(crypto_csv_path + csv_name, newline='') as f:
        print('Process file: ' + csv_name)
        reader = csv.reader(f)
        next(reader)
        for row in reader:
            set_date_from_row(csv_name)
            if match:
                set_date_value()
                add_value_to_array(CRYPTO_MONEDA, row[1], row[4][1:])

# Any results you write to the current directory are saved as output.
with open("./csv/dataset/dataset.csv", "w+") as f:
    writer = csv.writer(f)
    writer.writerows(data_set)

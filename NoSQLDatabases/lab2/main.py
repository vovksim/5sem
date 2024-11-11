from MariaDB import insert_rand_data_mariadb
from MongoMaria import insert_rand_data_mongodb

sizeLength = [10000]

for length in sizeLength:
    insert_rand_data_mariadb(length)
    insert_rand_data_mongodb(length)
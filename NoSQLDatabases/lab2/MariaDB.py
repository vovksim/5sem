import time
from time import CLOCK_MONOTONIC
from utils import *

import mysql.connector


def insert_rand_data_mariadb(numberOfRecords):
    connection = mysql.connector.connect(
        user='root',
        password='7795aaim',
        charset='utf8mb4',
        database='Lab2_sql',
        collation='utf8mb4_general_ci'
    )

    cursor = connection.cursor()

    data_generator = Faker()

    SQL_INSERT_DURATION = 0

    clean_mariadb_tables(cursor)
    connection.commit()

    generated_data = gen_random_sql_data(numberOfRecords)
    insert_user_data(cursor, generated_data["userList"])
    insert_game_data(cursor, generated_data["gameList"])
    start = time.clock_gettime(time.CLOCK_MONOTONIC)
    insert_all_data_mariadb(cursor, generated_data["imageList"],
                            generated_data["guideList"], generated_data["reviewList"], generated_data["imageGuideList"],
                            generated_data["screenshotList"],
                            generated_data["userGuideList"], generated_data["userReviewList"])
    connection.commit()
    finish = time.clock_gettime(CLOCK_MONOTONIC)
    print(f"Num of records: {numberOfRecords} | MARIADB_INSERTION_DURATION:", finish - start)

    cursor.close()
    connection.close()

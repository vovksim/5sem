import time
from time import CLOCK_MONOTONIC
from utils import *

import mysql.connector

connection = mysql.connector.connect(
    user='root',
    password='7795aaim',
    charset='utf8mb4',
    database='Lab2_sql',
    collation='utf8mb4_general_ci'
)

cursor = connection.cursor()

data_generator = Faker()


def insert_rand_data_mariadb(numberOfRecords):
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
    return finish-start



def get_all_user_guides_sql():
    start = time.clock_gettime(time.CLOCK_MONOTONIC)
    cursor.execute("""SELECT 
        Guide.id AS guide_id,
        Guide.title AS guide_title,
        Guide.description AS guide_description,
        Image.image_server_path AS image_path,
        Image.created_at AS image_created_at,
        User_Guide.user_id as user_id,
        Game.title as game_title,
        Game.id as game_id
            FROM 
            Guide
            LEFT JOIN 
            Image_Guide ON Guide.id = Image_Guide.guide_id
            LEFT JOIN 
	        Image ON Image_Guide.image_id = Image.id
            JOIN
	        User_Guide ON User_Guide.guide_id = Guide.id 
            JOIN 
	        Game ON Game.id = Guide.game_id;
    """)
    results = cursor.fetchall()
    finish = time.clock_gettime(time.CLOCK_MONOTONIC)
    print("Fetched ", cursor.rowcount, "records in total.", "MARIADB | Time spent: ", finish - start)
    return finish-start



def get_specific_user_guides_sql(id_to_search):
    start = time.clock_gettime(time.CLOCK_MONOTONIC)
    cursor.execute("""SELECT 
        Guide.id AS guide_id,
        Guide.title AS guide_title,
        Guide.description AS guide_description,
        Image.image_server_path AS image_path,
        Image.created_at AS image_created_at,
        User_Guide.user_id as user_id,
        Game.title as game_title,
        Game.id as game_id
            FROM 
            Guide
            LEFT JOIN 
            Image_Guide ON Guide.id = Image_Guide.guide_id
            LEFT JOIN 
	        Image ON Image_Guide.image_id = Image.id
            JOIN
	        User_Guide ON User_Guide.guide_id = Guide.id 
            JOIN 
	        Game ON Game.id = Guide.game_id
	    WHERE User_Guide.user_id = %s;
    """, (id_to_search,))
    results = cursor.fetchall()
    finish = time.clock_gettime(time.CLOCK_MONOTONIC)
    print("Fetched ", cursor.rowcount, "records connected to guides in total.", "MARIADB | Time spent: ", finish - start)
    return finish-start


def get_all_user_reviews_sql():
    start = time.clock_gettime(time.CLOCK_MONOTONIC)
    cursor.execute("""SELECT 
        Review.id AS review_id,
        Review.title AS guide_title,
        Review.review AS guide_description,
        User_Review.user_id as user_id
            FROM 
            Review
            JOIN
	        User_Review ON User_Review.review_id = Review.id;
    """)
    results = cursor.fetchall()
    finish = time.clock_gettime(time.CLOCK_MONOTONIC)
    print("Fetched ", cursor.rowcount, "reviews in total.", "MARIADB | Time spent: ", finish - start)
    return finish-start

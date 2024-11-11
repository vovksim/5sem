import random
import string
from random import randint
import mysql.connector
from faker import Faker

data_generator = Faker()


def rand_foreign_key(counter):
    if counter == 1:
        return counter
    else:
        return randint(1, counter)


def generate_user_data(num_records):
    """Generate random data for userList."""
    userList = [
        (i, data_generator.user_name(), data_generator.date(), data_generator.email())
        for i in range(1, num_records + 1)
    ]
    return userList


def generate_game_data(num_records):
    """Generate random data for gameList."""
    gameList = [
        (i, ''.join(random.choices(string.ascii_letters, k=10)),
         data_generator.date(), round(random.uniform(1.00, 9.00), 2),
         data_generator.text(80))
        for i in range(1, num_records + 1)
    ]
    return gameList


def generate_image_data(num_records):
    """Generate random data for imageList."""
    imageList = [
        (i, data_generator.file_path() + ''.join(random.choices(string.ascii_letters, k=10)), data_generator.date())
        for i in range(1, num_records + 1)
    ]
    return imageList


def generate_guide_data(num_records):
    """Generate random data for guideList."""
    guideList = [
        (i, data_generator.text(10), data_generator.text(80), i)
        for i in range(1, num_records + 1)
    ]
    return guideList


def generate_review_data(num_records):
    """Generate random data for reviewList."""
    reviewList = [
        (i, data_generator.text(20), data_generator.text(80), randint(1, 9))
        for i in range(1, num_records + 1)
    ]
    return reviewList


def generate_image_guide_data(num_records):
    """Generate random data for imageGuideList."""
    imageGuideList = [
        (i, (i % (num_records / 4)) + 1, randint(1, 9))
        for i in range(1, int(num_records / 2) + 1)
    ]
    return imageGuideList


def generate_screenshot_data(num_records):
    """Generate random data for screenshotList."""
    screenshotList = [
        (i, i, rand_foreign_key(i), rand_foreign_key(i), data_generator.text(40))
        for i in range(int(num_records / 2) + 1, num_records + 1)
    ]
    return screenshotList


def generate_user_guide_data(num_records):
    """Generate random data for userGuideList."""
    userGuideList = [
        (rand_foreign_key(i), i)
        for i in range(1, num_records + 1)
    ]
    return userGuideList


def generate_user_review_data(num_records):
    """Generate random data for userReviewList."""
    userReviewList = [
        (i, rand_foreign_key(i), data_generator.date(), "public")
        for i in range(1, num_records + 1)
    ]
    return userReviewList


def gen_random_sql_data(num_records):
    """Initialize random data for all lists by calling each specific generator function."""
    userList = generate_user_data(num_records)
    gameList = generate_game_data(num_records)
    imageList = generate_image_data(num_records)
    guideList = generate_guide_data(num_records)
    reviewList = generate_review_data(num_records)
    imageGuideList = generate_image_guide_data(num_records)
    screenshotList = generate_screenshot_data(num_records)
    userGuideList = generate_user_guide_data(num_records)
    userReviewList = generate_user_review_data(num_records)
    return {
        "userList": userList,
        "gameList": gameList,
        "imageList": imageList,
        "guideList": guideList,
        "reviewList": reviewList,
        "imageGuideList": imageGuideList,
        "screenshotList": screenshotList,
        "userGuideList": userGuideList,
        "userReviewList": userReviewList
    }


# Function to insert data into the User table
def insert_user_data(cursor, userList):
    cursor.executemany("""
        INSERT INTO User (id, username, born, email)
        VALUES (%s, %s, %s, %s)
    """, userList)


# Function to insert data into the Game table
def insert_game_data(cursor, gameList):
    cursor.executemany("""
        INSERT INTO Game (id, title, created_at, price, description)
        VALUES (%s ,%s, %s, %s, %s)
    """, gameList)


# Function to insert data into the Image table
def insert_image_data(cursor, imageList):
    cursor.executemany("""
        INSERT INTO Image (id, image_server_path, created_at)
        VALUES (%s ,%s, %s)
    """, imageList)


# Function to insert data into the Guide table
def insert_guide_data(cursor, guideList):
    cursor.executemany("""
        INSERT INTO Guide (id, title, description, game_id)
        VALUES (%s ,%s, %s, %s)
    """, guideList)


# Function to insert data into the Review table
def insert_review_data(cursor, reviewList):
    cursor.executemany("""
        INSERT INTO Review (id, title, review, rate)
        VALUES (%s ,%s, %s, %s)
    """, reviewList)


# Function to insert data into the Image_Guide table
def insert_image_guide_data(cursor, imageGuideList):
    cursor.executemany("""
        INSERT INTO Image_Guide (image_id, guide_id, position)
        VALUES (%s ,%s, %s)
    """, imageGuideList)


# Function to insert data into the Screenshot table
def insert_screenshot_data(cursor, screenshotList):
    cursor.executemany("""
        INSERT INTO Screenshot (id, image_id, user_id, game_id, description)
        VALUES (%s ,%s ,%s, %s, %s)
    """, screenshotList)


# Function to insert data into the User_Guide table
def insert_user_guide_data(cursor, userGuideList):
    cursor.executemany("""
        INSERT INTO User_Guide (user_id, guide_id)
        VALUES (%s ,%s)
    """, userGuideList)


# Function to insert data into the User_Review table
def insert_user_review_data(cursor, userReviewList):
    cursor.executemany("""
        INSERT INTO User_Review (user_id, review_id, publish_date, view_mode)
        VALUES (%s, %s, %s, %s)
    """, userReviewList)


# Main function to call each insertion function
def insert_all_data_mariadb(cursor, imageList, guideList, reviewList, imageGuideList,
                            screenshotList,
                            userGuideList, userReviewList):
    insert_image_data(cursor, imageList)
    insert_guide_data(cursor, guideList)
    insert_review_data(cursor, reviewList)
    insert_image_guide_data(cursor, imageGuideList)
    insert_screenshot_data(cursor, screenshotList)
    insert_user_guide_data(cursor, userGuideList)
    insert_user_review_data(cursor, userReviewList)


def clean_mariadb_tables(cursor):
    cursor.execute("SHOW TABLES")
    fetchedTables = cursor.fetchall()
    tableNames = [tablename[0] for tablename in fetchedTables]
    for record in reversed(sorted(tableNames, key=len)):
        cursor.execute(f"DELETE FROM {record.replace("'", '')}")


class MariaDBCursor:
    def __init__(self, databaseName):
        connection = mysql.connector.connect(user='root',
                                             password='7795aaim',
                                             charset='utf8mb4',
                                             database=databaseName,
                                             collation='utf8mb4_general_ci')
        self.cursor = connection.cursor()


def generate_nosql_data(num_records):
    screenshotList = []
    reviewList = []
    guideList = []
    for i in range(1, num_records + 1):
        reviewList.append(
            {"type": "review", "id": i, "title": data_generator.text(20), "review:": data_generator.text(80),
             "game_id": rand_foreign_key(i), "user_id": rand_foreign_key(i)})
        if i > num_records / 2:
            screenshotList.append({"type": "screenshot", "id": i,
                                   "image": {"path": data_generator.file_path(), "created_at": data_generator.date()},
                                   "description": data_generator.text(40), "game_id": rand_foreign_key(
                    i), "user_id": rand_foreign_key(i)})
            guideList.append(
                {"type": "guide", "id": i, "title": data_generator.text(10), "description": data_generator.text(80),
                 "game_id": rand_foreign_key(
                     i), "user_id": rand_foreign_key(i)})
        else:
            image_list = []
            if i < num_records / 2 / 2:
                for j in range(int((num_records / 2) / (num_records / 2 / 2))):
                    image_list.append({"path": data_generator.file_path(), "created_at": data_generator.date()})
            if len(image_list) != 0:
                guideList.append(
                    {"type": "guide", "id": i, "title": data_generator.text(10), "description": data_generator.text(80),
                     "images": image_list, "game_id": rand_foreign_key(
                        i), "game_name": "TBD", "user_id": rand_foreign_key(i)})
            else:
                guideList.append(
                    {"type": "guide", "id": i, "title": data_generator.text(10), "description": data_generator.text(80),
                     "game_id": rand_foreign_key(i), "game_name": "TBD", "user_id": rand_foreign_key(i)})
    return {"screenshotList": screenshotList, "reviewList": reviewList, "guideList": guideList}


def insert_all_data_mongodb(collection, guideList, reviewList, screenshotList):
    collection.insert_many(guideList)
    collection.insert_many(reviewList)
    collection.insert_many(screenshotList)

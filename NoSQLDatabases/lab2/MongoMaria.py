from pymongo import MongoClient
from utils import *
import time

client = MongoClient("localhost", 27017)


def insert_rand_data_mongodb(numOfRecords):
    database = client.get_database("GameService")

    guideCollection = database.get_collection("Guide")
    reviewCollection = database.get_collection("Review")
    screenshotCollection = database.get_collection("Screenshot")

    guideCollection.delete_many({})
    reviewCollection.delete_many({})
    screenshotCollection.delete_many({})
    generated_nosql_data = generate_nosql_data(numOfRecords)
    start = time.clock_gettime(time.CLOCK_MONOTONIC)
    insert_all_data_mongodb(guideCollection, reviewCollection, screenshotCollection, generated_nosql_data["guideList"],
                            generated_nosql_data["reviewList"],
                            generated_nosql_data["screenshotList"])
    finish = time.clock_gettime(time.CLOCK_MONOTONIC)
    print(f"Num of records: {numOfRecords} | MONGODB_MARIADB_INSERTION_DURATION:", finish - start)
    return finish-start


def get_all_guides_data_mongodb():
    database = client.get_database("GameService")
    collection = database.get_collection("Guide")
    start = time.clock_gettime(time.CLOCK_MONOTONIC)
    guides = list(collection.find({}))
    finish = time.clock_gettime(time.CLOCK_MONOTONIC)
    print("Fetched ", len(guides), " guides.", "MONGODB | Time spent: ", finish - start)
    return finish-start



def get_all_reviews_data_mongodb():
    database = client.get_database("GameService")
    collection = database.get_collection("Review")
    start = time.clock_gettime(time.CLOCK_MONOTONIC)
    guides = list(collection.find({}))
    finish = time.clock_gettime(time.CLOCK_MONOTONIC)
    print("Fetched ", len(guides), " reviews.", "MONGODB | Time spent: ", finish - start)
    return finish-start



def get_all_guides_for_user_mongodb(user_id):
    database = client.get_database("GameService")
    collection = database.get_collection("Guide")
    start = time.clock_gettime(time.CLOCK_MONOTONIC)
    guides = list(collection.find({"user_id": user_id}))
    finish = time.clock_gettime(time.CLOCK_MONOTONIC)
    print("Fetched ", len(guides), " guides.", "MONGODB | Time spent: ", finish - start)
    return finish-start


from pymongo import MongoClient
import mysql.connector
from utils import *
import time


def insert_rand_data_mongodb(numOfRecords):
    client = MongoClient("localhost", 27017)

    database = client.get_database("GameService")

    collection = database.get_collection("UserContent")

    collection.delete_many({})
    generated_nosql_data = generate_nosql_data(numOfRecords)
    # print(generated_nosql_data["guideList"][0])
    start = time.clock_gettime(time.CLOCK_MONOTONIC)
    insert_all_data_mongodb(collection, generated_nosql_data["guideList"], generated_nosql_data["reviewList"],
                            generated_nosql_data["screenshotList"])
    finish = time.clock_gettime(time.CLOCK_MONOTONIC)
    print(f"Num of records: {numOfRecords} | MONGODB_MARIADB_INSERTION_DURATION:", finish - start)
    # print(generated_nosql_data["guideList"][0])

# def parse_review(reviewList, userReviewList):
#     noSQLReview = []
#     for i in range(len(reviewList)):
#         noSQLReview.append(
#             {"id": reviewList[i][0], "type": "review", "title": reviewList[i][1], "review": reviewList[i][2],
#              "rate": reviewList[i][3],
#              "user_id": userReviewList[i][0], "game_id": userReviewList[i][1], "publish_date": userReviewList[i][2],
#              "view_mode": userReviewList[i][3]})
#     return noSQLReview
#
#
# def parse_guide(guideList, userGuideList, imageList):
#     noSQLGuide = []
#     for i in range(len(guideList)):
#         if i < len(guideList) / 2:
#             if i % 2 != 0:
#                 images = [{"path": imageList[i][1], "created_at": imageList[i][2]},
#                           {"path": imageList[i + 1][1], "created_at": imageList[i + 1][2]}]
#                 noSQLGuide.append(
#                     {"id": guideList[i][0], "type": "guide", "title": guideList[i][1], "description": guideList[i][2],
#                      "game_id": guideList[i][0], "user_id": userGuideList[i][1], "images": images
#                      })
#             else:
#                 noSQLGuide.append(
#                     {"id": guideList[i][0], "type": "guide", "title": guideList[i][1], "description": guideList[i][2],
#                      "game_id": guideList[i][0], "user_id": userGuideList[i][1]
#                      })
#         else:
#             noSQLGuide.append(
#                 {"id": guideList[i][0], "type": "guide", "title": guideList[i][1], "description": guideList[i][2],
#                  "game_id": guideList[i][0], "user_id": userGuideList[i][1]
#                  })
#     return noSQLGuide
#
#
# def parse_screenshot(screenshotList, imageList):
#     noSQLScreenshot = []
#     for i in range(int(len(imageList) / 2), len(imageList)):
#         image = {"path": imageList[i][1], "created_at": imageList[i][2]}
#         noSQLScreenshot.append(
#             {"id": screenshotList[i - int(len(imageList) / 2)][0], "type": "screenshot",
#              "image_id": screenshotList[i - int(len(imageList) / 2)][1],
#              "user_id": screenshotList[i - int(len(imageList) / 2)][2],
#              "game_id": screenshotList[i - int(len(imageList) / 2)][3],
#              "image": image})
#     return noSQLScreenshot

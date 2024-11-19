from MariaDB import insert_rand_data_mariadb, get_all_user_guides_sql, get_specific_user_guides_sql, \
    get_all_user_reviews_sql
from MongoMaria import insert_rand_data_mongodb, get_all_guides_data_mongodb, get_all_guides_for_user_mongodb, \
    get_all_reviews_data_mongodb

sizeLength = [10, 100, 1000, 10000, 100000]

# Open the file in write mode so you can write data to it
with open("stats.csv", "w") as file:
    # Write the header row to the file
    file.write(
        "Size,MariaDBInsertion,MongoDBInsertion,FetchMariaDBGuides,FetchMongoDBGuides,FetchSingleUserGuidesMariaDB,FetchSingleUserGuidesMongoDB,FetchAllUserReviewsMariaDB,FetchAllUserReviewsMongoDB\n"
    )

    # Loop over each size in sizeLength and write data for each iteration
    for length in sizeLength:
        # Collect the values you want to write for this row
        row = [
            str(length),  # Size
            f"{insert_rand_data_mariadb(length):.5f}",  # MariaDB Insertion
            f"{insert_rand_data_mongodb(length):.5f}",  # MongoDB Insertion
            f"{get_all_user_guides_sql():.5f}",  # Fetch MariaDB Guides
            f"{get_all_guides_data_mongodb():.5f}",  # Fetch MongoDB Guides
            f"{get_specific_user_guides_sql(1):.5f}",  # Fetch Single User Guides MariaDB
            f"{get_all_guides_for_user_mongodb(1):.5f}",  # Fetch Single User Guides MongoDB
            f"{get_all_user_reviews_sql():.5f}",  # Fetch All User Reviews MariaDB
            f"{get_all_reviews_data_mongodb():.5f}"  # Fetch All User Reviews MongoDB
        ]

        # Join the row items with commas and add a newline at the end
        file.write(",".join(row) + "\n")

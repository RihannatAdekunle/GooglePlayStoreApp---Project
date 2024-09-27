# Google Play Store App Data Analysis

## Project Overview

This project focuses on analyzing data from the Google Play Store, one of the largest digital distribution platforms for mobile applications. With millions of apps available for download, the Play Store offers a wide range of apps across various categories such as games, productivity, education, entertainment, and more. Users can rate, review, and download apps, while developers constantly update their apps to enhance user experience.

The primary goal of this project is to clean and analyze the available data to uncover insights into user preferences, app performance, pricing, and trends. By cleaning the raw data and then applying SQL-based analytical queries, we can extract key insights regarding app ratings, installation numbers, pricing trends, and much more.

This project is divided into two components:

1. **Data Cleaning** (`GooglePlayStoreApp - Cleaning.sql`): This phase deals with the cleaning of the raw dataset to ensure that it is free from inconsistencies, missing data, and other issues that could affect the accuracy of our analysis.
   
2. **Data Analysis** (`GooglePlayStoreApp.sql`): After the data is cleaned, I perform a detailed analysis by answering a series of key questions related to app ratings, installs, pricing, and more.

## Dataset

The dataset used in this project is sourced from the [Google Play Store Apps Dataset on Kaggle](https://www.kaggle.com/datasets/lava18/google-play-store-apps/data). It contains information on over 10,000 apps available in the Play Store, including app names, categories, user ratings, the number of reviews, install counts, pricing, and required Android versions.

### Key Features of the Dataset:
- **App Name**: The name of the app.
- **Category**: The category under which the app is listed (e.g., Games, Education, Productivity).
- **Rating**: The average user rating for the app (out of 5).
- **Reviews**: The total number of user reviews for the app.
- **Installs**: The number of times the app has been installed.
- **Size**: The size of the app, in MB or KB.
- **Price**: The price of the app (free apps are listed as '0').
- **Last Updated**: The date the app was last updated.
- **Android Version Required**: The minimum Android version required to install the app.

## Project Files

- **`GooglePlayStoreApp.sql`**: Contains SQL queries that answer analytical questions about the Google Play Store apps.
- **`GooglePlayStoreApp - Cleaning.sql`**: Contains SQL scripts for cleaning the raw data before analysis.

## Data Cleaning Process

Before any analysis can be done, it's essential to clean the dataset to correct inconsistencies and handle missing or incorrect data entries. Here’s a breakdown of the key cleaning steps that were applied:

1. **Handling Missing Values:**
   - Missing values in the `Rating` column were replaced with the average rating.
   - Missing values in the `Reviews` column were replaced with `0` to account for apps with no reviews.

2. **Data Type Conversion:**
   - The `Size` column was converted from a text field (containing units like MB and KB) to a numeric `float` data type for proper analysis.
   - Non-numeric characters (e.g., `+`, `,`) were removed from the `Installs` column, which was then converted to an integer.

3. **Standardization:**
   - The `Price` column was cleaned by removing the `$` symbol and standardizing prices for free apps to `0`.
   - The `Android Ver` column was cleaned by removing unnecessary text and standardizing the version numbers.

4. **Duplicate Removal:**
   - Duplicate app entries were identified and removed based on `App`, `Category`, and `Rating`.

5. **Date Formatting:**
   - The `Last Updated` column was converted into a proper `DATE` format to allow time-based analysis.

6. **Additional Standardization:**
   - Leading and trailing spaces were removed from various columns (`Size`, `Installs`, etc.) to ensure consistency in the data.

## Analytical Questions

Once the data was cleaned, several analytical questions were addressed to uncover trends and patterns in the Play Store. These questions include:

1. **Top-Rated Categories**: Identify the top 5 categories with the highest average app ratings to determine which types of apps are most liked by users.

2. **Popular Apps Across Genres**: Analyze which apps have the highest number of installs in different genres to understand the popularity of certain apps within specific genres.

3. **Common Android Version**: Discover the most common Android version required to find out the typical compatibility range of apps.

4. **Top Apps by Installs in Each Category**: Highlight the leading apps in each category by install count, revealing market leaders and user preferences.

5. **Above-Average Rated Apps by Genre**: Identify apps with ratings higher than the average within their genre to understand which apps are outperforming their peers.

6. **Percentage of Free Apps**: Find the percentage of free apps in each category to reveal pricing strategies across different categories.

7. **Most Expensive Paid Apps**: Discover the most expensive paid apps to understand how developers price premium content.

8. **Average Price and Paid Apps Distribution**: Analyze the average price of paid apps and their distribution across categories to identify where users are willing to spend money.

9. **Rating Distribution**: Examine rating distribution across categories to understand how users rate apps in different categories and identify opportunities for improvement.

10. **Growth Trends by Genre**: Investigate growth trends in installs for the top genres over time to predict future trends and identify growth opportunities.

11. **Improvement in Ratings After Updates**: Examine which categories have seen the most improvement in ratings after updates to assess the effectiveness of app updates.


## Conclusion

The Google Play Store hosts millions of apps across a wide range of categories, and analyzing this data helps us gain insights into app trends, user preferences, and the overall app market. This project demonstrates how data cleaning and analysis can provide actionable insights, allowing us to explore user behavior, app performance, and growth trends on the Play Store.

By following a structured approach to cleaning and analyzing the data, we can derive valuable information that can be useful for app developers, marketers, and business analysts alike.

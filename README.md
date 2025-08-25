# Nashville Housing Data Cleaning (SQL Project)


## Project Objective

The objective of this project is to clean and transform the Nashville Housing dataset using SQL.
The cleaning process ensures the dataset is accurate, consistent, and ready for analysis by:

•	Standardizing date formats

•	Handling missing property addresses

•	Splitting composite fields (address, city, state)

•	Normalizing categorical values

•	Removing duplicates

•	Dropping unnecessary columns


## Dataset

The dataset used in this project comes from Nashville Housing Data.
👉 <a href="https://www.kaggle.com/datasets/tmthyjames/nashville-housing-data">Housing Data – Download Link</a>


## Questions (KPIs)

This project was designed to address the following key data quality issues:
•	Are all SaleDate entries in a consistent format?

•	How can missing PropertyAddress values be recovered?

•	Can property and owner addresses be split into structured fields?

•	Are categorical fields like SoldAsVacant standardized?

•	Are there duplicate property records, and how can they be removed?

•	Which columns are unnecessary for analysis and can be dropped?


## Process

•	Data Inspection: Queried the raw dataset to identify inconsistencies and missing values

•	Date Standardization: Converted SaleDate into a proper DATE format

•	Address Cleaning: Filled missing addresses using ParcelID and split fields into Street, City, and State

•	Value Normalization: Standardized SoldAsVacant values from Y/N → Yes/No

•	Duplicate Removal: Used ROW_NUMBER() with PARTITION BY to detect and delete duplicates

•	Column Cleanup: Dropped redundant columns (OwnerAddress, PropertyAddress, TaxDistrict, etc.)

## Project Insights

•	Dates are now in a consistent and queryable format

•	Missing property addresses were successfully recovered from matching ParcelIDs

•	Property and Owner addresses are now split into structured fields (Street, City, State)

•	Categorical fields are standardized for easier reporting

•	Duplicate property records were identified and removed

•	Final dataset is simplified and analysis-ready

## Final Conclusion

The Nashville Housing SQL project demonstrates practical data cleaning and transformation techniques.
It equips analysts with a structured dataset that is:

•	Ready for visualization in Power BI, Tableau, or Python

•	Reliable for further real estate trend analysis

•	Cleaned using efficient SQL functions and best practices

## Tools & Technologies

•	SQL Server – Data cleaning and transformation

•	T-SQL Functions – ROW_NUMBER(), SUBSTRING, CHARINDEX, PARSENAME, ISNULL

•	Schema Management – ALTER TABLE, DROP COLUMN

## Author: Patrick Ugwu

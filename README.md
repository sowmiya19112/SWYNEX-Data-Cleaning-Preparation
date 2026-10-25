Data Cleaning and Preparation using MySQL
# SWYNEX Data Cleaning & Preparation

## Project Overview
This project focuses on cleaning and validating a student performance dataset using MySQL as part of the SWYNEX internship task.

## Tools Used
- MySQL
- MySQL Workbench
- GitHub

## Dataset
Student Performance Factors dataset containing 6,607 records and 20 columns.

## Data Cleaning Steps
1. Created a separate working table named `cleaned_student_data` to preserve the original data.
2. Identified blank values in `Teacher_Quality`, `Parental_Education_Level`, and `Distance_from_Home`.
3. Replaced 235 blank values across these columns with `Unknown`.
4. Checked for exact duplicate records across all 20 columns; no duplicate groups were found.
5. Validated numeric columns using minimum and maximum values.
6. Verified that the cleaned table retained 6,607 rows.
7. Checked all 20 columns for NULL and empty values; the final validation returned zero missing values.
8.  Identified one Exam_Score value above 100 in the raw dataset.
9.  Corrected the value from 101 to 100 in the cleaned dataset.
10.  Verified that no Exam_Score values exceed 100 after cleaning.

## Files
- `code_file.sql` — SQL queries used for cleaning and validation.
- `cleaned_student_data.csv` — cleaned dataset exported from MySQL Workbench.

## Validation Note
An `Exam_Score` value of 101 was identified during range validation. It requires verification against the dataset's documented score range before any correction is made.

## Key Learning
Practised SQL-based data cleaning, missing-value handling, duplicate checks, numeric validation, and data quality verification.

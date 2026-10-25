USE swynex_data_cleaning;
SHOW TABLES;
SELECT * FROM raw_student_data LIMIT 10;
-- 1. Total records count
SELECT COUNT(*) AS total_records FROM raw_student_data;
-- 2. Column names and data types
DESCRIBE raw_student_data;
-- 3. First 10 rows
SELECT *FROM raw_student_data LIMIT 10;
SELECT
    SUM(Hours_Studied IS NULL) AS missing_hours,
    SUM(Attendance IS NULL) AS missing_attendance,
    SUM(Parental_Involvement IS NULL) AS missing_parental,
    SUM(Access_to_Resources IS NULL) AS missing_resources,
    SUM(Extracurricular_Activities IS NULL) AS missing_activities,
    SUM(Sleep_Hours IS NULL) AS missing_sleep,
    SUM(Previous_Scores IS NULL) AS missing_previous_scores
FROM raw_student_data;
SELECT COUNT(*) AS total_rows
FROM raw_student_data;
SELECT COUNT(*) AS duplicate_groups
FROM (
    SELECT
        Access_to_Resources,
        Attendance,
        Distance_from_Home,
        Exam_Score,
        Extracurricular_Activities,
        Family_Income,
        Gender,
        Hours_Studied,
        Internet_Access,
        Learning_Disabilities,
        Motivation_Level,
        Parental_Education_Level,
        Parental_Involvement,
        Peer_Influence,
        Physical_Activity,
        Previous_Scores,
        School_Type,
        Sleep_Hours,
        Teacher_Quality,
        Tutoring_Sessions
    FROM raw_student_data
    GROUP BY
        Access_to_Resources,
        Attendance,
        Distance_from_Home,
        Exam_Score,
        Extracurricular_Activities,
        Family_Income,
        Gender,
        Hours_Studied,
        Internet_Access,
        Learning_Disabilities,
        Motivation_Level,
        Parental_Education_Level,
        Parental_Involvement,
        Peer_Influence,
        Physical_Activity,
        Previous_Scores,
        School_Type,
        Sleep_Hours,
        Teacher_Quality,
        Tutoring_Sessions
    HAVING COUNT(*) > 1
) AS duplicate_records;
SELECT DISTINCT Gender FROM raw_student_data;
SELECT DISTINCT Parental_Involvement FROM raw_student_data;
SELECT DISTINCT Access_to_Resources FROM raw_student_data;
SELECT DISTINCT Teacher_Quality FROM raw_student_data;
SELECT DISTINCT Distance_from_Home FROM raw_student_data;
SELECT 'Gender' AS column_name, Gender AS value,COUNT(*) AS total
FROM raw_student_data GROUP BY Gender
UNION ALL
SELECT 'Parental_Involvement', Parental_Involvement,COUNT(*) FROM raw_student_data GROUP BY Parental_Involvement
UNION ALL
SELECT 'Access_to_Resources', Access_to_Resources, COUNT(*) FROM raw_student_data
GROUP BY Access_to_Resources
UNION ALL
SELECT 'Teacher_Quality', Teacher_Quality, COUNT(*)
FROM raw_student_data GROUP BY Teacher_Quality;
SELECT SUM(Teacher_Quality IS NULL) AS null_values, SUM(TRIM(Teacher_Quality) = '') AS empty_values
FROM raw_student_data;
USE swynex_data_cleaning;
CREATE TABLE cleaned_student_data AS
SELECT * FROM raw_student_data;
USE swynex_data_cleaning;
UPDATE cleaned_student_data
SET Teacher_Quality = 'Unknown'
WHERE TRIM(Teacher_Quality) = '';
SELECT Teacher_Quality, COUNT(*) AS total
FROM cleaned_student_data
GROUP BY Teacher_Quality;
SELECT
    SUM(Access_to_Resources IS NULL OR TRIM(Access_to_Resources) = '') AS missing_resources,
    SUM(Attendance IS NULL) AS missing_attendance,
    SUM(Distance_from_Home IS NULL OR TRIM(Distance_from_Home) = '') AS missing_distance,
    SUM(Exam_Score IS NULL) AS missing_exam_score,
    SUM(Extracurricular_Activities IS NULL OR TRIM(Extracurricular_Activities) = '') AS missing_activities,
    SUM(Family_Income IS NULL OR TRIM(Family_Income) = '') AS missing_income,
    SUM(Gender IS NULL OR TRIM(Gender) = '') AS missing_gender,
    SUM(Hours_Studied IS NULL) AS missing_hours,
    SUM(Internet_Access IS NULL OR TRIM(Internet_Access) = '') AS missing_internet,
    SUM(Learning_Disabilities IS NULL OR TRIM(Learning_Disabilities) = '') AS missing_disabilities,
    SUM(Motivation_Level IS NULL OR TRIM(Motivation_Level) = '') AS missing_motivation,
    SUM(Parental_Education_Level IS NULL OR TRIM(Parental_Education_Level) = '') AS missing_parent_education,
    SUM(Parental_Involvement IS NULL OR TRIM(Parental_Involvement) = '') AS missing_parental,
    SUM(Peer_Influence IS NULL OR TRIM(Peer_Influence) = '') AS missing_peer,
    SUM(Physical_Activity IS NULL) AS missing_activity_hours,
    SUM(Previous_Scores IS NULL) AS missing_previous_scores,
    SUM(School_Type IS NULL OR TRIM(School_Type) = '') AS missing_school_type,
    SUM(Sleep_Hours IS NULL) AS missing_sleep,
    SUM(Teacher_Quality IS NULL OR TRIM(Teacher_Quality) = '') AS missing_teacher_quality,
    SUM(Tutoring_Sessions IS NULL) AS missing_tutoring
FROM cleaned_student_data;
SELECT Distance_from_Home, COUNT(*) AS total
FROM cleaned_student_data
GROUP BY Distance_from_Home;
SELECT Parental_Education_Level, COUNT(*) AS total
FROM cleaned_student_data
GROUP BY Parental_Education_Level;
UPDATE cleaned_student_data
SET Parental_Education_Level = 'Unknown'
WHERE TRIM(Parental_Education_Level) = '';
SELECT 'Distance_from_Home' AS column_name, Distance_from_Home AS cleaned_value, COUNT(*) AS total
FROM cleaned_student_data
GROUP BY Distance_from_Home
UNION ALL
SELECT 'Parental_Education_Level', Parental_Education_Level, COUNT(*)
FROM cleaned_student_data
GROUP BY Parental_Education_Level;
UPDATE cleaned_student_data
SET Distance_from_Home = 'Unknown'
WHERE Distance_from_Home IS NOT NULL
  AND TRIM(Distance_from_Home) = '';
SELECT Distance_from_Home, COUNT(*) AS total
FROM cleaned_student_data
GROUP BY Distance_from_Home;
SELECT
    MIN(Attendance) AS min_attendance,
    MAX(Attendance) AS max_attendance,
    MIN(Exam_Score) AS min_exam_score,
    MAX(Exam_Score) AS max_exam_score,
    MIN(Hours_Studied) AS min_hours_studied,
    MAX(Hours_Studied) AS max_hours_studied,
    MIN(Sleep_Hours) AS min_sleep_hours,
    MAX(Sleep_Hours) AS max_sleep_hours,
    MIN(Previous_Scores) AS min_previous_scores,
    MAX(Previous_Scores) AS max_previous_scores,
    MIN(Physical_Activity) AS min_physical_activity,
    MAX(Physical_Activity) AS max_physical_activity,
    MIN(Tutoring_Sessions) AS min_tutoring_sessions,
    MAX(Tutoring_Sessions) AS max_tutoring_sessions
FROM cleaned_student_data;
SELECT * FROM cleaned_student_data
WHERE Exam_Score > 100;
SELECT Exam_Score, COUNT(*) AS total_students
FROM cleaned_student_data
GROUP BY Exam_Score
ORDER BY Exam_Score DESC
LIMIT 10;
SELECT COUNT(*) AS total_rows
FROM cleaned_student_data;
SELECT
    SUM(Access_to_Resources IS NULL OR TRIM(Access_to_Resources) = '') AS missing_access_resources,
    SUM(Attendance IS NULL) AS missing_attendance,
    SUM(Distance_from_Home IS NULL OR TRIM(Distance_from_Home) = '') AS missing_distance,
    SUM(Exam_Score IS NULL) AS missing_exam_score,
    SUM(Extracurricular_Activities IS NULL OR TRIM(Extracurricular_Activities) = '') AS missing_extracurricular,
    SUM(Family_Income IS NULL OR TRIM(Family_Income) = '') AS missing_family_income,
    SUM(Gender IS NULL OR TRIM(Gender) = '') AS missing_gender,
    SUM(Hours_Studied IS NULL) AS missing_hours_studied,
    SUM(Internet_Access IS NULL OR TRIM(Internet_Access) = '') AS missing_internet,
    SUM(Learning_Disabilities IS NULL OR TRIM(Learning_Disabilities) = '') AS missing_learning_disabilities,
    SUM(Motivation_Level IS NULL OR TRIM(Motivation_Level) = '') AS missing_motivation,
    SUM(Parental_Education_Level IS NULL OR TRIM(Parental_Education_Level) = '') AS missing_parental_education,
    SUM(Parental_Involvement IS NULL OR TRIM(Parental_Involvement) = '') AS missing_parental_involvement,
    SUM(Peer_Influence IS NULL OR TRIM(Peer_Influence) = '') AS missing_peer_influence,
    SUM(Physical_Activity IS NULL) AS missing_physical_activity,
    SUM(Previous_Scores IS NULL) AS missing_previous_scores,
    SUM(School_Type IS NULL OR TRIM(School_Type) = '') AS missing_school_type,
    SUM(Sleep_Hours IS NULL) AS missing_sleep_hours,
    SUM(Teacher_Quality IS NULL OR TRIM(Teacher_Quality) = '') AS missing_teacher_quality,
    SUM(Tutoring_Sessions IS NULL) AS missing_tutoring_sessions
FROM cleaned_student_data;
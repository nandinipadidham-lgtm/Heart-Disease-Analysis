CREATE DATABASE heart_disease_db;
USE heart_disease_db;
SELECT COUNT(*) FROM HD;
-- 1. Overall rate
SELECT 
    COUNT(*) AS total_records,
    SUM(CASE WHEN HeartDisease='Yes' THEN 1 ELSE 0 END) AS heart_disease_cases,
    ROUND(SUM(CASE WHEN HeartDisease='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*), 2) AS rate_pct
FROM HD;

-- 2. By sex
SELECT Sex,
       COUNT(*) AS total,
       ROUND(SUM(CASE WHEN HeartDisease='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*), 2) AS rate_pct
FROM HD
GROUP BY Sex;

-- By race
SELECT Race,
       COUNT(*) AS total,
       ROUND(SUM(CASE WHEN HeartDisease='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*), 2) AS rate_pct
FROM HD
GROUP BY Race
ORDER BY rate_pct DESC;

-- Age x Sex
SELECT AgeCategory, Sex,
       ROUND(SUM(CASE WHEN HeartDisease='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*), 2) AS rate_pct
FROM HD
GROUP BY AgeCategory, Sex
ORDER BY AgeCategory, Sex;

-- 3. Stroke
SELECT Stroke,
       COUNT(*) AS total,
       ROUND(SUM(CASE WHEN HeartDisease='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*), 2) AS rate_pct
FROM HD
GROUP BY Stroke;

-- Diabetic
SELECT Diabetic,
       COUNT(*) AS total,
       ROUND(SUM(CASE WHEN HeartDisease='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*), 2) AS rate_pct
FROM HD
GROUP BY Diabetic
ORDER BY rate_pct DESC;

-- Kidney disease
SELECT KidneyDisease,
       COUNT(*) AS total,
       ROUND(SUM(CASE WHEN HeartDisease='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*), 2) AS rate_pct
FROM HD
GROUP BY KidneyDisease;

-- DiffWalking
SELECT DiffWalking,
       COUNT(*) AS total,
       ROUND(SUM(CASE WHEN HeartDisease='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*), 2) AS rate_pct
FROM HD
GROUP BY DiffWalking;

-- 4. Smoking vs Alcohol
SELECT Smoking, AlcoholDrinking,
       COUNT(*) AS total,
       ROUND(SUM(CASE WHEN HeartDisease='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*), 2) AS rate_pct
FROM HD
GROUP BY Smoking, AlcoholDrinking
ORDER BY rate_pct DESC;

-- Physical activity
SELECT PhysicalActivity,
       COUNT(*) AS total,
       ROUND(SUM(CASE WHEN HeartDisease='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*), 2) AS rate_pct
FROM HD
GROUP BY PhysicalActivity;

-- Sleep buckets
SELECT 
    CASE 
        WHEN SleepTime < 6 THEN 'Under 6h'
        WHEN SleepTime BETWEEN 6 AND 8 THEN '6-8h'
        ELSE 'Over 8h'
    END AS sleep_bucket,
    COUNT(*) AS total,
    ROUND(SUM(CASE WHEN HeartDisease='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*), 2) AS rate_pct
FROM HD
GROUP BY sleep_bucket
ORDER BY rate_pct DESC;

-- 5. BMI category
SELECT 
    CASE 
        WHEN BMI < 18.5 THEN 'Underweight'
        WHEN BMI < 25 THEN 'Normal'
        WHEN BMI < 30 THEN 'Overweight'
        ELSE 'Obese'
    END AS bmi_category,
    COUNT(*) AS total,
    ROUND(SUM(CASE WHEN HeartDisease='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*), 2) AS rate_pct
FROM HD
GROUP BY bmi_category
ORDER BY rate_pct DESC;

-- Averages by HeartDisease status
SELECT HeartDisease,
       ROUND(AVG(BMI), 2) AS avg_bmi,
       ROUND(AVG(PhysicalHealth), 2) AS avg_bad_physical_days,
       ROUND(AVG(MentalHealth), 2) AS avg_bad_mental_days,
       ROUND(AVG(SleepTime), 2) AS avg_sleep
FROM HD
GROUP BY HeartDisease;

-- 6. GenHealth
SELECT GenHealth,
       COUNT(*) AS total,
       ROUND(SUM(CASE WHEN HeartDisease='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*), 2) AS rate_pct
FROM HD
GROUP BY GenHealth
ORDER BY rate_pct DESC;

-- 7. Highest-risk combined profile
SELECT AgeCategory, GenHealth, Diabetic,
       COUNT(*) AS total,
       ROUND(SUM(CASE WHEN HeartDisease='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*), 2) AS rate_pct
FROM HD
GROUP BY AgeCategory, GenHealth, Diabetic
HAVING total >= 20
ORDER BY rate_pct DESC
LIMIT 10;
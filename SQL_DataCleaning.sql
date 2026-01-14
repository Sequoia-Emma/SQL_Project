Select * 
from Stress_Level



--DATA CLEANING
--TRIM all columns first

Update Stress_Level
Set mood = TRIM(mood) /*(done for all columns except Int, date and time columns)*/


--Remove dUPLICATES
With Duplicate_Table AS (
Select *,
ROW_NUMBER() over (Partition by id, first_name, last_name, test_DATE, test_time
					Order by id) Duplicate_Count
From Stress_Level
)
Delete 
from Duplicate_Table
Where Duplicate_Count >1

--Removing extra duplicates
With Duplicate_Table AS (
Select *,
ROW_NUMBER() over (Partition by id 
					Order by id) Duplicate_Count
From Stress_Level
)
Select * 
from Duplicate_Table
Where Duplicate_Count >1


With New_Clean AS(
Select * 
from Stress_Level
where first_name = 'grissel' --query done for 6 extra columns with duplicate records
)
delete  
from New_Clean
where test_date is null

--HANDLING MISSING DATA
Select * 
from Stress_Level
where stress_level_score is null

--Handle null in stress source
Update Stress_Level
set stress_source = 'Others'
Where stress_source is null

--Handle null in stress level score
Select AVG(stress_level_score) as avg_level
from Stress_Level

Update Stress_Level
Set stress_level_score = (Select AVG(stress_level_score) as avg_level
							from Stress_Level)
where stress_level_score is null

--Standardize Gender Column
Select Gender
from Stress_Level
Group by gender

Update Stress_Level
Set gender = Case
				when gender = 'F' then 'Female'
				else 'Male'
				END

--Create Age column
Alter table stress_Level
Add Age int

Update Stress_Level
Set Age = DATEDIFF(Year, dob, GETDATE())

Select mAX(age)
from Stress_Level




Select stress_source 
from Stress_Level
group by stress_source

--Classify and Group data
--Classify stress duration
Alter table stress_level
Add Stress_Class varchar(50)

Update Stress_Level
set stress_class = CASE
        WHEN stress_duration BETWEEN 1 AND 30 THEN 'Acute Stress'
        WHEN stress_duration BETWEEN 31 AND 90 THEN 'Subacute Stress'
        WHEN stress_duration > 90 THEN 'Chronic Stress'
    END 

	--classify heart rate
Alter table stress_level
add HeartRate_Class Varchar (50)

Update Stress_Level
Set HeartRate_Class =  CASE
        WHEN heart_rate BETWEEN 60 AND 100 THEN 'Normal'
        WHEN heart_rate BETWEEN 101 AND 110 THEN 'Mild Tachycardia'
        WHEN heart_rate BETWEEN 111 AND 120 THEN 'Tachycardia'
        ELSE 'Bradycardia' -- In case there are values below 60
    END

--classify cortisol level
Alter Table stress_Level
add Cortisol_Class Varchar (50)

Update Stress_Level
set Cortisol_Class =  CASE
		WHEN cortisol_level < 10 THEN 'Low'
        WHEN cortisol_level BETWEEN 10 AND 20 THEN 'Normal'
        WHEN cortisol_level BETWEEN 21 AND 25 THEN 'Elevated'
    END

--Classify stress level score
Alter Table Stress_Level
Add Stress_Level_Class Varchar(50)


Update Stress_Level
set stress_level_score = ROUND(Stress_level_score, 2)

Update Stress_Level
set stress_level_Class =    CASE
        WHEN stress_level_score BETWEEN 0.65 AND 1.00 THEN 'Low Stress'
        WHEN stress_level_score BETWEEN 1.01 AND 1.50 THEN 'Moderate Stress'
        WHEN stress_level_score BETWEEN 1.51 AND 2.00 THEN 'High Stress'
        WHEN stress_level_score BETWEEN 2.01 AND 2.30 THEN 'Very High Stress'
    END

--Create Age Group
Alter Table Stress_Level
Add Age_Group Varchar (50)

Update Stress_Level
set Age_Group =     CASE
        WHEN age BETWEEN 18 AND 34 THEN 'Young Adult'
        WHEN age BETWEEN 35 AND 55 THEN 'Middle-Aged Adult'
        WHEN age BETWEEN 56 AND 70 THEN 'Older Adult'
        WHEN age BETWEEN 71 AND 80 THEN 'Elderly'
    END

--Standardize text in different columns
-- Physical symptoms
Update Stress_Level
set physical_symptoms = case
				When physical_symptoms = 'Arthritis Pain' then 'Arthritis'
				When physical_symptoms = 'Stomach Age' then 'Stomach Ache'
				Else physical_symptoms
	END
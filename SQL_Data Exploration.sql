--KPIS
--TOTAL INDIVIDUALS
SELECT COUNT(*) [Total_individuals]
FROM Stress_Level

--AVERAGE AGE
SELECT AVG(Age) [Average_Age]
FROM Stress_Level

--AVERAGE STRESS LEVEL SCORE
SELECT Round(AVG(stress_level_score), 2)[Average_Stresslevel_score]
FROM Stress_Level

--AVERAGE HEART RATE
SELECT avg(heart_rate) [Average heart rate]
FROM Stress_Level

--AVERAGE CORTISOL LEVEL
SELECT AVG(cortisol_level)[avg cortisol level]
FROM Stress_Level

--FURTHER ANALYSIS
--determine the top 5 stress sources
Select top 5 stress_source, count(ID)
from Stress_Level
group by stress_source
Order by count(ID) desc

--know what are the top physical symptoms
Select top 5 physical_symptoms, count(ID)
from Stress_Level
group by physical_symptoms
Order by count(ID) desc

----know what are the top EMOTIONAL symptoms
Select top 5 emotional_symptoms, count(ID)
from Stress_Level
group by emotional_symptoms
Order by count(ID) desc

--distribution by stress class
Select Stress_Class, count(stress_class)
from Stress_Level
Group by Stress_Class

--Distribution by stress level class
Select Stress_Level_Class, count(stress_level_class)
from Stress_Level
Group by Stress_Level_Class

--Understand heart rate class in reletion to stress level scores
Select HeartRate_Class, Round(AVG(stress_level_score), 2) [Avg Stress Score]
from Stress_Level
group by HeartRate_Class

--Coping Mechanisms effectiveness
Select coping_mechanism, Avg(stress_duration) [Avg Stress Duration]
from Stress_Level
group by coping_mechanism
Order by [Avg Stress Duration]

--Stress Class and Heart rate Analysis
Select Stress_Class, HeartRate_Class, count(HeartRate_Class)
from Stress_Level
Group by Stress_Class, HeartRate_Class

--mood by stress level score analysis
Select mood, avg(stress_level_score) [Avg Stress Score]
from Stress_Level
Group by mood

--
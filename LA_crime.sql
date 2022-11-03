CREATE DATABASE IF NOT EXISTS LA_Crime;
USE LA_Crime; 
CREATE TABLE IF NOT EXISTS Crime (
Crime_ID INT PRIMARY KEY NOT NULL,
Time_Occurred INT,
Area_Name VARCHAR(250),
Crime_Code_Description VARCHAR(250),
Premise_Description VARCHAR(250),
Weapon_Description VARCHAR(250)
);
CREATE TABLE IF NOT EXISTS Victim (
Victim_Number INT PRIMARY KEY NOT NULL,
Victim_Age INT,
Victim_Sex VARCHAR(250),
Crime_ID INT,
FOREIGN KEY (Crime_ID) 
REFERENCES Crime(Crime_ID)
);

#select 10 records from crime table
select * from Crime
limit 10;

#Which crimes (ID and Crime_Code_Description) have happened in the area of Mission?  
select Crime_ID, Crime_Code_Description, Area_Name
from  Crime
where Area_Name like 'Mission%';
 
#How many of the victims are female and 50 years old or older. Show the count column as Count_Female_Over_50
select Victim_Age, Victim_Sex, count(Victim_Number) as Count_Female_Over_50
from Victim
where Victim_Age >50 and Victim_Sex= 'F';

#Who is the oldest victim (victim number and sex) and what is the crime’s code description for that victim?  
select Victim_Number, Victim_Sex, Victim_Age, Crime_Code_Description
from Victim v
inner join Crime c
	on v.Crime_ID= c.Crime_ID
where Victim_Age= (select max(Victim_Age)from Victim);
    
#In which areas less than 10 crimes have occurred? 
select Area_Name, count(Crime_ID) as Crime_Count
from Crime
group by Area_Name
having Crime_Count <10;

#How many of each type of crime (code description) occur in the area of N Hollywood? 
select Crime_Code_Description, count(Crime_Code_Description) as count_crime_type, Area_Name
from Crime
where Area_Name= 'N Hollywood'
group by Crime_Code_Description;

# Who are the victims (victim number, age, and sex) of the crime ID of 233? 
select Victim_Number, Victim_Sex, Victim_Age, Crime_ID
from Victim
where Crime_ID = 233;

# What are the top 3 weapons used in the crimes? 
select Weapon_Description, count(Crime_ID) as Crime_count
from Crime
group by Weapon_Description
order by Crime_count desc
limit 3;

#What types of crime did happen in the area of West Valley? 
select Crime_Code_Description, Area_Name
from Crime
where  Area_Name= 'West Valley'
group by Crime_Code_Description;

#What are the top 10 premises where the highest number of crimes happen? Show the results in the desc order and show the count of crimes as Count_Crime. 
select Premise_Description, count(Crime_ID) as Count_Crime
from Crime
group by Premise_Description 
order by Count_Crime desc;
--1) Write a SQL query to find the total no of Olympic Games held as per the dataset.
select count(*) as total_Olympics_Games from (select distinct Year, Season from athlete_events) as a


--2) Write a SQL query to list down all the Olympic Games held so far,display the year, season and the city.
select distinct Year, Season, City from athlete_events
group by Year, Season, City, Games
order by Year


--3) SQL query to fetch total no of countries participated in each olympic games.
select Games, count(distinct (Team)) as Number_of_Countries from athlete_events
group by Games
order by Games

--4) a.	Write a SQL query to return the Olympic Games which had the highest participating countries and the lowest participating countries.
with cte_low as (
select top 1 Year, Season, count(distinct(Team)) as nation_cnt from athlete_events
group by Year, Season
order by 3), 

cte_high as (
select top 1 Year, Season, count(distinct(Team)) as nation_cnt from athlete_events
group by Year, Season
order by 3 desc)

select cte_low.Year as Year_with_lowest_part, cte_high.Year as Year_with_highest_part from CTE_low, CTE_high


--5) SQL query to return the list of countries who have been part of every Olympics games.
select Team, count(Games) from athlete_events
group by Team
having count(Games) = (select count(distinct(Games))from athlete_events)


--6) SQL query to fetch the list of all sports which have been part of every olympics.
select distinct Sport from athlete_events
where Games like '%Summer%'
order by Sport

--7) Using SQL query, Identify the sport which were just played once in all of olympics.
select Sport, count(distinct(Games)) as count_of_plays from athlete_events
group by Sport
having count(distinct(Games)) = 1
order by Sport

--8) Write SQL query to fetch the total no of sports played in each olympics.
select Games, count(distinct(Sport)) as Sports_Played from athlete_events
group by Games
order by Games

--9) SQL Query to fetch the details of the oldest athletes to win a gold medal at the olympics.
with cte_gold_age as (
select ID,	Name, Sex,Age, DENSE_RANK() over (order by Age desc) as rnk from athlete_events
where Medal = 'Gold'
)

select cte_gold_age.ID, cte_gold_age.Name, cte_gold_age.Sex, cte_gold_age.Age from cte_gold_age where rnk = 1


--10) SQL query to fetch the top 5 athletes who have won the most gold medals.
select top 5 Name, count(Medal) as Most_Gold from athlete_events
where Medal = 'Gold'
group by Name
order by 2 desc
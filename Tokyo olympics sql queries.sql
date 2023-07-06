create database Tokyoolym;
use Tokyoolym;
/*Total events in the olympics*/
SELECT 
count(case when Event="Men" then 1 end) as male_Event,
  count(case when Event="Women" then 1 end) as female_Event,
  count(case when Event="duet" then 1 end) as duet_Event,
  count(*) as total_cnt
from teams;

/*Country that participated in maximum and minimum events*/
SELECT max(noc) as country_in_max_events,count(noc) as no_of_events from teams;
SELECT Noc,count(noc) from teams where NOC=(SELECT min(Noc) from teams);

/*Country with maximum and minimum medals*/
SELECT NOC,max(gold) as country_with_max_gold from medals;
SELECT NOC,max(silver) as country_with_max_silver from medals;
SELECT NOC,max(bronze) as country_with_max_bronze from medals;

SELECT NOC,gold,silver,bronze from medals where gold=(SELECT min(gold) from medals);
     SELECT NOC,gold,silver,bronze from medals where silver=(SELECT min(silver) from medals);
     SELECT NOC,gold,silver,bronze from medals where bronze= (SELECT min(bronze) from medals);
     
/*Country ranks by the total medals they won and the best and worst performer*/
SELECT NOC, dense_rank() over (Order By Total DESC) as Rnk from medals;
SELECT Rank_by_total  as best_performer,NOC from medals where Rank_by_total = (SELECT min(Rank_by_total)from medals);
SELECT Rank_by_total  as worst_performer,NOC from medals where Rank_by_total = (SELECT max(Rank_by_total)from medals);

/* Sport with maximum and minimum male entries and female entries*/
SELECT  discipline,male from entriesgender where male=(Select Max(Male) from entriesgender);
SELECT  discipline,female from entriesgender where female=(Select Max(female) from entriesgender);
SELECT  discipline,male from entriesgender where male=(Select Min(Male) from entriesgender);
SELECT  discipline,female from entriesgender where female=(Select Min(female) from entriesgender);

/* Discipline in which each country participated (country wise discipline) */
select NOC,Discipline from athlete where Discipline=(select count(discipline) from athlete) is not null;
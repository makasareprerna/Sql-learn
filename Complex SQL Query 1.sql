--Complex SQL Query 1 | Derive Points table for ICC tournament

create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

--icc_world_cup table
-- Team_1	Team_2	Winner
-- India	SL	India
-- SL	Aus	Aus
-- SA	Eng	Eng
-- Eng	NZ	NZ
-- Aus	India	India


-- output should look like:
-- team_name	no_of_matches	no_of_matches_won	no_of_losses
-- India	2	2	0
-- NZ	1	1	0
-- Eng	2	1	1
-- Aus	2	1	1
-- SL	2	0	2
-- SA	1	0	1


--solution
select team_name, count(1) as no_of_matches, sum(win_flag) as no_of_matches_won, count(1) - sum(win_flag) as no_of_losses
from (
select team_1 as team_name, case when team_1=winner then 1 else 0 end as win_flag
from icc_world_cup
union all
select team_2 as team_name, case when team_2=winner then 1 else 0 end as win_flag
from icc_world_cup)
group by team_name
order by no_of_matches_won desc
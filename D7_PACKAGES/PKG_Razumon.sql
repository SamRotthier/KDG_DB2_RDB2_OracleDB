CREATE OR REPLACE PACKAGE PKG_Razumon
IS

CREATE OR REPLACE PROCEDURE empty_tables
IS
BEGIN

truncate table  RELATION_1;
truncate table  guild;
truncate table monster;
truncate table team;
truncate table player;

END empty_tables;
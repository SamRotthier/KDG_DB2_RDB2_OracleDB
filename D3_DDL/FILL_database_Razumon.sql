--Clearing the tables
DELETE FROM guild;
DELETE FROM monster;
DELETE FROM player;
DELETE FROM team;
DROP SEQUENCE monsterid_seq;
DROP SEQUENCE  playerid_seq;
DROP SEQUENCE  teamid_seq;
DROP SEQUENCE  guildid_seq;

---------------------------------------------------------------------------------------------------------------------------------------

--Creating the guildid Sequence
CREATE SEQUENCE guildid_seq
    START WITH 1 INCREMENT BY   1
    NOCACHE
 NOCYCLE;

 --Inserting the values of the guild table
INSERT INTO guild (guildid,guildname,guildskill,madeon,"level",madeby )
VALUES (guildid_seq.nextval,'Killers','Farming',DATE '2022-10-04',10,(SELECT playerid FROM player WHERE name = 'Sam'));

INSERT INTO guild (guildid,guildname,guildskill,madeon,"level",madeby )
VALUES (guildid_seq.nextval,'Skillers','Mining',DATE '2023-05-07',10,(SELECT playerid FROM player WHERE name = 'Pascal'));

INSERT INTO guild (guildid,guildname,guildskill,madeon,"level",madeby )
VALUES (guildid_seq.nextval,'Hunters','Hunting',DATE '2023-07-08',10,(SELECT playerid FROM player WHERE name = ''));

INSERT INTO guild (guildid,guildname,guildskill,madeon,"level",madeby )
VALUES (guildid_seq.nextval,'Gamers','Mining',DATE '2023-09-13',10,(SELECT playerid FROM player WHERE name = 'Jasper'));

INSERT INTO guild (guildid,guildname,guildskill,madeon,"level",madeby )
VALUES (guildid_seq.nextval,'Grinders','Building',DATE '2023-11-20',10,(SELECT playerid FROM player WHERE name = 'Leia'));
COMMIT;

-----------------------------------------------------------------------------------------------------------------------------------

 --Creating the monsterid Sequence
 CREATE SEQUENCE monsterid_seq
 START WITH 1 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

 --Inserting the values of the monster table
INSERT INTO monster(monsterid, monstername, health, "level",canevolve)
VALUES (monsterid_seq.nextval,'Bob',100,5,'f');
INSERT INTO monster(monsterid, monstername, health, "level",canevolve)
VALUES (monsterid_seq.nextval,'Drake',150,35,'t');
INSERT INTO monster(monsterid, monstername, health, "level",canevolve)
VALUES (monsterid_seq.nextval,'R2-D2',999,99,'t');
INSERT INTO monster(monsterid, monstername, health, "level",canevolve)
VALUES (monsterid_seq.nextval,'C3-PO',200,50,'f');
INSERT INTO monster(monsterid, monstername, health, "level",canevolve)
VALUES (monsterid_seq.nextval,'Yoda',75,15,'f');
COMMIT;

---------------------------------------------------------------------------------------------------------------------------------

 --Creating the playerid Sequence
 CREATE SEQUENCE playerid_seq
 START WITH 1 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

 --Inserting the values of the player table
INSERT INTO player(playerid,name,gender,"level",timeplayed,homeaddress,team_teamid,startdate,lastlogindate)
VALUES (playerid_seq.nextval,'Sam','Male',10,5,'randomstraat10',1,DATE '2020-11-04',DATE '2023-04-05');

INSERT INTO player(playerid,name,gender,"level",timeplayed,homeaddress,team_teamid,startdate,lastlogindate)
VALUES (playerid_seq.nextval,'Elise','Female',20,10,'randomstraat15',2,DATE '2019-05-21',DATE '2020-03-15');

INSERT INTO player(playerid,name,gender,"level",timeplayed,homeaddress,team_teamid,startdate,lastlogindate)
VALUES (playerid_seq.nextval,'Pascal', 'Male',50,100,'randomstraat20',3,DATE '2021-01-10',DATE '2022-10-20');

INSERT INTO player(playerid,name,gender,"level",timeplayed,homeaddress,team_teamid,startdate,lastlogindate)
VALUES (playerid_seq.nextval,'Jasper','Male',35,25,'randomstraat25',4,DATE '2023-01-01',DATE '2022-06-15');

INSERT INTO player(playerid,name,gender,"level",timeplayed,homeaddress,team_teamid,startdate,lastlogindate)
VALUES (playerid_seq.nextval,'Leia','Other',1,1,'randomstraat30',5,DATE '2023-04-05',DATE '2023-04-05');
COMMIT;

-----------------------------------------------------------------------------------------------------------------------------------

 --Creating the teamid Sequence
 CREATE SEQUENCE teamid_seq
 START WITH 1 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

 --Inserting the values of the team table
INSERT INTO team(teamid,teamname,timeplayedwithteam,player_playerid,monster_monsterid)
VALUES (teamid_seq.nextval,'BestTeam',10,(SELECT playerid FROM player WHERE name = 'Sam'),(SELECT monsterid FROM monster WHERE monstername = 'R2-D2'));

INSERT INTO team(teamid,teamname,timeplayedwithteam,player_playerid,monster_monsterid)
VALUES (teamid_seq.nextval,'NumberOnes',50,(SELECT playerid FROM player WHERE name = 'Pascal'),(SELECT monsterid FROM monster WHERE monstername = 'C3-PO'));

INSERT INTO team(teamid,teamname,timeplayedwithteam,player_playerid,monster_monsterid)
VALUES (teamid_seq.nextval,'GreatestOfAll',5,(SELECT playerid FROM player WHERE name = 'Elise'),(SELECT monsterid FROM monster WHERE monstername = 'Drake'));

INSERT INTO team(teamid,teamname,timeplayedwithteam,player_playerid,monster_monsterid)
VALUES (teamid_seq.nextval,'NotATeam',15,(SELECT playerid FROM player WHERE name = 'Jasper'),(SELECT monsterid FROM monster WHERE monstername = 'Yoda'));

INSERT INTO team(teamid,teamname,timeplayedwithteam,player_playerid,monster_monsterid)
VALUES (teamid_seq.nextval,'Test',1,(SELECT playerid FROM player WHERE name = 'Leia'),(SELECT monsterid FROM monster WHERE monstername = 'Bob'));
COMMIT;

DELETE FROM guild;
DELETE FROM monster;
DELETE FROM player;
DELETE FROM team;

INSERT INTO guild (guildid,guildname,guildskill,madeon,"Level",madeby )
VALUES ();
INSERT INTO guild (guildid,guildname,guildskill,madeon,"Level",madeby )
VALUES ();
INSERT INTO guild (guildid,guildname,guildskill,madeon,"Level",madeby )
VALUES ();
INSERT INTO guild (guildid,guildname,guildskill,madeon,"Level",madeby )
VALUES ();
INSERT INTO guild (guildid,guildname,guildskill,madeon,"Level",madeby )
VALUES ();
COMMIT;

INSERT INTO monster(monsterid, monstername, health, "Level",canevolve)
VALUES ();
INSERT INTO monster(monsterid, monstername, health, "Level",canevolve)
VALUES ();
INSERT INTO monster(monsterid, monstername, health, "Level",canevolve)
VALUES ();
INSERT INTO monster(monsterid, monstername, health, "Level",canevolve)
VALUES ();
INSERT INTO monster(monsterid, monstername, health, "Level",canevolve)
VALUES ();
COMMIT;

INSERT INTO player(playerid,name,gender,"Level",timeplayed,homeaddress,team_teamid,startdate,lastlogindate)
VALUES ();
INSERT INTO player(playerid,name,gender,"Level",timeplayed,homeaddress,team_teamid,startdate,lastlogindate)
VALUES ();
INSERT INTO player(playerid,name,gender,"Level",timeplayed,homeaddress,team_teamid,startdate,lastlogindate)
VALUES ();
INSERT INTO player(playerid,name,gender,"Level",timeplayed,homeaddress,team_teamid,startdate,lastlogindate)
VALUES ();
INSERT INTO player(playerid,name,gender,"Level",timeplayed,homeaddress,team_teamid,startdate,lastlogindate)
VALUES ();
COMMIT;

INSERT INTO team(teamid,teamname,timeplayedwithteam,player_playerid,monster_monsterid)
VALUES ();
INSERT INTO team(teamid,teamname,timeplayedwithteam,player_playerid,monster_monsterid)
VALUES ();
INSERT INTO team(teamid,teamname,timeplayedwithteam,player_playerid,monster_monsterid)
VALUES ();
INSERT INTO team(teamid,teamname,timeplayedwithteam,player_playerid,monster_monsterid)
VALUES ();
INSERT INTO team(teamid,teamname,timeplayedwithteam,player_playerid,monster_monsterid)
VALUES ();
COMMIT;
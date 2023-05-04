Milestone 3: Creatie Databank
---

    Identity columns
---
- Mandatory
  - guild: guildid, guildname, madeon
  - monster: monsterid, monstername, health, team_teamid
  - player: playerid, name
  - relation_1: guildid, playerid
- Other:
  - guild: madeby


      Table Counts
---
![Table counts](screenshots_M4/table_count.PNG)

    @query 1: Relatie Veel-op-veel

SELECT PLAYER_PLAYERID,player.name,GUILD_GUILDID,guild.guildname FROM RELATION_1
JOIN player on player.playerid = PLAYER_PLAYERID
JOIN guild on guild.guildid = GUILD_GUILDID;
--- 
![query 1: Relatie Veel-op-veel](screenshots_M4/veel_op_veel.PNG)



    @query 2: 2 niveau’s diep

SELECT playerid, name, team.teamid,team.teamname,monster.monsterid,monster.monstername FROM player
JOIN team ON team.teamid = player.playerid
JOIN monster ON monster.monsterid = team.teamid;
--- 
![query 2: 2 niveau’s diep](screenshots_M4/2_niveaus_diep.PNG)

    @query 3: player_all

SELECT playerid,name,guild.guildid,guild.guildname, team.teamid, team.teamname, monster.monsterid,monster.monstername FROM player
JOIN team on team.player_playerid = player.playerid
JOIN monster on monster.team_teamid = team.teamid
JOIN relation_1 on player.playerid = relation_1.PLAYER_PLAYERID
JOIN guild on guild.guildid = relation_1.GUILD_GUILDID
ORDER BY playerid asc;
--- 
![query 3: player locations](screenshots_M4/player_all.PNG)


  Bewijs Domeinen - constraints M2
--- 
    Player: Start with capital and is 3 long

---
![Bewijs Capital](screenshots_M4/NAME_START_CAPITAL.PNG)
![Bewijs Min Length](screenshots_M4/MIN_NAME_LENGTH.PNG)

    Player: level larger then 0

---
![Bewijs larger then 0](screenshots_M4/LEVEL_LARGER_THEN_ZERO.PNG)


    guild: level between 0 and 100

---

![Bewijs level](screenshots_M4/MAX_LEVEL_1.PNG)
![Bewijs level](screenshots_M4/MAX_LEVEL_2.PNG)



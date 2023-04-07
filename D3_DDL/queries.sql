SELECT * FROM guild;
SELECT * FROM monster;
SELECT * FROM player;
SELECT * FROM team;
SELECT * FROM RELATION_1;

SELECT 'Guilds' as table_name, (SELECT COUNT(*) FROM guild) AS table_Count FROM dual UNION
SELECT 'Players', (SELECT COUNT(*) FROM player) FROM dual UNION
SELECT 'Monsters', (SELECT COUNT(*) FROM monster) FROM dual UNION
SELECT 'Teams', (SELECT COUNT(*) FROM team) FROM dual;

SELECT * FROM player
JOIN team ON team.teamid = player.playerid
JOIN monster ON monster.monsterid = team.teamid;

SELECT playerid, name, team.teamid,team.teamname,monster.monsterid,monster.monstername FROM player
JOIN team ON team.teamid = player.playerid
JOIN monster ON monster.monsterid = team.teamid;

SELECT PLAYER_PLAYERID,player.name,GUILD_GUILDID,guild.guildname FROM RELATION_1
JOIN player on player.playerid = PLAYER_PLAYERID
JOIN guild on guild.guildid = GUILD_GUILDID
ORDER BY PLAYER_PLAYERID desc;

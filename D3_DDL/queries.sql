SELECT * FROM guild;
SELECT * FROM monster;
SELECT * FROM player;
SELECT * FROM team;

SELECT 'Guilds' as table_name, (SELECT COUNT(*) FROM guild) AS table_Count FROM dual UNION
SELECT 'Players', (SELECT COUNT(*) FROM player) FROM dual UNION
SELECT 'Monsters', (SELECT COUNT(*) FROM monster) FROM dual UNION
SELECT 'Teams', (SELECT COUNT(*) FROM team) FROM dual;

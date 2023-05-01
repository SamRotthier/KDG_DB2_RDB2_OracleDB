CREATE OR REPLACE PACKAGE BODY PKG_Razumon
AS
    -- Public

    -- Empty tables
    PROCEDURE empty_tables
    AS
    BEGIN

        EXECUTE IMMEDIATE 'TRUNCATE TABLE RELATION_1';
        EXECUTE IMMEDIATE 'TRUNCATE TABLE guild';
        EXECUTE IMMEDIATE 'TRUNCATE TABLE monster';
        EXECUTE IMMEDIATE 'TRUNCATE TABLE team';
        EXECUTE IMMEDIATE 'TRUNCATE TABLE player';

        EXECUTE IMMEDIATE 'DROP SEQUENCE  playerid_seq';
        EXECUTE IMMEDIATE 'CREATE SEQUENCE playerid_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE';
        EXECUTE IMMEDIATE 'DROP SEQUENCE  guildid_seq';
        EXECUTE IMMEDIATE 'CREATE SEQUENCE guildid_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE';
        EXECUTE IMMEDIATE 'DROP SEQUENCE  teamid_seq';
        EXECUTE IMMEDIATE 'CREATE SEQUENCE teamid_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE';
        EXECUTE IMMEDIATE 'DROP SEQUENCE  monsterid_seq';
        EXECUTE IMMEDIATE 'CREATE SEQUENCE monsterid_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE';
       --EXECUTE IMMEDIATE 'ALTER TABLE player MODIFY playerid GENERATED ALWAYS AS IDENTITY(START WITH 1)';
       --EXECUTE IMMEDIATE 'ALTER TABLE guild MODIFY guildid GENERATED ALWAYS AS IDENTITY(START WITH 1)';
       --EXECUTE IMMEDIATE 'ALTER TABLE team MODIFY teamid GENERATED ALWAYS AS IDENTITY(START WITH 1)';
       --EXECUTE IMMEDIATE 'ALTER TABLE monster MODIFY monsterid GENERATED ALWAYS AS IDENTITY(START WITH 1)';
    END empty_tables;

    -- add Players in player table
    PROCEDURE add_player(
        p_name player.name%TYPE,
        p_gender player.gender%TYPE,
        p_level player."level"%TYPE,
        p_timeplayed player.timeplayed%TYPE,
        p_homeaddress player.homeaddress%TYPE,
        p_startdate player.startdate%TYPE,
        p_lastlogindate player.lastlogindate%TYPE
    )
    AS
        p_playerid player.playerid%TYPE;
    BEGIN
        p_playerid := lookup_playerid(p_name);
        INSERT INTO player(
            playerid,
            name,
            gender,
            "level",
            timeplayed,
            homeaddress,
            startdate,
            lastlogindate
        )
        VALUES (
                p_playerid,
                   p_name,
                   p_gender,
                   p_level,
                   p_timeplayed,
                   p_homeaddress,
                   p_startdate,
                   p_lastlogindate
               );
        COMMIT;
    END add_player;

    -- add guilds in guild table
    PROCEDURE add_guild(
        p_guildname guild.guildname%TYPE,
        p_guildskill guild.guildskill%TYPE,
        p_madeon guild.madeon%TYPE,
        p_level guild."level"%TYPE,
        p_name player.name%TYPE
    )
    AS
        p_guildid guild.guildid%TYPE;
        p_playerid player.playerid%TYPE;
    BEGIN
        p_guildid := lookup_guildid(p_guildname);
        p_playerid := lookup_playerid(p_name);
        INSERT INTO guild(
            guildid,
            guildname,
            guildskill,
            madeon,
            "level",
            madeby
        )
        VALUES (
                   p_guildid,
                   p_guildname,
                   p_guildskill,
                   p_madeon,
                   p_level,
                   p_playerid
               );
        COMMIT;
    END add_guild;

    -- add relations in relation table
    PROCEDURE add_relation(
        p_guildname guild.guildname%TYPE,
        p_name player.name%TYPE
    )
    AS
        p_guildid guild.guildid%TYPE;
        p_playerid player.playerid%TYPE;
    BEGIN
        p_guildid := lookup_guildid(p_guildname);
        p_playerid := lookup_playerid(p_name);
        INSERT INTO RELATION_1(
            guild_guildid,
            player_playerid
        )
        VALUES (
                   p_guildid,
                   p_playerid
               );
        COMMIT;
    END add_relation;

    -- add teams in team table
    PROCEDURE add_team(
        p_teamname team.teamname%TYPE,
        p_timeplayedwithteam team.timeplayedwithteam%TYPE,
        p_name player.name%TYPE
    )
    AS
        p_teamid team.teamid%TYPE;
        p_playerid player.playerid%TYPE;
    BEGIN
        p_teamid := lookup_teamid(p_teamname);
        p_playerid := lookup_playerid(p_name);
        INSERT INTO team(
            teamid,
            teamname,
            timeplayedwithteam,
            player_playerid
        )
        VALUES (
                   p_teamid,
                   p_teamname,
                   p_timeplayedwithteam,
                   p_playerid
               );
        COMMIT;
    END add_team;

    -- add monsters in monster table
    PROCEDURE add_monster(
        p_monstername monster.monstername%TYPE,
        p_health monster.health%TYPE,
        p_level monster."level"%TYPE,
        p_canevolve monster.canevolve%TYPE,
        p_teamname team.teamname%TYPE

    )
    AS
        p_monsterid monster.monsterid%TYPE;
        p_teamid team.teamid%TYPE;
    BEGIN
        p_teamid := lookup_teamid(p_teamname);
        p_monsterid := lookup_monsterid(p_monstername);
        INSERT INTO monster(
            monsterid,
            monstername,
            health,
            "level",
            canevolve,
            team_teamid
        )
        VALUES (
                   p_monsterid,
                   p_monstername,
                   p_health,
                   p_level,
                   p_canevolve,
                   p_teamid
               );
        COMMIT;
    END  add_monster;

    -- Private
    -- Lookup functions
    -- lookup playerid
    FUNCTION lookup_playerid
    (
        p_name player.name%TYPE
    )
        RETURN INTEGER
    AS lu_player_id INTEGER;
    BEGIN
        SELECT playerid
        INTO lu_player_id
        FROM player
        WHERE name = p_name;

        RETURN lu_player_id;
    END lookup_playerid;

    -- lookup guildid
    FUNCTION lookup_guildid
    (
        p_guildname guild.guildname%TYPE
    )
        RETURN INTEGER
    AS lu_guild_id INTEGER;
    BEGIN
        SELECT guildid
        INTO lu_guild_id
        FROM guild
        WHERE guildname = p_guildname;

        RETURN lu_guild_id;
    END lookup_guildid;

    -- lookup teamid
    FUNCTION lookup_teamid
    (
        p_teamname team.teamname%TYPE
    )
        RETURN INTEGER
    AS lu_team_id INTEGER;
    BEGIN
        SELECT teamid
        INTO lu_team_id
        FROM team
        WHERE teamname = p_teamname;

        RETURN lu_team_id;
    END lookup_teamid;

    -- lookup monsterid
    FUNCTION lookup_monsterid
    (
        p_monstername monster.monstername%TYPE
    )
        RETURN INTEGER
    AS lu_monster_id INTEGER;
    BEGIN
        SELECT monsterid
        INTO lu_monster_id
        FROM monster
        WHERE monstername = p_monstername;

        RETURN lu_monster_id;
    END lookup_monsterid;


END PKG_Razumon;
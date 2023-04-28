CREATE OR REPLACE PACKAGE BODY PKG_Razumon
AS
    -- Public functions
    -- Empty tables
    PROCEDURE empty_tables
    AS
    BEGIN

        EXECUTE IMMEDIATE 'TRUNCATE TABLE RELATION_1';
        EXECUTE IMMEDIATE 'TRUNCATE TABLE guild';
        EXECUTE IMMEDIATE 'TRUNCATE TABLE monster';
        EXECUTE IMMEDIATE 'TRUNCATE TABLE team';
        EXECUTE IMMEDIATE 'TRUNCATE TABLE player';

        EXECUTE IMMEDIATE 'ALTER TABLE guild MODIFY guildid GENERATED ALWAYS AS IDENTITY(START WITH 1)';
        EXECUTE IMMEDIATE 'ALTER TABLE player MODIFY playerid GENERATED ALWAYS AS IDENTITY(START WITH 1)';
        EXECUTE IMMEDIATE 'ALTER TABLE team MODIFY teamid GENERATED ALWAYS AS IDENTITY(START WITH 1)';
        EXECUTE IMMEDIATE 'ALTER TABLE monster MODIFY monsterid GENERATED ALWAYS AS IDENTITY(START WITH 1)';

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
    BEGIN
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
                lookup_playerid(p_name,p_homeaddress),
                   p_name,
                   p_gender,
                   p_level,
                   p_timeplayed,
                   p_homeaddress,
                   p_startdate,
                   p_lastlogindate
               );

    END add_player;

    PROCEDURE add_guild(
        p_guildname guild.guildname%TYPE,
        p_guildskill guild.guildskill%TYPE,
        p_madeon guild.madeon%TYPE,
        p_level guild."level"%TYPE,
        p_madeby guild.madeby%TYPE
    )
    AS
    BEGIN
        INSERT INTO guild(
            guildid,
            guildname,
            guildskill,
            madeon,
            "level",
            madeby
        )
        VALUES (
                lookup_guildid(guildname),
                   p_guildname,
                   p_guildskill,
                   p_madeon,
                   p_level,
                   p_madeby
               );
    END add_guild;

    PROCEDURE add_team(
        p_teamname team.teamname%TYPE,
        p_timeplayedwithteam team.timeplayedwithteam%TYPE,
        p_name player.name%TYPE,
        p_homeaddress player.homeaddress%TYPE
    )
    AS
    BEGIN
        INSERT INTO team(
            teamid,
            teamname,
            timeplayedwithteam,
            player_playerid
        )
        VALUES (
                    lookup_teamid(teamname),
                   p_teamname,
                   p_timeplayedwithteam,
                    lookup_playerid(p_name,p_homeaddress)
               );
    END add_team;

    PROCEDURE add_monster(
        p_monstername monster.monstername%TYPE,
        p_health monster.health%TYPE,
        p_level monster."level"%TYPE,
        p_canevolve monster.canevolve%TYPE,
        p_teamname team.teamname%TYPE
    )
    AS
    BEGIN
        INSERT INTO monster(
                            monsterid,
            monstername,
            health,
            "level",
            canevolve,
                            team_teamid
        )
        VALUES (
                lookup_monsterid(monstername),
                   p_monstername,
                   p_health,
                   p_level,
                   p_canevolve,
                    lookup_teamid(p_teamname)
               );
    END  add_monster;

-- Private functions
    -- Lookup functions
    FUNCTION lookup_playerid
    (
        p_name player.name%TYPE,
        p_homeaddress player.homeaddress%TYPE
    )
        RETURN INTEGER
    AS ln_player_id INTEGER;
    BEGIN
        SELECT playerid
        INTO ln_player_id
        FROM player
        WHERE name = p_name
          AND homeaddress = p_homeaddress ;

        RETURN ln_player_id;
    END lookup_playerid;

    FUNCTION lookup_guildid
    (
        p_guildname guild.guildname%TYPE
    )
        RETURN INTEGER
    AS ln_guild_id INTEGER;
    BEGIN
        SELECT guildid
        INTO ln_guild_id
        FROM guild
        WHERE guildname = p_guildname;

        RETURN ln_guild_id;
    END lookup_guildid;

    FUNCTION lookup_teamid
    (
        p_teamname team.teamname%TYPE
    )
        RETURN INTEGER
    AS ln_team_id INTEGER;
    BEGIN
        SELECT teamid
        INTO ln_team_id
        FROM team
        WHERE teamname = p_teamname;

        RETURN ln_team_id;
    END lookup_teamid;

    FUNCTION lookup_monsterid
    (
        p_monstername monster.monstername%TYPE
    )
        RETURN INTEGER
    AS ln_monster_id INTEGER;
    BEGIN
        SELECT monsterid
        INTO ln_monster_id
        FROM monster
        WHERE monstername = p_monstername;

        RETURN ln_monster_id;
    END lookup_monsterid;

END PKG_Razumon;
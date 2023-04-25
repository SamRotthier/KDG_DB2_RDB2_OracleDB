CREATE OR REPLACE PACKAGE BODY PKG_Razumon
IS
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

EXECUTE IMMEDIATE 'ALTER TABLE guild MODIFY guildid_seq GENERATED ALWAYS AS IDENTITY(START WITH 1)';
EXECUTE IMMEDIATE 'ALTER TABLE player MODIFY playerid_seq GENERATED ALWAYS AS IDENTITY(START WITH 1)';
EXECUTE IMMEDIATE 'ALTER TABLE team MODIFY teamid_seq GENERATED ALWAYS AS IDENTITY(START WITH 1)';
EXECUTE IMMEDIATE 'ALTER TABLE monster MODIFY monsterid_seq GENERATED ALWAYS AS IDENTITY(START WITH 1)';

END empty_tables;

PROCEDURE add_player(
    p_name player.name%TYPE,
    p_gender player.gender%TYPE,
    p_level player.level%TYPE,
    p_timeplayed player.timeplayed%TYPE,
    p_homeaddress player.homeaddress%TYPE,
    p_startdate player.startdate%TYPE,
    p_lastlogindate player.lastlogindate%TYPE
    )
AS
BEGIN
INSERT INTO player(
    name,
    gender,
    "level",
    timeplayed,
    homeaddress,
    startdate,
    lastlogindate
)
VALUES (
           p_name,
           p_gender,
           p_level,
           p_timeplayed,
           p_homeaddress,
           p_startdate,
           p_lastlogindate
       )

END add_player;

    PROCEDURE add_guild(
    p_guildname guild.guildname%TYPE,
    p_guildskill guild.guildskill%TYPE,
    p_madeon guild.madeon%TYPE,
    p_level guild.level%TYPE,
    p_madeby guild.madeby%TYPE
    )
AS
BEGIN


END add_guild;

  PROCEDURE add_team(
    p_teamname player.teamname%TYPE,
    p_timeplayedwithteam player.timeplayedwithteam%TYPE
    )
AS
BEGIN


END add_team;

    PROCEDURE add_monster(
    p_monstername monster.monstername%TYPE,
    p_health monster.health%TYPE,
    p_level monster.level%TYPE,
    p_canevolve monster.canevolve%TYPE
    )
AS
BEGIN


END  add_monster;
-- Private functions
        -- Lookup functions
    FUNCTION lookup_playerid
    ()
        RETURN INTEGER
    AS

    FUNCTION lookup_guildid
    ()
        RETURN INTEGER
    AS

    FUNCTION lookup_teamid
    ()
        RETURN INTEGER
    AS

    FUNCTION lookup_monsterid
    ()
        RETURN INTEGER
    AS
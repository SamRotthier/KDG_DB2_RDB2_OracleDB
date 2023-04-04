
--Dropping tables
DROP TABLE guild cascade constraints;
DROP TABLE monster cascade constraints;
DROP TABLE player cascade constraints;
DROP TABLE team cascade constraints;





CREATE TABLE guild (
    guildid    INTEGER NOT NULL,
    guildname  VARCHAR2(25) NOT NULL,
    guildskill VARCHAR2(15),
    madeon     DATE NOT NULL,
    "Level"    INTEGER,
    madeby     VARCHAR2(30)
);

ALTER TABLE guild
    ADD CHECK ( guildskill IN ( 'Building', 'Crafting', 'Farming', 'Hunting', 'Mining' ) );

ALTER TABLE guild
    ADD CONSTRAINT max_level CHECK ( level > 0
                                     AND level < 100 );

ALTER TABLE guild ADD CONSTRAINT guild_pk PRIMARY KEY ( guildid );

CREATE TABLE monster (
    monsterid   INTEGER NOT NULL,
    monstername VARCHAR2(10) NOT NULL,
    health      INTEGER NOT NULL,
    "Level"     INTEGER,
    canevolve   CHAR(1)
);

ALTER TABLE monster
    ADD CHECK ( canevolve IN ( 'False', 'True' ) );

ALTER TABLE monster ADD CONSTRAINT monster_pk PRIMARY KEY ( monsterid );

CREATE TABLE player (
    playerid      INTEGER NOT NULL,
    name          VARCHAR2(30) NOT NULL,
    gender        VARCHAR2(10),
    "Level"       INTEGER,
    timeplayed    INTEGER,
    homeaddress   VARCHAR2(50),
    team_teamid   INTEGER NOT NULL,
    startdate     DATE,
    lastlogindate DATE
);

ALTER TABLE player
    ADD CHECK ( gender IN ( 'Female', 'Male', 'Other' ) );

ALTER TABLE player ADD CONSTRAINT level_larger_then_zero CHECK ( level >= 0 );

CREATE UNIQUE INDEX player__idx ON
    player (
        team_teamid
    ASC );

ALTER TABLE player ADD CONSTRAINT player_pk PRIMARY KEY ( playerid );

CREATE TABLE relation_3 (
    player_playerid INTEGER NOT NULL,
    guild_guildid   INTEGER NOT NULL
);

ALTER TABLE relation_3 ADD CONSTRAINT relation_3_pk PRIMARY KEY ( player_playerid,
                                                                  guild_guildid );

CREATE TABLE team (
    teamid             INTEGER NOT NULL,
    teamname           VARCHAR2(15) NOT NULL,
    timeplayedwithteam INTEGER,
    player_playerid    INTEGER NOT NULL,
    monster_monsterid  INTEGER NOT NULL
);

CREATE UNIQUE INDEX team__idx ON
    team (
        player_playerid
    ASC );

ALTER TABLE team ADD CONSTRAINT team_pk PRIMARY KEY ( teamid );

ALTER TABLE player
    ADD CONSTRAINT player_team_fk FOREIGN KEY ( team_teamid )
        REFERENCES team ( teamid );

ALTER TABLE relation_3
    ADD CONSTRAINT relation_3_guild_fk FOREIGN KEY ( guild_guildid )
        REFERENCES guild ( guildid );

ALTER TABLE relation_3
    ADD CONSTRAINT relation_3_player_fk FOREIGN KEY ( player_playerid )
        REFERENCES player ( playerid );

ALTER TABLE team
    ADD CONSTRAINT team_monster_fk FOREIGN KEY ( monster_monsterid )
        REFERENCES monster ( monsterid );

ALTER TABLE team
    ADD CONSTRAINT team_player_fk FOREIGN KEY ( player_playerid )
        REFERENCES player ( playerid );




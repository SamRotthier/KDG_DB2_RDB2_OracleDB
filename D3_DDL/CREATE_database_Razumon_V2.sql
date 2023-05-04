
--Dropping tables
DROP TABLE guild cascade constraints;
DROP TABLE monster cascade constraints;
DROP TABLE player cascade constraints;
DROP TABLE team cascade constraints;
DROP TABLE relation_1 CASCADE CONSTRAINTS;





CREATE TABLE guild (
                       guildid    INTEGER GENERATED ALWAYS AS IDENTITY,
                       guildname  VARCHAR2(25) NOT NULL,
                       guildskill VARCHAR2(15),
                       madeon     DATE NOT NULL,
                       "level"    INTEGER,
                       madeby     INTEGER
);

ALTER TABLE guild
    ADD CHECK ( guildskill IN ( 'Building', 'Crafting', 'Farming', 'Hunting', 'Mining' ) );

ALTER TABLE guild
    ADD CONSTRAINT max_level CHECK ( "level" > 0
        AND "level" < 100 );

ALTER TABLE guild ADD CONSTRAINT guild_pk PRIMARY KEY ( guildid );

CREATE TABLE monster (
                         monsterid   INTEGER GENERATED ALWAYS AS IDENTITY,
                         monstername VARCHAR2(10) NOT NULL,
                         health      INTEGER NOT NULL,
                         "level"     INTEGER,
                         canevolve   CHAR(1),
                         team_teamid INTEGER NOT NULL
);

ALTER TABLE monster ADD CONSTRAINT monster_pk PRIMARY KEY ( monsterid );

CREATE TABLE player (
                        playerid      INTEGER GENERATED ALWAYS AS IDENTITY,
                        name          VARCHAR2(30) NOT NULL,
                        gender        VARCHAR2(10),
                        "level"       INTEGER,
                        timeplayed    INTEGER,
                        homeaddress   VARCHAR2(50),
                        startdate     DATE,
                        lastlogindate DATE

);

ALTER TABLE player
    ADD CHECK ( gender IN ( 'Female', 'Male', 'Other' ) );

ALTER TABLE player ADD CONSTRAINT name_start_capital CHECK (name= INITCAP(name)) ;

ALTER TABLE player
    ADD CONSTRAINT min_name_length CHECK (LENGTHB(name) >= 3);

ALTER TABLE player ADD CONSTRAINT level_larger_then_zero CHECK ( "level" > 0 );


ALTER TABLE player ADD CONSTRAINT player_pk PRIMARY KEY ( playerid );

CREATE TABLE relation_1(
                           relationid   INTEGER GENERATED ALWAYS AS IDENTITY,
                           player_playerid INTEGER NOT NULL,
                           guild_guildid   INTEGER NOT NULL
);

ALTER TABLE relation_1 ADD CONSTRAINT relation_1_pk PRIMARY KEY (relationid );

CREATE TABLE team (
                      teamid   INTEGER GENERATED ALWAYS AS IDENTITY,
                      teamname           VARCHAR2(15) NOT NULL,
                      timeplayedwithteam INTEGER,
                      player_playerid    INTEGER NOT NULL
);

--CREATE UNIQUE INDEX team__idx ON team (player_playerid ASC );

ALTER TABLE team ADD CONSTRAINT team_pk PRIMARY KEY ( teamid );


ALTER TABLE relation_1
    ADD CONSTRAINT relation_1_player_fk FOREIGN KEY ( player_playerid )
        REFERENCES player ( playerid );

ALTER TABLE monster
    ADD CONSTRAINT monster_team_fk FOREIGN KEY (team_teamid)
        REFERENCES team ( teamid );

ALTER TABLE team
    ADD CONSTRAINT team_player_fk FOREIGN KEY ( player_playerid )
        REFERENCES player ( playerid );

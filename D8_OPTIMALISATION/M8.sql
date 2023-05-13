-- Procedures for making the tables
begin
    PKG_Razumon.empty_tables();
    PKG_RAZUMON.genereer_Veel_op_Veel( 20, 20, 50);
    PKG_RAZUMON.genereer_2_levels(20,40,500);
end;

--Run once at start of session for smaller partition sizes
alter session set "_partition_large_extents" = false;

--Checking the size of a table
select segment_name,segment_type, sum(bytes/1024/1024) MB ,
(select   COUNT(*) FROM player) as table_count
from dba_segments
where segment_name= 'PLAYER'
group by segment_name,segment_type;

-- Check all partitions
select * from USER_TAB_PARTITIONS;
-- Purge for if there is still an unwanted parition after dropping a table
purge recyclebin;

-- partitioning monster table on teamid
DROP TABLE monster CASCADE CONSTRAINTS PURGE;
CREATE TABLE monster (
                         monsterid   INTEGER GENERATED ALWAYS AS IDENTITY
                             CONSTRAINT software_pk PRIMARY KEY,
                         monstername VARCHAR2(500) NOT NULL,
                         health      INTEGER NOT NULL,
                         "level"     INTEGER,
                         canevolve   CHAR(1),
                         team_teamid INTEGER NOT NULL
)
    PARTITION BY RANGE (team_teamid)
    INTERVAL (50)
(
    partition team_50 VALUES LESS THAN (50)
);

ALTER TABLE monster
    ADD CONSTRAINT monster_team_fk FOREIGN KEY (team_teamid)
        REFERENCES team ( teamid );


-- partitioning monster table on level
DROP TABLE monster CASCADE CONSTRAINTS PURGE;
CREATE TABLE monster (
                         monsterid   INTEGER GENERATED ALWAYS AS IDENTITY
                             CONSTRAINT software_pk PRIMARY KEY,
                         monstername VARCHAR2(500) NOT NULL,
                         health      INTEGER NOT NULL,
                         "level"     INTEGER,
                         canevolve   CHAR(1),
                         team_teamid INTEGER NOT NULL
)
    PARTITION BY RANGE ( "level" )
    INTERVAL (25)
(
    partition LevelLess25 VALUES LESS THAN (25),
    partition LevelLess50 VALUES LESS THAN (50),
    partition LevelLess75 VALUES LESS THAN (75),
    partition LevelLess100 VALUES LESS THAN (100)
);

-- Clean monster table
DROP TABLE monster CASCADE CONSTRAINTS PURGE;
CREATE TABLE monster (
                         monsterid   INTEGER GENERATED ALWAYS AS IDENTITY
                             CONSTRAINT software_pk PRIMARY KEY,
                         monstername VARCHAR2(500) NOT NULL,
                         health      INTEGER NOT NULL,
                         "level"     INTEGER,
                         canevolve   CHAR(1),
                         team_teamid INTEGER NOT NULL
);
ALTER TABLE monster
    ADD CONSTRAINT monster_team_fk FOREIGN KEY (team_teamid)
        REFERENCES team ( teamid );

-- Query
SELECT p.playerid, m.monstername,  ROUND(AVG(m."level")) AS "Average_time_played"
FROM player p
         JOIN team t ON p.playerid = t.PLAYER_PLAYERID
         JOIN monster m ON m.team_teamid = t.teamid
WHERE t.teamid < 25
GROUP BY p.playerid, m.monstername
ORDER BY p.playerid;
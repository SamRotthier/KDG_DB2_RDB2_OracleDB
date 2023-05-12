
begin
    PKG_Razumon.empty_tables();
    PKG_RAZUMON.genereer_Veel_op_Veel( 20, 20, 50);
    PKG_RAZUMON.genereer_2_levels(20,40,500);
end;

--Run once at start of session for smaller partition sizes
alter session set "_partition_large_extents" = false;

--checking the size of a table
select segment_name,segment_type, sum(bytes/1024/1024) MB ,
(select   COUNT(*) FROM player) as table_count
from dba_segments
where segment_name= 'PLAYER'
group by segment_name,segment_type;

--query
SELECT p.playerid, p.name, ROUND(AVG(m."level")) AS "Average_monster_level", ROUND(AVG(t.timeplayedwithteam)) AS "Average_time_played"
FROM player p
         JOIN team t ON p.playerid = t.PLAYER_PLAYERID
         JOIN monster m ON m.team_teamid = t.teamid
GROUP BY p.playerid, p.name
HAVING ROUND(AVG(t.timeplayedwithteam)) > '25'
ORDER BY p.playerid;


-- partitioning player table
CREATE TABLE player
(
    playerid      INTEGER GENERATED ALWAYS AS IDENTITY,
    name          VARCHAR2(500) NOT NULL,
    gender        VARCHAR2(10),
    "level"       INTEGER,
    timeplayed    INTEGER,
    homeaddress   VARCHAR2(50),
    startdate     DATE,
    lastlogindate DATE

)    PARTITION BY RANGE (playerid)
    INTERVAL (50)
(
    partition rep_50 VALUES LESS THAN (50)
);

ALTER TABLE player
    ADD CHECK ( gender IN ( 'Female', 'Male', 'Other' ) );

ALTER TABLE player ADD CONSTRAINT name_start_capital CHECK (name= INITCAP(name)) ;

ALTER TABLE player
    ADD CONSTRAINT min_name_length CHECK (LENGTHB(name) >= 3);

ALTER TABLE player ADD CONSTRAINT level_larger_then_zero CHECK ( "level" > 0 );


ALTER TABLE player ADD CONSTRAINT player_pk PRIMARY KEY ( playerid );

-- partitioning monster table
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
    PARTITION BY RANGE (monsterid)
    INTERVAL (50000)
(
    partition monsterid_50k VALUES LESS THAN (50000)
);

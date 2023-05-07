CREATE OR REPLACE PACKAGE BODY PKG_Razumon
AS
    -- Private M4
    -- Lookup functions
    -- lookup playerid
    FUNCTION lookup_playerid(
        p_name player.name%TYPE
    )
        RETURN INTEGER
    AS
        lu_player_id INTEGER;
    BEGIN
        SELECT playerid
        INTO lu_player_id
        FROM player
        WHERE name = p_name;
        --dbms_output.put_line('Test');

        RETURN lu_player_id;
    END lookup_playerid;

    -- lookup guildid
    FUNCTION lookup_guildid(
        p_guildname guild.guildname%TYPE
    )
        RETURN INTEGER
    AS
        lu_guild_id INTEGER;
    BEGIN
        SELECT guildid
        INTO lu_guild_id
        FROM guild
        WHERE guildname = p_guildname;

        RETURN lu_guild_id;
    END lookup_guildid;

    -- lookup teamid
    FUNCTION lookup_teamid(
        p_teamname team.teamname%TYPE
    )
        RETURN INTEGER
    AS
        lu_team_id INTEGER;
    BEGIN
        SELECT teamid
        INTO lu_team_id
        FROM team
        WHERE teamname = p_teamname;

        RETURN lu_team_id;
    END lookup_teamid;

    -- lookup monsterid
    FUNCTION lookup_monsterid(
        p_monstername monster.monstername%TYPE
    )
        RETURN INTEGER
    AS
        lu_monster_id INTEGER;
    BEGIN
        SELECT monsterid
        INTO lu_monster_id
        FROM monster
        WHERE monstername = p_monstername;

        RETURN lu_monster_id;
    END lookup_monsterid;

    -- Private M5
    FUNCTION random_number(
        p_min IN NUMBER,
        p_max IN NUMBER)
        RETURN NUMBER
    AS
    BEGIN
        RETURN TRUNC(dbms_random.VALUE(p_min, p_max));
    END random_number;

    FUNCTION random_date(
        p_from IN DATE,
        p_to IN DATE)
        RETURN DATE
    AS
        lu_range    NUMBER;
        lu_datepick NUMBER;
    BEGIN
        lu_range := p_to - p_from;
        lu_datepick := random_number(0, lu_range);
        RETURN p_from + lu_datepick;
    END random_date;

    FUNCTION random_gender
        RETURN player.gender%TYPE
        IS
        TYPE type_varray_type IS VARRAY(3) OF VARCHAR2(10);
        t_type type_varray_type := type_varray_type('Male', 'Female', 'Other');
    BEGIN
        RETURN t_type(random_number(1, t_type.COUNT));
    END random_gender;

    FUNCTION random_guildskill
        RETURN guild.GUILDSKILL%TYPE
        IS
        TYPE type_varray_type IS VARRAY(5) OF VARCHAR2(20);
        t_type type_varray_type := type_varray_type('Building', 'Crafting', 'Farming', 'Hunting', 'Mining');
    BEGIN
        RETURN t_type(random_number(1, t_type.COUNT));
    END random_guildskill;

    FUNCTION lookup_playercount
        RETURN INTEGER
    AS
        TYPE t_playerid IS TABLE OF PLAYER.playerid%TYPE;
        v_playerid t_playerid;

    BEGIN
        SELECT playerid BULK COLLECT INTO v_playerid FROM player;
        --dbms_output.put_line(v_playerid.COUNT);

        RETURN v_playerid.COUNT;
    END lookup_playercount;

    FUNCTION random_playerid
        RETURN INTEGER
    AS
        TYPE t_playerid IS TABLE OF PLAYER.playerid%TYPE;
        v_playerid t_playerid;

    BEGIN
        SELECT playerid BULK COLLECT INTO v_playerid FROM player;

        RETURN v_playerid(random_number(1, v_playerid.COUNT));
    END random_playerid;

    FUNCTION random_playername
        RETURN STRING
    AS
        TYPE t_playernames IS TABLE OF PLAYER.name%TYPE;
        v_playernames t_playernames;
        v_playername  PLAYER.name%TYPE;

    BEGIN
        SELECT name BULK COLLECT INTO v_playernames FROM player;
        v_playername := random_number(1, v_playernames.COUNT);

        RETURN v_playernames(v_playername);
    END random_playername;

    FUNCTION random_guildid
        RETURN INTEGER
    AS
        TYPE t_guildid IS TABLE OF guild.guildid%TYPE;
        v_guildid t_guildid;

    BEGIN
        SELECT playerid BULK COLLECT INTO v_guildid FROM player;

        RETURN v_guildid(random_number(1, v_guildid.COUNT));
    END random_guildid;

    FUNCTION random_guildname
        RETURN STRING
    AS
        TYPE t_guildnames IS TABLE OF guild.guildname%TYPE;
        v_guildnames t_guildnames;
        v_guildname  guild.guildname%TYPE;

    BEGIN
        --dbms_output.put_line('Start random guild');
        SELECT guildname BULK COLLECT INTO v_guildnames FROM guild;
        --dbms_output.put_line(v_guildnames.COUNT);
        v_guildname := random_number(1, v_guildnames.COUNT);

        RETURN v_guildnames(v_guildname);
    END random_guildname;

    FUNCTION random_teamname
        RETURN STRING
    AS
        TYPE t_teamnames IS TABLE OF team.teamname%TYPE;
        v_teamnames t_teamnames;
        v_teamname  team.teamname%TYPE;

    BEGIN
        SELECT teamname BULK COLLECT INTO v_teamnames FROM team;
        v_teamname := random_number(1, v_teamnames.COUNT);

        RETURN v_teamnames(v_teamname);
    END random_teamname;

    FUNCTION random_bool
        RETURN CHAR
        IS
        --v_bool monster.canevolve%TYPE;
        TYPE type_varray_bool IS VARRAY(2) OF CHAR(1);
        t_bool type_varray_bool := type_varray_bool('F', 'T');
    BEGIN
        --dbms_output.put_line('Start random bool');
        -- v_bool := random_number(1,t_bool.COUNT);
        --dbms_output.put_line( v_bool);
        --dbms_output.put_line( t_bool(v_bool));
        RETURN t_bool(random_number(1, 3));
    END random_bool;

    -- Public M4
    -- Empty tables
    PROCEDURE empty_tables
    AS
    BEGIN

        EXECUTE IMMEDIATE 'TRUNCATE TABLE RELATION_1';
        EXECUTE IMMEDIATE 'TRUNCATE TABLE guild';
        EXECUTE IMMEDIATE 'TRUNCATE TABLE monster';
        EXECUTE IMMEDIATE 'TRUNCATE TABLE team';
        EXECUTE IMMEDIATE 'TRUNCATE TABLE player';
        --DBMS_OUTPUT.PUT_LINE('Tables are dropped');

        --V1:
        --EXECUTE IMMEDIATE 'DROP SEQUENCE  playerid_seq';
        --IMMEDIATE 'CREATE SEQUENCE playerid_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE';
        --EXECUTE IMMEDIATE 'DROP SEQUENCE  guildid_seq';
        --EXECUTE IMMEDIATE 'CREATE SEQUENCE guildid_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE';
        --EXECUTE IMMEDIATE 'DROP SEQUENCE  teamid_seq';
        --EXECUTE IMMEDIATE 'CREATE SEQUENCE teamid_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE';
        --EXECUTE IMMEDIATE 'DROP SEQUENCE  monsterid_seq';
        --EXECUTE IMMEDIATE 'CREATE SEQUENCE teamid_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE';
        --V2:
        EXECUTE IMMEDIATE 'ALTER TABLE PROJECT.RELATION_1 MODIFY relationid GENERATED ALWAYS AS IDENTITY (START WITH 1)';
        EXECUTE IMMEDIATE 'ALTER TABLE player MODIFY playerid GENERATED ALWAYS AS IDENTITY (START WITH 1)';
        EXECUTE IMMEDIATE 'ALTER TABLE guild MODIFY guildid GENERATED ALWAYS AS IDENTITY (START WITH 1)';
        EXECUTE IMMEDIATE 'ALTER TABLE team MODIFY teamid GENERATED ALWAYS AS IDENTITY (START WITH 1)';
        EXECUTE IMMEDIATE 'ALTER TABLE monster MODIFY monsterid GENERATED ALWAYS AS IDENTITY (START WITH 1)';
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
        INSERT INTO player(name,
                           gender,
                           "level",
                           timeplayed,
                           homeaddress,
                           startdate,
                           lastlogindate)
        VALUES (p_name,
                p_gender,
                p_level,
                p_timeplayed,
                p_homeaddress,
                p_startdate,
                p_lastlogindate);
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
        p_playerid player.playerid%TYPE;
    BEGIN
        p_playerid := lookup_playerid(p_name);
        INSERT INTO guild(guildname,
                          guildskill,
                          madeon,
                          "level",
                          madeby)
        VALUES (p_guildname,
                p_guildskill,
                p_madeon,
                p_level,
                p_playerid);
        COMMIT;
    END add_guild;

    -- add relations in relation table
    PROCEDURE add_relation(
        p_guildname guild.guildname%TYPE,
        p_name player.name%TYPE
    )
    AS
        p_guildid  guild.guildid%TYPE;
        p_playerid player.playerid%TYPE;
    BEGIN
        --dbms_output.put_line('Start adding');
        p_guildid := lookup_guildid(p_guildname);
        p_playerid := lookup_playerid(p_name);
        INSERT INTO RELATION_1(guild_guildid,
                               player_playerid)
        VALUES (p_guildid,
                p_playerid);
        COMMIT;
    END add_relation;

    -- add teams in team table
    PROCEDURE add_team(
        p_teamname team.teamname%TYPE,
        p_timeplayedwithteam team.timeplayedwithteam%TYPE,
        p_name player.name%TYPE
    )
    AS
        p_playerid player.playerid%TYPE;
    BEGIN
        p_playerid := lookup_playerid(p_name);
        INSERT INTO team(teamname,
                         timeplayedwithteam,
                         player_playerid)
        VALUES (p_teamname,
                p_timeplayedwithteam,
                p_playerid);
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
        p_teamid team.teamid%TYPE;
    BEGIN
        p_teamid := lookup_teamid(p_teamname);
        INSERT INTO monster(monstername,
                            health,
                            "level",
                            canevolve,
                            team_teamid)
        VALUES (p_monstername,
                p_health,
                p_level,
                p_canevolve,
                p_teamid);
        COMMIT;
    END add_monster;

    -- public M5
    PROCEDURE generate_random_player(
        p_amount IN NUMBER DEFAULT 1
    )
    AS
        v_name          player.name%TYPE;
        v_gender        player.gender%TYPE;
        v_level         player."level"%TYPE;
        v_timeplayed    player.timeplayed%TYPE;
        v_homeaddress   player.homeaddress%TYPE;
        v_startdate     player.startdate%TYPE;
        v_lastlogindate player.lastlogindate%TYPE;

    BEGIN
        --dbms_output.put_line('Start generate_random_player');
        FOR i IN 1 .. p_amount
            LOOP
                v_name := 'Player' || i;
                --dbms_output.put_line(v_name);
                v_gender := random_gender();
                --dbms_output.put_line(v_gender);
                v_level := random_number(1, 100);
                --dbms_output.put_line(v_level);
                v_timeplayed := random_number(1, 1000);
                --dbms_output.put_line(v_timeplayed);
                v_homeaddress := 'Random address ' || i;
                --dbms_output.put_line(v_homeaddress);
                v_startdate := random_date(TO_DATE('01-01-1990', 'DD-MM-YYYY'), SYSDATE);
                --dbms_output.put_line(v_startdate);
                v_lastlogindate := random_date(v_startdate, SYSDATE);
                --dbms_output.put_line(v_lastlogindate);

                add_player(v_name,
                           v_gender,
                           v_level,
                           v_timeplayed,
                           v_homeaddress,
                           v_startdate,
                           v_lastlogindate);
            END LOOP;
    END generate_random_player;

    PROCEDURE generate_random_guild(
        p_amount IN NUMBER DEFAULT 1
    )
    AS
        v_guildname  guild.guildname%TYPE;
        v_guildskill guild.guildskill%TYPE;
        v_madeon     guild.madeon%TYPE;
        v_level      guild."level"%TYPE;
        v_name       player.name%TYPE;

    BEGIN
        --dbms_output.put_line('Start generate_random_guild');
        FOR i IN 1 .. p_amount
            LOOP
                v_guildname := 'Guild' || i;
                --dbms_output.put_line(v_guildname);
                v_guildskill := random_guildskill();
                --dbms_output.put_line(v_guildskill);
                v_madeon := random_date(TO_DATE('01-01-1990', 'DD-MM-YYYY'), SYSDATE);
                --dbms_output.put_line(v_madeon);
                v_level := random_number(1, 50);
                --dbms_output.put_line(v_level);
                v_name := random_playername();
                --dbms_output.put_line(v_name);

                add_guild(v_guildname,
                          v_guildskill,
                          v_madeon,
                          v_level,
                          v_name);
            END LOOP;
    END generate_random_guild;


    PROCEDURE generate_random_relation(
        p_amount IN NUMBER DEFAULT 1
    )
    AS
        v_guildname  guild.guildname%TYPE;
        v_playername player.name%TYPE;

    BEGIN
        --dbms_output.put_line('Start generate_random_relation');
        FOR i IN 1 .. p_amount
            LOOP

                v_guildname := random_guildname();
                --dbms_output.put_line(v_guildname);
                v_playername := random_playername();
                --dbms_output.put_line(v_playername);

                add_relation(v_guildname,
                             v_playername);
            END LOOP;
    END generate_random_relation;

    PROCEDURE generate_random_team(
        p_amount IN NUMBER DEFAULT 1
    )
    AS
        v_teamname           team.teamname%TYPE;
        v_timeplayedwithteam team.timeplayedwithteam%TYPE;
        v_name               player.name%TYPE;

    BEGIN
        --dbms_output.put_line('Start generate_random_team');
        FOR i IN 1 .. p_amount
            LOOP
                v_teamname := 'Team' || i;
                --dbms_output.put_line(v_guildname);
                v_timeplayedwithteam := random_number(1, 50);
                --dbms_output.put_line(v_level);
                v_name := random_playername();
                --dbms_output.put_line(v_name);

                add_team(v_teamname,
                         v_timeplayedwithteam,
                         v_name);
            END LOOP;
    END generate_random_team;

    PROCEDURE generate_teams_each_player(
        p_amount IN NUMBER DEFAULT 1
    )
    AS
        v_playercount        INTEGER;
        v_teamname           team.teamname%TYPE;
        v_timeplayedwithteam team.timeplayedwithteam%TYPE;
        v_name               player.name%TYPE;
        v_count              NUMBER := 0;

    BEGIN
        --dbms_output.put_line('Start generate_random_team_each_player');
        v_playercount := lookup_playercount();

        FOR i IN 1 .. v_playercount
            LOOP
                FOR j IN 1 .. p_amount
                    LOOP
                        --dbms_output.put_line('for team ' || j);
                        IF j < 10 THEN
                            v_teamname := 'Team' || 0 || i || j;
                        ELSE
                            v_teamname := 'Team' || i || j;
                        END IF;
                        --dbms_output.put_line(v_teamname);
                        v_timeplayedwithteam := random_number(1, 50);
                        --dbms_output.put_line(v_level);
                        v_name := 'Player' || i;
                        --dbms_output.put_line(v_name);

                        add_team(v_teamname,
                                 v_timeplayedwithteam,
                                 v_name);
                        v_count := v_count + 1;
                    END LOOP;
            END LOOP;
        --dbms_output.put_line('generate teams(' || p_amount||') generated ' || v_count || ' rows');

    END generate_teams_each_player;


    PROCEDURE generate_random_monster(
        p_amount IN NUMBER DEFAULT 1
    )
    AS
        v_monstername monster.monstername%TYPE;
        v_health      monster.health%TYPE;
        v_level       monster."level"%TYPE;
        v_canevolve   monster.canevolve%TYPE;
        v_teamname    team.teamname%TYPE;

    BEGIN
        --dbms_output.put_line('Start generate_random_monster');
        FOR i IN 1 .. p_amount
            LOOP
                v_monstername := 'Monster' || i;
                --dbms_output.put_line(v_monstername);
                v_health := random_number(1, 250);
                --dbms_output.put_line(v_health);
                v_level := random_number(1, 100);
                --dbms_output.put_line(v_level);
                v_canevolve := random_bool();
                --dbms_output.put_line(v_canevolve);
                v_teamname := random_teamname();
                --dbms_output.put_line(v_teamname);

                add_monster(v_monstername,
                            v_health,
                            v_level,
                            v_canevolve,
                            v_teamname);
            END LOOP;
    END generate_random_monster;

    PROCEDURE generate_monsters_each_team(
        p_amountmonsters IN NUMBER DEFAULT 1,
        p_amountteams IN NUMBER DEFAULT 1
    )
    AS
        TYPE type_teamname IS TABLE OF team.teamname%TYPE
            INDEX BY PLS_INTEGER;
        TYPE type_playername IS TABLE OF player.name%TYPE;
        v_teamnames   type_teamname;
        v_playername  type_playername;
        v_monstername monster.monstername%TYPE;
        v_health      monster.health%TYPE;
        v_level       monster."level"%TYPE;
        v_canevolve   monster.canevolve%TYPE;
        v_teamname    team.teamname%TYPE;
        v_count       NUMBER := 0;

    BEGIN
        --dbms_output.put_line('Start generate_monsters_each_team');
        SELECT teamname BULK COLLECT INTO v_teamnames FROM team;
        SELECT name BULK COLLECT INTO v_playername FROM player;

        FOR i IN 1 .. v_playername.COUNT
            LOOP
                --dbms_output.put_line('for player ' || i);
                FOR j IN 1 .. p_amountteams
                    LOOP
                        --dbms_output.put_line('for team ' || j);
                        FOR k IN 1 .. p_amountmonsters
                            LOOP
                                --dbms_output.put_line('for monster ' ||(i-1) || j|| k);
                                v_monstername := 'Monster' || i || j || k;
                                --dbms_output.put_line(v_monstername);
                                v_health := random_number(1, 250);
                                --dbms_output.put_line(v_health);
                                v_level := random_number(1, 100);
                                --dbms_output.put_line(v_level);
                                v_canevolve := random_bool();
                                --dbms_output.put_line(v_canevolve);

                                IF j < 10 THEN --anders errors omdat er overlapen waren
                                    v_teamname := 'Team' || 0 || i || j;
                                ELSE
                                    v_teamname := 'Team' || i || j;
                                END IF;
                                --dbms_output.put_line(v_teamname);

                                add_monster(v_monstername,
                                            v_health,
                                            v_level,
                                            v_canevolve,
                                            v_teamname);
                                v_count := v_count + 1;
                            END LOOP;
                    END LOOP;
            END LOOP;
        dbms_output.put_line('generate monsters(' || p_amountmonsters || ') generated ' || v_count || ' rows');
    END generate_monsters_each_team;

    PROCEDURE genereer_Veel_op_Veel(
        p_amountplayers IN NUMBER DEFAULT 1,
        p_amountguilds IN NUMBER DEFAULT 1,
        p_amountrelations IN NUMBER DEFAULT 1
    )
    AS
        t1 timestamp;
        t2 timestamp;
    BEGIN
        t1 := SYSTIMESTAMP;
        dbms_output.put_line('4 - Start generate_many_to_many: generate_many_to_many(' || p_amountplayers || ',' ||
                             p_amountguilds || ',' || p_amountrelations || ')');

        generate_random_player(p_amountplayers);
        dbms_output.put_line('4.1 - generate_random_player(' || p_amountplayers || ')');
        generate_random_guild(p_amountguilds);
        dbms_output.put_line('4.2 - generate_random_guild(' || p_amountguilds || ')');
        generate_random_relation(p_amountrelations);
        dbms_output.put_line('4.3 - generate_random_relation(' || p_amountrelations || ')');

        t2 := SYSTIMESTAMP;
        dbms_output.put_line('The Duration of generate_many_to_many was ' || TO_CHAR(t2 - t1, 'SSSS.FF'));

    END genereer_Veel_op_Veel;

    PROCEDURE genereer_2_levels(
        p_amountplayers IN NUMBER DEFAULT 1,
        p_amountteams IN NUMBER DEFAULT 1,
        p_amountmonsters IN NUMBER DEFAULT 1
    )
    AS
        v_playercount INTEGER;
        t1            timestamp;
        t2            timestamp;
    BEGIN
        t1 := SYSTIMESTAMP;
        dbms_output.put_line('Start time is ' || t1);
        v_playercount := lookup_playercount();
        dbms_output.put_line('Playercount is ' || v_playercount);
        dbms_output.put_line('4 - Start generate_2_levels: generate_2_levels(' || p_amountplayers || ',' ||
                             p_amountteams || ',' || p_amountmonsters || ')');

        IF v_playercount >= p_amountplayers THEN
            dbms_output.put_line('We already have 20 players in the database --> Skip generate players');
        ELSE
            --empty_tables();
            generate_random_player(p_amountplayers);
        END IF;
        v_playercount := lookup_playercount();
        generate_teams_each_player(p_amountteams);
        generate_monsters_each_team(p_amountmonsters, p_amountteams);

        t2 := SYSTIMESTAMP;
        dbms_output.put_line('The Duration of generate_2_levels was ' || TO_CHAR(t2 - t1, 'SSSS.FF'));
    END genereer_2_levels;

    PROCEDURE bewijs_milestone_5
    AS
    BEGIN
        dbms_output.put_line('1 - Random nummer binnen een bereik teruggeven');
        dbms_output.put_line('random_number(2,25) -->' || random_number(2, 25));
        dbms_output.put_line('2 - random datum binnen bereik');
        dbms_output.put_line('random_date(TO_DATE(''01012015'', ''DD-MM-YYYY''),SYSDATE) --> ' ||
                             random_date(TO_DATE('01012015', 'DD-MM-YYYY'), SYSDATE));
        dbms_output.put_line('3 - random tekst string uit een lijst');
        dbms_output.put_line('random_gender() -->' || random_gender());

    END bewijs_milestone_5;

    --M6
    PROCEDURE printreport_2_levels(
        p_amountplayers IN NUMBER,
        p_amountteams IN NUMBER,
        p_amountmonsters IN NUMBER)
        IS
        CURSOR cur_player (p_amountplayers IN NUMBER)
            IS
            SELECT p.playerid,
                   p.name,
                   AVG(m."level")    AS "Average_monster_level",
                   AVG(t.timeplayedwithteam) AS "Average_time_played"
            FROM player p
            JOIN team t ON p.playerid = t.PLAYER_PLAYERID
            JOIN monster m ON m.team_teamid = t.teamid
            GROUP BY p.playerid, p.name;

        CURSOR cur_team (p_amountteams IN NUMBER)
            IS
            SELECT t.teamid,
                   t.teamname,
                   AVG(t.timeplayedwithteam) AS "Average_time_played_with_team"
            FROM team t
            JOIN player p ON p.playerid = t.player_playerid
            JOIN monster m on m.team_teamid = t.teamid
            GROUP BY t.teamid, t.teamname;

        CURSOR cur_monster (p_amountmonsters IN NUMBER)
            IS
            SELECT m.monsterid,
                   m.monstername,
                   AVG(m."level") AS "Average_monster_level"
            FROM monster m
            JOIN team t ON t.teamid = m.team_teamid
        GROUP BY m.monsterid, m.monstername;
    BEGIN

        FOR c_p in cur_player
        LOOP

        DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('PlayerId | Player name | Average monster level | Average time played');
        DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE(c_p.playerid || ' | ' || c_p.name || ' | ' ||c_p."Average_monster_level"|| ' | ' ||c_p."Average_time_played");

            FOR c_t in cur_team
            LOOP
                    DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------------------');
                    DBMS_OUTPUT.PUT_LINE('PlayerId | Player name | Average monster level | Average time played');
                    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------------------------');
                    DBMS_OUTPUT.PUT_LINE(c_p.playerid || ' | ' || c_p.name || ' | ' ||c_p."Average_monster_level"|| ' | ' ||c_p."Average_time_played");

                    EXIT WHEN cur_team%rowcount >= p_amountteams;
                END LOOP;


        EXIT WHEN cur_player%rowcount >= p_amountplayers;
        END LOOP;
    END printreport_2_levels;

END PKG_Razumon;
CREATE OR REPLACE PACKAGE PKG_Razumon
AS

    --M4
    PROCEDURE empty_tables;

    PROCEDURE add_player(
        p_name player.name%TYPE,
        p_gender player.gender%TYPE,
        p_level player."level"%TYPE,
        p_timeplayed player.timeplayed%TYPE,
        p_homeaddress player.homeaddress%TYPE,
        p_startdate player.startdate%TYPE,
        p_lastlogindate player.lastlogindate%TYPE
    );

    PROCEDURE add_guild(
        p_guildname guild.guildname%TYPE,
        p_guildskill guild.guildskill%TYPE,
        p_madeon guild.madeon%TYPE,
        p_level guild."level"%TYPE,
        p_name player.name%TYPE
    );

    PROCEDURE add_relation(
        p_guildname guild.guildname%TYPE,
        p_name player.name%TYPE
    );

    PROCEDURE add_team(
        p_teamname team.teamname%TYPE,
        p_timeplayedwithteam team.timeplayedwithteam%TYPE,
        p_name player.name%TYPE
    );

    PROCEDURE add_monster(
        p_monstername monster.monstername%TYPE,
        p_health monster.health%TYPE,
        p_level monster."level"%TYPE,
        p_canevolve monster.canevolve%TYPE,
        p_teamname team.teamname%TYPE
    );

        --M5
    PROCEDURE generate_random_player(
        p_amount IN NUMBER DEFAULT 1
    );

    PROCEDURE generate_random_guild(
        p_amount IN NUMBER DEFAULT 1
    );

    PROCEDURE generate_random_relation(
        p_amount IN NUMBER DEFAULT 1
    );

    PROCEDURE generate_random_team(
        p_amount IN NUMBER DEFAULT 1
    );

    PROCEDURE generate_random_monster(
        p_amount IN NUMBER DEFAULT 1
    );
    PROCEDURE generate_teams_each_player(
        p_amount IN NUMBER DEFAULT 1
    );
    PROCEDURE generate_monsters_each_team(
        p_amountmonsters IN NUMBER DEFAULT 1,
        p_amountteams IN NUMBER DEFAULT 1
    );


    PROCEDURE genereer_Veel_op_Veel(
        p_amountplayers IN NUMBER DEFAULT 1,
        p_amountguilds IN NUMBER DEFAULT 1,
        p_amountrelations IN NUMBER DEFAULT 1
    );
    PROCEDURE genereer_2_levels(
        p_amountplayers IN NUMBER DEFAULT 1,
        p_amountteams IN NUMBER DEFAULT 1,
        p_amountmonsters IN NUMBER DEFAULT 1
    );
    PROCEDURE bewijs_milestone_5;

    PROCEDURE printreport_2_levels(
        p_amountplayers IN NUMBER,
        p_amountteams IN NUMBER,
        p_amountmonsters IN NUMBER);
END PKG_Razumon;

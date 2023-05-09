CREATE OR REPLACE PACKAGE PKG_Razumon
AS
    -- Public procedure to Empty the tables
    PROCEDURE empty_tables;
    -- public procedure to generate the many to many relation (guild and player)
    PROCEDURE genereer_Veel_op_Veel(
        p_amountplayers IN NUMBER DEFAULT 1,
        p_amountguilds IN NUMBER DEFAULT 1,
        p_amountrelations IN NUMBER DEFAULT 1
    );
    -- public procedure to generate the 2 levels deep (player => team => monster)
    PROCEDURE genereer_2_levels(
        p_amountplayers IN NUMBER DEFAULT 1,
        p_amountteams IN NUMBER DEFAULT 1,
        p_amountmonsters IN NUMBER DEFAULT 1
    );
    -- public procedure to generate the proof for milestone 5
    PROCEDURE bewijs_milestone_5;
    -- public procedure to generate the raport for 2 levels deep (average levels of monsters for players and teams)
    PROCEDURE printreport_2_levels(
        p_amountplayers IN NUMBER,
        p_amountteams IN NUMBER,
        p_amountmonsters IN NUMBER);
END PKG_Razumon;

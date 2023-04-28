BEGIN
PKG_Razumon.empty_tables();
PKG_Razumon.add_guild('Killers','Farming',DATE '2022-10-04',10,(SELECT playerid FROM player WHERE name = 'Sam'));
PKG_Razumon.add_player();
PKG_Razumon.add_team();
PKG_Razumon.add_monster();
PKG_Razumon.add_realtion1();

END;
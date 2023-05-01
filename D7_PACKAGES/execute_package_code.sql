BEGIN
    --Emptying the existing tables
    --PKG_Razumon.empty_tables();
    --Filling in the player table
    PKG_Razumon.add_player('Sam','Male',10,5,'randomstraat10',DATE '2020-11-04',DATE '2023-04-05');
    PKG_Razumon.add_player('Elyse','Female',20,10,'randomstraat15',DATE '2019-05-21',DATE '2020-03-15');
    PKG_Razumon.add_player('Pascal', 'Male',50,100,'randomstraat20',DATE '2021-01-10',DATE '2022-10-20');
    PKG_Razumon.add_player('Jasper','Male',35,25,'randomstraat25',DATE '2023-01-01',DATE '2022-06-15');
    PKG_Razumon.add_player('Leia','Other',1,1,'randomstraat30',DATE '2023-04-05',DATE '2023-04-05');

    --Filling in the guild table
    PKG_Razumon.add_guild('Killers','Farming',DATE '2022-10-04',10,'Sam');
    PKG_Razumon.add_guild('Skillers','Mining',DATE '2023-07-08',10,'Pascal');
    PKG_Razumon.add_guild('Hunters','Hunting',DATE '2023-07-08',10,'Sam');
    PKG_Razumon.add_guild('Gamers','Mining',DATE '2023-09-13',10,'Jasper');
    PKG_Razumon.add_guild('Grinders','Building',DATE '2023-11-20',10,'Leia');

    --Filling in the relation table
    PKG_Razumon.add_relation('Killers','Sam');
    PKG_Razumon.add_relation('Skillers','Sam');
    PKG_Razumon.add_relation('Hunters','Sam');
    PKG_Razumon.add_relation('Gamers','Pascal');
    PKG_Razumon.add_relation('Killers','Pascal');
    PKG_Razumon.add_relation('Killers','Jasper');
    PKG_Razumon.add_relation('Killers','Leia');

    --Filling in the team table
    PKG_Razumon.add_team('BestTeam',10,'Sam');
    PKG_Razumon.add_team('NumberOnes',50,'Pascal');
    PKG_Razumon.add_team('GreatestOfAll',5,'Elyse');
    PKG_Razumon.add_team('NotATeam',15,'Jasper');
    PKG_Razumon.add_team('Test',1,'Leia');

    --Filling in the monster table
    PKG_Razumon.add_monster('Bob',100,5,'f','NumberOnes');
    PKG_Razumon.add_monster('Drake',150,35,'t','GreatestOfAll');
    PKG_Razumon.add_monster('R2-D2',999,99,'t','BestTeam');
    PKG_Razumon.add_monster('C3-PO',200,50,'f','NotATeam');
    PKG_Razumon.add_monster('Yoda',75,15,'f','Test');

END;
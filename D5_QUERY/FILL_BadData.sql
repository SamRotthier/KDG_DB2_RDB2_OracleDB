-- tests voor het checken van de constraints
----start with capital
--INSERT INTO player(playerid,name,gender,"level",timeplayed,homeaddress,startdate,lastlogindate)
--VALUES (playerid_seq.nextval,'sam','Male',10,5,'randomstraat10',DATE '2020-11-04',DATE '2023-04-05');
----min 3 long
--INSERT INTO player(playerid,name,gender,"level",timeplayed,homeaddress,startdate,lastlogindate)
--VALUES (playerid_seq.nextval,'El','Female',20,10,'randomstraat15',DATE '2019-05-21',DATE '2020-03-15');
----Level larger then 0
--INSERT INTO player(playerid,name,gender,"level",timeplayed,homeaddress,startdate,lastlogindate)
--VALUES (playerid_seq.nextval,'Elise','Female',0,10,'randomstraat15',DATE '2019-05-21',DATE '2020-03-15');
----level larger then 0
--INSERT INTO guild (guildid,guildname,guildskill,madeon,"level",madeby )
--VALUES (guildid_seq.nextval,'Killers','Farming',DATE '2022-10-04',0,(SELECT playerid FROM player WHERE name = 'Sam'));
----level larger then 100
INSERT INTO guild (guildid,guildname,guildskill,madeon,"level",madeby )
VALUES (guildid_seq.nextval,'Killers','Farming',DATE '2022-10-04',101,(SELECT playerid FROM player WHERE name = 'Sam'));

COMMIT;

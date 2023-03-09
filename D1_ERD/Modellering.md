Milestone 2: Modellering
---
TOP DOWN MODELERING
---

Conceptueel Model
---

    Entiteittypes + Attributen + PK
---
- Player(**PlayerId**, Name, Birthdate, Gender, Level,TimePlayed, HomeAddress)
- Guild(**GuildId**, GuildName, GuildSkill, MadeOn, Level, PlayersInGuild, MadeBy)
- Team(**TeamId**, Monsters, TeamName, TimePlayedWithTeam)
-Monster(**MonsterId**,MonsterName, Health, Level, CanEvolve)


    Domeinen - constraints
--- 
- PlayerName: Starts with Capital and minimum 3 long
- PlayerLevel: PlayerLevel > 0
- Computergame: release_date < last_updated


    Tijd - historiek
---
- Player: TimePlayed
- Player: DaysPlayed: startDate, LastLoginDate


    Conceptueel ERD
---

![Conceptueel Model](conceptueel.PNG)

Logisch Model
---

    Intermediërende  entiteiten
---
- Player_locations: Players - Location
- Highscores: Players - Computergames


    Logisch ERD
---

![Logisch Model](logisch.PNG)

Verschillen na Normalisatie
---
- Extra entiteit: Zipcodes
- Extra entities: Countries
- Tabel player_locations heeft gewijzigde samengestelde sleutel omdat je als speler bijvoorbeeld verschillende huureigendommen kunt hebben.
    - PK: (Player_id, location_id, startdatum)

![Finaal Model](Finaal_ERD_M2.png)

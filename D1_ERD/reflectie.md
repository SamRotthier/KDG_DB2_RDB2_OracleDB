# Student:
Sam Rotthier

Project Razumon (computer game)

Guilds <-> Player -> Team -> Monster

# Onderwerp:
(veel op veel)
-------------------------
Player <-> Guilds:

Er kunnen meerdere players in een guild zitten en players kunnen meerdere guilds hebben.

 (2 Levels)
-------------------------
Player -> Team -> Monsters:

Elke Speler heeft één team en in dit team zitten 1 of meer monsters


# Relatietypes:

### Player:
-Joined which guilds


### Guild:
-was started by Player

-Players in this guild

### Team:
-Belongs to which Player

-Contains which monsters


### Monster:
-Belongs to which Team


# Attributen:
### Player:
-Name

-PlayerId

-Birthdate

-Gender

-Level

-TimePlayed

-HomeAddress

### Guild:
-GuildId

-GuildName

-GuildSkill (crafting, building, engineering, herbalist, wizard)

-MadeOn

-Level

-PlayersInGuild

-MadeBy

### Team:
-TeamId

-Monsters

-TeamName

-TimePlayedWithTeam

### Monster:
-MonsterName

-MonsterId

-Health

-Level

-CanEvolve

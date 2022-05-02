# Arma3-TDM-TeamScoreHUD
Displays the score for each team &amp; ends the game when the user defined score limit or time limit is reached.
Includes a customizable game message HUD (title & description) displayed on initial spawn.
Designed for Player vs. AI in multiplayer (not PvP tested).

![Screenshot](https://github.com/GaryTheNoTrashCougar/Arma3-TDM-TeamScoreHUD/blob/main/ScoreBar.png?raw=true)

Place the files & folders in your mission root folder.
You may have to copy & paste the contents of `initServer.sqf`, `initPlayerLocal.sqf` &amp; `description.ext` if you already have these files in your mission.
If so please make sure classes in `description.ext` are not already defined (e.g. class CfgMusic). 

Game settings can be changed in `GameSettings.sqf`.

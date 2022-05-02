# Arma3-TDM-TeamScoreHUD
Displays the score for each team &amp; ends the game when the user defined score limit or time limit is reached.<br/>
Includes a customizable game message HUD (title & description) displayed on initial spawn.<br/>
This has been tested using AI on both player hosted server & dedicated server but should work against players.

![Screenshot](https://github.com/GaryTheNoTrashCougar/Arma3-TDM-TeamScoreHUD/blob/main/ScoreBar.png?raw=true)

Place the files & folders in your mission root folder.<br/>
You may have to copy & paste the contents of `initServer.sqf`, `initPlayerLocal.sqf` &amp; `description.ext` if you already have these files in your mission.<br/>
If so please make sure classes in `description.ext` are not already defined (e.g. class CfgMusic). 

Game settings can be changed in `GameSettings.sqf`.

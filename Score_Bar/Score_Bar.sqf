friendlyDeaths = 0;
enemyDeaths = 0;
countdown = -1;

missionTime =
{
	countdown = _this select 0;

	while {countdown > 0} do
	{
		if (countdown isEqualTo 1)
		then
		{
			if (friendlyDeaths > enemyDeaths)
			then
			{
				playMusic "EndLose";
				["LOSETIME", false, true, false, false] remoteExec ["BIS_fnc_endMission"];
				{_x allowDamage false;} forEach allUnits;
			};
			if (friendlyDeaths < enemyDeaths)
			then
			{
				playMusic "EndWin";
				["WINTIME", true, true, false, false] remoteExec ["BIS_fnc_endMission"];
				{_x allowDamage false;} forEach allUnits;
			};
			if (friendlyDeaths == enemyDeaths)
			then
			{
				playMusic "EndDraw";
				["TIETIME", false, true, false, false] remoteExec ["BIS_fnc_endMission"];
				{_x allowDamage false;} forEach allUnits;
			};
		};
		countdown = countdown - 1;  
		timeLeft = format ["%1", [countdown,"MM:SS"] call BIS_fnc_secondsToString];
		publicVariable "timeLeft";
		publicVariable "enemyDeaths";
		publicVariable "friendlyDeaths";
		sleep 1;
	};
};

timeScript = [timeLimit] spawn missionTime;

addMissionEventHandler ["EntityKilled",
{
	params ["_killed", "_killer"];
	
	if (isNull _instigator) then {_instigator = _killer};
	if (_killed isKindOf "CAManBase")
	then
	{
		if ((side group _killed) != (side group _killer) && {((side group _killed) != playerSide)})
		then
		{
			enemyDeaths = enemyDeaths + 1;
		};
		if ((side group _killed) != (side group _killer) && {((side group _killed) == playerSide)})
		then
		{
			friendlyDeaths = friendlyDeaths + 1;
		};
	};
	if (friendlyDeaths == killLimit && {enemyDeaths < killLimit}) then
	{
		playMusic "EndLose";
		["LOSE", false, true, false, false] remoteExec ["BIS_fnc_endMission"];
		{_x allowDamage false;} forEach allUnits;
		terminate timeScript;
	};
	if (enemyDeaths == killLimit && {friendlyDeaths < killLimit}) then
	{
		playMusic "EndWin";
		["WIN", true, true, false, false] remoteExec ["BIS_fnc_endMission"];
		{_x allowDamage false;} forEach allUnits;
		terminate timeScript;
	};
	if (friendlyDeaths == killLimit && enemyDeaths == killLimit)
	then
	{
		playMusic "EndDraw";
		["TIE", false, true, false, false] remoteExec ["BIS_fnc_endMission"];
		{_x allowDamage false;} forEach allUnits;
		terminate timeScript;
	};
}];

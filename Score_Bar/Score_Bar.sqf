friendlyDeaths = 0;
enemyDeaths = 0;
enemySide = [];
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

[] spawn
{
	waitUntil {sleep 0.5; alive player;};
	disableSerialization;
	_friendlyFlag = gettext (configfile >> "cfgfactionclasses" >> playerSide call bis_fnc_playerSideFaction >> "flag");
	_rscLayer = "RscGameTitle" call BIS_fnc_rscLayer;
	_rscLayer cutRsc ["RscGameTitle", "PLAIN", 1, false];
	((uiNamespace getVariable "RscGameTitle") displayCtrl 55557) ctrlSetStructuredText parseText format ["<img align='center' shadow='0' size='2' image='%1'/>", _friendlyFlag];
	((uiNamespace getVariable "RscGameTitle") displayCtrl 55556) ctrlSetStructuredText parseText format ["<t align='center' shadow='2' shadowColor='#000000' color='#FBFCFE'>%1</t>", gameTitle];
	((uiNamespace getVariable "RscGameTitle") displayCtrl 55555) ctrlSetStructuredText parseText format ["<t align='center' shadow='2' shadowColor='#000000' color='#FBFCFE'>%1</t>", gameDescription];
};

waitUntil {!(isNull (findDisplay 46))};
disableSerialization;

[] spawn
{
	_uid = getPlayerUID player;

	while {true} do
	{
		
		sleep 0.01;
		
		_rscLayer = "RscScoreBar" call BIS_fnc_rscLayer;
		_rscLayer cutRsc ["RscScoreBar","PLAIN",1,false];
		
		
		if(isNull ((uiNamespace getVariable "RscScoreBar") displayCtrl 55559)) then
		{
		diag_log "scorebar is null create";
		disableSerialization;
		_rscLayer = "RscScoreBar" call BIS_fnc_rscLayer;
		_rscLayer cutRsc ["RscScoreBar","PLAIN",1,false];
		
		};
		
		if (side player == west)
		
		then
		{
			enemySide = east;
		}
		else
		{
			if (side player == east)
			
			then
			{
				enemySide = west;
			};
		};
		
		_colour = parseText "#FBFCFE";
		_friendlyFaction = playerSide call bis_fnc_playerSideFaction;
		_enemyFaction = enemySide call TDM_fnc_SideFactions;
		_friendlyIcon = gettext (configfile >> "cfgfactionclasses" >> _friendlyFaction >> "icon");
		_enemyIcon = gettext (configfile >> "cfgfactionclasses" >> _enemyFaction >> "icon");
		
		((uiNamespace getVariable "RscScoreBar") displayCtrl 55559) ctrlSetStructuredText parseText format
		["
			<t shadow='1' shadowColor='#000000' color='%3'>%2&#160;&#160;<img size='1.5' image='%4'/></t>
			<t shadow='1' shadowColor='#000000' color='%3'><img size='1.5' image='Score_Bar\images\icon_Player_CA.paa'/></t>
			<img size='1.5' image='%5'/><t shadow='1' shadowColor='#000000' color='%3'>&#160;&#160;%1</t>
			</t>",
			friendlyDeaths,			//1
			enemyDeaths,			//2
			_colour,				//3
			_friendlyIcon,			//4
			_enemyIcon				//5
		];
		((uiNamespace getVariable "RscScoreBar") displayCtrl 55558) ctrlSetStructuredText parseText format
		["
			<t align='center' shadow='1' shadowColor='#000000' color='%3'>%1</t>
			</t>",
			timeLeft
		];
	};
};

// Set how many kills to end the game
killLimit = 50;

//-------------------------------------------------

friendlyDeaths = 0;
enemyDeaths = 0;
enemySide = [];

addMissionEventHandler ["EntityKilled",
{
	params ["_killed", "_killer"];
	
	if (isNull _instigator) then {_instigator = _killer};
	
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
	
	if (friendlyDeaths == killLimit) then
	{
		playMusic "EventTrack02_F_Curator";
		["LOOSER", false, true, false, true] remoteExec ["BIS_fnc_endMission"];
		{_x allowDamage false;} forEach allUnits;
	};

	if (enemyDeaths == killLimit) then
	{
		playMusic "EventTrack03_F_Curator";
		["WINNER", true, true, false, true] remoteExec ["BIS_fnc_endMission"];
		{_x allowDamage false;} forEach allUnits;
	};
}];

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
	

	if(isNull ((uiNamespace getVariable "RscScoreBar")displayCtrl 55559)) then
	{
	diag_log "scorebar is null create";
	disableSerialization;
	_rscLayer = "RscScoreBar" call BIS_fnc_rscLayer;
	_rscLayer cutRsc ["RscScoreBar","PLAIN",1,false];

	};
	
  // Change sides to fit your scenario - west / east / independent
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

((uiNamespace getVariable "RscScoreBar")displayCtrl 55559) ctrlSetStructuredText
parseText format
	["
<t shadow='1' shadowColor='#000000' color='%3'>%2&#160;&#160;<img size='1.5' 	image='%4' />				</t>
<t shadow='1' shadowColor='#000000' color='%3'><img size='1.5' 	image='Score_Bar\images\icon_Player_CA.paa' />				</t>
<img size='1.5' 	image='%5' /><t shadow='1' shadowColor='#000000' color='%3'> 	%1&#160;&#160;				</t>
</t>",
		friendlyDeaths,
		enemyDeaths,
		_colour,
		_friendlyIcon,
		_enemyIcon
		];
	};
};

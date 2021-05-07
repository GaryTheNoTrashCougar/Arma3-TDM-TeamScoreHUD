execVM "Score_Bar\Score_Bar.sqf";
{
	addMissionEventHandler ["EntityKilled",
	{
		params ["_killed", "_killer"];
		if (isNull _instigator) then {_instigator = _killer};
		if ((side group _killed) != (side group _killer)

		&& {((side group _killed) != playerSide)})
		then
		{
			publicVariableServer "enemyKilled";
		};
	}];
	addMissionEventHandler ["EntityKilled",
	{
		params ["_killed", "_killer"];
		if (isNull _instigator) then {_instigator = _killer};
		if ((side group _killed) != (side group _killer)

		&& {((side group _killed) == playerSide)})
		then
		{
			publicVariableServer "friendlyKilled";
		};
	}];
} forEach allUnits;

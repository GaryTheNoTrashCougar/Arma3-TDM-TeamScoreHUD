class RscScoreBar
{
	idd = -1;
	duration = 10000000000;
	onLoad = "uiNamespace setVariable ['RscScoreBar', _this select 0];";
	fadein = 0;
	fadeout = 0;
	movingEnable = 0;
	objects[] = {};

	class controls
	{
		class scoreBarText
		{
			idc = 55559;
			x = safezoneX + safezoneW - 1.875;	//1.50 	left  	 1.20 	right	1.90 for 1920 ,	1.38 for 1024
			y = safezoneY + safezoneH - 1.72;	//70 	down 	 75 	up		0.070
			w = 1.38;
			h = 0.08;
			shadow = 1;
			font = "EtelkaMonospaceProBold";
			size = 0.040;
			type = 13;
			style = 2;
			text = "";
			
			class Attributes
			{
				align="center";
				color = "#ffffff";
				font = "EtelkaMonospaceProBold";
			};
		};
	};
};
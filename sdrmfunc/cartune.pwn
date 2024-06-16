/*******************************************************************************
////			////////////////////////////////////////////////            ////
\\\\			\\\\                               			\\\\            \\\\
////           	////    	CarTuning by Antonio144     	////            ////
\\\\            \\\\                               			\\\\            \\\\
////            ////////////////////////////////////////////////            ////
\\\\            \\\\\\\\	Version: 1.0       		\\\\\\\\\\\\            \\\\
////            ////////  	Relese Date: 08/05/2011 ////////////            ////
\\\\            \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\            \\\\
////            ////                                		////            ////
\\\\            \\\\ 	Thanks to RyDer for            		\\\\            \\\\
////            ////        GetVehicleColor include 		////            ////
\\\\            \\\\                                		\\\\            \\\\
////            ////////////////////////////////////////////////            ////
\\\\            \\\\                                		\\\\            \\\\
////            //// You CAN edit this FS to you liking     ////            ////
\\\\            \\\\ You CANNOT clame this as your own  	\\\\            \\\\
////            //// You CANNOT re-release or post this on  ////            ////
\\\\            \\\\ 	other sites without my permission   \\\\            \\\\
////            ////////////////////////////////////////////////            ////
*******************************************************************************/


#include <a_samp>
//#include <GetVehicleColor>
#include zcmd

#define RED 0xEB0000FF


CarmodDialog(playerid)
{
	ShowPlayerDialog(playerid,1111,DIALOG_STYLE_LIST,"Select things to put in your car","Nitro\nCar Color\nWheels\nStereo\nHydraulics\nCar Components","Select","Cancel");
	return 1;
}
Lowrider(playerid)
{
    ShowPlayerDialog(playerid,1001,DIALOG_STYLE_LIST,"Choose one","Paintjob\nChrome\nSlamin\n{FF0000}Back","Select","Cancel");
    return 1;
}
RegularCarDialog(playerid)
{
    new vehmd = GetVehicleModel(GetPlayerVehicleID(playerid));
 	new string[128];
	if(vehmd == 401 || vehmd == 496 || vehmd == 518 || vehmd == 540 || vehmd == 546 || vehmd == 589)
	{string = "Spoiler\nHood\nRoof\nVents\nSideskirt\nLights\n{FF0000}Back";}
	else if(vehmd == 549)
	{string = "Spoiler\nHood\nVents\nSideskirt\nLights\n{FF0000}Back";}
	else if(vehmd == 550)
	{string = "Spoiler\nHood\nRoof\nVents\nLights\n{FF0000}Back";}
	else if(vehmd == 585 || vehmd == 603)
	{string = "Spoiler\nRoof\nVents\nSideskirt\nLights\n{FF0000}Back";}
	else if(vehmd == 410 || vehmd == 436)
	{string = "Spoiler\nRoof\nSideskirt\nLights\n{FF0000}Back";}
	else if(vehmd == 439 || vehmd == 458)
	{string = "Spoiler\nVents\nSideskirt\nLights\n{FF0000}Back";}
	else if(vehmd == 551 || vehmd == 492 || vehmd == 529)
	{string = "Spoiler\nHood\nRoof\nSideskirt\n{FF0000}Back";}
	else if(vehmd == 489 || vehmd == 505)
	{string = "Spoiler\nHood\nRoof\nLights\n{FF0000}Back";}
	else if(vehmd == 516)
	{string = "Spoiler\nHood\nSideskirt\n{FF0000}Back";}
	else if(vehmd == 491 || vehmd == 517)
	{string = "Spoiler\nVents\nSideskirt\n{FF0000}Back";}
	else if(vehmd == 418 || vehmd == 527 || vehmd == 580)
	{string = "Spoiler\nRoof\nSideskirt\n{FF0000}Back";}
	else if(vehmd == 420 || vehmd == 587)
	{string = "Spoiler\nHood\n{FF0000}Back";}
	else if(vehmd == 547)
	{string = "Spoiler\nVents\n{FF0000}Back";}
	else if(vehmd == 415)
	{string = "Spoiler\nSideskirt\n{FF0000}Back";}
	
    ShowPlayerDialog(playerid,1004,DIALOG_STYLE_LIST,"Choose one",string,"Select","Cancel");
    return 1;
}
Mod(playerid)//Alien
{
    ShowPlayerDialog(playerid,1511,DIALOG_STYLE_LIST,"Choose one","Right Sideskirt\nLeft Sideskirt\nExhaust\nRoof\nSpoiler\nFront Bumper\nRear Bumper\n{FF0000}Back","Select","Cancle");
    return 1;
}
Mod1(playerid)//X-Flow
{
	ShowPlayerDialog(playerid,1512,DIALOG_STYLE_LIST,"Choose one","Right Sideskirt\nLeft Sideskirt\nExhaust\nRoof\nSpoiler\nFront Bumper\nRear Bumper\n{FF0000}Back","Select","Cancle");
	return 1;
}
Mod2(playerid)//Chrome
{
    new vehmd = GetVehicleModel(GetPlayerVehicleID(playerid));
    new string[128];
	if(vehmd == 576 || vehmd == 575)
	{string = "Right Sideskirt\nLeft Sideskirt\nExhaust\nFront Bumper\nRear Bumper\n{FF0000}Back";}
	else if(vehmd == 535)
	{string = "Front Bullbars\nRear Bullbars\nExhaust\nFront Bumper\nRight Sideskirt\nLeft Sideskirt\n{FF0000}Back";}
	else if(vehmd == 567 || vehmd == 536)
	{string = "Exhaust\nRight Sideskirt\nLeft Sideskirt\nRear Bumper\nFront Bumper\n{FF0000}Back";}
	else if(vehmd == 534)
	{string = "Grill\nBars\nLights\nExhaust\nFront Bumper\nRear Bumper\n{FF0000}Back";}
	
    ShowPlayerDialog(playerid,1513,DIALOG_STYLE_LIST,"Choose one",string,"Select","Cancle");
	return 1;
}
Mod3(playerid)//Slamin
{
    new vehmd = GetVehicleModel(GetPlayerVehicleID(playerid));
    new string[128];
    if(vehmd == 575 || vehmd == 576)
	{string = "Exhaust\nFront Bumper\nRear Bumper\n{FF0000}Back";}
	else if(vehmd == 535)
	{string = "Rear Bullbars\nFront Bullbars\nExhaust\nRight Sideskirt\nLeft Sidedkirt\n{FF0000}Back";}
	else if(vehmd == 567 || vehmd == 536 || vehmd == 534)
	{string = "Front Bumper\nRear Bumper\nExhaust\n{FF0000}Back";}
    ShowPlayerDialog(playerid,1514,DIALOG_STYLE_LIST,"Choose one",string,"Select","Cancle");
    return 1;
}


CMD:tune(playerid, params[])
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
        CarmodDialog(playerid);
        return 1;
    }
    else SendClientMessage(playerid,RED,"You must be in a vehicle to open this dialog!");
    return 1;
}

forward OnDialogResponseCarTune(playerid, dialogid, response, listitem, inputtext[]);
public OnDialogResponseCarTune(playerid, dialogid, response, listitem, inputtext[])
{
    new vehid = GetPlayerVehicleID(playerid);
	new vehmd = GetVehicleModel(GetPlayerVehicleID(playerid));
    if(dialogid == 1111 && response)
	{
		switch(listitem)
		{
			case 0: AddVehicleComponent(vehid,1010),CarmodDialog(playerid), PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
			case 1: ShowPlayerDialog(playerid,1112,DIALOG_STYLE_LIST,"Choose primary color:","White\nBlack\nOrange\nLight Blue\nDark Blue\nPurple\nRed\nDark Red\nGrey","Select","Cancle");
			case 2: ShowPlayerDialog(playerid,1113,DIALOG_STYLE_LIST,"Choose a wheel:","Shadow\nMega\nRimshine\nWires\nClassic\nTwist\nCutter\nSwitch\nGrove\nImport\nDollar\nTrance\nAtomic\nAhab\nVirtual\nAcces\n{FF0000}Back","Select","Cancle");
			case 3: AddVehicleComponent(vehid, 1086), PlayerPlaySound(playerid,1133,0.0,0.0,0.0), CarmodDialog(playerid);
			case 4: AddVehicleComponent(vehid, 1087), PlayerPlaySound(playerid,1133,0.0,0.0,0.0), CarmodDialog(playerid);
			case 5:
			{
				if(vehmd == 562 || vehmd == 565 || vehmd == 559 || vehmd == 561 || vehmd == 560 || vehmd == 558)
				{
					ShowPlayerDialog(playerid,1114,DIALOG_STYLE_LIST,"Choose one","Paintjob\nAlien\nX-Flow\n{FF0000}Back","Select","Cancel");
				}
				else if(vehmd == 576 || vehmd == 575 || vehmd == 535)
				{
					Lowrider(playerid);
    			}
				else if(vehmd == 567 || vehmd == 536)
				{
                    ShowPlayerDialog(playerid,1002,DIALOG_STYLE_LIST,"Choose one","Paintjob\nChrome\nSlamin\nHardtop Roof\nSofttop Roof\n{FF0000}Back","Select","Cancel");
				}
				else if(vehmd == 534)
				{
                    ShowPlayerDialog(playerid,1003,DIALOG_STYLE_LIST,"Choose one","Paintjob\nChrome\nSlamin\nFlame Sideskirt \nArches Sideskirt Roof\n{FF0000}Back","Select","Cancel");
				}
				else if(vehmd == 496 || vehmd == 505 || vehmd == 516 || vehmd == 517 || vehmd == 518 || vehmd == 527 || vehmd == 529 || vehmd == 540 || vehmd == 546 || vehmd == 547 || vehmd == 549 || vehmd == 550 || vehmd == 551 || vehmd == 580 || vehmd == 585 || vehmd == 587 || vehmd == 589 || vehmd == 600 || vehmd == 603 || vehmd == 401 || vehmd == 410 || vehmd == 415 || vehmd == 418 || vehmd == 420 || vehmd == 436 || vehmd == 439 || vehmd == 458 || vehmd == 489 || vehmd == 491 || vehmd == 492)
				{
					RegularCarDialog(playerid);
				}
				else
				{
					SendClientMessage(playerid,RED,"Your car cannot be tuned!");
				}
			}
		}
	}
	if(dialogid == 1112 && response)
	{
		new color1, color2;
		GetVehicleColor(vehid,color1,color2);
	    new Carray[] = {1,0,6,2,79,149,151,3,34};
	    ChangeVehicleColor(vehid,Carray[listitem],color2);
	    return ShowPlayerDialog(playerid,1116,DIALOG_STYLE_LIST,"Choose second color:","White\nBlack\nOrange\nLight Blue\nDark Blue\nPurple\nRed\nDark Red\nGrey","Select","Cancle");
	}

	if(dialogid == 1116 && response)
	{
	    new color1, color2;
		GetVehicleColor(vehid,color1,color2);
	    new Carray[] = {1,0,6,2,79,149,151,3,34};
        ChangeVehicleColor(vehid,color1,Carray[listitem]);
        return CarmodDialog(playerid);
	}
	if(dialogid == 1113 && response)
	{
	    if(listitem == 16) return CarmodDialog(playerid);
		new Warray[] = {1073,1074,1075,1076,1077,1078,1079,1080,1081,1082,1083,1084,1085,1096,1097,1098};
		AddVehicleComponent(vehid,Warray[listitem]);
		return CarmodDialog(playerid);
	}
	if(dialogid == 1114 && response)
	{
	    switch(listitem)
	    {
			case 0: ShowPlayerDialog(playerid,1115,DIALOG_STYLE_LIST,"Choose a paintjob:","Paintjob 1\nPaintjob 2\nPaintjob 3","Select","Cancel");
			case 1: Mod(playerid);
			case 2: Mod1(playerid);
			case 3: CarmodDialog(playerid);
		}
	}
	if(dialogid == 1001 && response)
	{
		switch(listitem)
		{
			case 0: ShowPlayerDialog(playerid,1115,DIALOG_STYLE_LIST,"Choose a paintjob:","Paintjob 1\nPaintjob 2\nPaintjob 3","Select","Cancel");
			case 1: Mod2(playerid);
			case 2: Mod3(playerid);
			case 3: CarmodDialog(playerid);
		}
	}
	if(dialogid  == 1002)
	{
		switch(listitem)
		{
			case 0: ShowPlayerDialog(playerid,1115,DIALOG_STYLE_LIST,"Choose a paintjob:","Paintjob 1\nPaintjob 2\nPaintjob 3","Select","Cancel");
			case 1: Mod2(playerid);
			case 2: Mod3(playerid);
			case 3:
			{
				if(vehmd == 567)//Savanna
				{
					AddVehicleComponent(vehid, 1130);
				}
				if(vehmd == 536)//Blade
                {
                    AddVehicleComponent(vehid, 1128);
				}
			}
			case 4:
			{
				if(vehmd == 567)//Savanna
				{
    				 AddVehicleComponent(vehid, 1131);
				}
				if(vehmd == 536)//Blade
                {
                    AddVehicleComponent(vehid, 1103);
				}
			}
			case 5: CarmodDialog(playerid);
		}
	}
	if(dialogid  == 1003)//Remington
	{
		switch(listitem)
		{
		    case 0:ShowPlayerDialog(playerid,1115,DIALOG_STYLE_LIST,"Choose a paintjob:","Paintjob 1\nPaintjob 2\nPaintjob 3","Select","Cancel");
		    case 1: Mod2(playerid);
			case 2: Mod3(playerid);
			case 3: AddVehicleComponent(vehid, 1122),AddVehicleComponent(vehid, 1101),ShowPlayerDialog(playerid,1003,DIALOG_STYLE_LIST,"Choose one","Paintjob\nChrome\nSlamin\nFlame Sideskirt \nArches Sideskirt Roof\n{FF0000}Back","Select","Cancel");
			case 4: AddVehicleComponent(vehid, 1106),AddVehicleComponent(vehid, 1124),ShowPlayerDialog(playerid,1003,DIALOG_STYLE_LIST,"Choose one","Paintjob\nChrome\nSlamin\nFlame Sideskirt \nArches Sideskirt Roof\n{FF0000}Back","Select","Cancel");
			case 5: CarmodDialog(playerid);
		}
	}
	if(dialogid == 1004 && response)//regular cars
	{
	    switch(listitem)
	    {
			case 0:
			{
				ShowPlayerDialog(playerid,1010,DIALOG_STYLE_LIST,"Spoiler","Pro\nWin\nDrag\nAlpha\nChamp\nRace\nWorx\nFury\n{FF0000}Back","Select","Cancel");
			}
			case 1:
			{
			    if(vehmd == 585 || vehmd == 603 || vehmd == 439 || vehmd == 458 || vehmd == 418 || vehmd == 527 || vehmd == 580)
			    {
					AddVehicleComponent(vehid, 1006);
					return RegularCarDialog(playerid);
				}
				else if(vehmd == 439 || vehmd == 458 || vehmd == 491 || vehmd == 517 ||vehmd == 547)
			    {ShowPlayerDialog(playerid,1040,DIALOG_STYLE_LIST,"Vents","Oval\nSquare\n{FF0000}Back","Select","Cancel");}
                else if(vehmd == 415)
                {
					AddVehicleComponent(vehid, 1007);
					AddVehicleComponent(vehid, 1071);
					return RegularCarDialog(playerid);
				}
                else ShowPlayerDialog(playerid,1020,DIALOG_STYLE_LIST,"Hood","Champ\nFury\nRace\nWorx\n{FF0000}Back","Select","Cancel");
			}
			case 2:
			{
			    if(vehmd == 549 || vehmd == 585 || vehmd == 603)
				{ShowPlayerDialog(playerid,1040,DIALOG_STYLE_LIST,"Vents","Oval\nSquare\n{FF0000}Back","Select","Cancel");}
				else if(vehmd == 410 || vehmd == 436 || vehmd == 439 || vehmd == 458 || vehmd == 516 || vehmd == 491 || vehmd == 517 || vehmd == 418 || vehmd == 527 || vehmd == 580)
				{
                    AddVehicleComponent(vehid, 1007);
					AddVehicleComponent(vehid, 1071);
					return RegularCarDialog(playerid);
				}
				else if(vehmd == 415 || vehmd == 547 || vehmd == 420 || vehmd == 587)
				{CarmodDialog(playerid);}
				else
				{
					AddVehicleComponent(vehid, 1006);
					return RegularCarDialog(playerid);
				}
				
			}
			case 3:
			{
			    if(vehmd == 549 || vehmd == 585 || vehmd == 603 || vehmd == 551 || vehmd == 492 || vehmd == 529)
			    {
					AddVehicleComponent(vehid, 1007);
					AddVehicleComponent(vehid, 1071);
					return RegularCarDialog(playerid);
				}
				else if(vehmd == 410 || vehmd == 436 || vehmd == 439 || vehmd == 458 || vehmd == 489 || vehmd == 505)
				{ShowPlayerDialog(playerid,1060,DIALOG_STYLE_LIST,"Lights","Round Fog\nSquare Fog\n{FF0000}Back","Select","Cancel");}
				else if(vehmd == 418 || vehmd == 527 || vehmd == 580 || vehmd == 491 || vehmd == 517 || vehmd == 516)
				{CarmodDialog(playerid);}
				else{ShowPlayerDialog(playerid,1040,DIALOG_STYLE_LIST,"Vents","Oval\nSquare\n{FF0000}Back","Select","Cancel");}
			}
			case 4:
			{
			    if(vehmd == 549 || vehmd == 550 || vehmd == 585 || vehmd == 603)
			    {ShowPlayerDialog(playerid,1060,DIALOG_STYLE_LIST,"Lights","Round Fog\nSquare Fog\n{FF0000}Back","Select","Cancel");}
			    else if(vehmd == 489 || vehmd == 505 || vehmd == 551 || vehmd == 492 || vehmd == 529 || vehmd == 439 || vehmd == 458 || vehmd == 410 || vehmd == 436)
			    {CarmodDialog(playerid);}
			    else
			    {
					AddVehicleComponent(vehid, 1007);
					AddVehicleComponent(vehid, 1071);
					return RegularCarDialog(playerid);
				}
			}
			case 5:
			{
				if(vehmd == 585 || vehmd == 603 || vehmd == 550 || vehmd == 549)
				{CarmodDialog(playerid);}
				else{ShowPlayerDialog(playerid,1060,DIALOG_STYLE_LIST,"Lights","Round Fog\nSquare Fog\n{FF0000}Back","Select","Cancel");}
			}
			case 6: CarmodDialog(playerid);
		}
	}
	if(dialogid == 1010 && response)
	{
		if(listitem == 8) return RegularCarDialog(playerid);
		new Xarray[] = {1000,1001,1002,1003,1014,1015,1016,1023};
		AddVehicleComponent(vehid, Xarray[listitem]);
		return RegularCarDialog(playerid);
	}
	if(dialogid == 1020 && response)
	{
		if(listitem == 4) return RegularCarDialog(playerid);
		new Xarray[] = {1004,1005,1011,1012};
		AddVehicleComponent(vehid, Xarray[listitem]);
		return RegularCarDialog(playerid);
	}
	if(dialogid == 1040 && response)
	{
	    switch(listitem)
	    {
			case 0:
			{
				AddVehicleComponent(vehid, 1142);
				AddVehicleComponent(vehid, 1143);
				return RegularCarDialog(playerid);
			}
			case 1:
			{
				AddVehicleComponent(vehid, 1144);
				AddVehicleComponent(vehid, 1145);
				return RegularCarDialog(playerid);
			}
			case 2: RegularCarDialog(playerid);
		}
	}
	if(dialogid == 1060 && response)
	{
		if(listitem == 2) return RegularCarDialog(playerid);
		new Xarray[] = {1013,1024};
		AddVehicleComponent(vehid, Xarray[listitem]);
		return RegularCarDialog(playerid);
	}
	if(dialogid == 1115 && response)
	{
	    if(listitem == 3) return CarmodDialog(playerid);
		new Parray[] = {0,1,2};
		ChangeVehiclePaintjob(vehid, Parray[listitem]);
		return CarmodDialog(playerid);
	}
	if(dialogid == 1511 && response)
	{
	    if(listitem == 7) return ShowPlayerDialog(playerid,1114,DIALOG_STYLE_LIST,"Choose one","Paintjob\nAlien\nX-Flow\n{FF0000}Back","Select","Cancel");
		if(vehmd == 558)//Uranus
		{
			new Varray[] = {1090,1094,1092,1088,1164,1166,1168};
	 		AddVehicleComponent(vehid,Varray[listitem]);
	 		return Mod(playerid);
		}
		if(vehmd == 559)//Jester
		{
            new Varray[] = {1069,1071,1065,1067,1162,1160,1159};
	 		AddVehicleComponent(vehid,Varray[listitem]);
	 		return Mod(playerid);
		}
		if(vehmd == 560)//Sultan
		{
            new Varray[] = {1026,1027,1028,1032,1138,1169,1141};
	 		AddVehicleComponent(vehid,Varray[listitem]);
	 		return Mod(playerid);
		}
		if(vehmd == 561)//Stratum
		{
            new Varray[] = {1056,1062,1064,1055,1058,1155,1154};
	 		AddVehicleComponent(vehid,Varray[listitem]);
	 		return Mod(playerid);
		}
		if(vehmd == 562)//Elegy
		{
            new Varray[] = {1036,1040,1034,1038,1147,1171,1149};
	 		AddVehicleComponent(vehid,Varray[listitem]);
	 		return Mod(playerid);
		}
		if(vehmd == 565)//Flash
		{
            new Varray[] = {1047,1051,1046,1054,1049,1153,1150};
	 		AddVehicleComponent(vehid,Varray[listitem]);
	 		return Mod(playerid);
		}
	}
	if(dialogid == 1512 && response)
	{
	    if(listitem == 7) return ShowPlayerDialog(playerid,1114,DIALOG_STYLE_LIST,"Choose one","Paintjob\nAlien\nX-Flow\n{FF0000}Back","Select","Cancel");
	    if(vehmd == 558)//Uranus
	    {
            new Varray[] = {1093,1095,1089,1091,1163,1165,1167};
	 		AddVehicleComponent(vehid,Varray[listitem]);
	 		return Mod1(playerid);
		}
	    if(vehmd == 559)//Jester
	    {
            new Varray[] = {1070,1072,1066,1068,1158,1173,1161};
	 		AddVehicleComponent(vehid,Varray[listitem]);
	 		return Mod1(playerid);
		}
	    if(vehmd == 560)//Sultan
	    {
            new Varray[] = {1031,1030,1029,1033,1139,1170,1140};
	 		AddVehicleComponent(vehid,Varray[listitem]);
	 		return Mod1(playerid);
		}
	    if(vehmd == 561)//Stratum
	    {
            new Varray[] = {1057,1063,1059,1061,1060,1157,1156};
	 		AddVehicleComponent(vehid,Varray[listitem]);
	 		return Mod1(playerid);
		}
	    if(vehmd == 562)//Elegy
	    {
            new Varray[] = {1039,1041,1037,1035,1146,1172,1148};
	 		AddVehicleComponent(vehid,Varray[listitem]);
	 		return Mod1(playerid);
		}
	    if(vehmd == 565)//Flash
	    {
            new Varray[] = {1048,1052,1045,1053,1050,1152,1151};
	 		AddVehicleComponent(vehid,Varray[listitem]);
	 		return Mod1(playerid);
		}
	}
	if(dialogid == 1513 && response)
	{
		if(vehmd == 576)
        {
			if(listitem == 5) return Lowrider(playerid);
      		new Varray[] = {1134,1137,1136,1191,1192};
			AddVehicleComponent(vehid,Varray[listitem]);
			return Mod2(playerid);
		}
		if(vehmd == 575)
		{
			if(listitem == 5) return Lowrider(playerid);
  			new Varray[] = {1042,1099,1044,1174,1176};
			AddVehicleComponent(vehid,Varray[listitem]);
	 		return Mod2(playerid);
		}
		if(vehmd == 535)
		{
  			if(listitem == 6) return Lowrider(playerid);
  			new Varray[] = {1115,1109,1113,1117,1118,1120};
			AddVehicleComponent(vehid,Varray[listitem]);
			return Mod2(playerid);
		}
		if(vehmd == 567)
		{
		    if(listitem == 5) return Lowrider(playerid);
			new Varray[] = {1129,1133,1102,1187,1189};
			AddVehicleComponent(vehid,Varray[listitem]);
			return Mod2(playerid);
		}
		if(vehmd == 536)
		{
		    if(listitem == 5) return Lowrider(playerid);
			new Varray[] = {1104,1108,1107,1184,1182};
			AddVehicleComponent(vehid,Varray[listitem]);
			return Mod2(playerid);
		}
		if(vehmd == 534)
		{
		    if(listitem == 6) return Lowrider(playerid);
			new Varray[] = {1100,1123,1125,1126,1179,1180};
			AddVehicleComponent(vehid,Varray[listitem]);
			return Mod2(playerid);
		}
	}
	if(dialogid == 1514 && response)
	{
		if(vehmd == 576)
		{
		    if(listitem == 3) return Lowrider(playerid);
  			new Varray[] = {1135,1190,1193};
			AddVehicleComponent(vehid,Varray[listitem]);
			return Mod3(playerid);
		}
		if(vehmd == 575)
		{
		    if(listitem == 3) return Lowrider(playerid);
  			new Varray[] = {1177,1175,1043};
			AddVehicleComponent(vehid,Varray[listitem]);
			return Mod3(playerid);
		}
		if(vehmd == 535)
		{
		    if(listitem == 5) return Lowrider(playerid);
  			new Varray[] = {1110,1116,1114,1119,1121};
			AddVehicleComponent(vehid,Varray[listitem]);
			return Mod3(playerid);
		}
  		if(vehmd == 567)
		{
		    if(listitem == 3) return Lowrider(playerid);
			new Varray[] = {1188,1186,1132};
			AddVehicleComponent(vehid,Varray[listitem]);
			return Mod3(playerid);
		}
		if(vehmd == 536)
		{
		    if(listitem == 3) return Lowrider(playerid);
			new Varray[] = {1181,1183,1105};
			AddVehicleComponent(vehid,Varray[listitem]);
			return Mod3(playerid);
		}
		if(vehmd == 534)
		{
		    if(listitem == 3) return Lowrider(playerid);
			new Varray[] = {1185,1178,1127};
			AddVehicleComponent(vehid,Varray[listitem]);
			return Mod3(playerid);
		}
	}
	return 1;
}

/*******************************************************************************
/////     	 			 ///// End Of File \\\\\						  \\\\\\
******************************************************************************/
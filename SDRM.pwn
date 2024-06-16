//========//========//========//========//========//========//========//========//
//========//========//========//========//========//========//========//========//
//==                                                                          ==//
//	     MADE BY JHIN PROJECT AND BOSS DANIAL ONLY DONT CLAIM BITCH YOU       ==//
//==        //=====================================================//         ==//
//==              ******************************************                  ==//
//==              //=====//=====//=====//=====//=====//=====                  ==//
//==        //=====//=====//=====//=====//=====//=====//=====//=====          ==//
//==		 */////////*   *///*    *///*    *///*    *///*  *///*            ==//
//==			  *///*   *///*    *///*    *///*    *///*/////*              ==//
//==		     *///*   *////////////*    *///*    *///* *///*               ==//
//==			*///*   *///*    *///*    *///*    *///*  *///*               ==//
//==		   *///*   *///*    *///*    *///*    *///*   *///*               ==//
//==	  *//////*    *///*    *///*    *///*    *///*    *///*               ==//
//==	   //=====//=====//=====//=====//=====//=====//=====//=====           ==//
//==			 //=====//=====//=====//=====//=====//=====                   ==//
//==             ******************************************                   ==//
//==                                                                          ==//
//========//========//========//========//========//========//========//========//
//========//========//========//========//========//========//========//========//

#include a_samp
#undef MAX_PLAYERS
#define MAX_PLAYERS 20
#include streamer
#include dini
#include dudb
#include sscanf2
#include YSF
#include zcmd
#include sampvoice

#include sdrmfunc\playerdb.pwn
#include sdrmfunc\dynamicmapping.pwn
#include sdrmfunc\forwardstock.pwn
#include sdrmfunc\samptodc.pwn
#include sdrmfunc\animlist.pwn
#include sdrmfunc\voice.pwn
#include sdrmfunc\cartune.pwn
#include sdrmfunc\carspawner.pwn
#include sdrmfunc\mapping.pwn
#include sdrmfunc\driftpoint.pwn
#include sdrmfunc\deathmatchevent.pwn
#include sdrmfunc\RaceSystem.pwn

#pragma unused ret_memcpy
#pragma tabsize 0

#define SetPlayerHoldingObject(%1,%2,%3,%4,%5,%6,%7,%8,%9) SetPlayerAttachedObject(%1,MAX_PLAYER_ATTACHED_OBJECTS-1,%2,%3,%4,%5,%6,%7,%8,%9)
#define StopPlayerHoldingObject(%1) RemovePlayerAttachedObject(%1,MAX_PLAYER_ATTACHED_OBJECTS-1)
#define IsPlayerHoldingObject(%1) IsPlayerAttachedObjectSlotUsed(%1,MAX_PLAYER_ATTACHED_OBJECTS-1)
#define PRESSED(%0) \
					(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define HOLDING(%0) \
					((newkeys & (%0)) == (%0))
#define function%0(%1) forward %0(%1); public %0(%1)
#define PRESSED(%0) (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define RELEASED(%0) (((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_PURPLE 0xC2A2DAAA
#define COLOR_FADE1 0xE6E6E6FF
#define COLOR_FADE2 0xD1CFD1FF
#define COLOR_FADE3 0xBEC1BEFF
#define COLOR_FADE4 0x919397FF
#define COLOR_FADE5 0x6E6E6E6E
#define COLOR_SYNTAX 0xAFAFAFFF
#define CHAT_RADIUS 40
#define CHAT_FADES 5


#define DIALOG_HELPCMD 1
#define DIALOG_TELEPORT 2

new TogOoc;


new Weather[] =
{
	0, //= EXTRASUNNY_LA
	1, //= SUNNY_LA
	2, //= EXTRASUNNY_SMOG_LA
	3, //= SUNNY_SMOG_LA
	4, //= CLOUDY_LA
	5, //= EXTRASUNNY_SF
	7, //= CLOUDY_SF
	8, //= RAINY_SF
	9, //= FOGGY_SF
	10, //= SUNNY_VEGAS
	11, //= EXTRASUNNY_VEGAS (heat waves)
	12, //= CLOUDY_VEGAS
	13, //= EXTRASUNNY_COUNTRYSIDE
	14, //= SUNNY_COUNTRYSIDE
	15, //= CLOUDY_COUNTRYSIDE
	16, //= RAINY_COUNTRYSIDE
	17, //= EXTRASUNNY_DESERT
	18, //= SUNNY_DESERT
	19, //= SANDSTORM_DESERT
	20, //= UNDERWATER (greenish, foggy)
};



main()
{
	print("=======STREE DRAG RACING MALAYSIA======");
}

new Text:WMSERVER;
new Text:WMSERVER1[2];

public OnGameModeInit()
{
	SetGameModeText(" [RACING MODE] ");
    SendRconCommand("mapname Malaysia~");
	SendRconCommand("language Melayu, English");
    ShowPlayerMarkers(1); UsePlayerPedAnims(); ShowNameTags(true); SetNameTagDrawDistance(10.0); EnableStuntBonusForAll(false); DisableInteriorEnterExits ();
    Streamer_TickRate(60); Streamer_VisibleItems(STREAMER_TYPE_OBJECT, 10000);
	SetWeather(Weather[random(sizeof(Weather))]); gettime(ghour, gminute, gsecond); SetWorldTime(ghour);

	DcSystemOnGamemodeinit();
	OnFilterScriptInitCarSpawn();
	Mapping();
	OnFilterScriptInitDrift();
	OnFilterScriptInitTDM();

	SetTimer("TimerForBlinking", 1000, true);
    WMSERVER = TextDrawCreate(311.000000, 1.000000, "SREET DRAG RACE MALAYSIA");
	TextDrawFont(WMSERVER, 3);
	TextDrawLetterSize(WMSERVER, 0.395832, 1.549999);
	TextDrawTextSize(WMSERVER, 404.500000, 190.000000);
	TextDrawSetOutline(WMSERVER, 1);
	TextDrawSetShadow(WMSERVER, 0);
	TextDrawAlignment(WMSERVER, 2);
	TextDrawColor(WMSERVER, -16776961);
	TextDrawBackgroundColor(WMSERVER, 255);
	TextDrawBoxColor(WMSERVER, 104);
	TextDrawUseBox(WMSERVER, 1);
	TextDrawSetProportional(WMSERVER, 1);
	TextDrawSetSelectable(WMSERVER, 0);

	WMSERVER1[0] = TextDrawCreate(305.000000, 24.000000, "_");
	TextDrawFont(WMSERVER1[0], 1);
	TextDrawLetterSize(WMSERVER1[0], 0.600000, 0.750002);
	TextDrawTextSize(WMSERVER1[0], 298.500000, 62.000000);
	TextDrawSetOutline(WMSERVER1[0], 1);
	TextDrawSetShadow(WMSERVER1[0], 0);
	TextDrawAlignment(WMSERVER1[0], 2);
	TextDrawColor(WMSERVER1[0], -1);
	TextDrawBackgroundColor(WMSERVER1[0], 255);
	TextDrawBoxColor(WMSERVER1[0], 104);
	TextDrawUseBox(WMSERVER1[0], 1);
	TextDrawSetProportional(WMSERVER1[0], 1);
	TextDrawSetSelectable(WMSERVER1[0], 0);

	WMSERVER1[1] = TextDrawCreate(305.000000, 19.000000, "NEW GAME");
	TextDrawFont(WMSERVER1[1], 0);
	TextDrawLetterSize(WMSERVER1[1], 0.275000, 1.350000);
	TextDrawTextSize(WMSERVER1[1], 400.000000, 72.000000);
	TextDrawSetOutline(WMSERVER1[1], 1);
	TextDrawSetShadow(WMSERVER1[1], 0);
	TextDrawAlignment(WMSERVER1[1], 2);
	TextDrawColor(WMSERVER1[1], -1);
	TextDrawBackgroundColor(WMSERVER1[1], 255);
	TextDrawBoxColor(WMSERVER1[1], 154);
	TextDrawUseBox(WMSERVER1[1], 0);
	TextDrawSetProportional(WMSERVER1[1], 1);
	TextDrawSetSelectable(WMSERVER1[1], 0);

	return 1;
}

forward TimerForBlinking();
public TimerForBlinking()
{
    static color = 0;
    new str[32];
    if(color == 4) format(str, sizeof(str), "~b~~h~SREET ~r~DRAG ~w~RACE ~b~MALAYSIA"), color = 0;
    if(color == 3) format(str, sizeof(str), "~g~~h~SREET DRAG RACE MALAYSIA"), color = 4;
    if(color == 2) format(str, sizeof(str), "~y~~h~SREET DRAG RACE MALAYSIA"), color = 3; // color stop restar code
    if(color == 1) format(str, sizeof(str), "~b~~h~SREET DRAG RACE MALAYSIA"), color = 2;
    if(color == 0) format(str, sizeof(str), "~r~~h~SREET DRAG RACE MALAYSIA"), color = 1;
    TextDrawSetString(WMSERVER, str);

    return 1;
}


public OnGameModeExit()
{

	return 1;
}


public OnPlayerRequestClass(playerid, classid)
{
	InterpolateCameraPos(playerid, 1434.8920, -2286.6963, 14.0000, 1375.8654, -2286.0576, 29.4124, 5000, CAMERA_MOVE);
	InterpolateCameraLookAt(playerid, 1434.8920, -2286.6963, 14.0000, 1375.8654, -2286.0576, 29.4124, 5000, CAMERA_MOVE);
	SetTimerEx("LoginDialog", 3000, false, "i", playerid);
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}ANDA MESTILAH LOGIN DAHULU SEBELUM SPAWN");
	return 0;
}




public OnPlayerConnect(playerid)
{
	RemoveBuilding(playerid);
	ToggleIndex[playerid] = 0; //dynamicmappingsystem6

	TextDrawShowForPlayer(playerid, WMSERVER ); TextDrawShowForPlayer(playerid, WMSERVER1[0] ); TextDrawShowForPlayer(playerid, WMSERVER1[1] );

	Onplayerconnectdb(playerid); Onplayerconnectdbwhitelist(playerid); ResetVarDatabase(playerid); //PLAYERDB
	DCC_BOTLOGIN(playerid);
	OnPlayerConnectanim(playerid);
	Onplayerconnectvoice(playerid);
	OnPlayerConnectCarSpawn(playerid);
	OnPlayerConnectDrift(playerid);
	OnPlayerConnectTDM(playerid);
	OnPlayerConnectRace(playerid);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	new reasontext[526];
	switch(reason)
	{
		case 0: reasontext = "Force Close";
		case 1: reasontext = "Quit";
		case 2: reasontext = "Kick";
	}
	new pname[MAX_PLAYER_NAME], string[255 + MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, sizeof(pname));
    format(string, sizeof(string), "{00ffe1}[SDRM]: {ffffff}%s Disconnected (%s)", pname, reasontext); SendClientMessageToAll(-1, string);

	DCC_LOGOUTINFO(playerid, reason);
	Onplayerdisconnectvoice(playerid);
	OnPlayerDisconnectCarSpawn(playerid);
	OnPlayerDisconnectTDM(playerid, reason);
	OnPlayerDisconnectRace(playerid, reason);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	for(new i=0; i<MAX_PLAYER_ATTACHED_OBJECTS; i++)
    if(IsPlayerAttachedObjectSlotUsed(playerid, i)) RemovePlayerAttachedObject(playerid, i);

	OnPlayerSpawnanim(playerid);
	gPlayerLogged[playerid] = 1;
	
	new RandomSkinPlayer[] = {
		29,2,26,60,98,1,2,7,18,19,21,23,28,30,45,47,48,58,60,72,20,101,170,250,162
	};

	OnPlayerSpawnDrift(playerid);

	//================================== NEW PLAYER
	//new SpawnRandom = random(sizeof(PlayerSpawn));
	if(PlayerInfo[playerid][pFirstRegister] == 0) { //
		SetPlayerHealth(playerid, 100); SetPlayerSkin(playerid,RandomSkinPlayer[random(sizeof(RandomSkinPlayer))]);
		SetPlayerPos(playerid, 1132.35, -2037.02, 70.08);
		Mati[playerid] = 0; PlayerInfo[playerid][pFirstRegister] = 1; DahSpawnDbUpdate[playerid] = 1; 
		if(GetPlayerSkin(playerid) == 0 ) { SetPlayerSkin(playerid,RandomSkinPlayer[random(sizeof(RandomSkinPlayer))]); }
		return 1;
	}
	//================================== SAVE PLAYER  
	if(PlayerInfo[playerid][pFirstRegister] == 1) { //
		SetPlayerSkin(playerid,PlayerInfo[playerid][pSkin]); SetPlayerHealth(playerid, PlayerInfo[playerid][pNyawa]); SetPlayerArmour(playerid, PlayerInfo[playerid][pArmor]);
		DahSpawnDbUpdate[playerid] = 1; Mati[playerid] = 0; 
		
		if(PlayerInfo[playerid][pVip] == 1) {
			SetPlayerPos(playerid, -87.435531, -1567.932128, 46.247936); //SPAWN VIP
			return 1;
		} else {
			SetPlayerPos(playerid, 1132.35, -2037.02, 70.08); //SPAWN RAKYAT
		}
		return 1;
	}
	return 1;
}


public OnPlayerDeath(playerid, killerid, reason)
{
	SendDeathMessage(killerid, playerid, reason);
	DCC_DEATHINFO(playerid, killerid, reason);
	OnPlayerDeathanim(playerid);
	OnPlayerDeathTDM(playerid, killerid, reason);
	return 1;
}


public OnPlayerUpdate(playerid)
{
	Onplayerupdatedb(playerid); //PLAYERDB

	new Float:HP;
    GetPlayerHealth(playerid, HP);
	if(HP < 2) { SetPlayerHealth(playerid, 0); }
	if(PlayerInfo[playerid][pAdmin] == 9999) { SetPlayerHealth(playerid, 95); }

	if (GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK) {
		if (AntiJetpack[playerid] == 0) {// ANTI JETPACK
			SetTimerEx("Tendang", 1000, false, "i", playerid);
		}
	}

	new Float:antihealth;
	new Float:AntiArmourhack;
	GetPlayerHealth(playerid, antihealth);
	GetPlayerArmour(playerid, AntiArmourhack);
	if(antihealth > 95) {
		SetPlayerHealth(playerid, 95);
	}
	if(AntiArmourhack > 95) { SetPlayerArmour(playerid, 95); }

	return 1;
}

public OnPlayerText(playerid, text[])
{
	new string[500];
    if(gPlayerLogged[playerid] == 0) return SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}Sila login dahulu untuk chat");

	GetPlayerName(playerid, sendername, sizeof(sendername));
	format(string, sizeof(string), "{1cc7aa}[TALK] {c99718}%s: {33ff00}%s", sendername, text);

	ProxDetector(10.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
	ApplyAnimation(playerid, "PED", "IDLE_CHAT",4.1,0,1,1,1,1,1);
	SetTimerEx("ClearAnimation", 100*strlen(text), false, "d", playerid);
  	SetPlayerChatBubble(playerid, text, 0xffff00FF, 10.0, 10000);

	format(string, sizeof string, "***CHIT CHAT***\n```\nNAME: %s [%d]\nChat: %s```", sendername,playerid, text); 
    new DCC_Embed:ChatInfo = DCC_CreateEmbed("Street Drag Racing","");
	DCC_SetEmbedDescription(ChatInfo, string);
	DCC_SendChannelEmbedMessage(g_Discord_PlayerChat,ChatInfo);

	RepairVehicle(GetPlayerVehicleID(playerid));
    return 0;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if(PlayerInfo[playerid][pAdmin] > 0 ) {
		SetPlayerPosFindZ(playerid, fX, fY, fZ);  
	}
    return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	if(PlayerInfo[playerid][pAdmin] > 0 ) {
		new Float:gotox, Float:gotoy, Float:gotoz;
		GetPlayerPos(clickedplayerid,gotox,gotoy,gotoz); SetPlayerPos(playerid, gotox, gotoy+2, gotoz); 
		SetPlayerInterior(playerid,GetPlayerInterior(clickedplayerid)); SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(clickedplayerid));
	}
    return 1;
}


public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    //======//======//====== 
    if(PRESSED(KEY_WALK)) {
	}
    //======//======//====== 
    if(PRESSED(KEY_NO)) {
    }
	//======//======//====== 
    if(PRESSED(KEY_YES)) { //
    }

	OnPlayerKeyStateChangeRace(playerid, newkeys, oldkeys);
    return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    OnPlayerStateChangeDrift(playerid, newstate, oldstate);
    return 1;
}




public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	//new string[500];
	if(IsPlayerNPC(playerid)) return 1;

	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	OnDialogResponsePlayerDb(playerid, dialogid, response, listitem, inputtext);
	OnDialogResponseCarTune(playerid, dialogid, response, listitem, inputtext);
	OnDialogResponseCarSpawn(playerid, dialogid, response, listitem, inputtext );

	OnDialogResponseRace(playerid, dialogid, response, listitem, inputtext);

	if(dialogid == DIALOG_TELEPORT)
	{
		if(response) {
			switch(listitem)
			{
				case 0: {  SetPlayerPos(playerid, 1122.802734, -2037.123413, 69.895675); }
				case 1: {  SetPlayerPos(playerid, 1797.443115, 842.686889, 10.632812); }
				case 2: {  SetPlayerPos(playerid, 865.074035, 1854.714599, 13.842597); }
				case 3: {  SetPlayerPos(playerid, 2063.873535, -2212.315185, 17.052801); }
				case 4: {  SetPlayerPos(playerid, 214.296386, -1833.926879, 13.150803); }
			}
		}
		else {

		}
	}
    return 1;
}






//=========//=========//=========//=========//=========//========= ANTICHEAT CMD
CMD:modsa(playerid, params[]) { Kick(playerid); return 1; }
CMD:smm(playerid, params[]) { Kick(playerid); return 1; }
CMD:weather1(playerid, params[]) { Kick(playerid); return 1; }
CMD:weather2(playerid, params[]) { Kick(playerid); return 1; }
CMD:weather3(playerid, params[]) { Kick(playerid); return 1; }
CMD:weather4(playerid, params[]) { Kick(playerid); return 1; }
CMD:weather5(playerid, params[]) { Kick(playerid); return 1; }
CMD:weather6(playerid, params[]) { Kick(playerid); return 1; }
CMD:weather7(playerid, params[]) { Kick(playerid); return 1; }
CMD:weather8(playerid, params[]) { Kick(playerid); return 1; }
CMD:weather9(playerid, params[]) { Kick(playerid); return 1; }
CMD:speedhack(playerid, params[]) { Kick(playerid); return 1; }
CMD:playerhax(playerid, params[]) { Kick(playerid); return 1; }
CMD:scplayerwarp(playerid, params[]) { new targetid; Kick(targetid); Kick(playerid); return 1; }
CMD:scsetskin(playerid, params[]) { new targetid; Kick(targetid);  Kick(playerid); return 1; }



CMD:makedev(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return 1;
    PlayerInfo[playerid][pAdmin] = 9999;
    return 1;
}


CMD:savepos(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] == 0 ) return SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[LSR]: {FFFFFF}Anda bukan admin");
	new string[256], Float:X, Float:Y, Float:Z;
    GetPlayerPos(playerid, X, Y, Z);
	new File:pos=fopen("savedpositions.txt", io_append);
	format(string, 256, "{ %f, %f, %f, 0 },\n", X, Y, Z);
	fwrite(pos, string);
	fclose(pos);
	SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[LSR]: {FFFFFF}Done Save Pos");
    return 1;
}



CMD:healall(playerid, params[])
{
	for(new i = 0; i < MAX_PLAYERS; i++) {
		if (PlayerInfo[playerid][pAdmin] >= 3) {
			SetPlayerHealth(i, 98.0); SendClientMessage(i, COLOR_WHITE,"~w~Semua Player Telah Di Heal.");
			//RepairVehicle(pemain[i][Vehicles]);
		}
	}
	return 1;
}


CMD:tarikall(playerid, params[])
{
	if(IsPlayerConnected(playerid)) {
		if(PlayerInfo[playerid][pAdmin] > 3) {
		    SetTimerEx("GetAllPlayers", 5000, 0, "i", playerid); 
			SendClientMessageToAll(-1, "~w~Semua player akan ditarik dalam masa 5 saat....");
		}
		else SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}Level 4 Keatas Sahaja.");
	}
	return 1;
}
//====//====//====//====//====//====//====//====//====//==== Countdown
forward GetAllPlayers(playerid);
public GetAllPlayers(playerid)
{
    new Float:X, Float:Y, Float:Z, Float:iX, Float:iY;
    GetPlayerPos(playerid, X, Y, Z);
    for(new i; i<MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i))
        {
            if(IsPlayerInAnyVehicle(i)) RemovePlayerFromVehicle(i);
            iX = floatadd(floatsub(random(30), 15.0), X);
            iY = floatadd(floatsub(random(30), 15.0), Y);
            SetPlayerPos(i, iX, iY, (Z+1.0)); SendClientMessage(i, -1, "Anda telah ditarik");
        }
    }
    return 1;
}


CMD:settime(playerid, params[])
{
	new cuaca;
	if (PlayerInfo[playerid][pAdmin] >= 3) {
		if(sscanf(params, "d", cuaca)) return SendClientMessage(playerid, -1, "~w~/settime [world time]");
		if (PlayerInfo[playerid][pAdmin] > 1) {
			SetWorldTime(cuaca);
		}
	}
	else SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}anda bukan admin");
	return 1;
}



CMD:spec(playerid, params[])
{
	new targetid;
	if(IsPlayerConnected(playerid)) {
		if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, -1, "~w~/spec [playerid]");
		if (PlayerInfo[playerid][pAdmin] > 0) {
		    if (!IsPlayerInAnyVehicle(targetid)) {
				TogglePlayerSpectating(playerid, 1); PlayerSpectatePlayer(playerid, targetid); SetPlayerInterior(playerid,GetPlayerInterior(targetid)); 
				SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(targetid));
			}
			else {
				TogglePlayerSpectating(playerid, 1); PlayerSpectateVehicle(playerid, GetPlayerVehicleID(targetid)); SetPlayerInterior(playerid,GetPlayerInterior(targetid)); 
				SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(targetid));
			}
		}
		else SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}anda bukan admin");
	}
	return 1;
}

CMD:specoff(playerid, params[])
{
	TogglePlayerSpectating(playerid, 0);
	//SetTimerEx("AutoGiveGun", 5000, false, "i", playerid);
	return 1;
}

/*
CMD:ajail(playerid, params[])
{
	new targetid;
	if(IsPlayerConnected(playerid))
	{
		if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, -1, "USAGE: /ajail [playerid]");
		if (PlayerInfo[playerid][pAdmin] > 0)
		{
			//=========//=========//=========//=========//=========
			if(PlayerInfo[targetid][pJail] == 0)
			{
				PlayerInfo[targetid][pJail] = 3; 
				PlayerInfo[targetid][pJailTime] = 9999; 
				SetPlayerPos(targetid, 1589.7635,-1664.7050,14.6641);
			 	SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}Info: Anda telah admin jail player itu!");
			}
			else return SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}Info: player ini bukan di jail Admin!");
		}
	}
	return 1;
}

CMD:aunjail(playerid, params[])
{
	new targetid;
	if(IsPlayerConnected(playerid))
	{
		if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, -1, "USAGE: /aunjail [playerid]");
		//if(playerid == playerid) return SendClientMessage(playerid, -1, "Anda Tidak Boleh Unjail Diri Sendiri");
		if (PlayerInfo[playerid][pAdmin] >= 2)
		{
			if(PlayerInfo[targetid][pJail] == 3)
			{
				PlayerInfo[targetid][pJail] = 0; 
				PlayerInfo[targetid][pJailTime] = 0; 
				SetPlayerPos(targetid, 1535.4318, -1672.8015, 13.8244);//COORDINATE UNJAIL ADMIN
				SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}Info: Anda telah admin unjail player itu!");
			}
			else return SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}Info: player ini bukan di jail Admin!");
		}
	}
	return 1;
}
*/

CMD:ao(playerid, params[]) return cmd_aooc(playerid, params);
CMD:aooc(playerid, params[])
{
	new string[128];
	if(IsPlayerConnected(playerid)) {
		if(PlayerInfo[playerid][pAdmin] > 0) {
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new result[64];
			if(sscanf(params, "s[128]", result)) return SendClientMessage(playerid, -1, "~w~/ao [aooc]");
			format(string, sizeof(string), "{00ffe1}[SDRM]: {ff0000}[ADMIN ALL]: %s:{ffffff} %s " , sendername, result);
			SendClientMessageToAll(-1, string);
		}
	}
	return 1;
}

CMD:kill(playerid, params[])
{
	new targetid;
	if(IsPlayerConnected(playerid)) {
		if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, -1, "~w~/kill [playerid]");
		if (PlayerInfo[playerid][pAdmin] > 1) {
			SetPlayerHealth(targetid,0);
		}
	}
	return 1;
}

CMD:setint(playerid, params[])
{
	new targetid, level;
	if(IsPlayerConnected(playerid)) {
		if(sscanf(params, "ud", targetid, level)) return SendClientMessage(playerid, -1, "~w~/setint [playerid] [id interrior]");
		if (PlayerInfo[playerid][pAdmin] >= 1) {
			if(IsPlayerConnected(targetid)) {
				if(targetid != INVALID_PLAYER_ID) {
					SetPlayerInterior(targetid,level);
				}
			}
		}
		else SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}anda tidak dibenarkan menggunakan cmd ini");
	}
	return 1;
}

CMD:setskin(playerid, params[])
{
	new targetid, skinid, string[256], name[MAX_PLAYER_NAME];
	if(IsPlayerConnected(playerid)) {
		if(sscanf(params, "ud", targetid, skinid)) return SendClientMessage(playerid, -1, "~w~/setskin [playerid/PartOfName] [skin id]");
		if(skinid > 299 || skinid < 1) { 
			SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}Wrong skin ID!"); 
			return 1; 
		}
		if (PlayerInfo[playerid][pAdmin] > 0) {
		    if(IsPlayerConnected(targetid)) {
		        if(targetid != INVALID_PLAYER_ID) {
					GetPlayerName(targetid, name, sizeof(name)); 
					GetPlayerName(playerid, sendername, sizeof(sendername));
					PlayerInfo[targetid][pSkin] = skinid;
					format(string, sizeof(string), "~w~Your skin has been changed by Admin %s", sendername); SendClientMessage(targetid, COLOR_WHITE, string);
					format(string, sizeof(string), "~w~You have given %s skin to %d.", name,skinid); SendClientMessage(playerid, COLOR_WHITE, string);
				    SetPlayerSkin(targetid, PlayerInfo[targetid][pSkin]);
				}
			}//not connected
		}
		else SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}anda tidak dibenarkan menggunakan cmd ini");
	}
	return 1;
}

CMD:jetpack(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] > 0) { 
		AntiJetpack[playerid] = 1; 
		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USEJETPACK); 
		SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}*Jetpack Use"); 
	}
    else return SendClientMessage(playerid, 0xAA0000AA, "~w~Cmd ini hanya untuk staff/admin sahaja.");
	return 1;
}



CMD:makeadmin(playerid, params[])
{
	new level, targetid, name[MAX_PLAYER_NAME], string[256];
	if(IsPlayerConnected(playerid)) {
		if(sscanf(params, "ud", targetid, level)) return SendClientMessage(playerid, -1, "~w~/makeadmin [playerid/PartOfName] [level]");
		if(PlayerInfo[playerid][pAdmin] == 9999)
		{
		    if(IsPlayerConnected(targetid))
		    {
		        if(targetid != INVALID_PLAYER_ID)
		        {
					GetPlayerName(targetid, name, sizeof(name)); 
					GetPlayerName(playerid, sendername, sizeof(sendername));
					PlayerInfo[targetid][pAdmin] = level;
					format(string, sizeof(string), "~w~Anda telah diberikan Admin level %d oleh Developer %s", level, sendername); SendClientMessage(targetid, COLOR_WHITE, string);
					format(string, sizeof(string), "~w~Anda telah memberikan %s Admin level %d .", name,level); SendClientMessage(playerid, COLOR_WHITE, string);
				}
			}
		}
		else SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}anda tidak dibenarkan menggunakan cmd ini");
	}
	return 1;
}

CMD:makevip(playerid, params[])
{
	new targetid, name[MAX_PLAYER_NAME], string[256];
	if(IsPlayerConnected(playerid)) {
		if(sscanf(params, "ud", targetid)) return SendClientMessage(playerid, -1, "~w~/makevip [playerid/PartOfName]");
		if(PlayerInfo[playerid][pAdmin] == 9999)
		{
		    if(IsPlayerConnected(targetid))
		    {
		        if(targetid != INVALID_PLAYER_ID)
		        {
					GetPlayerName(targetid, name, sizeof(name)); 
					GetPlayerName(playerid, sendername, sizeof(sendername));
					PlayerInfo[targetid][pVip] = 1;
					format(string, sizeof(string), "~w~Anda telah diberikan Vip oleh Developer %s", sendername); SendClientMessage(targetid, COLOR_WHITE, string);
					format(string, sizeof(string), "~w~Anda telah memberikan %s Vip .", name); SendClientMessage(playerid, COLOR_WHITE, string);
				}
			}
		}
		else SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}anda tidak dibenarkan menggunakan cmd ini");
	}
	return 1;
}

CMD:weatherall(playerid, params[])
{
	new weather, string[256];
	if(IsPlayerConnected(playerid)) {
		if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}anda tidak dibenarkan menggunakan cmd ini");
		if(sscanf(params, "d", weather)) return SendClientMessage(playerid, -1, "~w~/weatherall [weatherid]");
		if(weather < 0||weather > 45) 
		{
			SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}Weather ID can't be below 0 or above 45!"); 
			return 1; 
		}
		SetWeather(weather);
		SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}Weather Set to everyone!");
		GetPlayerName(playerid, sendername, sizeof(sendername));
       	format(string, 256, "~w~%s has changed the weather to %d.", sendername,weather);
		SendClientMessageToAll(-1,string);
	}
	return 1;
}

CMD:slap(playerid, params[])
{
	new targetid, sebab[128], name[MAX_PLAYER_NAME], string[256];
	if(IsPlayerConnected(playerid))
	{
		if(sscanf(params, "us[128]", targetid, sebab)) return SendClientMessage(playerid, -1, "~w~/slap [playerid] [sebab]");
		new Float:shealth;
		new Float:slx, Float:sly, Float:slz;
		if (PlayerInfo[playerid][pAdmin] > 0) {
		    if(IsPlayerConnected(targetid)) {
		        if(targetid != INVALID_PLAYER_ID) {
			        GetPlayerName(targetid, name, sizeof(name));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					GetPlayerHealth(targetid, shealth); 
					SetPlayerHealth(targetid, shealth-5);
					GetPlayerPos(targetid, slx, sly, slz); 
					SetPlayerPos(targetid, slx, sly, slz+5);
					SetPlayerInterior(targetid,0); 
					SetPlayerVirtualWorld(targetid, 0);
					PlayerPlaySound(targetid, 1130, slx, sly, slz+5);
					format(string, sizeof(string), "{00ffe1}[SDRM]: {ff0000}[DISCORD] {fffaf0}%s Telah Ditampar %s Sebab: (%s)",name ,sendername, sebab); 
					SendClientMessageToAll(-1,string);
				}
			}
		}
		else SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}anda tidak dibenarkan menggunakan cmd ini");
	}
	return 1;
}

CMD:slaphigh(playerid, params[])
{
	new targetid, sebab[128], name[MAX_PLAYER_NAME], string[256];
	if(IsPlayerConnected(playerid)) {
		if(sscanf(params, "us[128]", targetid, sebab)) return SendClientMessage(playerid, -1, "~w~/slap [playerid] [sebab]");
		new Float:shealth;
		new Float:slx, Float:sly, Float:slz;
		if (PlayerInfo[playerid][pAdmin] > 0) {
		    if(IsPlayerConnected(targetid)) {
		        if(targetid != INVALID_PLAYER_ID) {
			        GetPlayerName(targetid, name, sizeof(name));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					GetPlayerHealth(targetid, shealth); 
					SetPlayerHealth(targetid, shealth-5);
					GetPlayerPos(targetid, slx, sly, slz); 
					SetPlayerPos(targetid, slx, sly, slz+505);
					SetPlayerInterior(targetid,0); 
					SetPlayerVirtualWorld(targetid, 0);
					PlayerPlaySound(targetid, 1130, slx, sly, slz+5);
					format(string, sizeof(string), "~w~%s Telah Ditampar %s Sebab: (%s)",name ,sendername, sebab); 
					SendClientMessageToAll(-1,string);
				}
			}
		}
		else SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}anda tidak dibenarkan menggunakan cmd ini");
	}
	return 1;
}

CMD:kick(playerid, params[])
{
	new targetid, result[128], name[MAX_PLAYER_NAME], string[256];
	if(IsPlayerConnected(playerid)) {
		if(sscanf(params, "us[128]", targetid, result)) return SendClientMessage(playerid, -1, "~w~/kick [playerid] [sebab]");
		if (PlayerInfo[playerid][pAdmin] > 0) {
		    if(IsPlayerConnected(targetid)) {
		        if(targetid != INVALID_PLAYER_ID)
				{
				    GetPlayerName(targetid, name, sizeof(name));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), "~w~%s Telah ditendang dari SERVER Kerana:{ff0000} (%s)", name,result); 
					SendClientMessageToAll(-1, string);
					Kick(targetid);
					return 1;
				}
			}
		}
		else SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}anda tidak dibenarkan menggunakan cmd ini");
	}
	return 1;
}

CMD:tarik(playerid, params[])
{
	new targetid;
    if (PlayerInfo[playerid][pAdmin] > 0) {
		if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}/tarik [playerid]");
		new Float:plocx,Float:plocy,Float:plocz;
		if (IsPlayerConnected(targetid)) {
		    if(targetid != INVALID_PLAYER_ID) {
				if (PlayerInfo[targetid][pAdmin] > 1337) return SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}ANDA DILARANG MENARIK DEVELOPER.");
				if (PlayerInfo[playerid][pAdmin] > 0 ) {
					GetPlayerPos(playerid, plocx, plocy, plocz); 
					SetPlayerPos(targetid,plocx,plocy+2, plocz);
					SendClientMessage(targetid, COLOR_WHITE, "~w~Anda telah ditarik oleh Admin");
				}
				else SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}anda tidak dibenarkan menggunakan cmd ini");
			}
		}
		else SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}player ini offline");
	}
    return 1;
}

CMD:goto(playerid, params[])
{
	new targetid;
    if(IsPlayerConnected(playerid)) {
		if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}/goto [playerid]");
		new Float:plocx,Float:plocy,Float:plocz;
		if (IsPlayerConnected(targetid)) {
		    if(targetid != INVALID_PLAYER_ID) {
				if (PlayerInfo[playerid][pAdmin] > 0 ) {
					GetPlayerPos(targetid, plocx, plocy, plocz); 
					SetPlayerPos(playerid,plocx,plocy+2, plocz); 
					SetPlayerInterior(playerid,GetPlayerInterior(targetid));
					SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}Anda telah teleport kepada player ini");
				}
				else SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}anda tidak dibenarkan menggunakan cmd ini");
			}
		}
		else SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}player ini offline");
	}
    return 1;
}


CMD:ooc(playerid, params[]) return cmd_o(playerid, params);
CMD:o(playerid, params[])
{
	new string[128], result[128];
    if(IsPlayerConnected(playerid)) {
	    if(TogOoc == 1) {SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}Admin telah menutup OOC GLOBAL"); return 1;}
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(sscanf(params, "s[128]", result)) SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}USAGE: (/o)oc [OOC]");
		
		format(string, sizeof(string), "{00ff73}[CHAT ALL]: %s:{ffffff} %s " , sendername, result); SendClientMessageToAll(-1, string);

	}
    return 1;
}

CMD:admins(playerid, params[])
{
    new ContAdmin = 0, String[1000], Str[128];
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && PlayerInfo[i][pAdmin] > 0)
		{
			GetPlayerName(i, sendername, sizeof(sendername));
			format(Str, sizeof(Str), "{1100ff}%s {FFFFFF} {1100ff}[%i]\n", sendername, i);
			strcat(String, Str);
			ContAdmin++;
		}
	}
	if(ContAdmin == 0) { ShowPlayerDialog(playerid, 6551, DIALOG_STYLE_MSGBOX, "{1100ff}ADMIN OFFLINE", "{ffffff}TIADA ADMIN YANG ON WAKTU INI!", "Ok", #); }
	else { ShowPlayerDialog(playerid, 6552, DIALOG_STYLE_MSGBOX, "~w~ADMIN ONLINE", String, "Ok", #); }
    return 1;
}

CMD:cc(playerid, params[])
{
    SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}");
    SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}");
    SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}");
    SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}");
    SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}");
    SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}");
    SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}");
    SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}");
    SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}");
    SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}");
    SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}");
    SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}");
    SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}");
    return 1;
}

CMD:haha(playerid, params[])
{
	new string[128];
    if (WelcomeTiming[playerid] == 1) return SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}Sila tunggu 10 saat untuk guna cmd ini lagi !");
	format(string, sizeof(string), "{FFFF00}: {33CCFF}%s {D526D9}' {fafa00}H{2ca2c9}A{0a17c9}H{8a0b35}A{b300ff}H{00db7c}A", GetName(playerid)); SendClientMessageToAll(-1, string);
    WelcomeTiming[playerid] = 1; 
	SetTimerEx("WelcometimingTimer", 10000, false, "d", playerid);
    return 1;
}

CMD:ok(playerid, params[])
{
	new string[128];
    if (WelcomeTiming[playerid] == 1) return SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}Sila tunggu 10 saat untuk guna cmd ini lagi !");
	format(string, sizeof(string), "{FFFF00}: {33CCFF}%s {D526D9}' {FFFF00}O{ff0000}K{FFFF00}E{ff0000}Y!", GetName(playerid)); 
	SendClientMessageToAll(-1, string);
    WelcomeTiming[playerid] = 1; 
	SetTimerEx("WelcometimingTimer", 10000, false, "d", playerid);
    return 1;
}

CMD:wbg(playerid, params[])
{
	new string[128];
    if (WelcomeTiming[playerid] == 1) return SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}Sila tunggu 10 saat untuk guna cmd ini lagi !");
	format(string, sizeof(string), "{FFFF00}: {33CCFF}%s {D526D9}' {FFFF00}WELCOME BACK {f725e6}GAY {D526D9}' {FF8000}", GetName(playerid)); SendClientMessageToAll(-1, string);
    WelcomeTiming[playerid] = 1; SetTimerEx("WelcometimingTimer", 10000, false, "d", playerid);
    return 1;
}

CMD:wbd(playerid, params[])
{
	new string[128];
    if (WelcomeTiming[playerid] == 1) return SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}Sila tunggu 10 saat untuk guna cmd ini lagi !");
	format(string, sizeof(string), "{FFFF00}: {33CCFF}%s {D526D9}' {FFFF00}WELCOME BACK {ff0000}DEVELOPER {D526D9}' {FF8000}!", GetName(playerid)); SendClientMessageToAll(-1, string);
    WelcomeTiming[playerid] = 1; SetTimerEx("WelcometimingTimer", 10000, false, "d", playerid);
    return 1;
}

CMD:wbo(playerid, params[])
{
	new string[128];
    if (WelcomeTiming[playerid] == 1) return SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}Sila tunggu 10 saat untuk guna cmd ini lagi !");
	format(string, sizeof(string), "{FFFF00}: {33CCFF}%s {D526D9}' {FFFF00}WELCOME BACK {15eda5}OWNER {D526D9}' {FF8000}!", GetName(playerid)); SendClientMessageToAll(-1, string);
    WelcomeTiming[playerid] = 1; SetTimerEx("WelcometimingTimer", 10000, false, "d", playerid);
    return 1;
}

CMD:wba(playerid, params[])
{
	new string[128];
	if (WelcomeTiming[playerid] == 1) return SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}Sila tunggu 10 saat untuk guna cmd ini lagi !");
    format(string, sizeof(string), "{FFFF00}: {33CCFF}%s {D526D9}' {FFFF00}WELCOME BACK {385dd6}ADMIN {D526D9}' {FF8000}!", GetName(playerid)); SendClientMessageToAll(-1, string);
    WelcomeTiming[playerid] = 1; SetTimerEx("WelcometimingTimer", 10000, false, "d", playerid);
    return 1;
}

CMD:wb(playerid, params[])
{
	new string[128];
    if (WelcomeTiming[playerid] == 1) return SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}Sila tunggu 10 saat untuk guna cmd ini lagi !");
	format(string, sizeof(string), "{FFFF00}: {33CCFF}%s {D526D9}' {FFFF00}WELCOME BACK {D526D9}' {FF8000}!", GetName(playerid)); SendClientMessageToAll(-1, string);
    WelcomeTiming[playerid] = 1; SetTimerEx("WelcometimingTimer", 10000, false, "d", playerid);
    return 1;
}

CMD:ty(playerid, params[])
{
	new string[128];
    if (WelcomeTiming[playerid] == 1) return SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}Sila tunggu 10 saat untuk guna cmd ini lagi !"); SendClientMessageToAll(-1, string);
	format(string, sizeof(string), "{FFFF00}: {33CCFF}%s {D526D9}' {FFFF00}THANK YOU {D526D9}' {FF8000}!", GetName(playerid)); SendClientMessageToAll(-1, string);
    WelcomeTiming[playerid] = 1; SetTimerEx("WelcometimingTimer", 10000, false, "d", playerid);
    return 1;
}

CMD:aslm(playerid, params[])
{
	new string[128];
    if (WelcomeTiming[playerid] == 1) return SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}Sila tunggu 10 saat untuk guna cmd ini lagi !");
	format(string, sizeof(string), "{FFFF00}: {33CCFF}%s {D526D9}' {FFFF00}ASSALAMUALAIKUM {D526D9}' {FF8000}!", GetName(playerid)); SendClientMessageToAll(-1, string);
    WelcomeTiming[playerid] = 1; SetTimerEx("WelcometimingTimer", 10000, false, "d", playerid);
    return 1;
}

CMD:wslm(playerid, params[])
{
	new string[128];
    if (WelcomeTiming[playerid] == 1) return SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}Sila tunggu 10 saat untuk guna cmd ini lagi !");
	format(string, sizeof(string), "{FFFF00}: {33CCFF}%s {D526D9}' {FFFF00}WAALAIKUMSALAM {D526D9}' {FF8000}!", GetName(playerid)); SendClientMessageToAll(-1, string);
    WelcomeTiming[playerid] = 1; 
    SetTimerEx("WelcometimingTimer", 10000, false, "d", playerid);
    return 1;
}

forward WelcometimingTimer(playerid);
public WelcometimingTimer(playerid)
{
    WelcomeTiming[playerid] = 0;
}

CMD:togpm(playerid, params[])
{
    if(No_PM[playerid] == 0) 
	{
		No_PM[playerid] = 1; 
		SendClientMessage(playerid, -1, "~w~Anda telah off PM.");
	}
	else No_PM[playerid] = 0; SendClientMessage(playerid, -1, "~w~Anda telah on PM");
    return 1;
}

CMD:pm(playerid, params[])
{
	new targetid, result[64], string[128], giveplayer[MAX_PLAYER_NAME];
    if(IsPlayerConnected(playerid))
    {
        if(gPlayerLogged[playerid] == 0) return SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}login dahulu untuk pm!");
		if(sscanf(params, "us[128]", targetid, result))  return SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}/pm [playerid] [mesej]");
		if (IsPlayerConnected(targetid))
		{
		    if(targetid != INVALID_PLAYER_ID)
		    {
				if(No_PM[targetid] == 1) return SendClientMessage(playerid, 0xFF0000FF, "~w~Maaf: Player ni dah off PM!");
				Last_PM[targetid] = playerid;
				Last_PM[playerid] = targetid;
				GetPlayerName(playerid, sendername, sizeof(sendername));
				GetPlayerName(targetid, giveplayer, sizeof(giveplayer));
				if(targetid == playerid) return SendClientMessage(playerid, 0xFF0000FF, "~w~Tidak boleh send message kepada diri sendiri!");
				if(sscanf(params, "us[128]", targetid, result))  {SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}/pm [playerid] [mesej]"); SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}USAGE: /togglepm = untuk off pm"); return 1;}
				format(string, sizeof(string), "{FFFF00}Mesej ini daripada %s(%d): %s",sendername, playerid, (result)); SendClientMessage(targetid, -1, string);
				format(string, sizeof(string), "{FFFF00}Gunakan /r untuk membalas mesej dengan cepat!"); SendClientMessage(targetid, -1, string);
				format(string, sizeof(string), "{FFFF00}Mesej ini untuk %s(%d): %s",giveplayer, targetid, (result)); SendClientMessage(playerid,  -1, string);
				//PlayerPlaySound(targetid, 17802, 0, 0, 0);
				return 1;
			}
		}
		else SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}Player ini tidak akitf");
	}	
    return 1;
}


CMD:duduk(playerid, params[])
{
    ApplyAnimation(playerid,"PED","SEAT_down",4.1,0,0,0,1,1,1);
    return 1;
}

CMD:tab(playerid, params[])
{
    new stringtab[MAX_PLAYER_NAME * 100], title[80], count = 0, name[MAX_PLAYER_NAME+1];
	strcat(stringtab, "ID\tName\t{00ffbb}Level\tPing");
	count++;
	GetPlayerName(playerid, name, sizeof(name));
	format(stringtab, sizeof(stringtab), "%s\n%d\t%s\t%d\t%d", stringtab, playerid, name, GetPlayerScore(playerid), GetPlayerPing(playerid));
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i) && i != playerid)
	    {
	        count++;
	        GetPlayerName(i, name, sizeof(name));
	        format(stringtab, sizeof(stringtab), "%s\n%d\t%s\t%d\t%d", stringtab, i, name, GetPlayerScore(i), GetPlayerPing(i));
	    }
	}
	format(title, sizeof(title), "{00ffe1}[SDRM] |  {ffffff}Online: %d", count);
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, title, stringtab, "Closed", "");
    return 1;
}

CMD:r(playerid, params[]) return cmd_reply(playerid, params);
CMD:reply(playerid, params[])
{
	new text[256], targetid = Last_PM[playerid], string[256];
	if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, 0xFF0000FF, "~w~Maaf, player tersebut telah pun keluar!");
	if(sscanf(params, "s[256]", text)) return SendClientMessage(playerid, 0xFF0000FF, "~w~Penggunaan: /r [mesej]");
	if(No_PM[targetid] == 1) return SendClientMessage(playerid, 0xFF0000FF, "~w~Maaf: Player ni dah tutup PM!");
	Last_PM[targetid] = playerid;
	Last_PM[playerid] = targetid;
	format(string, sizeof(string), "{FFFF00}Mesej ini untuk %s (%d): %s", GetName(targetid), targetid, text); 
	SendClientMessage(playerid, -1, string);
	format(string, sizeof(string), "{FFFF00}Mesej ini daripada %s (%d): %s", GetName(playerid), playerid, text); 
	SendClientMessage(targetid, -1, string);
	PlayerPlaySound(targetid, 17802, 0, 0, 0);
    return 1;
}

CMD:cd(playerid, params[])
{
    new Float: kx, Float: ky, Float: kz;
	GetPlayerPos(playerid, kx, ky, kz);
	for(new i = 0; i < MAX_PLAYERS; i++) {
		if(IsPlayerInRangeOfPoint(i, 5, kx, ky, kz)) {
			if(IsPlayerConnected(i)) {
				SetTimerEx("Countdown1", 1000, false, "i", i); GameTextForPlayer(i, "~r~5", 5000, 3); PlayerPlaySound(i, 1056, 0, 0, 0);
			}
		}
	}
	return 1;
}

forward Countdown1(playerid);
public Countdown1(playerid) {GameTextForPlayer(playerid, "~r~5", 5000, 3); SetTimerEx("Countdown2", 1000, false, "i", playerid); PlayerPlaySound(playerid, 1056, 0, 0, 0); }

forward Countdown2(playerid);
public Countdown2(playerid) {GameTextForPlayer(playerid, "~r~4", 5000, 3); SetTimerEx("Countdown3", 1000, false, "i", playerid); PlayerPlaySound(playerid, 1056, 0, 0, 0); }

forward Countdown3(playerid);
public Countdown3(playerid) {GameTextForPlayer(playerid, "~r~3", 5000, 3); SetTimerEx("Countdown4", 1000, false, "i", playerid); PlayerPlaySound(playerid, 1056, 0, 0, 0); }

forward Countdown4(playerid);
public Countdown4(playerid) {GameTextForPlayer(playerid, "~r~2", 5000, 3); SetTimerEx("Countdown5", 1000, false, "i", playerid); PlayerPlaySound(playerid, 1056, 0, 0, 0); }

forward Countdown5(playerid);
public Countdown5(playerid) {GameTextForPlayer(playerid, "~r~1", 5000, 3); SetTimerEx("GOGOGO", 1000, false, "i", playerid); PlayerPlaySound(playerid, 1056, 0, 0, 0); }

forward GOGOGO(playerid);
public GOGOGO(playerid) {GameTextForPlayer(playerid, "~r~:: GO! GO! GO! ::", 1000, 3); PlayerPlaySound(playerid, 1057, 0, 0, 0); }


CMD:skin(playerid, params[])
{
	new skinid;
	if(sscanf(params, "d", skinid)) return SendClientMessage(playerid, -1, "~w~/skin [skin id]");
	SetPlayerSkin(playerid, skinid);
	return 1;
}

CMD:time(playerid, params[])
{
	new time;
	if(sscanf(params, "d", time)) return SendClientMessage(playerid, -1, "~w~/time [time]");
	SetPlayerTime(playerid, time, 0);
	return 1;
}

CMD:weather(playerid, params[])
{
	new weather;
	if(sscanf(params, "d", weather)) return SendClientMessage(playerid, -1, "~w~/weather [time]");
	SetPlayerWeather(playerid, weather);
	return 1;
}



CMD:vipskin(playerid, params[])
{
	new type[60];
	if(PlayerInfo[playerid][pVip] == 1) {
		if(sscanf(params, "s[60]", type)) return SendClientMessage(playerid, -1, "USAGE: /vipskin [1/2]");
		if(!strcmp(type, "1", true)) {
			for(new i=0; i<MAX_PLAYER_ATTACHED_OBJECTS; i++)
    		if(IsPlayerAttachedObjectSlotUsed(playerid, i)) RemovePlayerAttachedObject(playerid, i);
			SetPlayerAttachedObject(playerid, 5, 3524, 2, -0.6118, -0.1457, 0.0049, 88.3999, 104.4999, 91.9000, 0.2619, 0.3898, 0.3030, 0xFFF8F8FF, 0x00FFEBCD); // skull
			SetPlayerAttachedObject(playerid, 6, 3065, 2, -0.0178, 0.0178, 0.0000, 0.0000, 0.0000, 0.0000, 1.2318, 0.9448, 0.7649, 0xFF000000, 0xFFFFFFFF); // hide head
			SetPlayerAttachedObject(playerid, 7, 2680, 1, 0.0908, 0.0370, -0.2398, 99.1997, 76.1996, -4.3000, 1.1940, 1.3848, 1.7238, 0x00FF0000, 0x00FFEBCD); // chain
			SetPlayerAttachedObject(playerid, 8, 2899, 1, 0.2890, -0.0139, -0.0090, 91.4999, 91.9000, -0.3999, 0.1049, 0.0920, 0.5699, 0xFF2F4F4F, 0xFFFFFFFF); // jacket spikes
			SetPlayerAttachedObject(playerid, 9, 18693, 2, -1.6398, 0.1248, 0.0159, 0.0000, 90.5998, 0.0000, 1.0000, 1.0000, 1.0000, 0xFFFFFFFF, 0xFFFFFFFF); // skull flame 
			return 1;
		}
		//if(!strcmp(type, "2", true)) return //HouseTake(playerid, i);
	} else return SendClientMessage(playerid, -1, "~w~Anda bukan vip . pm owner untuk pembelian");
	return 1;
}

CMD:viparmor(playerid, params[])
{
	if(PlayerInfo[playerid][pVip] == 1) {
		SetPlayerArmour(playerid, 100.0);
	} else return SendClientMessage(playerid, -1, "~w~Anda bukan vip . pm owner untuk pembelian");
	return 1;
}



CMD:help(playerid, params[])
{
	new str[500], string[180];

	if(PlayerInfo[playerid][pAdmin] > 0 ) {
		format(string, sizeof(string), "{00ffe1}/w /healall /tarikall /settime /spec /ao /kill /setint /cobject\n"); strcat(str, string); 
		format(string, sizeof(string), "{00ffe1}/setskin /jetpack /weatherall /slap /slaphigh /kick /tarik /goto\n"); strcat(str, string); 
		format(string, sizeof(string), "{00ffe1}/adminevent /makevip\n"); strcat(str, string);
	}
    format(string, sizeof(string), "{00ffe1}/animlist /me /do /b /o /tab /duduk /mytime /weather\n"); strcat(str, string);  
	format(string, sizeof(string), "/admins /cc /togpm /pm /r /tune /v /cd /skin /tele /vipskin /viparmor\n"); strcat(str, string); 
	format(string, sizeof(string), "/haha /ok /wbg /wbd /wbo /wbo /wba /wb /ty /aslm /wslm\n"); strcat(str, string); 

	ShowPlayerDialog(playerid, DIALOG_HELPCMD, DIALOG_STYLE_MSGBOX, "Help Cmd", str, "Okey", "Exit");
    return 1;
}

CMD:tele(playerid, params[])
{
	new str[500], string[180];

    format(string, sizeof(string), "{00ffe1}[SDRM]: {FFFFFF}SPAWN RAKYAT\n"); strcat(str, string);  
	format(string, sizeof(string), "{00ffe1}[SDRM]: {FFFFFF}SPG4\n"); strcat(str, string);  
	format(string, sizeof(string), "{00ffe1}[SDRM]: {FFFFFF}DRAG 201M\n"); strcat(str, string);  
	format(string, sizeof(string), "{00ffe1}[SDRM]: {FFFFFF}DRAG V3\n"); strcat(str, string);  
	format(string, sizeof(string), "{00ffe1}[SDRM]: {FFFFFF}BENGKEL AGI X KARI\n"); strcat(str, string);  

	ShowPlayerDialog(playerid, DIALOG_TELEPORT, DIALOG_STYLE_LIST, "Help Cmd", str, "Okey", "Exit");
    return 1;
}


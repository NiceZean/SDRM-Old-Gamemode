#include discord-connector


//=======//=======//=======//=======//=======//=======//=======//=======//=======//======= DISCORD SYSTEM
//=======//=======//=======//=======
///*
new online;

new DCC_Channel:g_Discord_Login;
new DCC_Channel:g_Discord_Logout;
new DCC_Channel:g_Discord_Mati;
new DCC_Channel:g_Discord_Blacklist;
new DCC_Channel:g_Discord_PlayerChat;
static DCC_Channel:commandChannel;
//*/

forward DcSystemOnGamemodeinit();
public DcSystemOnGamemodeinit()
{
    //======//======//======//======//======//======//======//====== DISCORD SYSTEM
	///*
	g_Discord_Login = DCC_FindChannelById("952388789488222218");
    g_Discord_Logout = DCC_FindChannelById("952400957478699008");
   	g_Discord_Mati = DCC_FindChannelById("1079877589088350318");
	g_Discord_Blacklist = DCC_FindChannelById("1078249856436551702");
	g_Discord_PlayerChat = DCC_FindChannelById("1079877924259369172");
	commandChannel = DCC_FindChannelById("952396276098560020");
	//*/
}


//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//===== DISCORD SYSTEM

///*
forward DCC_DEATHINFO(playerid, killerid, reason);
public DCC_DEATHINFO(playerid, killerid, reason)
{
    new reasontext[526];
	switch(reason)
	{
	    case 49: reasontext = "Dilanggar Kenderaan";
	    case 50: reasontext = "Bilah Helikopter";
	    case 51: reasontext = "Letupan";
	    case 53: reasontext = "Lemas";
	    case 54: reasontext = "Splat";
	    case 255: reasontext = "Bunuh diri";
	}
	new name[MAX_PLAYER_NAME + 1];
	new pname[MAX_PLAYER_NAME + 1];
    GetPlayerName(playerid, name, sizeof name);
    GetPlayerName(killerid, pname, sizeof pname);

    new string[128];
    format(string, sizeof string, "%s [ID: %d] Death : (%s) || Killed By : (%s)", name, playerid, reasontext, pname);
    //DCC_SendChannelMessage(g_Discord_Mati, string);
    
	new DCC_Embed:DeathInfo = DCC_CreateEmbed("Street Drag Racing","");
	//DCC_SetEmbedThumbnail(DeathInfo, "https://scontent.fkul4-2.fna.fbcdn.net/v/t1.6435-9/197009108_1689910187868801_5562089934383164075_n.jpg?_nc_cat=104&ccb=1-3&_nc_sid=8631f5&_nc_ohc=HPwuPRYCtcsAX80tkuW&_nc_ht=scontent.fkul4-2.fna&oh=bccbc61ce2783a12a04089efb9438c1b&oe=60E11986");
	DCC_SetEmbedTitle(DeathInfo, "Street Drag Racing Death Info");
    DCC_SetEmbedDescription(DeathInfo, string);
	DCC_SendChannelEmbedMessage(g_Discord_Mati,DeathInfo);
}

forward DCC_BOTLOGIN(playerid);
public DCC_BOTLOGIN(playerid)
{
	if(IsPlayerNPC(playerid)) return 1;
	new name[MAX_PLAYER_NAME + 1];
    GetPlayerName(playerid, name, sizeof name);
    online++;

	new stringbot[500];
	format(stringbot, sizeof stringbot, "%s [ID: %d] Connected\nPlayer Connected: %d || Max Player: %d", name, playerid,online,GetMaxPlayers());
    //DCC_SendChannelMessage(g_Discord_Log, stringbot);
    
	new DCC_Embed:LogServer = DCC_CreateEmbed("Street Drag Racing","");
	//DCC_SetEmbedThumbnail(LogServer, "https://scontent.fkul4-2.fna.fbcdn.net/v/t1.6435-9/197009108_1689910187868801_5562089934383164075_n.jpg?_nc_cat=104&ccb=1-3&_nc_sid=8631f5&_nc_ohc=HPwuPRYCtcsAX80tkuW&_nc_ht=scontent.fkul4-2.fna&oh=bccbc61ce2783a12a04089efb9438c1b&oe=60E11986");
	DCC_SetEmbedTitle(LogServer, "***Street Drag Racing Login Info***");
    DCC_SetEmbedDescription(LogServer, stringbot);
	DCC_SendChannelEmbedMessage(g_Discord_Login,LogServer);
	return 1;
}

forward DCC_LOGOUTINFO(playerid, reason);
public DCC_LOGOUTINFO(playerid, reason)
{
    new reasontext[526];
	switch(reason)
	{
		case 0: reasontext = "(FC)Force Close";
		case 1: reasontext = "Quit";
		case 2: reasontext = "Kick";
	}
	new name[MAX_PLAYER_NAME + 1];
	GetPlayerName(playerid, name, sizeof name);
	online --;

	new stringbot[500];
	format(stringbot, sizeof stringbot, "%s [ID: %d] Disconnected (%s)", name, playerid, reasontext);
	//DCC_SendChannelMessage(g_Discord_Log, stringbot);

	new DCC_Embed:LogOutInfo = DCC_CreateEmbed("Street Drag Racing","");
	//DCC_SetEmbedThumbnail(LogOutInfo, "https://scontent.fkul4-2.fna.fbcdn.net/v/t1.6435-9/197009108_1689910187868801_5562089934383164075_n.jpg?_nc_cat=104&ccb=1-3&_nc_sid=8631f5&_nc_ohc=HPwuPRYCtcsAX80tkuW&_nc_ht=scontent.fkul4-2.fna&oh=bccbc61ce2783a12a04089efb9438c1b&oe=60E11986");
	DCC_SetEmbedTitle(LogOutInfo, "***Street Drag Racing Logout Info***");
    DCC_SetEmbedDescription(LogOutInfo, stringbot);
	DCC_SendChannelEmbedMessage(g_Discord_Logout,LogOutInfo);
}

/*
forward HideTextdrawDcChat(playerid);
public HideTextdrawDcChat(playerid)
{
    TextDrawHideForPlayer(playerid, DCCHATTEXTDRAW[playerid][0]); TextDrawHideForPlayer(playerid, DCCHATTEXTDRAW[playerid][1]); TextDrawHideForPlayer(playerid, DCCHATTEXTDRAW[playerid][2]); TextDrawHideForPlayer(playerid, DCCHATTEXTDRAW[playerid][3]);
    TextDrawHideForPlayer(playerid, DCUPDATECHAT[playerid]);
}
*/

public DCC_OnMessageCreate(DCC_Message:message)
{
	//new DCC_Channel:channel;
	DCC_GetMessageChannel(message, commandChannel);
	//if(channel != commandChannel) return 1;

	new DCC_User:author;
	DCC_GetMessageAuthor(message, author);

	new bool:IsBot;
	DCC_IsUserBot(author, IsBot);
	if(IsBot) { return 1; }

	new str[900];
    new command[32], params[128];
    new user_name[32 + 1];
   	DCC_GetUserName(author, user_name, 32);

    DCC_GetMessageContent(message, str);

    sscanf(str, "s[32]s[128]", command, params);

	
	new playerID;
	/*
	
    if(commandChannel == g_Discord_Chat && !IsBot) //!IsBot will block BOT's message in game
    {
        for(new i = 0; i < MAX_PLAYERS; i++)
		{
	        new realMsg[100];
	    	DCC_GetMessageContent(message, realMsg, 100);
	        format(str, sizeof(str), "~y~[%s]: ~w~%s",user_name, realMsg); TextDrawSetString(DCUPDATECHAT[i], str); TextDrawShowForPlayer(i, DCUPDATECHAT[i]);
	        TextDrawShowForPlayer(i, DCCHATTEXTDRAW[i][0]);
			TextDrawShowForPlayer(i, DCCHATTEXTDRAW[i][1]);
			TextDrawShowForPlayer(i, DCCHATTEXTDRAW[i][2]);
			TextDrawShowForPlayer(i, DCCHATTEXTDRAW[i][3]);
			SetTimerEx("HideTextdrawDcChat", 5000, false, "i", i);
        }
    }
	*/
	if(commandChannel == g_Discord_PlayerChat && !IsBot) //!IsBot will block BOT's message in game
    {
        new realMsg[100];
    	DCC_GetMessageContent(message, realMsg, 100);
        format(str, sizeof(str), "{ffc400}[DISCORD ADMIN]{34e5eb}[%s]: {ffc400}%s",user_name, realMsg);
        for(new i = 0; i < MAX_PLAYERS; i++) { SendClientMessage(i, COLOR_WHITE, str); }
    }
	/*
    if(commandChannel == g_Discord_AdminChat && !IsBot) //!IsBot will block BOT's message in game
    {
        new realMsg[100];
    	DCC_GetMessageContent(message, realMsg, 100);
        format(str, sizeof(str), "{ffc400}[DISCORD ADMIN]{34e5eb}[%s]: {ffc400}%s",user_name, realMsg);
        for(new i = 0; i < MAX_PLAYERS; i++) { if(PlayerInfo[i][pAdmin] > 0) { SendClientMessage(i, COLOR_WHITE, str); } }
    }
    if(commandChannel == g_Discord_PdrmChat && !IsBot) //!IsBot will block BOT's message in game
    {
        new realMsg[100];
    	DCC_GetMessageContent(message, realMsg, 100);
        format(str, sizeof(str), "{ffc400}[DISCORD PDRM]{34e5eb}[%s]: {ffc400}%s",user_name, realMsg);
        for(new i = 0; i < MAX_PLAYERS; i++) { if(PlayerInfo[i][pRole] == 1 || PlayerInfo[i][pRole] == 1) { SendClientMessage(i, COLOR_WHITE, str); } }
    }
    if(commandChannel == g_Discord_JpjChat && !IsBot) //!IsBot will block BOT's message in game
    {
        new realMsg[100];
    	DCC_GetMessageContent(message, realMsg, 100);
        format(str, sizeof(str), "{ffc400}[DISCORD JPJ]{34e5eb}[%s]: {ffc400}%s",user_name, realMsg);
        for(new i = 0; i < MAX_PLAYERS; i++) { if(PlayerInfo[i][pRole] == 2 || PlayerInfo[i][pRole] == 2) { SendClientMessage(i, COLOR_WHITE, str); } }
    }
    if(commandChannel == g_Discord_KkmChat && !IsBot) //!IsBot will block BOT's message in game
    {
        new realMsg[100];
    	DCC_GetMessageContent(message, realMsg, 100);
        format(str, sizeof(str), "{ffc400}[DISCORD KKM]{34e5eb}[%s]: {ffc400}%s",user_name, realMsg);
        for(new i = 0; i < MAX_PLAYERS; i++) { if(PlayerInfo[i][pRole] == 3 || PlayerInfo[i][pRole] == 3) { SendClientMessage(i, COLOR_WHITE, str); } }
    }
    if(commandChannel == g_Discord_TwinTigerChat && !IsBot) //!IsBot will block BOT's message in game
    {
        new realMsg[100];
    	DCC_GetMessageContent(message, realMsg, 100);
        format(str, sizeof(str), "{ffc400}[DISCORD TWIN TIGER]{34e5eb}[%s]: {ffc400}%s",user_name, realMsg);
        for(new i = 0; i < MAX_PLAYERS; i++) { if(PlayerInfo[i][pRole] == 5 || PlayerInfo[i][pRole] == 5) { SendClientMessage(i, COLOR_WHITE, str); } }
    }
	if(commandChannel == g_Discord_God7Chat && !IsBot) //!IsBot will block BOT's message in game
    {
        new realMsg[100];
    	DCC_GetMessageContent(message, realMsg, 100);
        format(str, sizeof(str), "{ffc400}[DISCORD GOD7]{34e5eb}[%s]: {ffc400}%s",user_name, realMsg);
        for(new i = 0; i < MAX_PLAYERS; i++) { if(PlayerInfo[i][pRole] == 6 || PlayerInfo[i][pRole] == 6) { SendClientMessage(i, COLOR_WHITE, str); } }
    }
	*/
	/*
    if(commandChannel == g_Discord_Geng204Chat && !IsBot) //!IsBot will block BOT's message in game
    {
        new realMsg[100];
    	DCC_GetMessageContent(message, realMsg, 100);
        format(str, sizeof(str), "{ffc400}[DISCORD GENG 204]{34e5eb}[%s]: {ffc400}%s",user_name, realMsg);
        for(new i = 0; i < MAX_PLAYERS; i++) { if(PlayerInfo[i][pRole] == 7 || PlayerInfo[i][pRole] == 7) { SendClientMessage(i, COLOR_WHITE, str); } }
    }
	*/
	///*
    //====//====//====//====//====//==== CMD RAKYAT
    if(strcmp(command, "/nothing", true) == 0)
	{
		DCC_SendChannelMessage(commandChannel, "");
		//DCC_TriggerBotTypingIndicator(commandChannel);
        return 1;
    }
    //*/
	///*
	//====//====//====//====//====//==== CMD ADMIN
	/*
	if(strcmp(command, "jwl", true) == 0)
	{
        new msg[128];
        sscanf(params, "s[128]",msg);
        new data[256];
        new string[500];
        format(data,sizeof(data),"Whitelist/%s.txt",msg);
        {
        	if(!dini_Exists(data)) {
				dini_Create(data);
				format(string, sizeof string, ":white_check_mark: __***WHITELISTED***__\n***Nama:%s\nWhitelist Accepted*** :thumbsup:", msg); //DCC_SendChannelMessage(g_Discord_Whitelist,string);
				new DCC_Embed:WhitelistInfo = DCC_CreateEmbed("Legacy Samp Roleplay","");
				//DCC_SetEmbedThumbnail(WhitelistInfo, "https://scontent.fkul2-3.fna.fbcdn.net/v/t1.6435-9/166206473_1640566462803174_3187879975635071091_n.jpg?_nc_cat=107&ccb=1-3&_nc_sid=8631f5&_nc_ohc=rOeAACkdP0MAX9pe6Hq&_nc_ht=scontent.fkul2-3.fna&oh=ff2e6ec9c94e34e6a7ad0d63c00fd553&oe=60D184F5");
				DCC_SetEmbedTitle(WhitelistInfo, "***Legacy Samp Roleplay Whitelist Info***");
			    DCC_SetEmbedDescription(WhitelistInfo, string);
				DCC_SendChannelEmbedMessage(g_Discord_Whitelist,WhitelistInfo);
			}
        	else {format(string,sizeof(string),"```\n%s Sudah Ada di dalam Record Whitelist```",msg); DCC_SendChannelMessage(commandChannel,string);}
        }
        return 1;
    }
    if(strcmp(command, "jbl", true) == 0)
	{
        new msg[128];
        sscanf(params, "s[128]",msg);
        new data[256];
        new string[200];
        format(data,sizeof(data),"Whitelist/%s.txt",msg);
        {
        	if(dini_Exists(data)) {
				dini_Remove(data); format(string, sizeof string, ":x: __***BLACKLISTED***__\n***Nama:%s\nYour Name Has Been Blacklisted In This Server*** :bangbang:", msg); //DCC_SendChannelMessage(g_Discord_Blacklist,string);
				new DCC_Embed:BlacklistInfo = DCC_CreateEmbed("Legacy SRP","");
				//DCC_SetEmbedThumbnail(BlacklistInfo, "https://scontent.fkul2-3.fna.fbcdn.net/v/t1.6435-9/166206473_1640566462803174_3187879975635071091_n.jpg?_nc_cat=107&ccb=1-3&_nc_sid=8631f5&_nc_ohc=rOeAACkdP0MAX9pe6Hq&_nc_ht=scontent.fkul2-3.fna&oh=ff2e6ec9c94e34e6a7ad0d63c00fd553&oe=60D184F5");
				DCC_SetEmbedTitle(BlacklistInfo, "***Legacy Samp Roleplay Blacklist Info***");
			    DCC_SetEmbedDescription(BlacklistInfo, string);
				DCC_SendChannelEmbedMessage(g_Discord_Blacklist,BlacklistInfo);
			}
        	else {format(string,sizeof(string),"```\n%s Tidak Ada Di Dalam Record Whitelist```",msg); DCC_SendChannelMessage(commandChannel,string);}
        }
        return 1;
    }
	*/
    
    //System Blacklist sahaja no whitelist
    if(strcmp(command, "jbl", true) == 0)
	{
		new msg[128];
        sscanf(params, "s[128]",msg);
        new data[256];
        new string[200];
        format(data,sizeof(data),"Blacklist/%s.txt",msg);
        {
        	if(!dini_Exists(data)) {
				dini_Create(data); format(string, sizeof string, ":x: __***BLACKLISTED***__\n***Nama:%s\nYour Name Has Been Blacklisted In This Server*** :bangbang:", msg); //DCC_SendChannelMessage(g_Discord_Blacklist,string);
				new DCC_Embed:BlacklistInfo = DCC_CreateEmbed("Legacy SRP","");
				//DCC_SetEmbedThumbnail(BlacklistInfo, "https://scontent.fkul2-3.fna.fbcdn.net/v/t1.6435-9/166206473_1640566462803174_3187879975635071091_n.jpg?_nc_cat=107&ccb=1-3&_nc_sid=8631f5&_nc_ohc=rOeAACkdP0MAX9pe6Hq&_nc_ht=scontent.fkul2-3.fna&oh=ff2e6ec9c94e34e6a7ad0d63c00fd553&oe=60D184F5");
				DCC_SetEmbedTitle(BlacklistInfo, "***Street Drag Racing Blacklist Info***");
			    DCC_SetEmbedDescription(BlacklistInfo, string);
				DCC_SendChannelEmbedMessage(g_Discord_Blacklist,BlacklistInfo);
			}
        	else { 
				format(string,sizeof(string),"```\n%s Sudah Ada Di Dalam Record Blacklist```",msg); DCC_SendChannelMessage(commandChannel,string); 
			}
        }
        return 1;
    }
	//*/
    /*
    //====//====//====//====//====//====
    if(strcmp(command, "jrestartlegacy", true) == 0)
    {
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i)) {SetTimerEx("Tendang", 10000, false, "i", i); SendClientMessage(i, COLOR_WHITE, "Maaf Ye, Server akan restart dalam masa 10 saat");}
	    }
	    DCC_SendChannelMessage(commandChannel, "***Server Restart Kick Player In 10 Second***");
        return 1;
    }
	*/
    //====//====//====//====//====//====
    if(strcmp(command, "jrevive", true) == 0)
    {
		new msg[128];
        if(IsPlayerConnected(playerID))
	    {
			
	        sscanf(params, "us[128]", playerID, msg);

	        SetTimerEx("ReviveFunction", 10000, false, "i", playerID);
	        DCC_SendChannelMessage(commandChannel, "Revive Player");
        }
        else return DCC_SendChannelMessage(commandChannel, "Player Ini OffLine");
        return 1;
    }
	/*
    //====//====//====//====//====//====
    if(strcmp(command, "jann", true) == 0)
	{
        new msg[128];
        sscanf(params, "s[128]",msg);

        for(new i = 0; i < MAX_PLAYERS; i++)
		{
	        TextDrawSetString(SEIJI[i][2], msg);
			for(new f = 0; f < 3; f ++) { TextDrawShowForPlayer(i, SEIJI[i][f]); }
			SetTimerEx("SEIJIHIDE", 10000, false, "i", i);
			PlayerPlaySound(i,1150,0.0,0.0,0.0);
		}
		DCC_SendChannelMessage(commandChannel, "***Mesej Dihantar***");
        return 1;
    }
	*/
    //====//====//====//====//====//====
    if(strcmp(command, "jpm", true) == 0)
	{
		new msg[128];
	    if(IsPlayerConnected(playerID))
	    {
	        
	        new string[300];
	        sscanf(params, "us[128]", playerID, msg);

	        format(string, sizeof(string), "{00ff73}[DISCORD ADMIN PM]: {aa1bb5}%s: {ffffff} %s " ,user_name, msg); SendClientMessage(playerID,-1, string);
        	DCC_SendChannelMessage(commandChannel, "***Mesej Dihantar***");
        }
        else return DCC_SendChannelMessage(commandChannel, "***Player Ini OffLine***");
        return 1;
    }
    //====//====//====//====//====//====
    if(strcmp(command, "jkick", true) == 0)
	{
		new msg[128];
	    if(IsPlayerConnected(playerID))
	    {
	        
	        new string[300];
	        sscanf(params, "us[128]", playerID, msg);

	        SetTimerEx("Tendang", 3000, false, "i", playerID);
	        format(string, sizeof(string), "{00ff73}[DISCORD CONTROL]: {ffffff} Anda telah di kick oleh admin {aa1bb5}%s {ffffff}kerana {00ff73}[%s]" ,user_name, msg); SendClientMessage(playerID,-1, string);
	        DCC_SendChannelMessage(commandChannel, "***Kick Player***");
        }
        else return DCC_SendChannelMessage(commandChannel, "Player Ini OffLine");
        return 1;
    }
	/*
    //====//====//====//====//====//====
    if(strcmp(command, "jajail", true) == 0)
	{
	    if(IsPlayerConnected(playerID))
	    {
	        new msg[128];
	        new string[256];
	        sscanf(params, "us[128]", playerID, msg);

	        PlayerInfo[playerID][pJail] = 3;
			PlayerInfo[playerID][pJailTime] = 99999;
			SetPlayerPos(playerID, 1589.7635,-1664.7050,14.6641); SetTimerEx("Unfreeze", 3000, false, "d", playerID);
	        format(string, sizeof(string), "{00ff73}[DISCORD CONTROL]: {ffffff} Anda telah di jail oleh admin {aa1bb5}%s {ffffff}kerana {00ff73}[%s] Selamanya" ,user_name, msg); SendClientMessage(playerID,-1, string);
	        DCC_SendChannelMessage(commandChannel, "***Jail Player***");
        }
        else return DCC_SendChannelMessage(commandChannel, "***Player Ini OffLine***");
        return 1;
    }
	//====//====//====//====//====//====
    if(strcmp(command, "jaunjail", true) == 0)
	{
	    if(IsPlayerConnected(playerID))
	    {
	        new msg[128];
	        new string[256];
	        sscanf(params, "us[128]", playerID, msg);

	        PlayerInfo[playerID][pJail] = 0;
			PlayerInfo[playerID][pJailTime] = 0;
			SetPlayerPos(playerID, 1535.4318, -1672.8015, 13.8244); SetTimerEx("Unfreeze", 3000, false, "d", playerID);
	        format(string, sizeof(string), "{00ff73}[DISCORD CONTROL]: {ffffff} Anda telah di unjail oleh admin {aa1bb5}%s",user_name); SendClientMessage(playerID,-1, string);
	        DCC_SendChannelMessage(commandChannel, "***UnJail Player***");
        }
        else return DCC_SendChannelMessage(commandChannel, "***Player Ini OffLine***");
        return 1;
    }
	*/
    //====//====//====//====//====//====
    if(strcmp(command, "jslap", true) == 0)
	{
		new msg[128];
	    if(IsPlayerConnected(playerID))
	    {
	        new string[256];
	        sscanf(params, "us[128]", playerID, msg);

	        new Float:slx, Float:sly, Float:slz;
			GetPlayerPos(playerID, slx, sly, slz); SetPlayerPos(playerID, slx, sly, slz+5); SetTimerEx("Unfreeze", 3000, false, "d", playerID);
	        format(string, sizeof(string), "{00ff73}[DISCORD CONTROL]: {ffffff} Admin {aa1bb5}%s Slap From Discord ",user_name); SendClientMessage(playerID,-1, string);
	        DCC_SendChannelMessage(commandChannel, "Slap Player");
        }
        else return DCC_SendChannelMessage(commandChannel, "Player Ini OffLine");
        return 1;
    }
    //====//====//====//====//====//====
    if(strcmp(command, "jkill", true) == 0)
	{
		new msg[128];
	    if(IsPlayerConnected(playerID))
	    {
	        new string[256];
	        sscanf(params, "us[128]", playerID, msg);

	        SetPlayerHealth(playerID,0);
	        format(string, sizeof(string), "{00ff73}[DISCORD CONTROL]: {ffffff} Admin {aa1bb5}%s Kill From Discord ",user_name); SendClientMessage(playerID,-1, string);
	        DCC_SendChannelMessage(commandChannel, "Kill Player");
        }
        else return DCC_SendChannelMessage(commandChannel, "Player Ini OffLine");
        return 1;
    }
    //====//====//====//====//====//====
    if(strcmp(command, "jlagu", true) == 0)
    {
        new msg[128];
        sscanf(params, "s[128]", msg);

		for(new i = 0; i < MAX_PLAYERS; i++) {if(IsPlayerConnected(i)) { PlayAudioStreamForPlayer(i, msg); }}
	    DCC_SendChannelMessage(commandChannel, "Lagu Di Server Dimainkan");
        return 1;
    }
    //====//====//====//====//====//====
    if(strcmp(command, "jhelp", true) == 0)
	{
	    new coordsstring[256];
		new finalstring [ 1024 ] ;

		format(coordsstring, sizeof(coordsstring), ":flag_my: ***BOT ADMIN CMD*** :small_red_triangle: \n\n"); strcat ( finalstring, coordsstring ) ;
		//format(coordsstring, sizeof(coordsstring), " ***jwl = Whitelist Player\n"); strcat ( finalstring, coordsstring ) ;
		format(coordsstring, sizeof(coordsstring), " jbl = Blacklist Player\n"); strcat ( finalstring, coordsstring ) ;
		//format(coordsstring, sizeof(coordsstring), " jann [text] = Annoucement Server\n"); strcat ( finalstring, coordsstring ) ;
		format(coordsstring, sizeof(coordsstring), " jao [text] = Ooc Ingame\n"); strcat ( finalstring, coordsstring ) ;
		format(coordsstring, sizeof(coordsstring), " jpm [playerid] [text] = pm player\n"); strcat ( finalstring, coordsstring ) ;
		//format(coordsstring, sizeof(coordsstring), " jao [text] = Ooc Ingame\n"); strcat ( finalstring, coordsstring ) ;
		format(coordsstring, sizeof(coordsstring), " jkick [playerid] [reason] = Kick Player\n"); strcat ( finalstring, coordsstring ) ;
		//format(coordsstring, sizeof(coordsstring), " jajail [playerid] [reason] = Jail Admin\n"); strcat ( finalstring, coordsstring ) ;
		//format(coordsstring, sizeof(coordsstring), " jaunjail [playerid] = Unjail Admin\n"); strcat ( finalstring, coordsstring ) ;
		//format(coordsstring, sizeof(coordsstring), " jweather = Set Cuaca Normal\n"); strcat ( finalstring, coordsstring ) ;
		format(coordsstring, sizeof(coordsstring), " jslap [playerid] = Slap Player\n"); strcat ( finalstring, coordsstring ) ;
		//format(coordsstring, sizeof(coordsstring), " jcheck [playerid] = Check Info\n"); strcat ( finalstring, coordsstring ) ;
		format(coordsstring, sizeof(coordsstring), " jlagu [link] = Lagu Untuk Semua\n"); strcat ( finalstring, coordsstring ) ;
		format(coordsstring, sizeof(coordsstring), " jrevive [id] = Revive Player\n"); strcat ( finalstring, coordsstring ) ;
		format(coordsstring, sizeof(coordsstring), " jkill [id] = Bunuh Orang Degil\n"); strcat ( finalstring, coordsstring ) ;
		//format(coordsstring, sizeof(coordsstring), " jtogooc = On Off Ooc Ingame\n"); strcat ( finalstring, coordsstring ) ;

        new DCC_Embed:JaiHelp = DCC_CreateEmbed("","");
		DCC_SetEmbedDescription(JaiHelp, finalstring);
		DCC_SendChannelEmbedMessage(commandChannel,JaiHelp);
        return 1;
    }
	//*/
	return 1;
}

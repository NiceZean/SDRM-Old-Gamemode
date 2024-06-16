

#define COLOR_WHITE 0xFFFFFFAA

new gPlayerLogTries[MAX_PLAYERS];
new gPlayerAccount[MAX_PLAYERS];
new Typed[MAX_PLAYERS][64];

new DahSpawnDbUpdate[MAX_PLAYERS];



//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====
enum pInfo
{
	pKey[128],
	pIpChecker,
	pAdmin,
	pFirstRegister,
	pSkin,
	pVip,
	//===========//=========== BASIC ROLEPLAY
    Float:pNyawa,
    Float:pArmor,
	Float:pSpawnX,
	Float:pSpawnY,
	Float:pSpawnZ,
	Float:pFacingAngle,
	pInterior,
	pVirtualWorld
};
new PlayerInfo[MAX_PLAYERS][pInfo];




forward Onplayerupdatedb(playerid);
public Onplayerupdatedb(playerid) 
{
	if(IsPlayerConnected(playerid)) {
		if(DahSpawnDbUpdate[playerid] == 1) {
			new string3[64];
			new playername3[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername3, sizeof(playername3));
			format(string3, sizeof(string3), "users/%s.ini", playername3);
			new File: hFile = fopen(string3, io_write);
			if (hFile) {
				{
					new var[64];
					format(var, 64, "pKey=%s\n", PlayerInfo[playerid][pKey]);fwrite(hFile, var);
					new dest[22];
					NetStats_GetIpPort(playerid, dest, sizeof(dest));
					format(var, 64, "pIpChecker=%s\n",dest);fwrite(hFile, var);
					format(var, 64, "pAdmin=%d\n",PlayerInfo[playerid][pAdmin]);fwrite(hFile, var);
					format(var, 64, "pFirstRegister=%d\n",PlayerInfo[playerid][pFirstRegister]);fwrite(hFile, var);
					format(var, 64, "pSkin=%d\n",GetPlayerSkin(playerid));fwrite(hFile, var);
					format(var, 64, "pVip=%d\n",PlayerInfo[playerid][pVip]);fwrite(hFile, var);
				
					new Float:Health;
					new Float:Armor;
					new Float:x, Float:y, Float:z;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerHealth(playerid, Health);
					GetPlayerArmour(playerid, Armor);

					//===========//=========== BASIC ROLEPLAY
					format(var, 64, "pNyawa=%.1f\n",Health);fwrite(hFile, var);
					format(var, 64, "pArmor=%.1f\n",Armor);fwrite(hFile, var);
					format(var, 64, "pSpawnX=%.1f\n",x);fwrite(hFile, var);
					format(var, 64, "pSpawnY=%.1f\n",y);fwrite(hFile, var);
					format(var, 64, "pSpawnZ=%.1f\n",z);fwrite(hFile, var);
					format(var, 64, "pInterior=%d\n",GetPlayerInterior(playerid));fwrite(hFile, var);
					format(var, 64, "pVirtualWorld=%d\n",GetPlayerVirtualWorld(playerid));fwrite(hFile, var);

	
					fclose(hFile);
				}
			}
		}
	}
}


forward OnPlayerLoginNew(playerid,password[]);
public OnPlayerLoginNew(playerid,password[])
{
    new string2[64];
	new playername2[MAX_PLAYER_NAME];
	new playernamesplit[3][MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername2, sizeof(playername2));
	split(playername2, playernamesplit, '_');
	format(string2, sizeof(string2), "users/%s.ini", playername2);
	new File: UserFile = fopen(string2, io_read);
	if ( UserFile )
	{
	    new PassData[256];
	    new keytmp[256], valtmp[256];
	    fread( UserFile , PassData , sizeof( PassData ) );
	    keytmp = ini_GetKey( PassData );
	    if( strcmp( keytmp , "pKey" , true ) == 0 )
		{
			valtmp = ini_GetValue( PassData );
			strmid(PlayerInfo[playerid][pKey], valtmp, 0, strlen(valtmp)-1, 255);
		}
		if(strcmp(PlayerInfo[playerid][pKey],password, true ) == 0 )
		{
			    new key[ 256 ] , val[ 256 ];
			    new Data[ 256 ];
			    while ( fread( UserFile , Data , sizeof( Data ) ) )
				{
					key = ini_GetKey( Data );
			    	//=====
					if( strcmp( key , "pAdmin" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pAdmin] = strval( val ); }
					if( strcmp( key , "pIpChecker" , true ) == 0 ) { val = ini_GetValue( Data ); strmid(PlayerInfo[playerid][pIpChecker], val, 0, strlen(val)-1, 255); }
					if( strcmp( key , "pFirstRegister" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pFirstRegister] = strval( val ); }
					if( strcmp( key , "pSkin" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pSkin] = strval( val ); }
					if( strcmp( key , "pVip" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pVip] = strval( val ); }
					//===========//=========== BASIC ROLEPLAY
				    if( strcmp( key , "pNyawa" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pNyawa] = floatstr( val ); }
				    if( strcmp( key , "pArmor" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pArmor] = floatstr( val ); }
					if( strcmp( key , "pSpawnX" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pSpawnX] = floatstr( val ); }
					if( strcmp( key , "pSpawnY" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pSpawnY] = floatstr( val ); }
					if( strcmp( key , "pSpawnZ" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pSpawnZ] = floatstr( val ); }
					if( strcmp( key , "pInterior" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pInterior] = strval( val ); }
					if( strcmp( key , "pVirtualWorld" , true ) == 0 ) { val = ini_GetValue( Data ); PlayerInfo[playerid][pVirtualWorld] = strval( val ); }


                }
                fclose(UserFile);		
		}
		else 
		{
            ShowPlayerDialog(playerid, 1245, DIALOG_STYLE_PASSWORD, "{FFFFFF}LOGIN", "{FF0000}WRONG PASSWORD!!! TRY AGAIN \n!", "Login", "Exit");
	        fclose(UserFile);
	        gPlayerLogTries[playerid] += 1;
	        if(gPlayerLogTries[playerid] == 3) { Kick(playerid); } //OnPlayerLogin
         	return 1;
		}
		SetPlayerPos(playerid, 5819.3906,-779.7399,10.9161); LoginStock(playerid);
	}
	return 1;
}

forward OnPlayerRegister(playerid, password[]);
public OnPlayerRegister(playerid, password[])
{
	if(IsPlayerConnected(playerid))
	{
		new string3[64];
		new playername3[MAX_PLAYER_NAME];
		GetPlayerName(playerid, playername3, sizeof(playername3));
		format(string3, sizeof(string3), "users/%s.ini", playername3);
		new File: hFile = fopen(string3, io_write);
		if (hFile)
		{
			{
				strmid(PlayerInfo[playerid][pKey], password, 0, strlen(password), 255);
				new var[64];
				format(var, 64, "pKey=%s\n", PlayerInfo[playerid][pKey]);fwrite(hFile, var);
				format(var, 64, "pIpChecker=%s\n", PlayerInfo[playerid][pIpChecker]);fwrite(hFile, var);
				format(var, 64, "pAdmin=%d\n",PlayerInfo[playerid][pAdmin]);fwrite(hFile, var);
				format(var, 64, "pFirstRegister=%d\n",PlayerInfo[playerid][pFirstRegister] = 0);fwrite(hFile, var);
				format(var, 64, "pSkin=%d\n",PlayerInfo[playerid][pSkin]);fwrite(hFile, var);
				format(var, 64, "pVip=%d\n",PlayerInfo[playerid][pVip]);fwrite(hFile, var);
				//===========//=========== BASIC ROLEPLAY
				format(var, 64, "pNyawa=%.1f\n", PlayerInfo[playerid][pNyawa]);fwrite(hFile, var);
				format(var, 64, "pArmor=%.1f\n",PlayerInfo[playerid][pArmor]);fwrite(hFile, var);
				format(var, 64, "pSpawnX=%.1f\n",PlayerInfo[playerid][pSpawnX]);fwrite(hFile, var);
				format(var, 64, "pSpawnY=%.1f\n",PlayerInfo[playerid][pSpawnY]);fwrite(hFile, var);
				format(var, 64, "pSpawnZ=%.1f\n",PlayerInfo[playerid][pSpawnZ]);fwrite(hFile, var);
				format(var, 64, "pInterior=%d\n",PlayerInfo[playerid][pInterior]);fwrite(hFile, var);
				format(var, 64, "pVirtualWorld=%d\n",PlayerInfo[playerid][pVirtualWorld]);fwrite(hFile, var);

				
				fclose(hFile);
			}
			new string[258];
			new name[MAX_PLAYER_NAME+1];
			GetPlayerName(playerid, name, sizeof(name));
			format(string, 128, "{08ffbd}%s {ffffff}Kata Laluan Anda Ialah {08ffbd}%s {ff0000}Jangan Lupa yeee!", name, PlayerInfo[playerid][pKey]); SendClientMessage(playerid, -1, string);
			LoginStock(playerid);
		}
	}
	return 1;
}

forward LoginStock(playerid);
public LoginStock(playerid)
{
	
	SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}CMD {00ffe1}/help {ffffff}untuk cmd Server Ini");

	//======//======//======//======//======
	DahSpawnDbUpdate[playerid] = 0; 
	SpawnPlayer(playerid); 
	//StopAudioStreamForPlayer(playerid);
	SetTimerEx("UnfreezeLogin", 5000, false, "i", playerid);

	new string[258];
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));

	new AdminTitle[60];
	if(PlayerInfo[playerid][pAdmin] == 9999) { AdminTitle = "{30302e}[OWNER]"; SetPlayerColor(playerid, 0x00e397ff); }
	if(PlayerInfo[playerid][pAdmin] == 3) { AdminTitle = "{00e397}[DEVELOPER]"; SetPlayerColor(playerid, 0x00e397ff); }
	if(PlayerInfo[playerid][pAdmin] == 2) { AdminTitle = "{FF0000}[EXT DEV]"; SetPlayerColor(playerid, 0x2f71bdff); }
	if(PlayerInfo[playerid][pAdmin] == 1) { AdminTitle = "{00bfff}[ADMIN]"; SetPlayerColor(playerid, 0x00bfffff); }
	if(PlayerInfo[playerid][pAdmin] == 0) { SetPlayerColor(playerid, 0xffffffff); }

	new VipTitle[60];
	if(PlayerInfo[playerid][pVip] == 1) { SetPlayerColor(playerid, 0xfcba03FF); }
	
    format(string, sizeof(string), "%s%s {ffffff}%s {7aeb34}Connected",AdminTitle, VipTitle, name); SendClientMessageToAll(-1, string); 
    //new stringveh[128]; format(stringveh, sizeof(stringveh), "{ffffff}(%d)", playerid); Update3DTextLabelText(player3Dtext[playerid], 0xFFFFFFFF, "");
	//player3Dtext[playerid] = Create3DTextLabel(stringveh, 0xFFFFFFAA, 30.0, 40.0, 50.0, 40.0, 0); Attach3DTextLabelToPlayer( player3Dtext[playerid], playerid, 0.0, 0.0, 0.7); // Attaching Text Label To Player
	return 1;
}


forward ResetVarDatabase(playerid);
public ResetVarDatabase(playerid) 
{
    ///======///======///======///====== RESET VAR DATABASE
	///*
	PlayerInfo[playerid][pAdmin] = 0;
	PlayerInfo[playerid][pFirstRegister] = 0;
	PlayerInfo[playerid][pSkin] = 0;

	PlayerInfo[playerid][pVip] = 0;

	///======///======///======///======
}


forward Onplayerconnectdb(playerid);
public Onplayerconnectdb(playerid) 
{
	new string[128];
    new plname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, plname, sizeof(plname));
	format(string, sizeof(string), "users/%s.ini", plname);
    if(dini_Exists(string)) {
		gPlayerAccount[playerid] = 1;
	}
	else {
		gPlayerAccount[playerid] = 0;
}
	}


forward Onplayerconnectdbwhitelist(playerid);
public Onplayerconnectdbwhitelist(playerid) 
{
   	/*
	new FirstName[MAX_PLAYER_NAME];
   	GetPlayerName(playerid, FirstName, sizeof(FirstName));
   	new namestring = strfind(FirstName, "_", true);
 	if(namestring == -1)
	{
		ShowPlayerDialog(playerid,7500,DIALOG_STYLE_MSGBOX, "{26ff00}Info [SDRM]", "{fffaf0}Nama Anda tidak roleplay, sila gunakan Firstname_Lastname\n\nExample: Ahmad_Albab", "Okay", "Tutup");
		SetTimerEx("Tendang", 500, false, "i", playerid);
		return 1;
	}
	*/
   	//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//===== BLACKLIST
	///*
	new name[MAX_PLAYER_NAME+1];
	GetPlayerName(playerid, name, sizeof(name));
	new player[200];
	format(player,sizeof(player),"/Blacklist/%s.txt",name);
	if(dini_Exists(player))
	{
		new coordsstring[256];
		new finalstring [ 1024 ] ;
		format(coordsstring, sizeof(coordsstring), "{03fcdf}Blacklisted\n\n{ffffff}Anda Diblacklist atas sebab tertentu\nSila rujuk Discord Legacy SRP\n{52fc03}https://discord.me/legacysrp\n"); strcat ( finalstring, coordsstring ) ;
		format(coordsstring, sizeof(coordsstring), "{ffffff}Nama Anda: {ff9900}%s\n",name); strcat ( finalstring, coordsstring ) ;
		ShowPlayerDialog(playerid, 8888, DIALOG_STYLE_MSGBOX, "{ff0000}Blacklisted", finalstring, "", "");
	 	SetTimerEx("Tendang", 500, false, "i", playerid);
   	}
   	else
   	{
   	}

	
	return 1;
}

forward UnfreezeLogin(playerid);
public UnfreezeLogin(playerid)
{	
	TogglePlayerControllable(playerid, true);
}

//===============================================DATABASE=======================================================
//===============================================DATABASE=======================================================
//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====
forward ini_GetKey( line[] );
stock ini_GetKey( line[] )
{
	new keyRes[256];
	keyRes[0] = 0;
    if ( strfind( line , "=" , true ) == -1 ) return keyRes;
    strmid( keyRes , line , 0 , strfind( line , "=" , true ) , sizeof( keyRes) );
    return keyRes;
}
//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====
forward ini_GetValue( line[] );
stock ini_GetValue( line[] )
{
	new valRes[256];
	valRes[0]=0;
	if ( strfind( line , "=" , true ) == -1 ) return valRes;
	strmid( valRes , line , strfind( line , "=" , true )+1 , strlen( line ) , sizeof( valRes ) );
	return valRes;
}
//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====
forward split(const strsrc[], strdest[][], delimiter);
public split(const strsrc[], strdest[][], delimiter)
{
	new i, li;
	new aNum;
	new len;
	while(i <= strlen(strsrc)){
	    if(strsrc[i]==delimiter || i==strlen(strsrc)){
	        len = strmid(strdest[aNum], strsrc, li, i, 128);
	        strdest[aNum][len] = 0;
	        li = i+1;
	        aNum++;
		}
		i++;
	}
	return 1;
}




forward LoginDialog(playerid);
public LoginDialog(playerid)
{
	new string[500];
	new name[MAX_PLAYER_NAME+1];
	GetPlayerName(playerid, name, sizeof(name));
	if (gPlayerAccount[playerid] != 0)
	{
		format(string, sizeof(string), "{FFFFFF}Selamat datang ke{08ffbd} SDRM\n{FFFFFF}Anda harus log masuk untuk bermain.\n\n{32d1cc}Nama Anda: {ffffff}%s\n\n{FFFFFF}Insert Your Password:",name);
		ShowPlayerDialog(playerid,1245, DIALOG_STYLE_PASSWORD, "{FFFFFF} SDRM", string, "Masuk", "Keluar");
	}
	else
	{
		SendClientMessage(playerid, COLOR_WHITE, "AKAUN INI BELUM DIDAFTAR!.");
		format(string, sizeof(string), "{FFFFFF}Selamat datang ke{08ffbd} SDRM\n{FFFFFF}Anda harus log masuk untuk bermain.\n\n{32d1cc}Nama Anda: {ffffff}%s\n\n{FFFFFF}Insert Your Password:",name);
		ShowPlayerDialog(playerid,1246, DIALOG_STYLE_PASSWORD, "{FFFFFF}DAFTAR", string, "Daftar", "Keluar");
	}
}




forward OnDialogResponsePlayerDb(playerid, dialogid, response, listitem, inputtext[]);
public OnDialogResponsePlayerDb(playerid, dialogid, response, listitem, inputtext[])
{
	//=========//=========//=========//=========//=========//=========//=========//=========//=========//========= DIALOG_LOGIN
    switch( dialogid )
    {
    	case 1245: //
		{
		    if(response)
		    {
		        strmid(Typed[playerid], inputtext, 0, strlen(inputtext), 255);
                if(!strcmp(Typed[playerid], "None", true)) {ShowPlayerDialog(playerid,1245, DIALOG_STYLE_PASSWORD, "{FF0000}Street Drag Racing Malaysia", "Please Insert Your Password", "Masuk", "Keluar");}
			  	else {
					OnPlayerLoginNew(playerid, inputtext); SetPlayerVirtualWorld(playerid, 0);
				}
			}
			//else Kick(playerid);
		}
	}
	//=========//=========//=========//=========//=========//=========//=========//=========//=========//========= DIALOG_REGISTER
	switch( dialogid )
	{
		case 1246: // REGISTER DIALOG ID
		{
		    if(response == 1)
		    {
		        if(strlen(inputtext) < 1) return ShowPlayerDialog(playerid,1246, DIALOG_STYLE_PASSWORD, "{FF0000}Street Drag Racing Malaysia", "Please Insert Your Password", "Masuk", "Keluar");
                if(strlen(inputtext) > 50) return ShowPlayerDialog(playerid,1246, DIALOG_STYLE_PASSWORD, "{FF0000}Street Drag Racing Malaysia", "Please Insert Your Password", "Masuk", "Keluar");
		        OnPlayerRegister(playerid, inputtext);
    		}
			//else Kick(playerid);
		}
	}
    return 1;
}
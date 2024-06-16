new ghour = 0;
new gminute = 0;
new gsecond = 0;



forward ClearAnimation(playerid);
public ClearAnimation(playerid) { 
	ApplyAnimation(playerid, "CARRY", "crry_prtial",4.0,0,0,0,0,0,1); return 1; 
}

forward Tendang(playerid);
public Tendang(playerid) {
	Kick(playerid);
}


forward SetTime();
public SetTime()
{
	gettime(ghour, gminute, gsecond);
	SetWorldTime(ghour);
}


//======//======//======//======//======//======//======//======//======//======//======//======//======//======//=====
stock SetVehicleSpeedTT(vehicleid, Float:speed)
{
    new Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2, Float:a;
    GetVehicleVelocity(vehicleid, x1, y1, z1);
    GetVehiclePos(vehicleid, x2, y2, z2);
    GetVehicleZAngle(vehicleid, a); a = 360 - a;
    x1 = (floatsin(a, degrees) * (speed/100) + floatcos(a, degrees) * 0 + x2) - x2;
    y1 = (floatcos(a, degrees) * (speed/100) + floatsin(a, degrees) * 0 + y2) - y2;
    SetVehicleVelocity(vehicleid, x1, y1, z1);
}
//======//======//======//======//======//======//======//======//======//======//======//======//======//======//=====
forward Float: GetVehicleSpeed(vehicleid);
public Float: GetVehicleSpeed(vehicleid)
{
	new Float: speed = -1;
	if(vehicleid != INVALID_VEHICLE_ID)
	{
		new Float: x,
			Float: y,
			Float: z,
			Float: angle;
		GetVehicleVelocity(vehicleid, x, y, z);
		GetVehicleZAngle(vehicleid, angle);
		speed = x / floatsin(-angle, degrees);
		speed *= 100.0;
	}
	return speed;
}
//======//======//======//======//======//======//======//======//======//======//======//======//======//======//======
stock SetPlayerSkinFix(playerid, skinid)
{
	new
 	Float:tmpPos[4],
	vehicleid = GetPlayerVehicleID(playerid),
	seatid = GetPlayerVehicleSeat(playerid);
	GetPlayerPos(playerid, tmpPos[0], tmpPos[1], tmpPos[2]);
	GetPlayerFacingAngle(playerid, tmpPos[3]);
	if(skinid < 0 || skinid > 299) return 0;
	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_DUCK)
	{
	    SetPlayerPos(playerid, tmpPos[0], tmpPos[1], tmpPos[2]);
		SetPlayerFacingAngle(playerid, tmpPos[3]);
		TogglePlayerControllable(playerid, 1); // preventing any freeze - optional
		return SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
	}
	else if(IsPlayerInAnyVehicle(playerid))
	{
	    new
     	tmp;
	    RemovePlayerFromVehicle(playerid);
	    SetPlayerPos(playerid, tmpPos[0], tmpPos[1], tmpPos[2]);
		SetPlayerFacingAngle(playerid, tmpPos[3]);
		TogglePlayerControllable(playerid, 1); // preventing any freeze - important - because of doing animations of exiting vehicle
		tmp = SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
		PutPlayerInVehicle(playerid, vehicleid, (seatid == 128) ? 0 : seatid);
		return tmp;
	}
	else
	{
	    return SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
	}
}


stock GetName(playerid) {
	new name[MAX_PLAYER_NAME+1]; GetPlayerName(playerid, name, MAX_PLAYER_NAME+1); return name;
}

forward ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5);
public ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i) && (GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i)))
			{
				{
					GetPlayerPos(i, posx, posy, posz);
					tempposx = (oldposx -posx);
					tempposy = (oldposy -posy);
					tempposz = (oldposz -posz);
					if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16))) {SendClientMessage(i, col1, string);}
					else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8))) {SendClientMessage(i, col2, string);}
					else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4))) {SendClientMessage(i, col3, string);}
					else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2))) {SendClientMessage(i, col4, string);}
					else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi))) {SendClientMessage(i, col5, string);}
				}
			}
		}
	}
	return 1;
}

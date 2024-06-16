
#define MAXOBJECT 10000
new ToggleIndex[MAX_PLAYERS];





new Mati[MAX_PLAYERS];
new gPlayerLogged[MAX_PLAYERS];
new sendername[MAX_PLAYER_NAME];
new WelcomeTiming[MAX_PLAYERS];
new AntiJetpack[MAX_PLAYERS];
new No_PM[MAX_PLAYERS], Last_PM[MAX_PLAYERS];

enum objectdata
{
    ID,
    Owner[MAX_PLAYER_NAME],
    ModelID,
    Float:PosXMap,
    Float:PosYMap,
    Float:PosZMap,
    Float:PosRXMap, 
    Float:PosRYMap, 
    Float:PosRZMap,
    worldid,
    interiorid,
    PlayerText3D:Label,
    idobject,
};
new ObjectData[MAXOBJECT][objectdata];


forward CreateNewObject(playerid, objectid, Float:xx, Float:yy, Float:zz, Float:rxx, Float:ryy, Float:rzz, worldidd, interioridd);
public CreateNewObject(playerid, objectid, Float:xx, Float:yy, Float:zz, Float:rxx, Float:ryy, Float:rzz, worldidd, interioridd)
{
    new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    for(new i = 0; i < MAXOBJECT; i++)
    {
        new file[60];
        format(file, sizeof(file), "DynamicMap/%d.ini", i);
        if(!fexist(file))
        {
            dini_Create(file);
            dini_IntSet(file, "ID", ObjectData[i][ID] = i);
            dini_Set(file, "Owner", name);
            dini_IntSet(file, "ModelID", ObjectData[i][ModelID] = objectid);
            dini_FloatSet(file, "PosXMap", ObjectData[i][PosXMap] = xx);
            dini_FloatSet(file, "PosYMap", ObjectData[i][PosYMap] = yy);
            dini_FloatSet(file, "PosZMap", ObjectData[i][PosZMap] = zz);
            dini_FloatSet(file, "PosRXMap", ObjectData[i][PosRXMap] = rxx);
            dini_FloatSet(file, "PosRYMap", ObjectData[i][PosRYMap] = ryy);
            dini_FloatSet(file, "PosRZMap", ObjectData[i][PosRZMap] = rzz);
            dini_IntSet(file, "worldid", ObjectData[i][worldid] = worldidd);
            dini_IntSet(file, "interiorid", ObjectData[i][interiorid] = interioridd);
            strmid(ObjectData[i][Owner], name, false, strlen(name), MAX_PLAYER_NAME);
            ObjectData[i][idobject] = CreateDynamicObject(objectid, xx, yy, zz, rxx, ryy, rzz, worldidd, interioridd);

            SendClientMessage(playerid, -1, "{00ffe1}[SDRM]: {FFFFFF}/edit [index id] untuk edit mapping anda");
            SendClientMessage(playerid, -1, "{00ffe1}[SDRM]: {FFFFFF}/dobject [index id] untuk destroy mapping anda");
            SendClientMessage(playerid, -1, "{00ffe1}[SDRM]: {FFFFFF}/togindex untuk lihat id mapping anda");
            return 1;
        }
    }
    return 1;
}

forward LoadAllMap();
public LoadAllMap()
{
    new totalmap;
    totalmap = 0;
    for(new i = 0; i < MAXOBJECT; i++)
    {
        new file[60];
        format(file, sizeof(file), "DynamicMap/%d.ini", i);
        if(fexist(file))
        {
            ObjectData[i][ID] = dini_Int(file, "ID");
            ObjectData[i][ModelID] = dini_Int(file, "ModelID");
            ObjectData[i][PosXMap] = dini_Float(file, "PosXMap");
            ObjectData[i][PosYMap] = dini_Float(file, "PosYMap");
            ObjectData[i][PosZMap] = dini_Float(file, "PosZMap");
            ObjectData[i][PosRXMap] = dini_Float(file, "PosRXMap");
            ObjectData[i][PosRYMap] = dini_Float(file, "PosRYMap");
            ObjectData[i][PosRZMap] = dini_Float(file, "PosRZMap");
            ObjectData[i][worldid] = dini_Int(file, "worldid");
            ObjectData[i][interiorid] = dini_Int(file, "interiorid");
            strmid(ObjectData[i][Owner], dini_Get(file, "Owner"), false, strlen(dini_Get(file, "Owner")), MAX_PLAYER_NAME);

            ObjectData[i][idobject] = CreateDynamicObject(ObjectData[i][ModelID], ObjectData[i][PosXMap], ObjectData[i][PosYMap], ObjectData[i][PosZMap], ObjectData[i][PosRXMap], ObjectData[i][PosRYMap], ObjectData[i][PosRZMap], ObjectData[i][worldid], ObjectData[i][interiorid]);
            totalmap++;
        }
    }
    return 1;
}

public OnPlayerEditDynamicObject(playerid, STREAMER_TAG_OBJECT:objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
    new Float:oldX, Float:oldY, Float:oldZ, Float:oldRotX, Float:oldRotY, Float:oldRotZ;
	GetObjectPos(objectid, oldX, oldY, oldZ);
	GetObjectRot(objectid, oldRotX, oldRotY, oldRotZ);
	if(response == EDIT_RESPONSE_FINAL)
	{
		

        for(new i = 0; i < MAXOBJECT; i++)
        {
            if(ObjectData[i][idobject] == objectid)
            {
                ObjectData[i][PosXMap] = x;
                ObjectData[i][PosYMap] = y;
                ObjectData[i][PosZMap] = z;
                ObjectData[i][PosRXMap] = rx;
                ObjectData[i][PosRYMap] = ry;
                ObjectData[i][PosRZMap] = rz;
                SetDynamicObjectPos(objectid, x, y, z); SetDynamicObjectRot(objectid, rx, ry, rz);

                new file[60];
                format(file, sizeof(file), "DynamicMap/%d.ini", i);
                if(fexist(file))
                {
                    dini_FloatSet(file, "PosXMap", ObjectData[i][PosXMap] = x);
                    dini_FloatSet(file, "PosYMap", ObjectData[i][PosYMap] = y);
                    dini_FloatSet(file, "PosZMap", ObjectData[i][PosZMap] = z);
                    dini_FloatSet(file, "PosRXMap", ObjectData[i][PosRXMap] = rx);
                    dini_FloatSet(file, "PosRYMap", ObjectData[i][PosRYMap] = ry);
                    dini_FloatSet(file, "PosRZMap", ObjectData[i][PosRZMap] = rz);
                }  

                SendClientMessage(playerid, -1, "{00ffe1}[LSRP]: {FFFFFF}Anda Telah Mengubah Position Object!");
                if(ToggleIndex[playerid] == 1)
                {
                    DeletePlayer3DTextLabel(playerid, ObjectData[i][Label]);
                    new string[180];
                    format(string, sizeof(string), "Index : %d", i);
                    ObjectData[i][Label] = CreatePlayer3DTextLabel(playerid, string, -1, ObjectData[i][PosXMap], ObjectData[i][PosYMap], ObjectData[i][PosZMap], 10.0);
                }
            }
            
        }
	}
 
	if(response == EDIT_RESPONSE_CANCEL)
	{
		SetDynamicObjectPos(objectid, oldX, oldY, oldZ);
		SetDynamicObjectRot(objectid, oldRotX, oldRotY, oldRotZ);
	}
    return 1;
}



CMD:cobject(playerid, params[])
{
    new Float:xx, Float:yy, Float:zz;
    GetPlayerPos(playerid, xx, yy, zz);
	new objectid;
	if (PlayerInfo[playerid][pAdmin] == 2) {
		if(sscanf(params, "d", objectid)) return SendClientMessage(playerid, -1, "~w~/cobject [object id]");
		CreateNewObject(playerid, objectid, xx+2, yy-5, zz, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
	}
	else SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}~w~Admin sahaja boleh mapping");
	return 1;
}

CMD:dobject(playerid, params[])
{
    new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    for(new i = 0; i < MAXOBJECT; i++)
    {
        new file[60]; format(file, sizeof(file), "DynamicMap/%d.ini", i);
        if(IsPlayerInRangeOfPoint(playerid, 10.0, ObjectData[i][PosXMap], ObjectData[i][PosYMap], ObjectData[i][PosZMap]) && !strcmp(ObjectData[i][Owner],name, true))
        {
            if (PlayerInfo[playerid][pAdmin] == 2) {
                new index;
                if(sscanf(params, "i", index)) return SendClientMessage(playerid, -1, "{00ffe1}[SDRM]: {FFFFFF}/destroy [index]");
                DestroyPlayerMapping(playerid, ObjectData[index][idobject]); 
            }
            else SendClientMessage(playerid, COLOR_WHITE, "{00ffe1}[SDRM]: {FFFFFF}~w~Admin sahaja boleh mapping");
            
        }
    }
    return 1;
}

CMD:edit(playerid, params[])
{
    new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    for(new i = 0; i < MAXOBJECT; i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 10.0, ObjectData[i][PosXMap], ObjectData[i][PosYMap], ObjectData[i][PosZMap]) && !strcmp(ObjectData[i][Owner],name, true))
        {
            new index;
            if(sscanf(params, "i", index)) return SendClientMessage(playerid, -1, "{00ffe1}[SDRM]: {FFFFFF}/edit [index]");
            EditDynamicObject(playerid, ObjectData[index][idobject]);
        }
    }
    return 1;
}

CMD:togindex(playerid, params[])
{
    if(ToggleIndex[playerid] == 0)
    {
        new name[MAX_PLAYER_NAME];
        GetPlayerName(playerid, name, sizeof(name));
        for(new i = 0; i < MAXOBJECT; i++)
        {
            if(IsPlayerInRangeOfPoint(playerid, 10.0, ObjectData[i][PosXMap], ObjectData[i][PosYMap], ObjectData[i][PosZMap]) && !strcmp(ObjectData[i][Owner],name, true))
            {
                new string[180];
                format(string, sizeof(string), "Index : %d", i);
                ObjectData[i][Label] = CreatePlayer3DTextLabel(playerid, string, -1, ObjectData[i][PosXMap], ObjectData[i][PosYMap], ObjectData[i][PosZMap], 10.0);
                ToggleIndex[playerid] = 1;
            }
        }
    }
    else if(ToggleIndex[playerid] == 1)
    {
        new name[MAX_PLAYER_NAME];
        GetPlayerName(playerid, name, sizeof(name));
        for(new i = 0; i < MAXOBJECT; i++)
        {
            if(IsPlayerInRangeOfPoint(playerid, 10.0, ObjectData[i][PosXMap], ObjectData[i][PosYMap], ObjectData[i][PosZMap]) && !strcmp(ObjectData[i][Owner],name, true))
            {
                DeletePlayer3DTextLabel(playerid, ObjectData[i][Label]);
                ToggleIndex[playerid] = 0;
            }
        }
    }
    return 1;
}

forward DestroyPlayerMapping(playerid, STREAMER_TAG_OBJECT:objectid);
public DestroyPlayerMapping(playerid, STREAMER_TAG_OBJECT:objectid)
{
    for(new i = 0; i < MAXOBJECT; i++)
    {
        if(ObjectData[i][idobject] == objectid)
        {
            new file[60];
            format(file, sizeof(file), "DynamicMap/%d.ini", i);
            if(fexist(file)) {
                DestroyDynamicObject(ObjectData[i][idobject]); DeletePlayer3DTextLabel(playerid, ObjectData[i][Label]); dini_Remove(file); 
            }  

        }
    }
    return 1;
}

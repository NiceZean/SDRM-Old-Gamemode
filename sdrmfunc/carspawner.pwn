#include a_samp
#include mSelection
#include zcmd

#define DIALOG_VEHICLES 		2412

#define 	red             	"{FF0000}"
#define     grey                "{AFAFAF}"
#define     green   	    	"{00FF00}"


new playerCar[MAX_PLAYERS];

new Airplanes = mS_INVALID_LISTID;
new Bikes = mS_INVALID_LISTID;
new Boats = mS_INVALID_LISTID;
new Convertible = mS_INVALID_LISTID;
new Helicopters = mS_INVALID_LISTID;
new Industrials = mS_INVALID_LISTID;
new LowriderCar = mS_INVALID_LISTID;
new OffRoad = mS_INVALID_LISTID;
new PublicService = mS_INVALID_LISTID;
new RC = mS_INVALID_LISTID;
new Saloon = mS_INVALID_LISTID;
new Sports = mS_INVALID_LISTID;
new StationWagon = mS_INVALID_LISTID;
new Trailer = mS_INVALID_LISTID;
new Unique = mS_INVALID_LISTID;

forward OnFilterScriptInitCarSpawn();
public OnFilterScriptInitCarSpawn()
{
	Airplanes = LoadModelSelectionMenu("VehicleSpawner/Airplane.txt");
	Bikes = LoadModelSelectionMenu("VehicleSpawner/Bike.txt");
	Boats = LoadModelSelectionMenu("VehicleSpawner/Boat.txt");
	Convertible = LoadModelSelectionMenu("VehicleSpawner/Convertible.txt");
	Helicopters = LoadModelSelectionMenu("VehicleSpawner/Helicopter.txt");
	Industrials = LoadModelSelectionMenu("VehicleSpawner/Industrial.txt");
	LowriderCar = LoadModelSelectionMenu("VehicleSpawner/Lowrider.txt");
	OffRoad = LoadModelSelectionMenu("VehicleSpawner/OffRoad.txt");
	PublicService = LoadModelSelectionMenu("VehicleSpawner/PublicService.txt");
	RC = LoadModelSelectionMenu("VehicleSpawner/RC.txt");
	Saloon = LoadModelSelectionMenu("VehicleSpawner/Saloon.txt");
	Sports = LoadModelSelectionMenu("VehicleSpawner/Sport.txt");
	StationWagon = LoadModelSelectionMenu("VehicleSpawner/StationWagon.txt");
	Trailer = LoadModelSelectionMenu("VehicleSpawner/Trailer.txt");
	Unique = LoadModelSelectionMenu("VehicleSpawner/Unique.txt");
	return 1;
}


forward OnPlayerConnectCarSpawn(playerid);
public OnPlayerConnectCarSpawn(playerid)
{
	playerCar[playerid] = INVALID_VEHICLE_ID;
	return 1;
}

forward OnPlayerDisconnectCarSpawn(playerid);
public OnPlayerDisconnectCarSpawn(playerid)
{
    DestroyVehicle(playerCar[playerid]);
	return 1;
}

forward OnDialogResponseCarSpawn(playerid, dialogid, response, listitem, inputtext[]);
public OnDialogResponseCarSpawn(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_VEHICLES:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0:
					{
					ShowModelSelectionMenu(playerid, Airplanes, "Airplanes");
					}
					case 1:
					{
					ShowModelSelectionMenu(playerid, Bikes, "Bikes");
					}
					case 2:
					{
					ShowModelSelectionMenu(playerid, Boats, "Boats");
					}
					case 3:
					{
					ShowModelSelectionMenu(playerid, Convertible, "Convertible");
					}
					case 4:
					{
					ShowModelSelectionMenu(playerid, Helicopters, "Helicopters");
					}
					case 5:
					{
					ShowModelSelectionMenu(playerid, Industrials, "Industrials");
					}
					case 6:
					{
					ShowModelSelectionMenu(playerid, LowriderCar, "Lowrider");
					}
					case 7:
					{
					ShowModelSelectionMenu(playerid, OffRoad, "OffRoad Vehicle");
					}
					case 8:
					{
					ShowModelSelectionMenu(playerid, PublicService, "Public Service");
					}
					case 9:
					{
					ShowModelSelectionMenu(playerid, RC, "RC Vehicles");
					}
					case 10:
					{
					ShowModelSelectionMenu(playerid, Saloon, "Saloons");
					}
					case 11:
					{
					ShowModelSelectionMenu(playerid, Sports, "Sport Cars");
					}
					case 12:
					{
					ShowModelSelectionMenu(playerid, StationWagon, "StationWagon");
					}
					case 13:
					{
					ShowModelSelectionMenu(playerid, Trailer, "Trailer");
					}
					case 14:
					{
					ShowModelSelectionMenu(playerid, Unique, "Unique Vehicles");
					}
				}
			}
		}
	}
	return 0;
}

CMD:v(playerid, params[])
{
	ShowPlayerDialog(playerid, DIALOG_VEHICLES, DIALOG_STYLE_LIST, ""red"Vehicle Category", ""green"Airplane\n"green"Bike\n"green"Boat\n"green"Convertible\n"green"Helicopter\n"green"Industrial\n"green"Lowrider\n"green"Off Road\n"green"Public Service\n"green"RC\n"green"Saloon\n"green"Sport\n"green"Station Wagon\n"green"Trailer\n"green"Unique", "Select", "Close");
	return 1;
}

CMD:car(playerid, params[]) return cmd_v(playerid, params);
public OnPlayerModelSelection(playerid, response, listid, modelid)
{
	new VW, INT;
    if(listid == Airplanes || listid == Bikes || listid == Boats || listid == Convertible || listid == Helicopters || listid == Industrials || listid == LowriderCar || listid == OffRoad || listid == PublicService || listid == RC || listid == Saloon || listid == Sports || listid == StationWagon || listid == Trailer || listid == Unique)
    {
        if(response)
        {
            DestroyVehicle(playerCar[playerid]);
            new Float:pos[4], color[2];
			GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
			GetPlayerFacingAngle(playerid, pos[3]);
			color[0] = random(256);
			color[1] = random(256);
			playerCar[playerid] = CreateVehicle(modelid, pos[0], pos[1], pos[2]+2.0, pos[3], color[0], color[1], -1);
			VW = GetPlayerVirtualWorld(playerid);
    		INT = GetPlayerInterior(playerid);
    		SetVehicleVirtualWorld(playerCar[playerid], VW);
    		LinkVehicleToInterior(playerCar[playerid], INT);
			PutPlayerInVehicle(playerid, playerCar[playerid], 0);
			SendClientMessage(playerid, 0xFF0000FF, ""red"[Vehicle] "grey"Vehcile Spawned.");
			
        }
        else SendClientMessage(playerid, 0xFF0000FF, ""red"[Vehicle] "grey"Canceled selection.");
        return 1;
    }
    return 1;
}


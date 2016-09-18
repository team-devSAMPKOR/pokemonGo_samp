#include <foreach>
#define ENUM_WARP 3
enum WARP{
   bool:CHECK,
   bool:INCAR,
   CARID
}
new WarpDTO[MAX_PLAYERS][WARP];


/*=========================================================================*/

public OnGameModeInit(){
	server_init();
	
	return 1;
}

stock server_init(){
	SetTimer("WarpThread", 50, true);
}

forward WarpThread();
public WarpThread(){
    foreach (new i : Player){
        warpManager(i);
	}
}

stock warpManager(playerid){
	if(!WarpDTO[playerid][INCAR]) return false;
	
	new carid = GetPlayerVehicleID(playerid);
	if(WarpDTO[playerid][CARID] != carid && carid != 0)SendClientMessage(playerid, -1, "����");
	return 1;
}

/*=========================================================================
TODO : ��峻 ���� ž�� �ڵ� �κп� inCar(playerid,vehicleid) �����ؾ���

   ���� ��� /��Ÿ ���� ���

   /��Ÿ [������ȣ] [����ȣ] [����Ʈ]{
      inCar(������ȣ, ����ȣ);
      PutPlayerInVehicle(������ȣ, ����ȣ, 0);
      �����ڵ� �����;
   }

   /����ȯ(/v){
      new ����ȣ = CreateVehicle(123123,123,123,123);
      inCar(������ȣ, ����ȣ);
      PutPlayerInVehicle(������ȣ, ����ȣ, 0);
      �����ڵ� �����;
   }
    PutPlayerInVehicleEX ���� ����
*/

/* SEE : ���� ž��Ű�� ������ ��*/
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger){
	inCar(playerid,vehicleid);
	return 1;
}

/* ��������*/
public OnPlayerStateChange(playerid, newstate, oldstate){
    switch(newstate){
        case PLAYER_STATE_ONFOOT:warpInit(playerid);
        case PLAYER_STATE_DRIVER..PLAYER_STATE_PASSENGER:checkWarp(playerid);
    }
   return 1;
}


/*=========================================================================*/

/* ž�ºμ���*/
stock inCar(playerid,vehicleid){
   WarpDTO[playerid][CARID]=vehicleid;
   WarpDTO[playerid][CHECK]=true;
}

/* üŷ*/
stock checkWarp(playerid){
   new msg[32];
   format(msg,sizeof(msg), "����ž�� : %s", (WarpDTO[playerid][CHECK]) ? ("����") : ("�ƴ�"));
   SendClientMessage(playerid, -1, msg);

   WarpDTO[playerid][INCAR]=true;
   
   if(!WarpDTO[playerid][CHECK]){
      new carid = GetPlayerVehicleID(playerid);
      if(WarpDTO[playerid][CARID] != carid && carid != 0)SendClientMessage(playerid, -1, "����");
   }
}

/* �ʱ�ȭ*/
stock warpInit(playerid){
   new temp[WARP];
   for(new i=0; i < ENUM_WARP; i++)WarpDTO[playerid] = temp;
}


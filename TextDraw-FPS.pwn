/*
    * Filterscript TextDraw FPS

    © [2024] [Calasans]. Todos os direitos reservados.

    Discord: ocalasans
    Youtube: Calasans
    Instagram: ocalasans

    SA:MP Programming Comunnity©: https://abre.ai/samp-spc
*/

#define FILTERSCRIPT
//
#include <a_samp>
//
main(){}
//
#define TFF_function:%0(%1) forward %0(%1);\
                            public %0(%1)
//
static TFF_cronometro[MAX_PLAYERS],
    PlayerText:TFF_text_fps[MAX_PLAYERS];
//
stock TFF_obter_fps(playerid)
{
    SetPVarInt(playerid, "TFF_drunk", GetPlayerDrunkLevel(playerid));
    //
    if(GetPVarInt(playerid, "TFF_drunk") <= 100)
        SetPlayerDrunkLevel(playerid, 2000);
    //
    else
    {
        if(GetPVarInt(playerid, "TFF_drunk_ii") != GetPVarInt(playerid, "TFF_drunk"))
        {
            new TFF_obter = GetPVarInt(playerid, "TFF_drunk_ii") - GetPVarInt(playerid, "TFF_drunk");
            //
            if((TFF_obter >= 1) && (TFF_obter <= 300))
                SetPVarInt(playerid, "TFF_fps", TFF_obter);
            //
            SetPVarInt(playerid, "TFF_drunk_ii", GetPVarInt(playerid, "TFF_drunk"));
        }
        return GetPVarInt(playerid, "TFF_fps");
    }
    //
    return false;
}

TFF_function:TFF_timer_fps(playerid)
{
    new TFF_string[10];
    //
    format(TFF_string, sizeof(TFF_string), "FPS: %d", TFF_obter_fps(playerid));
    PlayerTextDrawSetString(playerid, TFF_text_fps[playerid], TFF_string);
    //
    return true;
}

public OnFilterScriptInit()
{
    print(" ");
    print("__________________________________________________________________");
    print("||==============================================================||");
    print("||                                                              ||");
    print("||                  Filterscript TextDraw FPS                   ||");
    print("||                                                              ||");
    print("||                        By: Calasans                          ||");
    print("||                  Discord: abre.ai/samp-spc                   ||");
    print("||                                                              ||");
    print("||==============================================================||");
    print("__________________________________________________________________");
    print(" ");
    //
    return true;
}

public OnPlayerConnect(playerid)
{
    TFF_text_fps[playerid] = CreatePlayerTextDraw(playerid, 1.000000, 137.000000, "FPS: 0");
    PlayerTextDrawBackgroundColor(playerid, TFF_text_fps[playerid], 255);
    PlayerTextDrawFont(playerid, TFF_text_fps[playerid], 1);
    PlayerTextDrawLetterSize(playerid, TFF_text_fps[playerid], 0.140000, 0.799998);
    PlayerTextDrawColor(playerid, TFF_text_fps[playerid], 0xB4B5B7FF);
    PlayerTextDrawSetOutline(playerid, TFF_text_fps[playerid], 0);
    PlayerTextDrawSetProportional(playerid, TFF_text_fps[playerid], 1);
    PlayerTextDrawSetShadow(playerid, TFF_text_fps[playerid], 1);
    PlayerTextDrawUseBox(playerid, TFF_text_fps[playerid], 1);
    PlayerTextDrawBoxColor(playerid, TFF_text_fps[playerid], 255);
    PlayerTextDrawTextSize(playerid, TFF_text_fps[playerid], 23.000000, -311.000000);
    PlayerTextDrawSetSelectable(playerid, TFF_text_fps[playerid], 0);
    //
    PlayerTextDrawShow(playerid, TFF_text_fps[playerid]);
    //
    TFF_cronometro[playerid] = SetTimerEx("TFF_timer_fps", 0, true, "i", playerid);
    return true;
}

public OnPlayerDisconnect(playerid, reason)
{
    KillTimer(TFF_cronometro[playerid]);
    //
    PlayerTextDrawHide(playerid, TFF_text_fps[playerid]);
    //
    return true;
}

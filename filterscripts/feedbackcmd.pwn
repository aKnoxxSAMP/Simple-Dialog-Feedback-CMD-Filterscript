#define FILTERSCRIPT

#include <a_samp>
#include <sscanf>
#include <zcmd>

#define SCMCOLOR 0x91db4cFF

#define DIALOG_MAIN 7730
#define DIALOG_SUGGESTION 7731
#define DIALOG_BUGREPORT 7732

public OnFilterScriptInit()
{
	print("\n--------------------------------------------------------------------------");
	print("[FeedbackCMD FS]: Filterscript by aKnoxx loaded.");
	
	
	new File:openedfile = fopen("Feedback.txt", io_write);	
	fclose(openedfile);
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/mycommand", cmdtext, true, 10) == 0)
	{
		// Do something here
		return 1;
	}
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_MAIN) 
	{
		if(response)
		{
			if(listitem == 0)
			{
				ShowPlayerDialog(playerid, DIALOG_SUGGESTION, DIALOG_STYLE_INPUT, "Submit a Suggestion", "Briefly explain your suggestion.", "Submit", "Close");
				return 1;
			}
			if(listitem == 1)
			{
				ShowPlayerDialog(playerid, DIALOG_BUGREPORT, DIALOG_STYLE_INPUT, "Report a Bug", "Write a brief explaination of the bug you are reporting.", "Send", "Close");
				return 1;
			}
		}
	}
	if(dialogid == DIALOG_SUGGESTION)
	{
		if(response)
		{
			SendClientMessage(playerid, SCMCOLOR, "Thank you! Your suggestion has been saved for our development team to see.");
			
			new name[MAX_PLAYER_NAME], str[280];
			GetPlayerName(playerid, name, sizeof(name));
				
			new File:openedfile = fopen("feedback.txt", io_append);
				
			fwrite(openedfile, "----------------------------------------------\r\n");
			fwrite(openedfile, "~~ New Suggestion ~~\r\n\r\n");
			format(str, sizeof(str), "Player Name: %s\r\n", name);
			fwrite(openedfile, str);
			format(str, sizeof(str), "Suggestion: %s\r\n\r\n", inputtext);
			fwrite(openedfile, str);
			fwrite(openedfile, "----------------------------------------------\r\n");
			fclose(openedfile);
			
			return 1;
		}
	}
	if(dialogid == DIALOG_BUGREPORT)
	{
		if(response)
		{
			SendClientMessage(playerid, SCMCOLOR, "Thank you! Your bug report has been saved for our development team to see.");
			
			new name[MAX_PLAYER_NAME], str[280];
			GetPlayerName(playerid, name, sizeof(name));
				
			new File:openedfile = fopen("feedback.txt", io_append);
				
			fwrite(openedfile, "----------------------------------------------\r\n");
			fwrite(openedfile, "~~ New Bug Report ~~\r\n\r\n");
			format(str, sizeof(str), "Player Name: %s\r\n", name);
			fwrite(openedfile, str);
			format(str, sizeof(str), "Bug Report: %s\r\n\r\n", inputtext);
			fwrite(openedfile, str);
			fwrite(openedfile, "----------------------------------------------\r\n");
			fclose(openedfile);
			
			return 1;
				
		}
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

CMD:feedback(playerid, params[])
{
	SendClientMessage(playerid, SCMCOLOR, "This command is for gamemode feedback only. If you would like to leave feedback for something else please visit our forum.");
	ShowPlayerDialog(playerid, DIALOG_MAIN, DIALOG_STYLE_LIST, "Your feedback is important! Thank you!", "Suggestion\nReport a bug", "Continue", "Close");
	return 1;
}

CMD:clearfeedback(playerid, params[])
{
	if(IsPlayerAdmin(playerid))
	{
		new confirm[8];
		if(sscanf(params, "%s", confirm)) return SendClientMessage(playerid, 0x4286f4FF, "Are you sure you want to permanently clear the ENTIRE feedback.txt file? To do so type, '/clearfeedback confirm'");
		
		new File:openedfile = fopen("feedback.txt", io_write);
		new str[280];
		new name[MAX_PLAYER_NAME];
		
		GetPlayerName(playerid, name, sizeof(name));
		
		format(str, sizeof(str), "Cleared by %s\r\n", name);
		fwrite(openedfile, str);
	
		fclose(openedfile);
		
		SendClientMessage(playerid, 0x4286f4FF, "[CLEARED] feedback.txt"); 
				
		return 1;
	}
	else return SendClientMessage(playerid, -1, "[ERROR]: You must be logged into the rcon to use this command.");
}

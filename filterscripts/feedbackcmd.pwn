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

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/mycommand", cmdtext, true, 10) == 0)
	{
		// Do something here
		return 1;
	}
	return 0;
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
				
			format(str, sizeof(str), "[SUGGESTION] %s: %s\r\n", name, inputtext);
			fwrite(openedfile, str);
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
				
			format(str, sizeof(str), "[BUG] %s: %s\r\n", name, inputtext);
			fwrite(openedfile, str);
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
		
		if(strcmp(params, "confirm")) return SendClientMessage(playerid, -1, "Are you sure you want to permanently clear the ENTIRE feedback.txt file? To do so type, '/clearfeedback confirm'");
		
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

CMD:viewfeedback(playerid, params[])
{
	new File:handle = fopen("feedback.txt", io_read);
	new dialoglines[250], dialogstring[1000];
	if(handle)
	{
		new line[250];
		new i = 1;
		while(fread(handle, line)) 
		{
			format(dialoglines, sizeof(dialoglines), "[%i] %s", i, line);
			strcat(dialogstring, dialoglines);
			i++;
		}
		fclose(handle);
		ShowPlayerDialog(playerid, 89273, DIALOG_STYLE_MSGBOX, "View Feedback", dialogstring, "Close", "");
	}
	else SendClientMessage (playerid, -1, "error");
	return 1;

}

CrimePlus.Log("Initialising CrimePlus by Lupix")

function CrimePlus.GetCrimeSyndicateMembers(crimeSyn)
	local members = {}

	for k, v in pairs(CrimePlus.CrimeSyndicates[crimeSyn].Members) do
		table.insert(members, k)
	end

	return members
end

AddCSLuaFile("crimeplus/cl_chat.lua")

include("crimeplus/sv_player.lua")
include("crimeplus/sv_hooks.lua")
include("crimeplus/sv_diplomacy.lua")


hook.Add("loadCustomDarkRPItems", "CrimePlus_LoadChatCommands", function() include("crimeplus/sv_chat.lua") end)
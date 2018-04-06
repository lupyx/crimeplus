AddCSLuaFile()

CrimePlus = CrimePlus or {} 

function CrimePlus.Log(text)
	print("[CrimePlus] " .. text)
end

function CrimePlus.AddFailed(name, reason)
	CrimePlus.Log("Could not load Crime Syndicate " .. name .. ": " .. reason)
end

function CrimePlus.AddCrimeSyndicate(name, crimeSynInfo)

	CrimePlus.CrimeSynIndex = CrimePlus.CrimeSynIndex or 1

	for k, v in pairs(CrimePlus.CrimeSyndicates) do

		if not name then
			CrimePlus.AddFailed("Unknown", "You must specify the Name property!")
			return
		end 

		if v.LeaderJob == crimeSynInfo.LeaderJob then
			CrimePlus.AddFailed(name, "The LeaderJob is already registered!")
			return
		end

		if not crimeSynInfo.LeaderTitle then
			CrimePlus.AddFailed(name, "You must specify a LeaderTitle!")
			return
		end

		if v.MemberJob == crimeSynInfo.MemberJob then
			CrimePlus.AddFailed(name, "The MemberJob is already registered!")
			return
		end

		if not crimeSynInfo.Ranks then
			CrimePlus.AddFailed(name, "You must specify the Ranks!")
			return
		end
	end

	local insertIndex = CrimePlus.CrimeSynIndex
	CrimePlus.CrimeSyndicates[insertIndex] = { Id = insertIndex, Name = name, Info = crimeSynInfo, Members = {}, Diplomacy = {} }
	CrimePlus.CrimeSynIndex = CrimePlus.CrimeSynIndex + 1

	CrimePlus.Log(CrimePlus.CrimeSyndicates[insertIndex].Name .. " successfully loaded!")

	return insertIndex
end

-- Load Config Files
AddCSLuaFile("crimeplus/config/sh_crimeplus.lua")
include("crimeplus/config/sh_crimeplus.lua")

hook.Run("CrimePlus_ConfigLoaded")

AddCSLuaFile("crimeplus/config/sh_crimesyndicates.lua")

-- Load Shared Chat commands declarations
AddCSLuaFile("crimeplus/sh_chat.lua")

local function LoadCrimeSyndicates()
	include("crimeplus/config/sh_crimesyndicates.lua")
	hook.Run("CrimePlus_CrimeSyndicatesLoaded")
	include("crimeplus/sh_chat.lua")
end

hook.Add("loadCustomDarkRPItems", "CrimePlus_LoadCrimeSyndicates", LoadCrimeSyndicates)


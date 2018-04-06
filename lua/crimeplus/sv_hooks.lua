util.AddNetworkString("CrimePlus_PromotedToLeader")

local function OnPlayerJoinCrimeSyndicate(ply, oldTeam, newTeam)

	local crimeSyn = ply:GetCrimeSyndicate()
	local isPromotion = false

	if crimeSyn then
		if newTeam == CrimePlus.CrimeSyndicates[crimeSyn].Info.LeaderJob then
			isPromotion = true
		end

		if not isPromotion then
			ply:LeaveCrimeSyndicate()
		end
	end

	if not isPromotion then
		for k, v in pairs(CrimePlus.CrimeSyndicates) do
			if v.Info.MemberJob == newTeam then
				ply:JoinCrimeSyndicate(k)
			end
		end
	else
		local crimeSynName = CrimePlus.CrimeSyndicates[crimeSyn].Name

		net.Start("CrimePlus_PromotedToLeader")
		net.WriteString(crimeSynName)
		net.WriteString(ply:Nick())
		net.WriteString(CrimePlus.CrimeSyndicates[crimeSyn].Info.LeaderTitle)
		net.Send(CrimePlus.GetCrimeSyndicateMembers(crimeSyn))
	end

end

hook.Add("OnPlayerChangedTeam", "CrimePlus_OnPlayerJoinCrimeSyndicate", OnPlayerJoinCrimeSyndicate)

local function OnPlayerDisconnect(ply)

	if ply:GetCrimeSyndicate() then
		ply:LeaveCrimeSyndicate()
	end
end

hook.Add("PlayerDisconnected", "CrimePlus_OnPlayerDisconnect", OnPlayerDisconnect)

local function PlayerDies(ply, weapon, killer)
	print("Player Died")
	if killer:IsValid() and killer:IsPlayer() then
		print("Killer is player")
		local plyCrimeSyn = ply:GetCrimeSyndicate()
		local killerCrimeSyn = killer:GetCrimeSyndicate()
		if plyCrimeSyn and killerCrimeSyn and plyCrimeSyn ~= killerCrimeSyn then
			if CrimePlus.CrimeSyndicates[plyCrimeSyn].Diplomacy[killerCrimeSyn] ~= STANDING_WAR then
				CrimePlus.CrimeSyndicates[plyCrimeSyn].SetDiplomacy(killerCrimeSyn, STANDING_WAR)
			end
		end
	end
end

hook.Add("PlayerDeath", "CrimePlus_PlayerDies", PlayerDies)
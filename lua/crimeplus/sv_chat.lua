util.AddNetworkString("CrimePlus_NotInCrimeSyndicate")
util.AddNetworkString("CrimePlus_CrimeSyndicateChat")
util.AddNetworkString("CrimePlus_NotLeader")
util.AddNetworkString("CrimePlus_TargetNotMember")
util.AddNetworkString("CrimePlus_MemberPromoted")
util.AddNetworkString("CrimePlus_MemberDemoted")
util.AddNetworkString("CrimePlus_AlreadyLowestRank")
util.AddNetworkString("CrimePlus_AlreadyHighestRank")

local function CrimeSyndicateChat(ply, args)
	local crimeSyn = ply:GetCrimeSyndicate()

	if not crimeSyn then
		net.Start("CrimePlus_NotInCrimeSyndicate")
		net.Send(ply)
	else
		local plys = {}

		for k, v in pairs(player.GetAll()) do
			if crimeSyn == v:GetCrimeSyndicate() then
				table.insert(plys, v)
			end
		end

		local crimeSynName = CrimePlus.CrimeSyndicates[crimeSyn].Name
		local plyRankNumber = CrimePlus.CrimeSyndicates[crimeSyn].Members[ply].Rank
		local plyRankName = plyRankNumber == -1 and CrimePlus.CrimeSyndicates[crimeSyn].Info.LeaderTitle or CrimePlus.CrimeSyndicates[crimeSyn].Info.Ranks[plyRankNumber]

		net.Start("CrimePlus_CrimeSyndicateChat")
		net.WriteString(crimeSynName)
		net.WriteString(plyRankName)
		net.WriteString(ply:Nick())
		net.WriteString(args)
		net.Send(plys)
	end


	return ""
end

DarkRP.defineChatCommand("c", CrimeSyndicateChat, 1)
DarkRP.defineChatCommand("syn", CrimeSyndicateChat, 1)

local function Promote(ply)
	local crimeSyn = ply:GetCrimeSyndicate()

	if not crimeSyn then
		net.Start("CrimePlus_NotInCrimeSyndicate")
		net.Send(ply)

		return ""
	end

	if not ply:Team() == CrimePlus.CrimeSyndicates[crimeSyn].Info.LeaderJob then
		net.Start("CrimePlus_NotLeader")
		net.Send(ply)

		return ""
	end

	local ent = ply:GetEyeTrace().Entity

	if ent:IsValid() and ent:IsPlayer() then
		if not ent:GetCrimeSyndicate() == crimeSyn then
			net.Start("CrimePlus_TargetNotMember")
			net.Send(ply)
			return ""
		end

		local targetRank = ent:GetCrimeSyndicateRank()
		if targetRank == #CrimePlus.CrimeSyndicates[crimeSyn].Info.Ranks then
			net.Start("CrimePlus_AlreadyHighestRank")
			net.Send(ply)
			return ""
		end

		CrimePlus.CrimeSyndicates[crimeSyn].Members[ent].Rank = targetRank + 1

		net.Start("CrimePlus_MemberPromoted")
		net.WriteString(CrimePlus.CrimeSyndicates[crimeSyn].Name)
		net.WriteString(ply:Nick())
		net.WriteString(ent:Nick())
		net.WriteString(CrimePlus.CrimeSyndicates[crimeSyn].Info.Ranks[ent:GetCrimeSyndicateRank()])
		net.Send(CrimePlus.GetCrimeSyndicateMembers(crimeSyn))
		return ""
	end

	return ""
end

DarkRP.defineChatCommand("rankup", Promote, 1)

local function Demote(ply)
	local crimeSyn = ply:GetCrimeSyndicate()

	if not crimeSyn then
		net.Start("CrimePlus_NotInCrimeSyndicate")
		net.Send(ply)

		return ""
	end

	if not ply:Team() == CrimePlus.CrimeSyndicates[crimeSyn].Info.LeaderJob then
		net.Start("CrimePlus_NotLeader")
		net.Send(ply)

		return ""
	end

	local ent = ply:GetEyeTrace().Entity

	if ent:IsValid() and ent:IsPlayer() then
		if not ent:GetCrimeSyndicate() == crimeSyn then
			net.Start("CrimePlus_TargetNotMember")
			net.Send(ply)
			return ""
		end

		local targetRank = ent:GetCrimeSyndicateRank()
		if targetRank == 1 then
			net.Start("CrimePlus_AlreadyLowestRank")
			net.Send(ply)
			return ""
		end

		CrimePlus.CrimeSyndicates[crimeSyn].Members[ent].Rank = targetRank - 1

		net.Start("CrimePlus_MemberDemoted")
		net.WriteString(CrimePlus.CrimeSyndicates[crimeSyn].Name)
		net.WriteString(ply:Nick())
		net.WriteString(ent:Nick())
		net.WriteString(CrimePlus.CrimeSyndicates[crimeSyn].Info.Ranks[ent:GetCrimeSyndicateRank()])
		net.Send(CrimePlus.GetCrimeSyndicateMembers(crimeSyn))
		return ""
	end

	return ""
end

DarkRP.defineChatCommand("rankdown", Demote, 1)

hook.Run("CrimePlus_ChatCommandsLoaded")
util.AddNetworkString("CrimePlus_JoinedCrimeSyndicate")
util.AddNetworkString("CrimePlus_LeftCrimeSyndicate")

local meta = FindMetaTable("Player")

function meta:GetCrimeSyndicate()
	return self.CrimeSyndicate
end

function meta:JoinCrimeSyndicate(crimeSyn)
	if not CrimePlus.CrimeSyndicates[crimeSyn] then
		CrimePlus.Log(self:Nick() .. " attempted to join non-existant crime syndicate!")
	else
		self.CrimeSyndicate = crimeSyn
		local memberCount = #(CrimePlus.GetCrimeSyndicateMembers(crimeSyn))
		
		if memberCount > 0 then
			CrimePlus.CrimeSyndicates[crimeSyn].Members[self] = { Rank = 1 }
		else
			CrimePlus.CrimeSyndicates[crimeSyn].Members[self] = { Rank = -1 }
			self:changeTeam(CrimePlus.CrimeSyndicates[crimeSyn].Info.LeaderJob, true)
		end

		net.Start("CrimePlus_JoinedCrimeSyndicate")
		net.WriteString(CrimePlus.CrimeSyndicates[crimeSyn].Name)
		net.Send(self)
	end
end

function meta:LeaveCrimeSyndicate()
	if not self.CrimeSyndicate then
		CrimePlus.Log(self:Nick() .. " attempted to leave crime syndicate while not in one!")
	else
		local crimeSyn = self.CrimeSyndicate
		local crimeSynName = CrimePlus.CrimeSyndicates[crimeSyn].Name
		CrimePlus.CrimeSyndicates[crimeSyn].Members[self] = nil
		self.CrimeSyndicate = nil

		net.Start("CrimePlus_LeftCrimeSyndicate")
		net.WriteString(crimeSynName)
		net.Send(self)
	end
end

function meta:GetCrimeSyndicateRank()
	return CrimePlus.CrimeSyndicates[self.CrimeSyndicate].Members[self].Rank or nil
end

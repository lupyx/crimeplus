-- Crime Syndicate Diplomacies
util.AddNetworkString("CrimePlus_AtWar")
util.AddNetworkString("CrimePlus_Neutral")
util.AddNetworkString("CrimePlus_Allies")

STANDING_ALLIES, STANDING_NEUTRAL, STANDING_WAR = 1, 2, 3 

local function InitDiplomacy()
	print("InitDiplomacy")
	for i=1, #(CrimePlus.CrimeSyndicates) do
		print("Setting relationships for Crime Syndicate")

		CrimePlus.CrimeSyndicates[i].SetDiplomacy = function(otherCrimeSyn, standing)
			print("Diplomacy method")
			CrimePlus.CrimeSyndicates[i].Diplomacy[otherCrimeSyn] = standing  
			CrimePlus.CrimeSyndicates[otherCrimeSyn].Diplomacy[i] = standing

			local selfMembers = CrimePlus.GetCrimeSyndicateMembers(i)
			local otherMembers = CrimePlus.GetCrimeSyndicateMembers(otherCrimeSyn)

			
			local netStartString = ""

			if standing == STANDING_ALLIES then
				netStartString = "CrimePlus_Allies"
			elseif standing == STANDING_NEUTRAL then
				netStartString = "CrimePlus_Neutral"
			elseif standing == STANDING_WAR then
				netStartString = "CrimePlus_AtWar"
			end

			-- Send to own members that your standing has changed
			net.Start(netStartString)
			net.WriteString(CrimePlus.CrimeSyndicates[i].Name)
			net.WriteString(CrimePlus.CrimeSyndicates[otherCrimeSyn].Name)
			net.Send(selfMembers)

			-- Send to other members that their standing has changed
			net.Start(netStartString)
			net.WriteString(CrimePlus.CrimeSyndicates[otherCrimeSyn].Name)
			net.WriteString(CrimePlus.CrimeSyndicates[i].Name)
			net.Send(otherMembers)

		end

		for j=1, #(CrimePlus.CrimeSyndicates) do
			if i ~= j then
				CrimePlus.CrimeSyndicates[i].Diplomacy[j] = STANDING_NEUTRAL
			end
		end
	end
end

hook.Add("CrimePlus_CrimeSyndicatesLoaded", "CrimePlus_InitDiplomacy", InitDiplomacy)




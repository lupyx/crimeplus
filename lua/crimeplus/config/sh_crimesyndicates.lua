-- Crime Syndicates config file

CrimePlus.CrimeSyndicates = CrimePlus.CrimeSyndicates or {} -- Do not touch this line

--[[-------------------------------------------------------------------------
You may add the crime syndicates below
Make the LeaderJob inaccessible from the jobs menu!
This addon will handle people becoming the leader job on its own
---------------------------------------------------------------------------]]

CRIMESYN_COSANOSTRA = CrimePlus.AddCrimeSyndicate("La Cosa Nostra", {
	LeaderJob = TEAM_MOB,
	LeaderTitle = "Godfather",
	MemberJob = TEAM_GANG,
	Ranks = { 
		[1] = "Associate",
		[2] = "Soldato",
		[3] = "Capo", 
		[4] = "Consiglieri",
		[5] = "Underboss"
	}
})

CRIMESYN_TRIADS = CrimePlus.AddCrimeSyndicate("Triads", {
	LeaderJob = TEAM_TRIADLEADER,
	LeaderTitle = "Dragon Head",
	MemberJob = TEAM_TRIAD,
	Ranks = { 
		[1] = "Blue Lantern",
		[2] = "49er",
		[3] = "Red Pole",
		[4] = "Vanguard",
		[5] = "Deputy Dragon Head"
	}
})
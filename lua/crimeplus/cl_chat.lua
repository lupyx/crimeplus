

local function JoinedCrimeSyndicate()
	chat.AddText(Color(238, 44,	44), "[CrimePlus] ", Color(240, 255, 255), "You have joined ", Color(255, 215, 0), net.ReadString(), Color(240, 255, 255), ".")
end

net.Receive("CrimePlus_JoinedCrimeSyndicate", JoinedCrimeSyndicate)

local function LeftCrimeSyndicate()
	chat.AddText(Color(238, 44,	44), "[CrimePlus] ", Color(240, 255, 255), "You have left ", Color(255, 215, 0), net.ReadString(), Color(240, 255, 255), "." )
end

net.Receive("CrimePlus_LeftCrimeSyndicate", LeftCrimeSyndicate)

local function ReceiveCrimeSyndicateChat()
	chat.AddText(Color(238, 44, 44), "[" .. net.ReadString() .. "] ", Color(0, 191, 255), net.ReadString(), Color(0, 238, 0), " " .. net.ReadString(), Color(240, 255, 255), ": " .. net.ReadString())
end

net.Receive("CrimePlus_CrimeSyndicateChat", ReceiveCrimeSyndicateChat)

net.Receive("CrimePlus_NotInCrimeSyndicate", function()
	chat.AddText(Color(238, 44,	44), "[CrimePlus] ", Color(240, 255, 255), "You are not in a Crime Syndicate!")
end)

local function PromotedToLeader()
	chat.AddText(Color(238, 44, 44), "[" .. net.ReadString() .. "] ", Color(0, 238, 0), net.ReadString(), Color(240, 255, 255),  " is the new " , Color(0, 191, 255), net.ReadString(), Color(240, 255, 255), ".")
end

net.Receive("CrimePlus_PromotedToLeader", PromotedToLeader)

local function NotLeader()
	chat.AddText(Color(238, 44,	44), "[CrimePlus] ", Color(240, 255, 255), "You are not the Leader!")
end

net.Receive("CrimePlus_NotLeader", NotLeader)


local function TargetNotMember()
	chat.AddText(Color(238, 44,	44), "[CrimePlus] ", Color(240, 255, 255), "The target is not a member of your Crime Syndicate!")
end

net.Receive("CrimePlus_TargetNotMember", TargetNotMember)

local function MemberPromoted()
	chat.AddText(Color(238, 44, 44), "[" .. net.ReadString() .. "] ", Color(0, 238, 0), net.ReadString(), Color(240, 255, 255),  " has promoted ", Color(0, 238, 0),  net.ReadString(), Color(240, 255, 255), " to ", Color(0, 191, 255), net.ReadString(), Color(240, 255, 255), ".")
end

net.Receive("CrimePlus_MemberPromoted", MemberPromoted)

local function MemberDemoted()
	chat.AddText(Color(238, 44, 44), "[" .. net.ReadString() .. "] ", Color(0, 238, 0), net.ReadString(), Color(240, 255, 255),  " has demoted ", Color(0, 238, 0),  net.ReadString(), Color(240, 255, 255), " to ", Color(0, 191, 255), net.ReadString(), Color(240, 255, 255), ".")
end

net.Receive("CrimePlus_MemberDemoted", MemberDemoted)

local function AlreadyLowestRank()
	chat.AddText(Color(238, 44,	44), "[CrimePlus] ", Color(240, 255, 255), "The target is already the lowest rank!")
end

net.Receive("CrimePlus_AlreadyLowestRank", AlreadyLowestRank)

local function AlreadyHighestRank()
	chat.AddText(Color(238, 44,	44), "[CrimePlus] ", Color(240, 255, 255), "The target is already the highest rank!")
end

net.Receive("CrimePlus_AlreadyHighestRank", AlreadyHighestRank)

local function AtWar()
	chat.AddText(Color(238, 44, 44), "[" .. net.ReadString() .. "] ", Color(240, 255, 255),  "You are now at war with ", Color(238, 44, 44),  net.ReadString(), Color(240, 255, 255), ".")
end

net.Receive("CrimePlus_AtWar", AtWar)

local function Neutral()
	chat.AddText(Color(238, 44, 44), "[" .. net.ReadString() .. "] ", Color(240, 255, 255),  "You are now indifferent to ", Color(108, 123, 139),  net.ReadString(), Color(240, 255, 255), ".")
end

net.Receive("CrimePlus_Neutral", Neutral)

local function Allies()
	chat.AddText(Color(238, 44, 44), "[" .. net.ReadString() .. "] ", Color(240, 255, 255),  "You are now allies of ", Color(0, 238, 0),  net.ReadString(), Color(240, 255, 255), ".")
end

net.Receive("CrimePlus_Allies", Allies)
function removePartyMemberByName(playerId, membername)
local player = Player(playerId)
local party = player:getParty()

for _, member in pairs(party:getMembers()) do 
    if member:getName() == membername then 
        party:removeMember(member)
    end
end
end
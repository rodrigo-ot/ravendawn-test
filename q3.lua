function removePartyMemberByName(playerId, membername)
local player = Player(playerId)
local party = player:getParty()
--gave a proper name to the old v variable
--iterate through every party member looking for the player with given name
for _, member in pairs(party:getMembers()) do 
    -- if member is found, remove them from party
    if member:getName() == membername then 
        party:removeMember(member)
    end
end
end
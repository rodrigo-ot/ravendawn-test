local function releaseStorage(player)
    player:setStorageValue(1000, -1)
end
function onLogout(player)
    if player:getStorageValue(1000) ~= -1 then
        --removed addEvent because player would be offline when it executes
        releaseStorage(player)
    end
    return true
end
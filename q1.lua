function onLogout(player)
    local function releaseStorage()
        player:setStorageValue(1000, -1)
    end

    if player:getStorageValue(1000) ~= -1 then
        releaseStorage()
    end
    return true
end
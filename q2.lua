function printSmallGuildNames(memberCount)
    -- this method is supposed to print names of all guilds that have less than memberCount max members
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    local result = db.storeQuery(string.format(selectGuildQuery, memberCount))
    --checks if had any results on query
    if result ~= nil then
        --iterate through every guild returned by the query and print their name
        while result.next() do
            local guildName = result.getString("name")
            print(guildName)
        end
    end
end
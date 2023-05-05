local DIST = 3 -- maximum distance to walk
local INTERVAL = 50 -- interval between teleportations
local dir = { -- directional vectors
	[0] = {x =0, y = -1, z=0},
	[1] = {x =1, y = 0, z=0},
	[2] = {x =0, y = 1, z=0},
	[3] = {x =-1, y = 0, z=0} 
}
-- In my opinion, the next two functions (canWalk and findFarthestWalkable) 
--should be declared in libs because they could be used by other codes. 
--However, for the sake of practicality, considering that someone will test it, I left everything in the same file.

-- checks if a given position is walkable
local function canWalk(pos)
	local tile = Tile(pos)
	return tile and tile:getGround() and not tile:hasProperty(CONST_PROP_IMMOVABLEBLOCKSOLID)
end

-- finds the farthest walkable position in a given direction from a starting position
local function findFarthestWalkable(direction, fromPos, distance)
    local lastPos = fromPos
   
    for i = 1, distance do
        local nextPos = {x = lastPos.x + dir[direction].x, y = lastPos.y + dir[direction].y, z = lastPos.z + dir[direction].z}
        if canWalk(nextPos) then
            lastPos = nextPos
        else
            break
        end
    end
    return lastPos
end

function onCastSpell(creature, variant)
	-- get direction and position of caster
	local direction = creature:getDirection()
	local pos = creature:getPosition()
	
	-- if direction is valid
	if dir[direction] then
		-- find the farthest walkable position in the given direction
		local nextpos = findFarthestWalkable(direction, pos, DIST)
		creature:teleportTo(nextpos) -- teleport to the next position
		--individual teleportations
		for i=1,DIST+1 do
			addEvent(function()
				-- if the next position is walkable
				if canWalk(nextpos) then
					creature:teleportTo(nextpos) -- teleport to the next position
					pos = creature:getPosition() -- update position
					nextpos = {x = pos.x + dir[direction].x, y = pos.y + dir[direction].y, z = pos.z + dir[direction].z} -- calculate next position
				end
			end, i*INTERVAL) -- add event with delay
		end
	end

    return true
end
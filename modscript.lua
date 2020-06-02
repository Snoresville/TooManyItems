--- config
require("config")

--- creates an item pool which contains vanilla items.
local allItems = ItemPool.new("all items")
allItems.ignoreLocks = false
allItems.ignoreEnigma = true

local common = ItemPool.find("common"):toList()
for _, item in ipairs(common) do
    allItems:add(item)
end

local uncommon = ItemPool.find("uncommon"):toList()
for _, item in ipairs(uncommon) do
    allItems:add(item)
end

local rare = ItemPool.find("rare"):toList()
for _, item in ipairs(rare) do
    allItems:add(item)
end

allItems.weighted = false

--- on enemy death, drops an item
registercallback("onNPCDeathProc", function(npc, players)
	-- chance check, if unsuccessful, will not drop an item
	if math.random() > PERCENTAGE_SPAWN_CHANCE/100 then return end
	
	-- setting location of item spawn
	local locationX = npc.x
	local locationY = npc.y
	
	if SPAWN_ITEMS_AT_PLAYER then
		locationX = players.x
		locationY = players.y
	end
	
	-- creates the item
	local maxItems = math.random(SPAWN_ITEM_MAX)
	for numberDrops = 1, SPAWN_ITEM_COUNT do
		allItems:roll():getObject():create(locationX, locationY)
	end
end)
--- config
require("config")

--- creates an item pool which contains vanilla items.
local allItems = ItemPool.new("all items")
if SPAWN_LOCKED_ITEMS == false then allItems.ignoreLocks = false 
else allItems.ignoreLocks = true end
allItems.ignoreEnigma = true

local common = ItemPool.find("common"):toList()
for _, item in ipairs(common) do
    allItems:add(item)
	allItems:setWeight(item, ITEM_COMMON_WEIGHT)
end

local uncommon = ItemPool.find("uncommon"):toList()
for _, item in ipairs(uncommon) do
    allItems:add(item)
	allItems:setWeight(item, ITEM_UNCOMMON_WEIGHT)
end

local rare = ItemPool.find("rare"):toList()
for _, item in ipairs(rare) do
    allItems:add(item)
	allItems:setWeight(item, ITEM_RARE_WEIGHT)
end

if ITEM_RARITY_BALANCE == false then allItems.weighted = false 
else allItems.weighted = true end

--- on enemy death, drops an item
registercallback("onNPCDeathProc", function(npc, players)
	-- chance check, if unsuccessful, will not drop an item
	if math.random() > PERCENTAGE_SPAWN_CHANCE/100 then return end
	
	-- setting location of item spawn
	local locationX = npc.x
	local locationY = npc.y
	
	-- items will always spawn at each player's location if multiplayer
	if SPAWN_ITEMS_AT_PLAYER or #misc.players > 1 then
		locationX = players.x
		locationY = players.y
	end
	
	-- creates the item
	local maxItems = math.random(SPAWN_ITEM_MAX)
	for numberDrops = 1, maxItems do
		allItems:roll():getObject():create(locationX, locationY)
	end
end)
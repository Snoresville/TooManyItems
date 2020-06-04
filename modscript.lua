--- config
require("config")

--- creates an item pool which contains vanilla items.
local allItems = ItemPool.new("TooManyItems_Pool")

-- loads vanilla pools and a function for insertion
local vanillaPools = {
	ItemPool.find("common", "vanilla"), -- commons
	ItemPool.find("uncommon", "vanilla"), -- uncommons
	ItemPool.find("rare", "vanilla"), -- rares
	ItemPool.find("use", "vanilla") -- use items
}

function insertItemPool(itemPool)
	local itemList = itemPool:toList()
	for _, item in ipairs(itemList) do
		if item.color == "or" and SPAWN_USE_ITEMS == false then goto insertItemPoolSkip end -- use item check
	
		allItems:add(item)
		if item.color == "w" then allItems:setWeight(item, ITEM_COMMON_WEIGHT) end
		if item.color == "g" then allItems:setWeight(item, ITEM_UNCOMMON_WEIGHT) end
		if item.color == "r" then allItems:setWeight(item, ITEM_RARE_WEIGHT) end
		if item.color == "or" then allItems:setWeight(item, ITEM_USE_WEIGHT) end
		
		::insertItemPoolSkip::
	end
end

for _, itemPool in ipairs(vanillaPools) do
	insertItemPool(itemPool)
end

-- item pool options
if SPAWN_LOCKED_ITEMS == false then allItems.ignoreLocks = false 
else allItems.ignoreLocks = true end

allItems.ignoreEnigma = true

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
	local maxItems = math.random(math.floor(SPAWN_ITEM_MAX))
	for numberDrops = 1, maxItems do
		allItems:roll():getObject():create(locationX, locationY)
	end
end)
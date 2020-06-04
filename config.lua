--- easily modifiable variables.
--- for true/false variables, just set them to one or the other in order to activate/deactivate the variables
--- for numerical variables, pick a number that makes sense.
SPAWN_ITEMS_AT_PLAYER = false -- if the items are dropped at the player or where the monster died. this is forced to be true in multiplayer.
PERCENTAGE_SPAWN_CHANCE = 100 -- chance to spawn items. 100% is guaranteed item drop
SPAWN_ITEM_MAX = 1 -- if there's a chance to spawn items, this integer variable determines the maximum number of items spawned
SPAWN_LOCKED_ITEMS = true -- enemies can also drop items not unlocked yet.
SPAWN_USE_ITEMS = false -- if use items can be dropped by enemies

--- Rarity Balance
ITEM_RARITY_BALANCE = false -- setting this to true will change the probabilities of each rarity class.
--- Higher weights lead to greater probability of obtaining an item from a certain rarity.
--- Leads to no change if the weights are close to each other.
ITEM_COMMON_WEIGHT = 10
ITEM_UNCOMMON_WEIGHT = 6
ITEM_RARE_WEIGHT = 3
ITEM_USE_WEIGHT = 1
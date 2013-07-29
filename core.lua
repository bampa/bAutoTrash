----------------------------------------
-- bAutoTrash (Bampalicious @ Draenor EU)
-- https://github.com/bampa
----------------------------------------

local _, ns = ...

local f = CreateFrame('Frame')

if AutoTrash == nil then AutoTrash = false end -- To automatically trash or not to automatically trash, that is the setting
if bAutoTrashDB == nil then bAutoTrashDB = {} end -- DB of items that are supposed to be trashed

function ns.TrashItem(item)
	name = ns.Strip(item)
	local deteled = false
	for bag = 0, 4 do
		for slot = 1, GetContainerNumSlots(bag) do
			itemId = GetContainerItemID(bag, slot)
			_, count, _, _, _, _, link = GetContainerItemInfo(bag, slot)
			if(link) then
				iName = GetItemInfo(itemId)
				if(iName == name) then
					PickupContainerItem(bag, slot)
					DeleteCursorItem()
					deleted = true
				end
			end			
		end
	end
	if deleted then print("|cffe51616AutoTrash:|r Deleted item "..name) else end
end

function ns.TrashFromList()
	for k,item in pairs(bAutoTrashDB) do
		ns.TrashItem(item)
	end
end

f:SetScript("OnEvent", function(self, event, ...) if self[event]then return self[event](self, event, ...) end end)

f:RegisterEvent("ADDON_LOADED")

function f:ADDON_LOADED(event, addon)
	f:RegisterEvent("CHAT_MSG_LOOT")
	f:UnregisterEvent("ADDON_LOADED")
end

function f:CHAT_MSG_LOOT(event, message, chatLineId, ...)	
	if string.find(message, "You receive") then 
		local itemName = ns.Strip(message)		
		if ns.Exists(itemName) and AutoTrash then ns.TrashItem(itemName) end		
	end
end

SLASH_TRASH1 = '/trash'
SlashCmdList['TRASH'] = ns.SlashHandler
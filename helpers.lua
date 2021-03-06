local _, ns = ...

function ns.Strip(input)
	local itemString = string.match(input, "item[%-?%d:]+")
	if itemString == nil then return input
	else 
		return string.match(input, "h?%[?([^%[%]]*)%]+")
	end	
end

function ns.Exists(name)
	local index
	for k,item in pairs(bAutoTrashDB) do
		if item == name then index = k end
	end
	
	return index
end

function ns.SlashHandler(msg, editbox)
	local cmd, arg = msg:match("^(%S*)%s*(.-)$")
	if cmd ~= '' then
		if cmd == "all" then			
			ns.TrashFromList()			
		elseif cmd == "auto" then
			if arg == 'on' then
				AutoTrash = true
				print("|cffade516bAutoTrash:|r Automatically trashing items!|r")
			elseif arg == 'off' then
				AutoTrash = false
				print("|cffe51616bAutoTrash:|r Not automatically trashing items!|r")			
			else
				if AutoTrash then
					print("|cffade516bAutoTrash:|r Currently automatically trashing items!|r")
				else
					print("|cffe51616bAutoTrash:|r Currently not automatically trashing items!|r")
				end				
			end		
		elseif cmd == "add" then
			if arg ~= '' and not ns.Exists(ns.Strip(arg)) then
				table.insert(bAutoTrashDB, ns.Strip(arg))
				print("|cffade516bAutoTrash:|r Added item "..ns.Strip(arg).." to AutoTrash list")
			else 
				print("|cffe51616bAutoTrash:|r You need to specify an item name, or item link!") 
			end
		elseif cmd == "remove" then
			if(arg ~= '') then
				local index = ns.Exists(ns.Strip(arg))
				if index then
					table.remove(bAutoTrashDB, index)
					print("|cffade516bAutoTrash:|r Removed item "..ns.Strip(arg).." from AutoTrash list")
				else
					print("|cffe51616bAutoTrash:|r Item "..arg.." does not exist in AutoTrash list!")
				end
			else
				print("|cffe51616bAutoTrash:|r Please provide an item name or item link!")
			end
		elseif cmd == "list" then
			print("|cffe51616bAutoTrash|r: AutoTrash list") 
			for k,item in pairs(bAutoTrashDB) do
				print(item)
			end		
		elseif cmd == "clear" then
			wipe(bAutoTrashDB)
			print("|cffade516bAutoTrash:|r AutoTrash list cleared!")		
		elseif cmd == "value" then
			local value, t = arg:match("(%d+)(%w+)")
			if t == "g" then 
				AutoTrashValue = string.format("%d0000", value)
				print("|cffade516bAutoTrash:|r AutoTrashValue is now set to " .. value .. t)
			elseif t == "s" then
				AutoTrashValue = string.format("%d00", value)
				print("|cffade516bAutoTrash:|r AutoTrashValue is now set to " .. value .. t)
			elseif t == "c" then
				AutoTrashValue = value
				print("|cffade516bAutoTrash:|r AutoTrashValue is now set to " .. value .. t)
			else
				if AutoTrashValue ~= nil then 
					value, currency = ns.FormatCurrency(AutoTrashValue)
					print("|cffade516bAutoTrash:|r AutoTrashValue is set to " .. value .. currency)
				else
					print("|cffe51616bAutoTrash:|r Please provide a correct value such as 1s!")
				end
			end
		else			
			ns.TrashItem(msg)
		end
	else
		print("|cffe4ff00bAutoTrash Syntax:|r")
		print("To trash one kind of item")
		print("/trash |cffade516[itemname/link]|r")
		print("To trash all items in the items list")
		print("/trash |cffade516[all]|r")
		print("To Enable/Disable AutoTrash for items")
		print("/trash |cffade516[auto]|r on/off")
		print("To manage the trash list (if you don't want to update the lua file):")
		print("/trash |cffade516[add]|r itemname/link to add an item to the AutoTrash list")
		print("/trash |cffade516[remove]|r itemname/link to remove an item from the AutoTrash list")
		print("/trash |cffade516[list]|r to show all items in the AutoTrash list")
		print("/trash |cffade516[clear]|r to clear the AutoTrash list")
		print("To automatically trash grey items below a certain value:")		
		print("/trash |cffade516[value]|r [number][c/s/g] (e.g. 1s for 1 silver) or leave it blank to see the current value")
		print("AutoTrash must be |cffade516ON|r as well to automatically trash grey items")
	end
end

function ns.FormatCurrency(value)
	local num = tonumber(value)
	if num > 0 and num <= 99 then return value, "c"
	elseif num >= 100 and num <= 9900 then return string.sub(value, 1,-3), "s"
	elseif num >= 10000 then return string.sub(value, 1, -5), "g" end
end

-- Taken from http://www.wowwiki.com/Wait
function ns.Wait(delay, func, ...)
	local waitTable = {}
	local waitFrame = nil
	
	if type(delay) ~= "number" or type(func) ~= "function" then
		return false
	end
	if waitFrame == nil then
		waitFrame = CreateFrame("Frame", "WaitFrame", UIParent)		
		waitFrame:SetScript("onUpdate", function(self, elapse)
			local count = #waitTable
			local i = 1
			while i <= count do
				local waitRecord = tremove(waitTable, i)
				local d = tremove(waitRecord, 1)
				local f = tremove(waitRecord, 1)
				local p = tremove(waitRecord, 1)
				if d > elapse then
					tinsert(waitTable, i, { d - elapse, f, p })
					i = i + 1
				else
					count = count - 1
					f(unpack(p))
				end
			end
		end)
	end
	
	tinsert(waitTable, { delay, func, { ... } })
	return true
end
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('esx_society:registerSociety', 'taxi', 'Taxi', 'society_taxi', 'society_taxi', 'society_taxi', {type = 'public'})

-- Annonces

-- RegisterNetEvent('ouvert')
-- AddEventHandler('ouvert', function()
-- 	local _source = source

--     TriggerClientEvent('esx:showAdvancedNotification', source, 'Taxi', '~g~Les taxis sont en Services !~s~', 'CHAR_PROPERTY_TAXI_LOT')
-- end)

-- RegisterNetEvent('fermer')
-- AddEventHandler('fermer', function()
-- 	local _source = source

--     TriggerClientEvent('esx:showAdvancedNotification', source, 'Taxi', '~r~Les taxis sont Hors-Services !~s~', 'CHAR_PROPERTY_TAXI_LOT')
-- end)

RegisterServerEvent('ouvert')
AddEventHandler('ouvert', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Taxi', '~b~Annonce', 'Les taxis sont en Services !', 'CHAR_PROPERTY_TAXI_LOT', 8)
	end
end)

RegisterServerEvent('fermer')
AddEventHandler('fermer', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Taxi', '~b~Annonce', 'Les taxis sont Fermer !', 'CHAR_PROPERTY_TAXI_LOT', 8)
	end
end)

-------------------- Coffre
RegisterServerEvent('aTaxi:prendreitems')
AddEventHandler('aTaxi:prendreitems', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_taxi', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then

			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _source, "quantit?? invalide")
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, 'Objet retir??', count, inventoryItem.label)
			end
		else
			TriggerClientEvent('esx:showNotification', _source, "quantit?? invalide")
		end
	end)
end)


RegisterNetEvent('aTaxi:stockitem')
AddEventHandler('aTaxi:stockitem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_taxi', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', _source, "Objet d??pos?? "..count..""..inventoryItem.label.."")
		else
			TriggerClientEvent('esx:showNotification', _source, "quantit?? invalide")
		end
	end)
end)


ESX.RegisterServerCallback('aTaxi:inventairejoueur', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

ESX.RegisterServerCallback('aTaxi:prendreitem', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_taxi', function(inventory)
		cb(inventory.items)
	end)
end)
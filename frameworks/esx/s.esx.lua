if Shared.Framework ~= "ESX" then return end  
local ESX = nil
CreateThread(function()
    
    ESX = exports["es_extended"]:getSharedObject()

    Core.getIdentifier = function(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        return xPlayer.identifier
    end

    Core.registerItem = function(item, func)
        ESX.RegisterUsableItem(item, function(playerId)
            func(playerId)
        end)
    end

    Core.addCash = function(source, amount)
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.addMoney(amount) 
        return true 
    end

    Core.addItem = function(source, item, amount)
        if not Core.canCarry(source, item, amount) then
            return false
        end
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.addInventoryItem(item, amount)
        return true
    end

    Core.removeItem = function(source, item, amount)
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.removeInventoryItem(item, amount)
        return true
    end

    Core.getItemCount = function(source, item)
        local xPlayer = ESX.GetPlayerFromId(source)
        return xPlayer.getInventoryItem(item).count
    end

    Core.canCarry = function(source, item, amount)
        local xPlayer = ESX.GetPlayerFromId(source)
        local itemWeight = ESX.GetItem(item).weight
        local currentWeight = xPlayer.getWeight()
        local maxWeight = xPlayer.maxWeight
        local newWeight = currentWeight + (itemWeight * amount)
        if newWeight > maxWeight then
            return false
        end
        return true
    end

    Core.removeCash = function(source, amount)
        print("Removing cash", source, amount)
        local xPlayer = ESX.GetPlayerFromId(source)
        print("Cash: ", xPlayer.getMoney())
        if xPlayer.getMoney() < amount then 
            return false
        end
        print("Passed check")
        xPlayer.removeMoney(amount)
        return true
    end

    Core.getCash = function(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        return xPlayer.getMoney()
    end

    Core.getBank = function(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        return xPlayer.getAccount("bank").money
    end

    Core.removeBank = function(source, balance, amount)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.getAccount("bank").money < amount then 
            return false
        end
        xPlayer.removeAccountMoney("bank", amount)
        return true
    end

    Core.addBank = function(source, amount)
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.addAccountMoney("bank", amount)
        return true
    end

    Core.getJob = function(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        local jobData = {
            name = xPlayer.job.name or "unemployed",
            grade = xPlayer.job.grade or 0,
            onDuty = xPlayer.job.onDuty or false,
        }
        return jobData
    end

    Core.getFullName = function(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        return xPlayer.getName()
    end

    Core.Loaded = true
end)
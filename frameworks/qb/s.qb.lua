if Shared.Framework ~= "QBCore" then return end  
QBCore = nil

CreateThread(function()
    Wait(5000)
    QBCore = exports['qb-core']:GetCoreObject()

    Core.GetIdentifier = function(source)
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player then return false end
        return Player.PlayerData.citizenid
    end
    
    Core.RegisterItem = function(item, func)
        QBCore.Functions.CreateUseableItem(item, function(source, item)
            func(source)
        end)
    end
    
    Core.AddCash = function(source, amount)
        local Player = QBCore.Functions.GetPlayer(source)
        Player.Functions.AddMoney('cash', amount)
        return true
    end
    
    Core.RemoveCash = function(source, amount)
        local Player = QBCore.Functions.GetPlayer(source)
        if Player.PlayerData.money['cash'] < amount then
            return false
        end
        Player.Functions.RemoveMoney('cash', amount)
        return true
    end
    
    Core.GetCash = function(source)
        local Player = QBCore.Functions.GetPlayer(source)
        return Player.PlayerData.money['cash']
    end

    Core.GetBank = function(source)
        local accountName = Core.GetIdentifier(source)
        return exports['qb-banking']:GetAccountBalance(accountName)
    end
    
    Core.AddBank = function(source, amount)
        local accountName = Core.GetIdentifier(source)
        return exports['qb-banking']:AddMoney(accountName, amount)
    end

    Core.RemoveBank = function(source, amount)
        local accountName = Core.GetIdentifier(source)
        return exports['qb-banking']:RemoveMoney(accountName, amount)
    end

    Core.AddItem = function(source, item, amount)
        return exports['qb-inventory']:AddItem(source, item, amount)
    end

    Core.RemoveItem = function(source, item, amount)
        return exports['qb-inventory']:RemoveItem(source, item, amount)
    end

    Core.GetItemCount = function(source, item)
        return exports['qb-inventory']:GetItemCount(source, item)
    end

    Core.CanCarry = function(source, item, amount)
        return exports['qb-inventory']:CanAddItem(source, item, amount)
    end

    Core.GetJob = function(source)
        local xPlayer = QBCore.Functions.GetPlayer(source)
        local jobData = {
            name = xPlayer.PlayerData.job.name or "unemployed",
            label = xPlayer.PlayerData.job.label or "Unemployed",
            grade = xPlayer.PlayerData.job.grade or 0,
            onDuty = xPlayer.PlayerData.job.onDuty or false,
        }
        return jobData
    end

    Core.GetFullName = function(source)
        local xPlayer = QBCore.Functions.GetPlayer(source)
        return xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname
    end

    Core.Loaded = true
end)
if Shared.Framework ~= "QBCore" then return end  

CreateThread(function()
    
    QBCore = exports['qb-core']:GetCoreObject()

    Core.getIdentifier = function(source)
        local Player = QBCore.Functions.GetPlayer(source)
        return Player.PlayerData.citizenid
    end
    
    Core.registerItem = function(item, func)
        QBCore.Functions.CreateUseableItem(item, function(source, item)
            func(source)
        end)
    end
    
    Core.addCash = function(source, amount)
        local Player = QBCore.Functions.GetPlayer(source)
        Player.Functions.AddMoney('cash', amount)
        return true
    end
    
    Core.removeCash = function(source, amount)
        local Player = QBCore.Functions.GetPlayer(source)
        if Player.PlayerData.money['cash'] < amount then
            return false
        end
        Player.Functions.RemoveMoney('cash', amount)
        return true
    end
    
    Core.getCash = function(source)
        local Player = QBCore.Functions.GetPlayer(source)
        return Player.PlayerData.money['cash']
    end
    Core.Loaded = true
end)
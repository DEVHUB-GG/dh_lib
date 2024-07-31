if Shared.Framework ~= "ESX" then return end
   
CreateThread( function()
    RegisterNetEvent("esx:playerLoaded",function()
        TriggerEvent("dh_lib:client:playerLoaded")
    end)

    RegisterNetEvent("esx:onPlayerDeath",function()
        TriggerEvent("dh_lib:client:setDeathStatus", true)
    end)

    AddEventHandler('playerSpawned', function()
        TriggerEvent("dh_lib:client:setDeathStatus", false)
    end)

    Core.Loaded = true
end)
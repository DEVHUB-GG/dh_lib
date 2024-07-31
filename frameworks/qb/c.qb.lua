if Shared.Framework ~= "QBCore" then return end
   
CreateThread( function()
    RegisterNetEvent("QBCore:Client:OnPlayerLoaded",function()
        TriggerEvent("dh_lib:client:playerLoaded")
        TriggerServerEvent("dh_lib:server:playerLoaded", GetPlayerServerId(PlayerId()))
    end)

    RegisterNetEvent("hospital:server:SetDeathStatus",function(isDead)
        TriggerEvent("dh_lib:client:setDeathStatus", isDead)
    end)

    Core.Loaded = true
end)
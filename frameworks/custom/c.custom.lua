if Shared.Framework ~= "custom" then return end
   
CreateThread( function()
    Core.Loaded = true

    -- Registers an event for when the player is loaded.
    RegisterNetEvent("OnPlayerLoaded", function()
        TriggerEvent("dh_lib:client:playerLoaded")
        TriggerServerEvent("dh_lib:server:playerLoaded", GetPlayerServerId(PlayerId()))
    end)

    -- Registers an event to set the player's death status.
    -- @param isDead A boolean indicating the player's death status.
    RegisterNetEvent("SetDeathStatus", function(isDead)
        TriggerEvent("dh_lib:client:setDeathStatus", isDead)
    end)
end)
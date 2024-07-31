function Core.Notify(source, text, duration)
    TriggerClientEvent("dh_lib:client:notify", source, text, duration)
end

Core.SendLog = function(source, webhook, data)
    TriggerEvent("dh_lib:server:sendLog", source, webhook, data)
end
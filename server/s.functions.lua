function Core.Notify(source, text, duration)
    TriggerClientEvent("dh_lib:client:notify", source, text, duration)
end
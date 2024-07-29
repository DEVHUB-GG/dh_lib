if Shared.Framework ~= "QBCore" then 
    return
end
   
CreateThread( function()
    Core.Loaded = true
end)
if Shared.Framework ~= "ESX" then 
    return
end
   
CreateThread( function()
    Core.Loaded = true
end)
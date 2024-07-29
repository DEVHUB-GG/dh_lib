if Shared.Framework ~= "custom" then 
    return
end
   
CreateThread( function()
    Core.Loaded = true
end)
if Shared.Target ~= "qb-target" then return end 
CreateThread( function() 

    Core.AddModelToTarget = function(model, data)
        -- exports["qb-target"]:AddModel(model, {
        --     name = data.name, 
        --     event = data.event,
        --     icon = data.icon,
        --     label = data.label,
        --     canInteract = data.handler
        -- })
    end
end)
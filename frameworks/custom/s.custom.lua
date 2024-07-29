if Shared.Framework ~= "custom" then return end  

CreateThread(function()
    -- Retrieves the identifier of a player.
    -- @param source The player's source ID.
    -- @return The identifier of the player.
    Core.getIdentifier = function(source)
        -- code here
        return ""
    end

    -- Registers an item with a corresponding function.
    -- @param item The item to register.
    -- @param func The function to be called when the item is used.
    -- The function should take a single parameter, the player's source ID.
    -- @return void
    Core.registerItem = function(item, func)
        -- RegisterUsableItem(item, function(playerId)
        --     func(playerId)
        -- end)
    end

    -- Adds cash to the player's account.
    -- @param source The player's source ID.
    -- @param amount The amount of cash to add.
    -- @return True if the cash was successfully added, false otherwise.
    Core.addCash = function(source, amount)
        return true 
    end

    -- Removes cash from the player's account.
    -- @param source The player's source ID.
    -- @param amount The amount of cash to remove.
    -- @return True if the cash was successfully removed, false otherwise.
    Core.removeCash = function(source, amount)
        return true
    end

    -- Gets the amount of cash in the player's account.
    -- @param source The player's source ID.
    -- @return The amount of cash in the player's account.
    Core.getCash = function(source)
        return 10000
    end

    Core.Loaded = true
end)
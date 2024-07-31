CustomUi = {}

-- Displays a notification to the user.
-- @param text The text of the notification.
-- @param duration The duration for which the notification should be displayed. In milliseconds.
-- @param notificationType The type of the notification.
-- @return False if the default notification system is used, true if a custom notification system is used.
CustomUi.Notify = function(text, duration, notificationType)
    return false -- if you are using a custom notification, return true
end

-- Displays a static message to the user.
-- @param text The text of the static message, if false ui is hidden.
-- @return False if the default static message system is used, true if a custom static message system is used.
CustomUi.ShowStaticMessage = function(text)
    return false -- if you are using a custom static message, return true
end

-- Displays control buttons to the user.
-- @param text The text associated with the control buttons, if false ui is hidden.
-- @return False if the default control buttons system is used, true if a custom control buttons system is used.
CustomUi.ShowControlButtons = function(text)
    return false -- if you are using a custom control buttons system, return true
end

-- Displays a progress bar to the user.
-- @param data The data for the progress bar. 
    -- @param data.duration The duration for which the progress bar should be displayed. In milliseconds.
    -- @param data.text The text associated with the progress bar.
    -- @param data.canStop A boolean indicating whether the progress bar can be stopped by the user.
    -- @param data.placement The placement of the progress bar. Default low.
-- @param cb The callback function to be executed when the progress bar completes.
-- @return False if the default progress bar system is used, true if a custom progress bar system is used.
CustomUi.ShowProgressbar = function(data, cb)
    return false -- if you are using a custom progress bar, return true
end

-- Closes the progress bar.
-- @return False if the default progress bar system is used, true if a custom progress bar system is used.
CustomUi.CloseProgressbar = function()
    return false -- if you are using a custom progress bar, return true
end
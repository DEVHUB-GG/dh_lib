function Core.DumpTable(table, nb)
    if nb == nil then 
        nb = 0
    end 
    if type(table) == 'table' then
        local s = ''
        for i = 1, nb + 1, 1 do
            s = s .. "    "
        end
        s = '{\n'
        for k,v in pairs(table) do
            if type(k) ~= 'number' then k = '"'..k..'"' end
            for i = 1, nb, 1 do
                s = s .. "    "
            end
            s = s .. '['..k..'] = ' .. Core.DumpTable(v, nb + 1) .. '",\n'
        end
        for i = 1, nb, 1 do
            s = s .. "    "
        end
        return s .. '}'
    else
        return tostring(table)
    end
end
function Core.RequestModel(modelHash, cb)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(1)
		end
	end

	if cb ~= nil then
		cb()
	end
end

function Core.GetClosestVehicle(coords)
    local ped = PlayerPedId()
    local vehicles = GetGamePool('CVehicle')
    local closestDistance = -1
    local closestVehicle = -1
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(ped)
    end
    for i = 1, #vehicles, 1 do
        local vehicleCoords = GetEntityCoords(vehicles[i])
        local distance = #(vehicleCoords - coords)

        if closestDistance == -1 or closestDistance > distance then
            closestVehicle = vehicles[i]
            closestDistance = distance
        end
    end
    return closestVehicle, closestDistance
end
function Core.GetObjects()
	return GetGamePool('CObject') 
end 

function Core.SpawnObject(model, coords, cb, isLocal)
	local model = (type(model) == 'number' and model or GetHashKey(model))

	Citizen.CreateThread(function()
		Core.RequestModel(model)
		local networked = true 
		if isLocal == false then 
			networked = false
		end
		local obj = CreateObject(model, coords.x, coords.y, coords.z, networked, false, networked)
		if cb then
			cb(obj)
		end
	end)
end

function Core.SpawnVehicle(modelName, coords, heading, cb, _networked)
	local model = (type(modelName) == 'number' and modelName or GetHashKey(modelName))
	Citizen.CreateThread(function()
		Core.RequestModel(model)
		local networked = _networked ~= nil and _networked or true
		local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, heading, networked, networked)
		local id      = NetworkGetNetworkIdFromEntity(vehicle)
		SetNetworkIdCanMigrate(id, true)
		SetModelAsNoLongerNeeded(model)
		SetVehicleAsNoLongerNeeded(vehicle)
		SetVehicleNeedsToBeHotwired(vehicle, false)
        SetVehicleHasBeenOwnedByPlayer(vehicle, true)
        SetEntityAsMissionEntity(vehicle, true, true)
        SetVehicleIsStolen(vehicle, false)
        SetVehicleIsWanted(vehicle, false)
        SetVehRadioStation(vehicle, 'OFF')
        RequestCollisionAtCoord(coords.x, coords.y, coords.z)
		while not HasCollisionLoadedAroundEntity(vehicle) do
			RequestCollisionAtCoord(coords.x, coords.y, coords.z)
			Citizen.Wait(0)
		end
		if cb ~= nil then
			cb(vehicle)
		end
	end)
end 

function Core.IsSpawnPointClear(coords, radius)
    local vehicles = GetGamePool('CVehicle')
	for i=1, #vehicles, 1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local dist = #(coords - vehicleCoords)
		if dist <= radius then
			return false
		end
	end
	return true
end

function Core.AddBlip(coords, sprite, color, scale, name)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, color)
    SetBlipScale(blip, scale)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(name)
    EndTextCommandSetBlipName(blip)
    return blip
end

function Core.GetClosestPlayers(distance)
    if not distance then distance = 10.0 end
    local players = {}
    local pid = PlayerId()
    local activePlayers = GetActivePlayers()
    local coords = GetEntityCoords(PlayerPedId())

    for i = 1, #activePlayers do
        local currPlayer = activePlayers[i]
        local ped = GetPlayerPed(currPlayer)
        if DoesEntityExist(ped) and currPlayer ~= pid then
            local plyCoords = GetEntityCoords(ped)
            local dist = #(coords - plyCoords)
            if dist <= distance then
                players[#players + 1] = { ped = ped, player = currPlayer, id = GetPlayerServerId(currPlayer), name = GetPlayerName(currPlayer), distance = dist}
            end
        end
    end

    return players
end


function generateRandomChar(lenght)
    local charset = {}
    for i = 48,  57 do table.insert(charset, string.char(i)) end
    for i = 65,  90 do table.insert(charset, string.char(i)) end
    for i = 97, 122 do table.insert(charset, string.char(i)) end
    if not lenght or lenght <= 0 then return '' end
    return generateRandomChar(lenght - 1) .. charset[math.random(1, #charset)]
end
 
function Core.Notify(text, duration, notificationType)
    -- placement: low, medium, high
    -- notificationType: 'info', 'error', 'success', 'warning'
    local placement = "top-right"
    local duration = tonumber(duration) or 5000
    SendNUIMessage({
        type = "notify",
        placement = placement,
        text = text,
        duration = duration
    })
end
RegisterNetEvent("dh_lib:client:notify", function(text, duration)
    Core.Notify(text, duration)
end)


function Core.ShowStaticMessage(text, status)
    -- placement: top-left, top-right, bottom-left, bottom-right, top-center, bottom-center
    local placement = "top-left"
    SendNUIMessage({
        type = "static",
        text = text,
        placement = placement,
        close = status
    })
end

function Core.ShowControlButtons(text, status)
    -- placement: top-left, top-right, bottom-left, bottom-right, top-center, bottom-center
    local placement = "bottom-right"
    SendNUIMessage({
        type = "controls",
        text = text,
        placement = placement,
        close = status
    })
end

local progressbarCb = nil
local progressbarBusy = false
function Core.ShowProgressbar(data, cb)
    if progressbarBusy then print("Progressbar is busy") return end
    progressbarBusy = true
    local duration = data?.duration --@required in ms
    if not duration then print("Duration is required for progressbar") return end
    -- placement: low, medium, high
    local placement = data?.placement or "low"
    local text = data?.text or "Loading..."
    local canStop = data?.canStop or false
    SendNUIMessage({
        type = "progressbar",
        text = text,
        placement = placement,
        duration = duration
    })
    if canStop then 
        while progressbarCb == nil do 
            if IsControlJustPressed(0, 73) then 
                print("zamukam")
                SendNUIMessage({
                    type = "progressbar",
                    close = true
                })
                if cb then 
                    cb(false)
                end
                return false
            end
            Wait(1)
        end
    else 
        while progressbarCb == nil do 
            Wait(50)
        end
    end
    local temp = progressbarCb
    progressbarCb = nil
    progressbarBusy = false
    if cb then 
        cb(temp)
    else 
        return temp
    end
end

RegisterNUICallback("progressbarResult", function(data, cb)
    progressbarCb = data
    cb('ok')
end)

RegisterCommand("progressbar", function()
    local status = Core.ShowProgressbar({duration = 7000, text = "Hejka tu lenka", canStop = true })
    print(status)
end)



local inVeh = false
local isDriver = false
CreateThread(function()
    while true do 
        local sleep = 500 
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)
        if not inVeh then 
            if veh ~= 0 then 
                inVeh = true
                print("Entered vehicle")
                local seat = GetPedInVehicleSeat(veh, -1)
                if seat == ped then 
                    print("Driver entered")
                    isDriver = true
                    TriggerEvent("vehicleStatus", veh, true, true)
                else 
                    print("Passenger entered")
                    isDriver = false
                    TriggerEvent("vehicleStatus", veh, true, false)
                    CreateThread( function()
                        passengerWaiting(veh)
                    end)
                end
            end
        elseif inVeh then
            if veh == 0 then 
                inVeh = false
                print("Exited vehicle")
                isDriver = false
                TriggerEvent("vehicleStatus", nil, false, false)
            end
            if not isDriver then 
                local ped = PlayerPedId()
                local seat = GetPedInVehicleSeat(veh, -1)
                if seat == ped then 
                    print("Driver entered")
                    isDriver = true
                    TriggerEvent("vehicleStatus", veh, true, true)
                end
            end
        end
        Wait(sleep)
    end
end)

function passengerWaiting(veh)
    while inVeh do 
        local ped = PlayerPedId()
        local seat = GetPedInVehicleSeat(veh, -1)
        if seat == ped then 
            TriggerEvent("vehicleStatus", veh, true, true)
            isDriver = true
            break
        end
        Wait(1000)
    end
end
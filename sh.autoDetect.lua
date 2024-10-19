
FRAMEWORK_RESOURCES = { -- some framework like qbox uses provide to imitate other frameworks
    ['ESX'] = {
        "es_extended",
    },
    ['QBCore'] = {
        "qb-core",
    },
    ['QBOX'] = {
        "qbx_core",
        "qb-core",
    },
    ['VRP'] = {
        "vrp",
    },
}

TARGET_RESOURCES = {
    ['ox_target'] = "ox_target",
    ['qb-target'] = "qb-target",
}


if Shared.Framework == "AUTO DETECT" then
    local frameworkDetected = false
    local mostCompatibleFramework = {}
    for k, v in pairs(FRAMEWORK_RESOURCES) do
        for _, resource in pairs(v) do
            if GetResourceState(resource) == "started" then
                if not mostCompatibleFramework[k] then
                    mostCompatibleFramework[k] = 1
                else
                    mostCompatibleFramework[k] = mostCompatibleFramework[k] + 1
                end
            end
        end
    end
    local max = 0
    local maxFramework = ""
    local sameLevel = {}
    for k, v in pairs(mostCompatibleFramework) do
        if v > max then
            max = v
            maxFramework = k
            table.insert(sameLevel, k)
        elseif v == max then
            table.insert(sameLevel, k)
        end
    end
    for _, v in pairs(sameLevel) do
        local resourceCount = #FRAMEWORK_RESOURCES[v]
        if max >= resourceCount then
            maxFramework = v
        end
    end
    if max > 0 then
        Shared.Framework = maxFramework
        frameworkDetected = true
        print("^3dh_lib:^7 Framework detected: ^2"..maxFramework.."^7")
    end
    if not frameworkDetected then
        print("^3dh_lib:^1 Framework not detected. Please set it manually.\t^7Framework was automatically set to: ^2custom^7")
        Shared.Framework = "custom"
    end
end

if Shared.Framework == "VRP" then
    print("^3dh_lib:^7 Before using ^1vRP^7 make sure to uncomment ^1@vrp/lib/utils.lua^7 in fxmanifest.lua !!!^7")
end

if Shared.Target == "AUTO DETECT" then
    local targetDetected = false
    for k, v in pairs(TARGET_RESOURCES) do
        local status = GetResourceState(v)
        if status == "started" then
            Shared.Target = k
            targetDetected = true
            print("^3dh_lib:^7 Target detected: ^2"..k.."^7")
            break
        end
    end
    if not targetDetected then
        print("^3dh_lib:^1 Target not detected. Please set it manually.\t^7Target was automatically set to: ^2standalone^7")
        Shared.Target = "standalone"
    end
end

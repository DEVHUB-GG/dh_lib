Core = {}
exports("GetCoreObject", function()
    return Core
end)


PerformHttpRequest('https://raw.githubusercontent.com/DEVHUB-GG/dh_versions/main/versions.json', function(_, res)
    local resName = GetCurrentResourceName()
    local resPrefix = "^3["..resName.."]^"
    print("^3-------------------- DEVHUB.GG - Version Check --------------------")
    print(resPrefix.."1 Checking for updates...^7")
    if not res then print(resPrefix.."1Failed to check for updates^7") return end
    local result = json.decode(res)
    if GetResourceMetadata(resName, 'version', 0) ~= result[resName] then
        print(resPrefix.."1 New version ^3"..result[resName].."^1 of the script is available^7")
        print(resPrefix.."1 You can download it from ^3https://github.com/DEVHUB-GG/dh_lib^7")
    else 
        print(resPrefix.."2 You have the latest version of the script^7")
    end
    print("^3-------------------- DEVHUB.GG - Version Check --------------------^7")
end)
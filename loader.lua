local modules = {
    "https://raw.githubusercontent.com/cnrpro5823/cinar-script-universal/main/Speed.lua",
    "https://raw.githubusercontent.com/cnrpro5823/cinar-script-universal/main/Jump.lua",
    "https://raw.githubusercontent.com/cnrpro5823/cinar-script-universal/main/Esp.lua"
}

for _, url in pairs(modules) do
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)

    if success then
        local func = loadstring(response)
        if func then
            func()
        else
            warn("Loadstring başarısız: " .. url)
        end
    else
        warn("HttpGet başarısız: " .. url)
    end
end

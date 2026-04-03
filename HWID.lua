local AnalyticsService = game:GetService("RbxAnalyticsService")
local hwid = AnalyticsService:GetClientId()
local player = game.Players.LocalPlayer

if setclipboard then
    setclipboard(hwid)
else
    warn("Executor does not support setclipboard. HWID: " .. hwid)
end

player:Kick("HWID copied to clipboard!")

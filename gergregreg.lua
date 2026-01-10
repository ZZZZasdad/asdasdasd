if not game:IsLoaded() then
game.Loaded:Wait()
end
task.wait(10)

local servicenames = {
    "ReplicatedStorage",
    "TweenService", 
    "Players", 
    "Workspace",
    "RunService",
    "UserInputService"
}

local services = {}
for _, services in ipairs(servicenames) do 
    services[service] = cloneref(game:GetService(service))
end 

local rs = Services.ReplicatedStorage
local ts = Services.TweenService
local plrs = Services.Players
local ws = Services.Workspace
local runs = Services.RunService
local uis = Services.UserInputService
local plr = plrs.LocalPlayer
local cam = ws.CurrentCamera

repeat
    task.wait(1.25)
until rs and plr
pcall(function()
    pcall(function()
        local crabRemote = rs:FindFirstChild("Crab_Strangler")
        if crabRemote then
            crabRemote:Destroy()
        end
    end)
    task.wait(1.25)
end)

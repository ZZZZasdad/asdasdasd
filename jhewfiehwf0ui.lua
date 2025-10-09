getgenv().UI = true
game:GetService("RunService"):Set3dRenderingEnabled(false)
local gui = Instance.new("ScreenGui")
gui.Name = tostring(math.random(100000,999999))
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = game:GetService("CoreGui")
gui.Enabled = true
local frame = Instance.new("Frame")
frame.Size = UDim2.new(1, 0, 1, 0)
frame.Position = UDim2.new(0, 0, 0, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.35
frame.BorderSizePixel = 0
frame.Name = tostring(math.random(100000,999999))
frame.Parent = gui
local title = Instance.new("TextLabel")
title.AnchorPoint = Vector2.new(0.5, 0.5)
title.Position = UDim2.new(0.5, 0, 0.2, 0)
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundTransparency = 1
title.Text = "discord.gg/YuukiHub"
title.Font = Enum.Font.GothamBold
title.TextSize = 72
title.TextColor3 = Color3.fromRGB(175, 187, 230)
title.Name = tostring(math.random(100000,999999))
title.Parent = frame
local stats = {"Defeated", "Money", "Rebirth", "Total Damage"}
local statLabels = {}
local colors = {
    Color3.fromRGB(200, 0, 0),
    Color3.fromRGB(0, 200, 0),
    Color3.fromRGB(0, 100, 255),
    Color3.fromRGB(200, 0, 150)
}
for i, stat in ipairs(stats) do
    local label = Instance.new("TextLabel")
    label.AnchorPoint = Vector2.new(0.5, 0)
    label.Position = UDim2.new(0.5, 0, 0.4 + (i-1)*0.1, 0)
    label.Size = UDim2.new(0.6, 0, 0, 40)
    label.BackgroundTransparency = 1
    label.Text = stat..": 0"
    label.Font = Enum.Font.GothamBold
    label.TextSize = 36
    label.TextColor3 = colors[i]
    label.Name = stat
    label.Parent = frame
    statLabels[stat] = label
end
local blur = Instance.new("BlurEffect")
blur.Size = 50
blur.Parent = game.Lighting
blur.Enabled = true
blur.Name = tostring(math.random(100000,999999))
local Data = require(game:GetService("ReplicatedStorage").PlayerData).GetData().Data
function getDefeated() return tonumber(Data.Defeated) end
function getMoney() return tonumber(Data.Money) end
function getRebirth() return tonumber(Data.Rebirth) - 1 end
function getTotalDamage() return tonumber(game.Players.LocalPlayer:GetAttribute("TotalDamage")) end
task.spawn(function()
    while task.wait(5) do
        statLabels["Defeated"].Text = "Defeated: "..tostring(getDefeated())
        statLabels["Money"].Text = "Money: "..tostring(getMoney())
        statLabels["Rebirth"].Text = "Rebirth: "..tostring(getRebirth())
        statLabels["Total Damage"].Text = "Total Damage: "..tostring(getTotalDamage())
    end
end)

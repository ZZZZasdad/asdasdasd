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
frame.BackgroundTransparency = 0
frame.BorderSizePixel = 0
frame.Name = tostring(math.random(100000,999999))
frame.Parent = gui
local title = Instance.new("TextLabel")
title.AnchorPoint = Vector2.new(0.5, 0.5)
title.Position = UDim2.new(0.5, 0, 0.3, 0)
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundTransparency = 1
title.Text = "discord.gg/YuukiHub"
title.Font = Enum.Font.GothamBold
title.TextSize = 50
title.TextColor3 = Color3.fromRGB(175, 187, 230)
title.Name = tostring(math.random(100000,999999))
title.Parent = frame
local stats = {"Play Time","Name","Level", "Mythic Chest"}
local statLabels = {}
local colors = {
    Color3.fromRGB(255, 255, 255),
    Color3.fromRGB(255, 255, 255),
    Color3.fromRGB(255, 255, 255),
    Color3.fromRGB(255, 255, 255),
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
local plr = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local Data = ReplicatedStorage["Stats" .. plr.Name].Stats
local function GetData(Type) local stat = Data:FindFirstChild(Type) return stat and stat.Value or 0 end
local StatsData = ReplicatedStorage["Stats"..plr.Name]
function GetInventoryData(Item)
    local inv = StatsData.Inventory.Inventory.Value
    if type(inv) == "string" then inv = HttpService:JSONDecode(inv) end
    return inv[Item] or 0
end
local startTime = tick()
local name = plr.Name
task.spawn(function()
	while task.wait(1) do
		local elapsed = tick() - startTime
		local hours = math.floor(elapsed / 3600)
		local minutes = math.floor((elapsed % 3600) / 60)
		local seconds = math.floor(elapsed % 60)
		local playTime = string.format("%02dh %02dm %02ds", hours, minutes, seconds)
		if statLabels["Play Time"] then statLabels["Play Time"].Text = "Play Time: " .. playTime end
        if statLabels["Name"] then statLabels["Name"].Text = "Name: " .. tostring(name) end
		if statLabels["Level"] then statLabels["Level"].Text = "Level: " .. tostring(GetData("Level")) end
        if statLabels["Mythic Chest"] then statLabels["Mythic Chest"].Text = "Chest: " .. tostring(GetInventoryData("Mythical Fruit Chest")) end
	end
end)
local UserInputService = game:GetService("UserInputService")
local uiHidden, origTrans = false, frame.BackgroundTransparency
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed or input.KeyCode ~= Enum.KeyCode.K then return end
    uiHidden = not uiHidden
    game:GetService("RunService"):Set3dRenderingEnabled(uiHidden)
    frame.BackgroundTransparency = uiHidden and 1 or origTrans
    title.TextTransparency = uiHidden and 0.5 or 0
    for _, label in pairs(statLabels) do label.TextTransparency = uiHidden and 0.5 or 0 end
end)
getgenv().UI_Loaded = true

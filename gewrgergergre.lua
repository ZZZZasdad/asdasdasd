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
title.Position = UDim2.new(0.5, 0, 0.2, 0)
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundTransparency = 1
title.Text = "discord.gg/YuukiHub"
title.Font = Enum.Font.GothamBold
title.TextSize = 72
title.TextColor3 = Color3.fromRGB(175, 187, 230)
title.Name = tostring(math.random(100000,999999))
title.Parent = frame
local stats = {"Play Time", "Halloween Points", "Tier"}
local statLabels = {}
local colors = {
    Color3.fromRGB(200, 0, 0),
    Color3.fromRGB(0, 200, 0),
    Color3.fromRGB(0, 183, 255),
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
local ProfileData = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"))
local function GetDataHalloween()
	if ProfileData and ProfileData.Materials then
		return ProfileData.Materials.Owned.Candies2025 or 0
	end
	return 0
end
local function GetDataTier()
	if ProfileData and ProfileData.Halloween2025 then
		return ProfileData.Halloween2025.CurrentTier or 0
	end
	return 0
end
local startTime = tick()
task.spawn(function()
	while task.wait(1) do
		local elapsed = tick() - startTime
		local hours = math.floor(elapsed / 3600)
		local minutes = math.floor((elapsed % 3600) / 60)
		local seconds = math.floor(elapsed % 60)
		local playTime = string.format("%02dh %02dm %02ds", hours, minutes, seconds)
		if statLabels["Play Time"] then statLabels["Play Time"].Text = "Play Time: " .. playTime end
		if statLabels["Halloween Points"] then statLabels["Halloween Points"].Text = "Halloween Points: " .. tostring(GetDataHalloween()) end
        if statLabels["Tier"] then statLabels["Tier"].Text = "Battle Pass Tier: " .. tostring(GetDataTier()) end
	end
end)

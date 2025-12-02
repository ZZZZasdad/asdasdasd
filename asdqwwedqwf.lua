getgenv().LowCPU = true
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local plr = game.Players.LocalPlayer
local Terrain = Workspace.Terrain
for i1,v1 in ipairs(workspace.Effects:GetChildren()) do if v1:IsA("Part") or string.find(v1.Name,"Model") then v1:Destroy() end end
workspace.Effects.ChildAdded:Connect(function(v1) if v1:IsA("Part") or string.find(v1.Name,"Model") then v1:Destroy() end end)
plr.Backpack.Movements:Destroy()
Workspace.PlayerCharacters.ChildAdded:Connect(function(v) if v.Name ~= plr.Name then v:Destroy() end end)
for i, v in Players:GetChildren() do if v.Name ~= plr.Name then v:Destroy() end end
Players.ChildAdded:Connect(function(v) if v.Name ~= plr.Name then v:Destroy() end end)
Lighting:ClearAllChildren()
for i, v in next, Workspace:GetDescendants() do pcall(function() v.Transparency = 1 end) end
Workspace.DescendantAdded:Connect(function(v) pcall(function() v.Transparency = 1 end) end)
Workspace.ClientAnimatorThrottling = Enum.ClientAnimatorThrottlingMode.Enabled
Workspace.InterpolationThrottling = Enum.InterpolationThrottlingMode.Enabled
settings():GetService("RenderSettings").EagerBulkExecution = false
Workspace.LevelOfDetail = Enum.ModelLevelOfDetail.Disabled
Lighting.GlobalShadows = false
settings().Rendering.QualityLevel = "Level01"
Terrain.WaterWaveSize = 0
Terrain.WaterWaveSpeed = 0
Terrain.WaterReflectance = 0
Terrain.WaterTransparency = 0
Lighting.GlobalShadows = false
Lighting.FogEnd = 9e9
Lighting.Brightness = 0
for i, v in pairs(game:GetDescendants()) do
    if v.ClassName == "WedgePart" or v.ClassName == "Terrain" or v.ClassName == "MeshPart" then
        v.BrickColor = BrickColor.new(155, 155, 155)
        v.Material = "Plastic"
        v.Transparency = 1
    end
    if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
        v.Material = "Plastic"
        v.Reflectance = 0
    elseif v:IsA("Decal") or v:IsA("Texture") then
        v.Transparency = 1
    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
        v.Lifetime = NumberRange.new(0)
    elseif v:IsA("Explosion") then
        v.BlastPressure = 1
        v.BlastRadius = 1
    elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
        v.Enabled = false
    elseif v:IsA("MeshPart") then
        v.Material = "Plastic"
        v.Reflectance = 0
        v.TextureID = 10385902758728957
    end
end
Workspace.ChildAdded:Connect(function(v)
    if v.ClassName == "WedgePart" or v.ClassName == "Terrain" or v.ClassName == "MeshPart" then
        v.BrickColor = BrickColor.new(155, 155, 155)
        v.Material = "Plastic"
        v.Transparency = 1
    end
    if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
        v.Material = "Plastic"
        v.Reflectance = 0
    elseif v:IsA("Decal") or v:IsA("Texture") then
        v.Transparency = 1
    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
        v.Lifetime = NumberRange.new(0)
    elseif v:IsA("Explosion") then
        v.BlastPressure = 1
        v.BlastRadius = 1
    elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
        v.Enabled = false
    elseif v:IsA("MeshPart") then
        v.Material = "Plastic"
        v.Reflectance = 0
        v.TextureID = 10385902758728957
    end
end)
for i, e in pairs(Lighting:GetChildren()) do if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then e.Enabled = false end end
Lighting.ChildAdded:Connect(function(v) if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then v.Enabled = false end end)
getgenv().LowCPU_Loaded = true

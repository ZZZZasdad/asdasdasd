repeat task.wait() until game:IsLoaded()
for _, v in pairs((getconnections or get_signal_cons)(game.Players.LocalPlayer.Idled)) do if v.Disable then v:Disable() elseif v.Disconnect then v:Disconnect() end end
game.NetworkClient.ChildRemoved:Connect(function() game:GetService("TeleportService"):Teleport(77747658251236) end)
game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
    if child.Name == "ErrorPrompt" and child:FindFirstChild("MessageArea") and child.MessageArea:FindFirstChild("ErrorFrame") and child.MessageArea.ErrorFrame:FindFirstChild("ErrorMessage") then
        task.wait(1)
        local msg = string.lower(child.MessageArea.ErrorFrame.ErrorMessage.Text or "")
        local isFull = msg:find("server is full") or msg:find("requested server is full") or msg:find("this server is full") or msg:find("trying to join is full") or msg:find("full")
        if not isFull then game:GetService("TeleportService"):Teleport(77747658251236) end
    end
end)
local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local PlayerGui = plr:FindFirstChild("PlayerGui")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
local Remotes = ReplicatedStorage.Remotes
local AllocateStat = RemoteEvents:WaitForChild("AllocateStat")
local QuestAbandon = RemoteEvents:WaitForChild("QuestAbandon")
local QuestAccept = RemoteEvents:WaitForChild("QuestAccept")
local GetQuestArrowTarget = RemoteEvents:WaitForChild("GetQuestArrowTarget")
local GetPlayerStats = RemoteEvents:WaitForChild("GetPlayerStats")
local EquipWeapon = Remotes:WaitForChild("EquipWeapon")
local GetEquipped = Remotes:WaitForChild("GetEquipped")
local ResetStats = RemoteEvents:WaitForChild("ResetStats")
local RequestSummonBoss = Remotes:WaitForChild("RequestSummonBoss")
local QuestConfig = require(ReplicatedStorage.Modules.QuestConfig)
local Storage = PlayerGui:WaitForChild("InventoryPanelUI"):WaitForChild("MainFrame"):WaitForChild("Frame"):WaitForChild("Content"):WaitForChild("Holder"):WaitForChild("StorageHolder"):WaitForChild("Storage")
local InventoryButton = PlayerGui:WaitForChild("BasicStatsCurrencyAndButtonsUI"):WaitForChild("MainFrame"):WaitForChild("UIButtons"):WaitForChild("InventoryButtonFrame"):WaitForChild("InventoryButton")
local InventoryPanelUI = PlayerGui:WaitForChild("InventoryPanelUI"):WaitForChild("MainFrame")
local SwordButton = InventoryPanelUI:WaitForChild("Frame"):WaitForChild("Content"):WaitForChild("Holder"):WaitForChild("Tabs"):WaitForChild("SwordTab"):WaitForChild("ButtonOff")
local ItemsTab = InventoryPanelUI:WaitForChild("Frame"):WaitForChild("Content"):WaitForChild("Holder"):WaitForChild("Tabs"):WaitForChild("ItemsTab"):WaitForChild("ButtonOff")
local HakiStats = PlayerGui:WaitForChild("StatsPanelUI"):WaitForChild("MainFrame"):WaitForChild("Frame"):WaitForChild("Content"):WaitForChild("Page2"):WaitForChild("StatsHolder"):WaitForChild("HakiProgressionFrame")
local RequestHit = ReplicatedStorage:WaitForChild("CombatSystem"):WaitForChild("Remotes"):WaitForChild("RequestHit")
local RequestAbility = ReplicatedStorage:WaitForChild("AbilitySystem"):WaitForChild("Remotes"):WaitForChild("RequestAbility")
local HakiStateUpdate = RemoteEvents:WaitForChild("HakiStateUpdate")
local CodesConfig = require(ReplicatedStorage:WaitForChild("CodesConfig"))
local RedeemRemote = RemoteEvents:WaitForChild("CodeRedeem")
local HakiRemote = RemoteEvents:WaitForChild("HakiRemote")
local RequestAscend = RemoteEvents:WaitForChild("RequestAscend")
local GetAscendData = RemoteEvents:WaitForChild("GetAscendData")
local GetTitlesData = Remotes:WaitForChild("GetTitlesData")
local TitleEquip = RemoteEvents:WaitForChild("TitleEquip")
local LastError
local humanoid
local hrp
local noclipConn
local function InitHelper()
    if not (plr and plr.Character and hrp and humanoid) then return end
    local animate = plr.Character:FindFirstChild("Animate")
    if animate then animate.Disabled = true end
    humanoid.PlatformStand = true
    if not hrp:FindFirstChild("BodyVelocity") then Instance.new("BodyVelocity", hrp).Velocity = Vector3.new(0,0,0) end
end
local function UpdateCharacter(char)
    if noclipConn then noclipConn:Disconnect() noclipConn = nil end
	repeat task.wait() until char:FindFirstChild("Humanoid")
	humanoid = char:WaitForChild("Humanoid")
	repeat task.wait() until char:FindFirstChild("HumanoidRootPart")
	hrp = char:WaitForChild("HumanoidRootPart")
	InitHelper()
    noclipConn = RunService.Stepped:Connect(function() if not char or not char.Parent then return end for _, v in ipairs(char:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end)
end
if plr.Character then UpdateCharacter(plr.Character) end
plr.CharacterAdded:Connect(UpdateCharacter)
local function GetData(Data) return plr.Data[Data].Value end
function Tween(destination, State, LookVector)
    if getgenv().TPBlocked then return end
    if getgenv().CurrentTween then getgenv().CurrentTween:Cancel() getgenv().CurrentTween = nil end
    local distance = (hrp.Position - destination).Magnitude
    local time = distance / 180
    local tweenInfo = TweenInfo.new(time, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local cf = LookVector and CFrame.lookAt(destination, LookVector.Magnitude <= 1 and destination + LookVector or LookVector) or CFrame.new(destination)
    local twn = TweenService:Create(hrp, tweenInfo, { CFrame = cf })
    getgenv().CurrentTween = twn
    twn:Play()
    if State then twn.Completed:Wait() end
    getgenv().CurrentTween = nil
end
local function SendErrorWebhook(trace)
    pcall(function()
        http_request({
            Url = "",
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode({
                content = "Kon Was Here",
                embeds = {{
                    title = "⚠️ Script Error Detected",
                    description =
                        "**Username:** ||" .. plr.Name .. "||\n\n" ..
                        "**Error:**\n```lua\n" .. "Sailor Piece - Kaitun" .. "\n```\n" ..
                        "**Traceback:**\n```lua\n" .. tostring(trace or "N/A") .. "\n```",
                    type = "rich",
                    color = 0xFF5555,
                    footer = {
                        text = "YuukiHub • Auto Error Logger"
                    }
                }}
            })
        })
    end)
end
local function LowCPU()
    if not getgenv().LowCPU then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ZZZZasdad/asdasdasd/refs/heads/main/hrthrsxfaf3.lua"))()
    end
    if not getgenv().UI then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ZZZZasdad/asdasdasd/refs/heads/main/EGHERGDFS.lua"))()
    end
    for _, attr in ipairs({
        "DisableCoinsNotif","DisableCutscene","DisableGemsNotif","DisableOtherVFX",
        "DisablePvP","DisableScreenShake","DisableTradeRequests","GilgameshFUnlocked",
        "HideAura","HideBossHealthBar","HideCooldownBar","HideEpicNotif",
        "HideMythicalNotif","HideRaceAccessory","HideRareNotif",
        "HideUncommonNotif","RemoveShadows"
    }) do
        if plr:GetAttribute(attr) == false then plr:SetAttribute(attr, true) end
    end
end
if game.PlaceId == 77747658251236 then
    repeat task.wait(5) LowCPU() until getgenv().LowCPU_Loaded and getgenv().UI_Loaded
    local NPCs = Workspace.NPCs
    local DoingHaki,StopAddStats,HakiEnabled,UsedCodes = false,false,false,{}
    local PriorityList = {"King","Champion","Warrior","Apprentice"}
    local function IsNormalMob(name, base) return name:match("^"..base.."%d+$") end
    local function IsActive(v)
        return v and v.Parent and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChildOfClass("Humanoid") and v:FindFirstChildOfClass("Humanoid").Health > 0
    end
    local function GetMobs(QuestName)
        local quest = QuestConfig.RepeatableQuests[QuestName]
        if not quest then return {} end
        local EnemyName = quest.requirements[1].npcType
        local isBoss = EnemyName:find("Boss")
        for _, n in ipairs(NPCs:GetChildren()) do
            if IsActive(n) then
                local mhrp = n.HumanoidRootPart
                if isBoss then
                    if n.Name == EnemyName then return mhrp end
                else
                    if IsNormalMob(n.Name, EnemyName) then return mhrp end
                end
            end
        end
    end
    local function Hit(Equip,Tool,CurrentQuestData,hasSaber,hasKatana,DoingH)
        if not CurrentQuestData then return end
        if not DoingH then
            if hasSaber then
                if Tool ~= "Saber" then EquipWeapon:FireServer("Equip","Saber") task.wait(2) return end
            elseif hasKatana then
                if Tool ~= "Katana" then EquipWeapon:FireServer("Equip","Katana") task.wait(2) return end
            end
        end
        if not Equip and plr.Backpack:FindFirstChild(Tool) then pcall(humanoid.EquipTool, humanoid, plr.Backpack[Tool]) end
        RequestHit:FireServer()
    end
    local function GetQuestData()
        local data = GetQuestArrowTarget:InvokeServer()
        if data then return {npcName = data.npcName,questTitle = data.questTitle,position = data.position} end
    end
    local function AutoRedeemCodes(Level)
        for code, data in pairs(CodesConfig.Codes) do
            if UsedCodes[code] then continue end
            local levelReq = data.LevelReq or 0
            if Level >= levelReq then
                if CodesConfig.IsValid(code) then
                    RedeemRemote:InvokeServer(code)
                    UsedCodes[code] = true
                    task.wait(0.5)
                end
            end
        end
    end
    local function FireProximityPrompt(i)
        if not hrp or not hrp.Parent then return end
        local times = i or 5
        for _,v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("ProximityPrompt") and v.Parent then
                local part = v.Parent:IsA("BasePart") and v.Parent or v.Parent:FindFirstChildWhichIsA("BasePart")
                if part and part:IsA("BasePart") then
                    local dist = (part.Position - hrp.Position).Magnitude
                    if dist <= 10 then
                        for _ = 1, times do
                            if not v.Parent then break end
                            pcall(function()
                                replicatesignal(v.TriggeredActionReplicated, plr)
                                replicatesignal(v.TriggerEndedActionReplicated, plr)
                            end)
                            task.wait(0.2)
                        end
                    end
                end
            end
        end
    end
    local function CheckEquip(Tool) return plr.Character:FindFirstChild(Tool) ~= nil end
    local function CheckWeapon(Equipped, doinghaki)
        if doinghaki then return "Combat" end
        return (Equipped.Sword == "Saber" and "Saber") or (Equipped.Sword == "Katana" and "Katana") or "Combat"
    end
    local function CheckQuest(CurrentQuest, quest) return CurrentQuest == quest end
    local function CheckCurrentQuest()
        local questui = PlayerGui and PlayerGui:FindFirstChild("QuestUI")
        local quest = questui and questui:FindFirstChild("Quest")
        if quest and quest.Visible then
            local title = quest.Quest.Holder.Content.QuestInfo.QuestTitle.QuestTitle
            if title and title.Text ~= "" then return title.Text end
        end
        return nil
    end
    local function GetInventoryItem()
        if not InventoryPanelUI.Visible then firesignal(InventoryButton.Activated) task.wait(1) end
        local function get() local t={} for _,v in ipairs(Storage:GetChildren()) do if v:IsA("ImageButton") then t[#t+1]=v.Name end end return t end
        firesignal(SwordButton.Activated) task.wait(0.5) local Swords = get()
        firesignal(ItemsTab.Activated) task.wait(0.5) return get(), Swords
    end
    local function AutoGetHaki(CurrentQuest)
        if CheckQuest(CurrentQuest,"Path to Haki 1") then
            for i1,v1 in ipairs(NPCs:GetChildren()) do
                local isBoss = v1.Name:find("Boss")
                if v1:IsA("Model") and IsActive(v1) and (not isBoss and IsNormalMob(v1.Name, "Thief")) then
                    local backPos = (v1.HumanoidRootPart.Position + Vector3.new(0,6,0))
                    Tween(backPos,false,Vector3.new(0,-1,0))
                end
            end
        elseif CheckQuest(CurrentQuest,"Path to Haki 2") then
            RequestAbility:FireServer(1)
        elseif CheckQuest(CurrentQuest,"Path to Haki Final") then

        else
            QuestAbandon:FireServer("repeatable") task.wait(1) Tween(Vector3.new(-498, 24, -1250),true) task.wait(1) FireProximityPrompt(3) task.wait(2) Tween(Vector3.new(183, 17, -139))
        end
    end
    local function FarmLevel(CurrentQuest,CurrentQuestData,hasKatana,Peli,Weapon,Mob)
        if not CheckQuest(CurrentQuest, CurrentQuestData.questTitle) then
            QuestAbandon:FireServer("repeatable")
            task.wait(1)
            Tween(CurrentQuestData.position,true)
            QuestAccept:FireServer(CurrentQuestData.npcName)
            task.wait(2)
        else
            if Weapon == "Combat" and not hasKatana and Peli >= 2500 then Tween(Vector3.new(105,10,-263),true) task.wait(1) FireProximityPrompt() task.wait(1) EquipWeapon:FireServer("Equip","Katana") task.wait(1) ResetStats:FireServer() task.wait(1) AllocateStat:FireServer("Sword",1) return end
            if Mob then
                local backPos = Weapon == "Combat" and (Mob.Position + Vector3.new(0,6,0)) or (Mob.Position + Vector3.new(0,10,0))
                Tween(backPos,false,Vector3.new(0,-1,0))
            else
                Tween(CurrentQuestData.position)
            end
        end
    end
    local function FarmSaber()
    local SaberBoss = NPCs:FindFirstChild("SaberBoss")
        if SaberBoss and IsActive(SaberBoss) then
            Tween(SaberBoss.HumanoidRootPart.Position + Vector3.new(0,10,0), false, Vector3.new(0,-1,0))
        else
            Tween(Vector3.new(653,-4,-1018), true)
            RequestSummonBoss:FireServer("SaberBoss")
        end
    end
    local function Ascend() if GetAscendData:InvokeServer().allMet then RequestAscend:FireServer() end end
    local function AutoEquipBestTitle(TitleData)
        local current = TitleData.equipped
        local AllTitles = TitleData.unlocked
        for _, v1 in ipairs(PriorityList) do  if table.find(AllTitles, v1) then if current ~= v1 then TitleEquip:FireServer(v1) end return end end
    end
    local function ApplyStats(Weapon,StatsPoint,CurrentStats)
        if StopAddStats or not Weapon then return end
        if (Weapon == "Combat" and CurrentStats.Sword > 0) or (Weapon ~= "Combat" and CurrentStats.Melee > 0) then ResetStats:FireServer() task.wait(2) end
        local p = StatsPoint
        if p <= 0 then return end
        local atk = (Weapon == "Combat") and "Melee" or "Sword"
        local a = math.floor(p * 0.7)
        local d = p - a
        if CurrentStats[atk] >= 11500 then d, a = d + a, 0 end
        if a > 0 then AllocateStat:FireServer(atk, math.min(a, 11500 - CurrentStats[atk])) end
        if d > 0 then AllocateStat:FireServer("Defense", math.min(d, 11500 - CurrentStats.Defense)) end
    end
    local Level,Peli,Gems,StatsPoint,CurrentStats,Mob,CurrentQuest,Equip,CurrentQuestData,Equipped,Weapon,Items,Sword,hasKatana,hasSaber,CanSummon,Haki,TitleData
    task.spawn(function() while task.wait(1) do Equipped = GetEquipped:InvokeServer() if Equipped then Weapon = CheckWeapon(Equipped,DoingHaki) end Equip = CheckEquip(Weapon) Level = GetData("Level") if Level then AutoRedeemCodes(Level) end Peli = GetData("Money") Gems = GetData("Gems") StatsPoint = GetData("StatPoints") CurrentQuest = CheckCurrentQuest() CurrentQuestData = GetQuestData() if CurrentQuestData then Mob = GetMobs(CurrentQuestData.npcName) end Haki = HakiStats.Visible CurrentStats = GetPlayerStats:InvokeServer().Stats TitleData = GetTitlesData:InvokeServer() if TitleData then AutoEquipBestTitle(TitleData) end Ascend() ApplyStats(Weapon,StatsPoint,CurrentStats) end end)
    task.spawn(function() while task.wait(1) do Items,Sword = GetInventoryItem() if Sword and Items then hasSaber = table.find(Sword,"Item_Saber") hasKatana = table.find(Sword,"Item_Katana") CanSummon = table.find(Items,"Item_Boss Key") and (Peli and Peli >= 100000) and (Gems and Gems >= 175) end end end)
    repeat task.wait() until Peli and Level and Gems and (Items or Sword)
    HakiStateUpdate.OnClientEvent:Connect(function(...) local a = {...} HakiEnabled = (#a == 1 and a[1]) or (a[1] == plr and a[2]) or HakiEnabled end)
    task.spawn(function()
        while task.wait(0.1) do
            local ok, err = xpcall(function()
                if not (hrp and humanoid) then return end
                Hit(Equip,Weapon,CurrentQuestData,hasSaber,hasKatana,DoingHaki)
            end, debug.traceback)
            if not ok then if err ~= LastError then LastError = err warn(err) SendErrorWebhook(err) end task.wait(1) end
        end
    end)
    task.spawn(function()
        while task.wait() do
            local ok, err = xpcall(function()
                if not (hrp and humanoid) then return end
                if not CurrentQuestData then return end
                local State
                if Level >= 4000 and not Haki then State = "Haki" elseif Level >= 3000 and not hasSaber and CanSummon then State = "Saber" else State = "Farm" end
                if not HakiEnabled then HakiRemote:FireServer("Toggle") end
                if State == "Haki" then
                    DoingHaki = true
                    AutoGetHaki(CurrentQuest)
                elseif State == "Saber" then
                    FarmSaber()
                elseif State == "Farm" then
                    DoingHaki = false
                    FarmLevel(CurrentQuest,CurrentQuestData,hasKatana,Peli,Weapon,Mob)
                end
            end, debug.traceback)
            if not ok then if err ~= LastError then LastError = err warn(err) SendErrorWebhook(err) end task.wait(1) end
        end
    end)
end
setfpscap(getgenv().Config["Performance"]["FPS Lock"])
getgenv().Loaded = true

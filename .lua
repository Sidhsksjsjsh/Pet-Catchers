local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sidhsksjsjsh/VAPE-UI-MODDED/main/.lua"))()
local isload,error = pcall(function()
local wndw = lib:Window("VIP Turtle Hub V4 - :(")
local T1 = wndw:Tab("Main")
local T2 = wndw:Tab("Shop")
local T3 = wndw:Tab("Boss")
local T4 = wndw:Tab("Unlock & Teleport")
local T5 = wndw:Tab("Sell & Fishing")
local T6 = wndw:Tab("Minigames")
local T7 = wndw:Tab("Items")
local T8 = wndw:Tab("Config")
local T9 = wndw:Tab("Crafting")
local T10 = wndw:Tab("Attack")
local T11 = wndw:Tab("Alert")
local T12 = wndw:Tab("Server")

		
local TweenService = game:GetService("TweenService")
local self = game.Players.LocalPlayer
local crabInstance = ""
local grav = workspace.Gravity
local alert = Instance.new("Sound")
alert.SoundId = "rbxassetid://216917652"
alert.Parent = game:GetService("SoundService")
alert.Name = "Notify Sound"
--alert:Play()

local bosspos = {
	["slime-boss"] = {
		["vector"] = {Vector3.new(489,64,1471),Vector3.new(501,83,1450)},
		["cframe"] = {CFrame.new(489,64,1471),CFrame.new(501,83,1450)}
	},
	["the-kraken"] = {
		["vector"] = {Vector3.new(1176,85,337),Vector3.new(1212,109,330)},
		["cframe"] = {CFrame.new(1176,85,337),CFrame.new(1212,109,330)}
	}
}
-- bosspos["the-kraken"]["vector"][1]
local nottype = "Bottom"

local function AlertSystem(str)
	if nottype == "Bottom" then
		lib:notify(str,10)
	else
		lib:WarnUser(str)
	end
end
		
local function tween(name,random)
	if random == true then
		if name == "the-kraken" then
			TweenService:Create(self.Character.HumanoidRootPart,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false,0),{CFrame = bosspos["the-kraken"]["cframe"][math.random(1,2)]}):Play()
		elseif name == "king-slime" then
			TweenService:Create(self.Character.HumanoidRootPart,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false,0),{CFrame = bosspos["slime-boss"]["cframe"][math.random(1,2)]}):Play()
		end
	else
		if name == "the-kraken" then
			TweenService:Create(self.Character.HumanoidRootPart,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false,0),{CFrame = bosspos["the-kraken"]["cframe"][1]}):Play()
		elseif name == "king-slime" then
			TweenService:Create(self.Character.HumanoidRootPart,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false,0),{CFrame = bosspos["slime-boss"]["cframe"][1]}):Play()
		end
	end
end
		
local amount = {
    berry = 4115,
    craft = 1
}

local config = {
    mount = "Hoverboard"
}

local boss = {
	lvl = 1,
	name = "king-slime",
	table = {}
}

local function RejoinServerScript()
    if #game.Players:GetPlayers() <= 1 then
	AlertSystem("Rejoining")
        wait()
        game:GetService('TeleportService'):Teleport(game.PlaceId,self)
    else
        game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId,game.JobId,self)
    end
end

local workspace = game:GetService("Workspace")
local wo = {"The Blackmarket","The Summit"}
local act = {}
local upg = {}
local egg = {}
local shrine = {}
local mounts = {}
local items = {}

local rarity = "Common"
		
lib:AddTable(workspace.Activations,act)
lib:AddTable(game:GetService("ReplicatedStorage").Assets.WorldMap,wo)
lib:AddTable(workspace.Upgrades,upg)
lib:AddTable(game:GetService("ReplicatedStorage").Assets.Eggs,egg)
lib:AddTable(workspace.Shrines,shrine)
lib:AddTable(game:GetService("ReplicatedStorage").Assets.Mounts,mounts)
lib:AddTable(game:GetService("ReplicatedStorage").Assets.Items,items)
lib:AddTable(workspace.Bosses,boss.table)

T6:Label("this is for Ancient Dig minigames\nAncient Dig Minigame located in 'Dusty Dunes' world!")
T9:Label("Sorry ill change it into dropdown cus i have no time to\nmake item list")

local function getmetachildren(str,funct)
	for i,v in pairs(str:GetDescendants()) do
		funct(v)
	end
end

T9:Textbox("Item name",false,function(value)
    _G.craftitem = value
end)

T9:Dropdown("Select Crafting slot",{"1","2","3"},function(value)
    _G.craftslot = tonumber(value)
end)

T9:Slider("Craft amount ( MAX 999 )",0,999,1,function(value)
    amount.craft = value
end)

T9:Button("Craft",function()
    game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("StartCrafting",_G.craftslot,_G.craftitem,amount.craft)
end)

T9:Button("Claim all crafting",function()
    game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("ClaimCrafting",1)
    game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("ClaimCrafting",2)
    game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("ClaimCrafting",3)
end)

T9:Button("Unlock all crafting slots",function()
    game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("UnlockExtraCraftSlot")
    game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("UnlockExtraCraftSlot")
    game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("UnlockExtraCraftSlot")
end)

local function Fishing(str,pos)
    game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("StartFishing",str,pos)
end

local function childAsync(str,funct)
	for i,v in pairs(str:GetChildren()) do
		funct(v)
	end
end

local function tilesGetAsync(func)
    for i,v in pairs(workspace["Map"]["Dusty Dunes"]["Excavation"]["Tiles"]:GetChildren()) do
        func(v.Name)
    end
end

local function enemiesGetAsync(array,funct)
	childAsync(workspace["Markers"]["Enemies"][self.PlayerGui.ScreenGui.Region.Frame.Label.Text],function(sync)
		if array == "Armored Snowman" then
			if self.PlayerGui.ScreenGui.Region.Frame.Label.Text == "Frosty Peaks" then
				childAsync(sync["Armored"],function(async)
					if async.Name ~= "SourceFolder" then
						funct(async.Name)
				        end
			        end)
		        end
		else
			childAsync(sync["Default"],function(fet)
				if fet.Name ~= "SourceFolder" then
					funct(fet.Name)
				end
			end)
		end
	end)
end

T1:Dropdown("Select catch rarities",{"Common","Rare","Epic","Legendary"},function(value)
    _G.rarity = value
end)

T1:Toggle("Auto catch all pets",false,function(value)
    _G.cpets = value
    while wait() do
      if _G.cpets == false then break end
      for i,v in pairs(workspace["Rendered"]["Pets"]["World"]:GetChildren()) do
            if _G.cpets == true then
                game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Function"]:InvokeServer("CapturePet",v.Name,_G.rarity)
            end
      end
    end
end)

if self.Name == "Rivanda_Cheater" then
T1:Toggle("Auto catch [ Manual ID ]",false,function(value)
    _G.manualver = value
    while wait() do
      if _G.manualver == false then break end
	game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Function"]:InvokeServer("CapturePet",crabInstance,_G.rarity)
    end
end)
end

T2:Dropdown("Select shops",act,function(value)
        _G.shop = value
end)

T2:Toggle("Auto buy item shop [ Item 1 ]",false,function(value)
    _G.bitem1 = value
    while wait() do
      if _G.bitem1 == false then break end
      game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("BuyShopItem",_G.shop,1)
    end
end)

T2:Toggle("Auto buy item shop [ Item 2 ]",false,function(value)
    _G.bitem2 = value
    while wait() do
      if _G.bitem2 == false then break end
      game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("BuyShopItem",_G.shop,2)
    end
end)

T2:Toggle("Auto buy item shop [ Item 3 ]",false,function(value)
    _G.bitem3 = value
    while wait() do
      if _G.bitem3 == false then break end
      game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("BuyShopItem",_G.shop,3)
    end
end)

T1:Button("Claim all shrine",function()
      for array = 1,#shrine do
            game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("UseShrine",shrine[array])
      end
end)

T1:Button("Buy all upgrades",function()
    for array = 1,#upg do
        game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("BuyUpgrade",upg[array])
    end
end)

T1:Button("Claim all index",function()
    for array = 1,100 do
        game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("ClaimIndexReward",array)
    end
end)

T1:Button("Skip omacka's dialog [ VANGUARD ]",function()
    lib:notify("Vanguard is skipping all quest dialog",10)
    for array = 1,50 do
        game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("FinishedQuestDialog","omacka-" .. array)
    end
    lib:notify("Successfully skips all dialog",10)
end)

T1:Toggle("Auto skip bruh's bounty hunter dialog",false,function(value)
	_G.bounty = value
	lib:notify("Auto skip enabled",10)
	while wait() do
		if _G.bounty == false then break end
			game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("FinishedQuestDialog","bruh-bounty")
	end
end)

--game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("TargetEnemy",asyc)
T10:Dropdown("Select world to spam damage",wo,function(value)
    _G.Worldtarget = value
end)

T10:Toggle("Auto damage to a selected world",false,function(value)
    _G.selworld = value
    while wait() do
        if _G.selworld == false then break end
		childAsync(workspace["Markers"]["Enemies"][_G.Worldtarget]["Default"],function(fet)
			if fet.Name ~= "SourceFolder" then
				game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("TargetEnemy",fet.Name)
			end
		end)
	end
end)

T10:Toggle("Auto damage to rendered enemies",false,function(value)
    _G.mde = value
    while wait() do
        if _G.mde == false then break end
		childAsync(workspace["Markers"]["Enemies"][self.PlayerGui.ScreenGui.Region.Frame.Label.Text]["Default"],function(fet)
			if fet.Name ~= "SourceFolder" then
				game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("TargetEnemy",fet.Name)
			end
		end)
	end
end)
		
T10:Toggle("Auto damage to all enemies",false,function(value)
    _G.allwo = value
    while wait() do
        if _G.allwo == false then break end
		childAsync(workspace["Markers"]["Enemies"],function(track)
			if track:FindFirstChild("Default") or v.Name == "Default" then
				childAsync(track["Default"],function(fet)
					if fet.Name ~= "SourceFolder" then
						game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("TargetEnemy",fet.Name)
				        end
		                end)
			end
		end)
	end
end)

T10:Toggle("Auto damage to Armored Snowman",false,function(value)
    _G.asfp = value
    task.spawn(function()
	if self.PlayerGui.ScreenGui.Region.Frame.Label.Text ~= "Frosty Peaks" then
		game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("RepairBeacon","Frosty Peaks","Spawn")
		wait(0.2)
		game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("TeleportBeacon","Frosty Peaks","Spawn")
	end
    end)
		
    while wait() do
        if _G.asfp == false then break end
		childAsync(workspace["Markers"]["Enemies"][self.PlayerGui.ScreenGui.Region.Frame.Label.Text]["Armored"],function(fet)
			if fet.Name ~= "SourceFolder" then
				game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("TargetEnemy",fet.Name)
			end
		end)
	end
end)

T4:Dropdown("Select world",wo,function(value)
    _G.TpWorld = value
end)

T4:Button("Teleport",function()
	if _G.TpWorld == "The Blackmarket" then
		game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("TeleportBeacon","Magma Basin","The Blackmarket")
	elseif _G.TpWorld == "The Summit" then
		game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("TeleportBeacon","Magma Basin","The Summit")
	else
		game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("TeleportBeacon",_G.TpWorld,"Spawn")
	end
end)

T4:Button("Repair all beacons",function()
    for array = 1,#wo do
        game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("RepairBeacon",wo[array],"Spawn")
    end
end)

T4:Button("Unlock regions",function()
    for array = 1,#wo do
        game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("UnlockRegion",wo[array])
    end
end)

T3:Dropdown("Select boss",boss.table,function(value)
	boss.name = value
end)

T3:Textbox("Enter boss level",false,function(value)
    boss.lvl = tonumber(value)
end)

--self.PlayerGui.LoadingGui.Enabled = false
T3:Button("Boss fight",function()
    game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Function"]:InvokeServer("BossRequest",boss.name,boss.lvl)
end)

T3:Toggle("Auto respawn boss",false,function(value)
	_G.autoresboss = value
		while wait() do
			if _G.autoresboss == false then break end
				game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("RespawnBoss",boss.name)
		end
end)

T3:Toggle("Auto tp to safe place",false,function(value)
	_G.safezone = value
	if value then
		workspace.Gravity = 0
		--AlertSystem("Gravity changed to " .. lib:ColorFonts(workspace.Gravity,"Red"))
	else
		workspace.Gravity = grav
	end

		while wait() do
			if _G.safezone == false then break end
				if self.Character then
					tween(boss.name,true)
				else
					AlertSystem(lib:ColorFonts("runtime error : Failed to find Character in line 4972","Red"))
				end
		end
end)

T3:Toggle("Auto deal damage to rendered boss",false,function(value)
	_G.damage = value
		while wait() do
			if _G.damage == false then break end
			childAsync(workspace.Rendered.Enemies,function(childAsync)
				game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("TargetEnemy",childAsync.Name)
			end)
		end
end)

--T3:Label("Fuck you")
--Workspace.Rendered.Pets.World.7b55e3ef-327b-4990-80c7-66eabe8d3aea.Hitbox.WorldPetGui.Stars.4.Common

--[[
local args = {
    [1] = "StartFishing",
    [2] = "Magma Basin",
    [3] = Vector3.new(1260.465576171875, 183.92877197265625, -435.5975646972656)
}

game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer(unpack(args))
]]

--T5:Dropdown("Select world to start fishing",{"Pet Park","Mellow Meadows","Auburn Woods","Frosty Peaks","Sunset Shores","Dusty Dunes","Gloomy Grotto","Magma Basin"},function(value)
T5:Dropdown("Select world to start fishing",wo,function(value)
    _G.fishworld = value
end)

T5:Button("Start fishing",function()
    if _G.fishworld == "Pet Park" then
        Fishing("Pet Park",Vector3.new(1138.7437744140625,9.686546325683594,1633.845703125))
    elseif _G.fishworld == "Mellow Meadows" then
        Fishing("Mellow Meadows",Vector3.new(874.0309448242188,21.719955444335938,1490.1602783203125))
    elseif _G.fishworld == "Auburn Woods" then
        Fishing("Auburn Woods",Vector3.new(716.324462890625,21.719636917114258,1150.069091796875))
    elseif _G.fishworld == "Frosty Peaks" then
        Fishing("Frosty Peaks",Vector3.new(977.94580078125,37.48805618286133,719.7373657226562))
    elseif _G.fishworld == "Sunset Shores" then
        Fishing("Sunset Shores",Vector3.new(1319.7314453125,37.488059997558594,621.930419921875))
    elseif _G.fishworld == "Dusty Dunes" then
        Fishing("Dusty Dunes",Vector3.new(1842.6231689453125,49.098777770996094,105.9592056274414))
    elseif _G.fishworld == "Gloomy Grotto" then
	Fishing("Gloomy Grotto",Vector3.new(1545.80615234375,49.098777770996094,-94.8126220703125))
    elseif _G.fishworld == "Magma Basin" or _G.fishworld == "The Summit" then
	Fishing("Magma Basin",Vector3.new(1260.465576171875,183.92877197265625,-435.5975646972656))
    else
	AlertSystem("Oops, this region is unavailable. try select another region.")
    end
end)

T5:Toggle("Auto cast every 4s",false,function(value)
    _G.fish = value
    game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("StartCastFishing")
    while wait(4) do
      if _G.fish == false then break end
      game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("StartCastFishing")
    end
end)

T5:Button("Sell all fish",function()
    game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("SellFish")
end)

T5:Button("Stop fishing",function()
    game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("StopFishing")
end)

T6:Toggle("Auto dig",false,function(value)
    _G.autDig = value
    while wait() do
        if _G.autDig == false then break end
            tilesGetAsync(function(tilesAsync)
                game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("TryMinigameInput",tilesAsync)
            end)
    end
end)

T6:Label("Auto play for dance-of coming soon\nthat minigames located in 'Gloomy Grotto'")

T7:Dropdown("Select item",items,function(value)
    _G.mystype = value
end)

T7:Toggle("Auto use/hatch selected item",false,function(value)
    _G.autmys = value
    while wait() do
        if _G.autmys == false then break end
		if _G.mystype == "Elite Mystery Egg" then
			game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Function"]:InvokeServer("TryHatchEgg","Elite Mystery Egg")
		elseif _G.mystype == "Mystery Egg" then
			game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Function"]:InvokeServer("TryHatchEgg","Mystery Egg")
		elseif _G.mystype == "Prismatic Mystery Egg" then
			game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Function"]:InvokeServer("TryHatchEgg","Prismatic Mystery Egg")
		else
			game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("UsePowerup",_G.mystype)
		end
	end
end)

T7:Toggle("Auto equip best pet",false,function(value)
    _G.best = value
	while wait() do
		if _G.best == false then break end
			game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("EquipBestPets")
	end
end)

T8:Dropdown("Select mount",mounts,function(value)
    config.mount = value
end)

T8:Toggle("Set hoverboard config",false,function(value)
    _G.treat = value
end)

T11:Dropdown("Select alert rarity",{"Common","Rare","Epic","Legendary"},function(value)
    rarity = value
end)

T11:Dropdown("Select alert type",{"Bottom","Center & Big"},function(value)
	nottype = value
end)

T11:Textbox("Insert alert sound",false,function(value)
    alert.SoundId = value
end)

T11:Toggle("Enable alert",false,function(value)
    _G.sys_alert = value
end)

T11:Toggle("Enable boss defeated alert",false,function(value)
    _G.boss_alert = value
end)

--alert:Play()
T11:Button("Test alert",function()
    AlertSystem("The alert will be like this")
end)

T11:Button("Test sound",function()
	alert:Play()
end)

T12:Button("Rejoin server",function()
    RejoinServerScript()
end)
--TreatsInstance.berry
--[[
local args = {
    [1] = "EquipMount",
    [2] = "Hoverboard",
    [3] = "Default"
}

game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer(unpack(args))
]]
--[[
game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Function"]:InvokeServer("CapturePet",v.Name,_G.rarity)
]]
lib:HookFunction(function(method,received,args)
    if method == "InvokeServer" and received == "Function" and args[1] == "CapturePet" then
	crabInstance = args[2]
    end
end)

self:GetAttributeChangedSignal("Mount"):Connect(function()
	if _G.treat == true then
		self:SetAttribute("Mount",config.mount .. "/Default")
		lib:notify("Successfully sets the mount config to " .. lib:ColorFonts(config.mount,"Green"),10)
	end
end)

self.PlayerGui.ScreenGui.Region.Frame.Label:GetPropertyChangedSignal("Text"):Connect(function()
	lib:notify("Now entering " .. self.PlayerGui.ScreenGui.Region.Frame.Label.Text,10)
end)
		
self.PlayerGui.ScreenGui.Received.ChildAdded:Connect(function(i)
	if i.Label:IsA("TextLabel") and _G.sys_alert == true then
		childAsync(i.Label,function(get)
			if get.Name == rarity then
				AlertSystem("Congratulation! You got " .. i.Label.Text)
				alert:Play()
				--[[if _G.typealert == "Bottom" then
					lib:notify("Congratulation! You got " .. i.Label.Text,10)
					alert:Play()
				else
					lib:WarnUser("Congratulation! You got " .. i.Label.Text)
					alert:Play()
				end]]
			end
		end)
	end
end)
--0 /
self.PlayerGui.ScreenGui.BossHUD.Healthbar.Health:GetPropertyChangedSignal("Text"):Connect(function()
	if self.PlayerGui.ScreenGui.BossHUD.Healthbar.Health.Text:sub(1,3) == "0 /" or self.PlayerGui.ScreenGui.BossHUD.Healthbar.Health.Text:sub(1,2) == "0/" and _G.boss_alert == true then
		AlertSystem("Congrats! You defeated " .. lib:ColorFonts(self.PlayerGui.ScreenGui.BossHUD.Healthbar.DisplayName.Text,"Red"))
		alert:Play()
		--[[if _G.typealert == "Bottom" then
			lib:notify("Congrats! You defeated " .. lib:ColorFonts(self.PlayerGui.ScreenGui.BossHUD.Healthbar.DisplayName.Text,"Red"),10)
			alert:Play()
		else
			lib:WarnUser("Congrats! You defeated " .. lib:ColorFonts(self.PlayerGui.ScreenGui.BossHUD.Healthbar.DisplayName.Text,"Red"))
			alert:Play()
		end]]
	end
end)

self.PlayerGui.ScreenGui.BossHUD.Healthbar.DisplayName:GetPropertyChangedSignal("Text"):Connect(function()
	if _G.boss_alert == true then
		AlertSystem(lib:ColorFonts(self.PlayerGui.ScreenGui.BossHUD.Healthbar.DisplayName.Text,"Red") .. " has appeared! Be careful to defeat him.")
		alert:Play()
		--[[if _G.typealert == "Bottom" then
			lib:notify(lib:ColorFonts(self.PlayerGui.ScreenGui.BossHUD.Healthbar.DisplayName.Text,"Red") .. " has appeared! Be careful to defeat him.",10)
			alert:Play()
		else
			lib:WarnUser(lib:ColorFonts(self.PlayerGui.ScreenGui.BossHUD.Healthbar.DisplayName.Text,"Red") .. " has appeared! Be careful to defeat him.")
			alert:Play()
		end]]
	end
end)

workspace:GetPropertyChangedSignal("Gravity"):Connect(function()
	AlertSystem("Gravity changed to " .. lib:ColorFonts(workspace.Gravity,"Green"))
end)
-- BREAK
end)

if not isload and self.Name == "Rivanda_Cheater" then
	lib:WarnUser(error)
end

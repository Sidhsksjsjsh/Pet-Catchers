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
	AlertSystem("Rejoining")
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

local toggle = {
	P1 = false,
	P2 = false,
	P3 = false,
	P4 = false,
	P5 = false,
	P6 = false,
	P7 = false,
	P8 = false,
	P9 = false,
	P10 = false,
	P11 = false,
	P12 = false,
	P13 = false,
	P14 = false,
	P15 = false,
	P16 = false,
	P17 = false,
	P18 = false,
	P19 = false,
	P20 = false,
	P21 = false,
	P22 = false,
	P23 = false,
	boss = false,
	alert = false,
	B1 = "rare-cube",
	B2 = 1,
	B3 = "Common",
	B4 = act[1],
	B5 = wo[3],
	B6 = wo[3],
	B7 = wo[3],
	B8 = items[1],
	B9 = "",
	B10 = "",
	B11 = "",
	B12 = "",
	B13 = "",
	B14 = "",
	B15 = "",
	B16 = "",
	B17 = "",
	B18 = "",
	B19 = "",
	B20 = "",
	B21 = "",
	B22 = "",
	B23 = "",
	B24 = "",
	B25 = "",
	B26 = ""
} -- toggle.B1 

T6:Label("this is for Ancient Dig minigames\nAncient Dig Minigame located in 'Dusty Dunes' world!")
T9:Label("Sorry ill change it into dropdown cus i have no time to\nmake item list")

local function getmetachildren(str,funct)
	for i,v in pairs(str:GetDescendants()) do
		funct(v)
	end
end

T9:Textbox("Item name",false,function(value)
    toggle.B1 = value
end)

T9:Dropdown("Select Crafting slot",{"1","2","3"},function(value)
    toggle.B2 = tonumber(value)
end)

T9:Slider("Craft amount ( MAX 999 )",0,999,1,function(value)
    amount.craft = value
end)

T9:Button("Craft",function()
    game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("StartCrafting",toggle.B2,toggle.B1,amount.craft)
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
    lib:notify("You are currently fishing in the " .. str .. " zone",10)
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
    toggle.B3 = value
end)

T1:Toggle("Auto catch all pets",false,function(value)
    toggle.P1 = value
    while wait() do
      if toggle.P1 == false then break end
      for i,v in pairs(workspace["Rendered"]["Pets"]["World"]:GetChildren()) do
            if _G.cpets == true then
                game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Function"]:InvokeServer("CapturePet",v.Name,toggle.B3)
            end
      end
    end
end)

if self.Name == "Rivanda_Cheater" then
T1:Toggle("Auto catch [ Manual ID ]",false,function(value)
    toggle.P2 = value
    while wait() do
      if toggle.P2 == false then break end
	game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Function"]:InvokeServer("CapturePet",crabInstance,toggle.B3)
    end
end)
end

T2:Dropdown("Select shops",act,function(value)
        toggle.B4 = value
end)

T2:Toggle("Auto buy item shop [ Item 1 ]",false,function(value)
    toggle.P3 = value
    while wait() do
      if toggle.P3 == false then break end
      game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("BuyShopItem",toggle.B4,1)
    end
end)

T2:Toggle("Auto buy item shop [ Item 2 ]",false,function(value)
    toggle.P4 = value
    while wait() do
      if toggle.P4 == false then break end
      game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("BuyShopItem",toggle.B4,2)
    end
end)

T2:Toggle("Auto buy item shop [ Item 3 ]",false,function(value)
    toggle.P5 = value
    while wait() do
      if toggle.P5 == false then break end
      game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("BuyShopItem",toggle.B4,3)
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
	toggle.P6 = value
	lib:notify("Auto skip enabled",10)
	while wait() do
		if toggle.P6 == false then break end
			game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("FinishedQuestDialog","bruh-bounty")
	end
end)

--game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("TargetEnemy",asyc)
T10:Dropdown("Select world to spam damage",wo,function(value)
    toggle.B5 = value
end)

T10:Toggle("Auto damage to a selected world",false,function(value)
    toggle.P7 = value
    while wait() do
        if toggle.P7 == false then break end
		childAsync(workspace["Markers"]["Enemies"][toggle.B5]["Default"],function(fet)
			if fet.Name ~= "SourceFolder" then
				game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("TargetEnemy",fet.Name)
			end
		end)
	end
end)

T10:Toggle("Auto damage to rendered enemies",false,function(value)
    toggle.P8 = value
    while wait() do
        if toggle.P9 == false then break end
		childAsync(workspace["Markers"]["Enemies"][self.PlayerGui.ScreenGui.Region.Frame.Label.Text]["Default"],function(fet)
			if fet.Name ~= "SourceFolder" then
				game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("TargetEnemy",fet.Name)
			end
		end)
	end
end)
		
T10:Toggle("Auto damage to all enemies",false,function(value)
    toggle.P10 = value
    while wait() do
        if toggle.P10 == false then break end
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
    toggle.P11 = value
    task.spawn(function()
	if self.PlayerGui.ScreenGui.Region.Frame.Label.Text ~= "Frosty Peaks" then
		game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("RepairBeacon","Frosty Peaks","Spawn")
		wait(0.2)
		game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("TeleportBeacon","Frosty Peaks","Spawn")
	end
    end)
		
    while wait() do
        if toggle.P11 == false then break end
		childAsync(workspace["Markers"]["Enemies"][self.PlayerGui.ScreenGui.Region.Frame.Label.Text]["Armored"],function(fet)
			if fet.Name ~= "SourceFolder" then
				game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("TargetEnemy",fet.Name)
			end
		end)
	end
end)

T4:Dropdown("Select world",wo,function(value)
    toggle.B6 = value
end)

T4:Button("Teleport",function()
	if toggle.B6 == "The Blackmarket" then
		game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("TeleportBeacon","Magma Basin","The Blackmarket")
		lib:notify("Now Entering 'The Blackmarket'",10)
	elseif toggle.B6 == "The Summit" then
		game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("TeleportBeacon","Magma Basin","The Summit")
		lib:notify("Now Entering 'The Summit'",10)
	else
		game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("TeleportBeacon",_G.TpWorld,"Spawn")
	end
end)

T4:Button("Repair all beacons",function()
    lib:notify("Repairing all beacons...",10)
    for array = 1,#wo do
        game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("RepairBeacon",wo[array],"Spawn")
    end
    lib:notify(lib:ColorFonts("Done","Green") .. "... total beacons repaired: " .. lib:ColorFonts(#wo,"Green"),10)
end)

T4:Button("Unlock regions",function()
    lib:notify("Unlocking all regions",10)
    for array = 1,#wo do
        game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("UnlockRegion",wo[array])
    end
    lib:notify(lib:ColorFonts("Done","Green"),10)
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
    lib:notify("Where is the boss? 😥😢",10)
end)

T3:Toggle("Auto respawn boss",false,function(value)
	toggle.P12 = value
		while wait() do
			if toggle.P12 == false then break end
				game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("RespawnBoss",boss.name)
		end
end)

T3:Toggle("Auto tp to safe place",false,function(value)
	toggle.P13 = value
	if value then
		workspace.Gravity = 0
	else
		workspace.Gravity = grav
	end

		while wait() do
			if toggle.P13 == false then break end
				if self.Character then
					tween(boss.name,true)
				else
					lib:notify(lib:ColorFonts("runtime error : Failed to find 'Character' in line 4972","Red"),10)
					toggle.P13 = false
				end
		end
end)

T3:Toggle("Auto deal damage to rendered boss",false,function(value)
	toggle.P14 = value
		while wait() do
			if toggle.P14 == false then break end
			childAsync(workspace.Rendered.Enemies,function(childAsync)
				if childAsync then
					game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("TargetEnemy",childAsync.Name)
				else
					lib:notify(lib:ColorFonts("No boss are detected","Red"),10)
					toggle.P14 = false
				end
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
    toggle.B7 = value
end)

T5:Button("Start fishing",function()
    if toggle.B7 == "Pet Park" then
        Fishing("Pet Park",Vector3.new(1138.7437744140625,9.686546325683594,1633.845703125))
    elseif toggle.B7 == "Mellow Meadows" then
        Fishing("Mellow Meadows",Vector3.new(874.0309448242188,21.719955444335938,1490.1602783203125))
    elseif toggle.B7 == "Auburn Woods" then
        Fishing("Auburn Woods",Vector3.new(716.324462890625,21.719636917114258,1150.069091796875))
    elseif toggle.B7 == "Frosty Peaks" then
        Fishing("Frosty Peaks",Vector3.new(977.94580078125,37.48805618286133,719.7373657226562))
    elseif toggle.B7 == "Sunset Shores" then
        Fishing("Sunset Shores",Vector3.new(1319.7314453125,37.488059997558594,621.930419921875))
    elseif toggle.B7 == "Dusty Dunes" then
        Fishing("Dusty Dunes",Vector3.new(1842.6231689453125,49.098777770996094,105.9592056274414))
    elseif toggle.B7 == "Gloomy Grotto" then
	Fishing("Gloomy Grotto",Vector3.new(1545.80615234375,49.098777770996094,-94.8126220703125))
    elseif toggle.B7 == "Magma Basin" or toggle.B7 == "The Summit" then
	Fishing("Magma Basin",Vector3.new(1260.465576171875,183.92877197265625,-435.5975646972656))
    else
	AlertSystem("Oops, this region is unavailable. try select another region.")
    end
end)

T5:Toggle("Auto cast every 4s",false,function(value)
    toggle.P15 = value
    game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("StartCastFishing")
    while wait(4) do
      if toggle.P15 == false then break end
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
    toggle.P16 = value
    while wait() do
        if toggle.P16 == false then break end
            tilesGetAsync(function(tilesAsync)
		if tilesAsync then
			game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("TryMinigameInput",tilesAsync)
		else
			lib:notify(lib:ColorFonts("Cant find minigame tiles","Red"),10)
		end
            end)
    end
end)

T6:Label("Auto play for dance-of coming soon\nthat minigames located in 'Gloomy Grotto'")

T7:Dropdown("Select item",items,function(value)
    toggle.B8 = value
end)

T7:Toggle("Auto use/hatch selected item",false,function(value)
    toggle.P17 = value
    while wait() do
        if toggle.P17 == false then break end
		if toggle.B8 == "Elite Mystery Egg" then
			game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Function"]:InvokeServer("TryHatchEgg","Elite Mystery Egg")
		elseif toggle.B8 == "Mystery Egg" then
			game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Function"]:InvokeServer("TryHatchEgg","Mystery Egg")
		elseif toggle.B8 == "Prismatic Mystery Egg" then
			game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Function"]:InvokeServer("TryHatchEgg","Prismatic Mystery Egg")
		else
			game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("UsePowerup",toggle.B8)
		end
	end
end)

T7:Toggle("Auto equip best pet",false,function(value)
    toggle.P18 = value
	while wait() do
		if toggle.P18 == false then break end
			game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("EquipBestPets")
	end
end)

T8:Dropdown("Select mount",mounts,function(value)
    config.mount = value
end)

T8:Toggle("Set hoverboard config",false,function(value)
    toggle.P19 = value
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
    toggle.alert = value
end)

T11:Toggle("Enable boss defeated alert",false,function(value)
    toggle.boss = value
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
	if toggle.P19 == true then
		self:SetAttribute("Mount",config.mount .. "/Default")
		lib:notify("Successfully sets the mount config to " .. lib:ColorFonts(config.mount,"Green"),10)
	end
end)

self.PlayerGui.ScreenGui.Region.Frame.Label:GetPropertyChangedSignal("Text"):Connect(function()
	lib:notify("Now Entering '" .. self.PlayerGui.ScreenGui.Region.Frame.Label.Text .. "'",10)
end)
		
self.PlayerGui.ScreenGui.Received.ChildAdded:Connect(function(i)
	if i.Label:IsA("TextLabel") and toggle.alert == true then
		childAsync(i.Label,function(get)
			if get.Name == rarity then
				AlertSystem("Congratulation! You got '" .. i.Label.Text .. "'")
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
	if self.PlayerGui.ScreenGui.BossHUD.Healthbar.Health.Text:sub(1,3) == "0 /" or self.PlayerGui.ScreenGui.BossHUD.Healthbar.Health.Text:sub(1,2) == "0/" and toggle.boss == true then
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
	if toggle.boss == true then
		AlertSystem(lib:ColorFonts(self.PlayerGui.ScreenGui.BossHUD.Healthbar.DisplayName.Text,"Red") .. " has appeared. Be careful to defeat him!")
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
	lib:notify("Gravity changed to " .. lib:ColorFonts(workspace.Gravity,"Green"),10)
end)

self.CharacterAdded:Connect(function(chrAsync)
	lib:notify(lib:ColorFonts("Respawned","Green"),10)
end)
-- BREAK
end)

if not isload and self.Name == "Rivanda_Cheater" then
	lib:WarnUser(error)
end

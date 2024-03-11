local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sidhsksjsjsh/VAPE-UI-MODDED/main/.lua"))()
local wndw = lib:Window("VIP Turtle Hub V4 - NEVER GIVE UP, GOD IS ALWAYS BESIDE U")
local T1 = wndw:Tab("Main")
local T2 = wndw:Tab("Shop")
local T3 = wndw:Tab("Boss")
local T4 = wndw:Tab("Unlock & Teleport")
local T5 = wndw:Tab("Sell & Fishing")
local T6 = wndw:Tab("Minigames")
local T7 = wndw:Tab("Items")
local T8 = wndw:Tab("Config")
local T9 = wndw:Tab("Crafting")

local self = game.Players.LocalPlayer
local crabInstance = ""
local grav = workspace.Gravity

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

-- pets._self.pos = 
-- pets._self.rarity = 
local workspace = game:GetService("Workspace")
local wo = {"The Blackmarket","The Summit"}
local act = {}
local upg = {}
local egg = {}
local shrine = {}
local mounts = {}
local items = {}

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
--game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("TargetEnemy",asyc)
T1:Toggle("Auto damage to enemies",false,function(value)
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

T1:Toggle("Auto damage to Armored Snowman [ Frosty Peaks ]",false,function(value)
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

T3:Toggle("Auto to safe place [ only work in kraken boss ]",false,function(value)
	_G.safezone = value
	if value then
		workspace.Gravity = 0
	else
		workspace.Gravity = grav
	end

		while wait() do
			if _G.safezone == false then break end
				self.Character.HumanoidRootPart.Position = Vector3.new(1176,85,337)
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

T5:Dropdown("Select world to start fishing",{"Pet Park","Mellow Meadows","Auburn Woods","Frosty Peaks","Sunset Shores","Dusty Dunes","Gloomy Grotto","Magma Basin"},function(value)
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
    elseif _G.fishworld == "Magma Basin" then
	Fishing("Magma Basin",Vector3.new(1260.465576171875,183.92877197265625,-435.5975646972656))
    else
	lib:WarnUser("Oops, this region is unavailable\ntry select another region.")
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
    lib:WarnUser(":5817: attempt to index nil with 'ServerStorage'")
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
	end
end)

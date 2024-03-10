local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sidhsksjsjsh/VAPE-UI-MODDED/main/.lua"))()
local wndw = lib:Window("VIP Turtle Hub V4 - 🔥🤖")
local T1 = wndw:Tab("Main")
local T2 = wndw:Tab("Shop")
local T3 = wndw:Tab("Loading Screen")
local T4 = wndw:Tab("Unlock & Teleport")
local T5 = wndw:Tab("Sell & Fishing")
local T6 = wndw:Tab("Minigames")
local T7 = wndw:Tab("Mystery Egg Hatcher")
local T8 = wndw:Tab("Config")
local T9 = wndw:Tab("Crafting")

local self = game.Players.LocalPlayer
local crabInstance = ""
local amount = {
    berry = 4115,
    craft = 1
}

local config = {
    mount = "Hoverboard"
}

local workspace = game:GetService("Workspace")
local wo = {}
local act = {}
local upg = {}
local egg = {}
local shrine = {}
local mounts = {}

lib:AddTable(workspace.Activations,act)
lib:AddTable(game:GetService("ReplicatedStorage").Assets.WorldMap,wo)
lib:AddTable(workspace.Upgrades,upg)
lib:AddTable(game:GetService("ReplicatedStorage").Assets.Eggs,egg)
lib:AddTable(workspace.Shrines,shrine)
lib:AddTable(game:GetService("ReplicatedStorage").Assets.Mounts,mounts)

T6:Label("this is for Ancient Dig minigames\nAncient Dig Minigame located in 'Dusty Dunes' world!")
T9:Label("Sorry ill change it into dropdown cus i have no time to\nmake item list")

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

local function tilesGetAsync(func)
    for i,v in pairs(workspace["Map"]["Dusty Dunes"]["Excavation"]["Tiles"]:GetChildren()) do
        func(v.Name)
    end
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

T1:Button("Claim all index [ Bypassed ]",function()
    for array = 1,100 do
        game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("ClaimIndexReward",array)
    end
end)

T1:Toggle("More damage to enemies",false,function(value)
    _G.mde = value
    while wait() do
        if _G.mde == false then break end
            game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("TargetEnemy",crabInstance)
    end
end)

T4:Dropdown("Select world",wo,function(value)
    _G.TpWorld = value
end)

T4:Button("Teleport",function()
    game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("TeleportBeacon",_G.TpWorld,"Spawn")
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

T3:Button("Bypass loading screen",function()
    self.PlayerGui.LoadingGui.Enabled = false
end)

--[[
local args = {
    [1] = "StartFishing",
    [2] = "Gloomy Grotto",
    [3] = Vector3.new(1545.80615234375, 49.098777770996094, -94.8126220703125)
}

game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer(unpack(args))
]]

T5:Dropdown("Select world to start fishing",{"Pet Park","Mellow Meadows","Auburn Woods","Frosty Peaks","Sunset Shores","Dusty Dunes","Gloomy Grotto"},function(value)
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

T5:Button("Fishing all region",function()
	Fishing("Pet Park",Vector3.new(1138.7437744140625,9.686546325683594,1633.845703125))
	Fishing("Mellow Meadows",Vector3.new(874.0309448242188,21.719955444335938,1490.1602783203125))
	Fishing("Auburn Woods",Vector3.new(716.324462890625,21.719636917114258,1150.069091796875))
	Fishing("Frosty Peaks",Vector3.new(977.94580078125,37.48805618286133,719.7373657226562))
	Fishing("Sunset Shores",Vector3.new(1319.7314453125,37.488059997558594,621.930419921875))
	Fishing("Dusty Dunes",Vector3.new(1842.6231689453125,49.098777770996094,105.9592056274414))
	Fishing("Gloomy Grotto",Vector3.new(1545.80615234375,49.098777770996094,-94.8126220703125))
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

T7:Dropdown("Select Mystery Egg",{"Elite Mystery Egg","Mystery Egg"},function(value)
    _G.mystype = value
end)

T7:Toggle("Auto hatch",false,function(value)
    _G.autmys = value
    while wait() do
        if _G.autmys == false then break end
            game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Function"]:InvokeServer("TryHatchEgg",_G.mystype)
    end
end)

T8:Dropdown("Select mount",mounts,function(value)
    config.mount = value
end)

T8:Toggle("Set hoverboard config",false,function(value)
    _G.treat = value
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
lib:HookFunction(function(method,received,args)
    if method == "FireServer" and received == "Event" and args[1] == "TargetEnemy" and args[2] ~= nil then
        crabInstance = args[2]
    end
end)

self:GetAttributeChangedSignal("Mount"):Connect(function()
	if _G.treat == true then
		self:SetAttribute("Mount",config.mount .. "/Default")
	end
end)

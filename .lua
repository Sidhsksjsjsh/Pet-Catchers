local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sidhsksjsjsh/VAPE-UI-MODDED/main/.lua"))()
local wndw = lib:Window("VIP Turtle Hub V4 - TURTLE HUB ON TOP ( dont complain )")
local T1 = wndw:Tab("Main")
local T2 = wndw:Tab("Shop")
local T3 = wndw:Tab("Loading Screen")
local T4 = wndw:Tab("Unlock & Teleport")
local T5 = wndw:Tab("Sell & Fishing")
local T6 = wndw:Tab("Minigames")
local T7 = wndw:Tab("Mystery Egg Hatcher")
local T8 = wndw:Tab("Treats")

local self = game.Players.LocalPlayer
local crabInstance = ""
local TreatsInstance = {
    berry = 9e9
}

local workspace = game:GetService("Workspace")
local wo = {}
local act = {}
local upg = {}
local egg = {}
local shrine = {}

lib:AddTable(workspace.Activations,act)
lib:AddTable(game:GetService("ReplicatedStorage").Assets.WorldMap,wo)
lib:AddTable(workspace.Upgrades,upg)
lib:AddTable(game:GetService("ReplicatedStorage").Assets.Eggs,egg)
lib:AddTable(workspace.Shrines,shrine)

T6:Label("this is for Ancient Dig minigames\nAncient Dig Minigame located in 'Dusty Dunes' world!")

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
    [2] = "Dusty Dunes",
    [3] = Vector3.new(1842.6231689453125, 49.098777770996094, 105.9592056274414)
}

game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer(unpack(args))
]]

T5:Dropdown("Select world to start fishing",{"Pet Park","Mellow Meadows","Auburn Woods","Frosty Peaks","Sunset Shores","Dusty Dunes"},function(value)
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

T8:Slider("Treats amount",0,9e9,16,function(value)
    TreatsInstance.berry = value
end)

T8:Toggle("Use all WildBerry",false,function(value)
    _G.treat = value
end)

--TreatsInstance.berry
--[[
local args = {
    [1] = "UseTreat",
    [2] = "5013788c-1513-40c6-acbb-314d76b65edc",
    [3] = "Wildberry",
    [4] = 350
}

game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Function"]:InvokeServer(unpack(args))
]]
lib:HookFunction(function(method,received,args)
    if method == "FireServer" and received == "Event" and args[1] == "TargetEnemy" and args[2] ~= nil then
        crabInstance = args[2]
    end
end)

lib:HookCalled(function(self,args)
     if self.Name == "Function" and args[1] == "UseTreat" and _G.treat == true then
        args[4] = TreatsInstance.berry
        return self.InvokeServer(self,unpack(args))
     end
end)

local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sidhsksjsjsh/VAPE-UI-MODDED/main/.lua"))()
local wndw = lib:Window("VIP Turtle Hub V4 - TURTLE HUB ON TOP ( dont complain )")
local T1 = wndw:Tab("Main")
local T2 = wndw:Tab("Shop")
local T3 = wndw:Tab("Loading Screen")
local T4 = wndw:Tab("Unlock & Teleport")
local T5 = wndw:Tab("Sell & Fishing")
local self = game.Players.LocalPlayer
local crabInstance = ""

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

T5:Dropdown("Select world to start fishing",wo,function(value)
    _G.fishworld = value
end)

T5:Button("Start fishing",function()
    game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Event"]:FireServer("StartFishing",_G.fishworld,self.Character.HumanoidRootPart.Position)
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

lib:HookFunction(function(method,received,args)
    if method == "FireServer" and received == "Event" and args[1] == "TargetEnemy" and args[2] ~= nil then
        crabInstance = args[2]
    end
end)

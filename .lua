local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sidhsksjsjsh/VAPE-UI-MODDED/main/.lua"))()
local wndw = lib:Window("VIP Turtle Hub V4 - More feature soon")
local T1 = wndw:Tab("Main")
local workspace = game:GetService("Workspace")

T1:Toggle("Auto catch all pets",false,function(value)
    _G.cpets = value
    while wait() do
      if _G.cpets == false then break end
      for i,v in pairs(workspace["Rendered"]["Pets"]["World"]) do
        game:GetService("ReplicatedStorage")["Shared"]["Framework"]["Network"]["Remote"]["Function"]:InvokeServer("CapturePet",v.Name,"Common")
      end
    end
end)

--[[ This script is copyrighted by Grims Community™ if you use the code, idea's, methods, if you use anything
from this code you have to give credits to Grims Community™ | Valco
]]--
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

local Window = Library.CreateLib("SLICE PVP [ALPHA]", "GrapeTheme")
local MainTab = Window:NewTab("Main")
local MainSection = MainTab:NewSection("Main Functions")

local TrollingTab = Window:NewTab("Trolling")
local TrollingSection = TrollingTab:NewSection("Trolling Functions")

local SpoofTab = Window:NewTab("Spoofing")
local SpoofSection = SpoofTab:NewSection("Spoofing Functions")
local plr = game:GetService("Players").LocalPlayer

MainSection:NewButton("Break Server [CANT UNBREAK IT]", "Breaks Server", function()
   while task.wait() do
 for _,v in pairs(game:GetService("Workspace"):GetDescendants()) do
       pcall(function()
           if v:IsA("BasePart") then 
              pcall(function()
                  plr.Character.Humanoid:EquipTool(plr.Backpack.Slice)
                end)
            local A_1 = v
            local A_2 = CFrame.new(math.random(-200,200), math.random(-200,200), math.random(-200,200))
            local Event = plr.Character.Slice.SliceEvent
            Event:FireServer(A_1, A_2)
            task.wait()
            end
        end) 
    end
    end
end)

MainSection:NewButton("Break Map", "Breaks Map", function()
    for _,v in pairs(game:GetService("Workspace"):GetDescendants()) do
       pcall(function()
           if v:IsA("BasePart") then 
               pcall(function()
                  plr.Character.Humanoid:EquipTool(plr.Backpack.Slice)
                end)
            local A_1 = v
            local A_2 = CFrame.new(math.random(-200,200), math.random(-200,200), math.random(-200,200))
            local Event = plr.Character.Slice.SliceEvent
            Event:FireServer(A_1, A_2)
            task.wait()
            end
        end) 
    end
end)

MainSection:NewButton("Infinite Health", "Gives you infinite health", function()
  game:GetService("Workspace").CurrentMap.Slice.Spawn["Safe Zone"].Size = Vector3.new(2555,2555,2555)
end)


getgenv().AutoSpamBalls = false
MainSection:NewToggle("Spam Balls", "Spams balls on everybody except you", function(state)
    if state then
        getgenv().AutoSpamBalls = true
        repeat
           task.wait()
        for _,v in pairs(game:GetService("Players"):GetChildren()) do
        pcall(function()
            if plr ~= v then
            local A_1 = "SummonBall"
            local A_2 = v.Character.HumanoidRootPart.Position
            local Event = game:GetService("ReplicatedStorage").Events.RemoteMessenger.SendData
            Event:FireServer(A_1, A_2)   
            end
        end)
        end
        until getgenv().AutoSpamBalls == false    
    else
        getgenv().AutoSpamBalls = false
    end
end)

getgenv().AutoSpamCylinders = false
MainSection:NewToggle("Spam Cylinders", "Spams Cylinders on everybody except you", function(state)
    if state then
        getgenv().AutoSpamCylinders = true
        repeat
            task.wait()
        for _,v in pairs(game:GetService("Players"):GetChildren()) do
        pcall(function()
            if plr ~= v then
            local A_1 = "SummonCylinder"
            local A_2 = v.Character.HumanoidRootPart.Position
            local Event = game:GetService("ReplicatedStorage").Events.RemoteMessenger.SendData
            Event:FireServer(A_1, A_2)   
            end
        end)
        end
        until getgenv().AutoSpamCylinders == false    
    else
        getgenv().AutoSpamCylinders = false
    end
end)

function GetPlayers() 
    local Players = {}
    for _,v in pairs(game:GetService("Players"):GetChildren()) do
       if v ~= plr then
           table.insert(Players, v.Name)
        end
    end
    return Players
end



local plrToFreeze = "None"

local PlayersDropDown = TrollingSection:NewDropdown("Freeze Player", "Select a player to freeze", GetPlayers(), function(currentOption)
    plrToFreeze = currentOption
end)


TrollingSection:NewButton("Freeze Player", "Freezes the player", function()
    if plrToFreeze ~= "None" then 
      
        plr.Character.Humanoid:EquipTool(plr.Backpack.Slice)
      
       pcall(function()
        local A_1 = game:GetService("Players"):FindFirstChild(plrToFreeze).Character.HumanoidRootPart
        local A_2 = CFrame.new(math.random(-200,200), math.random(-200,200), math.random(-200,200))
        local Event = plr.Character.Slice.SliceEvent
        Event:FireServer(A_1, A_2)
        task.wait(0.2)
           pcall(function()
               plr.Character.Humanoid:UnequipTools(plr.Character.Slice)
               end)
       end)
   end
end)

getgenv().Freeze = false
TrollingSection:NewToggle("Freeze Everybody", "Freezes everybody but you", function(state)
    if state then
        getgenv().Freeze = true
        repeat
            task.wait()
        for _,v in pairs(game:GetService("Players"):GetChildren()) do
           if v ~= plr then
            pcall(function()
                plr.Character.Humanoid:EquipTool(plr.Backpack.Slice)
            end)
            pcall(function()
                local A_1 = v.Character.HumanoidRootPart
                local A_2 = CFrame.new(math.random(-200,200), math.random(-200,200), math.random(-200,200))
                local Event = plr.Character.Slice.SliceEvent
                Event:FireServer(A_1, A_2)
            end)
            end
        end
        until getgenv().Freeze == false 
          pcall(function()
            plr.Character.Humanoid:UnequipTools(plr.Character.Slice)
        end)
    else
        getgenv().Freeze = false
    end
end)

local spoof = false
getgenv().SpoofIdle = false
SpoofSection:NewToggle("AFK Spoofer", "Spoofs you to pretend to be AFK or not", function(state)
    if state then
        getgenv().SpoofIdle = true
        repeat
        local A_1 = spoof
        local Event = game:GetService("ReplicatedStorage").AFK
        Event:FireServer(A_1)
        task.wait()
        until getgenv().SpoofIdle == false    
    else
        getgenv().SpoofIdle = false
    end
end)

SpoofSection:NewDropdown("AFK Spoof Options", "Select a spoof option", {"Spoof AFK", "Spoof Non-AFK"}, function(currentOption)
    if currentOption == "Spoof AFK" then spoof = true end
    if currentOption == "Spoof Non-AFK" then spoof = false end
end)

getgenv().SpoofChat = false
SpoofSection:NewToggle("Chat Spoof", "Makes people think your typing but your not", function(state)
    if state then
        getgenv().SpoofChat = true
        repeat
        local A_1 = true
        local Event = game:GetService("ReplicatedStorage").AddOnRemote.ToggleTypingBubble
        Event:FireServer(A_1)
        task.wait()
        until getgenv().SpoofChat == false    
    else
        local A_1 = false
        local Event = game:GetService("ReplicatedStorage").AddOnRemote.ToggleTypingBubble
        Event:FireServer(A_1)
        getgenv().SpoofChat = false
    end
end)

local CreditsTab = Window:NewTab("Credits")
local CreditsSection = CreditsTab:NewSection("Credits")
CreditsSection:NewLabel("Made by Valco#7818")

CreditsSection:NewButton("Join Discord", "Joins the discord server.", function()
    local http = game:GetService('HttpService') 
    local req = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or getgenv().request or request
	if req then
		req({
			Url = 'http://127.0.0.1:6463/rpc?v=1',
			Method = 'POST',
			Headers = {
				['Content-Type'] = 'application/json',
				Origin = 'https://discord.com'
			},
			Body = http:JSONEncode({
				cmd = 'INVITE_BROWSER',
				nonce = http:GenerateGUID(false),
				args = {code = 'nFKSeMVTG7'}
			})
		})
	end
end)

game:GetService("Players").PlayerAdded:Connect(function(v)
    PlayersDropDown:Refresh(GetPlayers())
end)

game:GetService("Players").PlayerRemoving:Connect(function(v)
    PlayersDropDown:Refresh(GetPlayers())
end)

--[[
Game Link: https://www.roblox.com/games/4003872968/Giant-Survival
Made By: Valco
Discord: https://dsc.gg/grimcity
]]--

--[[
Copyright © 2022 Grims Community™

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
]]--

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Giant Survival! UI", "GrapeTheme")

local Tab = Window:NewTab("Main")
local AutoSection = Tab:NewSection("OP Stuff")

local plr = game:GetService("Players").LocalPlayer

function GetGiantName()
    local Giants = {}
    for _,v in pairs(game:GetService("Workspace"):GetChildren()) do
        if v:IsA("Model") and v.Name:find("Giant")  then 
            table.insert(Giants, v.Name)
            end
    end
return Giants
end

function GetAllWeapons() 
    local WeaponsModule = require(game:GetService("ReplicatedStorage").Framework.Modules["7 | Weapon"]).weapons
    local Weapons = {}

    for _,v in pairs(WeaponsModule) do
        if WeaponsModule[_].gamepass_id == nil then 
        table.insert(Weapons, WeaponsModule[_].name .. " [REQUIRED LVL: " ..WeaponsModule[_].level .."]")
        end
    end
  
    return Weapons
end    

function GetAllGears() 
    local GearsModule = require(game:GetService("ReplicatedStorage").Framework.Modules["7 | Gear"]).gears
    local Gears = {}

    for _,v in pairs(GearsModule) do
        table.insert(Gears, GearsModule[_].name)
    end
  
    return Gears
end    

function GetAllPlayers() 
    local Players = {}
    for _,v in pairs(game:GetService("Players"):GetChildren()) do
        table.insert(Players, v.DisplayName .. " (@".. v.Name..")")
    end
    
    return Players
end    

function SplitString(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
end


getgenv().Auto = false
AutoSection:NewToggle("Auto Kill [BEST FOR XP]", "Auto kills the boss(s).", function(state)
    if state then
        getgenv().Auto = true
        repeat
            wait()
            pcall(function()
                for _,v in pairs(GetGiantName()) do
                 local A_1 = {
                [1] = v,
                [2] = 3,
                [3] = 1.024205997230985
            }
            local Event = game:GetService("Workspace")["__THINGS"]["__REMOTES"]["giant_dealdamage"]
            Event:FireServer(A_1)
                end
            end)
        until getgenv().Auto == false    
    else
        getgenv().Auto = false
    end
end)


getgenv().AutoMoney = false
AutoSection:NewToggle("Auto Add Money", "Auto gives you money.", function(state)
    if state then
        getgenv().AutoMoney = true
        repeat
            wait()
            pcall(function()
                local A_1 = 
                {
                [1] = {
                		[1] = false
                	},
                	[2] = {
                		[1] = 2
                	}
                }
                local Event = game:GetService("Workspace")["__THINGS"]["__REMOTES"]["currencycollected"]
                Event:FireServer(A_1)
                
            end)
        until getgenv().AutoMoney == false    
    else
        getgenv().AutoMoney = false
    end
end)

AutoSection:NewButton("Add Money", "Gives you money.", function()
     local A_1 = 
                {
                [1] = {
                		[1] = false
                	},
                	[2] = {
                		[1] = 2
                	}
                }
                local Event = game:GetService("Workspace")["__THINGS"]["__REMOTES"]["currencycollected"]
                Event:FireServer(A_1)
end)

local EquipWeaponsAndToolsSection = Tab:NewSection("Equip Weapons And Tools")
EquipWeaponsAndToolsSection:NewDropdown("Equip Weapon [NO GAMEPASS WEAPONS]", "Equips the weapon you want.", GetAllWeapons(), function(currentOption)
    local A_1 = 
{
	[1] = currentOption
}
local Event = game:GetService("Workspace")["__THINGS"]["__REMOTES"].weaponequipped
Event:FireServer(A_1)
pcall(function() plr.Character.Humanoid:TakeDamage(999) end)
end)

EquipWeaponsAndToolsSection:NewDropdown("Equip Gear", "Equips the gear you want.", GetAllGears(), function(currentOption)
    local A_1 = 
{
	[1] = currentOption
}
local Event = game:GetService("Workspace")["__THINGS"]["__REMOTES"].gearequipped
Event:FireServer(A_1)
pcall(function() plr.Character.Humanoid:TakeDamage(999) end)
end)

local LocalPlayerTab = Window:NewTab("Local Player")
local LocalPlayerSection = LocalPlayerTab:NewSection("Walk Speed And Jump Power")

LocalPlayerSection:NewSlider("Walk speed", "Changes your walk speed.", 500, plr.Character.Humanoid.WalkSpeed, function(s)
    plr.Character.Humanoid.WalkSpeed = s
end)

LocalPlayerSection:NewSlider("Jump power", "Changes your jump power.", 500, plr.Character.Humanoid.JumpPower, function(s) 
    plr.Character.Humanoid.JumpPower = s
end)

local TeleportSection = LocalPlayerTab:NewSection("Teleport To Player")

local PlayersDropDown = TeleportSection:NewDropdown("Teleport", "Teleports you to player.", GetAllPlayers(), function(currentOption)
    pcall(function()
    plr.Character.HumanoidRootPart.CFrame = game:GetService("Players")[SplitString(currentOption, " ")[1]].Character.HumanoidRootPart.CFrame    
    end)
end)


game:GetService("Players").PlayerAdded:Connect(function(v)
    PlayersDropDown:Refresh(GetAllPlayers())
end)

game:GetService("Players").PlayerRemoving:Connect(function(v)
    PlayersDropDown:Refresh(GetAllPlayers())
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

pcall(function()
    
local Plrs = game:GetService("Players")
local Run = game:GetService("RunService")

local MyPlr = Plrs.LocalPlayer
local MyChar = MyPlr.Character
while true do
MyChar = MyPlr.Character -- Player's character likes to go nil sometimes?
if MyChar then
local MyHum = MyChar:FindFirstChild("Humanoid")
local MyTor = MyChar:FindFirstChild("HumanoidRootPart")
if MyHum and MyTor then
MyHum.WalkToPoint = MyTor.Position + Vector3.new(0, 0, 1)
end
end
wait(30)
end    
end)


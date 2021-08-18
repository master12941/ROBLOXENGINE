local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Alprazolam - version 1.0", "Midnight")
-- Global vars
local localplayer = game.Players.LocalPlayer.Character.HumanoidRootPart

local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

local next = false

getgenv().tp = false
getgenv().loadscreen = false
getgenv().algorithm = false
getgenv().unblacklist = false

getgenv().solarisone = false
getgenv().autosolaris = false
getgenv().solaristhreshold = 0

getgenv().bitcoinone = false
getgenv().autobitcoin = false
getgenv().bitcointhreshold = 0

getgenv().claimstar = false
getgenv().antiafk = false
getgenv().claimcrate = false

-- Exploits
local Exploits = Window:NewTab("Exploits")

local Exploits1 = Exploits:NewSection("Exploits")

Exploits1:NewButton("Anti Blacklist", "Lets you walk through blacklisted plot barriers", function()
    checkbl()
    print("Unblacklist Phase")
end)
function checkbl()
    local plots = {"Plot_1", "Plot_2", "Plot_3", "Plot_4", "Plot_5", "Plot_6"}
    for _, v in pairs(game.Workspace:GetDescendants()) do
        for i=1, #plots do
            if v.Name == plots[i] then
                if v:FindFirstChild("Block") then
                    v.Block.CanCollide = false
                    v.Block:Destroy()
                end
            end
        end
    end
end

Exploits1:NewToggle("Remove Loading Screen", "Removes train loading screen", function(state)
    getgenv().loadscreen = state
    load_screen = game:GetService("Players").LocalPlayer.PlayerGui.Train.Frame
    if state then
        print("Loading Screen Disabled")
        load_screen.Visible = false
    else
        print("Loading Screen Enabled")
        load_screen.Visible = true
    end
end)

local Exploits2 = Exploits:NewSection("Unlocks")

Exploits2:NewToggle("Unlock TP", "Allows you to use the TP feature", function(state)
    getgenv().tp = state
    tp_lock = game:GetService("Players").LocalPlayer.PlayerGui.Phone.Frame.Apps.Warp.Locked
    if state then
        print("TP Unlocked")
        tp_lock.Visible = false
    else
        print("TP Locked")
        tp_lock.Visible = true
    end
end)

Exploits2:NewToggle("Unlock Algorithm", "Unlocks Algorithms (Regardless of level)", function(state)
    getgenv().algorithm = state
    game:GetService("Players").LocalPlayer.PlayerGui.Phone.Frame.Apps.MiningAlgorithms.Controller.Disabled = state
    if state then
        print("Algorithm Unlocked")
    else
        print("Algorithm Locked")
    end
end)

-- AUTOMATION
local Automation = Window:NewTab("Automation")
local Automation1 = Automation:NewSection("Solaris")
local Automation2 = Automation:NewSection("Bitcoin")

Automation1:NewButton("Exchange Solaris", "One time auto exchange", function()
    print("Exchanged Solaris")
    shop_location = CFrame.new(200,7,70)
        
    prev_pos = localplayer.CFrame
    localplayer.CFrame = shop_location
    wait(1)
    game:GetService("ReplicatedStorage").Events.ExchangeMoney:FireServer(false)
    wait(0.5)
    localplayer.CFrame = prev_pos
end)


Automation1:NewToggle("Exchange Solaris", "Toggle auto exchange", function(state)
    getgenv().autosolaris = state
    if state then
        print("Exchange Solaris On")
        autoexchangesolaris()
    else
        print("Exchange Solaris Off")
    end
end)

Automation1:NewSlider("Amount activation", "Amount of solaris to activate auto exchanger", 50, 1, function(s)
    getgenv().solaristhreshold = s
end)

function autoexchangesolaris()
    while getgenv().autosolaris do
        wait(1)
        shop_location = CFrame.new(200,7,70)
        solaris_amount = game:GetService("Players").LocalPlayer.leaderstats.Solaris.Value
        solaris_cash = game:GetService("Players").LocalPlayer.leaderstats.SCash.Value
        if solaris_amount >= getgenv().solaristhreshold * 1000000 then
            prev_pos = localplayer.CFrame
            repeat
                wait()
                localplayer.CFrame = shop_location
                game:GetService("ReplicatedStorage").Events.ExchangeMoney:FireServer(false)
            until solaris_cash ~= game:GetService("Players").LocalPlayer.leaderstats.SCash.Value
            wait()
            localplayer.CFrame = prev_pos
        end
    end
end
--
Automation2:NewButton("Exchange Bitcoin", "One time auto exchange", function()
    print("Exchanged Bitcoin")
    shop_location = CFrame.new(200,7,70)
        
    prev_pos = localplayer.CFrame
    localplayer.CFrame = shop_location
    wait(1)
    game:GetService("ReplicatedStorage").Events.ExchangeMoney:FireServer(true)
    wait(0.5)
    localplayer.CFrame = prev_pos
end)


Automation2:NewToggle("Exchange Bitcoin", "Toggle auto exchange", function(state)
    getgenv().autobitcoin = state
    if state then
        print("Exchange Bitcoin On")
        autoexchangebitcoin()
    else
        print("Exchange Bitcoin Off")
    end
end)

Automation2:NewSlider("Amount activation", "Amount of bitcoin to activate auto exchanger", 50, 1, function(s)
    getgenv().bitcointhreshold = s
end)

function autoexchangebitcoin()
    while getgenv().autobitcoin do
        wait(1)
        shop_location = CFrame.new(200,7,70)
        bitcoin_amount = game:GetService("Players").LocalPlayer.leaderstats.BitCoins.Value
        bitcoin_cash = game:GetService("Players").LocalPlayer.leaderstats.Cash.Value
        if bitcoin_amount >= getgenv().bitcointhreshold * 1000000 then
            prev_pos = localplayer.CFrame
            repeat
                wait()
                localplayer.CFrame = shop_location
                game:GetService("ReplicatedStorage").Events.ExchangeMoney:FireServer(true)
            until bitcoin_cash ~= game:GetService("Players").LocalPlayer.leaderstats.Cash.Value
            wait()
            localplayer.CFrame = prev_pos
        end
    end
end

local Automation2 = Automation:NewSection("Other Automations")
--[[
Automation2:NewToggle("Best Algorithm (Doesn't work)", "Changes Algorithm to the best one", function(state)

    if state then
        print("Best Algorithm On")
    else
        print("Best Algorithm Off")
    end
end)]]

Automation2:NewToggle("Claim Boost Stars", "Claims boost stars", function(state)
    getgenv().claimstar = state
    if state then
        print("Claim Boosts On")
        check_stars()
    else
        print("Claim Boosts Off")
    end
end)

function check_stars()
    while getgenv().claimstar do
        wait()
        boost = game:GetService("Players").LocalPlayer.PlayerGui.Boosts.TextButton.Notif
        if boost.Visible then
            print("Claimed Boost Star")
            game:GetService("ReplicatedStorage").Events.ClaimFreeBoostStar:FireServer()
        elseif boost.Visible ~= true then
        end
    end
end

Automation2:NewToggle("Claim Crates", "Claims crates", function(state)
    getgenv().claimcrate = state
    if state then
        print("Claim Crates On")
        check_crates()
    else
        print("Claim Crates Off")
    end
end)

function check_crates()
    while getgenv().claimcrate do
        wait()
        crate = game:GetService("Players").LocalPlayer.PlayerGui.Crates.TextButton.Frame
        if crate.Visible then
            print("Claimed Crate")
            game:GetService("ReplicatedStorage").Events.ClmFrCrt:FireServer(true)
            game:GetService("ReplicatedStorage").Events.ClmFrCrt:FireServer(false)
        elseif crate.Visible ~= true then
        end
    end
end

-- Teleportation
local Teleport = Window:NewTab("Teleportations")
local Teleport1 = Teleport:NewSection("Teleport Locations")

Teleport1:NewButton("Your Plot", "TPs you to your mining plot", function()
    plot_location = CFrame.new(game:GetService("Players").LocalPlayer.PlayerGui.Phone.Frame.Warp.ScrollingFrame["!!Plots"].posi.Value)
    wait(0.1)
    localplayer.CFrame = plot_location
end)

Teleport1:NewButton("Shop", "TPs you to the shop", function()
    shop_location = CFrame.new(200,7,70)
    wait(0.1)
    localplayer.CFrame = shop_location
end)

Teleport1:NewButton("Solaris Area", "TPs you to the solaris area", function()
    solaris_location = CFrame.new(-140, 40, 13921)
    wait(0.1)
    localplayer.CFrame = solaris_location
end)



-- MISC
local Misc = Window:NewTab("Misc")

local Misc1 = Misc:NewSection("Player Enhancements")

Misc1:NewSlider("Walk Speed", "Changes local player walk speed", 250, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

Misc1:NewSlider("Jump Power", "Changes local player jump power", 250, 50, function(s)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
end)

Misc1:NewToggle("Anti AFK", "Prevents you from being kicked", function(state)
    getgenv().antiafk = state
    if state then
        print("Anti AFK On")
        check_afk()
    else
        print("Anti AFK Off")
    end
end)
function check_afk()
    while getgenv().antiafk do
        wait(1)
        if next == false then
        repeat
            Humanoid.Jump = true
            wait(500)
            next = true
        until next
          next = false
        end
    end
end

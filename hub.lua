-- ⬛ DXD HUB ⚡ 2025 - FINAL VERSION W/ CLEAN KEY SYSTEM

-- 0. KEY CONFIG
local correctKeyURL = "https://gist.githubusercontent.com/hadoukenzy/33dbde55309ff802bb412012b170cb9c/raw/b09b8075a7846b04e52c5a89400d60e3870f0320/my-secret-lootlink-key"
local lootlinkURL = "https://loot-link.com/s?y2uz8yCS"
local correctKey = ""
local gotKey = false

-- Fetch key
local success, response = pcall(function()
    return game:HttpGet(correctKeyURL)
end)

if success and response then
    correctKey = response:match("^%s*(.-)%s*$")
else
    warn("Failed to fetch key from GitHub")
end

-- Load Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create main window
local Window = Rayfield:CreateWindow({
    Name = "DXD HUB ⚡ 2025",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "by enzy & dxrling",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "DXD_HUB",
        FileName = "Configuration"
    }
})

-- Create Key System Tab
local KeyTab = Window:CreateTab("🔐 Key System")

KeyTab:CreateInput({
    Name = "Enter Your Key",
    PlaceholderText = "Paste your key here",
    RemoveTextAfterFocusLost = false,
    Callback = function(userInput)
        if userInput == correctKey then
            gotKey = true
            Rayfield:Notify({
                Title = "Correct Key",
                Content = "Welcome to DXD HUB!",
                Duration = 5
            })
            task.wait(1.5)
            -- Remove key tab from UI
            KeyTab.TabFrame:Destroy()
            KeyTab:Destroy()
            for i, v in pairs(Window.Tabs) do
                if v == KeyTab then
                    table.remove(Window.Tabs, i)
                    break
                end
            end
        else
            Rayfield:Notify({
                Title = "Invalid Key",
                Content = "Check the link and try again.",
                Duration = 5
            })
        end
    end
})

KeyTab:CreateButton({
    Name = "📎 Get Key (via Loot-Link)",
    Callback = function()
        setclipboard(lootlinkURL)
        Rayfield:Notify({
            Title = "Loot-Link",
            Content = "Link copied to clipboard. Complete steps to get your key!",
            Duration = 5
        })
    end
})

-- Wait until correct key is entered
repeat task.wait() until gotKey

-- 1. Game module config
local Modules = {
    [2753915549] = "https://gist.githubusercontent.com/hadoukenzy/3f70899df182d4f10d3fc6055b15f73c/raw/ce41700a4e9d248b23205c5a74b8b7feb9fe63a3/blox_fruits.lua", -- Blox Fruits
    [1537690962] = "murder_mystery.lua", -- Murder Mystery 2
    [126884695634066] = "https://gist.githubusercontent.com/hadoukenzy/c7e0e34391bfaa7d429ab65d0121495b/raw/055d368acf7f647c91baa5b60721889ead9ffd8f/grow_a_garden.lua", -- Grow A Garden!
    [125009265613167] = "https://gist.githubusercontent.com/hadoukenzy/4792f688f6c7e12024216d1fcf4b0932/raw/a734552a7d904a240a66b81732525e4686022efa/ink_game.lua", -- Ink Game
    [109983668079237] = "https://gist.githubusercontent.com/hadoukenzy/cf7214c4ef25dbcb9d8712f6d624bfd3/raw/669144202d145fd37a258838cefef14a34742a37/steal_a_brainrot.lua" -- Steal a Brainrot
}
local UniversalModule = "universal.lua"
local version = "1.3.7"
local VersionURL = "https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/version.txt"

-- Detect game
local id = game.PlaceId
local modURL = Modules[id] or UniversalModule

local gameName = "Unknown Game"
local successInfo, info = pcall(function()
    return game:GetService("MarketplaceService"):GetProductInfo(id)
end)
if successInfo and info and info.Name then
    gameName = info.Name
end

Rayfield:Notify({
    Title = "Game Detected",
    Content = "Your game is: " .. gameName .. ". Loading appropriate script...",
    Duration = 6
})

-- Module loader
local function LoadModule(url)
    local success, content = pcall(game.HttpGet, game, url, true)
    if success then
        local fn, err = loadstring(content)
        if fn then
            pcall(fn, Window)
            return true
        else
            Rayfield:Notify({
                Title = "Script Error",
                Content = "Failed to compile module: " .. err,
                Duration = 5
            })
        end
    else
        Rayfield:Notify({
            Title = "Download Error",
            Content = "Failed to download module: " .. content,
            Duration = 5
        })
    end
    return false
end

-- Load current module
LoadModule(modURL)

-- Version check
local successVer, latestVer = pcall(function()
    return game:HttpGet(VersionURL, true)
end)
if successVer and latestVer and latestVer:gsub("%s+", "") ~= version then
    Rayfield:Notify({
        Title = "Update Available",
        Content = "New version " .. latestVer .. " is available! Please restart the loader.",
        Duration = 8
    })
end

-- Final info tab
local InfoTab = Window:CreateTab("ℹ️ Info")

InfoTab:CreateLabel("Your current Game: " .. gameName)
InfoTab:CreateLabel("Script developers: enzy & dxrling")

InfoTab:CreateButton({
    Name = "Re-inject Current Module",
    Callback = function()
        LoadModule(modURL)
    end
})

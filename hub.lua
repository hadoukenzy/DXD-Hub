-- ⬛️ DXD HUB ⚡️ 2025 - FINAL VERSION W/ CLEAN KEY SYSTEM

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
    Name = "DXD HUB ⚡️ 2025",
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

-- ✅ 1. Game module config (CORRECTED PlaceIds & URLs)
local Modules = {
    [2753915549] = "https://raw.githubusercontent.com/hadoukenzy/DXD-Hub/main/scripts/blox_fruits.lua",
    [142823291] = "https://raw.githubusercontent.com/hadoukenzy/DXD-Hub/main/scripts/murder_mystery.lua",
    [126884695634066] = "https://raw.githubusercontent.com/hadoukenzy/DXD-Hub/main/scripts/grow_a_garden.lua",
    [99567941238278] = "https://raw.githubusercontent.com/hadoukenzy/DXD-Hub/main/scripts/ink_game.lua",
    [109983668079237] = "https://raw.githubusercontent.com/hadoukenzy/DXD-Hub/main/scripts/steal_a_brainrot.lua",
    [70671905624144] = "https://raw.githubusercontent.com/hadoukenzy/DXD-Hub/main/scripts/steal_a_baddie.lua",
    [126509999114328] = "https://raw.githubusercontent.com/hadoukenzy/DXD-Hub/main/scripts/99_nights_in_forest.lua",
    [4924922222] = "https://raw.githubusercontent.com/hadoukenzy/DXD-Hub/main/scripts/brookhaven.lua",
    [6766156863] = "https://raw.githubusercontent.com/hadoukenzy/DXD-Hub/main/scripts/strongman_simulator.lua",
    [192800] = "https://raw.githubusercontent.com/hadoukenzy/DXD-Hub/main/scripts/work_at_a_pizza_place.lua"
}

-- fallback module
local UniversalModule = "https://raw.githubusercontent.com/hadoukenzy/DXD-Hub/main/scripts/universal.lua"

-- versioning
local version = "1.3.7"
local VersionURL = "https://raw.githubusercontent.com/hadoukenzy/DXD-Hub/main/version.txt"

-- Detect current game
local id = game.PlaceId
local modURL = Modules[id] or UniversalModule

-- Get game name
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

-- Info tab
local InfoTab = Window:CreateTab("ℹ️ Info")

InfoTab:CreateLabel("Your current Game: " .. gameName)
InfoTab:CreateLabel("PlaceId: " .. tostring(id))
InfoTab:CreateLabel("Script developers: enzy & dxrling")

InfoTab:CreateButton({
    Name = "Re-inject Current Module",
    Callback = function()
        LoadModule(modURL)
    end
})

-- Supported games list
InfoTab:CreateLabel("🎮 Supported Games:")

-- Emoji map
local emojiMap = {
    ["blox fruits"] = "🍏",
    ["murder mystery"] = "🔪",
    ["grow a garden"] = "🌸",
    ["ink game"] = "🖋️",
    ["steal a brainrot"] = "🧠",
    ["steal a baddie"] = "💃",
    ["99 nights in forest"] = "🌲",
    ["brookhaven"] = "🏡",
    ["strongman simulator"] = "💪",
    ["work at a pizza place"] = "🍕"
}

-- Helper to format name
local function prettifyNameFromURL(url)
    local name = url:match(".+/([%w_]+)%.lua$")
    local readable = name:gsub("_", " ")
    local formatted = readable:gsub("(%a)([%w]*)", function(a, b) return a:upper() .. b:lower() end)
    local lowercase = readable:lower()
    local emoji = emojiMap[lowercase] or "🎲"
    return emoji .. " " .. formatted
end

-- Loop and list games
for _, url in pairs(Modules) do
    local gameLabel = prettifyNameFromURL(url)
    InfoTab:CreateLabel("- " .. gameLabel)
end

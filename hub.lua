-- ⬛ DXD HUB ⚡ 2025 - FINAL VERSION W/ CLEAN KEY SYSTEM

-- 0. KEY CONFIG
local correctKeyURL = "https://gist.githubusercontent.com/hadoukenzy/33dbde55309ff802bb412012b170cb9c/raw/b09b8075a7846b04e52c5a89400d60e3870f0320/my-secret-lootlink-key"
local lootlinkURL = "https://loot-link.com/s?y2uz8yCS"
local correctKey = ""
local gotKey = false

-- Fetch key
local success, response = pcall(function()
    return game:HttpGet(correctKeyURL, true)
end)

if success and response then
    correctKey = response:match("^%s*(.-)%s*$")
else
    warn("Failed to fetch key from GitHub: " .. tostring(response))
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
            KeyTab:Destroy()
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

-- ✅ 1. Game module config (UPDATED with jsDelivr URLs for better reliability)
local Modules = {
    [2753915549] = "https://cdn.jsdelivr.net/gh/hadoukenzy/DXD-Hub@main/scripts/blox_fruits.lua", -- Blox Fruits
    [142823291] = "https://cdn.jsdelivr.net/gh/hadoukenzy/DXD-Hub@main/scripts/murder_mystery.lua", -- Murder Mystery 2
    [5985232436] = "https://cdn.jsdelivr.net/gh/hadoukenzy/DXD-Hub@main/scripts/grow_a_garden.lua", -- Grow a Garden!
    [6186867282] = "https://cdn.jsdelivr.net/gh/hadoukenzy/DXD-Hub@main/scripts/ink_game.lua", -- The Ink Game
    [9872472334] = "https://cdn.jsdelivr.net/gh/hadoukenzy/DXD-Hub@main/scripts/steal_a_brainrot.lua" -- Steal a Brainrot
}

-- fallback module with jsDelivr
local UniversalModule = "https://cdn.jsdelivr.net/gh/hadoukenzy/DXD-Hub@main/scripts/universal.lua"

-- versioning
local version = "1.3.7"
local VersionURL = "https://cdn.jsdelivr.net/gh/hadoukenzy/DXD-Hub@main/version.txt"

-- Detect current game
local id = game.PlaceId
local modURL = Modules[id] or UniversalModule

-- Get game name with better error handling
local gameName = "Unknown Game"
local successInfo, info = pcall(function()
    return game:GetService("MarketplaceService"):GetProductInfo(id)
end)
if successInfo and info and info.Name then
    gameName = info.Name
end

Rayfield:Notify({
    Title = "Game Detected",
    Content = "Your game is: " .. gameName .. " (PlaceId: " .. id .. ")",
    Duration = 6
})

-- Improved module loader with better error reporting
local function LoadModule(url)
    Rayfield:Notify({
        Title = "Loading Module",
        Content = "Attempting to load from: " .. url,
        Duration = 4
    })
    
    local success, content = pcall(function()
        return game:HttpGet(url, true)
    end)
    
    if not success then
        Rayfield:Notify({
            Title = "HTTP Error",
            Content = "Failed to download module: " .. content,
            Duration = 6
        })
        return false
    end
    
    local fn, err = loadstring(content)
    if not fn then
        Rayfield:Notify({
            Title = "Compilation Error",
            Content = "Failed to compile module: " .. tostring(err),
            Duration = 6
        })
        return false
    end
    
    local execSuccess, execErr = pcall(fn, Window)
    if not execSuccess then
        Rayfield:Notify({
            Title = "Execution Error",
            Content = "Module failed to execute: " .. tostring(execErr),
            Duration = 6
        })
        return false
    end
    
    return true
end

-- Attempt to load current module with retry logic
local loaded = false
for i = 1, 3 do -- Try 3 times
    if LoadModule(modURL) then
        loaded = true
        break
    end
    task.wait(2) -- Wait 2 seconds before retry
end

if not loaded then
    Rayfield:Notify({
        Title = "Critical Error",
        Content = "Failed to load module after 3 attempts",
        Duration = 8
    })
end

-- Version check with improved handling
local successVer, latestVer = pcall(function()
    return game:HttpGet(VersionURL, true):gsub("%s+", "")
end)

if successVer and latestVer then
    if latestVer ~= version then
        Rayfield:Notify({
            Title = "Update Available",
            Content = "New version " .. latestVer .. " is available! (Current: " .. version .. ")",
            Duration = 8
        })
    end
else
    Rayfield:Notify({
        Title = "Version Check Failed",
        Content = "Could not check for updates: " .. tostring(latestVer),
        Duration = 6
    })
end

-- Info tab
local InfoTab = Window:CreateTab("ℹ️ Info")

InfoTab:CreateLabel("Current Game: " .. gameName)
InfoTab:CreateLabel("Place ID: " .. tostring(id))
InfoTab:CreateLabel("Script Version: " .. version)
InfoTab:CreateLabel("Developers: enzy & dxrling")

InfoTab:CreateButton({
    Name = "Re-inject Current Module",
    Callback = function()
        LoadModule(modURL)
    end
})

InfoTab:CreateButton({
    Name = "Copy Game ID",
    Callback = function()
        setclipboard(tostring(id))
        Rayfield:Notify({
            Title = "Copied",
            Content = "Game ID copied to clipboard",
            Duration = 2
        })
    end
})

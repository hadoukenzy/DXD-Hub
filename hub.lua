-- ⬛ DXD HUB ⚡ 2025 — ВСТАВКА ГОТОВЫХ СКРИПТОВ + КЛЮЧ С GITHUB

-- КОНФИГ КЛЮЧА
local correctKeyURL = "https://gist.githubusercontent.com/hadoukenzy/33dbde55309ff802bb412012b170cb9c/raw/b09b8075a7846b04e52c5a89400d60e3870f0320/my-secret-lootlink-key"
local lootlinkURL = "https://loot-link.com/s?y2uz8yCS"
local correctKey = ""
local gotKey = false

-- Получаем ключ с GitHub
local success, response = pcall(function()
    return game:HttpGet(correctKeyURL)
end)
if success and response then
    correctKey = response:match("^%s*(.-)%s*$")
else
    warn("❌ Не удалось загрузить ключ с GitHub")
end

-- UI через Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
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

-- Ключ-система
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
            KeyTab.TabFrame:Destroy()
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

-- Ждём ввода ключа
repeat task.wait() until gotKey

-- ВСТРОЕННЫЕ СКРИПТЫ
local Modules = {
    [2753915549] = [[
        local tab = Window:CreateTab("🍍 Blox Fruits")
        tab:CreateLabel("Blox Fruits Loaded")
        loadstring(game:HttpGet(('https://raw.githubusercontent.com/ThunderZ-05/HUB/main/TestKey')))()
    ]],

    [142823291] = [[
        local tab = Window:CreateTab("🔪 MM2")
        tab:CreateLabel("Murder Mystery 2 Loaded")
        -- вставь сюда свой код
    ]],

    [5985232436] = [[
        local tab = Window:CreateTab("🌱 Garden")
        tab:CreateLabel("Grow a Garden Loaded")
        -- вставь сюда свой код
    ]],

    [6186867282] = [[
        local tab = Window:CreateTab("🖋️ Ink Game")
        tab:CreateLabel("Ink Game Loaded")
        -- вставь сюда свой код
    ]],

    [9872472334] = [[
        local tab = Window:CreateTab("🧠 Brainrot")
        tab:CreateLabel("Brainrot Loaded")
        -- вставь сюда свой код
    ]]
}

-- универсальный скрипт
local UniversalScript = [[
    local tab = Window:CreateTab("🌍 Universal")
    tab:CreateLabel("This game is not supported yet.")
]]

-- Определяем игру
local id = game.PlaceId
local scriptCode = Modules[id] or UniversalScript

-- Получаем имя игры
local gameName = "Unknown Game"
local successInfo, info = pcall(function()
    return game:GetService("MarketplaceService"):GetProductInfo(id)
end)
if successInfo and info and info.Name then
    gameName = info.Name
end

Rayfield:Notify({
    Title = "Game Detected",
    Content = "Your game is: " .. gameName .. ". Loading script...",
    Duration = 6
})

-- Загружаем скрипт
local fn, err = loadstring(scriptCode)
if fn then
    local ok, result = pcall(fn)
    if not ok then
        Rayfield:Notify({
            Title = "Script Error",
            Content = tostring(result),
            Duration = 5
        })
    end
else
    Rayfield:Notify({
        Title = "Load Error",
        Content = tostring(err),
        Duration = 5
    })
end

-- Инфо вкладка
local InfoTab = Window:CreateTab("ℹ️ Info")
InfoTab:CreateLabel("Your current Game: " .. gameName)
InfoTab:CreateLabel("Script developers: enzy & dxrling")

InfoTab:CreateButton({
    Name = "Re-inject Current Script",
    Callback = function()
        local reload, err = loadstring(scriptCode)
        if reload then
            pcall(reload)
        else
            Rayfield:Notify({
                Title = "Reload Error",
                Content = tostring(err),
                Duration = 5
            })
        end
    end
})

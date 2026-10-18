-- [V] Ilh8m8 GUI (Abieb) v3 - Full Templates & Editable IDs
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- State
local AssetIDs = {
    TrollFace = "125425233033462",
    GenericAsset = "116786398220383",
    JumpscareSound = "1837258874",
    DecalSpam = "16131809733",
    Skybox1 = "116786398220383",
    Skybox2 = "113197003713530",
}
local HintText = "Hacked By Ilh8m8 (Abieb)"

local Ilh8m8Client = {}
local permanentHint = nil
local idInputBoxes = {}

local function cleanup(name)
    local old = playerGui:FindFirstChild(name)
    if old then old:Destroy() end
end

-- ==========================================
-- PAYLOADS (semua dipertahankan)
-- ==========================================

function Ilh8m8Client.SkyboxChaos()
    cleanup("SkyboxChaos")
    local sky = Lighting:FindFirstChildOfClass("Sky") or Instance.new("Sky", Lighting)
    local gui = Instance.new("ScreenGui", playerGui)
    gui.Name = "SkyboxChaos"
    gui.ResetOnSpawn = false
    local running = true
    task.spawn(function()
        while running and gui.Parent do
            local id1 = "rbxassetid://" .. AssetIDs.Skybox1
            local id2 = "rbxassetid://" .. AssetIDs.Skybox2
            for _, p in ipairs({"SkyboxBk","SkyboxDn","SkyboxFt","SkyboxLf","SkyboxRt","SkyboxUp"}) do sky[p] = id1 end
            task.wait(0.1)
            for _, p in ipairs({"SkyboxBk","SkyboxDn","SkyboxFt","SkyboxLf","SkyboxRt","SkyboxUp"}) do sky[p] = id2 end
            task.wait(0.1)
        end
    end)
    gui.Destroying:Connect(function() running = false end)
end

function Ilh8m8Client.DecalSpam()
    local decalId = "rbxassetid://" .. AssetIDs.DecalSpam
    local count = 0
    for _, part in ipairs(Workspace:GetDescendants()) do
        if part:IsA("BasePart") then
            for _, face in ipairs(Enum.NormalId:GetEnumItems()) do
                local decal = Instance.new("Decal")
                decal.Texture = decalId
                decal.Face = face
                decal.Parent = part
            end
            count = count + 1
            if count % 50 == 0 then task.wait() end
        end
    end
end

function Ilh8m8Client.ParticleStorm()
    local particleId = "rbxassetid://" .. AssetIDs.GenericAsset
    local count = 0
    for _, part in ipairs(Workspace:GetDescendants()) do
        if part:IsA("BasePart") then
            local emitter = Instance.new("ParticleEmitter")
            emitter.Texture = particleId
            emitter.Rate = 150
            emitter.Speed = NumberRange.new(15, 30)
            emitter.Lifetime = NumberRange.new(1, 3)
            emitter.Parent = part
            count = count + 1
            if count % 50 == 0 then task.wait() end
        end
    end
end

function Ilh8m8Client.FireSpam()
    local count = 0
    for _, part in ipairs(Workspace:GetDescendants()) do
        if part:IsA("BasePart") then
            local fire = Instance.new("Fire")
            fire.Heat = 50
            fire.Size = 20
            fire.Parent = part
            count = count + 1
            if count % 50 == 0 then task.wait() end
        end
    end
end

function Ilh8m8Client.TrollFaceBillboard()
    local trollId = "rbxassetid://" .. AssetIDs.TrollFace
    for _, plr in ipairs(Players:GetPlayers()) do
        local char = plr.Character
        if char and char:FindFirstChild("Head") then
            local existing = char.Head:FindFirstChild("TrollFaceBillboard")
            if not existing then
                local billboard = Instance.new("BillboardGui")
                billboard.Name = "TrollFaceBillboard"
                billboard.Size = UDim2.new(4, 0, 4, 0)
                billboard.StudsOffset = Vector3.new(0, 3.5, 0)
                billboard.AlwaysOnTop = true
                billboard.Parent = char.Head
                local image = Instance.new("ImageLabel")
                image.Size = UDim2.new(1, 0, 1, 0)
                image.BackgroundTransparency = 1
                image.Image = trollId
                image.ScaleType = Enum.ScaleType.Fit
                image.Parent = billboard
            else
                local img = existing:FindFirstChildOfClass("ImageLabel")
                if img then img.Image = trollId end
            end
        end
    end
end

function Ilh8m8Client.PermanentHint(text)
    if text then HintText = text end
    if permanentHint and permanentHint.Parent then
        permanentHint.Text = HintText
    else
        permanentHint = Instance.new("Hint", Workspace)
        permanentHint.Text = HintText
    end
end

function Ilh8m8Client.StopHint()
    if permanentHint then permanentHint:Destroy(); permanentHint = nil end
end

function Ilh8m8Client.Jumpscare()
    local sound = Instance.new("Sound", SoundService)
    sound.SoundId = "rbxassetid://" .. AssetIDs.JumpscareSound
    sound.Volume = 10
    sound.PlaybackSpeed = 1.25
    sound:Play()
    local flash = Instance.new("Frame", playerGui)
    flash.Size = UDim2.new(1, 0, 1, 0)
    flash.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    flash.BackgroundTransparency = 0.3
    flash.ZIndex = 100
    task.wait(0.2)
    flash:Destroy()
end

function Ilh8m8Client.UnanchorAll()
    for _, part in ipairs(Workspace:GetDescendants()) do
        if part:IsA("BasePart") then part.Anchored = false end
    end
end

function Ilh8m8Client.DiscoMode()
    cleanup("DiscoMode")
    local gui = Instance.new("ScreenGui", playerGui)
    gui.Name = "DiscoMode"
    gui.ResetOnSpawn = false
    local running = true
    task.spawn(function()
        while running and gui.Parent do
            Lighting.Ambient = Color3.new(math.random(), math.random(), math.random())
            Lighting.OutdoorAmbient = Color3.new(math.random(), math.random(), math.random())
            task.wait(0.15)
        end
    end)
    gui.Destroying:Connect(function() running = false end)
end

function Ilh8m8Client.ClearAllPayloads()
    for _, obj in ipairs(playerGui:GetDescendants()) do
        if obj.Name:match("Chaos") or obj.Name:match("Disco") or obj.Name:match("Jumpscare") then obj:Destroy() end
    end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr.Character and plr.Character:FindFirstChild("Head") then
            local bb = plr.Character.Head:FindFirstChild("TrollFaceBillboard")
            if bb then bb:Destroy() end
        end
    end
    Ilh8m8Client.StopHint()
    Lighting.Ambient = Color3.fromRGB(70, 70, 70)
    Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
end

-- ==========================================
-- TEMPLATES (per-ID, klik = langsung set)
-- ==========================================
local Templates = {
    TrollFace = {
        { name = "Sonic.exe", id = "125425233033462" },
        { name = "Troll Face", id = "19125414" },
        { name = "Doge", id = "157166231" },
        { name = "Noob", id = "1481665" },
        { name = "Derp", id = "157003559" },
    },
    DecalSpam = {
        { name = "G00byD0lan", id = "16131809733" },
        { name = "Troll Face", id = "19125414" },
        { name = "Doge", id = "157166231" },
        { name = "Noob", id = "1481665" },
        { name = "Sonic.exe", id = "125425233033462" },
        { name = "Derp", id = "157003559" },
    },
    Skybox1 = {
        { name = "Asset A", id = "116786398220383" },
        { name = "Asset B", id = "113197003713530" },
    },
    Skybox2 = {
        { name = "Asset A", id = "116786398220383" },
        { name = "Asset B", id = "113197003713530" },
    },
    GenericAsset = {
        { name = "Asset A", id = "116786398220383" },
        { name = "Star", id = "1325388082" },
        { name = "Smoke", id = "240096761" },
    },
    JumpscareSound = {
        { name = "G00byD0lan", id = "1837258874" },
        { name = "Oof", id = "9118823103" },
        { name = "Scream", id = "3757922864" },
        { name = "Airhorn", id = "2699798940" },
    },
}
local HintTemplates = {
    { name = "Ilh8m8", text = "Hacked By Ilh8m8 (Abieb)" },
    { name = "Ilh8m8 Was Here", text = "Ilh8m8 was here" },
    { name = "Owned by Abieb", text = "Owned by Abieb" },
    { name = "C00lkidd", text = "c00lkidd was here" },
    { name = "G00byD0lan", text = "g00byd0lan was here" },
    { name = "SERVER HACKED", text = "SERVER HACKED" },
    { name = "Goofed", text = "you got goofed lol" },
    { name = "Skill Issue", text = "skill issue" },
}

-- ==========================================
-- GUI
-- ==========================================
local function createGUI()
    cleanup("Ilh8m8GUI")
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "Ilh8m8GUI"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.Parent = playerGui
    
    local mainFrame = Instance.new("Frame", screenGui)
    mainFrame.Size = UDim2.new(0, 620, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -310, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(14, 16, 22)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    local mCorner = Instance.new("UICorner", mainFrame)
    mCorner.CornerRadius = UDim.new(0, 8)
    local mStroke = Instance.new("UIStroke", mainFrame)
    mStroke.Color = Color3.fromRGB(0, 255, 255)
    mStroke.Thickness = 1.5
    mStroke.Transparency = 0.4
    
    -- Header
    local header = Instance.new("Frame", mainFrame)
    header.Size = UDim2.new(1, 0, 0, 45)
    header.BackgroundColor3 = Color3.fromRGB(20, 24, 35)
    header.BorderSizePixel = 0
    local hCorner = Instance.new("UICorner", header)
    hCorner.CornerRadius = UDim.new(0, 8)
    local hFix = Instance.new("Frame", header)
    hFix.Size = UDim2.new(1, 0, 0, 15)
    hFix.Position = UDim2.new(0, 0, 1, -15)
    hFix.BackgroundColor3 = Color3.fromRGB(20, 24, 35)
    hFix.BorderSizePixel = 0
    
    local titleText = Instance.new("TextLabel", header)
    titleText.Size = UDim2.new(1, -100, 1, 0)
    titleText.Position = UDim2.new(0, 20, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.Text = "Ilh8m8 GUI (Abieb)"
    titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleText.TextSize = 18
    titleText.Font = Enum.Font.GothamBold
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    
    local closeBtn = Instance.new("TextButton", header)
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -45, 0, 7.5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    closeBtn.BorderSizePixel = 0
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)
    closeBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)
    
    -- Sidebar
    local sidebar = Instance.new("Frame", mainFrame)
    sidebar.Size = UDim2.new(0, 150, 1, -45)
    sidebar.Position = UDim2.new(0, 0, 0, 45)
    sidebar.BackgroundColor3 = Color3.fromRGB(18, 20, 28)
    sidebar.BorderSizePixel = 0
    
    -- Content
    local content = Instance.new("Frame", mainFrame)
    content.Size = UDim2.new(1, -150, 1, -45)
    content.Position = UDim2.new(0, 150, 0, 45)
    content.BackgroundColor3 = Color3.fromRGB(22, 26, 36)
    content.BorderSizePixel = 0
    Instance.new("UICorner", content).CornerRadius = UDim.new(0, 8)
    
    -- Tab system
    local tabs, pages = {}, {}
    local function createTab(name, order)
        local btn = Instance.new("TextButton", sidebar)
        btn.Size = UDim2.new(1, -20, 0, 35)
        btn.Position = UDim2.new(0, 10, 0, order * 42 + 10)
        btn.BackgroundColor3 = Color3.fromRGB(30, 35, 48)
        btn.BorderSizePixel = 0
        btn.Text = name
        btn.TextColor3 = Color3.fromRGB(180, 190, 210)
        btn.Font = Enum.Font.GothamSemibold
        btn.TextSize = 13
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
        btn.MouseEnter:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(45, 55, 75), TextColor3 = Color3.fromRGB(0, 255, 255)}):Play()
        end)
        btn.MouseLeave:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(30, 35, 48), TextColor3 = Color3.fromRGB(180, 190, 210)}):Play()
        end)
        table.insert(tabs, btn)
        return btn
    end
    
    local function createPage(scrollable)
        local frame = Instance.new("ScrollingFrame", content)
        frame.Size = UDim2.new(1, -20, 1, -20)
        frame.Position = UDim2.new(0, 10, 0, 10)
        frame.BackgroundTransparency = 1
        frame.Visible = false
        frame.ScrollBarThickness = 6
        frame.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 255)
        frame.CanvasSize = UDim2.new(0, 0, 0, 0)
        frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        if scrollable ~= false then
            local layout = Instance.new("UIGridLayout", frame)
            layout.CellSize = UDim2.new(0, 180, 0, 38)
            layout.CellPadding = UDim2.new(0, 10, 0, 10)
        end
        table.insert(pages, frame)
        return frame
    end
    
    local trollPage = createPage()
    local worldPage = createPage()
    local chaosPage = createPage()
    local idPage = createPage(false) -- pakai UIListLayout
    
    local idListLayout = Instance.new("UIListLayout", idPage)
    idListLayout.Padding = UDim.new(0, 8)
    idListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    local function switchPage(page)
        for _, p in ipairs(pages) do p.Visible = false end
        page.Visible = true
    end
    
    local trollTab = createTab("Troll", 0)
    local worldTab = createTab("World", 1)
    local chaosTab = createTab("Chaos", 2)
    local idTab = createTab("IDs & Templates", 3)
    
    trollTab.MouseButton1Click:Connect(function() switchPage(trollPage) end)
    worldTab.MouseButton1Click:Connect(function() switchPage(worldPage) end)
    chaosTab.MouseButton1Click:Connect(function() switchPage(chaosPage) end)
    idTab.MouseButton1Click:Connect(function() switchPage(idPage) end)
    
    -- Button helper
    local function addButton(parent, text, callback)
        local btn = Instance.new("TextButton", parent)
        btn.Size = UDim2.new(0, 180, 0, 38)
        btn.BackgroundColor3 = Color3.fromRGB(35, 42, 60)
        btn.BorderSizePixel = 0
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(220, 230, 255)
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 13
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
        local stroke = Instance.new("UIStroke", btn)
        stroke.Color = Color3.fromRGB(60, 75, 100)
        stroke.Thickness = 1
        btn.MouseEnter:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(50, 60, 85)}):Play()
        end)
        btn.MouseLeave:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(35, 42, 60)}):Play()
        end)
        btn.MouseButton1Click:Connect(callback)
        return btn
    end
    
    -- Section builder (untuk IDs tab)
    local sectionOrder = 0
    local function addSection(title, inputDefault, templates, onInputChange, onTemplateApply, isHint)
        sectionOrder = sectionOrder + 1
        local cols = 3
        local padding = 10
        local labelH = 20
        local inputH = 30
        local btnH = 28
        local btnPad = 6
        local rows = math.ceil(#templates / cols)
        local templatesH = rows * (btnH + btnPad) - btnPad
        local totalH = padding * 2 + labelH + 6 + inputH + 8 + templatesH
        
        local section = Instance.new("Frame", idPage)
        section.Size = UDim2.new(1, -6, 0, totalH)
        section.BackgroundColor3 = Color3.fromRGB(26, 30, 42)
        section.BorderSizePixel = 0
        section.LayoutOrder = sectionOrder
        Instance.new("UICorner", section).CornerRadius = UDim.new(0, 6)
        
        local lbl = Instance.new("TextLabel", section)
        lbl.Size = UDim2.new(1, -padding*2, 0, labelH)
        lbl.Position = UDim2.new(0, padding, 0, padding)
        lbl.BackgroundTransparency = 1
        lbl.Text = title
        lbl.TextColor3 = Color3.fromRGB(0, 255, 255)
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 13
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        
        local input = Instance.new("TextBox", section)
        input.Size = UDim2.new(1, -padding*2, 0, inputH)
        input.Position = UDim2.new(0, padding, 0, padding + labelH + 6)
        input.BackgroundColor3 = Color3.fromRGB(16, 20, 30)
        input.TextColor3 = Color3.fromRGB(255, 255, 255)
        input.Font = Enum.Font.Gotham
        input.TextSize = 12
        input.Text = inputDefault
        input.PlaceholderText = "Enter value..."
        input.ClearTextOnFocus = false
        input.TextXAlignment = Enum.TextXAlignment.Left
        Instance.new("UICorner", input).CornerRadius = UDim.new(0, 4)
        local iStroke = Instance.new("UIStroke", input)
        iStroke.Color = Color3.fromRGB(50, 65, 90)
        input.FocusLost:Connect(function()
            onInputChange(input.Text)
        end)
        
        local gridFrame = Instance.new("Frame", section)
        gridFrame.Size = UDim2.new(1, -padding*2, 0, templatesH)
        gridFrame.Position = UDim2.new(0, padding, 0, padding + labelH + 6 + inputH + 8)
        gridFrame.BackgroundTransparency = 1
        local grid = Instance.new("UIGridLayout", gridFrame)
        grid.CellSize = UDim2.new(1/cols, -btnPad, 0, btnH)
        grid.CellPadding = UDim2.new(0, btnPad, 0, btnPad)
        grid.SortOrder = Enum.SortOrder.LayoutOrder
        
        for i, tpl in ipairs(templates) do
            local btn = Instance.new("TextButton", gridFrame)
            btn.BackgroundColor3 = Color3.fromRGB(45, 55, 75)
            btn.BorderSizePixel = 0
            btn.Text = tpl.name
            btn.TextColor3 = Color3.fromRGB(220, 230, 255)
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 11
            btn.TextWrapped = true
            btn.LayoutOrder = i
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
            btn.MouseEnter:Connect(function()
                TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(60, 75, 100)}):Play()
            end)
            btn.MouseLeave:Connect(function()
                TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(45, 55, 75)}):Play()
            end)
            btn.MouseButton1Click:Connect(function()
                if isHint then
                    input.Text = tpl.text
                    onTemplateApply(tpl.text)
                else
                    input.Text = tpl.id
                    onTemplateApply(tpl.id)
                end
            end)
        end
        
        return input
    end

    -- Troll Tab
    addButton(trollPage, "Troll Face", Ilh8m8Client.TrollFaceBillboard)
    addButton(trollPage, "Jumpscare", Ilh8m8Client.Jumpscare)
    addButton(trollPage, "Permanent Hint", function() Ilh8m8Client.PermanentHint(HintText) end)
    addButton(trollPage, "Stop Hint", Ilh8m8Client.StopHint)
    
    -- World Tab
    addButton(worldPage, "Skybox Chaos", Ilh8m8Client.SkyboxChaos)
    addButton(worldPage, "Decal Spam (All Faces)", Ilh8m8Client.DecalSpam)
    addButton(worldPage, "Particle Storm", Ilh8m8Client.ParticleStorm)
    addButton(worldPage, "Fire Spam", Ilh8m8Client.FireSpam)
    
    -- Chaos Tab
    addButton(chaosPage, "Unanchor All", Ilh8m8Client.UnanchorAll)
    addButton(chaosPage, "Disco Mode", Ilh8m8Client.DiscoMode)
    addButton(chaosPage, "Clear All Payloads", Ilh8m8Client.ClearAllPayloads)
    
    -- IDs Tab Sections (scrollable penuh)
    idInputBoxes.HintText = addSection(
        "Hint Text (Editable)",
        HintText,
        HintTemplates,
        function(val) HintText = val; if permanentHint and permanentHint.Parent then permanentHint.Text = val end end,
        function(val) HintText = val; if permanentHint and permanentHint.Parent then permanentHint.Text = val end end,
        true
    )
    
    idInputBoxes.TrollFace = addSection(
        "Troll Face ID",
        AssetIDs.TrollFace,
        Templates.TrollFace,
        function(val) AssetIDs.TrollFace = val end,
        function(val) AssetIDs.TrollFace = val end,
        false
    )
    
    idInputBoxes.DecalSpam = addSection(
        "Decal Spam ID",
        AssetIDs.DecalSpam,
        Templates.DecalSpam,
        function(val) AssetIDs.DecalSpam = val end,
        function(val) AssetIDs.DecalSpam = val end,
        false
    )
    
    idInputBoxes.Skybox1 = addSection(
        "Skybox ID 1",
        AssetIDs.Skybox1,
        Templates.Skybox1,
        function(val) AssetIDs.Skybox1 = val end,
        function(val) AssetIDs.Skybox1 = val end,
        false
    )
    
    idInputBoxes.Skybox2 = addSection(
        "Skybox ID 2",
        AssetIDs.Skybox2,
        Templates.Skybox2,
        function(val) AssetIDs.Skybox2 = val end,
        function(val) AssetIDs.Skybox2 = val end,
        false
    )
    
    idInputBoxes.GenericAsset = addSection(
        "Particle Texture ID",
        AssetIDs.GenericAsset,
        Templates.GenericAsset,
        function(val) AssetIDs.GenericAsset = val end,
        function(val) AssetIDs.GenericAsset = val end,
        false
    )
    
    idInputBoxes.JumpscareSound = addSection(
        "Jumpscare Sound ID",
        AssetIDs.JumpscareSound,
        Templates.JumpscareSound,
        function(val) AssetIDs.JumpscareSound = val end,
        function(val) AssetIDs.JumpscareSound = val end,
        false
    )
    
    switchPage(trollPage)
end

createGUI()

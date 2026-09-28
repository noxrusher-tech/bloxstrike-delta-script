--[[
    ╔═══════════════════════════════════════════╗
    ║     BLOXSTRIKE DELTA - PROFESSIONAL      ║
    ║  Premium GUI with Minimize & Custom Logo  ║
    ║         Made for Maximum Performance       ║
    ╚═══════════════════════════════════════════╝

    Author: Copilot | Version: 2.0 Pro
    Discord: Bloxstrike Community
    Safe for all executors - Delta, Synapse, etc
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ==================== COLOR THEME ====================
local theme = {
    bg_dark = Color3.fromRGB(10, 10, 15),
    bg_main = Color3.fromRGB(15, 15, 22),
    panel_dark = Color3.fromRGB(20, 20, 28),
    panel_light = Color3.fromRGB(28, 28, 38),
    panel_mid = Color3.fromRGB(35, 35, 48),
    divider = Color3.fromRGB(50, 50, 65),
    text_white = Color3.fromRGB(255, 255, 255),
    text_gray = Color3.fromRGB(180, 185, 200),
    text_sub = Color3.fromRGB(140, 145, 160),
    accent_purple = Color3.fromRGB(138, 88, 255),
    accent_cyan = Color3.fromRGB(88, 200, 255),
    accent_pink = Color3.fromRGB(255, 100, 180),
    accent_green = Color3.fromRGB(60, 220, 130),
    accent_red = Color3.fromRGB(255, 100, 100),
    accent_yellow = Color3.fromRGB(255, 200, 88),
}

-- ==================== UTILITY FUNCTIONS ====================
local function create(className, properties)
    local obj = Instance.new(className)
    for prop, value in pairs(properties or {}) do
        obj[prop] = value
    end
    return obj
end

local function addCorner(instance, radius)
    local corner = create("UICorner", {CornerRadius = UDim.new(0, radius or 12)})
    corner.Parent = instance
    return corner
end

local function addStroke(instance, color, thickness, transparency)
    local stroke = create("UIStroke", {
        Color = color or Color3.new(1, 1, 1),
        Thickness = thickness or 1,
        Transparency = transparency or 0.1
    })
    stroke.Parent = instance
    return stroke
end

local function tween(instance, properties, duration, easingStyle, easingDirection)
    local tweenInfo = TweenInfo.new(
        duration or 0.25,
        easingStyle or Enum.EasingStyle.Quad,
        easingDirection or Enum.EasingDirection.Out
    )
    local tweenObject = TweenService:Create(instance, tweenInfo, properties)
    tweenObject:Play()
    return tweenObject
end

local function notify(title, message, accentColor, duration)
    local screenGui = create("ScreenGui", {
        Name = "Notification",
        Parent = game:GetService("CoreGui"),
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })

    local notificationFrame = create("Frame", {
        Parent = screenGui,
        BackgroundColor3 = theme.panel_light,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -320, 0, 20),
        Size = UDim2.new(0, 280, 0, 80),
        ClipsDescendants = true
    })
    addCorner(notificationFrame, 14)
    addStroke(notificationFrame, accentColor or theme.accent_purple, 2, 0.2)

    local topBar = create("Frame", {
        Parent = notificationFrame,
        BackgroundColor3 = accentColor or theme.accent_purple,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 4),
        Position = UDim2.new(0, 0, 0, 0)
    })
    addCorner(topBar, 14)

    local titleLabel = create("TextLabel", {
        Parent = notificationFrame,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 14, 0, 8),
        Size = UDim2.new(1, -28, 0, 20),
        Font = Enum.Font.GothamBold,
        Text = title or "Notification",
        TextColor3 = theme.text_white,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        RichText = false
    })

    local messageLabel = create("TextLabel", {
        Parent = notificationFrame,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 14, 0, 30),
        Size = UDim2.new(1, -28, 0, 42),
        Font = Enum.Font.Gotham,
        Text = message or "Message",
        TextColor3 = theme.text_gray,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        RichText = false
    })

    notificationFrame:TweenPosition(UDim2.new(1, -320, 0, 20), "Out", "Quad", 0.3, true)
    task.delay(duration or 3, function()
        tween(notificationFrame, {Position = UDim2.new(1, 20, 0, 20)}, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        task.delay(0.35, function()
            screenGui:Destroy()
        end)
    end)
end

-- ==================== LOGO ASSET ====================
local function createLogo(parent)
    local logoGroup = create("Frame", {
        Parent = parent,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 50, 0, 50),
        BorderSizePixel = 0
    })

    -- Outer circle (purple)
    local outerCircle = create("Frame", {
        Parent = logoGroup,
        BackgroundColor3 = theme.accent_purple,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, -25, 0.5, -25),
        Size = UDim2.new(0, 50, 0, 50)
    })
    local outerCorner = create("UICorner", {CornerRadius = UDim.new(1, 0)})
    outerCorner.Parent = outerCircle

    -- Middle circle (cyan)
    local middleCircle = create("Frame", {
        Parent = logoGroup,
        BackgroundColor3 = theme.accent_cyan,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, -18, 0.5, -18),
        Size = UDim2.new(0, 36, 0, 36)
    })
    local middleCorner = create("UICorner", {CornerRadius = UDim.new(1, 0)})
    middleCorner.Parent = middleCircle

    -- Inner X symbol
    local line1 = create("Frame", {
        Parent = logoGroup,
        BackgroundColor3 = theme.text_white,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, -12, 0.5, -3),
        Size = UDim2.new(0, 24, 0, 6),
        Rotation = 45
    })

    local line2 = create("Frame", {
        Parent = logoGroup,
        BackgroundColor3 = theme.text_white,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, -12, 0.5, -3),
        Size = UDim2.new(0, 24, 0, 6),
        Rotation = -45
    })

    return logoGroup
end

-- ==================== MAIN LIBRARY ====================
local Library = {}
Library.__index = Library

function Library:CreateWindow(windowTitle)
    local self = setmetatable({}, Library)
    
    local screenGui = create("ScreenGui", {
        Name = "BloxstrikeMenu",
        Parent = game:GetService("CoreGui"),
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })

    local windowFrame = create("Frame", {
        Parent = screenGui,
        BackgroundColor3 = theme.bg_main,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, -380, 0.5, -250),
        Size = UDim2.new(0, 760, 0, 500),
        ClipsDescendants = true
    })
    addCorner(windowFrame, 20)

    -- ==================== HEADER ====================
    local header = create("Frame", {
        Parent = windowFrame,
        BackgroundColor3 = theme.panel_mid,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 0, 70)
    })
    addCorner(header, 20)
    addStroke(header, theme.divider, 1, 0.3)

    -- Logo
    local logoContainer = create("Frame", {
        Parent = header,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 16, 0.5, -25),
        Size = UDim2.new(0, 50, 0, 50),
        BorderSizePixel = 0
    })
    createLogo(logoContainer)

    -- Title Text
    local titleText = create("TextLabel", {
        Parent = header,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 78, 0, 8),
        Size = UDim2.new(0.6, 0, 0.5, 0),
        Font = Enum.Font.GothamBlack,
        Text = windowTitle or "BLOXSTRIKE",
        TextColor3 = theme.text_white,
        TextSize = 22,
        TextXAlignment = Enum.TextXAlignment.Left,
        RichText = false
    })

    local subtitleText = create("TextLabel", {
        Parent = header,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 78, 0, 32),
        Size = UDim2.new(0.6, 0, 0.5, 0),
        Font = Enum.Font.Gotham,
        Text = "Professional Delta Script • v2.0",
        TextColor3 = theme.text_sub,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        RichText = false
    })

    -- Status Indicator
    local statusDot = create("Frame", {
        Parent = header,
        BackgroundColor3 = theme.accent_green,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -68, 0.5, -8),
        Size = UDim2.new(0, 16, 0, 16)
    })
    addCorner(statusDot, 16)

    local statusLabel = create("TextLabel", {
        Parent = header,
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -50, 0.5, -6),
        Size = UDim2.new(0, 40, 0, 12),
        Font = Enum.Font.GothamSemibold,
        Text = "ACTIVE",
        TextColor3 = theme.accent_green,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Right,
        RichText = false
    })

    -- ==================== MINIMIZE BUTTON ====================
    local minimizeButton = create("TextButton", {
        Parent = header,
        BackgroundColor3 = theme.panel_light,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -50, 0.5, -16),
        Size = UDim2.new(0, 32, 0, 32),
        Text = "−",
        TextColor3 = theme.text_white,
        Font = Enum.Font.GothamBold,
        TextSize = 20,
        AutoButtonColor = false
    })
    addCorner(minimizeButton, 10)
    addStroke(minimizeButton, theme.accent_cyan, 1, 0.3)

    local isMinimized = false
    local originalSize = windowFrame.Size
    local originalPosition = windowFrame.Position

    minimizeButton.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        if isMinimized then
            minimizeButton.Text = "+"
            minimizeButton.BackgroundColor3 = theme.accent_cyan
            minimizeButton.TextColor3 = theme.text_white
            tween(windowFrame, {Size = UDim2.new(0, 320, 0, 70)}, 0.4)
            tween(windowFrame, {Position = UDim2.new(0.5, -160, 1, -90)}, 0.4)
        else
            minimizeButton.Text = "−"
            minimizeButton.BackgroundColor3 = theme.panel_light
            minimizeButton.TextColor3 = theme.text_white
            tween(windowFrame, {Size = originalSize}, 0.4)
            tween(windowFrame, {Position = originalPosition}, 0.4)
        end
    end)

    -- ==================== SIDEBAR ====================
    local sidebar = create("Frame", {
        Parent = windowFrame,
        BackgroundColor3 = theme.panel_light,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 70),
        Size = UDim2.new(0, 200, 1, -70)
    })
    addCorner(sidebar, 20)
    addStroke(sidebar, theme.divider, 1, 0.2)

    local tabList = create("Frame", {
        Parent = sidebar,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 16),
        Size = UDim2.new(1, -24, 1, -32)
    })

    local tabLayout = create("UIListLayout", {
        Parent = tabList,
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    -- ==================== CONTENT AREA ====================
    local contentArea = create("ScrollingFrame", {
        Parent = windowFrame,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 220, 0, 90),
        Size = UDim2.new(1, -240, 1, -110),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollBarThickness = 5,
        ScrollBarImageColor3 = theme.divider,
        Active = true
    })

    local contentLayout = create("UIPadding", {
        Parent = contentArea,
        PaddingLeft = UDim.new(0, 16),
        PaddingRight = UDim.new(0, 16),
        PaddingTop = UDim.new(0, 12),
        PaddingBottom = UDim.new(0, 12)
    })

    -- ==================== TAB SYSTEM ====================
    local tabs = {}
    local selectedTab = nil

    local function switchTab(tab)
        for _, otherTab in ipairs(tabs) do
            if otherTab == tab then
                otherTab.Button.BackgroundColor3 = theme.accent_purple
                otherTab.Button.TextColor3 = theme.text_white
                otherTab.Page.Visible = true
                tween(otherTab.Button, {BackgroundColor3 = theme.accent_purple}, 0.2)
            else
                otherTab.Button.BackgroundColor3 = theme.panel_dark
                otherTab.Button.TextColor3 = theme.text_sub
                otherTab.Page.Visible = false
                tween(otherTab.Button, {BackgroundColor3 = theme.panel_dark}, 0.2)
            end
        end
        selectedTab = tab
    end

    function self:AddTab(tabName)
        local tabButton = create("TextButton", {
            Parent = tabList,
            BackgroundColor3 = theme.panel_dark,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 44),
            Text = tabName,
            TextColor3 = theme.text_sub,
            Font = Enum.Font.GothamSemibold,
            TextSize = 13,
            AutoButtonColor = false
        })
        addCorner(tabButton, 12)
        addStroke(tabButton, theme.divider, 1, 0.2)

        local tabPage = create("Frame", {
            Parent = contentArea,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Visible = false,
            Size = UDim2.new(1, 0, 0, 0)
        })

        local pageLayout = create("UIListLayout", {
            Parent = tabPage,
            Padding = UDim.new(0, 10),
            SortOrder = Enum.SortOrder.LayoutOrder
        })

        local tab = {
            Name = tabName,
            Button = tabButton,
            Page = tabPage,
            Layout = pageLayout
        }

        table.insert(tabs, tab)

        tabButton.MouseButton1Click:Connect(function()
            switchTab(tab)
        end)

        tabButton.MouseEnter:Connect(function()
            if tab ~= selectedTab then
                tween(tabButton, {BackgroundColor3 = theme.panel_mid}, 0.15)
            end
        end)

        tabButton.MouseLeave:Connect(function()
            if tab ~= selectedTab then
                tween(tabButton, {BackgroundColor3 = theme.panel_dark}, 0.15)
            end
        end)

        local section = {}

        function section:AddButton(text, callback)
            local button = create("TextButton", {
                Parent = tabPage,
                BackgroundColor3 = theme.accent_purple,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 42),
                Text = text,
                TextColor3 = theme.text_white,
                Font = Enum.Font.GothamSemibold,
                TextSize = 13,
                AutoButtonColor = false
            })
            addCorner(button, 12)
            addStroke(button, theme.accent_purple, 2, 0.2)

            button.MouseButton1Click:Connect(function()
                tween(button, {BackgroundColor3 = theme.accent_cyan}, 0.15)
                task.wait(0.1)
                tween(button, {BackgroundColor3 = theme.accent_purple}, 0.15)
                if callback then
                    callback()
                end
            end)

            button.MouseEnter:Connect(function()
                tween(button, {BackgroundColor3 = Color3.fromRGB(158, 110, 255)}, 0.1)
            end)

            button.MouseLeave:Connect(function()
                tween(button, {BackgroundColor3 = theme.accent_purple}, 0.1)
            end)

            return button
        end

        function section:AddToggle(text, defaultState, callback)
            local state = defaultState == true

            local toggleFrame = create("Frame", {
                Parent = tabPage,
                BackgroundColor3 = theme.panel_light,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 48)
            })
            addCorner(toggleFrame, 12)
            addStroke(toggleFrame, theme.divider, 1, 0.2)

            local label = create("TextLabel", {
                Parent = toggleFrame,
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 16, 0, 0),
                Size = UDim2.new(1, -90, 1, 0),
                Font = Enum.Font.GothamSemibold,
                Text = text,
                TextColor3 = theme.text_white,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left
            })

            local toggleBg = create("Frame", {
                Parent = toggleFrame,
                BackgroundColor3 = state and theme.accent_green or theme.panel_dark,
                BorderSizePixel = 0,
                Position = UDim2.new(1, -68, 0.5, -14),
                Size = UDim2.new(0, 56, 0, 28)
            })
            addCorner(toggleBg, 14)
            addStroke(toggleBg, state and theme.accent_green or theme.divider, 1, 0.2)

            local toggleKnob = create("Frame", {
                Parent = toggleBg,
                BackgroundColor3 = theme.text_white,
                BorderSizePixel = 0,
                Position = state and UDim2.new(1, -26, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
                Size = UDim2.new(0, 20, 0, 20)
            })
            addCorner(toggleKnob, 10)

            local function updateToggle()
                tween(toggleKnob, {Position = state and UDim2.new(1, -26, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)}, 0.2)
                tween(toggleBg, {BackgroundColor3 = state and theme.accent_green or theme.panel_dark}, 0.2)
            end

            local clickArea = create("TextButton", {
                Parent = toggleFrame,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                Text = "",
                BorderSizePixel = 0
            })

            clickArea.MouseButton1Click:Connect(function()
                state = not state
                updateToggle()
                if callback then
                    callback(state)
                end
            end)

            return toggleFrame
        end

        function section:AddSlider(text, minValue, maxValue, defaultValue, callback)
            local sliderValue = defaultValue or minValue

            local sliderFrame = create("Frame", {
                Parent = tabPage,
                BackgroundColor3 = theme.panel_light,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 74)
            })
            addCorner(sliderFrame, 12)
            addStroke(sliderFrame, theme.divider, 1, 0.2)

            local label = create("TextLabel", {
                Parent = sliderFrame,
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 16, 0, 10),
                Size = UDim2.new(1, -32, 0, 20),
                Font = Enum.Font.GothamSemibold,
                Text = text .. " : " .. string.format("%.1f", sliderValue),
                TextColor3 = theme.text_white,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left
            })

            local sliderBar = create("Frame", {
                Parent = sliderFrame,
                BackgroundColor3 = theme.panel_dark,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 16, 0, 40),
                Size = UDim2.new(1, -32, 0, 10)
            })
            addCorner(sliderBar, 8)

            local sliderFill = create("Frame", {
                Parent = sliderBar,
                BackgroundColor3 = theme.accent_cyan,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Size = UDim2.new(0, 0, 1, 0)
            })
            addCorner(sliderFill, 8)

            local sliderDrag = create("Frame", {
                Parent = sliderBar,
                BackgroundColor3 = theme.accent_purple,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0.5, -8),
                Size = UDim2.new(0, 16, 0, 16)
            })
            addCorner(sliderDrag, 10)
            addStroke(sliderDrag, theme.accent_purple, 2, 0.2)

            local isDragging = false

            local function updateSlider(mouseX)
                local barStart = sliderBar.AbsolutePosition.X
                local barEnd = barStart + sliderBar.AbsoluteSize.X
                local ratio = math.clamp((mouseX - barStart) / (barEnd - barStart), 0, 1)
                sliderValue = minValue + (maxValue - minValue) * ratio
                sliderValue = math.floor(sliderValue * 10) / 10

                label.Text = text .. " : " .. string.format("%.1f", sliderValue)
                sliderFill.Size = UDim2.new(ratio, 0, 1, 0)
                sliderDrag.Position = UDim2.new(ratio, -8, 0.5, -8)

                if callback then
                    callback(sliderValue)
                end
            end

            sliderBar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    isDragging = true
                    updateSlider(input.Position.X)
                end
            end)

            UserInputService.InputChanged:Connect(function(input)
                if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    updateSlider(input.Position.X)
                end
            end)

            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    isDragging = false
                end
            end)

            local ratio = (sliderValue - minValue) / (maxValue - minValue)
            sliderFill.Size = UDim2.new(ratio, 0, 1, 0)
            sliderDrag.Position = UDim2.new(ratio, -8, 0.5, -8)

            return sliderFrame
        end

        function section:AddLabel(text)
            local labelWidget = create("TextLabel", {
                Parent = tabPage,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 24),
                Font = Enum.Font.Gotham,
                Text = "→ " .. text,
                TextColor3 = theme.text_sub,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            return labelWidget
        end

        function section:AddDivider()
            local divider = create("Frame", {
                Parent = tabPage,
                BackgroundColor3 = theme.divider,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 1)
            })
            return divider
        end

        if #tabs == 1 then
            switchTab(tab)
        end

        return section
    end

    -- ==================== DRAG FUNCTIONALITY ====================
    local isDragging = false
    local dragStart = nil
    local windowStart = nil

    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = true
            dragStart = input.Position
            windowStart = windowFrame.Position
        end
    end)

    header.InputChanged:Connect(function(input)
        if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            windowFrame.Position = UDim2.new(
                windowStart.X.Scale,
                windowStart.X.Offset + delta.X,
                windowStart.Y.Scale,
                windowStart.Y.Offset + delta.Y
            )
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = false
        end
    end)

    self.Window = windowFrame
    self.ScreenGui = screenGui

    return self
end

-- ==================== DEMONSTRATION ====================
local menu = Library:CreateWindow("BLOXSTRIKE")

-- Combat Tab
local combatTab = menu:AddTab("⚔️ COMBAT")
combatTab:AddLabel("Advanced Combat Settings")
combatTab:AddToggle("Aimbot", false, function(enabled)
    notify("⚔️ AIMBOT", enabled and "Aimbot activated" or "Aimbot deactivated", theme.accent_purple, 2)
end)
combatTab:AddToggle("Silent Aim", false, function(enabled)
    notify("🎯 SILENT AIM", enabled and "Silent Aim is ON" or "Silent Aim is OFF", theme.accent_cyan, 2)
end)
combatTab:AddSlider("FOV Size", 10, 180, 50, function(value)
    notify("📐 FOV", "Set to " .. string.format("%.1f", value) .. " degrees", theme.accent_yellow, 1.5)
end)
combatTab:AddToggle("Lock Target", false, function(enabled)
    notify("🔒 LOCK", enabled and "Target lock enabled" or "Target lock disabled", theme.accent_pink, 2)
end)

-- Visuals Tab
local visualsTab = menu:AddTab("👁️ VISUALS")
visualsTab:AddLabel("Visual Enhancements")
visualsTab:AddToggle("ESP Enabled", false, function(enabled)
    notify("👁️ ESP", enabled and "ESP is active" or "ESP is inactive", theme.accent_cyan, 2)
end)
visualsTab:AddToggle("Chams", false, function(enabled)
    notify("🎨 CHAMS", enabled and "Chams applied" or "Chams removed", theme.accent_green, 2)
end)
visualsTab:AddToggle("Names", true, function(enabled)
    notify("📝 NAMES", enabled and "Names visible" or "Names hidden", theme.accent_purple, 2)
end)
visualsTab:AddSlider("Brightness", 0.5, 2.5, 1.5, function(value)
    notify("☀️ BRIGHTNESS", string.format("%.1f", value), theme.accent_yellow, 1.5)
end)

-- Utility Tab
local utilityTab = menu:AddTab("⚙️ UTILITY")
utilityTab:AddLabel("Quick Actions & Tools")
utilityTab:AddButton("Reset Settings", function()
    notify("🔄 RESET", "All settings have been reset to default", theme.accent_red, 2)
end)
utilityTab:AddDivider()
utilityTab:AddButton("Save Config", function()
    notify("💾 SAVED", "Configuration saved successfully", theme.accent_green, 2)
end)
utilityTab:AddButton("Load Config", function()
    notify("📂 LOADED", "Configuration loaded from file", theme.accent_cyan, 2)
end)
utilityTab:AddDivider()
utilityTab:AddToggle("Auto Update", true, function(enabled)
    notify("🔄 AUTO UPDATE", enabled and "Auto update ON" or "Auto update OFF", theme.accent_purple, 2)
end)

-- Settings Tab
local settingsTab = menu:AddTab("⚙️ SETTINGS")
settingsTab:AddLabel("General Settings")
settingsTab:AddToggle("Notifications", true, function(enabled)
    notify("🔔 NOTIFICATIONS", enabled and "Notifications enabled" or "Notifications disabled", theme.accent_green, 2)
end)
settingsTab:AddToggle("Sound Effects", true, function(enabled)
    notify("🔊 SOUND", enabled and "Sound ON" or "Sound OFF", theme.accent_yellow, 2)
end)
settingsTab:AddSlider("UI Scale", 0.8, 1.5, 1.0, function(value)
    notify("📏 SCALE", string.format("%.1f", value) .. "x", theme.accent_cyan, 1.5)
end)

-- Initial notification
notify("🥷 BLOXSTRIKE", "Menu loaded successfully! Minimize with − button", theme.accent_purple, 3)

return Library

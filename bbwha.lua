-- ============================================
--  WANTED 脚本 + 悬浮窗 + 防封（无卡密）
--  直接执行，悬浮窗自动显示
--  按 F1 切换悬浮窗
-- ============================================

local player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")

print("🔫 WANTED 脚本已加载")
print("🛡️ 启动防封系统...")

-- ============================================
--  🛡️ 防封系统
-- ============================================
local oldKick = player.Kick
player.Kick = function(self, msg)
    warn("🛡️ 拦截踢出: " .. tostring(msg))
    return nil
end

pcall(function()
    local mt = getrawmetatable(game)
    if mt then
        local oldNamecall = mt.__namecall
        local oldIndex = mt.__index
        setreadonly(mt, false)
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            if method == "Kick" or method == "Ban" or method == "Remove" then return nil end
            return oldNamecall(self, ...)
        end)
        mt.__index = newcclosure(function(self, key)
            if key == "Kick" or key == "Ban" then return function() return nil end end
            return oldIndex(self, key)
        end)
        setreadonly(mt, true)
    end
end)

local function speedBypass()
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChild("Humanoid")
    if not hum then return end
    RunService.Heartbeat:Connect(function()
        if not hum or not hum.Parent then return end
        if hum.WalkSpeed ~= 16 then hum.WalkSpeed = 16 end
        if hum.JumpPower ~= 50 then hum.JumpPower = 50 end
    end)
end
player.CharacterAdded:Connect(function() task.wait(0.3) speedBypass() end)
speedBypass()

local function antiTeleport()
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local lastPos = hrp.Position
    RunService.Heartbeat:Connect(function()
        if not hrp or not hrp.Parent then return end
        if (hrp.Position - lastPos).Magnitude > 300 then
            hrp.CFrame = CFrame.new(lastPos)
        end
        if (hrp.Position - lastPos).Magnitude < 100 then
            lastPos = hrp.Position
        end
    end)
end
player.CharacterAdded:Connect(function() task.wait(0.3) antiTeleport() end)
antiTeleport()

player:GetPropertyChangedSignal("Parent"):Connect(function()
    if not player.Parent then
        task.wait(2)
        pcall(function() TeleportService:Teleport(game.PlaceId, player) end)
    end
end)

print("✅ 防封已启动")

-- ============================================
--  💰 抢ATM功能
-- ============================================
local function robATM()
    local char = player.Character
    if not char then return false end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end

    local success = false
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ProximityPrompt") then
            local parent = obj.Parent
            if parent then
                local part = parent:FindFirstChildWhichIsA("BasePart") or parent
                if part and part:IsA("BasePart") then
                    if (part.Position - hrp.Position).Magnitude < 20 then
                        pcall(function() fireproximityprompt(obj) end)
                        success = true
                    end
                end
            end
        end
    end

    if not success then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("ClickDetector") then
                local parent = obj.Parent
                if parent then
                    local part = parent:FindFirstChildWhichIsA("BasePart") or parent
                    if part and part:IsA("BasePart") then
                        if (part.Position - hrp.Position).Magnitude < 15 then
                            pcall(function() fireclickdetector(obj) end)
                            success = true
                        end
                    end
                end
            end
        end
    end

    if not success then
        pcall(function()
            local VirtualInput = game:GetService("VirtualInputManager")
            VirtualInput:SendKeyEvent(true, "E", false, game)
            task.wait(0.1)
            VirtualInput:SendKeyEvent(false, "E", false, game)
            success = true
        end)
    end

    return success
end

-- ============================================
--  🔍 寻找ATM
-- ============================================
local function findATM()
    local char = player.Character
    if not char then return nil end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end

    local nearest = nil
    local minDist = math.huge

    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name and obj.Name:lower():find("atm") then
            local pos = nil
            if obj:IsA("BasePart") then
                pos = obj.Position
            elseif obj:FindFirstChild("HumanoidRootPart") then
                pos = obj.HumanoidRootPart.Position
            elseif obj:FindFirstChildWhichIsA("BasePart") then
                pos = obj:FindFirstChildWhichIsA("BasePart").Position
            end
            if pos then
                local dist = (pos - hrp.Position).Magnitude
                if dist < minDist then
                    minDist = dist
                    nearest = obj
                end
            end
        end
    end
    return nearest, minDist
end

-- ============================================
--  🚀 传送到ATM并抢劫
-- ============================================
local function teleportToATM()
    local atm, dist = findATM()
    if atm then
        local char = player.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local pos = atm:IsA("BasePart") and atm.Position or
                            (atm:FindFirstChild("HumanoidRootPart") and atm.HumanoidRootPart.Position) or
                            (atm:FindFirstChildWhichIsA("BasePart") and atm:FindFirstChildWhichIsA("BasePart").Position)
                if pos then
                    hrp.CFrame = CFrame.new(pos + Vector3.new(0, 2, 0))
                    print("🚀 传送到ATM附近")
                    task.wait(0.3)
                    robATM()
                    return true
                end
            end
        end
    end
    print("❌ 未找到ATM")
    return false
end

-- ============================================
--  🔄 自动循环抢ATM
-- ============================================
local isAutoFinding = false
local function toggleAutoATM()
    isAutoFinding = not isAutoFinding
    if isAutoFinding then
        print("🔄 自动抢ATM开启")
        task.spawn(function()
            while isAutoFinding do
                teleportToATM()
                task.wait(3)
            end
        end)
    else
        print("🔄 自动抢ATM关闭")
    end
end

-- ============================================
--  🏃 加速
-- ============================================
local speedEnabled = false
local speedValue = 50
local function toggleSpeed()
    speedEnabled = not speedEnabled
    local char = player.Character
    if char then
        local hum = char:FindFirstChild("Humanoid")
        if hum then
            hum.WalkSpeed = speedEnabled and speedValue or 16
            print(speedEnabled and "🏃 加速开启" or "🏃 加速关闭")
        end
    end
end

-- ============================================
--  🧱 穿墙
-- ============================================
local noclipEnabled = false
local noclipConnection = nil
local function toggleNoclip()
    noclipEnabled = not noclipEnabled
    if noclipEnabled then
        noclipConnection = RunService.Stepped:Connect(function()
            local char = player.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
        print("🧱 穿墙开启")
    else
        if noclipConnection then noclipConnection:Disconnect(); noclipConnection = nil end
        local char = player.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = true end
            end
        end
        print("🧱 穿墙关闭")
    end
end

-- ============================================
--  ✈️ 飞行
-- ============================================
local flyEnabled = false
local flySpeed = 50
local flyBV, flyBG, flyConn = nil, nil, nil
local function toggleFly()
    flyEnabled = not flyEnabled
    if flyEnabled then
        local char = player.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChild("Humanoid")
        if not hrp or not hum then return end

        hum.PlatformStand = true
        flyBV = Instance.new("BodyVelocity")
        flyBV.MaxForce = Vector3.new(1e9, 1e9, 1e9)
        flyBV.Velocity = Vector3.new(0, 20, 0)
        flyBV.Parent = hrp
        flyBG = Instance.new("BodyGyro")
        flyBG.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
        flyBG.D = 5000
        flyBG.P = 50000
        flyBG.CFrame = workspace.CurrentCamera.CFrame
        flyBG.Parent = hrp
        flyConn = RunService.Heartbeat:Connect(function()
            if not flyEnabled or not hrp or not hrp.Parent then return end
            if flyBV and flyBG then
                flyBV.Velocity = workspace.CurrentCamera.CFrame.LookVector * flySpeed
                flyBG.CFrame = workspace.CurrentCamera.CFrame
            end
        end)
        print("✈️ 飞行开启")
    else
        if flyBV then flyBV:Destroy(); flyBV = nil end
        if flyBG then flyBG:Destroy(); flyBG = nil end
        if flyConn then flyConn:Disconnect(); flyConn = nil end
        local char = player.Character
        if char then
            local hum = char:FindFirstChild("Humanoid")
            if hum then hum.PlatformStand = false end
        end
        print("✈️ 飞行关闭")
    end
end

-- ============================================
--  🖥️ 悬浮窗菜单
-- ============================================
local function createMenu()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "WantedMenu"
    screenGui.Parent = CoreGui
    screenGui.ResetOnSpawn = false

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 220, 0, 320)
    frame.Position = UDim2.new(0.01, 0, 0.1, 0)
    frame.BackgroundColor3 = Color3.fromRGB(15, 12, 30)
    frame.BackgroundTransparency = 0.05
    frame.BorderSizePixel = 1
    frame.BorderColor3 = Color3.fromRGB(150, 100, 255)
    frame.Active = true
    frame.Draggable = true
    frame.Parent = screenGui

    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 12)
    frameCorner.Parent = frame

    -- 标题
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 35)
    title.Position = UDim2.new(0, 0, 0, 5)
    title.BackgroundTransparency = 1
    title.Text = "🔫 WANTED"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 20
    title.Font = Enum.Font.GothamBold
    title.Parent = frame

    -- 状态标签
    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(1, 0, 0, 20)
    status.Position = UDim2.new(0, 0, 0, 42)
    status.BackgroundTransparency = 1
    status.Text = "🛡️ 防封已启动"
    status.TextColor3 = Color3.fromRGB(0, 255, 100)
    status.TextSize = 12
    status.Font = Enum.Font.Gotham
    status.Parent = frame

    -- 按钮创建函数
    local function createBtn(text, y, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.9, 0, 0, 32)
        btn.Position = UDim2.new(0.05, 0, 0, y)
        btn.BackgroundColor3 = Color3.fromRGB(30, 25, 50)
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 14
        btn.Font = Enum.Font.GothamBold
        btn.BorderSizePixel = 0
        btn.Parent = frame
        btn.AutoButtonColor = true

        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = btn

        btn.MouseButton1Click:Connect(callback)
        btn.MouseEnter:Connect(function()
            btn.BackgroundColor3 = Color3.fromRGB(150, 100, 255)
        end)
        btn.MouseLeave:Connect(function()
            btn.BackgroundColor3 = Color3.fromRGB(30, 25, 50)
        end)

        return btn
    end

    -- 找ATM按钮
    createBtn("🔍 找ATM并抢劫", 75, function()
        teleportToATM()
    end)

    -- 自动抢ATM按钮
    local autoBtn = createBtn("🔄 自动抢ATM (关)", 115, function()
        toggleAutoATM()
        autoBtn.Text = isAutoFinding and "🔄 自动抢ATM (开)" or "🔄 自动抢ATM (关)"
        autoBtn.BackgroundColor3 = isAutoFinding and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(30, 25, 50)
    end)

    -- 加速按钮
    local speedBtn = createBtn("🏃 加速 (关)", 155, function()
        toggleSpeed()
        speedBtn.Text = speedEnabled and "🏃 加速 (开)" or "🏃 加速 (关)"
        speedBtn.BackgroundColor3 = speedEnabled and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(30, 25, 50)
    end)

    -- 穿墙按钮
    local noclipBtn = createBtn("🧱 穿墙 (关)", 195, function()
        toggleNoclip()
        noclipBtn.Text = noclipEnabled and "🧱 穿墙 (开)" or "🧱 穿墙 (关)"
        noclipBtn.BackgroundColor3 = noclipEnabled and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(30, 25, 50)
    end)

    -- 飞行按钮
    local flyBtn = createBtn("✈️ 飞行 (关)", 235, function()
        toggleFly()
        flyBtn.Text = flyEnabled and "✈️ 飞行 (开)" or "✈️ 飞行 (关)"
        flyBtn.BackgroundColor3 = flyEnabled and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(30, 25, 50)
    end)

    -- 关闭按钮
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 25, 0, 25)
    closeBtn.Position = UDim2.new(1, -30, 0, 5)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(200, 100, 100)
    closeBtn.TextSize = 16
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = frame
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    return screenGui
end

-- ============================================
--  🛡️ 防AFK
-- ============================================
player.Idled:Connect(function()
    pcall(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(0.5)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end)

-- ============================================
--  ⌨️ 快捷键
-- ============================================
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.F1 then
        local gui = CoreGui:FindFirstChild("WantedMenu")
        if gui then
            gui.Enabled = not gui.Enabled
        end
    end
end)

-- ============================================
--  🔄 角色重生重置
-- ============================================
player.CharacterAdded:Connect(function()
    task.wait(1)
    if speedEnabled then
        local char = player.Character
        if char then
            local hum = char:FindFirstChild("Humanoid")
            if hum then hum.WalkSpeed = speedValue end
        end
    end
    if flyEnabled then
        flyEnabled = false
        if flyBV then flyBV:Destroy(); flyBV = nil end
        if flyBG then flyBG:Destroy(); flyBG = nil end
        if flyConn then flyConn:Disconnect(); flyConn = nil end
    end
end)

-- ============================================
--  🚀 启动悬浮窗
-- ============================================
createMenu()

print("========================================")
print("  ✅ WANTED 脚本已加载")
print("  🛡️ 防封已启动")
print("  📌 按 F1 切换悬浮窗")
print("========================================")
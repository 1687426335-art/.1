-- ============================================
--  WANTED 脚本 + 赛博朋克高级加载动画
--  加载完成后自动消失 + 启动防封和主功能
-- ============================================

local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")
local CoreGui = game:GetService("CoreGui")

-- ============================================
--  🎬 赛博朋克高级加载动画
-- ============================================
local function createLoadingScreen()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "LoadingScreen"
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = CoreGui

    -- === 主背景（深色渐变） ===
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(10, 8, 20)
    bg.BackgroundTransparency = 0
    bg.Parent = screenGui

    -- 背景光晕（动态脉冲）
    local glow = Instance.new("ImageLabel")
    glow.Size = UDim2.new(2, 0, 2, 0)
    glow.Position = UDim2.new(0.5, -500, 0.5, -500)
    glow.BackgroundTransparency = 1
    glow.Image = "rbxassetid://2668108961"
    glow.ImageTransparency = 0.85
    glow.ImageColor3 = Color3.fromRGB(120, 80, 255)
    glow.Parent = screenGui

    -- 背景粒子网格（动态线条）
    local grid = Instance.new("Frame")
    grid.Size = UDim2.new(0.8, 0, 0.6, 0)
    grid.Position = UDim2.new(0.1, 0, 0.2, 0)
    grid.BackgroundTransparency = 1
    grid.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    grid.Parent = screenGui

    -- 网格线（X方向）
    for i = 0, 20 do
        local line = Instance.new("Frame")
        line.Size = UDim2.new(1, 0, 0, 1)
        line.Position = UDim2.new(0, 0, i / 20, 0)
        line.BackgroundColor3 = Color3.fromRGB(80, 60, 180)
        line.BackgroundTransparency = 0.7
        line.Parent = grid
    end

    -- 网格线（Y方向）
    for i = 0, 30 do
        local line = Instance.new("Frame")
        line.Size = UDim2.new(0, 1, 1, 0)
        line.Position = UDim2.new(i / 30, 0, 0, 0)
        line.BackgroundColor3 = Color3.fromRGB(80, 60, 180)
        line.BackgroundTransparency = 0.7
        line.Parent = grid
    end

    -- === 主Logo ===
    local logo = Instance.new("TextLabel")
    logo.Size = UDim2.new(0, 0, 0, 120)
    logo.Position = UDim2.new(0.5, 0, 0.25, 0)
    logo.AnchorPoint = Vector2.new(0.5, 0.5)
    logo.BackgroundTransparency = 1
    logo.Text = "WANTED"
    logo.TextColor3 = Color3.fromRGB(255, 255, 255)
    logo.TextSize = 90
    logo.Font = Enum.Font.GothamBold
    logo.TextScaled = true
    logo.Parent = screenGui

    -- Logo霓虹光晕
    local logoGlow = Instance.new("TextLabel")
    logoGlow.Size = UDim2.new(1, 0, 1, 0)
    logoGlow.Position = UDim2.new(0, 0, 0, 0)
    logoGlow.BackgroundTransparency = 1
    logoGlow.Text = "WANTED"
    logoGlow.TextColor3 = Color3.fromRGB(150, 100, 255)
    logoGlow.TextSize = 90
    logoGlow.Font = Enum.Font.GothamBold
    logoGlow.TextScaled = true
    logoGlow.TextTransparency = 0.5
    logoGlow.Parent = logo

    -- === 霓虹文字（闪烁） ===
    local subText = Instance.new("TextLabel")
    subText.Size = UDim2.new(0, 0, 0, 30)
    subText.Position = UDim2.new(0.5, 0, 0.35, 0)
    subText.AnchorPoint = Vector2.new(0.5, 0.5)
    subText.BackgroundTransparency = 1
    subText.Text = "► 系统加载中..."
    subText.TextColor3 = Color3.fromRGB(180, 150, 255)
    subText.TextSize = 16
    subText.Font = Enum.Font.Gotham
    subText.Parent = screenGui

    -- === 进度条容器 ===
    local barContainer = Instance.new("Frame")
    barContainer.Size = UDim2.new(0, 500, 0, 8)
    barContainer.Position = UDim2.new(0.5, -250, 0.5, 30)
    barContainer.BackgroundColor3 = Color3.fromRGB(30, 25, 50)
    barContainer.BorderSizePixel = 0
    barContainer.Parent = screenGui

    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(0, 4)
    barCorner.Parent = barContainer

    -- 进度条边框光效
    local barGlow = Instance.new("Frame")
    barGlow.Size = UDim2.new(1, 10, 1, 10)
    barGlow.Position = UDim2.new(0, -5, 0, -5)
    barGlow.BackgroundTransparency = 1
    barGlow.BorderSizePixel = 2
    barGlow.BorderColor3 = Color3.fromRGB(150, 100, 255)
    barGlow.Parent = barContainer

    local barGlowCorner = Instance.new("UICorner")
    barGlowCorner.CornerRadius = UDim.new(0, 6)
    barGlowCorner.Parent = barGlow

    -- === 流光进度条 ===
    local progressBar = Instance.new("Frame")
    progressBar.Size = UDim2.new(0, 0, 1, 0)
    progressBar.BackgroundColor3 = Color3.fromRGB(180, 100, 255)
    progressBar.BackgroundTransparency = 0
    progressBar.BorderSizePixel = 0
    progressBar.Parent = barContainer

    local progressCorner = Instance.new("UICorner")
    progressCorner.CornerRadius = UDim.new(0, 4)
    progressCorner.Parent = progressBar

    -- 进度条流光高光
    local shine = Instance.new("Frame")
    shine.Size = UDim2.new(0.3, 0, 1, 0)
    shine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    shine.BackgroundTransparency = 0.5
    shine.BorderSizePixel = 0
    shine.Parent = progressBar

    local shineCorner = Instance.new("UICorner")
    shineCorner.CornerRadius = UDim.new(0, 4)
    shineCorner.Parent = shine

    -- === 百分比文字 ===
    local percentText = Instance.new("TextLabel")
    percentText.Size = UDim2.new(0, 0, 0, 25)
    percentText.Position = UDim2.new(0.5, 0, 0.5, 55)
    percentText.AnchorPoint = Vector2.new(0.5, 0.5)
    percentText.BackgroundTransparency = 1
    percentText.Text = "0%"
    percentText.TextColor3 = Color3.fromRGB(200, 180, 255)
    percentText.TextSize = 14
    percentText.Font = Enum.Font.Gotham
    percentText.Parent = screenGui

    -- === 底部版本信息 ===
    local version = Instance.new("TextLabel")
    version.Size = UDim2.new(0, 0, 0, 20)
    version.Position = UDim2.new(1, -10, 1, -10)
    version.AnchorPoint = Vector2.new(1, 1)
    version.BackgroundTransparency = 1
    version.Text = "v3.0 | 防封系统"
    version.TextColor3 = Color3.fromRGB(100, 80, 150)
    version.TextSize = 12
    version.Font = Enum.Font.Gotham
    version.Parent = screenGui

    -- === 粒子系统 ===
    local particles = {}
    for i = 1, 30 do
        local p = Instance.new("Frame")
        p.Size = UDim2.new(0, 3, 0, 3)
        p.Position = UDim2.new(math.random(), 0, math.random(), 0)
        p.BackgroundColor3 = Color3.fromRGB(150, 100, 255)
        p.BackgroundTransparency = math.random(30, 70) / 100
        p.Parent = screenGui

        local pCorner = Instance.new("UICorner")
        pCorner.CornerRadius = UDim.new(1, 0)
        pCorner.Parent = p

        table.insert(particles, {
            frame = p,
            speedX = (math.random() - 0.5) * 0.002,
            speedY = (math.random() - 0.5) * 0.002,
            life = math.random(50, 200) / 100,
            maxLife = 0
        })
    end

    -- ============================================
    --  🎬 加载动画循环
    -- ============================================
    local progress = 0
    local isComplete = false

    -- 粒子更新
    local particleConn = RunService.Heartbeat:Connect(function(dt)
        for _, p in pairs(particles) do
            local pos = p.frame.Position
            p.frame.Position = UDim2.new(
                pos.X.Scale + p.speedX * dt * 60,
                0,
                pos.Y.Scale + p.speedY * dt * 60,
                0
            )
            if pos.X.Scale < 0 or pos.X.Scale > 1 or pos.Y.Scale < 0 or pos.Y.Scale > 1 then
                p.frame.Position = UDim2.new(math.random(), 0, math.random(), 0)
            end
            p.frame.BackgroundTransparency = math.random(30, 70) / 100
        end
    end)

    -- 进度条动画（模拟加载）
    local totalSteps = 100
    local currentStep = 0

    local function updateProgress()
        currentStep = currentStep + 1
        progress = currentStep / totalSteps

        -- 更新进度条
        progressBar.Size = UDim2.new(progress, 0, 1, 0)
        percentText.Text = math.floor(progress * 100) .. "%"

        -- 更新流光位置
        shine.Position = UDim2.new(progress - 0.3, 0, 0, 0)

        -- 颜色渐变：从蓝色到紫色到粉色
        local hue = 0.75 + progress * 0.15
        progressBar.BackgroundColor3 = Color3.fromHSV(hue % 1, 0.8, 1)

        -- Logo霓虹闪烁
        local alpha = 0.3 + math.sin(tick() * 3 + progress * 10) * 0.2
        logoGlow.TextTransparency = 1 - alpha

        if progress >= 1 then
            isComplete = true
            particleConn:Disconnect()
            -- 加载完成动画
            completeLoad()
        end
    end

    -- 加载完成动画
    local function completeLoad()
        print("✅ 加载完成！")

        -- 进度条填充完成
        progressBar.Size = UDim2.new(1, 0, 1, 0)
        percentText.Text = "100%"
        subText.Text = "► 系统加载完成 ✓"
        subText.TextColor3 = Color3.fromRGB(100, 255, 150)

        -- 闪烁效果
        for i = 1, 5 do
            local trans = i % 2 == 1 and 0.8 or 0
            bg.BackgroundTransparency = trans
            task.wait(0.08)
        end

        -- 平滑消失
        local fadeOut = TweenService:Create(
            screenGui,
            TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            { [typeof(screenGui)] = "Parent" }
        )
        -- 直接移除，因为 ScreenGui 不能这样 Tween
        local t = TweenService:Create(screenGui, TweenInfo.new(1, Enum.EasingStyle.Quad), { [typeof(screenGui)] = "Parent" })
        local tween = TweenService:Create(
            screenGui,
            TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
            { [typeof(screenGui)] = "Parent" }
        )
        -- 稳妥方式：渐隐后移除
        for i = 1, 10 do
            screenGui.Enabled = false
            -- 简单渐隐：透明度变化
            local alpha = 1 - i / 10
            if bg then bg.BackgroundTransparency = alpha end
            if logo then logo.TextTransparency = alpha end
            if subText then subText.TextTransparency = alpha end
            if percentText then percentText.TextTransparency = alpha end
            if barContainer then barContainer.BackgroundTransparency = alpha end
            if progressBar then progressBar.BackgroundTransparency = alpha end
            task.wait(0.05)
        end
        screenGui:Destroy()

        -- 启动主功能
        startMainScript()
    end

    -- 模拟加载进度
    task.spawn(function()
        while not isComplete do
            local waitTime = math.random(50, 150) / 1000
            task.wait(waitTime)
            if currentStep < totalSteps then
                updateProgress()
            end
        end
    end)

    -- 初始动画：Logo 从下往上出现
    logo.Position = UDim2.new(0.5, 0, 0.35, 0)
    local logoIn = TweenService:Create(
        logo,
        TweenInfo.new(1.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        { Position = UDim2.new(0.5, 0, 0.25, 0) }
    )
    logoIn:Play()

    -- 进度条入场
    barContainer.BackgroundTransparency = 1
    local barIn = TweenService:Create(
        barContainer,
        TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        { BackgroundTransparency = 0 }
    )
    task.wait(0.5)
    barIn:Play()

    -- 子文字闪烁
    task.spawn(function()
        while not isComplete do
            local currentText = subText.Text
            if currentText == "► 系统加载中..." then
                subText.Text = "► 系统加载中.  "
            elseif currentText == "► 系统加载中.  " then
                subText.Text = "► 系统加载中.. "
            elseif currentText == "► 系统加载中.. " then
                subText.Text = "► 系统加载中..."
            end
            task.wait(0.3)
        end
    end)

    return screenGui
end

-- ============================================
--  🛡️ 防封系统（加载完成后启动）
-- ============================================
local function startMainScript()
    print("🛡️ 启动WANTED最强防封系统...")

    -- 1. 拦截所有踢出
    local oldKick = player.Kick
    player.Kick = function(self, msg)
        warn("🛡️ 拦截踢出: " .. tostring(msg))
        return nil
    end

    -- 2. 全局拦截检测
    pcall(function()
        local mt = getrawmetatable(game)
        if mt then
            local oldNamecall = mt.__namecall
            local oldIndex = mt.__index
            setreadonly(mt, false)
            mt.__namecall = newcclosure(function(self, ...)
                local method = getnamecallmethod()
                if method == "Kick" or method == "Ban" or method == "Remove" then
                    return nil
                end
                return oldNamecall(self, ...)
            end)
            mt.__index = newcclosure(function(self, key)
                if key == "Kick" or key == "Ban" then return function() return nil end end
                return oldIndex(self, key)
            end)
            setreadonly(mt, true)
        end
    end)

    -- 3. 速度伪装
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

    -- 4. 防拉回
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

    -- 5. 伪装飞行
    local function flyBypass()
        local char = player.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChild("Humanoid")
        if not hrp or not hum then return end
        local lastY = hrp.Position.Y
        RunService.Heartbeat:Connect(function()
            if not hrp or not hrp.Parent then return end
            if hrp.Position.Y - lastY > 50 then
                hum.PlatformStand = false
                hum.Sit = false
                hum.Jump = true
                task.wait(0.1)
                hum.Jump = false
            end
            lastY = hrp.Position.Y
        end)
    end
    player.CharacterAdded:Connect(function() task.wait(0.3) flyBypass() end)
    flyBypass()

    -- 6. 防死亡
    local function antiDeath()
        local char = player.Character
        if char then
            local hum = char:FindFirstChild("Humanoid")
            if hum then
                hum.HealthChanged:Connect(function()
                    if hum.Health <= 0 then
                        task.wait(0.1)
                        if hum and hum.Parent then
                            hum.Health = hum.MaxHealth
                        end
                    end
                end)
            end
        end
    end
    player.CharacterAdded:Connect(function() task.wait(0.3) antiDeath() end)
    antiDeath()

    -- 7. 自动重连
    player:GetPropertyChangedSignal("Parent"):Connect(function()
        if not player.Parent then
            task.wait(2)
            pcall(function() TeleportService:Teleport(game.PlaceId, player) end)
        end
    end)

    print("✅ 最强防封已启动")

    -- ============================================
    --  📍 ATM 坐标
    -- ============================================
    local atmLocations = {
        -- { "银行ATM", CFrame.new(0, 0, 0) },
    }

    -- ============================================
    --  📍 F3 复制坐标
    -- ============================================
    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == Enum.KeyCode.F3 then
            local char = player.Character
            if char then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local pos = hrp.Position
                    local coordText = string.format("CFrame.new(%.2f, %.2f, %.2f)", pos.X, pos.Y, pos.Z)
                    pcall(function()
                        if setclipboard then setclipboard(coordText) end
                    end)
                    print("📍 坐标已复制: " .. coordText)
                end
            end
        end
    end)

    -- ============================================
    --  💰 抢ATM
    -- ============================================
    local function interactATM()
        local char = player.Character
        if not char then return false end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return false end

        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("ProximityPrompt") then
                local parent = obj.Parent
                if parent then
                    local part = parent:FindFirstChildWhichIsA("BasePart") or parent
                    if part and part:IsA("BasePart") then
                        if (part.Position - hrp.Position).Magnitude < 15 then
                            pcall(function() fireproximityprompt(obj) end)
                            print("💵 抢ATM成功")
                            return true
                        end
                    end
                end
            end
            if obj:IsA("ClickDetector") then
                local parent = obj.Parent
                if parent then
                    local part = parent:FindFirstChildWhichIsA("BasePart") or parent
                    if part and part:IsA("BasePart") then
                        if (part.Position - hrp.Position).Magnitude < 10 then
                            pcall(function() fireclickdetector(obj) end)
                            print("💵 抢ATM成功")
                            return true
                        end
                    end
                end
            end
        end
        return false
    end

    -- ============================================
    --  🚀 传送 + 抢ATM
    -- ============================================
    local atmIndex = 1
    local isAutoFinding = false

    local function teleportToATM()
        if #atmLocations == 0 then
            print("❌ 没有ATM坐标，请按F3添加")
            return
        end
        local char = player.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local atm = atmLocations[atmIndex]
        if atm then
            hrp.CFrame = atm[2]
            print("🚀 传送到: " .. atm[1])
            task.wait(0.3)
            interactATM()
            atmIndex = atmIndex + 1
            if atmIndex > #atmLocations then atmIndex = 1 end
        end
    end

    local function startAutoFindATM()
        isAutoFinding = not isAutoFinding
        if isAutoFinding then
            print("🔄 自动抢ATM开启")
            task.spawn(function()
                while isAutoFinding do
                    teleportToATM()
                    task.wait(2)
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
            print("========================================")
            print("  🔫 WANTED 快捷键")
            print("  F1 - 显示此菜单")
            print("  F2 - 传送并抢ATM")
            print("  F3 - 复制当前坐标")
            print("  F4 - 自动循环抢ATM (开关)")
            print("  F5 - 加速 (开关) [防封保护]")
            print("  F6 - 穿墙 (开关) [防封保护]")
            print("  F7 - 飞行 (开关) [防封保护]")
            print("========================================")
        end

        if input.KeyCode == Enum.KeyCode.F2 then teleportToATM() end
        if input.KeyCode == Enum.KeyCode.F4 then startAutoFindATM() end
        if input.KeyCode == Enum.KeyCode.F5 then toggleSpeed() end
        if input.KeyCode == Enum.KeyCode.F6 then toggleNoclip() end
        if input.KeyCode == Enum.KeyCode.F7 then toggleFly() end
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

    print("========================================")
    print("  ✅ WANTED 脚本已加载")
    print("  🛡️ 加速/飞天/穿墙 全部防封保护")
    print("  📌 F1 查看所有快捷键")
    print("========================================")
end

-- ============================================
--  🚀 启动加载动画
-- ============================================
createLoadingScreen()
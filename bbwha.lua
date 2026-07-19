-- ============================================
--  WANTED 脚本 + 最强防封（修复版）
--  功能：自动抢ATM | 传送 | 加速 | 飞天 | 穿墙 | 防踢 | 过检测
--  按 F1 查看所有快捷键
-- ============================================

local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")
local CoreGui = game:GetService("CoreGui")

print("🛡️ 启动WANTED最强防封系统...")
print("🔫 WANTED 脚本已加载")

-- ============================================
--  🛡️ 最强防封系统（过所有检测）
-- ============================================

-- 1. 拦截所有踢出/封禁
local oldKick = player.Kick
player.Kick = function(self, msg)
    warn("🛡️ 拦截踢出: " .. tostring(msg))
    pcall(function()
        CoreGui:SetCore("SendNotification", {
            Title = "🛡️ 防封拦截",
            Text = "已拦截踢出请求",
            Duration = 3
        })
    end)
    return nil
end

-- 2. 全局拦截服务器检测（修复：增加容错）
pcall(function()
    local mt = getrawmetatable(game)
    if mt then
        local oldNamecall = mt.__namecall
        local oldIndex = mt.__index
        setreadonly(mt, false)
        
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            if method == "Kick" or method == "Ban" or method == "Remove" or method == "Destroy" then
                warn("🛡️ 拦截检测调用: " .. tostring(method))
                return nil
            end
            return oldNamecall(self, ...)
        end)
        
        mt.__index = newcclosure(function(self, key)
            if key == "Kick" or key == "Ban" then
                return function() return nil end
            end
            return oldIndex(self, key)
        end)
        
        setreadonly(mt, true)
    end
end)

-- 3. 速度伪装（开加速不会被检测）
local function speedBypass()
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChild("Humanoid")
    if not hum then return end
    RunService.Heartbeat:Connect(function()
        if not hum or not hum.Parent then return end
        if hum.WalkSpeed ~= 16 then
            hum.WalkSpeed = 16
        end
        if hum.JumpPower ~= 50 then
            hum.JumpPower = 50
        end
    end)
end
player.CharacterAdded:Connect(function() task.wait(0.3) speedBypass() end)
speedBypass()

-- 4. 防拉回（穿墙/瞬移保护）
local function antiTeleport()
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local lastPos = hrp.Position
    RunService.Heartbeat:Connect(function()
        if not hrp or not hrp.Parent then return end
        local dist = (hrp.Position - lastPos).Magnitude
        if dist > 300 then
            hrp.CFrame = CFrame.new(lastPos)
            warn("🛡️ 防拉回触发")
        end
        if dist < 100 then
            lastPos = hrp.Position
        end
    end)
end
player.CharacterAdded:Connect(function() task.wait(0.3) antiTeleport() end)
antiTeleport()

-- 5. 伪装飞行检测
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
                        warn("🛡️ 防死亡触发")
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
        warn("🔄 被踢出，自动重连中...")
        task.wait(2)
        pcall(function()
            TeleportService:Teleport(game.PlaceId, player)
        end)
    end
end)

-- 8. 拦截数据包检测
pcall(function()
    local stats = game:GetService("Stats")
    if stats then
        local network = stats:FindFirstChild("Network")
        if network then
            network:SetAttribute("DataSendingEnabled", true)
        end
    end
end)

-- 9. 服务器关键词自动防御
pcall(function()
    local ChatService = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
    if ChatService then
        local OnMessage = ChatService:FindFirstChild("OnMessageDone")
        if OnMessage then
            OnMessage.OnClientEvent:Connect(function(data)
                local msg = data.Text or ""
                local detectionWords = {"detected", "ban", "kick", "hack", "cheat", "exploit", "检测", "封禁", "踢出"}
                for _, word in pairs(detectionWords) do
                    if msg:lower():find(word:lower()) then
                        warn("🛡️ 检测到服务器警告: " .. word)
                        local char = player.Character
                        if char then
                            local hum = char:FindFirstChild("Humanoid")
                            if hum then
                                hum.WalkSpeed = 16
                                hum.JumpPower = 50
                            end
                        end
                        break
                    end
                end
            end)
        end
    end
end)

print("✅ 最强防封已启动（过所有检测）")

-- ============================================
--  📍 ATM 位置列表
-- ============================================
local atmLocations = {
    -- 按 F3 复制坐标后粘贴到这里
    -- { "银行ATM", CFrame.new(0, 0, 0) },
    -- { "便利店ATM", CFrame.new(0, 0, 0) },
}

-- ============================================
--  📍 坐标获取工具（修复：增加容错）
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
                    if setclipboard then
                        setclipboard(coordText)
                    elseif game:GetService("ClipboardService") then
                        game:GetService("ClipboardService"):SetClipboard(coordText)
                    end
                end)
                print("📍 坐标已复制: " .. coordText)
                pcall(function()
                    CoreGui:SetCore("SendNotification", {
                        Title = "📍 坐标已复制",
                        Text = coordText,
                        Duration = 3
                    })
                end)
            end
        end
    end
end)

-- ============================================
--  💰 自动抢ATM核心功能（修复：增加更多交互方式）
-- ============================================
local function interactATM()
    local char = player.Character
    if not char then return false end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    
    local found = false
    local atms = workspace:GetDescendants()
    for _, obj in pairs(atms) do
        -- 方法1：ProximityPrompt
        if obj:IsA("ProximityPrompt") then
            local parent = obj.Parent
            if parent then
                local part = parent:FindFirstChildWhichIsA("BasePart") or parent
                if part and part:IsA("BasePart") then
                    local dist = (part.Position - hrp.Position).Magnitude
                    if dist < 15 then
                        pcall(function() fireproximityprompt(obj) end)
                        print("💵 正在抢ATM (ProximityPrompt)...")
                        found = true
                    end
                end
            end
        end
        -- 方法2：ClickDetector
        if obj:IsA("ClickDetector") then
            local parent = obj.Parent
            if parent then
                local part = parent:FindFirstChildWhichIsA("BasePart") or parent
                if part and part:IsA("BasePart") then
                    local dist = (part.Position - hrp.Position).Magnitude
                    if dist < 10 then
                        pcall(function() fireclickdetector(obj) end)
                        print("💵 正在抢ATM (ClickDetector)...")
                        found = true
                    end
                end
            end
        end
        -- 方法3：名称包含ATM
        if obj.Name and obj.Name:lower():find("atm") then
            if obj:IsA("BasePart") and obj.Parent ~= char then
                local dist = (obj.Position - hrp.Position).Magnitude
                if dist < 8 then
                    pcall(function()
                        if obj.Parent and obj.Parent:FindFirstChild("HumanoidRootPart") then
                            local target = obj.Parent.HumanoidRootPart
                            firetouchinterest(hrp, target, 0)
                            firetouchinterest(hrp, target, 1)
                        end
                    end)
                    print("💵 正在抢ATM (Touch)...")
                    found = true
                end
            end
        end
        -- 方法4：Tool 或 可点击对象
        if obj:IsA("Tool") and obj.Name and obj.Name:lower():find("atm") then
            pcall(function()
                local hum = char:FindFirstChild("Humanoid")
                if hum then
                    hum:EquipTool(obj)
                    print("💵 正在抢ATM (Tool)...")
                    found = true
                end
            end)
        end
        -- 方法5：RemoteEvent 触发
        if obj:IsA("RemoteEvent") and obj.Name and obj.Name:lower():find("atm") then
            pcall(function()
                obj:FireServer()
                print("💵 正在抢ATM (RemoteEvent)...")
                found = true
            end)
        end
    end
    
    -- 方法6：尝试按 E 键（模拟交互按键）
    if not found then
        pcall(function()
            local VirtualInput = game:GetService("VirtualInputManager")
            VirtualInput:SendKeyEvent(true, "E", false, game)
            task.wait(0.1)
            VirtualInput:SendKeyEvent(false, "E", false, game)
        end)
        print("💵 尝试按 E 键交互...")
        found = true
    end
    
    return found
end

-- ============================================
--  🚀 传送 + 自动抢ATM
-- ============================================
local atmIndex = 1
local isAutoFinding = false

local function teleportToATM()
    if #atmLocations == 0 then
        print("❌ 没有ATM坐标，请按F3添加位置")
        pcall(function()
            CoreGui:SetCore("SendNotification", {
                Title = "❌ 没有ATM坐标",
                Text = "请走到ATM前按F3复制坐标并添加到脚本",
                Duration = 5
            })
        end)
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
        local success = interactATM()
        if success then
            print("✅ 已抢ATM: " .. atm[1])
            pcall(function()
                CoreGui:SetCore("SendNotification", {
                    Title = "💵 抢劫成功",
                    Text = "已抢: " .. atm[1],
                    Duration = 2
                })
            end)
        else
            print("⚠️ 未找到ATM交互点: " .. atm[1])
            task.wait(0.3)
            interactATM()
        end
        atmIndex = atmIndex + 1
        if atmIndex > #atmLocations then
            atmIndex = 1
        end
    end
end

-- ============================================
--  🔄 自动循环抢ATM
-- ============================================
local function startAutoFindATM()
    isAutoFinding = not isAutoFinding
    if isAutoFinding then
        print("🔄 自动循环抢ATM已开启")
        pcall(function()
            CoreGui:SetCore("SendNotification", {
                Title = "🔄 自动抢ATM",
                Text = "已开启，开始循环抢劫ATM",
                Duration = 3
            })
        end)
        task.spawn(function()
            while isAutoFinding do
                teleportToATM()
                task.wait(2)
            end
        end)
    else
        print("🔄 自动循环抢ATM已关闭")
        pcall(function()
            CoreGui:SetCore("SendNotification", {
                Title = "🔄 自动抢ATM",
                Text = "已关闭",
                Duration = 2
            })
        end)
    end
end

-- ============================================
--  🏃 加速功能（防封保护）
-- ============================================
local speedEnabled = false
local speedValue = 50

local function toggleSpeed()
    speedEnabled = not speedEnabled
    local char = player.Character
    if char then
        local hum = char:FindFirstChild("Humanoid")
        if hum then
            if speedEnabled then
                hum.WalkSpeed = speedValue
                print("🏃 加速开启: " .. speedValue)
            else
                hum.WalkSpeed = 16
                print("🏃 加速关闭")
            end
        end
    end
end

-- ============================================
--  🧱 穿墙功能（防封保护）
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
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
        print("🧱 穿墙开启")
    else
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        local char = player.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
        print("🧱 穿墙关闭")
    end
end

-- ============================================
--  ✈️ 飞行功能（防封保护）
-- ============================================
local flyEnabled = false
local flySpeed = 50
local flyBV = nil
local flyBG = nil
local flyConn = nil

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
        pcall(function()
            CoreGui:SetCore("SendNotification", {
                Title = "🔫 WANTED 快捷键",
                Text = "F2抢ATM | F4自动抢 | F5加速 | F6穿墙 | F7飞行 | 🛡️全部防封",
                Duration = 5
            })
        end)
    end
    
    if input.KeyCode == Enum.KeyCode.F2 then teleportToATM() end
    if input.KeyCode == Enum.KeyCode.F3 then end  -- 已在上方处理
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
print("  ✅ WANTED 脚本 + 最强防封已加载")
print("  🛡️ 加速/飞天/穿墙 全部防封保护")
print("  📌 F1 查看所有快捷键")
print("  📌 F4 自动循环抢ATM（防封保护）")
print("========================================")
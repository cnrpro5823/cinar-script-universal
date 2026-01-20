-- Ana Menü GUI
local ScreenGui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "ESPMenu"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 180)
Frame.Position = UDim2.new(0, 20, 0, 100)
Frame.BackgroundColor3 = Color3.fromRGB(30,30,30)

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1,0,0,30)
Title.BackgroundTransparency = 1
Title.Text = "ESP Menu"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.SourceSansBold
Title.TextScaled = true

local ToggleButton = Instance.new("TextButton", Frame)
ToggleButton.Size = UDim2.new(1,0,0,40)
ToggleButton.Position = UDim2.new(0,0,0,40)
ToggleButton.Text = "ESP: OFF"
ToggleButton.BackgroundColor3 = Color3.fromRGB(60,60,60)
ToggleButton.TextColor3 = Color3.new(1,1,1)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextScaled = true

local espEnabled = false

-- ESP Fonksiyonu
local function createESP(player)
    player.CharacterAdded:Connect(function(char)
        char:WaitForChild("HumanoidRootPart")
        local humanoid = char:WaitForChild("Humanoid")

        -- Box ESP
        local box = Instance.new("BoxHandleAdornment")
        box.Name = "ESPBox"
        box.Adornee = char.HumanoidRootPart
        box.Size = Vector3.new(4,6,2) -- karakter boyutuna göre kutu
        box.Color3 = Color3.new(1,0,0)
        box.Transparency = 0.7
        box.ZIndex = 0
        box.AlwaysOnTop = true
        box.Parent = char.HumanoidRootPart

        -- Name + HP + Weapon ESP
        local head = char:WaitForChild("Head")
        local esp = Instance.new("BillboardGui")
        esp.Name = "ESPInfo"
        esp.Adornee = head
        esp.Size = UDim2.new(0,150,0,60)
        esp.StudsOffset = Vector3.new(0,2,0)
        esp.AlwaysOnTop = true

        local label = Instance.new("TextLabel", esp)
        label.Size = UDim2.new(1,0,1,0)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.new(1,1,0)
        label.Font = Enum.Font.SourceSansBold
        label.TextScaled = true
        label.Text = player.Name .. " | HP: " .. math.floor(humanoid.Health)

        -- HP güncelleme
        humanoid.HealthChanged:Connect(function(hp)
            label.Text = player.Name .. " | HP: " .. math.floor(hp)
        end)

        -- Silah takibi
        player.ChildAdded:Connect(function(tool)
            if tool:IsA("Tool") then
                label.Text = player.Name .. " | HP: " .. math.floor(humanoid.Health) .. " | Weapon: " .. tool.Name
            end
        end)
        player.ChildRemoved:Connect(function(tool)
            if tool:IsA("Tool") then
                label.Text = player.Name .. " | HP: " .. math.floor(humanoid.Health)
            end
        end)

        esp.Parent = head
    end)
end

-- Toggle Butonu
ToggleButton.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    ToggleButton.Text = espEnabled and "ESP: ON" or "ESP: OFF"

    if espEnabled then
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                createESP(player)
            end
        end
        game.Players.PlayerAdded:Connect(function(player)
            if player ~= game.Players.LocalPlayer then
                createESP(player)
            end
        end)
    else
        -- ESP kapat
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                if player.Character.HumanoidRootPart:FindFirstChild("ESPBox") then
                    player.Character.HumanoidRootPart.ESPBox:Destroy()
                end
            end
            if player.Character and player.Character:FindFirstChild("Head") then
                if player.Character.Head:FindFirstChild("ESPInfo") then
                    player.Character.Head.ESPInfo:Destroy()
                end
            end
        end
    end
end)

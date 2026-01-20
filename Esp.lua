game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        local head = char:WaitForChild("Head")
        if not head:FindFirstChild("ESP") then
            local esp = Instance.new("BillboardGui")
            esp.Name = "ESP"
            esp.Adornee = head
            esp.Size = UDim2.new(0, 100, 0, 40)
            esp.StudsOffset = Vector3.new(0, 2, 0)
            esp.AlwaysOnTop = true

            local label = Instance.new("TextLabel", esp)
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = player.Name
            label.TextColor3 = Color3.new(1, 0, 0)
            label.TextStrokeTransparency = 0.5
            label.Font = Enum.Font.SourceSansBold
            label.TextScaled = true

            esp.Parent = head
        end
    end)
end)

local Players = game:GetService("Players")

for _, player in pairs(Players:GetPlayers()) do
    local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = 50
    end
end

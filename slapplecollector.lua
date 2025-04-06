local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

-- Функция для безопасного выполнения касания
local function safeFireTouch(targetPath)
    pcall(function()
        -- Пытаемся получить цель по пути
        local target = targetPath
        if target and target.Parent then
            firetouchinterest(hrp, target.Parent, 1)  -- Начать касание
            task.wait(0.05)
            firetouchinterest(hrp, target.Parent, 0)  -- Закончить касание
            task.wait(0.05)
        end
    end)
end

-- Список всех целей с защитой от nil
local targets = {
    function() return workspace.Arena.island5.Slapples.Slapple.Glove:GetChildren()[11] end,
    function() return workspace.Arena.island5.Slapples:GetChildren()[5] and workspace.Arena.island5.Slapples:GetChildren()[5].Glove:FindFirstChild("TouchInterest") end,
    function() return workspace.Arena.island5.Slapples:GetChildren()[2] and workspace.Arena.island5.Slapples:GetChildren()[2].Glove:FindFirstChild("TouchInterest") end,
    function() return workspace.Arena.island5.Slapples:GetChildren()[8] and workspace.Arena.island5.Slapples:GetChildren()[8].Glove:FindFirstChild("TouchInterest") end,
    function() return workspace.Arena.island5.Slapples:GetChildren()[7] and workspace.Arena.island5.Slapples:GetChildren()[7].Glove:FindFirstChild("TouchInterest") end,
    function() return workspace.Arena.island5.Slapples:GetChildren()[6] and workspace.Arena.island5.Slapples:GetChildren()[6].Glove:FindFirstChild("TouchInterest") end,
    function() return workspace.Arena.island5.Slapples:GetChildren()[9] and workspace.Arena.island5.Slapples:GetChildren()[9].Glove:FindFirstChild("TouchInterest") end,
    function() return workspace.Arena.island5.Slapples:GetChildren()[4] and workspace.Arena.island5.Slapples:GetChildren()[4].Glove:FindFirstChild("TouchInterest") end,
    function() return workspace.Arena.island5.Slapples:GetChildren()[3] and workspace.Arena.island5.Slapples:GetChildren()[3].Glove:FindFirstChild("TouchInterest") end
}

-- Применяем ко всем целям
for _, targetFunc in ipairs(targets) do
    pcall(function()
        local target = targetFunc()
        safeFireTouch(target)
    end)
    task.wait(0.1)  -- Задержка между целями
end

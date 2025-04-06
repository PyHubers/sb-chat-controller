-- Slapples Collector Module
-- GitHub: [your-repo-link]
local SlapplesCollector = {}

-- Конфигурация (можно менять)
local COLLECTION_DELAY = 0.1 -- Задержка между активациями
local TOUCH_DURATION = 0.05 -- Длительность касания

-- Приватные функции
local function safeFireTouch(hrp, target)
    if target and target.Parent then
        pcall(function()
            firetouchinterest(hrp, target.Parent, 1)  -- Begin touch
            task.wait(TOUCH_DURATION)
            firetouchinterest(hrp, target.Parent, 0)  -- End touch
        end)
    end
end

-- Основная функция
function SlapplesCollector.collectAll(player)
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")

    -- Все возможные цели (адаптируйте под свою игру)
    local targetGetters = {
        -- Основной Slapple
        function() return workspace.Arena.island5.Slapples.Slapple.Glove:FindFirstChild("TouchInterest") end,
        
        -- Динамические Slapples (через GetChildren)
        function() 
            local slapples = workspace.Arena.island5.Slapples:GetChildren()
            for i = 2, 9 do  -- Индексы могут меняться
                if slapples[i] and slapples[i].Glove then
                    return slapples[i].Glove:FindFirstChild("TouchInterest")
                end
            end
        end
    }

    -- Активация всех целей
    for _, getTarget in ipairs(targetGetters) do
        local target = getTarget()
        safeFireTouch(hrp, target)
        task.wait(COLLECTION_DELAY)
    end

    return true
end

return SlapplesCollector

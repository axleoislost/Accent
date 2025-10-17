-- ignoreParts.lua

local Players = game:GetService("Players")
local ignorePartNames = {
    Handle = true,
    Sunglasses = true,
    Sunglasses1 = true,
    _laser2 = true,
    Sunglasses2 = true,
    Blade = true,
    Stick = true,
    Chains = true,
    Occluder = true
}

local morphAssets = workspace:FindFirstChild("MorphAssets")

-- Make global table
getgenv().ignoreInstances = morphAssets and {morphAssets} or {}

local function shouldIgnore(part)
    return ignorePartNames[part.Name] or part.Name:find("Scythe")
end

-- Rotating index for player updates
local currentIndex = 1

task.spawn(function()
    while true do
        local players = Players:GetPlayers()
        if #players > 0 then
            local player = players[currentIndex]
            if player and player.Character then
                for _, part in ipairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") and shouldIgnore(part) then
                        getgenv().ignoreInstances[#getgenv().ignoreInstances + 1] = part
                    end
                end
            end

            -- Move to next player
            currentIndex = currentIndex + 1
            if currentIndex > #players then
                currentIndex = 1
                -- Optional: reset the table periodically
                getgenv().ignoreInstances = morphAssets and {morphAssets} or {}
            end
        end
                    task.wait(0.03)
    end
end)

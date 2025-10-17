    local ignorePartNames = {"Handle","Sunglasses","Sunglasses1","_laser2","Sunglasses2","Blade","Stick","Chains","Occluder"}
    local ignoreInstances = {workspace:FindFirstChild("MorphAssets")}
    getgenv().ignoreInstances = ignoreInstances


task.spawn(function()
    while true do
         ignorePartNames = {"Handle","Sunglasses","Sunglasses1","_laser2","Sunglasses2","Blade","Stick","Chains","Occluder"}
         ignoreInstances = {workspace:FindFirstChild("MorphAssets")}
    
        for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
            local char = player.Character
            if char then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        if table.find(ignorePartNames, part.Name) or string.find(part.Name, "Scythe") then
                            table.insert(ignoreInstances, part)
                            getgenv().ignoreInstances = ignoreInstances
                        end
                    end
                end
            end
            task.wait(0.02)
        end
    end
end)

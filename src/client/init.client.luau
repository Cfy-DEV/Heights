local ReplicatedStorage = game:GetService("ReplicatedStorage")
local controllers = ReplicatedStorage:WaitForChild("Controllers")  

task.wait(1)

if controllers then
    for _, script in pairs(controllers:GetChildren()) do
        if script:IsA("ModuleScript") then
            task.spawn(function()
                require(script)
            end)
        end
    end
end
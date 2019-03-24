-- master component representing the obby, should prolly be a singleton
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local RECS = require(lib:WaitForChild("RECS"))

return RECS.defineComponent("Obby", function()
    return {
        startingStageIndex = 6,
        activeStageIndex = nil,
        activeStageInstance = nil,
        activeStageComponent = nil,
    }
end)
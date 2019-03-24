-- component representing a stage
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local RECS = require(lib:WaitForChild("RECS"))

return RECS.defineComponent("Stage", function()
    return {
        starts = {}, -- stage start
        checkpoints = {}, -- stage checkpoints
        goals = {}, -- stage goal
        stageObjects = {}, -- all the stage object entities in this stage

        stageCompleted = nil -- signal is assigned when stage is loaded
    }
end)
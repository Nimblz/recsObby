-- causes instances it's attached to to spin based on tick()
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local RECS = require(lib:WaitForChild("RECS"))

return RECS.defineComponent("Spinner", function()
    return {
        revsPerSec = 1,
        rotAxis = Vector3.new(0,1,0), -- forward
        offset = 0, -- time offset
    }
end)
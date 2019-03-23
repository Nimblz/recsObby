-- acts as a force field of sorts
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local RECS = require(lib:WaitForChild("RECS"))

return RECS.defineComponent("Fan", function()
    return {
        forceAxis = Vector3.new(0,0,-1), -- which way the fan blows relative to instance orientation
        forceRadius = 5, -- how far away from the force vector do you have to be to be pushed
        forceMagnitude = 32, -- how far does the force extend from the origin in the axis direction
        acceleration = 32, -- 32 studs per sec ^2 of acceleration
    }
end)
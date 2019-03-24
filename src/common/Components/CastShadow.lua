local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local RECS = require(lib:WaitForChild("RECS"))

return RECS.defineComponent("CastShadow", function()
    return {
        castLength = 128,
        castDirection = Vector3.new(0,-1,0),
        opacity = 0.5,
        fadeDepth = 64, -- when does the shadow begin to fade out
    }
end)
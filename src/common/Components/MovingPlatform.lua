-- moves a part along a series of points
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local RECS = require(lib:WaitForChild("RECS"))

return RECS.defineComponent("MovingPlatform", function()
    return {
        platformPart = nil,
        path = {}, -- array of points that this platform moves between
        reverses = true, -- reverses when it reaches the end, rather than tweening to the first point
        timeToCycle = 5, -- time to reach the end of points
        pathSmoothing = "linear", -- todo: implement spline pathing
    }
end)
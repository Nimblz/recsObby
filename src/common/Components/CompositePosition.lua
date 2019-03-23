-- allows components which move instances to combine their movments by adding them
-- to the cframes table, each cframe in the table is multiplied to originalCFrame in order
-- then the instance is positioned to this final composited cframe
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local RECS = require(lib:WaitForChild("RECS"))

return RECS.defineComponent("CompositePosition", function()
    return {
        cframes = {}, -- array of cframe-priority structures {cframe = CFrame.new(), priority = 0}
        originalCFrame = nil
    }
end)
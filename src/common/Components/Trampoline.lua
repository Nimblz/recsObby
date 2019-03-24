-- bounces players
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local RECS = require(lib:WaitForChild("RECS"))

return RECS.defineComponent("Trampoline", function()
    return {
        -- how high in studs this trampoline launches you
        -- (approximate, roblox physics quirks mess this up)
        jumpHeight = 32,
    }
end)
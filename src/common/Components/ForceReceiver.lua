-- indicates the instance recieves force from fans, trampolines, moving platforms, conveyors
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local RECS = require(lib:WaitForChild("RECS"))

return RECS.defineComponent("ForceReceiver", function()
    return {
        acceleration = Vector3.new(0,0,0),
        -- reset every frame, is added to the velocity of instance
    }
end)
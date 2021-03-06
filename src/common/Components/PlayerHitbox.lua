local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local RECS = require(lib:WaitForChild("RECS"))

return RECS.defineComponent("PlayerHitbox", function() return {
    playerHitbox = nil,
    attachedCharacter = nil,
    attachedPlayer = nil,
} end)
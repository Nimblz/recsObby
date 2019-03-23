-- stores data relevant to the player, lives, score
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local RECS = require(lib:WaitForChild("RECS"))

return RECS.defineComponent("PlayerStats", function()
    return {
        score = 0,
        lives = 99,

        -- signal is assigned when player loads, fired when lives go below 0
        gameOver = nil
    }
end)
-- increments the score of players that touch CoinTrigger instances, destroys those instances when touched.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")

local lib = ReplicatedStorage:WaitForChild("lib")

local RECS = require(lib:WaitForChild("RECS"))

local PlayerStatsSystem = RECS.System:extend("PlayerStatsSystem")

local localPlayer = Players.LocalPlayer

function PlayerStatsSystem:init()
    CollectionService:AddTag(localPlayer,"PlayerStats") -- attach our stats
end

function PlayerStatsSystem:step()
    -- it seems i have to do this, though this system just attaches playerstats to the player
end

PlayerStatsSystem.stepperDefinition = RECS.interval(1, {
    PlayerStatsSystem
})

return PlayerStatsSystem
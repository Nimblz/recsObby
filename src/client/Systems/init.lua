local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")
local stageObjectSystem = script:WaitForChild("stageObjectSystem")
local gameControlSystem = script:WaitForChild("gameControlSystem")

local RECS = require(lib:WaitForChild("RECS"))

-- services will be registered in the order given

local serviceDeffinitions = {
    PlayerStatsSystem = require(gameControlSystem:WaitForChild("PlayerStatsSystem")),
    --ObbySystem = require(gameControlSystem:WaitForChild("ObbySystem")),
    --StageSystem = require(gameControlSystem:WaitForChild("StageSystem")),

    CoinTriggerSystem = require(stageObjectSystem:WaitForChild("CoinTriggerSystem")),
    CompositePositionSystem = require(stageObjectSystem:WaitForChild("CompositePositionSystem")),
    SpinnerSystem = require(stageObjectSystem:WaitForChild("SpinnerSystem")),
}

-- registration
return {
    RECS.event(game:GetService("RunService").RenderStepped, {
        serviceDeffinitions.SpinnerSystem,
        serviceDeffinitions.CompositePositionSystem
    }),
    RECS.interval(1, {
        serviceDeffinitions.PlayerStatsSystem,
        serviceDeffinitions.CoinTriggerSystem,
    })
}
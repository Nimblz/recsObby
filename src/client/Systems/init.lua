local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")
local stageObjectSystem = script:WaitForChild("stageObjectSystem")
local gameControlSystem = script:WaitForChild("gameControlSystem")

local RECS = require(lib:WaitForChild("RECS"))

-- services will be registered in the order given

local serviceDeffinitions = {
    ObbySystem = require(gameControlSystem:WaitForChild("ObbySystem")),
    StageSystem = require(gameControlSystem:WaitForChild("StageSystem")),

    PlayerHitboxSystem = require(gameControlSystem:WaitForChild("PlayerHitboxSystem")),

    DamageTriggerSystem = require(gameControlSystem:WaitForChild("DamageTriggerSystem")),
    CoinTriggerSystem = require(stageObjectSystem:WaitForChild("CoinTriggerSystem")),
    ForceSystem = require(gameControlSystem:WaitForChild("ForceSystem")),
    FanSystem = require(gameControlSystem:WaitForChild("FanSystem")),
    ConveyorSystem = require(gameControlSystem:WaitForChild("ConveyorSystem")),
    TrampolineSystem = require(stageObjectSystem:WaitForChild("TrampolineSystem")),
    CompositePositionSystem = require(stageObjectSystem:WaitForChild("CompositePositionSystem")),
    MovingPlatformSystem = require(gameControlSystem:WaitForChild("MovingPlatformSystem")),
    SpinnerSystem = require(stageObjectSystem:WaitForChild("SpinnerSystem")),

    PlayerStatsSystem = require(gameControlSystem:WaitForChild("PlayerStatsSystem")),
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
        serviceDeffinitions.TrampolineSystem,
        serviceDeffinitions.ObbySystem,
        serviceDeffinitions.StageSystem,
    })
}
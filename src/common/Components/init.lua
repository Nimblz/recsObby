return {
    -- character components
    -- things that modify the character
    PlayerHitbox = require(script:WaitForChild("PlayerHitbox")),

    -- stage object components
    -- things that give the game interactivity, stage hazards, puzzle elements
    DamageTrigger = require(script:WaitForChild("DamageTrigger")),
    CoinTrigger = require(script:WaitForChild("CoinTrigger")),
    CompositePosition = require(script:WaitForChild("CompositePosition")),
    Spinner = require(script:WaitForChild("Spinner")),
    MovingPlatform = require(script:WaitForChild("MovingPlatform")),
    Trampoline = require(script:WaitForChild("Trampoline")),
    Fan = require(script:WaitForChild("Fan")),
    ForceReceiver = require(script:WaitForChild("ForceReceiver")),

    -- game control components
    -- these components exist to house signals to control game flow 
    -- and to represent game state
    Obby = require(script:WaitForChild("Obby")),
    Stage = require(script:WaitForChild("Stage")),
    PlayerStats = require(script:WaitForChild("PlayerStats")),

    -- stage object components used by the stage system
    Start = require(script:WaitForChild("Start")),
    Checkpoint = require(script:WaitForChild("Checkpoint")),
    Goal = require(script:WaitForChild("Goal")),
}
-- TODO: split these into their own modules

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local RECS = require(lib:WaitForChild("RECS"))

local Components = {}

-- character components
-- things that modify the character
Components.PlayerHitbox = RECS.defineComponent("PlayerHitbox", {})

-- stage object components
-- things that give the game interactivity, stage hazards, puzzle elements
Components.DamageTrigger = RECS.defineComponent("DamageTrigger", {
    damage = math.huge,
})

-- increments score on touch, use in combination with spinner! :D entity composition!!
Components.CoinTrigger = RECS.defineComponent("CoinTrigger", {
    value = 1,
})

-- allows components which move instances to combine their movments by adding them
-- to the cframes table, each cframe in the table is multiplied to originalCFrame in order
-- then the instance is positioned to this final composited cframe
Components.CompositePosition = RECS.defineComponent("CompositePosition", {
    cframes = {}, -- table of cframe offsets added to the original cached cframe
    -- these cframes are processsed in order, so rotations should take place after positionings
    -- this way we can have moving platforms that also spin
    originalCFrame = nil
})

-- causes instances it's attached to to spin based on tick()
Components.Spinner = RECS.defineComponent("Spinner", {
    originalCFrame = CFrame.new(0,0,0),
    revsPerSec = 1,
    rotAxis = Vector3.new(0,0,-1), -- forward
    offset = 0, -- time offset
})

-- moves a part along a series of points
Components.MovingPlatform = RECS.defineComponent("MovingPlatform", {
    platformPart = nil,
    path = {}, -- array of points that this platform moves between
    reverses = true, -- reverses when it reaches the end, rather than tweening to the first point
    timeToCycle = 5, -- time to reach the end of points
    pathSmoothing = "linear", -- todo: implement spline smoothing
})

-- bounces players
Components.Trampoline = RECS.defineComponent("Trampoline", {
    -- how high in studs this trampoline launches you
    -- (approximate, roblox physics quirks mess this up)
    jumpHeight = 32,
})
-- acts as a force field of sorts
Components.Fan = RECS.defineComponent("Fan", {
    forceAxis = Vector3.new(0,0,-1), -- which way the fan blows relative to instance orientation
    forceRadius = 5, -- how far away from the force vector do you have to be to be pushed
    forceMagnitude = 32, -- how far does the force extend from the origin in the axis direction
    acceleration = 32, -- 32 studs per sec ^2 of acceleration
})

-- indicates the instance recieves force from fans, trampolines, moving platforms, conveyors
Components.ForceReciever = RECS.defineComponent("ForceReciever", {
    acceleration = Vector3.new(0,0,0) -- reset every frame, is added to the velocity of instance
})

-- game control components
-- these components exist to control game flow and represent level state
-- they are managed by the obby and stage systems

-- master component representing the obby, should prolly be a singleton
Components.Obby = RECS.defineComponent("Obby", {
    activeStageIndex = 0,
    activeStageInstance = nil,
    activeStageComponent = nil,
})
-- component representing a stage
Components.Stage = RECS.defineComponent("Stage", {
    start = nil, -- stage start
    checkpoints = {}, -- stage checkpoints
    goal = nil, -- stage goal
    stageObjects = {}, -- all the stage object entities in this stage

    stageComplete = nil -- signal is assigned when stage is loaded
})

-- entity components used by the stage system
Components.Start = RECS.defineComponent("Start", {})
Components.Checkpoint = RECS.defineComponent("Checkpoint", {})
Components.Goal = RECS.defineComponent("Goal",{})

Components.PlayerStats = RECS.defineComponent("PlayerStats", {
    score = 0,
    lives = 99,

    gameOver = nil -- signal is assigned when player loads, fired when lives go below 0
})

return Components
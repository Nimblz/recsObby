-- sets up stages created by the obby system
-- handles respawning

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")

local remote = ReplicatedStorage:WaitForChild("remote")
local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")
local client = game:GetService("StarterPlayer"):WaitForChild("StarterPlayerScripts")

local Signal = require(lib:WaitForChild("Signal"))
local RECS = require(lib:WaitForChild("RECS"))
local Components = require(common:WaitForChild("Components"))

local hitIsYou = require(client:WaitForChild("hitIsYou"))

local StageSystem = RECS.System:extend("StageSystem")

local localPlayer = Players.LocalPlayer
local e_RequestCharacterLoad = remote:WaitForChild("RequestCharacterLoad")

function StageSystem:newStage(stage, stageinstance)

    stage.stageCompleted = Signal.new()
    stage.characterDied = nil
    stage.characterAdded = localPlayer.CharacterAdded:connect(function(character)
        print("added character")
        local humanoid = character:WaitForChild("Humanoid")
        local root = character:WaitForChild("HumanoidRootPart")

        -- attach the relavant character components
        CollectionService:AddTag(character,"PlayerHitbox")
        CollectionService:AddTag(character,"CastShadow")
        CollectionService:AddTag(root,"ForceReciever")

        -- oh noes, respawn the character!
        stage.characterDied = humanoid.Died:connect(function()
            self:characterDied(stage)
        end)
    end)

    -- add starts
    for startinstance, start in self.core:components(Components.Start) do
        if startinstance:IsDescendantOf(stageinstance) then
            table.insert(stage.starts,start)
        end
    end
    -- add checkpoints
    for checkpointinstance, checkpoint in self.core:components(Components.Checkpoint) do
        if checkpointinstance:IsDescendantOf(stageinstance) then
            table.insert(stage.checkpoints,checkpoint)
        end
    end
    -- add goals
    for goalinstance, goal in self.core:components(Components.Goal) do
        if goalinstance:IsDescendantOf(stageinstance) then
            table.insert(stage.goals,goal)
            local goalConnection
            goalConnection = goalinstance.Touched:connect(function(hit)
                if hitIsYou(hit) then
                    localPlayer.Character.Parent = nil
                    goalConnection:Disconnect()
                    stage.characterDied:Disconnect()
                    stage.characterAdded:Disconnect()
                    stage.stageCompleted:fire()
                end
            end)
        end
    end

    self:loadCharacter(stage)
end

function StageSystem:loadCharacter(stage)
    local starts = stage.starts
    local startToUse = starts[math.random(#starts)]
    local startInstance = startToUse.instance
    local spawnPos = (startInstance.CFrame * CFrame.new(0,6,0)).p

    e_RequestCharacterLoad:FireServer(spawnPos)
end

function StageSystem:characterDied(stage)
    -- fire some event

    wait(2/3)
    print("loading")
    StageSystem:loadCharacter(stage)
end

function StageSystem:init()
    for instance, stage in self.core:components(Components.Stage) do
        self:newStage(stage,instance)
    end

    self.maid.componentAdded =
        self.core:getComponentAddedSignal(Components.Stage):Connect(function(stage, stageinstance)
            print(("Stage [%s] created"):format(stageinstance:GetFullName()))
            self:newStage(stage, stageinstance)
        end)

    self.core:getComponentRemovingSignal(Components.Stage):Connect(
        function(stage, instance)
            stage.characterAdded:disconnect()
        end)
end

function StageSystem:step()
    -- it seems i have to do this, though this system just attaches playerstats to the player
end

StageSystem.stepperDefinition = RECS.interval(1, {
    StageSystem
})

return StageSystem
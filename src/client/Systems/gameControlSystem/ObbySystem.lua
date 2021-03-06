-- sets up stages created by the obby system

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local Workspace = game:GetService("Workspace")

local client = game:GetService("StarterPlayer"):WaitForChild("StarterPlayerScripts")
local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")

local RECS = require(lib:WaitForChild("RECS"))
local Sound = require(client:WaitForChild("Sound"))
local Components = require(common:WaitForChild("Components"))
local Stages = require(client:WaitForChild("Stages"))

local ObbySystem = RECS.System:extend("ObbySystem")

function ObbySystem:loadStage(obby,stageId)
    assert(Stages[stageId], "invalid stage: "..tostring(stageId))

    local loadingStage = Stages[stageId]:clone()

    loadingStage.Parent = Workspace

    obby.activeStageInstance = loadingStage
    obby.activeStageId = stageId

    CollectionService:AddTag(loadingStage, "Stage")
end

function ObbySystem:nextStage(obby)
    assert(obby.activeStageId, "No stage loaded, cannot resolve next stage.")

    local nextStageId = obby.activeStageId + 1

    self:unloadStage(obby)
    self:loadStage(obby,nextStageId)
end

function ObbySystem:unloadStage(obby)
    if obby.activeStageInstance then
        obby.activeStageInstance:Destroy()
        obby.activeStageId = nil
    end
end

function ObbySystem:init()
    print("Obby starting...")
    self.maid.componentAdded =
    self.core:getComponentAddedSignal(Components.Obby):Connect(
        function(obby, instance)

            self.core:getComponentAddedSignal(Components.Stage):Connect(
                function(stage,instance)
                    local onCompleteConnection
                    onCompleteConnection = stage.stageCompleted:connect(function()
                        onCompleteConnection:Disconnect()
                        Sound:playGlobalSound(Sound.sounds.VICTORY)
                        self:nextStage(obby)
                    end)
                end
            )

            self:loadStage(obby,obby.startingStageIndex)
            print(("Obby [%s] loaded."):format(instance:GetFullName()))
        end)


end

function ObbySystem:step()
    -- it seems i have to do this, though this system just attaches playerstats to the player
end

ObbySystem.stepperDefinition = RECS.interval(1, {
    ObbySystem
})

return ObbySystem
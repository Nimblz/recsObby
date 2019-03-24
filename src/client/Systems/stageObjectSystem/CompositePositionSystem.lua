-- spins all spinners in the game, sets velocities acordingly

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")

local RECS = require(lib:WaitForChild("RECS"))
local Components = require(common:WaitForChild("Components"))

local CompositePositionSystem = RECS.System:extend("CompositePositionSystem")

function CompositePositionSystem:init()
    for instance, compositePos in self.core:components(Components.CompositePosition) do
        compositePos.originalCFrame = instance.CFrame -- set orig cframe
    end

    self.maid.componentAdded =
        self.core:getComponentAddedSignal(Components.CompositePosition):Connect(
            function(compositePos, instance)
                compositePos.originalCFrame = instance.CFrame
            end)
end

function CompositePositionSystem:step()
    for instance, compositePos in self.core:components(Components.CompositePosition) do
        -- dont worry about entities that aren't visible
        if instance:IsDescendantOf(game:GetService("Workspace")) then
            local cframeAccumulator = CFrame.new()
            local sortedCFrames = {}

            for _,cfStruct in pairs(compositePos.cframes) do
                table.insert(sortedCFrames,cfStruct) -- insert to a array we can sort
            end

            table.sort(sortedCFrames, function(a,b) return a.priority < b.priority end)

            for _,cfStruct in ipairs(sortedCFrames) do
                cframeAccumulator = cframeAccumulator * cfStruct.cframe
            end

            instance.CFrame = compositePos.originalCFrame * cframeAccumulator
        end
    end
end

return CompositePositionSystem
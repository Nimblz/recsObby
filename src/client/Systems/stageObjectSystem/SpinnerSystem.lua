-- spins all spinners in the game, sets velocities acordingly

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")

local client = game:GetService("StarterPlayer"):WaitForChild("StarterPlayerScripts")
local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")

local RECS = require(lib:WaitForChild("RECS"))
local Components = require(common:WaitForChild("Components"))
local CompositePositionPriority = require(client:WaitForChild("CompositePositionPriority"))

local SpinnerSystem = RECS.System:extend("SpinnerSystem")

function SpinnerSystem:init()
    self.maid.componentAdded =
        self.core:getComponentAddedSignal(Components.Spinner):Connect(
            function(spinner, instance)
                local compositePosition = self.core:getComponent(instance, Components.CompositePosition)

                if not compositePosition then
                    CollectionService:AddTag(instance,"CompositePosition")
                end
            end)
end

function SpinnerSystem:step()
    for instance, spinner in self.core:components(Components.Spinner) do
        -- dont worry about coins that aren't loaded
        if instance:IsDescendantOf(game:GetService("Workspace")) then
            local offsetTime = tick()+spinner.offset
            local scaledTime = offsetTime * spinner.revsPerSec
            local theta = scaledTime % math.pi * 2
            local rotCFrame = CFrame.fromAxisAngle(spinner.rotAxis,theta)

            local compositePosition = self.core:getComponent(instance, Components.CompositePosition)
            if compositePosition then
                compositePosition.cframes.spin = {
                    cframe = rotCFrame,
                    priority = CompositePositionPriority.SPINNING_PLATFORMS
                }
            end
        end
    end
end


return SpinnerSystem
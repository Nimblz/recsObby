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

local CastShadowSystem = RECS.System:extend("CastShadowSystem")

function CastShadowSystem:init()
    self.maid.componentAdded =
        self.core:getComponentAddedSignal(Components.Spinner):Connect(
            function(spinner, instance)
                local compositePosition = self.core:getComponent(instance, Components.CompositePosition)

                if not compositePosition then
                    CollectionService:AddTag(instance,"CompositePosition")
                end
            end)
end

function CastShadowSystem:step()
    for character, shadowComponent in self.core:components(Components.CastShadow) do
        local humanoid = character:WaitForChild("Humanoid")
        local root = character:WaitForChild("HumanoidRootPart")

        if humanoid and root then
            -- TODO: shadow
        end
    end
end


return CastShadowSystem
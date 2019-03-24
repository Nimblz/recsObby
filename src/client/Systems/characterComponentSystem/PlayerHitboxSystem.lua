-- spins all spinners in the game, sets velocities acordingly

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")

local RECS = require(lib:WaitForChild("RECS"))
local Components = require(common:WaitForChild("Components"))

local PlayerHitboxSystem = RECS.System:extend("PlayerHitboxSystem")

function PlayerHitboxSystem:init()
    self.maid.componentAdded =
    self.core:getComponentAddedSignal(Components.PlayerHitbox):Connect(
        function(hitbox, instance)
        end)
end

function PlayerHitboxSystem:step()
    for instance, hitbox in self.core:components(Components.PlayerHitbox) do
        -- Todo: Hitbox
    end
end

return PlayerHitboxSystem
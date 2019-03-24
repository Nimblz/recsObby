-- damages players that touch DamageTrigger instances
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")
local client = game:GetService("StarterPlayer"):WaitForChild("StarterPlayerScripts")

local RECS = require(lib:WaitForChild("RECS"))
local Components = require(common:WaitForChild("Components"))

local hitIsYou = require(client:WaitForChild("hitIsYou"))

local DamageTriggerSystem = RECS.System:extend("DamageTriggerSystem")

function DamageTriggerSystem:triggerTouched(damageTrigger, instance, hit)
    if hitIsYou(hit) then
        local character = hit.Parent
        local humanoid = character:FindFirstChild("Humanoid")

        if humanoid and humanoid.Health > 0 then
            humanoid:TakeDamage(damageTrigger.damage)
        end
    end
end

function DamageTriggerSystem:init()
    self.maid.componentAdded =
        self.core:getComponentAddedSignal(Components.DamageTrigger):Connect(
            function(damageTrigger, instance)
                instance.Touched:Connect(function(hit)
                    self:triggerTouched(damageTrigger, instance, hit)
                end)
            end)
end

function DamageTriggerSystem:step()
    -- it seems i have to do this, though this is a listening system
end

return DamageTriggerSystem
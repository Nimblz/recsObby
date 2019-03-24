-- increments the score of players that touch CoinTrigger instances, destroys those instances when touched.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")
local client = game:GetService("StarterPlayer"):WaitForChild("StarterPlayerScripts")

local RECS = require(lib:WaitForChild("RECS"))
local Sound = require(client:WaitForChild("Sound"))
local Components = require(common:WaitForChild("Components"))

local hitIsYou = require(client:WaitForChild("hitIsYou"))

local CoinTriggerSystem = RECS.System:extend("CoinTriggerSystem")

function CoinTriggerSystem:coinTouched(coinTrigger, instance, hit)
    if hitIsYou(hit) then
        local localPlayer = Players.LocalPlayer
        local stats = self.core:getComponent(localPlayer, Components.PlayerStats)

        Sound:playSound(Sound.sounds.COIN_COLLECT,instance.CFrame)
        instance:Destroy()

        stats.score = stats.score + coinTrigger.value
    end
end

function CoinTriggerSystem:init()
    self.maid.componentAdded =
        self.core:getComponentAddedSignal(Components.CoinTrigger):Connect(
            function(coinTrigger, instance)
                instance.Touched:Connect(function(hit)
                    self:coinTouched(coinTrigger, instance, hit)
                end)
            end)
end

function CoinTriggerSystem:step()
    -- it seems i have to do this, though this is a listening system
end

return CoinTriggerSystem
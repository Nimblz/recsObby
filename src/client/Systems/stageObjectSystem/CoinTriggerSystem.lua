-- increments the score of players that touch CoinTrigger instances, destroys those instances when touched.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")
local client = game:GetService("StarterPlayer"):WaitForChild("StarterPlayerScripts")

local RECS = require(lib:WaitForChild("RECS"))
local Sound = require(client:WaitForChild("Sound"))
local Components = require(common:WaitForChild("Components"))

local CoinTriggerSystem = RECS.System:extend("CoinTriggerSystem")

local function hitIsYou(hit)
    return Players:GetPlayerFromCharacter(hit.Parent) == Players.LocalPlayer
end

function CoinTriggerSystem:coinTouched(coinTrigger, instance, hit)
    if hitIsYou(hit) then
        local localPlayer = Players.LocalPlayer
        Sound:playSound(Sound.sounds.COIN_COLLECT,instance.CFrame)
        instance:Destroy()
        local stats = self.core:getComponent(localPlayer, Components.PlayerStats)
        stats.score = stats.score + coinTrigger.value
        print(stats.score)
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
-- client

--[[
    Motiviation is to do most stuff on the client
]]

-- services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")

-- paths
local client = script.Parent
local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")


-- libraries, enum-like objects
local RECS = require(lib:WaitForChild("RECS"))
local Components = require(common:WaitForChild("Components"))
local Systems = require(client:WaitForChild("Systems"))

-- variables
local core = RECS.Core.new()

local remote = ReplicatedStorage:WaitForChild("remote")
local localPlayer = Players.LocalPlayer
local e_RequestCharacterLoad = remote:WaitForChild("RequestCharacterLoad")

-- tells the RECS core about our components (data)
local function registerAllComponents()
    for _,component in pairs(Components) do
        core:registerComponent(component)
    end
end

-- registers our systems (behaviors) with the RECS core
local function registerAllSystems()
    core:registerSystems(Systems)
end

-- starts the player respawn loop
local function bindCharacterRespawner()
    localPlayer.CharacterAdded:connect(function(character)
        local humanoid = character:WaitForChild("Humanoid")
        local root = character:WaitForChild("HumanoidRootPart")

        -- attach the relavant character components
        CollectionService:AddTag(character,"PlayerHitbox")
        CollectionService:AddTag(root,"ForceReciever")

        -- oh noes, respawn the character!
        humanoid.Died:connect(function()
            e_RequestCharacterLoad:FireServer()
        end)
    end)
    e_RequestCharacterLoad:FireServer()
end
-- spawn the character
bindCharacterRespawner()

-- let's start the game.
registerAllComponents()
registerAllSystems()
core:start()


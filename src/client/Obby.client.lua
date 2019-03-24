-- client

--[[
    Motiviation is to do most stuff on the client
]]

-- services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

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

-- let's start the game.
registerAllComponents()
registerAllSystems()
core:start()


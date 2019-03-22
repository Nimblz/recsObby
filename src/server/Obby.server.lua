-- server

--[[
    Motiviation is to do most stuff on the client
    if something _has_ to be done on the server it should be done here
    eg: PhysicsService stuff, character loading
]]

local Players = game:GetService("Players")
local PhysicsService = game:GetService("PhysicsService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remote = ReplicatedStorage:WaitForChild("remote")

local e_RequestCharacterLoad = remote:WaitForChild("RequestCharacterLoad")

PhysicsService:CreateCollisionGroup("characters")
PhysicsService:CollisionGroupSetCollidable("characters", "characters", false)

-- collision stuff
Players.PlayerAdded:connect(function(player)
    player.CharacterAppearanceLoaded:connect(function(character)
        for _,part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                PhysicsService:SetPartCollisionGroup(part,"characters")
            end
        end
    end)
end)

-- character loading
e_RequestCharacterLoad.OnServerEvent:connect(function(player, position)
    position = position or Vector3.new(0,100,0)
    player:LoadCharacter()

    local character = player.Character or player.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")

    rootPart.CFrame = CFrame.new(position)
end)
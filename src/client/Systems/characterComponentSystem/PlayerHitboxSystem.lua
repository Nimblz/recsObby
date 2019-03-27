-- spins all spinners in the game, sets velocities acordingly

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local client = game:GetService("StarterPlayer"):WaitForChild("StarterPlayerScripts")
local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")
local model = ReplicatedStorage:WaitForChild("model")

local Dictionary = require(client:WaitForChild("Dictionary"))
local RECS = require(lib:WaitForChild("RECS"))
local Components = require(common:WaitForChild("Components"))

local PlayerHitboxSystem = RECS.System:extend("PlayerHitboxSystem")

function PlayerHitboxSystem:init()
    self.maid.componentAdded =
        self.core:getComponentAddedSignal(Components.PlayerHitbox):Connect(
            function(playerHitbox, instance)
                local hitboxPart = model:WaitForChild("Hitbox"):Clone()

                playerHitbox.hitboxPart = hitboxPart
                playerHitbox.attachedCharacter = instance
                playerHitbox.attachedPlayer = Players:GetPlayerFromCharacter(instance)
                hitboxPart.Parent = instance

                instance.AncestryChanged:Connect(function()
                    if not instance:IsDescendantOf(game) then
                        playerHitbox.hitboxPart = nil
                        hitboxPart:Destroy()
                    end
                end)
            end)
end

function PlayerHitboxSystem:step()
    for character, playerHitbox in self.core:components(Components.PlayerHitbox) do
        local humanoid = character:FindFirstChild("Humanoid")
        local root = character:FindFirstChild("HumanoidRootPart")
        local hitboxPart = playerHitbox.hitboxPart

        if humanoid and root and hitboxPart then
            -- vectors we do math on to find right orientation
            local offset =
                humanoid.RigType == Enum.HumanoidRigType.R15 and Vector3.new(0,1.5,0)
                or Vector3.new(0,-0.5,0)
            local pos = root.Position + offset
            local up = Vector3.new(0,1,0)
            local forward = Vector3.new(0,0,-1)
            local direction = (root.CFrame.LookVector * Vector3.new(1,0,1)).Unit

            -- flip angle?
            local isForwardAngleNegative = math.sign(forward:Cross(direction).Y)
            -- angle to match facing direction
            local forwardAngle = math.acos(forward:Dot(direction)) * isForwardAngleNegative

            hitboxPart.CFrame =
                CFrame.new(pos) *
                CFrame.fromAxisAngle(up,forwardAngle) -- tilt to match character facing

            --[[
            the part must be unanchored to fire touched events on other parts, but
            that means it will accumulate velocity every step. In order to prevent it
            from falling below the clear plane, we reset the velocity every frame.
            ]]
            hitboxPart.Velocity = Vector3.new(0,0,0)
        end
    end
end


return PlayerHitboxSystem
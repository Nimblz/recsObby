-- makes the trampoline instances bouncy!
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")
local client = game:GetService("StarterPlayer"):WaitForChild("StarterPlayerScripts")

local RECS = require(lib:WaitForChild("RECS"))
local Sound = require(client:WaitForChild("Sound"))
local Components = require(common:WaitForChild("Components"))

local hitIsYou = require(client:WaitForChild("hitIsYou"))

local TrampolineSystem = RECS.System:extend("TrampolineSystem")

function TrampolineSystem:trampolineTouched(trampoline, instance, hit)
    if hitIsYou(hit) then
        local character = hit.Parent
        local root = character:FindFirstChild("HumanoidRootPart")
        local humanoid = character:FindFirstChild("Humanoid")

        if root and humanoid then
            Sound:playSound(Sound.sounds.TRAMPOLINE_BOING, instance.CFrame)
            humanoid:ChangeState(Enum.HumanoidStateType.Physics)
            local gravity = workspace.Gravity
            local impulseAmmount = math.sqrt(2 * gravity * trampoline.jumpHeight)
            for _,charPart in pairs(character:GetChildren()) do
                if charPart:IsA"BasePart" then
                    charPart.Velocity = Vector3.new(root.Velocity.X,impulseAmmount,root.Velocity.Z)
                end
            end
            humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
        end
    end
end

function TrampolineSystem:init()
    self.maid.componentAdded =
        self.core:getComponentAddedSignal(Components.Trampoline):Connect(
            function(trampoline, instance)
                instance.Touched:Connect(function(hit)
                    self:trampolineTouched(trampoline, instance, hit)
                end)
            end)
end

function TrampolineSystem:step()
    -- it seems i have to do this, though this is a listening system
end

return TrampolineSystem
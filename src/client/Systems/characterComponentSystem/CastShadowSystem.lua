-- spins all spinners in the game, sets velocities acordingly

local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local client = game:GetService("StarterPlayer"):WaitForChild("StarterPlayerScripts")
local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")
local model = ReplicatedStorage:WaitForChild("model")

local Dictionary = require(client:WaitForChild("Dictionary"))
local RECS = require(lib:WaitForChild("RECS"))
local Components = require(common:WaitForChild("Components"))

local CastShadowSystem = RECS.System:extend("CastShadowSystem")

function CastShadowSystem:init()
    self.maid.componentAdded =
        self.core:getComponentAddedSignal(Components.CastShadow):Connect(
            function(castShadow, instance)
                local shadowPart = model:WaitForChild("Shadow"):Clone()

                castShadow.shadowPart = shadowPart

                instance.AncestryChanged:Connect(function()
                    if not instance:IsDescendantOf(game) then
                        castShadow.shadowPart = nil
                        shadowPart:Destroy()
                    end
                end)
            end)
end

function CastShadowSystem:step()
    for character, castShadow in self.core:components(Components.CastShadow) do
        local humanoid = character:FindFirstChild("Humanoid")
        local root = character:FindFirstChild("HumanoidRootPart")
        local shadowPart = castShadow.shadowPart

        if humanoid and root and shadowPart then
            local rayOrigin = root.Position
            local rayDirection = castShadow.castDirection*castShadow.castLength
            local castShadowRay = Ray.new(rayOrigin,rayDirection)
            local blacklist = {character,shadowPart}

            for _,noCollidable in ipairs(CollectionService:GetTagged("NoCollide")) do
                table.insert(blacklist,noCollidable)
            end

            local hit, pos, normal = Workspace:FindPartOnRayWithIgnoreList(castShadowRay,blacklist)

            local dist = (rayOrigin-pos).Magnitude

            if hit and dist > 4 then

                if shadowPart.Parent == nil then
                    shadowPart.Parent = Workspace
                end

                local up = Vector3.new(0,1,0)
                local forward = Vector3.new(0,0,-1)
                local direction = (root.CFrame.LookVector * Vector3.new(1,0,1)).Unit

                local right = up:Cross(normal)
                local normalAngle = math.acos(up:Dot(normal))

                local isForwardAngleNegative = math.sign(forward:Cross(direction).Y)
                local forwardAngle = math.acos(forward:Dot(direction)) * isForwardAngleNegative
                local rightCross = right.Magnitude == 0 and Vector3.new(1,0,0) or right.Unit

                shadowPart.CFrame =
                    CFrame.new(pos) *
                    CFrame.fromAxisAngle(normal,forwardAngle) *
                    CFrame.fromAxisAngle(rightCross, normalAngle)
            else
                if shadowPart.Parent == Workspace then
                    shadowPart.Parent = nil
                end
            end
        end
    end
end


return CastShadowSystem
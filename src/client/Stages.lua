-- module that compiles and returns all the game's stages in order, order is determined by name.
-- stage must be named chronologically with no gaps in number

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local stage = ReplicatedStorage:WaitForChild("stage")

local numStages = #stage:GetChildren() - 1

local stageInstances = {}

for i = 1, numStages do
    table.insert(stageInstances,stage:WaitForChild("Stage"..i))
end

table.insert(stageInstances, stage:WaitForChild("StageEnd"))

return stageInstances
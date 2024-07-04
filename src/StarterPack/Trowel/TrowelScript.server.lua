-- Trowel @ kidvinnilla

local replicatedStorage = game:GetService("ReplicatedStorage")

-- Require modules
local animationModule = require(replicatedStorage:WaitForChild("AnimationModule"))

local gardenAssets = replicatedStorage.GardenAssets
local plot = gardenAssets.Plot

local inputData = Instance.new("RemoteFunction",script.Parent)
local tool = script.Parent
local handle = tool.Handle

local settings = require(script.Parent.Settings)
tool.ToolTip = settings.ToolTip


tool.Equipped:Connect(function()
end)

tool.Unequipped:Connect(function()
end)

tool.Activated:Connect(function()
	if not tool.Enabled then return end
	animationModule.Slash(tool)
end)
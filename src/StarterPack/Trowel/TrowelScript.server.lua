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
	local player = game.Players:GetPlayerFromCharacter(tool.Parent)
	if player then
		local selectedSeed, selectedPlot = inputData:InvokeClient(player)
		if selectedSeed and selectedPlot then
			tool.Enabled = false

			local seedData = settings.Seeds[selectedSeed]
			local seedSpacing = seedData.spacing
			local spacingData = settings.Spacing[seedSpacing]
			local seedAssetsFolder = gardenAssets.vegetables[selectedSeed]
			local seedMesh = seedAssetsFolder:WaitForChild("seed")
			local plotPosition = selectedPlot.Position

			for counter = 1, seedSpacing do
				local clone = seedMesh:Clone()
				local primaryPart = clone.PrimaryPart
				primaryPart.Position = plotPosition + spacingData[counter]
				primaryPart.Anchored = true
				clone.Parent = selectedPlot

				-- TODO: start async growing of each separate plant
			end

			selectedPlot:SetAttribute(settings.PlantedAttribute, true)
			
			wait(settings.Cooldown)
			tool.Enabled = true
		end
	end
end)
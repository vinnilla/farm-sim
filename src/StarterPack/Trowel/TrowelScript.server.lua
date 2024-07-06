-- Trowel @ kidvinnilla

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local remoteEvent = ReplicatedStorage:FindFirstChildOfClass("RemoteEvent")

local gardenAssets = ReplicatedStorage.GardenAssets
local plot = gardenAssets.Plot
local tool = script.Parent
local handle = tool.Handle

local settings = require(script.Parent.Settings)
tool.ToolTip = settings.ToolTip


tool.Equipped:Connect(function()
end)

tool.Unequipped:Connect(function()
end)

tool.Activated:Connect(function()
end)

local function plantSeed(player, selectedSeed, selectedPlot)
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

remoteEvent.OnServerEvent:Connect(plantSeed)
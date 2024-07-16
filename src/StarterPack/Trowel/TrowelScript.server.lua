-- Trowel @ kidvinnilla

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local plantEvent = ReplicatedStorage:WaitForChild("PlantEvent")
local growthEvent = ServerScriptService:WaitForChild("GrowthEvent")

local plantSettings = require(ReplicatedStorage:WaitForChild("PlantSettings"))

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
	if selectedSeed and selectedPlot and selectedPlot.Name == "Plot" then
		tool.Enabled = false

		local seedData = plantSettings.seedData[selectedSeed]
		local seedSpacing = seedData.spacing
		local spacingData = plantSettings.spacingData[seedSpacing]
		local seedAssetsFolder = gardenAssets.vegetables[selectedSeed]
		local seedMesh = seedAssetsFolder:WaitForChild("seed")
		local plotPosition = selectedPlot.Position

		for counter = 1, seedSpacing do
			local clone = seedMesh:Clone()
			local primaryPart = clone.PrimaryPart
			primaryPart.Position = plotPosition + spacingData[counter]
			primaryPart.Anchored = true
			clone.Parent = selectedPlot
		end
		-- TODO: set up bindable event to simulate async growing of each separate plant
		growthEvent:Fire(selectedSeed, selectedPlot)

		selectedPlot:SetAttribute(settings.PlantedAttribute, true)
		
		wait(settings.Cooldown)
		tool.Enabled = true
	end
end

plantEvent.OnServerEvent:Connect(plantSeed)
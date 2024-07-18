local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Get reference to bindable event instance
local growthEvent = ServerScriptService:WaitForChild("GrowthEvent")
local plantSettings = require(ReplicatedStorage:WaitForChild("PlantSettings"))
local gardenAssets = ReplicatedStorage.GardenAssets

local function replaceModels(plot, state, seedName, seedData)
  -- clear plot
  plot:ClearAllChildren()

  -- place seedling models
  local seedSpacing = seedData.spacing
  local spacingData = plantSettings.spacingData[seedSpacing]
  local seedAssetsFolder = gardenAssets.vegetables[seedName]
  local plotPosition = plot.Position

  local model = seedAssetsFolder:WaitForChild(state)
  for counter = 1, seedSpacing do
    local clone = model:Clone()
    local primaryPart = clone.PrimaryPart
    primaryPart.Position = plotPosition + spacingData[counter]
    primaryPart.Anchored = true
    clone.Parent = plot
  end
end

local function asyncGrowPlants(seedName, plot)
  print(seedName, plot, plantSettings.seedData[seedName])

  local seedData = plantSettings.seedData[seedName]
  local timingData = seedData.timing

  for i, data in ipairs(timingData) do
    local state = data.state
    print(state)

    if (state == "seedling" or state == "harvest" or state == "withered") then
      replaceModels(plot, state, seedName, seedData)
    elseif (state == "gone") then
      plot:ClearAllChildren()
      plot:SetAttribute(plantSettings.PlantedAttribute, false)
      break
    end

    wait(data.length)
  end
end

growthEvent.Event:Connect(asyncGrowPlants)
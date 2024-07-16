local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Get reference to bindable event instance
local growthEvent = ServerScriptService:WaitForChild("GrowthEvent")
local plantSettings = require(ReplicatedStorage:WaitForChild("PlantSettings"))

local function asyncGrowPlants(seedName, plot)
  print(seedName, plot, plantSettings.seedData[seedName])

  local seedData = plantSettings.seedData[seedName]
  local seedSpacing = seedData.spacing
  local timingData = seedData.timing
  local spacingData = plantSettings.spacingData[seedSpacing]

  for i, data in ipairs(timingData) do
    local state = data.state
    print(state)

    if (state == "seed") then
    elseif (state == "seedling") then
      -- todo: implement replacing seeds with seedling model
    elseif (state == "harvest") then
      -- todo: implement replacing seedling with harvest model
    elseif (state == "withered") then
      -- todo: implement replacing harvest with withered model
    elseif (state == "gone") then
      -- todo: implement clearing plot
      print("clearing plot")
      break
    end

    wait(data.length)
  end
end

growthEvent.Event:Connect(asyncGrowPlants)
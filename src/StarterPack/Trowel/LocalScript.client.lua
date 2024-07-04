-- Trowel - Client @ kidvinnilla

local settings = require(script.Parent.Settings)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local gardenAssets = ReplicatedStorage.GardenAssets
--local plot = gardenAssets.Plot

--local seedSelectorFrame = gardenAssets.ui.SeedSelectorFrame

local player = game.Players.LocalPlayer
local seedSelectorFrame = player.PlayerGui.ScreenGui.SeedSelectorFrame
local tool = script.Parent
local handle = tool.Handle
local seeds = settings.Seeds

local clickPosition
local clickTarget
local selectedSeed

-- Helper function to translate screen pointer position to 3D world position START
local function findInGamePosition(inputPosition)
	local camera = workspace.CurrentCamera
	local unitray = camera:ViewportPointToRay(inputPosition.x, inputPosition.y)
	local ray = Ray.new(unitray.Origin, unitray.Direction * 100)
	local target, position = workspace:FindPartOnRay(ray, player.Character or nil)
	return position, target
end
-- Helper function to translate screen pointer position to 3D world position START


-- Remote Function to send client mouse data to server START
tool:WaitForChild("RemoteFunction").OnClientInvoke = function(...)
	return clickPosition, clickTarget
end
-- Remote Function to send client mouse data to server END

local function toggleSeedSelectorFrame()
	local currentVisibility = seedSelectorFrame.Visible
	seedSelectorFrame.Visible = not currentVisibility	
end

local function closeSeedSelectorFrame()
	seedSelectorFrame.Visible = false
end

-- handle player input START
local function onInputBegan(inputObject, processedEvent)
	if processedEvent then return end

	if (inputObject.UserInputType == Enum.UserInputType.MouseButton1) or
		(inputObject.UserInputType == Enum.UserInputType.Touch) then
		--clickPosition, clickTarget = findInGamePosition(inputObject.Position)
	elseif (inputObject.UserInputType == Enum.UserInputType.Keyboard) and (inputObject.KeyCode == Enum.KeyCode.E) then
		toggleSeedSelectorFrame()
	end
end

--local function onInputEnded(inputObject, processedEvent)
--	if processedEvent then return end

--	if (inputObject.UserInputType == Enum.UserInputType.MouseButton1) or
--		(inputObject.UserInputType == Enum.UserInputType.Touch) then
--		--clickPosition, clickTarget = findInGamePosition(inputObject.Position)
--		--hideForecast()
--	end
--end

--local function onInputChanged(inputObject, processedEvent)
--	if processedEvent then return end

--	if (inputObject.UserInputType == Enum.UserInputType.MouseMovement) or
--		(inputObject.UserInputType == Enum.UserInputType.Touch) then
--		--forecastArea(findInGamePosition(inputObject.Position))
--	end
--end

local function selectSeed(seedName, seedButton)	
	selectedSeed = seedName
	
	-- reset all buttons' border size
	local frame = seedButton.Parent
	for seedName in seeds do
		frame:WaitForChild(seedName).BorderSizePixel = 2
	end
	
	seedButton.BorderSizePixel = 5
	print("updated selectedSeed to " .. seedName)
	toggleSeedSelectorFrame()
end
-- handle player input END



-- Connection management START
local inputBeganConnection
local inputChangedConnection
local inputEndedConnection
local carrotInputBeganConnection
local potatoInputBeganConnection
local cornInputBeganConnection

tool.Equipped:Connect(function()
	inputBeganConnection = UserInputService.InputBegan:Connect(onInputBegan)
	--inputChangedConnection = UserInputService.InputChanged:Connect(onInputChanged)
	--inputEndedConnection = UserInputService.InputEnded:Connect(onInputEnded)
	carrotInputBeganConnection = seedSelectorFrame.carrot.InputBegan:Connect(function(inputObject, processedEvent)
		if processedEvent then return end
		
		if (inputObject.UserInputType == Enum.UserInputType.MouseButton1) or
			(inputObject.UserInputType == Enum.UserInputType.Touch) then
			selectSeed("carrot", seedSelectorFrame.carrot)
		end
	end)
	potatoInputBeganConnection = seedSelectorFrame.potato.InputBegan:Connect(function(inputObject, processedEvent)
		if processedEvent then return end

		if (inputObject.UserInputType == Enum.UserInputType.MouseButton1) or
			(inputObject.UserInputType == Enum.UserInputType.Touch) then
			selectSeed("potato", seedSelectorFrame.potato)
		end
	end)
	cornInputBeganConnection = seedSelectorFrame.corn.InputBegan:Connect(function(inputObject, processedEvent)
		if processedEvent then return end

		if (inputObject.UserInputType == Enum.UserInputType.MouseButton1) or
			(inputObject.UserInputType == Enum.UserInputType.Touch) then
			selectSeed("corn", seedSelectorFrame.corn)
		end
	end)
end)

tool.Unequipped:Connect(function()
	closeSeedSelectorFrame()
	inputBeganConnection:Disconnect()
	inputBeganConnection = nil
	--inputChangedConnection:Disconnect()
	--inputChangedConnection = nil
	--inputEndedConnection:Disconnect()
	--inputEndedConnection = nil
	carrotInputBeganConnection:Disconnect()
	carrotInputBeganConnection = nil
	potatoInputBeganConnection:Disconnect()
	potatoInputBeganConnection = nil
	cornInputBeganConnection:Disconnect()
	cornInputBeganConnection = nil
end)
-- Connection management END
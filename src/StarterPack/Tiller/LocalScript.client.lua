-- Tiller - Client @ kidvinnilla

local settings = require(script.Parent.Settings)

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local gardenAssets = ReplicatedStorage.GardenAssets
local plot = gardenAssets.Plot

local UserInputService = game:GetService("UserInputService")

local player = game.Players.LocalPlayer
local tool = script.Parent
local handle = tool.Handle

local clickPosition
local clickTarget

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


-- Mouse Hit Forecast START
local ghostPlot

local function instantiateGhostPlot()
	ghostPlot = plot:Clone()
	ghostPlot.Name = "plotForecast"
	ghostPlot.Anchored = false
	ghostPlot.CanCollide = false
	ghostPlot.CanQuery = false
	ghostPlot.CanTouch = false
	ghostPlot.Massless = true
	ghostPlot.Transparency = 0.7
	ghostPlot.Parent = workspace.Terrain
end

local function destroyGhostPlot()
	ghostPlot:Destroy()
	ghostPlot = nil
end

local function hideForecast()
	ghostPlot.Transparency = 1
end

local function forecastArea(hoverPosition)
	local distanceToMouse = (hoverPosition - handle.Position).Magnitude
	local isOutOfReach = distanceToMouse > settings.Reach
	
	-- hide ghostPlot if mouse is too far away from player
	if isOutOfReach then
		hideForecast()
		return
	end
	
	-- make ghostPlot semi visible again if previously hidden
	if ghostPlot.Transparency == 1 then
		ghostPlot.Transparency = 0.7
	end
	
	ghostPlot.Position = hoverPosition - Vector3.new(0, 0.4, 0)
end
-- Mouse Hit Forecast END


-- handle player input START
local function onInputBegan(inputObject, processedEvent)
	if processedEvent then return end

	if (inputObject.UserInputType == Enum.UserInputType.MouseButton1) or
		(inputObject.UserInputType == Enum.UserInputType.Touch) then
		clickPosition, clickTarget = findInGamePosition(inputObject.Position)
		forecastArea(clickPosition)
	end
end

local function onInputEnded(inputObject, processedEvent)
	if processedEvent then return end

	if (inputObject.UserInputType == Enum.UserInputType.MouseButton1) or
		(inputObject.UserInputType == Enum.UserInputType.Touch) then
		clickPosition, clickTarget = findInGamePosition(inputObject.Position)
		hideForecast()
	end
end

local function onInputChanged(inputObject, processedEvent)
	if processedEvent then return end

	if (inputObject.UserInputType == Enum.UserInputType.MouseMovement) or
		(inputObject.UserInputType == Enum.UserInputType.Touch) then
		forecastArea(findInGamePosition(inputObject.Position))
	end
end
-- handle player input END


-- Connection management START
local inputBeganConnection
local inputChangedConnection
local inputEndedConnection

tool.Equipped:Connect(function()
	instantiateGhostPlot()
	inputBeganConnection = UserInputService.InputBegan:Connect(onInputBegan)
	inputChangedConnection = UserInputService.InputChanged:Connect(onInputChanged)
	inputEndedConnection = UserInputService.InputEnded:Connect(onInputEnded)
end)
tool.Unequipped:Connect(function()
	destroyGhostPlot()
	inputBeganConnection:Disconnect()
	inputBeganConnection = nil
	inputChangedConnection:Disconnect()
	inputChangedConnection = nil
	inputEndedConnection:Disconnect()
	inputEndedConnection = nil
end)
-- Connection management END
-- Tiller @ kidvinnilla

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
		local hitPosition, hitTarget = inputData:InvokeClient(player)
		
		if hitTarget == workspace.Terrain and (hitPosition - handle.Position).Magnitude <= settings.Reach then
			tool.Enabled = false

			-- generate new plot part
			local clone = plot:Clone()
			clone.Position = hitPosition - Vector3.new(0, 0.4, 0) -- position plot just above terrain
			clone.Parent = workspace.Terrain

			-- check overlap
			local partList = { clone }
			local isTouching = (workspace:ArePartsTouchingOthers(partList, .5))				
			if isTouching then
				print('oops, there is already a plot there!')
				clone:Destroy()
			end

			wait(settings.Cooldown)
			tool.Enabled = true
		end
	end
end)
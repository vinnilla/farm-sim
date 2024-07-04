local Animation = {}

Animation.Slash = function(tool)
	local animation = Instance.new("StringValue")
	animation.Name = "toolanim"
	animation.Value = "Slash"
	animation.Parent = tool
end

return Animation

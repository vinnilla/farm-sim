-- Trowel - Settings @ kidvinnilla
-- vincent silly goose huang

local seedData = {
	carrot = {
		spacing = 9
	},
	potato = {
		spacing = 1
	},
	corn = {
		spacing = 1
	}
}

local spacingData = {
	[1] = { Vector3.new(0, 0.5, 0) },
	[9] = {
		Vector3.new(0, 0.5, 0),
		Vector3.new(0, 0.5, 4),
		Vector3.new(0, 0.5, -4),
		Vector3.new(4, 0.5, 0),
		Vector3.new(4, 0.5, 4),
		Vector3.new(4, 0.5, -4),
		Vector3.new(-4, 0.5, 0),
		Vector3.new(-4, 0.5, 4),
		Vector3.new(-4, 0.5, -4)
	}
}

return {
	ToolTip = "Plant seeds";
	PlantedAttribute = "Planted";
	
	Cooldown = .5;		-- tool cooldown in seconds
	
	Seeds = seedData;
	Spacing = spacingData;
}
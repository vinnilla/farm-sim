local seedData = {
	carrot = {
		spacing = 9,
    timing = {
			{ state = "seed", length = 10 },
			{ state = "seedling", length = 10 },
			{ state = "harvest", length = 10 },
			{ state = "withered", length = 10 },
			{ state = "gone" }
    }
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
	PlantedAttribute = "Planted";
	seedData = seedData;
	spacingData = spacingData;
}
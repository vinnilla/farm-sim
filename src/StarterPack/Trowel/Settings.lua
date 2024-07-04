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

return {
	ToolTip = "Plant seeds";
	
	Reach = 32;			-- how far the tool can reach
	Cooldown = .5;		-- tool cooldown in seconds
	
	Seeds = seedData;
}
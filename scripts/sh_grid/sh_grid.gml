function sh_grid(args)
{
	if array_length(args) > 1
	{
		var xx = args[1], yy = xx;
		
		if array_length(args) > 2
			yy = args[2];
		
		if string_is_number(xx)
			xx = real(xx);
		else
			return "X parameter must be a number";
		
		if string_is_number(yy)
			yy = real(yy);
		else
			return "Y parameter must be a number";
		
		WC_drag_grid = [xx, yy];
		return "Set dragging grid to " + args[1] + "x" + args[2];
	}
	else
	{
		WC_drag_grid = [1, 1];
		return "Set dragging grid to 1x1";
	}
}
function meta_grid()
{
	return {
		description: "set the object dragging and creating grid. leave arguments empty to disable grid",
		arguments: ["<x>", "<y>"],
		suggestions: [
			function()
			{
				if WC_drag_grid[0] != 32
					return [WC_drag_grid[0], 32];
				return [32];
			},
			function()
			{
				if WC_drag_grid[1] != 32
					return [WC_drag_grid[1], 32];
				return [32];
			}
		],
		argumentDescriptions: [
			"the grid's horizontal snap",
			"the grid's vertical snap"
		],
	}
}


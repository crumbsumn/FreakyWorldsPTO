visible = true
switch string_lower(rank)
{
	case "none": visible = false; break;
	case "s": image_index = 0; break;
	case "a": image_index = 1; break;
	case "b": image_index = 2; break;
	case "c": image_index = 3; break;
	case "d": image_index = 4; break;
	case "eggplant": image_index = 5; break;
}

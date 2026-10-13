extends Node

enum {
	NAME, SPRITE, IS_UNLOCKED, EFFECT
}

const LOAD_PATH: String = "res://firefly-grove-puzzle-system/assets/items/"

## Returns an array of paths to an image, in the format:
## "res://firefly-grove-puzzle-system/assets/item_name.lower()/item_name-i.png"
func get_load_paths(item_name: String) -> Array[Resource]:
	var load_paths: Array = []
	load_paths.resize(4)
	if(item_name.to_lower() == item_name):
		print("Warning: item name in get_load_paths is inputed in lowercase. Make sure it matches the file name.")
	for i in range(4):
		load_paths[i] = load(LOAD_PATH + item_name.to_lower() + "/" + item_name + "-" + str(i + 1) + ".png")
	return load_paths

## Array of arrays storing all items. Each array represents an item, in the following
## format: (Index implied), Name: String, sprite: Array (one for each number), 
## unlocked?: bool, effects: dict
var all_items: Array[Array] = [
	["Sunflower", get_load_paths("Sunflower"), true, {}],
	["Triliy", get_load_paths("Triliy"), true, {"sun": 8, "water": 5}],
	["Pufflower", get_load_paths("Pufflower"), true, {"sun": -8}],
	["Glowberry", get_load_paths("Glowberry"), true, {}],
]

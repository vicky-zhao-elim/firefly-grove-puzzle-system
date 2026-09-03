extends Node

enum {
	NAME, SPRITE, IS_UNLOCKED, EFFECT
}

enum ItemEffect{
	TYPE, STRENGTH
}

## Array of arrays storing all items. Each array represents an item, in the following
## format: (Index implied), Name: String, sprite: Array (one for each number), 
## unlocked?: bool, effects: dict
var all_items: Array[Array] = [
	["One", [
		load("res://firefly-grove-puzzle-system/assets/sunflowers/Sunflowers-1.png"), load("res://firefly-grove-puzzle-system/assets/sunflowers/Sunflowers-2.png"), load("res://firefly-grove-puzzle-system/assets/sunflowers/Sunflowers-3.png"), load("res://firefly-grove-puzzle-system/assets/sunflowers/Sunflowers-4.png")
		], true, {}],
	["Three", [
		load("res://firefly-grove-puzzle-system/assets/Pufflower.png"), load("res://firefly-grove-puzzle-system/assets/Pufflower.png"), load("res://firefly-grove-puzzle-system/assets/Pufflower.png"), load("res://firefly-grove-puzzle-system/assets/Pufflower.png")
		], true, {"sun": 8, "water": 5}],
	["Placeholder", [
		load("res://icon.svg"), load("res://icon.svg"), load("res://icon.svg"), load("res://icon.svg"),
		], true, {"sun": -8}],
	["Placeholder", [
		load("res://icon.svg"), load("res://icon.svg"), load("res://icon.svg"), load("res://icon.svg"),
		], true, {}],
	["Placeholder", [
		load("res://icon.svg"), load("res://icon.svg"), load("res://icon.svg"), load("res://icon.svg"),
		], true, {}],
	["Placeholder", [
		load("res://icon.svg"), load("res://icon.svg"), load("res://icon.svg"), load("res://icon.svg"),
		], true, {}],
	["Placeholder", [
		load("res://icon.svg"), load("res://icon.svg"), load("res://icon.svg"), load("res://icon.svg"),
		], true, {}],
	["Placeholder", [
		load("res://icon.svg"), load("res://icon.svg"), load("res://icon.svg"), load("res://icon.svg"),
		], true, {}],
	["Placeholder", [
		load("res://icon.svg"), load("res://icon.svg"), load("res://icon.svg"), load("res://icon.svg"),
		], true, {}],
	["Placeholder", [
		load("res://icon.svg"), load("res://icon.svg"), load("res://icon.svg"), load("res://icon.svg"),
		], true, {}],
]

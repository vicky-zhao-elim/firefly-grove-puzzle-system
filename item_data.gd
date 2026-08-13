extends Node

enum {
	NAME, SPRITE, IS_UNLOCKED, HAS_EFFECT, EFFECT
}

enum ItemEffect{
	TYPE, STRENGTH
}

## Array of arrays storing all items. Each array represents an item, in the following
## format: (Index implied), Name: String, sprite: Array (one for each number), 
## unlocked?: bool, has effect?: bool => Array[effect type, effect strength]
var all_items : Array[Array] = [
	["One", [
		load("res://firefly-grove-puzzle-system/assets/Sunflower-1.png"), load("res://firefly-grove-puzzle-system/assets/Sunflower-2.png"), load("res://firefly-grove-puzzle-system/assets/Sunflower-3.png"), load("res://firefly-grove-puzzle-system/assets/Sunflower-4.png")
		], true, false],
	["Three", [
		load("res://firefly-grove-puzzle-system/assets/Pufflower.png"), load("res://firefly-grove-puzzle-system/assets/Pufflower.png"), load("res://firefly-grove-puzzle-system/assets/Pufflower.png"), load("res://firefly-grove-puzzle-system/assets/Pufflower.png")
		], true, true, ["sun", 8]],
]

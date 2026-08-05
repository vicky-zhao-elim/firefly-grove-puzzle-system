extends Node

enum {
	NAME, SPRITE, IS_UNLOCKED, HAS_EFFECT, EFFECT
}

enum ItemEffect{
	TYPE, STRENGTH
}

var all_items : Array[Array] = [
	# (Index implied), Name, sprite (one for each type - change to include dead ones?), unlocked?, has effect? => Array[effect type, effect strength]
	["One", [
		load("res://firefly-grove-puzzle-system/assets/Sunflower-1.png"), load("res://firefly-grove-puzzle-system/assets/Sunflower-2.png"), load("res://firefly-grove-puzzle-system/assets/Sunflower-3.png"), load("res://firefly-grove-puzzle-system/assets/Sunflower-4.png")
		], true, false],
	["Three", [
		load("res://firefly-grove-puzzle-system/assets/Pufflower.png"), load("res://firefly-grove-puzzle-system/assets/Pufflower.png"), load("res://firefly-grove-puzzle-system/assets/Pufflower.png"), load("res://firefly-grove-puzzle-system/assets/Pufflower.png")
		], true, true, ["sun", 1]],
]

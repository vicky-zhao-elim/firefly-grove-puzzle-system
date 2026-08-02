extends Node

enum {
	NAME, SPRITE, IS_UNLOCKED, HAS_EFFECT, EFFECT
}

enum ItemEffect{
	TYPE, STRENGTH
}

var all_items : Array[Array] = [
	# (Index implied), Name, sprite (one for each type - change to include dead ones?), unlocked?, has effect? => Array[effect type, effect strength]
	["One", [load("res://icon.svg"), load("res://icon.svg"), load("res://icon.svg"), load("res://icon.svg")], true, false],
	["Two", [load("res://icon.svg"), load("res://icon.svg"), load("res://icon.svg"), load("res://icon.svg")], false, false],
	["Three", [load("res://icon.svg"), load("res://icon.svg"), load("res://icon.svg"), load("res://icon.svg")], true, true, ["sun", 1]],
	["Four", [load("res://icon.svg"), load("res://icon.svg"), load("res://icon.svg"), load("res://icon.svg")], false, false],
]

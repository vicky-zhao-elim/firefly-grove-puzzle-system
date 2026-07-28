extends Node

enum {
	NAME, SPRITE, IS_UNLOCKED, HAS_EFFECT, EFFECT
}

enum ItemEffect{
	TYPE, STRENGTH
}

var all_items : Array[Array] = [
	# (Index implied), Name, sprite, unlocked?, has effect? => Array[effect type, effect strength]
	["One", load("res://icon.svg"), true, false],
	["Two", load("res://icon.svg"), false, false],
	["Three", load("res://icon.svg"), true, false],
	["Four", load("res://icon.svg"), false, false],
]

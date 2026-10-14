extends Node2D

@onready var dragged_scene: PackedScene = preload("res://firefly-grove-puzzle-system/scenes/dragged_card.tscn")
@onready var win_scene: PackedScene = preload("res://firefly-grove-puzzle-system/scenes/win_scene.tscn")

func _ready() -> void:
	%Inventory.show()
	for child in %InventorySlots.get_children():
		child.picked_up_card.connect(add_picked_up_card)
	%HorizontalRemoveWildlifeSlot.picked_up_card.connect(add_picked_up_card)
	
	for i in range($PuzzleGroups.get_child_count()):
		var current_puzzle_group: Node2D = $PuzzleGroups.get_child(i)
		current_puzzle_group.puzzle_id = i
		current_puzzle_group.puzzle_group_complete.connect(on_puzzle_group_complete)

## If a card has been picked up (signal from wildlife_card_slot.gd), 
## add the scene for a dragged card.
func add_picked_up_card(card_id : int) -> void:
	var new_dragged_scene = dragged_scene.instantiate()
	new_dragged_scene.wildlife_id = card_id
	GlobalSelected.current_selected_item_id = card_id
	%Inventory.add_child(new_dragged_scene)

func on_puzzle_group_complete(puzzle_group: int) -> void:
	print("puzzle group " + str(puzzle_group) + " complete")
	var new_win_scene: Node2D = win_scene.instantiate()
	add_child(new_win_scene)

extends Node2D

enum InventoryLayout{
	HORIZONTAL, VERTICAL
}

@onready var dragged_scene: PackedScene = preload("res://firefly-grove-puzzle-system/scenes/dragged_card.tscn")
@onready var win_scene: PackedScene = preload("res://firefly-grove-puzzle-system/scenes/win_scene.tscn")

@export var inventory_layout: int = InventoryLayout.HORIZONTAL

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Auto choose inventory layout based on screen size -
	# vertical screen -> horizontal layout
	# horizontal screen -> vertical layout
	
	match inventory_layout:
		InventoryLayout.HORIZONTAL:
			%HorizontalInventory.show()
			for child in %HorizontalInventorySlots.get_children():
				child.picked_up_card.connect(add_picked_up_card)
			%HorizontalRemoveWildlifeSlot.picked_up_card.connect(add_picked_up_card)
		InventoryLayout.VERTICAL:
			%VerticalInventory.show()
			for child in %VerticalInventorySlots.get_children():
				child.picked_up_card.connect(add_picked_up_card)
			%VerticalRemoveWildlifeSlot.picked_up_card.connect(add_picked_up_card)


## If a card has been picked up (signal from wildlife_card_slot.gd), 
## add the scene for a dragged card.
func add_picked_up_card(card_id : int) -> void:
	var new_dragged_scene = dragged_scene.instantiate()
	new_dragged_scene.wildlife_id = card_id
	GlobalSelected.current_selected_item_id = card_id
	if(inventory_layout == InventoryLayout.HORIZONTAL):
		%HorizontalInventory.add_child(new_dragged_scene)
	elif(inventory_layout == InventoryLayout.VERTICAL):
		%VerticalInventory.add_child(new_dragged_scene)

func on_puzzle_group_complete(puzzle_group: int) -> void:
	print("puzzle group " + str(puzzle_group) + " complete")
	var new_win_scene: Node2D = win_scene.instantiate()
	add_child(new_win_scene)

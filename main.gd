extends Node2D

@onready var dragged_scene = preload("res://firefly-grove-puzzle-system/scenes/dragged_card.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in %InventorySlots.get_children():
		child.picked_up_card.connect(add_picked_up_card)
	$Inventory/Panel/RemoveWildlifeSlot.picked_up_card.connect(add_picked_up_card)

## If a card has been picked up (signal from wildlife_slot), add the scene for a dragged card.
func add_picked_up_card(card_id : int) -> void:
	var new_dragged_scene = dragged_scene.instantiate()
	new_dragged_scene.wildlife_id = card_id
	GlobalSelected.current_selected_item_id = card_id
	%Inventory.add_child(new_dragged_scene)

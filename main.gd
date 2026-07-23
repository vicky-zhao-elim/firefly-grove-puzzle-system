extends Node2D

@onready var dragged_scene = preload("res://firefly-grove-puzzle-system/scenes/dragged_card.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in %InventorySlots.get_children():
		child.picked_up_card.connect(add_picked_up_card)

func add_picked_up_card(card_name : String) -> void:
	var new_dragged_scene = dragged_scene.instantiate()
	new_dragged_scene.wildlife_name = card_name
	GlobalSelected.current_selected_item = card_name
	%Inventory.add_child(new_dragged_scene)

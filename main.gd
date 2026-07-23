extends Node2D

@onready var dragged_scene = preload("res://firefly-grove-puzzle-system/scenes/dragged_card.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in %InventorySlots.get_children():
		child.picked_up_card.connect(add_picked_up_card)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_picked_up_card() -> void:
	var new_dragged_scene = dragged_scene.instantiate()
	add_child(new_dragged_scene)

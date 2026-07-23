extends Node2D

@export var wildlife_in_slot : String

var mouse_in_slot : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(mouse_in_slot > 0):
		GlobalSelected.is_hovering_on_placement_slot = true
		if(Input.is_action_just_released("click")):
			$temp_label.text = GlobalSelected.current_selected_item
	else:
		GlobalSelected.is_hovering_on_placement_slot = false


func _on_area_2d_mouse_entered() -> void:
	mouse_in_slot += 1


func _on_area_2d_mouse_exited() -> void:
	mouse_in_slot -= 1

extends Node2D

@export var wildlife_in_slot : String
@export var no_of_wildlife_in_slot : int
@export var current_sunlight : int # can be negative
@export var current_moisture : int # can be negative

var mouse_in_slot : int = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(mouse_in_slot > 0):
		GlobalSelected.is_hovering_on_placement_slot = true
		print("A")
		if(Input.is_action_just_released("click")):
			$temp_label.text = GlobalSelected.current_selected_item
	else:
		GlobalSelected.is_hovering_on_placement_slot = false

func update_visuals() -> void:
	pass

func _on_area_2d_mouse_entered() -> void:
	mouse_in_slot += 1


func _on_area_2d_mouse_exited() -> void:
	mouse_in_slot -= 1

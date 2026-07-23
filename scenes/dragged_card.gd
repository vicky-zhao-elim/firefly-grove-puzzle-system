extends Node2D

var prev_mouse_pos: Vector2 = Vector2.ZERO
const skew_speed := 0.005
const scale_speed := 0.05

func _ready() -> void:
	global_position = get_global_mouse_position()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(is_queued_for_deletion()): return
	
	if(GlobalSelected.is_hovering_on_placement_slot == true):
		scale.x = move_toward(scale.x, 1.1, scale_speed / 2)
		scale.y = move_toward(scale.y, 1.1, scale_speed / 2)
	else:
		scale.x = move_toward(scale.x, 1.0, scale_speed / 2)
		scale.y = move_toward(scale.y, 1.0, scale_speed / 2)
	
	if(Input.is_action_just_released("click")):
		# Do stuff
		queue_free()
	else:
		global_position = get_global_mouse_position()
		var direction_x : int = signf((global_position - prev_mouse_pos).x)
		var direction_y : int = signf((global_position - prev_mouse_pos).y)
		# Add pixel different to account for speed
		prev_mouse_pos = global_position
		skew = move_toward(skew, deg_to_rad(12) * direction_x, skew_speed)

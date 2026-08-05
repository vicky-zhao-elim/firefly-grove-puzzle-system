extends Node2D

var wildlife_id : int

var prev_mouse_pos: Vector2 = Vector2.ZERO
# Maybe make this a global
const skew_speed := 0.005
const scale_speed := 0.05
const rotation_speed := 1.5

var disabled_self : bool = false

func _ready() -> void:
	global_position = get_global_mouse_position()
	GlobalSelected.is_card_held = true
	$CardBackground/CardImage.texture = ItemData.all_items[wildlife_id][ItemData.SPRITE][0]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(is_queued_for_deletion()): return
	if(disabled_self == true): return
	
	# If hovering over a valid slot, do a small animation and decrease the opacity
	if(GlobalSelected.is_hovering_on_placement_slot == true):
		scale.x = move_toward(scale.x, 0.8, scale_speed / 2)
		scale.y = move_toward(scale.y, 0.8, scale_speed / 2)
		rotation_degrees = move_toward(rotation_degrees, 1, rotation_speed)
		modulate = Color(0.675, 0.675, 0.675, 0.75)
	# Else, return to normal
	else:
		scale.x = move_toward(scale.x, 1.0, scale_speed / 2)
		scale.y = move_toward(scale.y, 1.0, scale_speed / 2)
		rotation_degrees = move_toward(rotation_degrees, 0, rotation_speed)
		modulate = Color.WHITE
		
	# When the player lets go of the mouse, play an animation depending on where it was released
	if(Input.is_action_just_released("click")):
		# Prevent this scene from doing anything in process so it does not move after you release it,
		# but still plays the animation.
		disabled_self = true
		# Play a release animation if card is over a valid slot
		if(GlobalSelected.is_hovering_on_placement_slot == true):
			var tween = get_tree().create_tween()
			tween.tween_property(self, "scale", Vector2(1.005, 1.005), 0.05)
			# Gives a bit of time for the slot to check if is_card_held
			await tween.finished
			GlobalSelected.is_card_held = false
			tween = get_tree().create_tween()
			tween.tween_property(self, "scale", Vector2(0.5, 0.5), 0.15)
			tween.tween_callback(queue_free)
		else:
			GlobalSelected.is_card_held = false
			queue_free()
	# Movement animation if the card has not been released yet
	else:
		global_position = get_global_mouse_position()
		var x_pos_offset = (global_position - prev_mouse_pos).x 
		x_pos_offset /= 8
		clamp(x_pos_offset, -10, 10)
		var y_pos_offset = (global_position - prev_mouse_pos).y
		clamp(y_pos_offset, -90, 90)
		prev_mouse_pos = global_position
		skew = move_toward(skew, deg_to_rad(x_pos_offset), skew_speed)
		rotation_degrees = move_toward(rotation_degrees, y_pos_offset, rotation_speed)

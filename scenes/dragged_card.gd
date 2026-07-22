extends Node2D

func _ready() -> void:
	self.global_position = get_global_mouse_position()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_action_just_released("click")):
		# Do stuff
		#await get_tree().create_timer(0.5).timeout
		#
		queue_free()
	else:
		self.global_position = get_global_mouse_position()

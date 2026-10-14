extends Camera2D

const SPEED: float = 5

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_up"):
		position.y -= SPEED
	if Input.is_action_pressed("ui_down"):
		position.y += SPEED
	if Input.is_action_pressed("ui_left"):
		position.x -= SPEED
	if Input.is_action_pressed("ui_right"):
		position.x += SPEED

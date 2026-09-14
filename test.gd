@tool
extends Sprite2D

var pos: float = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		rotation_degrees += 90 * delta
		pos += 1
		position.x = pingpong(pos, 1000)
	else:
		hide()

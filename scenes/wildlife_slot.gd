extends Control

var is_mouse_in_slot : int = 0

@onready var dragged_scene = preload("res://firefly-grove-puzzle-system/scenes/dragged_card.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(is_mouse_in_slot == 1):
		if(Input.is_action_pressed("click")):
			var new_dragged_scene = dragged_scene.instantiate()
			get_parent().get_parent().get_parent().get_parent().get_parent().add_child(new_dragged_scene)


func _on_texture_rect_mouse_entered() -> void:
	is_mouse_in_slot += 1



func _on_texture_rect_mouse_exited() -> void:
	is_mouse_in_slot -= 1

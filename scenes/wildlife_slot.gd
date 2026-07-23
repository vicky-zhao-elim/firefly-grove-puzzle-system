extends Control

signal picked_up_card

@export var wildlife_name : String

var is_mouse_in_slot : int = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(is_mouse_in_slot == 1):
		self.modulate = Color(0.725, 0.725, 0.725, 1.0)
		if(Input.is_action_just_pressed("click")):
			picked_up_card.emit(wildlife_name)
	else:
		self.modulate = Color.WHITE


func _on_texture_rect_mouse_entered() -> void:
	is_mouse_in_slot += 1

func _on_texture_rect_mouse_exited() -> void:
	is_mouse_in_slot -= 1

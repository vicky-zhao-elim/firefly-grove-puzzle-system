extends Control

signal picked_up_card

var wildlife_id : int
@export var wildlife_name : String
@export var card_texture : Texture2D

var is_mouse_in_slot : int = 0

const rotation_speed := 1.5

func _ready() -> void:
	$TextureRect.texture = card_texture

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# If the mouse is on the card, play an animation to indicate this.
	if(is_mouse_in_slot == 1):
		self.modulate = Color(0.725, 0.725, 0.725, 1.0)
		$TextureRect.rotation_degrees = move_toward($TextureRect.rotation_degrees, -5, rotation_speed)
		if(Input.is_action_just_pressed("click")):
			picked_up_card.emit(wildlife_name, wildlife_id)
	# Else, reset to the normal values
	else:
		self.modulate = Color.WHITE
		$TextureRect.rotation_degrees = move_toward($TextureRect.rotation_degrees, 0, rotation_speed)


func _on_texture_rect_mouse_entered() -> void:
	is_mouse_in_slot += 1

func _on_texture_rect_mouse_exited() -> void:
	is_mouse_in_slot -= 1

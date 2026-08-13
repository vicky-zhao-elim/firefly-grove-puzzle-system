extends Control

## Signal emitted from wildlife_card_slot.gd when the mouse is in the slot
## and is clicked. Recieved by main.gd add_picked_up_card(card_id).
signal picked_up_card

@export var wildlife_id: int
@export var card_texture: Texture2D

var is_mouse_in_slot: int = 0

const rotation_speed := 1.5


func _ready() -> void:
	$TextureRectImage.texture = card_texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# If the mouse is on the card, play an animation to indicate this.
	if(is_mouse_in_slot == 1):
		self.modulate = Color(0.725, 0.725, 0.725, 1.0)
		$TextureRectBackground.rotation_degrees = move_toward($TextureRectBackground.rotation_degrees, -5, rotation_speed)
		$TextureRectImage.rotation_degrees = move_toward($TextureRectImage.rotation_degrees, -5, rotation_speed)
		if(Input.is_action_just_pressed("click")):
			picked_up_card.emit(wildlife_id)
	# Else, reset to the normal values
	else:
		self.modulate = Color.WHITE
		$TextureRectBackground.rotation_degrees = move_toward($TextureRectBackground.rotation_degrees, 0, rotation_speed)
		$TextureRectImage.rotation_degrees = move_toward($TextureRectImage.rotation_degrees, 0, rotation_speed)


## Function that runs when the mouse enters the card.
func _on_texture_rect_mouse_entered() -> void:
	is_mouse_in_slot += 1


## Function that runs when the mouse exits the card.
func _on_texture_rect_mouse_exited() -> void:
	is_mouse_in_slot -= 1

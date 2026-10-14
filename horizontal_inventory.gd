extends CanvasLayer

const TWEEN_TIME: float = 0.5

var card_scene: PackedScene = preload("res://firefly-grove-puzzle-system/scenes/wildlife_card_slot.tscn")

var screen_size: Vector2

func _ready() -> void:
	# Change window size to test
	
	screen_size = get_viewport().get_visible_rect().size
	
	$Panel.position.y = screen_size.y - $Panel.size.y
	
	%HorizontalCoveringPanel.size.y = $Panel.size.y
	%HorizontalCoveringPanel.global_position.y = $Panel.position.y 
	
	#$OpenButton.position.y = screen_size.y - $OpenButton.size.y
	$OpenButton.global_position = $Panel/HorizontalCoveringPanel/CloseButton.global_position
	
	$Panel/ScrollContainer.custom_maximum_size.x = screen_size.x - $Panel/ScrollContainer.position.x
	
	for child in %InventorySlots.get_children():
		child.queue_free()
		
	for i in range(ItemData.all_items.size()):
		var item : Array = ItemData.all_items[i]
		var new_card = card_scene.instantiate()
		new_card.wildlife_id = i
		new_card.card_texture = item[ItemData.SPRITE][0]
		if(item[ItemData.IS_UNLOCKED]):
			%InventorySlots.add_child(new_card)

## Function that runs when the open button is pressed.
func _on_open_button_pressed() -> void:
	$Panel.show()
	var tween = get_tree().create_tween()
	tween.tween_property($Panel, "position:y", screen_size.y - $Panel.size.y, TWEEN_TIME)
	tween.parallel().tween_property($Panel, "modulate", Color(1.0, 1.0, 1.0, 1.0), TWEEN_TIME / 2)
	await tween.finished
	$OpenButton.hide()


## Function that runs when the close button is pressed.
func _on_close_button_pressed() -> void:
	$OpenButton.show()
	$OpenButton.disabled = true
	var tween = get_tree().create_tween()
	tween.tween_property($Panel, "position:y", 2000, TWEEN_TIME)
	tween.parallel().tween_property($Panel, "modulate", Color(0.0, 0.0, 0.0, 0.0), TWEEN_TIME / 2)
	await tween.finished
	$Panel.hide()
	$OpenButton.disabled = false

extends CanvasLayer

var card_scene: PackedScene = preload("res://firefly-grove-puzzle-system/scenes/wildlife_card_slot.tscn")

var screen_size: Vector2

func _ready() -> void:
	# Change window size to test
	
	screen_size = get_viewport().get_visible_rect().size
	
	$Panel.position.y = screen_size.y - $Panel.size.y
	
	%HorizontalCoveringPanel.size.y = $Panel.size.y
	%HorizontalCoveringPanel.global_position.y = $Panel.position.y 
	
	$OpenButton.position.y = screen_size.y - $OpenButton.size.y
	
	$Panel/ScrollContainer.custom_maximum_size.x = screen_size.x - $Panel/ScrollContainer.position.x
	
	for child in %HorizontalInventorySlots.get_children():
		child.queue_free()
		
	for i in range(ItemData.all_items.size()):
		var item : Array = ItemData.all_items[i]
		var new_card = card_scene.instantiate()
		new_card.wildlife_id = i
		new_card.card_texture = item[ItemData.SPRITE][0]
		if(item[ItemData.IS_UNLOCKED]):
			%HorizontalInventorySlots.add_child(new_card)


var tween_time: float = 0.5

## Function that runs when the open button is pressed.
func _on_open_button_pressed() -> void:
	$Panel.show()
	var tween = get_tree().create_tween()
	tween.tween_property($Panel, "position:y", screen_size.y - $Panel.size.y, tween_time)
	tween.parallel().tween_property($Panel, "modulate", Color(1.0, 1.0, 1.0, 1.0), tween_time / 2)
	await tween.finished
	$OpenButton.hide()


## Function that runs when the close button is pressed.
func _on_close_button_pressed() -> void:
	$OpenButton.show()
	var tween = get_tree().create_tween()
	tween.tween_property($Panel, "position:y", 2000, tween_time)
	tween.parallel().tween_property($Panel, "modulate", Color(0.0, 0.0, 0.0, 0.0), tween_time / 2)
	await tween.finished
	$Panel.hide()

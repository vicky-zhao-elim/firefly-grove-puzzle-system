extends CanvasLayer

var card_scene: PackedScene = preload("res://firefly-grove-puzzle-system/scenes/wildlife_card_slot.tscn")


func _ready() -> void:
	# Change window size to test
	
	var screen_size: Vector2 = get_viewport().get_visible_rect().size
	
	$Panel.size.y = screen_size.y
	$OpenButton.position.y = screen_size.y - $OpenButton.size.y
	
	%VerticalCoveringPanel.global_position.y = screen_size.y - %VerticalCoveringPanel.size.y 
	
	$Panel/ScrollContainer.position.x = 25
	
	$OpenButton.position.y = screen_size.y - $OpenButton.size.y
	
	$Panel/ScrollContainer.position.x = $Panel/VerticalCoveringPanel/CloseButton.position.x + ($Panel/ScrollContainer.position.x / 2)
	
	#$Panel/ScrollContainer.custom_maximum_size.y = screen_size.y - $Panel/ScrollContainer.position.x
	
	for child in %VerticalInventorySlots.get_children():
		child.queue_free()
		
	for i in range(ItemData.all_items.size()):
		var item : Array = ItemData.all_items[i]
		var new_card = card_scene.instantiate()
		new_card.wildlife_id = i
		new_card.card_texture = item[ItemData.SPRITE][0]
		if(item[ItemData.IS_UNLOCKED]):
			%VerticalInventorySlots.add_child(new_card)


## Function that runs when the open button is pressed.
func _on_open_button_pressed() -> void:
	$Panel.show()
	var tween = get_tree().create_tween()
	tween.tween_property($Panel, "position:x", 0, 0.2)
	tween.parallel().tween_property($Panel, "modulate", Color(1.0, 1.0, 1.0, 1.0), 0.2)
	await tween.finished
	$OpenButton.hide()


## Function that runs when the close button is pressed.
func _on_close_button_pressed() -> void:
	$OpenButton.show()
	var tween = get_tree().create_tween()
	tween.tween_property($Panel, "position:x", -300, 0.2)
	tween.parallel().tween_property($Panel, "modulate", Color(0.0, 0.0, 0.0, 0.0), 0.2)
	await tween.finished
	$Panel.hide()

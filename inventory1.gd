extends CanvasLayer

var card_scene : PackedScene = preload("res://firefly-grove-puzzle-system/scenes/wildlife_card_slot.tscn")

func _ready() -> void:
	
	# Change window size to test
	
	var screen_size : Vector2 = get_viewport().get_visible_rect().size
	%Panel.position.y = screen_size.y - %Panel.size.y
	
	$CoveringPanel.size.y = %Panel.size.y
	$CoveringPanel.position.y = %Panel.position.y
	
	##
	
	for child in %InventorySlots.get_children():
		child.queue_free()
		
	for item : Array in ItemData.all_items:
		var new_card = card_scene.instantiate()
		new_card.wildlife_name = item[ItemData.NAME]
		new_card.card_texture = item[ItemData.SPRITE]
		if(item[ItemData.IS_UNLOCKED]):
			%InventorySlots.add_child(new_card)
		

func _on_button_pressed() -> void:
	$Panel.show()
	%CloseButton.show()
	$CoveringPanel.show()
	$OpenButton.hide()


func _on_close_button_pressed() -> void:
	$Panel.hide()
	%CloseButton.hide()
	$CoveringPanel.hide()
	$OpenButton.show()

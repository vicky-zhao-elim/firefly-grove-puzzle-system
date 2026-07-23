extends CanvasLayer

func _on_button_pressed() -> void:
	$Panel.show()
	$OpenButton.hide()


func _on_close_button_pressed() -> void:
	$Panel.hide()
	$OpenButton.show()

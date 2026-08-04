extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var is_correct : bool = true
	for child in get_children():
		if(child.is_slot_correct == false):
			is_correct = false
			
	if(is_correct):
		print("All correct")

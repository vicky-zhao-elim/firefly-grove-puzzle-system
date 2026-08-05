extends Node2D

var is_first_correct : bool = true

## Continously check if all of the slots belonging to this node are correct.
## If so, trigger the end of the puzzle and lock all slots from further modification.
func _process(_delta: float) -> void:
	var is_correct : bool = true
	for child in get_children():
		if(child.is_slot_correct == false):
			is_correct = false
			
	if(is_correct and is_first_correct):
		print("All correct")
		is_first_correct = false
		for child in get_children():
			child.is_slot_locked = true
			

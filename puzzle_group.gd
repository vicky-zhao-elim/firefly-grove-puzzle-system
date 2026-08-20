extends Node2D

## Signal emitted from puzzle_group.gd when all children slots are correct.
## Recieved by ??
signal puzzle_group_complete

@export var puzzle_id: int

## Has the group been correct for the first time yet?
var _is_first_correct: bool = true

## Continously check if all of the slots belonging to this node are correct.
## If so, trigger the end of the puzzle and lock all slots from further modification.
func _process(_delta: float) -> void:
	var _is_correct : bool = true
	for child in get_children():
		if(child.is_slot_correct == false):
			_is_correct = false
			
	if(_is_correct and _is_first_correct):
		print("All correct")
		_is_first_correct = false
		puzzle_group_complete.emit(puzzle_id)
		for child in get_children():
			child.is_slot_locked = true
			

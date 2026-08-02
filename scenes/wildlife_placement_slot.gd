extends Node2D

## The slots that this slot can affect
@export var neighbours : Array[Node2D]

var wildlife_id : int
@export var wildlife_in_slot : String = ""
@export var no_of_wildlife_in_slot : int
@export var current_sunlight : int = 0 # can be negative
@export var current_moisture : int = 0 # can be negative

var mouse_in_slot : int = 0
var dropped_wildlife_type : String
var dropped_wildlife_id : int

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(mouse_in_slot > 0):
		if(Input.is_action_just_released("click")):
			dropped_wildlife_type = GlobalSelected.current_selected_item
			dropped_wildlife_id = GlobalSelected.current_selected_item_id
			update_slot_data()
			update_visuals()

## Update it based on the wildlife type, number, and updated sun+water
func update_visuals() -> void:
	self.modulate = Color(1, 1 - float(current_moisture) / 10.0, 1 - float(current_sunlight) / 10.0)
	
	if(no_of_wildlife_in_slot == 0):
		$temp_label.text = "empty " + str(no_of_wildlife_in_slot)
		$ItemSprite.texture = null
	else:
		$temp_label.text = wildlife_in_slot + " " + str(no_of_wildlife_in_slot)
		$ItemSprite.texture = ItemData.all_items[wildlife_id][ItemData.SPRITE][no_of_wildlife_in_slot - 1]

## Resets the count to 1 if the card type is different, otherwise add one to the count of wildlife in the slot
func update_slot_data() -> void:
	if(dropped_wildlife_type == "Remove"):
		if(no_of_wildlife_in_slot != 0):
			revert_slot_effect(1)
		return
	if(wildlife_in_slot != dropped_wildlife_type):
		# Reverse the prior plant's effects
		revert_slot_effect(no_of_wildlife_in_slot)
		
		wildlife_in_slot = dropped_wildlife_type
		wildlife_id = dropped_wildlife_id
	no_of_wildlife_in_slot += 1
	if(no_of_wildlife_in_slot > 4):
		no_of_wildlife_in_slot = 4
	else:
		for neighbour in neighbours:
			update_neighbour_data(neighbour, "add", 1)
	$temp_label.text = wildlife_in_slot + " " + str(no_of_wildlife_in_slot)

## Reverts the slot effect a certain number of times, calling the function update_neighbour_data to change the neighbours.
func revert_slot_effect(number_removed : int) -> void:
	no_of_wildlife_in_slot -= number_removed
	for neighbour in neighbours:
		update_neighbour_data(neighbour, "subtract", number_removed)

## Based on the originating item type in the slot, change the neighbouring slot's sun or water by a certain amount.
## Then, calls the function to update the visuals of the slots so they update immediately.
func update_neighbour_data(this_neighbour_node : Node2D, operator : String, difference : int) -> void:
	if(this_neighbour_node == self):
		return
		
	if(ItemData.all_items[wildlife_id][ItemData.HAS_EFFECT]):
		var effect: Array = ItemData.all_items[wildlife_id][ItemData.EFFECT]
		var effect_type: String = effect[0]
		var effect_strength: int = effect[1]
		if(operator == "add"):
			if(effect_type == "sun"):
				this_neighbour_node.current_sunlight += effect_strength * difference
			elif(effect_type == "water"):
				this_neighbour_node.current_moisture += effect_strength * difference
			else:
				printerr("Invalid effect type")
		elif(operator == "subtract"):
			if(effect_type == "sun"):
				this_neighbour_node.current_sunlight -= effect_strength * difference
			elif(effect_type == "water"):
				this_neighbour_node.current_moisture -= effect_strength * difference
			else:
				printerr("Invalid effect type")
		else:
			printerr("Invalid operator")
	else:
		pass
		#print("no effect")
	this_neighbour_node.update_visuals()

func _on_area_2d_mouse_entered() -> void:
	mouse_in_slot += 1
	GlobalSelected.is_hovering_on_placement_slot = true

func _on_area_2d_mouse_exited() -> void:
	mouse_in_slot -= 1
	GlobalSelected.is_hovering_on_placement_slot = false

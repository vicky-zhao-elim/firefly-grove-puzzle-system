extends Node2D

@export var slot_starting_values: SlotData

@export var is_slot_locked: bool = false

@export var slot_finish_condition: SlotData

## The slots that this slot can affect
@export var neighbours: Array[Node2D]

var wildlife_id: int
var no_of_wildlife_in_slot: int
var current_sunlight: int = 0 # can be negative
var current_moisture: int = 0 # can be negative

var mouse_in_slot: int = 0
var dropped_wildlife_id: int

var is_slot_correct: bool = false

const original_scale_of_item := 0.2


func _ready() -> void:
	wildlife_id = slot_starting_values.id
	no_of_wildlife_in_slot = slot_starting_values.number_of_items
	current_sunlight = slot_starting_values.sunlight
	current_moisture = slot_starting_values.moisture
	
	if(is_slot_locked == true):
		$GroundSprite.hide()
	
	update_visuals()
	check_if_slot_is_correct()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(mouse_in_slot > 0 and is_slot_locked == false):
		if(Input.is_action_just_released("click") && GlobalSelected.is_card_held):
			dropped_wildlife_id = GlobalSelected.current_selected_item_id
			update_slot_data()
			update_visuals()
			do_bounce_animation()
			check_if_slot_is_correct()


## Update it based on the wildlife type, number, and updated sun+water
func update_visuals() -> void:
	# Animation transition colour
	var tween = get_tree().create_tween()
	var new_colour_modulate: Color = Color(1, 1 - float(current_moisture) / 80.0, 1 - float(current_sunlight) / 80.0)
	tween.tween_property(self, "modulate", new_colour_modulate, 0.3)
	
	if(no_of_wildlife_in_slot == 0):
		$temp_label.text = "empty " + str(no_of_wildlife_in_slot)
		$ItemSprite.texture = null
	else:
		$temp_label.text = ItemData.all_items[wildlife_id][ItemData.NAME] + " " + str(no_of_wildlife_in_slot)
		$ItemSprite.texture = ItemData.all_items[wildlife_id][ItemData.SPRITE][no_of_wildlife_in_slot - 1]
		

func do_bounce_animation() -> void:
	# Bounce animation when visuals change
	var tween = get_tree().create_tween()
	tween.tween_property($ItemSprite, "scale:y", 0.17, 0.1)
	tween.parallel().tween_property($ItemSprite, "scale:x", 0.23, 0.1)
	tween.tween_property($ItemSprite, "scale:y", original_scale_of_item, 0.1)
	tween.parallel().tween_property($ItemSprite, "scale:x", original_scale_of_item, 0.1)


func fade_ground_out() -> void:
	var time_to_fade: float = 5
	var tween = get_tree().create_tween()
	tween.tween_property($GroundSprite, "modulate:a", 0, time_to_fade)


## Resets the count to 1 if the card type is different, otherwise add one to the count of wildlife in the slot
func update_slot_data() -> void:
	# An ID of -1 is not normally possible, so it is from the remove card
	if(dropped_wildlife_id == -1):
		if(no_of_wildlife_in_slot != 0):
			revert_slot_effect(1)
		return
	if(wildlife_id != dropped_wildlife_id):
		# Reverse the prior plant's effects
		revert_slot_effect(no_of_wildlife_in_slot)
		
		wildlife_id = dropped_wildlife_id
	no_of_wildlife_in_slot += 1
	if(no_of_wildlife_in_slot > 4):
		no_of_wildlife_in_slot = 4
	else:
		for neighbour in neighbours:
			update_neighbour_data(neighbour, "add", 1)
	update_debug_labels()


## Reverts the slot effect a certain number of times, calling the function update_neighbour_data to change the neighbours.
func revert_slot_effect(number_removed: int) -> void:
	no_of_wildlife_in_slot -= number_removed
	for neighbour in neighbours:
		update_neighbour_data(neighbour, "subtract", number_removed)


## Based on the originating item type in the slot, change the neighbouring slot's sun or water by a certain amount.
## Then, calls the function to update the visuals of the slots so they update immediately.
func update_neighbour_data(this_neighbour_node: Node2D, operator: String, difference: int) -> void:
	# This makes it so the slot will not affect itself, only its neighbours
	if(this_neighbour_node == self):
		return
		
	var operator_multiplier: int
	if(operator == "add"):
		operator_multiplier = 1
	elif(operator == "subtract"):
		operator_multiplier = -1
	else:
		printerr("Invalid operator for update data function")
		
	if(ItemData.all_items[wildlife_id][ItemData.EFFECT].is_empty() == false):
		var effects: Dictionary = ItemData.all_items[wildlife_id][ItemData.EFFECT]
		for effect_type: String in effects.keys():
			if(effect_type == "sun"):
				this_neighbour_node.current_sunlight += effects[effect_type] * difference * operator_multiplier
			elif(effect_type == "water"):
				this_neighbour_node.current_moisture += effects[effect_type] * difference * operator_multiplier
			else:
				printerr("Invalid effect type")
		
	else:
		pass
		#print("no effect")
	this_neighbour_node.update_visuals()
	this_neighbour_node.update_debug_labels()
	this_neighbour_node.check_if_slot_is_correct()


## Updates the debug labels to represent certain values. This will be hidden in the final.
func update_debug_labels() -> void:
	$temp_label.text = ItemData.all_items[wildlife_id][ItemData.NAME] + " " + str(no_of_wildlife_in_slot)
	$sun_value_label.text = str(current_sunlight)


## Checks each value one by one to see if its the same as the correct value or not
func check_if_slot_is_correct() -> void:
	if(slot_finish_condition.id != -1):
		if(wildlife_id != slot_finish_condition.id):
			is_slot_correct = false
			return
	if(slot_finish_condition.number_of_items != -1):
		if(no_of_wildlife_in_slot != slot_finish_condition.number_of_items):
			is_slot_correct = false
			return
	if(slot_finish_condition.sunlight != -1):
		if(current_sunlight != slot_finish_condition.sunlight):
			is_slot_correct = false
			return
	if(slot_finish_condition.moisture != -1):
		if(current_moisture != slot_finish_condition.moisture):
			is_slot_correct = false
			return
			
	# If it passes everything without returning, it is correct
	is_slot_correct = true


## Function that runs when the mouse enters the area.
func _on_area_2d_mouse_entered() -> void:
	mouse_in_slot += 1
	if(is_slot_locked == false):
		GlobalSelected.is_hovering_on_placement_slot = true


## Function that runs when the mouse exits the area.
func _on_area_2d_mouse_exited() -> void:
	mouse_in_slot -= 1
	GlobalSelected.is_hovering_on_placement_slot = false

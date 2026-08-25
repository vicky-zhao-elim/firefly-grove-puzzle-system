extends Node

## The id of the currently picked up card's item
var current_selected_item_id: int
## Boolean that stores whether the player is holding a card or not
var is_card_held: bool = false
## Boolean that stores whether the player's mouse is over a placement slot
var is_hovering_on_placement_slot: bool = false

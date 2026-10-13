extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Positioning
	var screen_size = get_viewport().get_visible_rect().size
	self.position = Vector2(screen_size.x / 2, screen_size.y / 2 - ($Label.size.y * 2))
	self.modulate = Color(1.0, 1.0, 1.0, 0.0) # Make self transparent
	
	var tween: Tween
	# Fade in
	tween = create_tween()
	tween.tween_property(self, "modulate:a", 1, 1)
	await tween.finished

	var chosen_texture: Resource = ItemData.all_items[randi_range(0, ItemData.all_items.size() - 1)][ItemData.SPRITE][0]
	$ParticleEffectLeft.texture = chosen_texture
	$ParticleEffectRight.texture = chosen_texture
	
	await get_tree().create_timer(4).timeout
	# Fade out
	tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, 2)
	await tween.finished
	queue_free()

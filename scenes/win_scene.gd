extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var chosen_texture: Resource = ItemData.all_items[randi_range(0, ItemData.all_items.size() - 1)][ItemData.SPRITE][0]
	$ParticleEffectLeft.texture = chosen_texture
	$ParticleEffectRight.texture = chosen_texture
	await get_tree().create_timer(4).timeout
	var tween: Tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, 2)
	await tween.finished
	queue_free()

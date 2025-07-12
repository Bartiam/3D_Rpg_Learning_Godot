extends RayCast3D



func deal_damage(damage: float, crit_chance: float) -> void:
	if not is_colliding():
		return
	
	var is_critical: bool = randf() <= crit_chance
	var collider: Object = get_collider()
	
	if collider is Enemy:
		collider.health_component.take_damage(damage, is_critical)
		add_exception(collider)

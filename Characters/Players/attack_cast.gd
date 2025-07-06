extends RayCast3D



func deal_damage() -> void:
	if not is_colliding():
		return
	
	var collider: Object = get_collider()
	
	if collider is Enemy:
		collider.health_component.take_damage(25.0)
	
	add_exception(collider)

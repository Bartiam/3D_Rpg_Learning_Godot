extends Node

class_name HealthComponent

@export var body: PhysicsBody3D

signal defeat()
signal health_changed()

var max_health: float = 100.0
var current_health: float:
	set(value):
		current_health = max(value, 0.0)
		if current_health == 0.0:
			defeat.emit()
		health_changed.emit()

func update_max_health(max_hp_in: float) -> void:
	max_health = max_hp_in
	current_health = max_health
	printt("Health Changed: ", max_health, current_health)

func take_damage(damage_in: float, is_critical: bool) -> void:
	var damage = damage_in
	var color_damage_number: Color = Color.WHITE
	
	if is_critical:
		damage *= 2
		color_damage_number = Color.RED
		print("Critical heat")
	
	current_health -= damage
	
	VfxManager.spawn_damage_number(damage, color_damage_number, body.global_position + Vector3(0.0, 0.5, 0.0))



func _ready() -> void:
	pass

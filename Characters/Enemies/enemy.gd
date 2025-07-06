extends CharacterBody3D
class_name Enemy

@export var max_health: float = 100.0

@onready var rig: Node3D = $Rig
@onready var health_component: HealthComponent = $HealthComponent
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var player_detecter: ShapeCast3D = $PlayerDetecter

func _ready() -> void:
	rig.set_active_mesh(
		rig.villiger_meshes.pick_random()
	)
	
	health_component.update_max_health(max_health)


func _on_health_component_defeat() -> void:
	rig.travel("Defeat")
	collision_shape_3d.disabled = true
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	if rig.is_idle():
		check_for_attacks()

func check_for_attacks() -> void:
	for collision_id in player_detecter.get_collision_count():
		var collider = player_detecter.get_collider(collision_id)
		print(collider)

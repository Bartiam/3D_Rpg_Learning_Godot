extends CharacterBody3D

@export_category("Character Specifications")
@export var MovementSpeed: float = 5
@export var JumpVelocity: float = 5

var Gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta: float) -> void:
	# add gravity to the character
	if not is_on_floor():
		velocity.y -= Gravity * delta
	
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JumpVelocity
	
	var InputDir: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var Direction: Vector3 = (transform.basis * Vector3(InputDir.x, 0, InputDir.y)).normalized()
	
	if (Direction):
		velocity.x = Direction.x * MovementSpeed
		velocity.y = Direction.y * MovementSpeed
	else:
		velocity.x = move_toward(velocity.x, 0, MovementSpeed)
		velocity.z = move_toward(velocity.z, 0, MovementSpeed)
	
	move_and_slide()

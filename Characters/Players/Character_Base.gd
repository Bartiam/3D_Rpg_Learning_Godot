extends CharacterBody3D

# Variables #
@export_category("Character Specifications")
@export var MovementSpeed: float = 0.0
@export var JumpVelocity: float = 0.0
@export var MouseSensitivity: float = 0.05
@export var MinBoundary: float = -60.0
@export var MaxBoundary: float = 10.0
@export var AnimationDecay: float = 20.0

var Gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

# Stores the x/y directions the player is trying to look in
var LookingCharacter: Vector2 = Vector2.ZERO

@onready var HorisontalPivot: Node3D = $HorisontalPivot
@onready var VerticalPivot: Node3D = $HorisontalPivot/VerticalPivot
@onready var RigPivot: Node3D = $RigPivot
@onready var rig: Node3D = $RigPivot/Rig
# Variables #

# Functions #
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	



func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			LookingCharacter = -event.relative * MouseSensitivity



func _physics_process(delta: float) -> void:
	# add gravity to the character
	if not is_on_floor():
		velocity.y -= Gravity * delta
	
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JumpVelocity
	
	var Direction: Vector3 = GetMovementDirections()
	rig.UpdateAnimationTree(Direction)
	
	if (Direction):
		velocity.x = Direction.x * MovementSpeed
		velocity.z = Direction.z * MovementSpeed
		LookTowardDirection(Direction, delta)
	else:
		velocity.x = move_toward(velocity.x, 0, MovementSpeed)
		velocity.z = move_toward(velocity.z, 0, MovementSpeed)
	
	frame_camera_rotation(delta)
	move_and_slide()



func GetMovementDirections() -> Vector3:
	var InputDir: Vector2 = Input.get_vector("Move_Left", "Move_Right", "Move_Forward", "Move_Backward")
	var InputVector: Vector3 = Vector3(InputDir.x, 0, InputDir.y).normalized()
	return HorisontalPivot.global_transform.basis * InputVector



func frame_camera_rotation(DeltaTime: float) -> void:
	HorisontalPivot.rotate_y(LookingCharacter.x * MouseSensitivity)
	VerticalPivot.rotate_x(LookingCharacter.y * MouseSensitivity)
	
	VerticalPivot.rotation.x = clampf(
		VerticalPivot.rotation.x,
		 deg_to_rad(MinBoundary),
		 deg_to_rad(MaxBoundary))
	
	$SpringArm3D.global_transform = VerticalPivot.global_transform
	LookingCharacter = Vector2.ZERO



func LookTowardDirection(Direction: Vector3, DeltaTime: float) -> void:
	var TargetTransform: = RigPivot.global_transform.looking_at(
		RigPivot.global_position + Direction, Vector3.UP, true
	)
	RigPivot.global_transform = RigPivot.global_transform.interpolate_with(
		TargetTransform, 1 - exp(-AnimationDecay * DeltaTime)
	)

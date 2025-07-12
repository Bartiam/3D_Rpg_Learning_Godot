extends Node3D

@export var player: Player

@onready var timer: Timer = $Timer

var direction: Vector3 = Vector3.ZERO

func _unhandled_input(event: InputEvent) -> void:
	
	if not timer.is_stopped():
		return;
	
	if event.is_action_pressed("Dash_Action"):
		print("Dash button pressed")
		direction = player.GetMovementDirection()
		
		if not direction.is_zero_approx():
			print("We can dash")
			timer.start(1.0)

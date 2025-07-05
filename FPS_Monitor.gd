extends ColorRect

func _process(delta: float) -> void:
	$FPS_Counter.text = str(Engine.get_frames_per_second())

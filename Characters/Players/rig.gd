extends Node3D

@onready var animation_tree: AnimationTree = $AnimationTree

var BlendSpaceMovement_Path: String = "parameters/Movement/blend_position"


func UpdateAnimationTree(Direction: Vector3) -> void:
	if Direction.is_zero_approx():
		animation_tree[BlendSpaceMovement_Path] = -1.0
	else:
		animation_tree[BlendSpaceMovement_Path] = 1.0

extends Control

@onready var level_label: Label = %LevelLabel
@onready var hp_bar: ProgressBar = %HPBar


@export var player: Player

func update_stats_display() -> void:
	level_label.text = str(player.stats.level)
	hp_bar.max_value = player.stats.percentage_level_up_boundary()

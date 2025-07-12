extends Resource

class_name CharacterStats

class Ability:
	var min_modifier: float
	var max_modifier: float
	
	var ability_score: int = 25:
		set(value):
			ability_score = clamp(value, 0, 100)
	
	func _init(min: float, max: float) -> void:
		min_modifier = min
		max_modifier = max
	
	func percentile_lerp(min_bound: float, max_bound: float) -> float:
		return lerp(min_bound, max_bound, ability_score / 100.0)
	
	func get_modifire() -> float:
		return percentile_lerp(min_modifier, max_modifier)
	
	func increace_level() -> void:
		ability_score += randi_range(2, 5)

var level: int = 0
var hp: float = 0.0

# Damage bonus on attack
var strength := Ability.new(2.0, 12.0)
# Movement speed in m/s
var speed := Ability.new(3.0, 7.0)
# HP bonus per level
var endurance := Ability.new(5.0, 25.0)
# Crit chance
var agility := Ability.new(0.05, 0.25)



func get_base_speed() -> float:
	return speed.get_modifire()

func get_base_strength() -> float:
	return speed.get_modifire()

func get_base_agility() -> float:
	return agility.get_modifire()

func level_up() -> void:
	level += 1
	strength.increace_level()
	speed.increace_level()
	endurance.increace_level()
	agility.increace_level()
	
	printt(
		strength.ability_score,
		 agility.ability_score,
	 	speed.ability_score,
	 	endurance.ability_score)

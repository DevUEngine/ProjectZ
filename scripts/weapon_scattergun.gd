class_name WeaponScattergun
extends Weapon

const _PROJECTILE = preload("res://scenes/projectile.tscn")

func _ready() -> void:
	damage = 7
	cooldown = 1.0
	range = 100.0
	super._ready()

func _fire(target_position: Vector2, from_position: Vector2) -> void:
	var dir = (target_position - from_position).normalized()
	for offset in [-0.3, 0.0, 0.3]:
		var pellet_dir = dir.rotated(offset)
		var pellet = _PROJECTILE.instantiate()
		pellet.global_position = from_position
		pellet.init(pellet_dir, 400.0, damage)
		get_tree().current_scene.add_child(pellet)

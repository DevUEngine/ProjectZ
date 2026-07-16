class_name WeaponPlasmaPistol
extends Weapon

const _PROJECTILE = preload("res://scenes/projectile.tscn")

func _ready() -> void:
	damage = 10
	cooldown = 0.5
	range = 200.0
	super._ready()

func _fire(target_position: Vector2, from_position: Vector2) -> void:
	var dir = (target_position - from_position).normalized()
	var projectile = _PROJECTILE.instantiate()
	projectile.global_position = from_position
	projectile.init(dir, 500.0, damage)
	get_tree().current_scene.add_child(projectile)

class_name WeaponNanoSwarm
extends Weapon

const _PROJECTILE = preload("res://scenes/projectile.tscn")

func _ready() -> void:
	damage = 3
	cooldown = 0.5
	range = 180.0
	super._ready()

func _fire(target_position: Vector2, from_position: Vector2) -> void:
	var target = _find_nearest_enemy(from_position)
	var dir = (target_position - from_position).normalized()
	var projectile = _PROJECTILE.instantiate()
	projectile.global_position = from_position
	if target:
		projectile.init_homing(target, 300.0, damage, 8.0)
	else:
		projectile.init(dir, 300.0, damage)
	get_tree().current_scene.add_child(projectile)

func _find_nearest_enemy(from: Vector2) -> Node2D:
	var space = get_world_2d().direct_space_state
	var query = PhysicsShapeQueryParameters2D.new()
	var circle = CircleShape2D.new()
	circle.radius = range
	query.shape = circle
	query.transform = Transform2D(0, from)
	query.collision_mask = 2
	query.collide_with_bodies = true
	var results = space.intersect_shape(query, 64)
	var nearest: Node2D = null
	var min_dist: float = range
	for result in results:
		var enemy = result.collider
		var dist = enemy.global_position.distance_to(from)
		if dist < min_dist:
			min_dist = dist
			nearest = enemy
	return nearest

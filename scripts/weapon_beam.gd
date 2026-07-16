class_name WeaponBeam
extends Weapon

func _ready() -> void:
	damage = 25
	cooldown = 1.5
	range = 300.0
	super._ready()

func _fire(target_position: Vector2, from_position: Vector2) -> void:
	var dir = (target_position - from_position).normalized()
	var space = get_world_2d().direct_space_state
	var query = PhysicsShapeQueryParameters2D.new()
	var circle = CircleShape2D.new()
	circle.radius = range
	query.shape = circle
	query.transform = Transform2D(0, from_position)
	query.collision_mask = 2
	query.collide_with_bodies = true
	var results = space.intersect_shape(query, 64)
	var hits: Array[Node2D] = []
	for result in results:
		var enemy = result.collider
		var enemy_dir = (enemy.global_position - from_position).normalized()
		if enemy_dir.dot(dir) > 0.95:
			hits.append(enemy)
	hits.sort_custom(func(a, b): return from_position.distance_to(a.global_position) < from_position.distance_to(b.global_position))
	for enemy in hits.slice(0, 5):
		enemy.take_damage(damage, dir)

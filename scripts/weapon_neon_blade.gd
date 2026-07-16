class_name WeaponNeonBlade
extends Weapon

func _ready() -> void:
	damage = 15
	cooldown = 1.0
	range = 40.0
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
	var results = space.intersect_shape(query, 32)
	for result in results:
		var enemy = result.collider
		if not enemy.has_method("take_damage"):
			continue
		var enemy_dir = (enemy.global_position - from_position).normalized()
		if enemy_dir.dot(dir) > 0.5:
			enemy.take_damage(damage, enemy_dir)

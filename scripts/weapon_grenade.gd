class_name WeaponGrenade
extends Weapon

func _ready() -> void:
	damage = 40
	cooldown = 2.0
	range = 120.0
	super._ready()

func _fire(target_position: Vector2, from_position: Vector2) -> void:
	var grenade = Node2D.new()
	grenade.global_position = target_position
	get_tree().current_scene.add_child(grenade)
	var sprite = Sprite2D.new()
	sprite.texture = load("res://assets/sprites/projectiles/grenade.png")
	grenade.add_child(sprite)
	var timer = Timer.new()
	timer.wait_time = 1.0
	timer.one_shot = true
	timer.timeout.connect(_explode.bind(grenade))
	grenade.add_child(timer)
	timer.start()

func _explode(grenade: Node2D) -> void:
	var pos = grenade.global_position
	grenade.queue_free()
	var space = get_world_2d().direct_space_state
	var query = PhysicsShapeQueryParameters2D.new()
	var circle = CircleShape2D.new()
	circle.radius = range
	query.shape = circle
	query.transform = Transform2D(0, pos)
	query.collision_mask = 2
	query.collide_with_bodies = true
	var results = space.intersect_shape(query, 32)
	for result in results:
		var enemy = result.collider
		if enemy.has_method("take_damage"):
			var dir = (enemy.global_position - pos).normalized()
			enemy.take_damage(damage, dir)

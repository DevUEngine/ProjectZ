extends Enemy

var phase := 1
var add_timer: Timer

func _ready():
	super._ready()
	health = 1000
	speed = 50.0
	damage = 30
	xp_value = 200
	add_timer = Timer.new()
	add_timer.wait_time = 5.0
	add_timer.autostart = true
	add_timer.timeout.connect(_spawn_add)
	add_child(add_timer)

func _physics_process(delta: float):
	_update_phase()
	var p := get_player()
	if not p:
		return
	var dir := global_position.direction_to(p.global_position)
	velocity = dir * speed + knockback
	knockback = knockback.move_toward(Vector2.ZERO, speed * 3.0 * delta)
	move_and_slide()
	_attack_player()

func _update_phase():
	var pct := float(health) / 1000.0
	var new_phase := 3 if pct < 0.33 else 2 if pct < 0.66 else 1
	if new_phase == phase:
		return
	phase = new_phase
	_enter_phase()

func _enter_phase():
	match phase:
		2:
			speed = 70.0
			add_timer.wait_time = 3.0
		3:
			speed = 90.0
			damage = 40
			add_timer.wait_time = 2.0

func _spawn_add():
	var scenes := [
		preload("res://scenes/cyber_zombie.tscn"),
		preload("res://scenes/drone.tscn"),
	]
	var scene := scenes.pick_random()
	var add := scene.instantiate()
	add.global_position = global_position + Vector2(randf() - 0.5, randf() - 0.5) * 100.0
	get_tree().current_scene.call_deferred("add_child", add)

func die():
	add_timer.stop()
	died.emit(global_position, xp_value)
	queue_free()

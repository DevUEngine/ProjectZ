extends Enemy

var is_dashing := false

func _ready():
	super._ready()
	health = 15
	speed = 150.0
	damage = 8
	xp_value = 3
	var timer := Timer.new()
	timer.wait_time = 1.5
	timer.autostart = true
	timer.timeout.connect(_start_dash)
	add_child(timer)

func _physics_process(delta: float):
	var p := get_player()
	if not p:
		return
	var dir := global_position.direction_to(p.global_position)
	var current_speed := speed * 3.0 if is_dashing else speed
	velocity = dir * current_speed + knockback
	knockback = knockback.move_toward(Vector2.ZERO, speed * 3.0 * delta)
	move_and_slide()
	_attack_player()

func _start_dash():
	is_dashing = true
	get_tree().create_timer(0.3).timeout.connect(func(): is_dashing = false)

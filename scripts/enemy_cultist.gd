extends Enemy

const ENEMY_PROJECTILE := preload("res://scenes/enemy_projectile.tscn")

func _ready():
	super._ready()
	health = 20
	speed = 60.0
	damage = 15
	xp_value = 8
	var timer := Timer.new()
	timer.wait_time = 2.0
	timer.autostart = true
	timer.timeout.connect(_shoot)
	add_child(timer)

func _shoot():
	var p := get_player()
	if not p:
		return
	var proj := ENEMY_PROJECTILE.instantiate()
	proj.global_position = global_position
	var dir := global_position.direction_to(p.global_position)
	proj.init(dir, 150.0, damage)
	get_tree().current_scene.call_deferred("add_child", proj)

extends CharacterBody2D

signal health_changed(current: int, max_val: int)
signal xp_changed(current: int, to_next: int)
signal leveled_up(new_level: int)
signal died

@export var speed: float = 200.0
@export var max_health: int = 100

var health: int = max_health
var xp: int = 0
var level: int = 1
var xp_to_next: int = 100

var _dodging: bool = false
var _iframe_timer: float = 0.0

@onready var _weapons: Node2D = $Weapons


func _ready():
	add_to_group("player")
	health = max_health


func _physics_process(delta: float):
	var input := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var move_speed := speed

	if Input.is_action_just_pressed("dodge") and not _dodging:
		_start_dodge()

	if _dodging:
		move_speed *= 2.5
		_iframe_timer -= delta
		if _iframe_timer <= 0.0:
			_dodging = false

	velocity = input * move_speed
	move_and_slide()
	_attack_nearest()


func _start_dodge():
	_dodging = true
	_iframe_timer = 0.2


func _attack_nearest():
	if _weapons.get_child_count() == 0:
		return

	var nearest := _find_nearest_enemy()
	if nearest == null:
		return

	for w in _weapons.get_children():
		if w.has_method("fire"):
			w.fire(nearest.global_position, global_position)


func _find_nearest_enemy() -> Node2D:
	var enemies := get_tree().get_nodes_in_group("enemy")
	var closest: Node2D = null
	var best := INF

	for e in enemies:
		var d := global_position.distance_squared_to(e.global_position)
		if d < best:
			best = d
			closest = e

	return closest


func take_damage(amount: int):
	if _dodging:
		return

	health = maxi(health - amount, 0)
	health_changed.emit(health, max_health)
	if health == 0:
		die()


func heal(amount: int):
	health = mini(health + amount, max_health)
	health_changed.emit(health, max_health)


func add_xp(amount: int):
	xp += amount
	while xp >= xp_to_next:
		xp -= xp_to_next
		level += 1
		xp_to_next = int(xp_to_next * 1.2)
		leveled_up.emit(level)
	xp_changed.emit(xp, xp_to_next)


func die():
	died.emit()
	queue_free()


func _on_pickup_detector_area_entered(area: Area2D):
	if area.has_method("collect"):
		area.collect(self)

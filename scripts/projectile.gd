class_name Projectile
extends Area2D

var _speed: float = 400.0
var _damage: int = 10
var _direction: Vector2 = Vector2.RIGHT
var _lifetime: float = 3.0

var _homing_target: Node2D = null
var _homing_strength: float = 5.0

func init(dir: Vector2, spd: float, dmg: int) -> void:
	_direction = dir.normalized()
	_speed = spd
	_damage = dmg

func init_homing(target: Node2D, spd: float, dmg: int, strength: float = 5.0) -> void:
	_homing_target = target
	_speed = spd
	_damage = dmg
	_homing_strength = strength
	if target:
		_direction = (target.global_position - global_position).normalized()

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	var timer = Timer.new()
	timer.wait_time = _lifetime
	timer.one_shot = true
	timer.timeout.connect(queue_free)
	add_child(timer)
	timer.start()

func _physics_process(delta: float) -> void:
	if _homing_target and is_instance_valid(_homing_target):
		var target_dir = (_homing_target.global_position - global_position).normalized()
		_direction = _direction.lerp(target_dir, _homing_strength * delta).normalized()
	position += _direction * _speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(_damage, _direction)
	queue_free()

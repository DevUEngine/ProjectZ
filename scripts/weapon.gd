class_name Weapon
extends Node2D

@export var damage: int = 10
@export var cooldown: float = 1.0
@export var range: float = 100.0
@export var level: int = 1

var _cooldown_timer: Timer

func _ready() -> void:
	_cooldown_timer = Timer.new()
	_cooldown_timer.one_shot = true
	_cooldown_timer.wait_time = cooldown
	add_child(_cooldown_timer)

func fire(target_position: Vector2, from_position: Vector2) -> void:
	if not _cooldown_timer.is_stopped():
		return
	_fire(target_position, from_position)
	_cooldown_timer.start()

func _fire(target_position: Vector2, from_position: Vector2) -> void:
	pass

func upgrade() -> void:
	level += 1
	_on_upgrade()

func _on_upgrade() -> void:
	damage = int(damage * 1.2)
	cooldown *= 0.9
	_cooldown_timer.wait_time = cooldown

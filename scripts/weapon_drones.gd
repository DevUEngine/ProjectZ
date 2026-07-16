class_name WeaponDrones
extends Weapon

const _PROJECTILE = preload("res://scenes/projectile.tscn")

var _drones: Array[Sprite2D] = []
var _orbit_angle: float = 0.0
var _orbit_radius: float = 40.0

func _ready() -> void:
	damage = 12
	cooldown = 1.0
	range = 150.0
	super._ready()
	for i in 2:
		var drone = Sprite2D.new()
		drone.texture = load("res://assets/sprites/weapons/drone.png")
		add_child(drone)
		_drones.append(drone)

func _process(delta: float) -> void:
	_orbit_angle += delta * 2.0
	for i in _drones.size():
		var angle = _orbit_angle + i * PI
		_drones[i].position = Vector2(cos(angle), sin(angle)) * _orbit_radius

func _fire(target_position: Vector2, from_position: Vector2) -> void:
	for drone in _drones:
		var dir = (target_position - (global_position + drone.position)).normalized()
		var projectile = _PROJECTILE.instantiate()
		projectile.global_position = global_position + drone.position
		projectile.init(dir, 400.0, damage)
		get_tree().current_scene.add_child(projectile)

class_name Pickup
extends Area2D

enum Type { XP, HEALTH, SOUL }

var _type: Type = Type.XP
var _amount: int = 1
var _base_y: float
var _time: float = 0.0

@onready var _sprite: Sprite2D = $Sprite2D

func init(type: String, amount: int) -> void:
	_amount = amount
	match type:
		"xp_orb":
			_type = Type.XP
		"health":
			_type = Type.HEALTH
		"soul":
			_type = Type.SOUL

func _ready() -> void:
	_base_y = position.y
	body_entered.connect(_on_body_entered)
	match _type:
		Type.XP:
			_sprite.texture = load("res://assets/sprites/pickups/xp_orb.png")
		Type.HEALTH:
			_sprite.texture = load("res://assets/sprites/pickups/health.png")
		Type.SOUL:
			_sprite.texture = load("res://assets/sprites/pickups/soul.png")

func _process(delta: float) -> void:
	_time += delta
	position.y = _base_y + sin(_time * 3.0) * 4.0

func _on_body_entered(body: Node2D) -> void:
	if not body.has_method("add_xp"):
		return
	match _type:
		Type.XP:
			body.add_xp(_amount)
		Type.HEALTH:
			if body.has_method("heal"):
				body.heal(_amount)
		Type.SOUL:
			GameState.add_souls(_amount)
	queue_free()

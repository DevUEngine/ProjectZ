extends Area2D

var velocity: Vector2 = Vector2.ZERO
var damage: int = 5

func init(dir: Vector2, spd: float, dmg: int):
	velocity = dir * spd
	damage = dmg

func _ready():
	body_entered.connect(_on_body_entered)
	var timer := Timer.new()
	timer.wait_time = 3.0
	timer.timeout.connect(queue_free)
	add_child(timer)
	timer.start()

func _physics_process(delta: float):
	position += velocity * delta

func _on_body_entered(body: Node2D):
	if body.is_in_group("player") and body.has_method("take_damage"):
		body.take_damage(damage)
	queue_free()

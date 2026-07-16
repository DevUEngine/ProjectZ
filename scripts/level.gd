extends Node2D

@onready var spawner = $SpawnerHolder/Spawner
@onready var pickups = $Pickups
@onready var hud = $HUD

var player: Node2D
var game_time: float = 0.0
var max_time: float = 20.0 * 60.0
var paused: bool = false
var boss_spawned: bool = false

signal game_won
signal game_lost

func _ready() -> void:
	spawn_player()
	spawner.start_spawning()

var _last_boss_minute: int = -1

func _process(delta: float) -> void:
	if paused:
		return
	game_time += delta
	var remaining = max_time - game_time
	hud.update_timer(ceil(remaining))
	if game_time >= max_time:
		win()
		return
	var minutes = int(game_time / 60.0)
	if minutes > 0 and minutes % 5 == 0 and minutes != _last_boss_minute:
		spawner.spawn_boss()
		_last_boss_minute = minutes

func spawn_player() -> void:
	var scene = load("res://scenes/player.tscn")
	player = scene.instantiate()
	player.position = Vector2.ZERO
	add_child(player)
	player.died.connect(_on_player_died)

func win() -> void:
	paused = true
	spawner.stop_spawning()
	get_tree().paused = true
	game_won.emit()

func _on_player_died() -> void:
	paused = true
	spawner.stop_spawning()
	get_tree().paused = true
	game_lost.emit()

func toggle_pause() -> void:
	paused = not paused
	get_tree().paused = paused

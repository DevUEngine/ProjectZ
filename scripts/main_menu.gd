extends Node2D

signal start_game
signal open_upgrades

@onready var souls_label: Label = $UI/SoulsLabel

func _ready():
	update_souls(GameState.get_souls())
	$UI/StartButton.pressed.connect(_on_start)
	$UI/UpgradesButton.pressed.connect(_on_upgrades)
	$UI/QuitButton.pressed.connect(_on_quit)

func update_souls(n: int):
	souls_label.text = "Souls: %d" % n

func _on_start():
	start_game.emit()

func _on_upgrades():
	open_upgrades.emit()

func _on_quit():
	get_tree().quit()

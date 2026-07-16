extends CanvasLayer

signal retry
signal main_menu

@onready var time_label: Label = $Panel/VBox/TimeLabel
@onready var kills_label: Label = $Panel/VBox/KillsLabel
@onready var souls_label: Label = $Panel/VBox/SoulsLabel

func _ready():
	$Panel/VBox/RetryButton.pressed.connect(func(): retry.emit())
	$Panel/VBox/MenuButton.pressed.connect(func(): main_menu.emit())

func show_stats(time_sec: int, kills: int, souls: int):
	var m := time_sec / 60
	var s := time_sec % 60
	time_label.text = "Time: %d:%02d" % [m, s]
	kills_label.text = "Kills: %d" % kills
	souls_label.text = "Souls: %d" % souls
	show()

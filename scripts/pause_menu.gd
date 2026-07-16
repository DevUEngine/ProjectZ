extends CanvasLayer

signal resume
signal open_upgrades
signal quit_to_menu

func _ready():
	$Panel/VBox/ResumeButton.pressed.connect(func(): resume.emit())
	$Panel/VBox/UpgradesButton.pressed.connect(func(): open_upgrades.emit())
	$Panel/VBox/QuitButton.pressed.connect(func(): quit_to_menu.emit())

func show_pause():
	get_tree().paused = true
	show()

func hide_pause():
	hide()
	get_tree().paused = false

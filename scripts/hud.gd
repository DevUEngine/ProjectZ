extends CanvasLayer

signal weapon_picked(choice: Dictionary)

@onready var health_bar: ProgressBar = $Control/HealthBar
@onready var xp_bar: ProgressBar = $Control/XPBar
@onready var timer_label: Label = $Control/TimerLabel
@onready var souls_label: Label = $Control/SoulsLabel
@onready var level_label: Label = $Control/LevelLabel
@onready var level_up_panel: Panel = $LevelUpPanel
@onready var choices_container: VBoxContainer = $LevelUpPanel/VBoxContainer
@onready var weapon_icons: HBoxContainer = $Control/WeaponIcons

var _level_up_choices: Array[Dictionary] = []

func _ready():
	hide_level_up()
	update_souls(0)

func update_health(current: int, max_health: int):
	health_bar.max_value = max_health
	health_bar.value = current

func update_xp(current: int, to_next: int):
	xp_bar.max_value = to_next
	xp_bar.value = current

func update_timer(sec: int):
	var m := sec / 60
	var s := sec % 60
	timer_label.text = "%d:%02d" % [m, s]

func update_souls(n: int):
	souls_label.text = "S: %d" % n

func update_level(lvl: int):
	level_label.text = "Lv.%d" % lvl

func add_weapon_icon(texture_path: String):
	var tex := load(texture_path) as Texture2D
	if not tex:
		return
	var icon := TextureRect.new()
	icon.texture = tex
	icon.custom_minimum_size = Vector2(32, 32)
	icon.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	weapon_icons.add_child(icon)

func clear_weapon_icons():
	for c in weapon_icons.get_children():
		c.queue_free()

func show_level_up(options: Array[Dictionary]):
	_level_up_choices = options
	get_tree().paused = true
	level_up_panel.show()

	for c in choices_container.get_children():
		c.queue_free()

	for opt in options:
		var btn := Button.new()
		btn.text = opt.get("name", "???")
		btn.pressed.connect(_on_choice.bind(opt))
		choices_container.add_child(btn)

func hide_level_up():
	level_up_panel.hide()
	get_tree().paused = false

func _on_choice(choice: Dictionary):
	weapon_picked.emit(choice)
	hide_level_up()

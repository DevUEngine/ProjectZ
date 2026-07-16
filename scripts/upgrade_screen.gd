extends CanvasLayer

const UPGRADES := {
	"max_health": {"name": "Max Health", "cost": 50, "max": 10, "value": 10},
	"speed": {"name": "Speed", "cost": 60, "max": 10, "value": 5},
	"damage": {"name": "Damage", "cost": 75, "max": 10, "value": 5},
	"cooldown": {"name": "Cooldown", "cost": 80, "max": 10, "value": 2},
	"xp_gain": {"name": "XP Gain", "cost": 100, "max": 5, "value": 10},
}

@onready var souls_label: Label = $Panel/VBox/SoulsLabel
@onready var grid: GridContainer = $Panel/VBox/Grid

func _ready():
	$Panel/VBox/BackButton.pressed.connect(hide)
	refresh_ui()

func refresh_ui():
	for c in grid.get_children():
		c.queue_free()

	souls_label.text = "Souls: %d" % GameState.get_souls()

	for id in UPGRADES:
		var data := UPGRADES[id] as Dictionary
		var lvl := GameState.get_upgrade(id)
		var cost := data.cost + lvl * 25
		var btn := Button.new()
		btn.text = "%s Lv.%d\nCost: %d" % [data.name, lvl, cost]
		btn.disabled = lvl >= data.max or GameState.get_souls() < cost
		btn.pressed.connect(buy_upgrade.bind(id, cost))
		grid.add_child(btn)

func buy_upgrade(id: String, cost: int):
	if GameState.get_souls() < cost:
		return
	GameState.add_souls(-cost)
	GameState._upgrades[id] = GameState.get_upgrade(id) + 1
	GameState.save_game()
	refresh_ui()

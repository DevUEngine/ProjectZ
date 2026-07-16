extends Node

var souls: int = 0
var upgrades: Dictionary = {}
var unlocked_weapons: Array = []
var unlocked_characters: Array = []

var save_path: String = "user://save.json"

func add_souls(n: int) -> void:
	souls += n

func get_upgrade(name: String) -> int:
	return upgrades.get(name, 0)

func save_game() -> void:
	var data = {
		"souls": souls,
		"upgrades": upgrades,
		"unlocked_weapons": unlocked_weapons,
		"unlocked_characters": unlocked_characters
	}
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))

func load_game() -> void:
	if not FileAccess.file_exists(save_path):
		return
	var file = FileAccess.open(save_path, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	if data == null:
		return
	souls = data.get("souls", 0)
	upgrades = data.get("upgrades", {})
	unlocked_weapons = data.get("unlocked_weapons", [])
	unlocked_characters = data.get("unlocked_characters", [])

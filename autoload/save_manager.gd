extends Node
class_name SaveManager

const SAVE_PATH := "user://save.json"

var player: Player = Player.new()

func _ready() -> void:
	load_game()

func save_game() -> void:
	var data: Dictionary = player.to_dict()
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null:
		push_error("Save failed: cannot open %s for writing" % SAVE_PATH)
		return
	file.store_string(JSON.stringify(data))
	file.flush()

func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		save_game()
		return

	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		push_error("Load failed: cannot open %s for reading" % SAVE_PATH)
		return

	var text: String = file.get_as_text()

	var parsed: Variant = JSON.parse_string(text)

	if typeof(parsed) != TYPE_DICTIONARY:
		push_error("Save corrupted/invalid JSON, resetting.")
		player = Player.new()
		save_game()
		return

	var data: Dictionary = parsed
	player = Player.from_dict(data)

func add_level(delta: int = 1) -> void:
	player.level += delta
	save_game()

func assign_level(echo: int) -> void:
	player.level = echo
	save_game()

func reset_player() -> void:
	player.level = 0
	save_game()

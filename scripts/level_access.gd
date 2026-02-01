extends PanelContainer

@onready var thumbnail: TextureButton = $VBoxContainer/LevelThumbnail

func _ready() -> void:
	Save.load_game()
	var level_num := _get_level_number()

	if level_num > Save.player.level:
		thumbnail.disabled = true
		return

	thumbnail.pressed.connect(_on_thumbnail_pressed.bind(level_num))

func _on_thumbnail_pressed(level_num: int) -> void:
	var scene_path := "res://scenes/levels/level_%d.tscn" % level_num
	get_tree().change_scene_to_file(scene_path)

func _get_level_number() -> int:
	return int(name.replace("Level", ""))

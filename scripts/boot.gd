extends Node2D

const PILOT_SCENE := "res://scenes/menus/pilot.tscn"
const MAIN_MENU_SCENE := "res://scenes/menus/main-menu.tscn"

func _ready() -> void:
	Save.load_game()
	call_deferred("_route")

func _route() -> void:
	if Save.player.level == 0:
		get_tree().change_scene_to_file(PILOT_SCENE)
	else:
		get_tree().change_scene_to_file(MAIN_MENU_SCENE)

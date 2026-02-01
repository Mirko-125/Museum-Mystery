extends Control

@onready var confirm_dialog := $SafeArea/ConfirmNewGame

func _ready() -> void:
	print("Current level is: ", Save.player.level)

func _on_new_game_pressed() -> void:
	confirm_dialog.popup_centered()
	
func _on_confirm_new_game_confirmed() -> void:
	Save.reset_player()
	get_tree().change_scene_to_file("res://scenes/menus/pilot.tscn")
	
func _on_continue_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/scene-select.tscn");

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_artifacts_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/artifacts.tscn")

func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/credits.tscn")

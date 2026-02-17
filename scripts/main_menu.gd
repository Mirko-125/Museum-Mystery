extends Control

@onready var confirm_dialog := $SafeArea/ConfirmNewGame
@onready var transition := $Transition
@onready var more_levels := $SafeArea/VBoxContainer/Continue

func _ready() -> void:
	print("Current level is: ", Save.player.level)
	if Save.player.level == 0:
		more_levels.visible = false
	transition.animate("fade_out")

func _on_new_game_pressed() -> void:
	confirm_dialog.popup_centered()
	
func _on_confirm_new_game_confirmed() -> void:
	Save.reset_player()
	transition.animate("fade_in","res://scenes/menus/pilot.tscn")
	
func _on_continue_pressed() -> void:
	transition.animate("fade_in","res://scenes/menus/scene-select.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_artifacts_pressed() -> void:
	transition.animate("fade_in","res://scenes/menus/artifacts.tscn")

func _on_credits_pressed() -> void:
	transition.animate("fade_in","res://scenes/menus/credits.tscn")

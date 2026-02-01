extends Control

func _ready() -> void:
	print("Current level is: ", Save.player.level)

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")

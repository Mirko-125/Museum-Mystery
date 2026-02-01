extends CanvasLayer

@onready var pause := $"."

func _on_pause_pressed() -> void:
	pause.visible = true

func _on_continue_pressed() -> void:
	pause.visible = false

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/main-menu.tscn")

func _on_quit_to_os_pressed() -> void:
	get_tree().quit()

extends CanvasLayer

@onready var pause := $"."
@onready var transition := $"../../Transition"

func _on_pause_pressed() -> void:
	pause.visible = true

func _on_continue_pressed() -> void:
	pause.visible = false

func _on_main_menu_pressed() -> void:
	transition.animate("fade_in","res://scenes/menus/main-menu.tscn")

func _on_quit_to_os_pressed() -> void:
	transition.animate("fade_in")
	get_tree().quit()

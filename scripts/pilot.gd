extends Control

@onready var transition := $Transition

func _ready() -> void:
	transition.animate("fade_out")
	print("Current level is: ", Save.player.level)

func _on_start_pressed() -> void:
	transition.animate("fade_in","res://scenes/levels/level_1.tscn")

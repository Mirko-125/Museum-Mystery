extends Control

@onready var transition := $Transition
@onready var audio := $AudioStreamPlayer2D

func _ready() -> void:
	transition.animate("fade_out")
	print("Current level is: ", Save.player.level)

func _on_start_pressed() -> void:
	audio.play()
	transition.animate("fade_in","res://scenes/levels/level_1.tscn")

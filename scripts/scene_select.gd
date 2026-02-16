extends Control

@onready var transition := $Transition

func _ready() -> void:
	transition.animate("fade_out")
	print("Current level is: ", Save.player.level)

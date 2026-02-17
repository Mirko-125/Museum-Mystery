extends Control

@onready var transition := $Transition

func _ready() -> void:
	transition.animate("fade_out")
	await get_tree().create_timer(2.0).timeout
	transition.animate("fade_in","res://scenes/menus/us.tscn")

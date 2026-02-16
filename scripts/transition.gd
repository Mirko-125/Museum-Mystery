extends Control

@onready var animation := $AnimationPlayer
@onready var background := $ColorRect

func animate(target: String, location: String = "") -> void:
	animation.play(target)
	await animation.animation_finished
	if not location == "":
		get_tree().change_scene_to_file(location) # ne ucitava za sve

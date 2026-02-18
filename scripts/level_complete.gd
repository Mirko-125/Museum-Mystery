extends Control

@onready var transition := $Transition
@onready var value := $Background/MarginContainer/VBoxContainer/Value
@onready var sound := $sound
var level_num := Save.player.level

var puzzle_dictionary = {
	1: "G",
	2: "L",
	3: "C",
	4: "R",
	5: "Q",
	6: "-3",
	7: "H",
	8: "Caesar",
	9: "V",
	10: "_"
}

func _ready() -> void:
	transition.animate("fade_out")
	print("Current level is: ", level_num)
	value.text = puzzle_dictionary[level_num-1]

func _on_menu_pressed() -> void:
	sound.play()
	transition.animate("fade_in","res://scenes/menus/main-menu.tscn")

func _on_next_level_pressed() -> void:
	sound.play()
	var scene_path := "res://scenes/levels/level_%d.tscn" % level_num
	if Save.player.isdemo:
		transition.animate("fade_in","res://scenes/menus/demo.tscn")
	else:
		transition.animate("fade_in",scene_path)

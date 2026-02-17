extends Control

@onready var transition := $Transition
@onready var value := $Background/MarginContainer/VBoxContainer/Value
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
	print("Current level is: ", level_num)
	value.text = puzzle_dictionary[level_num-1]

func _on_menu_pressed() -> void:
	transition.animate("fade_in","res://scenes/menus/main-menu.tscn")

func _on_next_level_pressed() -> void:
	var scene_path := "res://scenes/levels/level_%d.tscn" % level_num
	get_tree().change_scene_to_file(scene_path)

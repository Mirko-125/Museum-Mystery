extends Node3D

@onready var transition := $Transition

func _ready() -> void:
	transition.animate("fade_out")
	update_3d_nodes()

func update_3d_nodes() -> void:
	for i in range(1, 11):  
		var child = get_node_or_null(str(i))
		if child:
			child.visible = i <= Save.player.level

func _on_start_pressed() -> void:
	transition.animate("fade_in","res://scenes/menus/main-menu.tscn")

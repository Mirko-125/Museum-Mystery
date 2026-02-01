extends Node3D

@onready var cutscene := $Cutscene
@onready var text_label := $Cutscene/DarkenShadow/HBoxContainer/DialogBox/MarginContainer/Text
@onready var character := $Cutscene/DarkenShadow/HBoxContainer/Character

var dialog_data := [
	{
		"text": "Welcome to your first adventure!",
		"character_texture": "res://art/brat_marko/PNG/MARE-1.png"
	},
	{
		"text": "Let me show you the basics…",
		"character_texture": "res://art/brat_marko/PNG/MARE-4.png"
	},
	{
		"text": "Tap to begin!",
		"character_texture": "res://art/brat_marko/PNG/MARE-3.png"
	}
]

var current_index := 0
var typing_speed := 0.04
var can_advance := false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

	if Save.player.level == 0:
		start_cutscene()
	else:
		cutscene.queue_free()
		cutscene = null

func start_cutscene() -> void:
	get_tree().paused = true
	cutscene.visible = true
	show_line(current_index)

func show_line(idx: int) -> void:
	can_advance = false
	text_label.text = ""

	var line = dialog_data[idx]
	character.texture = load(line["character_texture"])

	await typewriter(line["text"])
	can_advance = true

func typewriter(text_str: String) -> void:
	text_label.text = ""
	for t in text_str:
		text_label.text += t
		await get_tree().create_timer(typing_speed).timeout

func _input(event: InputEvent) -> void:
	if cutscene == null:
		return
	if not can_advance:
		return

	if event is InputEventMouseButton and event.pressed:
		advance_dialog()

func advance_dialog() -> void:
	current_index += 1
	if current_index < dialog_data.size():
		show_line(current_index)
	else:
		finish_cutscene()

func finish_cutscene() -> void:
	get_tree().paused = false
	cutscene.queue_free()
	cutscene = null

func _on_option_1_pressed() -> void:
	Save.assign_level(2)
	get_tree().change_scene_to_file("res://scenes/levels/level_complete.tscn");

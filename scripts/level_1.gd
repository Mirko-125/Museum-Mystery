extends Node3D

@onready var cutscene := $Cutscene
@onready var text_label := $Cutscene/DarkenShadow/HBoxContainer/Dialog/Panel/MarginContainer/Label
@onready var character := $Cutscene/DarkenShadow/HBoxContainer/Character/Marko
@onready var transition := $Transition
@onready var correct := $UI/OptionCorrect

var dialog_data := [
	{
		"text": "Ekipa još uvek postavlja ostale nivoe - 
		ali bez brige, ti si moj tajni agent...",
		"character_texture": "res://art/brat_marko/PNG/MARE-1.png"
	},
	{
		"text": "...sada reši prvu mini-igru krišom dok ja 
		dovršavam app sa njima, pa da zajedno
		dignemo Muzej Vojvodine na noge...",
		"character_texture": "res://art/brat_marko/PNG/MARE-6.png"
	},
	{
		"text": "...pre nego što kustos kaže 'dovoljno 
		misterije za danas!'",
		"character_texture": "res://art/brat_marko/PNG/MARE-4.png"
	}
]

var current_index := 0
var typing_speed := 0.04
var can_advance := false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	transition.animate("fade_out")
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
	correct.play()
	Save.assign_level(2)
	get_tree().change_scene_to_file("res://scenes/levels/level_complete.tscn");

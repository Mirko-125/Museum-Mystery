extends Node

@export var max_selected := 3
@export var correct_items: Array[String] = [] 
@onready var camera: Camera3D = $"../../Camera3D"
@onready var level = $"../../.."
@onready var finalization := $"../../../Finalization"
@onready var wrong := $"../../../UI/OptionWrong"
@onready var correct := $"../../../UI/OptionCorrect"
var selected_items: Array[String] = []

func select_item(id: String) -> void:
	if id in selected_items:
		return
	if selected_items.size() >= max_selected:
		return
	selected_items.append(id)
	if selected_items.size() == max_selected:
		_check_selection()

func deselect_item(id: String) -> void:
	selected_items.erase(id)

func reset() -> void:
	selected_items.clear()

func print_selected_items() -> void:
	print("Selected items: ", selected_items)

func _check_selection() -> void:
	if selected_items.size() == max_selected:
		var required_items = ["Wheat", "Rain", "Sun"]
		var is_correct = selected_items.size() == required_items.size()
		for item in required_items:
			if not item in selected_items:
				is_correct = false
				break
		if is_correct:
			correct.play()
			print("Correct selection!")
			finalization.visible = true
		else:
			wrong.play()
			print("Incorrect selection. Resetting...")
			_shake_camera()
			reset()
			_deselect_all_items()

func _shake_camera() -> void:
	var original_position = camera.position
	var shake_intensity = 0.2
	var shake_duration = 0.5
	var elapsed = 0.0

	var timer = get_tree().create_timer(shake_duration, false)
	timer.timeout.connect(func(): camera.position = original_position)

	while elapsed < shake_duration:
		camera.position = original_position + Vector3(
			randf_range(-shake_intensity, shake_intensity),
			randf_range(-shake_intensity, shake_intensity),
			randf_range(-shake_intensity, shake_intensity)
		)
		elapsed += 0.01
		await get_tree().create_timer(0.01).timeout

func _deselect_all_items() -> void:
	for child in get_parent().get_children():
		if child.has_method("deselect"):
			child.deselect()

func _reset_progress() -> void:
	wrong.play()
	print("Incorrect answer. Resetting...")
	finalization.visible = false
	_shake_camera()
	reset()
	_deselect_all_items()

func _on_option_2_pressed() -> void:
	_reset_progress()

func _on_option_3_pressed() -> void:
	_reset_progress()

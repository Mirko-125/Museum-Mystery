extends Node3D

var original_position: Vector3
var camera: Camera3D
var is_selected := false
var is_returning := false
var is_rotating_360 := false
var rotation_angle := 0.0

var move_speed := 5.0
var rotation_360_speed := 1.0

@onready var ui_panel = $"../Control"
@onready var return_button = $"../Control/ColorRect/Return"
@onready var audio = $"../AudioStreamPlayer2D"

func _ready():
	original_position = global_position
	camera = get_viewport().get_camera_3d()
	ui_panel.visible = false
	return_button.pressed.connect(_on_return_button_pressed)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and not is_selected:
		_move_to_camera()

func _move_to_camera():
	audio.play()
	is_selected = true
	is_rotating_360 = true
	var target_position = Vector3(0.0, 1.636, 3.468)
	global_position = target_position
	ui_panel.visible = true 

func _on_return_button_pressed():
	audio.play()
	is_returning = true
	is_rotating_360 = false

func _process(delta: float) -> void:
	if is_rotating_360:
		rotation_angle += rotation_360_speed * delta
		rotation.y = rotation_angle

	if is_returning:
		global_position = global_position.lerp(original_position, move_speed * delta)
		if global_position.distance_to(original_position) < 0.01:
			global_position = original_position
			is_returning = false
			is_selected = false
			is_rotating_360 = false
			ui_panel.visible = false  
			rotation.y = 0.0

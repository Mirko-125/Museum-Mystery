extends Node3D

@export var item_id: String
@export var rotation_speed := 4.0

@onready var manager := $"../ItemManager"

var rotating := true
var selected := false

func _ready() -> void:
	$Hitbox.input_event.connect(_on_hitbox_input)

func _process(delta: float) -> void:
	if rotating:
		rotate_y(rotation_speed * delta)

func _on_hitbox_input(
	_camera: Camera3D,
	event: InputEvent,
	_position: Vector3,
	_normal: Vector3,
	_shape_idx: int
) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_toggle_selection()

func _toggle_selection() -> void:
	rotating = !rotating
	selected = !selected

	if selected:
		manager.select_item(item_id)
		manager.print_selected_items()
	else:
		manager.deselect_item(item_id)

func deselect() -> void:
	rotating = true
	selected = false

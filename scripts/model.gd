extends Node3D

@export var rotation_sensitivity := 0.01
@export var zoom_sensitivity := 0.8
@export var min_zoom := 1.5
@export var max_zoom := 6.0

@onready var camera: Camera3D = $"../Camera3D"
@onready var hitbox: Area3D = $Hitbox

var last_drag_pos: Vector2
var dragging := false
var is_active_touch := false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			is_active_touch = _touch_hits_hitbox(event.position)
			dragging = is_active_touch
			last_drag_pos = event.position
		else:
			dragging = false
			is_active_touch = false

	elif event is InputEventScreenDrag and dragging and is_active_touch:
		var delta: Vector2 = event.position - last_drag_pos
		last_drag_pos = event.position

		rotate_y(delta.x * rotation_sensitivity)
		rotate_x(delta.y * rotation_sensitivity)
		rotation.x = clamp(rotation.x, deg_to_rad(-80), deg_to_rad(80))

	elif event is InputEventMagnifyGesture and is_active_touch:
		var cam_pos := camera.position
		cam_pos.z = clamp(
			cam_pos.z - event.factor * zoom_sensitivity,
			min_zoom,
			max_zoom
		)
		camera.position = cam_pos

func _touch_hits_hitbox(screen_pos: Vector2) -> bool:
	var ray_origin := camera.project_ray_origin(screen_pos)
	var ray_dir := camera.project_ray_normal(screen_pos)
	var ray_end := ray_origin + ray_dir * 1000.0

	var query := PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
	query.collide_with_areas = true
	query.collide_with_bodies = false

	var result := get_world_3d().direct_space_state.intersect_ray(query)
	return not result.is_empty() and result.collider == hitbox

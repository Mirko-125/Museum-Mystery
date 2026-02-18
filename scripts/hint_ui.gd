extends CanvasLayer

@onready var hint_db = $Hints
@onready var hint_button: TextureButton = $Top/Background/Seperator/Hints/Hints
@onready var number_of_hints = $Top/Background/Seperator/Hints/Num
@onready var hint_card: Control = $Card
@onready var hint_value = $Card/HintValue
@onready var hint_sound = $HintSound

var card_visible: bool = false
var tween: Tween = null
var hints_available = 3

var level_index: int
var hint_index: int

func _ready() -> void:
	level_index = get_scene_number(get_tree().current_scene.name)
	number_of_hints.text = str(hints_available)
	hint_card.visible = false
	hint_button.pressed.connect(_on_hint_button_pressed)
	hint_card.gui_input.connect(_on_hint_card_input)

func _on_hint_button_pressed() -> void:
	if card_visible:
		return
	
	hint_index = get_mapped_hint_number(hints_available)
	print(hint_db.hints_bank[level_index-1][hint_index])
	hint_value.text = hint_db.hints_bank[level_index-1][hint_index]
	hints_available -= 1
	if hints_available == 0:
		hint_button.disabled = true
	hint_sound.play()
	number_of_hints.text = str(hints_available)
	card_visible = true
	hint_card.visible = true
	animate_card_in()

func _on_hint_card_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		animate_card_out()

func animate_card_in() -> void:
	if tween:
		tween.kill()

	var viewport_size: Vector2 = get_viewport().get_visible_rect().size
	var card_size: Vector2 = hint_card.size

	hint_card.position = Vector2(
		-card_size.x - 50.0,
		(viewport_size.y - card_size.y) / 2.0
	)

	var target_pos: Vector2 = Vector2(
		viewport_size.x * 0.15,
		(viewport_size.y - card_size.y) / 2.0
	)

	tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)

	tween.tween_property(
		hint_card,
		"position",
		target_pos,
		0.45
	)

func animate_card_out() -> void:
	if tween:
		tween.kill()

	card_visible = false

	tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN)

	tween.tween_property(
		hint_card,
		"position",
		Vector2(-hint_card.size.x - 50.0, hint_card.position.y),
		0.35
	)

	tween.finished.connect(func() -> void:
		hint_card.visible = false
	)

func get_mapped_hint_number(input_number: int) -> int:
	return 4 - input_number

func get_scene_number(input_scene_name: String) -> int:
	var regex := RegEx.new()
	regex.compile("(\\d+)")
	var result := regex.search(input_scene_name)
	if result:
		return int(result.get_string(1))
	return -1

# Manager for the entire game! Root of the project, handles game states and events

extends Node2D

signal restart

@onready var timer 		= $Timer
@onready var score 		= $Score
@onready var background = $Background
@onready var message 	= $Message
@onready var sfx 		= $AudioStreamPlayer2D
@onready var ambience 	= $AmbienceManager

const ENEMY    = preload('res://scenes/enemy/enemy.tscn')
var COLOR_BG = Color.hex(0x595652ff)

func _ready() -> void:
	message.show()
	message.texture = load('res://assets/sprites/start-game.png')

func _process(_dt: float) -> void:
	if (
		not Globals.is_game_started and Input.is_anything_pressed()
	) or (
		Globals.paused and Input.is_action_just_pressed('up')
	):
		start_game()

func start_game() -> void: 
	Globals.is_game_started = true
	Globals.paused = false
	Globals.added_difficulty = 0
	timer.start()
	message.hide()
	message.texture = load('res://assets/sprites/game-over.png')
	emit_signal('restart')
   
func spawn_enemy() -> void:
	var instance = ENEMY.instantiate()
	add_child(instance)
	restart.connect(instance._on_restart)

func _on_timer_timeout() -> void:
	spawn_enemy()

func _on_player_body_entered(_body: Node2D) -> void:
	Globals.paused = true
	timer.stop()
	sfx.play()
	message.show()

func _on_score_night() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(
		background,
		'color',
		COLOR_BG if Globals.night else Color.WHITE,
		0.5
	)
	score.label.add_theme_color_override(
		"default_color",
		Color.WHITE if Globals.night else COLOR_BG
	)

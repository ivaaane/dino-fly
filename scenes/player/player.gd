# 'Player' refers to the flying dinosaur btw

extends Area2D

@export var SPEED: int
@onready var sprite = $AnimatedSprite2D
@onready var sfx = $AudioStreamPlayer2Ds

func _ready() -> void:
	sprite.animation = 'start'
	reset_position()

func _process(dt: float) -> void:
	if Globals.paused:
		return
	player_input(dt)
	wrap_borders()

func player_input(dt: float) -> void:
	if Input.is_action_pressed('up'):
		position.y -= SPEED * dt
		sprite.animation = 'fly'
	elif Input.is_action_pressed('down'):
		position.y += SPEED * dt
		sprite.animation = 'idle'
	else:
		position.y += (SPEED / 3) * dt
		sprite.animation = 'idle'
	if Input.is_action_just_pressed('up'):
		sfx.play()

func wrap_borders() -> void:
	if position.y > Globals.viewport.y:
		position.y = -(Globals.viewport.y) + 1 
	if position.y < -(Globals.viewport.y):
		position.y = Globals.viewport.y

func _on_game_restart() -> void:
	visible = true
	reset_position()

func reset_position() -> void:
	position = Vector2(-(Globals.viewport.x) + 100, 0)

func _on_body_entered(_body: Node2D) -> void:
	sprite.animation = 'die'

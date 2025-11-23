# This refers to background decorative clouds, NOT the enemy ones!

extends CharacterBody2D

@export var SPEED: int

func _ready() -> void:
	position = Vector2(
		Globals.viewport.x + 30,
		(randi() % int(Globals.viewport.x)) - (Globals.viewport.x / 2)
	)

func _process(dt: float) -> void:
	if Globals.paused:
		return
	position.x -= (SPEED + Globals.added_difficulty) * dt
	if -(Globals.viewport.x + 30) > position.x:
		queue_free()

func _on_restart() -> void:
	queue_free()

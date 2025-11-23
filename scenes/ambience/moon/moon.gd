# The background decorative moon

extends CharacterBody2D

@export var SPEED: int
@onready var sprite = $Sprite2D
var region = -1

func _process(dt: float) -> void:
	visible = Globals.night
	if Globals.paused:
		return
	if -(Globals.viewport.x + 30) > position.x:
		position.x = Globals.viewport.x + 30
	position.x -= SPEED * dt
	sprite.region_rect = Rect2(
		0.0,
		float((region * 40) % (40 * 7)) + 1,
		41.0,
		40.0
	)

func _on_restart() -> void:
	position = Vector2(
		Globals.viewport.x,
		-(Globals.viewport.y) + 75
	)
	region = -1

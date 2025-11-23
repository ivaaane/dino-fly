# Background decorative night stars

extends CharacterBody2D

@export var SPEED: int
@onready var sprite = $Sprite2D

func _ready() -> void:
	position = Vector2(
		(randi() % int(Globals.viewport.x * 2)) - Globals.viewport.x,
		(randi() % int(Globals.viewport.y * 2)) - Globals.viewport.y
	)
	sprite.region_rect = Rect2(8 * (randi() % 3), 0.0, 8.0, 11.0)


func _process(dt: float) -> void:
	if Globals.paused:
		return
	if not Globals.night:
		queue_free()
	if -(Globals.viewport.x + 30) > position.x:
		position.x = Globals.viewport.x + 30
	position.x -= SPEED * dt

func _on_restart() -> void:
	queue_free()

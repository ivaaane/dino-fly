# evil ass clouds

extends CharacterBody2D

@export var BASE_SPEED: int
@export var MAX: int
@onready var sprite = $Sprite2D

var speed: int

func _ready() -> void:
	position = Vector2(
		Globals.viewport.x + 100,
		(((Globals.viewport.y * 2) / MAX) * (randi() %  MAX) - Globals.viewport.y) + 30
	)   
	# Big ass dinosaur
	if get_parent().score.value > 300 and randi() % 10 == 0:
		BASE_SPEED *= 2
		sprite.region_enabled = false
		sprite.texture = load("res://assets/sprites/enemy-big.png")
	# Normal-sized, random sprite
	else:
		var region = 14.0 * (randi() % 3) + 14
		sprite.region_enabled = true
		sprite.region_rect = Rect2(0.0, region, 44.0, 14.0)

func _process(dt: float) -> void:
	if Globals.paused:
		return
	speed = BASE_SPEED + Globals.added_difficulty
	move(dt)

func move(dt: float) -> void:
	position.x -= speed * dt
	if -(Globals.viewport.x + 100) > position.x:
		queue_free()

func _on_restart() -> void:
	queue_free()

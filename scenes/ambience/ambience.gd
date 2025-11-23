# Manager for background decorative elements, which are:
# * The clouds (random spawns)
# * The stars (three of them, always wrapping)
# * The moon (only one, always wrapping)

extends Node2D

@onready var cloud = preload('res://scenes/ambience/cloud/cloud.tscn')
@onready var moon  = preload('res://scenes/ambience/moon/moon.tscn')
@onready var star  = preload('res://scenes/ambience/stars/stars.tscn')

func _ready() -> void:
	spawn_element(moon)

func spawn_element(element):
	var instance = element.instantiate()
	get_parent().restart.connect(instance._on_restart)
	add_child(instance)

func _on_timer_timeout() -> void:
	if not randi() % 5:
		spawn_element(cloud)  	

func _on_score_night() -> void:
	if Globals.night:
		$Moon.region += 1
		for _i in range(5):
			spawn_element(star)

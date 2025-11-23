# Global variables for all scripts

extends Node2D

@onready var paused = true
@onready var is_game_started = false
@onready var viewport = (get_viewport_rect().size * 0.5) / 2
@onready var night = false
@onready var added_difficulty = 0

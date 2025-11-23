# Manager for the score (and all its events  ) and the score text

extends Node2D

signal night

@onready var label = $RichTextLabel
@onready var timer = $Timer
@onready var ani_timer = $AnimationTimer
@onready var sfx = $AudioStreamPlayer2D

var value = 0
var highscore = 0
var ani_count: int
const TEXT_FORMAT = '[color=#dbdbdb]HI {0}[/color] {1}'

func _ready() -> void:
	visible = false
	position = Vector2(
		Globals.viewport.x - 10,
		-(Globals.viewport.y) + 10
	)

func _on_timer_timeout() -> void:
	if Globals.paused:
		return
	value += 1
	if ani_timer.is_stopped():
		update_label()
	# Animation thingy
	if value % 100 == 0 and value > 1:
		sfx.play()
		ani_timer.start()
		ani_count = 6
		Globals.added_difficulty += 20  
	# Night cycle
	if value % 700 == 0 and value > 1:
		Globals.night = not Globals.night
		emit_signal('night')

func update_label() -> void:
	if highscore > 0:
		label.text = TEXT_FORMAT.format([
			add_zeros(highscore),
			add_zeros(value),
		])
	else:
		label.text = add_zeros(value)

func _on_animation_timer_timeout() -> void:   
	visible = not visible
	ani_count -= 1
	if ani_count == 0:
		visible = true
		ani_timer.stop()

func _on_game_restart() -> void:
	if value > highscore:
		highscore = value
	value = 0
	visible = true
	Globals.night = false
	timer.start()
	update_label()
	emit_signal('night')
 
func add_zeros(val: int) -> String:
	var zeros = ''
	for _i in abs(5 - len(str(val))):
		zeros += '0'
	return zeros + str(val)

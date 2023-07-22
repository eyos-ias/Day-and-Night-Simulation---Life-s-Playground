extends Node2D

@onready var Day_Night_canvas = $Day_Night_canvas
@onready var UI = $UI
@onready var hour_controller = $Control/current_hour
@onready var speed_controller = $Control/time_speed

var time
func _ready():
	Day_Night_canvas.visible = true
	Day_Night_canvas.time_tick.connect(UI.set_daytime)
	Day_Night_canvas.is_phase.connect(UI.set_phase)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_time_speed_value_changed(value):
	Day_Night_canvas.INGAME_SPEED = value

func _on_current_hour_value_changed(value):
	Day_Night_canvas.INITIAL_HOUR = value




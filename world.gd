extends Node2D

@onready var Day_Night_canvas = $Day_Night_canvas
@onready var UI = $UI
@onready var hour_controller = $Control/current_hour
@onready var speed_controller = $Control/time_speed

var time
func _ready():
	Day_Night_canvas.visible = true
	Day_Night_canvas.time_tick.connect(UI.set_daytime)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

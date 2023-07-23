extends Node2D
# Connect nodes from the scene to variables for easy access
# The following nodes are connected to their respective variables:
# - $Day_Night_canvas: The Day_Night_canvas node is connected to the Day_Night_canvas variable.
# - $UI: The UI node is connected to the UI variable.
# - $Control/current_hour: The current_hour node inside the Control node is connected to the hour_controller variable.
# - $Control/time_speed: The time_speed node inside the Control node is connected to the speed_controller variable.


@onready var Day_Night_canvas = $Day_Night_canvas
@onready var UI = $UI
@onready var hour_controller = $Control/current_hour
@onready var speed_controller = $Control/time_speed


func _ready():
	# Make the Day_Night_canvas visible
	Day_Night_canvas.visible = true
	
	# Connect the Day_Night_canvas signals to the UI functions
	# This allows the Day_Night_canvas to send time-related information to the UI for display
	Day_Night_canvas.time_tick.connect(UI.set_daytime)
	Day_Night_canvas.is_phase.connect(UI.set_phase)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Function called when the value of the time_speed slider changes
# The 'value' parameter represents the new value of the slider.
func _on_time_speed_value_changed(value):
	Day_Night_canvas.INGAME_SPEED = value

# Function called when the value of the current_hour slider changes
# The 'value' parameter represents the new value of the slider.
func _on_current_hour_value_changed(value):
	# Update the INITIAL_HOUR variable in the Day_Night_canvas script
	# This changes the starting hour of the in-game time.
	Day_Night_canvas.INITIAL_HOUR = value




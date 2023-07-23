extends CanvasLayer

# Connect nodes from the scene to variables for easy access
@onready var Clock = $Clock
@onready var Phase = $Phase

# Variables to store formatted time and day information
var hours: String
var minutes: String
var days: String

# List of phase names to display based on the phase integer received
var Phases = ["Dawn", "Morning", "Late morning", "Noon", "Afternoon", "Evening", "Dusk", "Twilight", "Night", "Late night", "Pre-dawn"]

# This function is called every frame. It is empty, as there's no specific logic in this script to run every frame.
func _process(delta):
	pass

# Function to update the displayed in-game time on the UI
# Arguments:
# - day: The current day number.
# - hour: The current in-game hour.
# - minute: The current in-game minute.
func set_daytime(day: int, hour: int, minute: int) -> void:
	# Format the hour and minute with leading zeroes if they are less than 10.
	# This ensures that the time is displayed in the format "HH:MM".
	if hour < 10:
		hours = "0" + str(hour)
	else:
		hours = str(hour)

	if minute < 10:
		minutes = "0" + str(minute)
	else:
		minutes = str(minute)

	# Update the Clock text with the formatted time (HH:MM).
	Clock.text = hours + ":" + minutes

	# The day information is not being used in this function. You could uncomment the following line if you want to display the day:
	# days = str(day)
	# However, it seems to be commented out, so it won't update the day display.

# Function to update the displayed phase of the day on the UI
# Argument:
# - phase: The integer representing the current phase of the day (0 to 10).
# The phase is used as an index to access the corresponding phase name from the Phases list.
func set_phase(phase: int):
	# Update the Phase text with the corresponding phase name based on the provided phase integer.
	Phase.text = str(Phases[phase])

extends CanvasModulate

#constants for time calculations
const MINUTES_PER_DAY = 1440
const MINUTES_PER_HOUR = 60
const INGAME_TO_REAL_MINUTE_DURATION = (2 * PI) / MINUTES_PER_DAY

#Enum that represents different phases of the day
enum Phase{
	DAWN,
	MORNING,
	LATE_MORNING,
	NOON,
	AFTERNOON,
	EVENING,
	DUSK,
	TWILIGHT,
	NIGHT,
	LATE_NIGHT,
	PRE_DAWN
}

#Signal used to communicate the current in-game time
signal time_tick(day:int, hour:int, minute:int)

#Signal used to communicate the current in-game phase
signal is_phase(phase:int)

#Exported Variables
#Gradient Texture can be set to different gradients to convey different seasons
@export var gradient_texture:GradientTexture1D

#Ingame speed and the Initial/current hour
@export var INGAME_SPEED = 20.0
@export var INITIAL_HOUR = 12:
	set(h):
		INITIAL_HOUR = h
		time = INGAME_TO_REAL_MINUTE_DURATION * MINUTES_PER_HOUR * INITIAL_HOUR

#script variables
var time:float= 0.0
var past_minute:int= -1

var ingame_hour:int

func _ready() -> void:
	# When the node is ready, set the initial time based on INITIAL_HOUR
	time = INGAME_TO_REAL_MINUTE_DURATION * MINUTES_PER_HOUR * INITIAL_HOUR

func _process(delta: float) -> void:
	# Update the time based on the elapsed delta time and speed
	time += delta * INGAME_TO_REAL_MINUTE_DURATION * INGAME_SPEED
	
	# Calculate a value (percentage) based on the current in-game time (elapsed time since game start).
	# The value will be used to determine color modulation for the CanvasModulate node.
	var value = (sin(time - PI / 2.0) + 1.0) / 2.0
	
	# Use the calculated value to sample a color from the gradient_texture GradientTexture1D.
	# This color will be applied as color modulation to the CanvasModulate node, changing its color dynamically.
	self.color = gradient_texture.gradient.sample(value)
	
	# Recalculate the time values (day, hour, minute) and emit the time_tick signal if the minute changes
	_recalculate_time()
	
	# Emit the is_phase signal for different phases of the day based on the current ingame_hour
	emit_phase(0, 3, Phase.LATE_NIGHT)
	emit_phase(3, 4, Phase.PRE_DAWN)
	emit_phase(4, 6, Phase.DAWN)
	emit_phase(6, 9, Phase.MORNING)
	emit_phase(9, 12, Phase.LATE_MORNING)
	emit_phase(12, 13, Phase.NOON)
	emit_phase(13, 18, Phase.AFTERNOON)
	emit_phase(18, 20, Phase.EVENING)
	emit_phase(20, 21, Phase.DUSK)
	emit_phase(21, 22, Phase.TWILIGHT)
	emit_phase(22, 24, Phase.NIGHT)



func _recalculate_time() -> void:
	#Calculate the total minutes elapsed in the game based on the in-game time
	var total_minutes = int(time / INGAME_TO_REAL_MINUTE_DURATION)
	
	#Calculate the current day number by dividing the total minutes by the minutes in a day
	var day = int(total_minutes / MINUTES_PER_DAY)

	## Calculate the remaining minutes after removing complete days to get the current day's minutes.
	var current_day_minutes = total_minutes % MINUTES_PER_DAY

	# Calculate the current in-game hour by dividing the current day's minutes by the minutes in an hour.
	ingame_hour = int(current_day_minutes / MINUTES_PER_HOUR)
	
	# Calculate the current in-game minute by getting the remainder after dividing by minutes in an hour.
	var minute = int(current_day_minutes % MINUTES_PER_HOUR)
	
	# Check if the minute has changed since the last update to avoid emitting the signal multiple times per minute.
	# Update the past_minute variable with the new minute for future comparisons.
	if past_minute != minute:
		past_minute = minute
		# Emit the time_tick signal with the updated time information (day, hour, minute).
		time_tick.emit(day, ingame_hour, minute)

# Emit the is_phase signal for the given phase if ingame_hour is withn the specified range
# Godot's built-in Range method can also be used
func emit_phase(starting:int, ending:int, emitted_phase:int):
	if ingame_hour >= starting && ingame_hour < ending:
		is_phase.emit(emitted_phase)
		print("is emitting "+ str(emitted_phase))

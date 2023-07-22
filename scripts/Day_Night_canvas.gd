extends CanvasModulate

const MINUTES_PER_DAY = 1440
const MINUTES_PER_HOUR = 60
const INGAME_TO_REAL_MINUTE_DURATION = (2 * PI) / MINUTES_PER_DAY

var morning_phase_emitted: bool = false

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

signal time_tick(day:int, hour:int, minute:int)

signal is_phase(phase:int)

@export var gradient_texture:GradientTexture1D
@export var INGAME_SPEED = 20.0
@export var INITIAL_HOUR = 12:
	set(h):
		INITIAL_HOUR = h
		time = INGAME_TO_REAL_MINUTE_DURATION * MINUTES_PER_HOUR * INITIAL_HOUR


var time:float= 0.0
var past_minute:int= -1

var ingame_hour:int

func _ready() -> void:
	time = INGAME_TO_REAL_MINUTE_DURATION * MINUTES_PER_HOUR * INITIAL_HOUR

func _process(delta: float) -> void:
	time += delta * INGAME_TO_REAL_MINUTE_DURATION * INGAME_SPEED
	
	var value = (sin(time - PI / 2.0) + 1.0) / 2.0
	
	self.color = gradient_texture.gradient.sample(value)
	
	_recalculate_time()
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
	var total_minutes = int(time / INGAME_TO_REAL_MINUTE_DURATION)
	
	var day = int(total_minutes / MINUTES_PER_DAY)

	var current_day_minutes = total_minutes % MINUTES_PER_DAY

	ingame_hour = int(current_day_minutes / MINUTES_PER_HOUR)
	var minute = int(current_day_minutes % MINUTES_PER_HOUR)
	
	if past_minute != minute:
		past_minute = minute
		time_tick.emit(day, ingame_hour, minute)

func emit_phase(starting:int, ending:int, emitted_phase:int):
	if ingame_hour >= starting && ingame_hour < ending:
		is_phase.emit(emitted_phase)
		print("is emitting "+ str(emitted_phase))

extends CanvasLayer
@onready var Clock = $Clock
@onready var Phase = $Phase
var hours:String
var minutes:String
var days:String



var Phases = ["Dawn", "Morning", "Late morning", "noon", "After-noon", "Evening", "Dusk", "Twilight", "Night", "Late night",
"Pre-dawn"]

func _process(delta):
	pass
	

func set_daytime(day: int, hour: int, minute: int)->void:

	if hour < 10:
		hours = "0" + str(hour)
	else: 
		hours = str(hour)
	if minute < 10:
		minutes = "0"+str(minute)
	else:
		minutes = str(minute)
	
	Clock.text = hours+ ":"+ minutes
	#$Phase.text = str(day)

func set_phase(phase:int):
	Phase.text = str(Phases[phase])

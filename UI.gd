extends Control
@onready var Clock = $Clock
var hours:String
var minutes:String
var days:String
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

extends CanvasModulate

const MINUTES_PER_DAY = 1440
const MINUTES_PER_HOUR = 60

@export var current_time_minutes: float = 0.0
@export var day_night_cycle_speed: float =1

var initial_time = 0
var current_hour = initial_time

func _ready():
	current_time_minutes = initial_time

func _process(delta: float) -> void:
	#update the time based ont he game's time scale and day-night spee
	current_time_minutes += delta * day_night_cycle_speed
	
	#wrap the time to ensure it stays within a 24-hour cycle
	current_time_minutes = fmod(current_time_minutes, MINUTES_PER_DAY)
	
	
	current_hour =  int(current_time_minutes/MINUTES_PER_HOUR)%24
	
	#call functions or update visuals based on the day-night cycle
	if is_dawn():
		print("is dawn")
	elif is_morning(): 
		print("its morning")
	elif is_late_morning():
		print("its morning")
	elif is_noon():
		print("its noon")
	else:
		print("its evening")


func is_dawn() -> bool:
	var hour = int(current_time_minutes/MINUTES_PER_HOUR) % 24
	return hour >= 0 && hour < 2

func is_morning()-> bool:
	var hour = int(current_time_minutes/MINUTES_PER_HOUR) % 24
	return hour >= 2 && hour < 6

func is_late_morning()->bool:
	var hour = int(current_time_minutes/MINUTES_PER_HOUR)%24
	return hour >=6 && hour < 10

func is_noon()-> bool:
	var hour = int(current_time_minutes/MINUTES_PER_HOUR)%24
	return hour >=10 && hour < 12

#night time stats
func is_evening()-> bool:
	var hour = int(current_time_minutes/MINUTES_PER_HOUR)%24
	return hour >=12 && hour < 15

func is_sunset()-> bool:
	var hour = int(current_time_minutes/MINUTES_PER_HOUR)%24
	return hour >=6 && hour < 18

func is_twilight()-> bool:
	var hour = int(current_time_minutes/MINUTES_PER_HOUR)%24
	return hour >=18 && hour < 19

func is_night()-> bool:
	var hour = int(current_time_minutes/MINUTES_PER_HOUR)%24
	return hour >=19 && hour < 22
	
func is_late_night()-> bool:
	var hour = int(current_time_minutes/MINUTES_PER_HOUR)%24
	return hour >=6 && hour < 10

func is_predawn()-> bool:
	var hour = int(current_time_minutes/MINUTES_PER_HOUR)%24
	return hour >=23 && hour < 24

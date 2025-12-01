extends Control

@onready var timerLabel: Label = $Time/TimerLabel
var active:bool = false

func _process(_delta: float) -> void:
	if not active: return
	var timeleft = Networking.hostEvents.hideTimer.time_left
	
	var minutes : float = timeleft / 60
	var seconds : float = int(timeleft) % 60
	var milli : float = int((timeleft - int(timeleft)) * 100)
	timerLabel.text = "%02d:%02d.%02d" % [minutes,seconds,milli]
